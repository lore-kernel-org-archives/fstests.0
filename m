Received: from mx1.redhat.com ([209.132.183.28]:33224 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937060AbdAGQcC (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 7 Jan 2017 11:32:02 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 17C09C05681D
        for <fstests@vger.kernel.org>; Sat,  7 Jan 2017 16:32:03 +0000 (UTC)
Received: from [IPv6:::1] (ovpn04.gateway.prod.ext.phx2.redhat.com [10.5.9.4])
        by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id v07GW27G015532
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
        for <fstests@vger.kernel.org>; Sat, 7 Jan 2017 11:32:02 -0500
From: Eric Sandeen <sandeen@redhat.com>
Subject: xfs/118: add to dangerous group
Message-ID: <f3f2db11-2278-4b0e-f7a4-22c49eb8e0b5@redhat.com>
Date: Sat, 7 Jan 2017 10:32:01 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

Failure results in an oops, so add it to dangerous.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/tests/xfs/group b/tests/xfs/group
index c237b50..5b872d9 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -115,7 +115,7 @@
 115 parent attr
 116 quota auto quick
 117 fuzzers
-118 auto quick fsr
+118 auto quick fsr dangerous
 119 log v2log auto freeze dangerous
 120 fuzzers
 121 log auto quick
