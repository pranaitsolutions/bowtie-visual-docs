// ═══════════════════════════════════════════════════════════════════════════
//  BOWTIE RISK VISUAL — BowtieCombined query
//  Builds ONE flat table from your five source tables. This one table drives
//  BOTH the Risk Bowtie view and the Barrier View — no second table needed.
// ═══════════════════════════════════════════════════════════════════════════
//
//  HOW TO USE
//    1. Power BI Desktop → Home → Transform data
//    2. Home → New Source → Blank Query
//    3. Right-click the query → Advanced Editor → delete everything → paste this
//    4. Edit ONLY the "CUSTOMISE" block below to match your table/column names
//    5. Done → rename the query "BowtieCombined" → Close & Apply
//
//  WHAT YOU EDIT — the CUSTOMISE block only. Everything else is generic.
//
//  WHAT THIS DOES
//    Starts from your Barrier table and LEFT-joins Actions, Causes, Consequences
//    and Risks onto it, so every barrier appears even with no actions, and
//    every cause/consequence appears even with no barriers. Risk-level actions
//    (linked to a RiskID rather than a BarrierID) are appended as their own rows.
//
//  MULTI-RISK BARRIERS
//    If the same BarrierID protects several risks, your Barrier table should have
//    one row per (BarrierID, RiskID, LinkedTo). The visual handles the rest.
//
// ═══════════════════════════════════════════════════════════════════════════

let
    // ───────────────────────────── CUSTOMISE ─────────────────────────────
    // Your source table names (as they appear in the Queries pane)
    T_Risk        = Risk,
    T_Cause       = Causes,
    T_Consequence = Consequences,
    T_Barrier     = Barriers,
    T_Action      = Actions,

    // Key column names in YOUR tables
    K_RiskID           = "RiskID",          // in Risk, Barrier, Cause, Consequence
    K_CauseID          = "CauseID",         // in Cause
    K_ConsequenceID    = "ConsequenceID",   // in Consequence
    K_BarrierID        = "BarrierID",       // in Barrier
    K_BarrierLinkedTo  = "LinkedTo",        // in Barrier: holds a CauseID or ConsequenceID
    K_ActionID         = "ActionID",        // in Action
    K_ActionLinkedTo   = "LinkedTo",        // in Action: holds a BarrierID or RiskID
    // ─────────────────────────── END CUSTOMISE ───────────────────────────

    // Prefix helper so columns from different tables never collide
    Prefix = (t as table, pfx as text, keep as list) as table =>
        let cols = List.Select(Table.ColumnNames(t), each not List.Contains(keep, _))
        in Table.RenameColumns(t, List.Transform(cols, each {_, pfx & _})),

    // 1. Barriers are the spine
    B0 = Table.Buffer(T_Barrier),

    // 2. LEFT-join Actions on Action.LinkedTo = Barrier.BarrierID
    A_pref = Prefix(T_Action, "Action", {K_ActionID, K_ActionLinkedTo}),
    B1 = Table.NestedJoin(B0, {K_BarrierID}, A_pref, {K_ActionLinkedTo}, "_a", JoinKind.LeftOuter),
    B2 = Table.ExpandTableColumn(B1, "_a", Table.ColumnNames(A_pref)),
    B3 = Table.RenameColumns(B2, {{K_ActionLinkedTo, "ActionLinkedTo"}}, MissingField.Ignore),

    // 3. LEFT-join Causes on Barrier.LinkedTo = Cause.CauseID
    C_pref = Prefix(T_Cause, "Cause", {K_CauseID, K_RiskID}),
    B4 = Table.NestedJoin(B3, {K_BarrierLinkedTo}, C_pref, {K_CauseID}, "_c", JoinKind.LeftOuter),
    B5 = Table.ExpandTableColumn(B4, "_c", List.RemoveItems(Table.ColumnNames(C_pref), {K_RiskID})),

    // 4. LEFT-join Consequences on Barrier.LinkedTo = Consequence.ConsequenceID
    Q_pref = Prefix(T_Consequence, "Consequence", {K_ConsequenceID, K_RiskID}),
    B6 = Table.NestedJoin(B5, {K_BarrierLinkedTo}, Q_pref, {K_ConsequenceID}, "_q", JoinKind.LeftOuter),
    B7 = Table.ExpandTableColumn(B6, "_q", List.RemoveItems(Table.ColumnNames(Q_pref), {K_RiskID})),

    // 5. LEFT-join Risk on RiskID
    R_pref = Prefix(T_Risk, "Risk", {K_RiskID}),
    B8 = Table.NestedJoin(B7, {K_RiskID}, R_pref, {K_RiskID}, "_r", JoinKind.LeftOuter),
    B9 = Table.ExpandTableColumn(B8, "_r", List.RemoveItems(Table.ColumnNames(R_pref), {K_RiskID})),

    // 6. Risk-level actions (Action.LinkedTo matches a RiskID) → their own rows
    RiskIDs = List.Distinct(Table.Column(T_Risk, K_RiskID)),
    RA0 = Table.SelectRows(T_Action, each List.Contains(RiskIDs, Record.Field(_, K_ActionLinkedTo))),
    RA1 = Prefix(RA0, "Action", {K_ActionID, K_ActionLinkedTo}),
    RA2 = Table.RenameColumns(RA1, {{K_ActionLinkedTo, "ActionLinkedTo"}}),
    RA3 = Table.AddColumn(RA2, K_RiskID, each [ActionLinkedTo]),
    RA4 = Table.NestedJoin(RA3, {K_RiskID}, R_pref, {K_RiskID}, "_r", JoinKind.LeftOuter),
    RA5 = Table.ExpandTableColumn(RA4, "_r", List.RemoveItems(Table.ColumnNames(R_pref), {K_RiskID})),

    // 7. Union barrier rows + risk-action rows (columns aligned by name)
    Result = Table.Combine({B9, RA5})
in
    Result
