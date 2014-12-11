Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41764 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754264AbaLKRRJ (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 11 Dec 2014 12:17:09 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id sBBHH83h025813
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Thu, 11 Dec 2014 12:17:09 -0500
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH 2/4] fstests: change mode of test files to 0755
Date: Fri, 12 Dec 2014 01:16:09 +0800
Message-Id: <1418318171-5892-3-git-send-email-eguan@redhat.com>
In-Reply-To: <1418318171-5892-1-git-send-email-eguan@redhat.com>
References: <1418318171-5892-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Performed by

find tests -perm 644 -name [0-9][0-9][0-9] -exec chmod 755 {} \;

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 tests/btrfs/010   | 0
 tests/btrfs/013   | 0
 tests/btrfs/015   | 0
 tests/btrfs/017   | 0
 tests/btrfs/018   | 0
 tests/btrfs/026   | 0
 tests/btrfs/027   | 0
 tests/btrfs/028   | 0
 tests/btrfs/029   | 0
 tests/btrfs/031   | 0
 tests/btrfs/043   | 0
 tests/btrfs/044   | 0
 tests/btrfs/046   | 0
 tests/btrfs/049   | 0
 tests/btrfs/057   | 0
 tests/btrfs/058   | 0
 tests/btrfs/076   | 0
 tests/btrfs/077   | 0
 tests/generic/029 | 0
 tests/generic/030 | 0
 tests/generic/031 | 0
 tests/generic/032 | 0
 tests/generic/033 | 0
 tests/generic/323 | 0
 tests/generic/324 | 0
 tests/xfs/298     | 0
 tests/xfs/306     | 0
 27 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 tests/btrfs/010
 mode change 100644 => 100755 tests/btrfs/013
 mode change 100644 => 100755 tests/btrfs/015
 mode change 100644 => 100755 tests/btrfs/017
 mode change 100644 => 100755 tests/btrfs/018
 mode change 100644 => 100755 tests/btrfs/026
 mode change 100644 => 100755 tests/btrfs/027
 mode change 100644 => 100755 tests/btrfs/028
 mode change 100644 => 100755 tests/btrfs/029
 mode change 100644 => 100755 tests/btrfs/031
 mode change 100644 => 100755 tests/btrfs/043
 mode change 100644 => 100755 tests/btrfs/044
 mode change 100644 => 100755 tests/btrfs/046
 mode change 100644 => 100755 tests/btrfs/049
 mode change 100644 => 100755 tests/btrfs/057
 mode change 100644 => 100755 tests/btrfs/058
 mode change 100644 => 100755 tests/btrfs/076
 mode change 100644 => 100755 tests/btrfs/077
 mode change 100644 => 100755 tests/generic/029
 mode change 100644 => 100755 tests/generic/030
 mode change 100644 => 100755 tests/generic/031
 mode change 100644 => 100755 tests/generic/032
 mode change 100644 => 100755 tests/generic/033
 mode change 100644 => 100755 tests/generic/323
 mode change 100644 => 100755 tests/generic/324
 mode change 100644 => 100755 tests/xfs/298
 mode change 100644 => 100755 tests/xfs/306

diff --git a/tests/btrfs/010 b/tests/btrfs/010
old mode 100644
new mode 100755
diff --git a/tests/btrfs/013 b/tests/btrfs/013
old mode 100644
new mode 100755
diff --git a/tests/btrfs/015 b/tests/btrfs/015
old mode 100644
new mode 100755
diff --git a/tests/btrfs/017 b/tests/btrfs/017
old mode 100644
new mode 100755
diff --git a/tests/btrfs/018 b/tests/btrfs/018
old mode 100644
new mode 100755
diff --git a/tests/btrfs/026 b/tests/btrfs/026
old mode 100644
new mode 100755
diff --git a/tests/btrfs/027 b/tests/btrfs/027
old mode 100644
new mode 100755
diff --git a/tests/btrfs/028 b/tests/btrfs/028
old mode 100644
new mode 100755
diff --git a/tests/btrfs/029 b/tests/btrfs/029
old mode 100644
new mode 100755
diff --git a/tests/btrfs/031 b/tests/btrfs/031
old mode 100644
new mode 100755
diff --git a/tests/btrfs/043 b/tests/btrfs/043
old mode 100644
new mode 100755
diff --git a/tests/btrfs/044 b/tests/btrfs/044
old mode 100644
new mode 100755
diff --git a/tests/btrfs/046 b/tests/btrfs/046
old mode 100644
new mode 100755
diff --git a/tests/btrfs/049 b/tests/btrfs/049
old mode 100644
new mode 100755
diff --git a/tests/btrfs/057 b/tests/btrfs/057
old mode 100644
new mode 100755
diff --git a/tests/btrfs/058 b/tests/btrfs/058
old mode 100644
new mode 100755
diff --git a/tests/btrfs/076 b/tests/btrfs/076
old mode 100644
new mode 100755
diff --git a/tests/btrfs/077 b/tests/btrfs/077
old mode 100644
new mode 100755
diff --git a/tests/generic/029 b/tests/generic/029
old mode 100644
new mode 100755
diff --git a/tests/generic/030 b/tests/generic/030
old mode 100644
new mode 100755
diff --git a/tests/generic/031 b/tests/generic/031
old mode 100644
new mode 100755
diff --git a/tests/generic/032 b/tests/generic/032
old mode 100644
new mode 100755
diff --git a/tests/generic/033 b/tests/generic/033
old mode 100644
new mode 100755
diff --git a/tests/generic/323 b/tests/generic/323
old mode 100644
new mode 100755
diff --git a/tests/generic/324 b/tests/generic/324
old mode 100644
new mode 100755
diff --git a/tests/xfs/298 b/tests/xfs/298
old mode 100644
new mode 100755
diff --git a/tests/xfs/306 b/tests/xfs/306
old mode 100644
new mode 100755
-- 
1.8.3.1

