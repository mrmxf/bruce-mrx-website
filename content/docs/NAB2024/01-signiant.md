---
title:       Cloud Ingest with Jet
linkTitle:   Cloud Ingest with Jet
date:        2024-02-20
description: Dynamic Flight Deck Media
author:      Bruce Devlin
tags:        ["signiant", "PoC"]
---

{{< nab24-demo 1 >}}

#### Concept

Signiant Jet can be triggered to capture live events by connecting to an Arqiva
Live Picture Exchage Directory ([LPX]). Metarex provides automatic ETL
(**E**xtract, **T**ransform & **L**oad) processes to allow the
metadata from the live event to be automatically:

* show descriptive & QC text in the Jet UI for display
* import event metadata into Snowflake
* embed the metadata into the essence for downstream propagation

Key Points:

* IMF QC report & LPX data moved in {{< metarex >}} container
* Web Service (metarex core) to validate documents
* Web Service (metarex enabled) to check QC status
* Web Service (metarex enabled) to synthesise svg icons
* Jet / Fight Deck mockup to show status
* Potentially use LPX metadata to show downstream list of captured events

[LPX]:   https://app.swaggerhub.com/apis/Arqiva/lpx-api/3.0

{{< sitelinks >}}
{{< /nab24-demo >}}
