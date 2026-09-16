# Privacy Policy — Bowtie Risk Visual for Power BI

**Effective Date:** September 2026
**Publisher:** Prana IT Solutions Ltd

## Overview

The Bowtie Risk Visual ("the Visual") is a Power BI custom visual that renders
bow-tie risk analysis diagrams. This policy explains how data is handled when
you use the Visual.

## Data Processing

The Visual processes data **entirely within your Power BI environment**. Specifically:

- **No data leaves Power BI.** The Visual reads data from Power BI's DataView API
  and renders it on screen. It does not transmit, store, or send your data to any
  external server, API, or third-party service.

- **No external network calls.** The Visual has an empty privileges array and makes
  no HTTP requests. It operates entirely within Power BI's sandboxed iframe.

- **No cookies or local storage.** The Visual does not use browser cookies,
  localStorage, sessionStorage, or any persistent client-side storage.

- **No telemetry or analytics.** The Visual does not collect usage data, track
  user behaviour, or send analytics to any service.

## Data Handled

The Visual processes the following categories of data, provided by you through
Power BI's field wells:

- Risk identifiers and descriptions
- Cause and consequence identifiers and descriptions
- Barrier identifiers, health status, effectiveness ratings, and ownership
- Action identifiers, status, due dates, and assignees
- Any additional columns you choose to bind to the Details field wells

All of this data originates from your Power BI data model and is processed
in-memory within the browser for rendering purposes only.

## Licensing

If you use the premium tier, licence verification is handled by Microsoft's
Power BI Licensing API. Prana IT Solutions Ltd does not independently collect
or store any licence, payment, or subscription information. All commercial
transactions are managed through Microsoft AppSource and the Microsoft 365
Admin Center.

## Third-Party Libraries

The Visual includes the following open-source libraries, bundled into the
visual package:

- React (MIT License) — UI rendering
- ReactFlow (MIT License) — graph visualisation
- dagre (MIT License) — graph layout
- D3.js (ISC License) — SVG rendering

These libraries run locally within Power BI and do not make external calls.

## Children's Privacy

The Visual is a business analytics tool and is not directed at children
under the age of 13.

## Changes to This Policy

We may update this policy from time to time. Changes will be posted at this
URL with an updated effective date.

## Contact

For questions about this privacy policy:

**Prana IT Solutions Ltd**
Email: support@pranaits.com
Web: https://pranaits.com
