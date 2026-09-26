---
title: Support
nav_order: 7
description: Fixes for common problems, and how to contact Prana IT Solutions.
---

# Support
{: .no_toc }

Most questions are answered below. If yours isn't, email **support@pranaits.com**.
{: .fs-6 .fw-300 }

<details open markdown="block">
  <summary>On this page</summary>
  {: .text-delta }
1. TOC
{:toc}
</details>

---

## The visual shows "Resize to view bowtie"

The visual is smaller than 300 × 200 px. Make it bigger; 900 × 500 px or more works best.

## Barriers are missing

You're probably binding columns from separate tables, and Power BI drops barriers that have no
actions. Build one flat table with the
[Power Query script](sampledata/BowtieVisual_CombineQuery.pq) — see [Get started](get-started#2-build-one-flat-table).

## A cause or consequence is missing

With the Power Query script, causes and consequences come in through their barriers, so one with
no barrier linked to it yet doesn't appear. Link a barrier to it.

## I have a licence but still see the Grouped layout

A newly assigned licence can take up to an hour to be recognised. Then press **F5** in the Power BI
Service, or close and reopen Power BI Desktop. In Desktop, sign in with the account the licence is
assigned to — signed out or offline, Desktop can't check the licence and shows the free view.
See [Free and Premium](free-and-premium).

## It shows the wrong risk, or "1 of N risks shown"

A bowtie shows one risk at a time. Select a risk in another visual, or add a slicer or filter on
`RiskID`. See [several risks in one table](your-data#several-risks-in-one-table).

## Selecting a risk in a table or slicer doesn't change the bowtie

The table or slicer and the bowtie must be on the same page and read from the same
`BowtieCombined` table.

## Action counts show nothing

`ActionID` must be on the same row as its barrier. If your table is fully denormalised, bind
*Action: Linked To*. See [how actions attach](your-data#how-actions-attach-to-barriers).

## Overdue counts look wrong

Put the status and due-date columns in *Action: Details*, and make sure the due date is a date
column, not text. See [overdue actions](your-data#overdue-actions).

## The score badge is orange

No colour is bound. Bind *Risk: Score Colour*, or change **Format** → **Colours** → **Risk score
default colour**. See [risk score colours](your-data#risk-score-colours).

## Text looks small in the Grouped or Vertical layout

When the bowtie is larger than the visual, it's scaled down so all of it stays visible. Make the
visual bigger or collapse some barrier groups. With Premium you can also zoom in: **Ctrl + scroll**
or the **+** button.

## The detail panel shows fields I don't want

It shows only what's in the Details wells. Remove a column from the well to hide it.

## The visual won't delete with the Delete key

Click outside it, then click its border, then press **Delete** — or right-click → **Remove**.
That's standard Power BI behaviour for custom visuals.

## Contact us

Email **support@pranaits.com** with:

- your Power BI Desktop version and the visual's version;
- what you expected and what happened, with a screenshot;
- if you can, a sanitised sample of the rows involved.

For a feature request, use the same address with "Feature request" in the subject.
