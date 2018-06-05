Received: from mail-wr0-f180.google.com ([209.85.128.180]:43063 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751507AbeFEIH0 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 5 Jun 2018 04:07:26 -0400
Received: by mail-wr0-f180.google.com with SMTP id d2-v6so1305181wrm.10
        for <fstests@vger.kernel.org>; Tue, 05 Jun 2018 01:07:25 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v3] generic/401: fix test in case of no filetype support
Date: Tue,  5 Jun 2018 11:08:50 +0300
Message-Id: <1528186130-22854-1-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>, Xu Huan <xuhuan.fnst@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Xu Huan reported that this test fails on nfs in some setup.
Apparently, the assumptions made about xfs/ext* do not hold
for nfs.

Relax the verification of filetype not supported case to
allow either DT_UNKNOWN or actual file type on all files and
not only on special dir entires "." and "..".

Convert the unknown d_type replacement code from awk to bash
so it is a bit more readable and flexible.

Reported-by: Xu Huan <xuhuan.fnst@cn.fujitsu.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Xu,

Please check if this patch fixes your problem.
I prefer to keep the test coverage of unsupported case.

I tested with xfs/ext4 with/without filetype support.

Thanks,
Amir.

 tests/generic/401 | 42 ++++++++++++++++++++----------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/tests/generic/401 b/tests/generic/401
index 74f2bea..34ce76e 100755
--- a/tests/generic/401
+++ b/tests/generic/401
@@ -4,14 +4,13 @@
 # Test filetype feature
 #
 # This test does NOT require that file system support the d_type feature.
-# It verifies that either all file types are reported as DT_UNKNOWN
-# or all file types are reported correctly.
+# It verifies that file types are reported as either DT_UNKNOWN or as
+# the actual file type. For example, special dir entries . and .. MAY be
+# reported as DT_UNKNOWN IF filetype feature is disabled (ext4), but MAY
+# also be reported as DT_DIR in this case (xfs).
 #
 # For fs for which we know how to test the filetype feature (xfs|ext*)
 # verify getting DT_UNKNOWN IFF feature is disabled.
-# Special dir entries . and .. MAY be reported as DT_UNKNOWN IF filetype
-# feature is disabled (ext4), but MAY also be reported as DT_DIR in this
-# case (xfs).
 #
 #-----------------------------------------------------------------------
 #
@@ -73,23 +72,22 @@ mknod $testdir/c c 1 1
 mknod $testdir/b b 1 1
 mknod $testdir/p p
 
-# Test d_type of . and ..
-# it must be DT_DIR on fs with filetype support and it could be
-# either DR_DIR or DT_UNKNOWN on fs without filetype support
-src/t_dir_type $testdir d | grep -F '.' | sort
-
-# Test that either all file types are unknown or all are correct
-if _supports_filetype $SCRATCH_MNT; then
-	# print real file types
-	src/t_dir_type $testdir | grep -vF '.' | sort
-else
-	# print fake dir file type for . and .. if they are DT_UNKNOWN
-	src/t_dir_type $testdir u | grep -F '.' | \
-		awk '{ print $1, "d" }' | sort
-	# list unknown files and print filename as fake file type
-	src/t_dir_type $testdir u | grep -vF '.' | \
-		awk '{ print $1, $1 }' | sort
-fi
+# Test d_type of test files - it must be the actual file type on fs
+# with filetype support and it could be either the actual file type
+# or DT_UNKNOWN on fs without filetype support
+ftype=
+_supports_filetype $SCRATCH_MNT && ftype=1
+src/t_dir_type $testdir | \
+while read name type; do
+	if [ "$ftype" != 1 -a "$type" = u ]; then
+		if [ "$name" = "." -o "$name" = ".." ]; then
+			type=d
+		else
+			type=$name
+		fi
+	fi
+	echo $name $type
+done | sort
 
 status=0
 exit
-- 
2.7.4

