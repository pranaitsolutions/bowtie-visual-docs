# Support — Bowtie Risk Visual for Power BI

## Start here
The [User Help](user-guide) covers setup, the data model, every interaction and the formatting
pane. Most questions are answered in §2 (setup) and §9 (troubleshooting).

## Quick answers

**Barriers are missing** → you're binding from separate tables. Use the included Power Query
script to build one flat `BowtieCombined` table. See Help §2.1.

**Action counts show nothing** → `ActionID` must sit on the same row as its barrier. If your table
is fully denormalised, bind *Action: Linked To*. Help §4.3.

**"Resize to view bowtie"** → make the visual larger than 300×200 px.

**Score badge is the wrong colour** → bind a hex colour column to *Risk: Score Colour*. Help §5.

**How do I drill from a barrier to a detail page?** → Help §7.

**Can I link nodes to my risk platform?** → yes; put a URL column in the Details well. Help §3.4.

## Report a problem
Email **support@pranaits.com** with:
- Power BI Desktop version
- Visual version (Format pane → About)
- What you expected, what happened, and a screenshot
- A sanitised sample of the rows involved if possible

## Feature requests
Same address, "Feature request" in the subject.

## Open-source components
The visual is built with open-source libraries including React, React Flow, dagre and d3.
Copyright and licence texts: [Third-party notices](third-party-notices).
