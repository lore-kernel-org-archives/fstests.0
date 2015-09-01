Received: from mx1.redhat.com ([209.132.183.28]:32915 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752238AbbIAOWf (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 1 Sep 2015 10:22:35 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id 63A6DC0EF9B7
	for <fstests@vger.kernel.org>; Tue,  1 Sep 2015 14:22:35 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t81EMYkn010378
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
	for <fstests@vger.kernel.org>; Tue, 1 Sep 2015 10:22:35 -0400
From: Jeff Moyer <jmoyer@redhat.com>
Subject: xfstests run to run variability
Date: Tue, 01 Sep 2015 10:22:34 -0400
Message-ID: <x4937yyrzh1.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi,

I typically use ./check -g auto to test for regressions in my patches.
However, I've noticed that there is some run-to-run variability in the
results, even for a single kernel.  Here are the tests that fail, either
reliably, or worse, intermittently:

reproducible failures: generic/042 generic/311 xfs/032 xfs/053 xfs/070 xfs/071
intermittent failures: generic/192 generic/247 generic/232 xfs/167

I don't have time to dig into things right now (and so I haven't
included logs here since I'm not looking for help diagnosing the
issues).  What I'd like to know is if others also see this.  Second, I
was wondering if someone else has the time and motivation to look into
this inconsistency.

In case it's interesting, I run my tests on a Micron P320h PCIe SSD as
the test device, and a regular sata disk as the scratch device.

Cheers,
Jeff
