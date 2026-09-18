# Bowtie Risk Visual for Power BI — Help

**Version 1.3.0 · Prana IT Solutions Ltd · support@pranaits.com**

---

## 1. What it does

The Bowtie Risk Visual renders bow-tie risk diagrams inside Power BI. It reads your existing
risk register — risks, causes, consequences, barriers and actions — and draws the full picture:
causes on the left flowing through prevention barriers to a central top event, then through
mitigation barriers to consequences on the right.

Two perspectives, one dataset:

| Perspective | Who it's for | What's in the centre |
|---|---|---|
| **Risk Bowtie** | Risk owners | One risk, with everything that leads to it and everything it leads to |
| **Barrier View** (premium) | Barrier owners | One barrier, with every risk / cause / consequence it protects — across the whole portfolio |

Both perspectives read the **same table**. You don't need to build anything twice.

---

## 2. Five-minute setup

### 2.1 Your data

You need one flat table where each row is a barrier (repeated once per action if it has
several). The visual calls this **BowtieCombined**. You have two ways to get there:

**Path A — you already have one flat table.**
Skip to §2.2.

**Path B — you have five normalised tables (Risk, Cause, Consequence, Barrier, Action).**
This is the common case. Use the included `BowtieVisual_CombineQuery.pq`:

1. Power BI Desktop → **Home → Transform data**
2. **Home → New Source → Blank Query**
3. Right-click the query → **Advanced Editor** → delete the contents → paste the `.pq` file
4. Edit the **CUSTOMISE** block at the top to match your table and column names (nothing else needs touching)
5. **Done** → rename the query `BowtieCombined` → **Close & Apply**

What you'll have to change in the CUSTOMISE block, and only there:

| Setting | Meaning | Default |
|---|---|---|
| `T_Risk … T_Action` | The names of your five queries | Risk, Causes, Consequences, Barriers, Actions |
| `K_RiskID` | The risk key column (must exist in Risk, Barrier, Cause, Consequence) | `RiskID` |
| `K_CauseID`, `K_ConsequenceID`, `K_BarrierID`, `K_ActionID` | Primary keys | as named |
| `K_BarrierLinkedTo` | Column on Barrier holding the CauseID or ConsequenceID it protects | `LinkedTo` |
| `K_ActionLinkedTo` | Column on Action holding the BarrierID (or RiskID for risk-level actions) | `LinkedTo` |

The query LEFT-joins everything onto the Barrier table so nothing is dropped: barriers with no
actions still appear, causes with no barriers still appear, and actions linked directly to a risk
get their own rows.

> **Why one flat table?** If you drag columns from five separate tables into the visual, Power BI
> silently inner-joins them and any barrier without an action disappears. The flat table avoids that.

### 2.2 Add the visual

1. Visualizations pane → **…** → **Import a visual from a file** → select the `.pbiviz`
2. Drag the bowtie icon onto the canvas
3. Resize to at least 900×500 px — it will say "Resize to view bowtie" until it has room

### 2.3 Bind the field wells

Drag columns from `BowtieCombined` into these wells. Names below assume the default CUSTOMISE values.

| Field well | Column | Required |
|---|---|---|
| Risk: ID | `RiskID` | ✓ |
| Risk: Name | `RiskName` | ✓ |
| Risk: Details | `RiskScore`, `RiskOwner`, … | any Risk column you want on the card |
| Risk: Score Colour | `RiskScoreColour` | optional — see §5 |
| Cause: ID | `CauseID` | ✓ |
| Cause: Name | `CauseName` | ✓ |
| Cause: Details | `CauseLikelihood`, … | optional |
| Consequence: ID | `ConsequenceID` | ✓ |
| Consequence: Name | `ConsequenceName` | ✓ |
| Consequence: Details | `ConsequenceSeverity`, … | optional |
| Barrier: ID | `BarrierID` | ✓ |
| Barrier: Name | `BarrierName` | ✓ |
| Barrier: Linked To | `LinkedTo` | ✓ |
| Barrier: Details | `Health`, `Effectiveness`, `Owner`, … | `Health` drives the colour strip |
| Action: ID | `ActionID` | optional |
| Action: Name | `ActionName` | optional |
| Action: Linked To (optional) | `ActionLinkedTo` | optional — see §4.3 |
| Action: Details | `ActionStatus`, `ActionDueDate`, `ActionAssignee`, … | `Status`/`DueDate` drive overdue counts |

The bowtie renders as soon as the required wells are bound.

---

## 3. Using the visual

### 3.1 Reading the diagram

- **Blue cards (left)** — causes. Subtitle shows likelihood if bound.
- **White cards next to them** — prevention barrier groups. Collapsed by default (see *Start expanded*): "N barriers", a row of health dots (green / amber / red), an action pill, and ⊞.
- **Orange-bordered card (centre)** — the top event. Shows the risk score badge and a pill with total risk-level actions.
- **Grey cards (right)** — mitigation barrier groups.
- **Yellow cards (far right)** — consequences. Subtitle shows severity if bound.
- **Connectors** fan from the risk to each side. In the premium view they turn red or amber when the barrier they pass is failed or degraded.

### 3.2 Expand / collapse

| Action | Result |
|---|---|
| Click ⊞ on a barrier group card | Expands that cause's / consequence's barriers into individual cards |
| Click ⊟ on the cause / consequence card | Collapses them back (⊟ only appears while expanded) |
| **Expand All** / **Collapse All** toolbar | All groups at once (Auto layout; hide it with *Show expand/collapse toolbar*) |

Turn on **Start expanded** in *Format → Layout* to open every group expanded instead of collapsed.

### 3.3 Detail panel

Click any barrier, risk, cause or consequence. A panel opens on the right showing every field
you bound to that entity's Details well, plus:

- For barriers: which risk it belongs to, and each linked action with status, due date, assignee
- For the risk: its risk-level actions

Click the same node again, click empty canvas, or press × to close.

### 3.4 Hyperlinks to your source system

If any column in an entity's Details well contains a value starting with `https://`, the title
in the detail panel becomes a link. Clicking it opens that URL in the browser. Use this to jump
from a barrier straight to its record in your risk management platform. The URL column itself is
hidden from the panel.

### 3.5 Hover

Hovering any node shows a tooltip with name, health, action count, overdue count, effectiveness
and owner as available.

### 3.6 Cross-filtering (premium)

Clicking a node selects it in Power BI's sense — any other visual on the page filters to the
rows behind that node. Put a table of actions next to the bowtie; click a barrier; the table
shows just that barrier's actions.

### 3.7 Zoom and pan (premium)

Scroll to zoom, drag empty canvas to pan, use the + / – / ⤢ controls at bottom-left. Clicking
a node zooms to it and highlights its path; clicking empty canvas fits everything back.

### 3.8 Barrier View: picking a barrier (premium)

Set *Visual perspective = Barrier View*. With no barrier chosen you get a summary: every unique
barrier, each showing how many risks it spans.

| Action | Result |
|---|---|
| Click a barrier in the summary | That barrier moves to the centre, with the causes / consequences it sits on and the risks it protects |
| **← All Barriers** button | Back to the summary |
| Filter to one barrier (slicer or drill-through) | That barrier is centred straight away |

Cause and consequence cards here are labelled **Risk: <name>**, so a barrier shared by several
risks shows which risk each side item comes from. The Barrier View always reads across every risk
in the data, even when the Risk Bowtie is showing just one.

---

## 4. The data model, explained

### 4.0 Several risks in one dataset

If your `BowtieCombined` holds more than one risk, the Risk Bowtie shows the first and a small
badge says "Showing 1 of N risks". To switch, add a slicer or table on `RiskID` and select a row —
Power BI filters the visual's data and the bowtie re-renders for that risk. This is the normal way
to browse a multi-risk register.

The Barrier View is unaffected: it deliberately reads across all risks.

### 4.1 Which risk does a barrier belong to?

The visual reads `RiskID` from the same row as the barrier. If a barrier appears on rows with
different `RiskID`s, the Barrier View shows it protecting all of them. This is how shared
barriers work — one `BarrierID`, one row per (risk, linked cause/consequence).

### 4.2 Prevention or mitigation?

If `LinkedTo` matches a `CauseID`, the barrier is prevention (left side). If it matches a
`ConsequenceID`, it's mitigation (right side). Nothing to configure.

### 4.3 How actions attach to barriers

Three passes, in order:

1. **Explicit** — if you bound *Action: Linked To* and its value matches a `BarrierID` (or `RiskID`), that wins.
2. **Row co-occurrence** — if an action sits on the same row as a barrier, they're linked. This is what the combine query produces, so most customers never need pass 1.
3. **Risk fallback** — any action still unmatched whose `LinkedTo` names a risk attaches to that risk.

When do you need the explicit well? Only if your table is fully denormalised — every row carries
a `BarrierID` even for risk-level actions — so co-occurrence would mis-attach them.

### 4.4 Overdue

An action counts as overdue when its `Status` contains "overdue", **or** its `DueDate` is in the
past and its `Status` isn't closed / complete / done. The count appears under the action pill.

### 4.5 Health colour

`Health` values containing "fail" → red, "degrad" → amber, anything else → green. Case-insensitive.

---

## 5. Risk score colours

The visual never interprets score values. `A1`, `3x4`, `12`, `L2-I3` — it doesn't matter.
Instead, bind a colour column:

1. If you have a risk-matrix table (Score → Colour), join it into `BowtieCombined` on `RiskScore` so each row carries the matching hex, e.g. `#D32F2F`. Both sample workbooks include a `RiskMatrix` sheet showing this.
2. Drag that column into **Risk: Score Colour**.

The score badge takes that background, and the label auto-contrasts to white or dark. If you
don't bind the well, the badge uses **Format → Colours → Risk score default colour**.

---

## 6. Formatting pane

**Layout**
- *Visual perspective* — Risk Bowtie / Barrier View
- *Barrier layout* — Grouped (two-column) · Vertical (stacked, premium) · Auto layout (premium: barriers connected in sequence along each path) · Auto layout, grouped barriers (premium: expanded barriers boxed in two columns — more compact with many barriers)
- *Start expanded* — open barrier groups expanded instead of collapsed
- *Show zoom controls*, *Animate degraded edges*
- *Show expand/collapse toolbar* — then *Toolbar position* + button background / text / border colours

**Colours** — risk, cause, consequence, barrier fill and border, connectors, info panel
background / text / border, risk score default. Text on every card auto-contrasts against whatever
you pick.

**Risk / Cause / Consequence / Barrier Text** — font size and family per node type.

Background and border for the visual as a whole come from Power BI's own **General** section, so
the bowtie follows your report theme.

---

## 7. Drill-through: bowtie → detail pages

Right-click any node to get Power BI's drill-through menu. To make it useful:

**Barrier detail page**
1. Add a new report page. In its Format pane → **Page information → Drill through**, add `BarrierID` as the drill-through field.
2. On that page, add a second Bowtie visual with *Visual perspective = Barrier View*, bound to the same wells.
3. Add whatever else helps a barrier owner — an actions table, KPI cards.
4. Back on the main page, right-click a barrier → **Drill through → Barrier detail**. The target page opens filtered to that barrier, and the Barrier View centres it. You can also reach any barrier by clicking it in the Barrier View summary (§3.8).

**Risk detail page** — same pattern with `RiskID` as the drill-through field.

Note: Power BI offers drill-through based on every column in the selected rows, so right-clicking
a risk will also list the barrier page. Name your pages clearly and users will pick the right one.

---

## 8. Free vs premium

| | Free | Premium |
|---|---|---|
| Risk Bowtie — Grouped layout | ✓ | ✓ |
| Expand / collapse, health dots, action & overdue pills | ✓ | ✓ |
| Hover tooltips | ✓ | ✓ |
| Vertical layout | | ✓ |
| Auto layout — connected or grouped barriers (engine-positioned, pan & zoom) | | ✓ |
| Detail panel with actions and hyperlinks | | ✓ |
| Cross-filtering and drill-through | | ✓ |
| Barrier View (summary, click-through to any barrier) | | ✓ |
| Path highlighting, edge animation | | ✓ |
| Colour, font and toolbar customisation | | ✓ |
| Watermark & upgrade banner | shown | removed |

Licensing is handled by Microsoft AppSource. A free trial of premium is available.

---

## 9. Troubleshooting

**"Resize to view bowtie"** — the visual is under 300×200 px. Make it bigger.

**Selecting a risk in a table/slicer doesn't change the bowtie** — make sure the table and the
bowtie are on the same page and both read from `BowtieCombined`. Cross-visual filtering only
works between visuals sharing a data source.

**Barriers are missing** — you're probably binding columns from separate tables. Use the
combine query (§2.1) so every barrier has a row regardless of actions.

**Action pills show nothing** — check `ActionID` is populated on the same rows as its barrier. If
your table is fully denormalised, bind *Action: Linked To*.

**Overdue counts are wrong** — confirm `ActionStatus` / `ActionDueDate` are in *Action: Details*
and dates are real date values, not text.

**Score badge is orange** — no colour bound. Either bind *Risk: Score Colour* or change the
default in Format → Colours.

**Detail panel shows fields I don't want** — only what's in the Details wells is shown. Remove
columns from the well to hide them.

**The visual won't delete with the Delete key** — click outside it first, then click its border,
then Delete. Or right-click → Remove. This is standard Power BI behaviour for custom visuals.

---

## 10. Support

support@pranaits.com · https://pranaits.github.io/bowtie-visual-docs/
