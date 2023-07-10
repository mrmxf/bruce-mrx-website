---
title:       MRX.123.456.789.abc
linkTitle:   MRX.123.456.789.abc
url:         /reg/MRX.123.456.789.abc
description: Sample registration for comment
---
# MRX.123.456.789.abc

**Congratulations**.This is a sample url intended to show how a simple ID can
resolve to a web page where there is information on how to:

* check you've got the right page (`metarexId`)
* get a unique string that identifies the metarex type (`type`)
* and a set of useful keys to identify ways to enlighten the data. The
  specification and schema need to be developed during the project and Proofs of
  Concept, but potential values are:
  * `schema` links to one or more schema(s) for this metadata
  * `format` the `Content Type` for an HTTP header
  * `specification` url of a human (or machine) readable syntax & semantic
    definition
  * `decoder` links to one or more decoder(s) for the metadata
  * `encoder` links to one or more encoder(s) for the metadata
  * `services` links to online services that can handle the raw or metarex
    encapsulated metadata

```json
BEGIN-METAREX-JSON
{
    "metarexId": "MRX.123.456.789.abc",
    "type": "binay serialised Raspberry Pi data",
    "format": "application/octet-stream",
    "specification": "https://github.com/mrmxf/metarex/MRX.123.456.789.abc/spec",
    "decoder": "https://github.com/mrmxf/metarex/MRX.123.456.789.abc/code",
    "services": {
        "avid":      "https://some-decoder.com/api/avid/v1"
        "transcode": "https://some-magic.com/api/avid/v1"
    },
}
END-METAREX-JSON
```

The project should also decide if this lightweight JSON should be delivered raw
at an API endpoint, embedded in a register webpage (like this) or both.