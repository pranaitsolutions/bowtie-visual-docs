# Bowtie Risk Visual — User Guide

## Overview
The Bowtie Risk Visual displays bow-tie risk diagrams in Power BI. It shows how
causes lead through prevention barriers to a top event (risk), and how mitigation
barriers protect against consequences.

## Quick Start

### 1. Prepare Your Data
Create a single table (or use the included Power Query) with these columns:

| Column | Example | Description |
|--------|---------|-------------|
| RiskID | TE-001 | Unique risk identifier |
| RiskName | Loss of Containment | Risk / top event name |
| CauseID | C-001 | Unique cause identifier |
| CauseName | Internal Corrosion | Cause name |
| ConsequenceID | CO-001 | Unique consequence identifier |
| ConsequenceName | Environmental Release | Consequence name |
| BarrierID | B-001 | Unique barrier identifier |
| BarrierName | Corrosion Inspection | Barrier name |
| LinkedTo | C-001 | Which cause or consequence the barrier protects |
| Health | Healthy | Barrier health: Healthy, Degraded, or Failed |
| ActionID | A-001 | Unique action identifier (optional) |
| ActionName | Recalibrate gauges | Action name (optional) |

Each row represents one barrier (duplicated per action if it has multiple actions).
Barriers without actions still need a row (with empty ActionID/ActionName).

### 2. Add the Visual
1. Import the .pbiviz file (Visualizations pane → ... → Import from file)
2. Drag the bowtie icon onto your report canvas
3. Resize to at least 800×500px for best results

### 3. Bind Field Wells
Drag columns from your table into these field wells:

- **Risk: ID** → RiskID
- **Risk: Name** → RiskName
- **Risk: Details** → RiskScore, RiskOwner (any extra columns)
- **Cause: ID** → CauseID
- **Cause: Name** → CauseName
- **Cause: Details** → Likelihood, Description
- **Consequence: ID** → ConsequenceID
- **Consequence: Name** → ConsequenceName
- **Consequence: Details** → Severity, Category
- **Barrier: ID** → BarrierID
- **Barrier: Name** → BarrierName
- **Barrier: Linked To** → LinkedTo
- **Barrier: Details** → Health, Effectiveness, Owner
- **Action: ID** → ActionID (optional)
- **Action: Name** → ActionName (optional)
- **Action: Linked To** → (optional — leave empty, the visual detects linkage automatically)
- **Action: Details** → Status, DueDate, Assignee (optional)

## Interacting with the Bowtie

### Click Nodes
- **Click a barrier** → Opens the detail panel showing health, effectiveness, owner, and linked actions
- **Click the risk (top event)** → Shows risk details and risk-level actions
- **Click a cause** → Shows cause details (and opens the detail panel)
- **Click a consequence** → Shows consequence details

### Expand / Collapse Barriers
- **Click the ▸ chevron** on a cause or consequence → Expands or collapses its barrier group
- **Expand All / Collapse All** buttons in the toolbar toggle all groups

### Cross-Filtering
Clicking any node filters other visuals on the same report page. Add a table showing
Actions alongside the bowtie — clicking a barrier filters the table to its actions.

### Drill-Through
Right-click any node → Power BI shows drill-through options to navigate to detail pages.
Set up drill-through pages with BarrierID, RiskID, or CauseID filters.

### Hyperlinks
If any field in an entity's Details well contains a URL (starting with https://),
the title in the detail panel becomes a clickable link. Add a URL column to your
data to link back to your risk register or external system.

## Formatting Options

### Layout
- **Visual perspective:** Risk Bowtie (default) or Barrier View (premium)
- **Barrier layout:** Grouped, Vertical, Auto (dagre), or Compact
- **Show zoom controls:** Toggle the +/−/fit buttons
- **Animate degraded edges:** Animates edges on degraded/failed paths
- **Toolbar position:** Top left, Top right, Bottom left, Bottom right
- **Toolbar colours:** Background, text, and border colours

### Colours
- Risk, Cause, Consequence, Barrier, Barrier border, Connector colours
- Info panel background, text, and border colours

### Text (per node type)
- Risk Text: Font size, Font family
- Cause Text: Font size, Font family
- Consequence Text: Font size, Font family
- Barrier Text: Font size, Font family

## Barrier View (Premium)
Switch to Barrier View perspective to see barriers at the centre of the diagram.
Use a slicer on BarrierID to focus on a specific barrier and see all the risks,
causes, and consequences it protects across your portfolio.

## Troubleshooting

**Visual shows "Resize to view bowtie"**
→ The visual is too small. Drag the handles to at least 300×200px.

**Barriers are missing**
→ Ensure your data uses a single combined table (not separate tables with relationships).
Power BI inner-joins separate tables, dropping barriers without actions. Use the included
Power Query to auto-combine your tables.

**Action counts show 0**
→ Ensure ActionID is populated and on the same row as its barrier in your combined table.
The visual detects action-to-barrier linkage by row co-occurrence.

**Drill-through not available**
→ Set up a drill-through page with the relevant ID field (e.g., BarrierID) as the
drill-through filter. Click a node first, then right-click for drill-through options.

## Support
Visit https://pranaits.github.io/bowtie-visual-docs/support for help.
