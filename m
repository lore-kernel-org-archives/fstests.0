Received: from cn.fujitsu.com ([222.73.24.84]:25836 "EHLO song.cn.fujitsu.com"
        rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1755441AbcKOIOQ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 15 Nov 2016 03:14:16 -0500
From: Qu Wenruo <quwenruo@cn.fujitsu.com>
Subject: [PATCH] fstests: Block btrfs from test case generic/372
Date: Tue, 15 Nov 2016 16:14:10 +0800
Message-Id: <20161115081410.6779-1-quwenruo@cn.fujitsu.com>
MIME-Version: 1.0
Sender: fstests-owner@vger.kernel.org
To: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Since btrfs always return the whole extent even part of it is shared
with other files, so the hole/extent counts differs for "file1" in this
test case.

For example:

 /------ File 1 Extent 0-------------\
/                                     \
|<----------Extent A------------------>|
\         /                  \         /
 \ File 2/                    \ File 2/
   Ext 0~4K                    Ext 64k~68K

In that case, fiemap on File 1 will only return 1 large extent A with
SHARED flag.
While XFS will split it into 3 extents,  first and last 4K with SHARED
flag while the rest without SHARED flag.

This makes the test case meaningless as btrfs doesn't follow such
assumption.
So black list btrfs for this test case to avoid false alert.

Signed-off-by: Qu Wenruo <quwenruo@cn.fujitsu.com>
---
 common/rc         | 10 ++++++++++
 tests/generic/372 |  1 +
 2 files changed, 11 insertions(+)

diff --git a/common/rc b/common/rc
index e3b54ec..6c3de22 100644
--- a/common/rc
+++ b/common/rc
@@ -3230,6 +3230,16 @@ _normalize_mount_options()
 	echo $MOUNT_OPTIONS | sed -n 's/-o\s*\(\S*\)/\1/gp'| sed 's/,/ /g'
 }
 
+# skip test if FSTYP is in the black list
+_exclude_fs_type()
+{
+	while [ $# -gt 0 ]; do
+		if [ $FSTYP == $1 ]; then
+			_notrun "fs type \"$1\" is not allowed in this test"
+		fi
+	done
+}
+
 # skip test if MOUNT_OPTIONS contains the given strings
 _exclude_scratch_mount_option()
 {
diff --git a/tests/generic/372 b/tests/generic/372
index 31dff20..5e4cfff 100755
--- a/tests/generic/372
+++ b/tests/generic/372
@@ -45,6 +45,7 @@ _cleanup()
 # real QA test starts here
 _supported_os Linux
 _supported_fs generic
+_exclude_fs_type btrfs
 _require_scratch_reflink
 _require_fiemap
 
-- 
2.7.4



