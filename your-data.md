---
title: Your data
nav_order: 4
description: How the visual reads your table — several risks, barrier links, actions, overdue, health and risk-score colours.
---

# Your data
{: .no_toc }

How the visual reads `BowtieCombined`, and how to make it show what you expect.
{: .fs-6 .fw-300 }

<details open markdown="block">
  <summary>On this page</summary>
  {: .text-delta }
1. TOC
{:toc}
</details>

---

## Several risks in one table

A bowtie shows one risk at a time. If the visual's data holds several risks, the Risk Bowtie draws
the first, and a small note in the bottom-right corner says **"1 of N risks shown · select a risk or
use a slicer to change"**. Hover it for the full explanation.

To choose the risk:

- select a risk in a table or other visual on the same page;
- add a slicer or a page filter on `RiskID`;
- or drill through to the page with `RiskID` as the drill-through field.

Barrier View doesn't need this: it deliberately reads across all risks.

## Which risk a barrier belongs to

The visual reads `RiskID` from the same row as the barrier. If a barrier appears on rows with
different `RiskID`s, Barrier View shows it protecting all of them. That's how shared barriers
work: one `BarrierID`, one row per risk and linked cause or consequence.

## Prevention or mitigation

If a barrier's `LinkedTo` matches a `CauseID`, it's a prevention barrier (left side). If it
matches a `ConsequenceID`, it's a mitigation barrier (right side). There's nothing to configure.

## How actions attach to barriers

The visual tries three ways, in order:

1. **Explicit** — if you bound *Action: Linked To* and its value matches a `BarrierID` (or a
   `RiskID`), that wins.
2. **Same row** — an action on the same row as a barrier belongs to it. The Power Query script
   produces exactly this, so most people never need step 1.
3. **Risk fallback** — with a single risk in the data, any action still unmatched becomes a
   risk-level action.

You only need the explicit well if your table is fully denormalised — every row carries a
`BarrierID`, even for risk-level actions — so the same-row rule would attach them wrongly.

## Overdue actions

An action is overdue when:

- its status contains "overdue", **or**
- its due date is in the past **and** its status isn't closed, complete or done.

The visual reads the status from a Details column named `Status` or `ActionStatus`, and the due
date from `DueDate`, `ActionDueDate` or `Due Date`. The overdue count appears under the action pill.

## Barrier health colour

From the first of these barrier Details columns that's present — `Health`, `BarrierHealth`,
`Status` — ignoring case:

| Value contains | Colour |
|:---------------|:-------|
| "fail" | Red |
| "degrad" | Amber |
| anything else, or no health column | Green |

## Risk score colours

The visual never interprets score values — `A1`, `3x4`, `12` and `L2-I3` all work. Instead, give it
a colour:

1. If you have a risk matrix (score → colour), join it into `BowtieCombined` on the score, so each
   row carries its hex colour, such as `#D32F2F`. The [sample risk register](sampledata/BowtieVisual_SampleData_MultiRisk.xlsx)
   has a `RiskMatrix` sheet showing this.
2. Drag that column into **Risk: Score Colour**.

The score badge takes that colour, and its text switches between white and dark to stay readable.
Without a colour column, the badge uses **Format** → **Colours** → **Risk score default colour**.
