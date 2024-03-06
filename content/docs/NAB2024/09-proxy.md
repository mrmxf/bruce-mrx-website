---
title:       No Proxy UHD
linkTitle:   No Proxy UHD
date:        2024-03-06
description: Smart Content at res
author:      Bruce Devlin
tags:        ["tools"]

---

{{% nab24-demo 9 %}}

{{< nab24-demo-highlight >}}
Self describing metadata enhances true multi-resolution codecs in
content-at-rest workflows. **No More Proxies**
{{< /nab24-demo-highlight >}}

{{% nab24-demo-summary %}}

* 8k renders of Rexy are encoded with VC-6
* we register the VC-6 metadata and make a filter to display available resolutions
* user can select a resolutiuon and playback directly from S3 cache - no transcode - no proxy
* player shows bitrate an possibly buffering of the bitstream
{{% /nab24-demo-summary %}}

<div class="ui ui olive card card">
    <div style="aspect-ratio: 1 / 1;width:1280px;align-content:center;background-color:darkgray;">
      <video class="ui centered image" poster="/img/event/ibc2023-poster-rnf-sizzle.png" autoplay="1" loop="1" controls="1" muted="1" style="  position: relative;top: 50%;transform: translateY(-50%);">
        <source src="/meeja/fish 2.mp4">
        Your browser does not support the video tag.
      </video>
    </div>
    <div class="content">
      <div class="header">IBC Accelerator Zone 2023</div>
      <div class="meta">
      </div>
      <p><!-- partials/metarex-styled.html -->
</p>
    </div>
  </div>
{{% sitelinks %}}"
{{% /nab24-demo %}}
