Received: from mailhub.sw.ru ([195.214.232.25]:39086 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751225AbdAaRxS (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 31 Jan 2017 12:53:18 -0500
From: Dmitry Monakhov <dmonakhov@openvz.org>
Subject: [PATCH 0/2] Add report generators support
Date: Tue, 31 Jan 2017 21:16:21 +0400
Message-Id: <1485882983-16883-1-git-send-email-dmonakhov@openvz.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Dmitry Monakhov <dmonakhov@openvz.org>
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

Footnotes: 
[1]  https://testanything.org
[2] http://help.catchsoftware.com/display/ET/JUnit+Format

