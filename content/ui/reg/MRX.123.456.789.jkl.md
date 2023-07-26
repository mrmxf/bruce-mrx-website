---
title:       MRX.123.456.789.def
linkTitle:   MRX.123.456.789.def
url:         /ui/reg/MRX.123.456.789.jkl
description: Sample registration for rexy_sunbathe_mrx.mxf
---
# MRX.123.456.789.def

## embedded CSV text data of the lighting in Rexy's sunbathing scene

This is work in progress and there may be issues with the rexy file as well as
with the associated identifiers during the engineering stages.

The sample JSON below may change over time. If you want to track the changes
of the JSON for this sample, then take a look at the GitHub repo for this page.

```json
BEGIN-METAREX-JSON
{
    "metarexId":     "MRX.123.456.789.jkl",
    "type":          "embedded CSV text data of the lighting in Rexy's sunbathing scene",
    "payloadFormat": "text/csv",
    "specification": "https://docs.unrealengine.com/4.26/en-US/Resources/ContentExamples/Lighting/2_1/",
    "services": {}
}
END-METAREX-JSON
```

The project should also decide if this lightweight JSON should be delivered raw
at an API endpoint, embedded in a register webpage (like this) or both.