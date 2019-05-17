Received: from mx2.suse.de ([195.135.220.15]:49358 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727794AbfEQLY2 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 17 May 2019 07:24:28 -0400
From: Luis Henriques <lhenriques@suse.com>
Subject: [PATCH 2/2] overlay/023: use numeric user and group IDs in getfacl
Date: Fri, 17 May 2019 12:24:22 +0100
Message-Id: <20190517112422.20671-3-lhenriques@suse.com>
In-Reply-To: <20190517112422.20671-1-lhenriques@suse.com>
References: <20190517112422.20671-1-lhenriques@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Luis Henriques <lhenriques@suse.com>, Xiong Zhou <xzhou@redhat.com>
List-ID: <fstests@vger.kernel.org>

This prevents test failures if cases where, e.g., /etc/group doesn't
include the 'root' group ID.

Cc: Xiong Zhou <xzhou@redhat.com>
Signed-off-by: Luis Henriques <lhenriques@suse.com>
---
 tests/overlay/023     | 2 +-
 tests/overlay/023.out | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/overlay/023 b/tests/overlay/023
index 7e48349d1a12..edd034c3a9e3 100755
--- a/tests/overlay/023
+++ b/tests/overlay/023
@@ -55,7 +55,7 @@ setfacl -d -m o::rwx $wkdir
 _scratch_mount
 
 # getting acls, ACL set on workdir should be cleaned
-getfacl -p $wkdir/work 2>&1 | _filter_scratch | _filter_ovl_dirs
+getfacl -n -p $wkdir/work 2>&1 | _filter_scratch | _filter_ovl_dirs
 
 # success, all done
 status=0
diff --git a/tests/overlay/023.out b/tests/overlay/023.out
index 4a243c5b44ce..911d272d2241 100644
--- a/tests/overlay/023.out
+++ b/tests/overlay/023.out
@@ -1,7 +1,7 @@
 QA output created by 023
 # file: SCRATCH_DEV/OVL_WORK/work
-# owner: root
-# group: root
+# owner: 0
+# group: 0
 user::---
 group::---
 other::---
