Received: from mail-lf0-f66.google.com ([209.85.215.66]:35305 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752308AbdBUMoM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 21 Feb 2017 07:44:12 -0500
Received: by mail-lf0-f66.google.com with SMTP id z127so9031815lfa.2
        for <fstests@vger.kernel.org>; Tue, 21 Feb 2017 04:44:11 -0800 (PST)
From: Dmitry Monakhov <dmonakhov@openvz.org>
Subject: [PATCH 0/2] Add report generators support
Date: Tue, 21 Feb 2017 16:44:03 +0400
Message-Id: <1487681045-22884-2-git-send-email-dmonakhov@openvz.org>
In-Reply-To: <1487681045-22884-1-git-send-email-dmonakhov@openvz.org>
References: <1487681045-22884-1-git-send-email-dmonakhov@openvz.org>
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

