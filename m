Received: from mail-lf0-f65.google.com ([209.85.215.65]:35876 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751465AbdCCLcv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 3 Mar 2017 06:32:51 -0500
Received: by mail-lf0-f65.google.com with SMTP id g70so6820880lfh.3
        for <fstests@vger.kernel.org>; Fri, 03 Mar 2017 03:31:05 -0800 (PST)
From: Dmitry Monakhov <dmonakhov@openvz.org>
Subject: [PATCH 0/2] Add report generators support v3
Date: Fri,  3 Mar 2017 12:26:14 +0400
Message-Id: <1488529576-17034-1-git-send-email-dmonakhov@openvz.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: eguan@redhat.com, Dmitry Monakhov <dmonakhov@openvz.org>
List-ID: <fstests@vger.kernel.org>

xfstests has no stable logging API which is suitable for machine parsing.
This makes it difficult to integrate with external atomation tools (Jenkins.io, k8s jobs)
In fact thare are alot of well known parsable report formats TAP [1], Junit [2], yaml.
Let's add basic infrastructure so people may add report formats they do care about.

Usecase example with Jenkins:
- Split huge xfstest job to smaller peaces.
- Submit it as separate jobs and run it in parallel on different VMs
- Fetch and merge results to single job report.
This approach allow me to speedup xfstests x50 times,
now full run of '-g auto' takes only 3minutes

TOC
- check: prepare test report generator infrastructure
- report:Add xunit format report generator

changes from v2:
 - fixes in response to comments from eguan@
 - update against recent HEAD

changes from v1:
 - fixes in response to comments from eguan@
 - Add env variables to report
 .
Footnotes:
[1]  https://testanything.org
[2] http://help.catchsoftware.com/display/ET/JUnit+Format
