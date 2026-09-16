# Support — Bowtie Risk Visual for Power BI

## Getting Started

New to the Bowtie Risk Visual? Start here:

1. **Data Setup** — Prepare a single combined table with Risk, Cause,
   Consequence, Barrier, and Action columns. See the Field Mapping Guide
   included with the visual download.

2. **Import the Visual** — In Power BI Desktop, go to the Visualizations
   pane → ... → Import from file → select the .pbiviz file.

3. **Bind Your Data** — Drag columns from your table into the five field
   well groups: Risk, Cause, Consequence, Barrier, and Action.

4. **Explore** — Click nodes to see details, use the expand/collapse
   chevrons to manage barrier groups, and right-click for drill-through.

## Frequently Asked Questions

### My barriers are missing
Your data source may be using separate tables that Power BI inner-joins,
dropping barriers without actions. Use a single combined table or the
included Power Query M script to left-join your tables.

### Action counts show zero
Ensure your ActionID column is populated and that each action appears on
the same row as its barrier in your combined table. The visual detects
action-to-barrier linkage by row co-occurrence.

### The visual shows "Resize to view bowtie"
The visual needs at least 300×200 pixels. Drag the resize handles to make
it larger.

### How do I set up drill-through?
Create a new report page, set it as a drill-through page with BarrierID
(or RiskID) as the drill-through filter. Right-click a node in the bowtie
to see the drill-through option.

### How do I link to my external risk register?
Add a URL column to your data (e.g., BarrierURL) and drag it into the
Barrier: Details field well. When a URL is detected, the barrier name in
the detail panel becomes a clickable hyperlink.

### Can I use separate tables instead of a combined table?
Yes, but be aware that Power BI may inner-join them, which drops entities
without matching rows in all tables. The combined table approach is
recommended for completeness.

## Report a Bug

If you encounter a bug or unexpected behaviour:

1. Note the steps to reproduce the issue
2. Take a screenshot if possible
3. Email us at support@pranaits.com with:
   - Power BI Desktop version
   - Visual version (shown in the visual's About section)
   - Description of the issue
   - Screenshots or sample data (if possible)

## Feature Requests

We welcome feature suggestions. Email support@pranaits.com with
"Feature Request" in the subject line.

## Contact

**Prana IT Solutions Ltd**
Email: support@pranaits.com
Web: https://pranaits.com
