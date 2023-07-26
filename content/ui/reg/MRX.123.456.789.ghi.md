---
title:       MRX.123.456.789.ghi
linkTitle:   MRX.123.456.789.ghi
url:         /ui/reg/MRX.123.456.789.ghi
description: Sample registration for rexy_sunbathe_mrx.mxf
---
# MRX.123.456.789.ghi

## clocked JSON text of the camera location for Rexy's sunbathing scene

This is work in progress and there may be issues with the rexy file as well as
with the associated identifiers during the engineering stages.

The sample JSON below may change over time. If you want to track the changes
of the JSON for this sample, then take a look at the GitHub repo for this page.

```json
BEGIN-METAREX-JSON
{
    "metarexId":     "MRX.123.456.789.ghi",
    "type":          "clocked JSON text of the camera location for Rexy's sunbathing scene",
    "payloadFormat": "application/json",
    "specification": "https://docs.unrealengine.com/4.27/en-US/API/Runtime/Engine/Camera/UCameraComponent//",
    "services": {}
}
END-METAREX-JSON
```

The project should also decide if this lightweight JSON should be delivered raw
at an API endpoint, embedded in a register webpage (like this) or both.