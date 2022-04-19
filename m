Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04154C433FE
	for <linux-fstests@archiver.kernel.org>; Tue, 19 Apr 2022 12:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350512AbiDSM72 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 19 Apr 2022 08:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350475AbiDSM72 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 19 Apr 2022 08:59:28 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125A43299B
        for <fstests@vger.kernel.org>; Tue, 19 Apr 2022 05:56:45 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id p18so21492620wru.5
        for <fstests@vger.kernel.org>; Tue, 19 Apr 2022 05:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lTTP/aJFMHrhxi1lywFKQDRBKczoS8O+mIxuTCzLdiY=;
        b=NZ9nx5AUW/9eYNM60S5kCzo4TSEoNxZGySeiUrJ2qdX+TSppj4wPNOcKSIXl3rY0xG
         2McDsUnrVhxbQsLEfK/JDZjuh9JTr9gyGInyg1tWCseGlBo0E9V2uf5MmvizHW6BS72w
         AlwKC2ExByteSpJSAqgBsnHRJZvA3Wkxk0m6gbou/b5+RBnO80lCmuZj7fB5umBpE6CO
         4JRkTjZfl/7UHvwP3sm0N9jmSXZT5ay86F4cI6ln6HVyBoTPDIGdX5gpR1YG1v8sxNVR
         KQBycsI3JZfmQLVDOy3qZcU3qwx/bcGU6eAEliq4eqk9pSXQ47PazdstHDS7iDDmfBqo
         L3Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lTTP/aJFMHrhxi1lywFKQDRBKczoS8O+mIxuTCzLdiY=;
        b=KQK9txVArO0FeMqbYXZfJCuE/DcMO7M7VNK11QMGX5m67R+W8wYjJh4g3RAUHLFPb0
         ZEX+xPPrcCel3CzNgabHEDdmufuqfG3jJzWwO0kf95Kv0J8yZOGKC143CrwJUtpdbcrB
         8oSh5vCXguWmmYo62s18H/dFOqJddNlwuNAdKdCqU1rrisDgVRtxkKxKmvMnnAoIow7F
         oPC1m6/PGWRtaqzKIgk3xilxoeOkNLlBJj9RFggt9/pemNgA3t9gLuH9wgNMEey4c7cM
         ku9NuW3IoTHiVXyVboIBBjAcb1i2nwX7GX0V6sEyXEGmei1lGQA03Sw0FCBz8FKK6JGu
         xedg==
X-Gm-Message-State: AOAM531FF/PpOeF5vyjhBSKz/9pGaVmjdQLziqzYN0igfFkGYvUzU+LJ
        LCCwWQCmJIuhySb+75DlP/U=
X-Google-Smtp-Source: ABdhPJyHwQsq0JehHFinbCaxbyDxrBwO2zunVoeuVu/qndmDwmSpaZJKo+ESvAwUUHncilap7G5+fw==
X-Received: by 2002:a05:6000:799:b0:207:a326:8e with SMTP id bu25-20020a056000079900b00207a326008emr11704648wrb.516.1650373003390;
        Tue, 19 Apr 2022 05:56:43 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id t12-20020a05600001cc00b00207aac5d595sm12499142wrx.38.2022.04.19.05.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 05:56:42 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Zorro Lang <zlang@redhat.com>, Eryu Guan <guaneryu@gmail.com>
Cc:     fstests@vger.kernel.org
Subject: [PATCH v2 2/2] common: print hints for reasons of test failures
Date:   Tue, 19 Apr 2022 15:56:37 +0300
Message-Id: <20220419125637.2502181-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220419125637.2502181-1-amir73il@gmail.com>
References: <20220419125637.2502181-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Introduce helpers _fixed_by_{kernel,git}_commit() and
_fixed_in_{kernel_,}version() that can be used to hint testers why a
test might be failing and aid in auto-generating of expunge lists for
downstream kernel testing.

A test may be annotated with multiple hints, for example:

_fixed_by_kernel_commit 09889695864 xfs: foo
_fixed_by_kernel_commit 46464565465 ext4: bar
_fixed_in_version xfsprogs v5.15

Annotate fix kernel commits for some overlayfs tests.
Annotate fix kernel version for some overlayfs tests testing
for legacy behavior whose fixes are not likely to be backported
to stable kernels.

This is modeled after LTP's 'make filter-known-fails' and
print_failure_hints() using struct tst_tag annotations.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 check             | 10 +++++++++-
 common/preamble   |  2 +-
 common/rc         | 29 +++++++++++++++++++++++++++++
 tests/overlay/009 |  3 +++
 tests/overlay/010 |  3 +++
 tests/overlay/014 |  2 ++
 tests/overlay/016 |  4 +++-
 tests/overlay/017 |  4 +++-
 tests/overlay/018 |  4 +++-
 tests/overlay/020 |  3 +++
 tests/overlay/022 |  2 ++
 tests/overlay/029 |  2 ++
 tests/overlay/038 |  2 ++
 tests/overlay/041 |  2 ++
 tests/overlay/042 |  3 +++
 tests/overlay/043 |  4 +++-
 tests/overlay/044 |  4 +++-
 tests/overlay/054 |  3 +++
 tests/overlay/055 |  3 +++
 tests/overlay/063 |  3 +++
 tests/overlay/065 |  4 ++++
 tests/overlay/067 |  3 +++
 tests/overlay/070 |  4 +++-
 tests/overlay/071 |  4 +++-
 tests/overlay/072 |  2 ++
 tests/overlay/074 |  5 +++++
 tests/overlay/077 |  5 +++++
 tests/overlay/078 |  1 +
 28 files changed, 111 insertions(+), 9 deletions(-)

diff --git a/check b/check
index a0863121..de11b37e 100755
--- a/check
+++ b/check
@@ -808,7 +808,7 @@ function run_section()
 		fi
 
 		# really going to try and run this one
-		rm -f $seqres.out.bad
+		rm -f $seqres.out.bad $seqres.hints
 
 		# check if we really should run it
 		_expunge_test $seqnum
@@ -942,6 +942,14 @@ function run_section()
 			fi; } | sed -e 's/^\(.\)/    \1/'
 			err=true
 		fi
+		if [ -f $seqres.hints ]; then
+			if $err; then
+				echo
+				cat $seqres.hints
+			else
+				rm -f $seqres.hints
+			fi
+		fi
 	done
 
 	# make sure we record the status of the last test we ran.
diff --git a/common/preamble b/common/preamble
index 64d79385..68219660 100644
--- a/common/preamble
+++ b/common/preamble
@@ -79,6 +79,6 @@ _begin_fstest()
 	. ./common/rc
 
 	# remove previous $seqres.full before test
-	rm -f $seqres.full
+	rm -f $seqres.full $seqres.hints
 
 }
diff --git a/common/rc b/common/rc
index ae201f87..6713add2 100644
--- a/common/rc
+++ b/common/rc
@@ -1605,6 +1605,35 @@ _supported_fs()
 		_notrun "not suitable for this filesystem type: $FSTYP"
 }
 
+_fixed_in_version()
+{
+	local pkg=$1
+	local ver=$2
+
+	echo "HINT: You _MAY_ be hit by a known issue on $pkg version < $ver." >> $seqres.hints
+	echo >> $seqres.hints
+}
+
+_fixed_in_kernel_version()
+{
+	_fixed_in_version kernel $*
+}
+
+_fixed_by_git_commit()
+{
+	local pkg=$1
+	shift
+
+	echo "HINT: You _MAY_ be missing $pkg fix:" >> $seqres.hints
+	echo "      $*" >> $seqres.hints
+	echo >> $seqres.hints
+}
+
+_fixed_by_kernel_commit()
+{
+	_fixed_by_git_commit kernel $*
+}
+
 # check if a FS on a device is mounted
 # if so, verify that it is mounted on mount point
 # if fstype is given as argument, verify that it is also
diff --git a/tests/overlay/009 b/tests/overlay/009
index 94bd1b66..d85ef16e 100755
--- a/tests/overlay/009
+++ b/tests/overlay/009
@@ -17,6 +17,9 @@ _begin_fstest auto quick
 
 # real QA test starts here
 _supported_fs overlay
+_fixed_by_kernel_commit a4859d75944a \
+	"ovl: fix dentry leak for default_permissions"
+
 _require_scratch
 
 # Remove all files from previous tests
diff --git a/tests/overlay/010 b/tests/overlay/010
index 71ef6ec1..af22b2b4 100755
--- a/tests/overlay/010
+++ b/tests/overlay/010
@@ -17,6 +17,9 @@ _begin_fstest auto quick whiteout
 
 # real QA test starts here
 _supported_fs overlay
+_fixed_by_kernel_commit 84889d493356 \
+	"ovl: check dentry positiveness in ovl_cleanup_whiteouts()"
+
 # Use non-default scratch underlying overlay dirs, we need to check
 # them explicity after test.
 _require_scratch_nocheck
diff --git a/tests/overlay/014 b/tests/overlay/014
index 83295ccc..2d6c11d9 100755
--- a/tests/overlay/014
+++ b/tests/overlay/014
@@ -21,6 +21,8 @@ _begin_fstest auto quick copyup
 
 # real QA test starts here
 _supported_fs overlay
+_fixed_by_kernel_commit 0956254a2d5b "ovl: don't copy up opaqueness"
+
 # Use non-default scratch underlying overlay dirs, we need to check
 # them explicity after test.
 _require_scratch_nocheck
diff --git a/tests/overlay/016 b/tests/overlay/016
index 8a091615..7b4a3dad 100755
--- a/tests/overlay/016
+++ b/tests/overlay/016
@@ -6,7 +6,7 @@
 #
 # Test ro/rw fd data inconsistecies
 #
-# This simple test demonstrates a known issue with overlayfs:
+# This simple test demonstrates an issue with overlayfs on kernel < v4.19:
 # - process A opens file F for read
 # - process B writes new data to file F
 # - process A reads old data from file F
@@ -19,6 +19,8 @@ _begin_fstest auto quick copyup
 
 # real QA test starts here
 _supported_fs overlay
+_fixed_in_kernel_version "v4.19"
+
 _require_scratch
 _require_xfs_io_command "open"
 
diff --git a/tests/overlay/017 b/tests/overlay/017
index 15b0d613..0bb248c2 100755
--- a/tests/overlay/017
+++ b/tests/overlay/017
@@ -6,7 +6,7 @@
 #
 # Test constant inode numbers
 #
-# This simple test demonstrates a known issue with overlayfs:
+# This simple test demonstrates an issue with overlayfs on kernel < v4.14:
 # - stat file A shows inode number X
 # - modify A to trigger copy up
 # - stat file A shows inode number Y != X
@@ -23,6 +23,8 @@ _begin_fstest auto quick copyup redirect
 
 # real QA test starts here
 _supported_fs overlay
+_fixed_in_kernel_version "v4.14"
+
 _require_scratch
 _require_test_program "af_unix"
 _require_test_program "t_dir_type"
diff --git a/tests/overlay/018 b/tests/overlay/018
index b09bca9c..4cccbbdc 100755
--- a/tests/overlay/018
+++ b/tests/overlay/018
@@ -6,7 +6,7 @@
 #
 # Test hardlink breakage
 #
-# This simple test demonstrates a known issue with overlayfs:
+# This simple test demonstrates an issue with overlayfs on kernel < v4.13:
 # - file A and B are hardlinked in lower
 # - modify A to trigger copy up
 # - file A is no longer a hardlink of file B
@@ -19,6 +19,8 @@ _begin_fstest auto quick copyup hardlink
 
 # real QA test starts here
 _supported_fs overlay
+_fixed_in_kernel_version "v4.13"
+
 _require_scratch
 _require_scratch_feature index
 _require_test_program "t_dir_type"
diff --git a/tests/overlay/020 b/tests/overlay/020
index 51f97ccd..98a33aec 100755
--- a/tests/overlay/020
+++ b/tests/overlay/020
@@ -23,6 +23,9 @@ require_unshare() {
 
 # Modify as appropriate.
 _supported_fs overlay
+_fixed_by_kernel_commit 3fe6e52f0626 \
+	"ovl: override creds with the ones from the superblock mounter"
+
 _require_scratch
 require_unshare -m -p -U
 
diff --git a/tests/overlay/022 b/tests/overlay/022
index 1a11805d..09af6500 100755
--- a/tests/overlay/022
+++ b/tests/overlay/022
@@ -29,6 +29,8 @@ _cleanup()
 
 # Modify as appropriate.
 _supported_fs overlay
+_fixed_by_kernel_commit 76bc8e2843b6 "ovl: disallow overlayfs as upperdir"
+
 _require_scratch
 
 # Remove all files from previous tests
diff --git a/tests/overlay/029 b/tests/overlay/029
index 1a532c2a..c4c8eed7 100755
--- a/tests/overlay/029
+++ b/tests/overlay/029
@@ -34,6 +34,8 @@ _cleanup()
 
 # Modify as appropriate.
 _supported_fs overlay
+_fixed_by_kernel_commit c4fcfc1619ea "ovl: fix d_real() for stacked fs"
+
 _require_scratch
 
 # Remove all files from previous tests
diff --git a/tests/overlay/038 b/tests/overlay/038
index 145b4b34..19c000ce 100755
--- a/tests/overlay/038
+++ b/tests/overlay/038
@@ -15,6 +15,8 @@ _begin_fstest auto quick copyup
 
 # real QA test starts here
 _supported_fs overlay
+_fixed_in_kernel_version "v4.14"
+
 # Use non-default scratch underlying overlay dirs, we need to check
 # them explicity after test.
 _require_scratch_nocheck
diff --git a/tests/overlay/041 b/tests/overlay/041
index 762e7389..a326b6b0 100755
--- a/tests/overlay/041
+++ b/tests/overlay/041
@@ -17,6 +17,8 @@ _begin_fstest auto quick copyup nonsamefs
 
 # real QA test starts here
 _supported_fs overlay
+_fixed_in_kernel_version "v4.17"
+
 # Use non-default scratch underlying overlay dirs, we need to check
 # them explicity after test.
 _require_scratch_nocheck
diff --git a/tests/overlay/042 b/tests/overlay/042
index 60f4b477..0715066f 100755
--- a/tests/overlay/042
+++ b/tests/overlay/042
@@ -26,6 +26,9 @@ _begin_fstest auto quick copyup hardlink
 
 # real QA test starts here
 _supported_fs overlay
+_fixed_by_kernel_commit 6eaf011144af \
+	"ovl: fix EIO from lookup of non-indexed upper"
+
 _require_scratch
 # Without overlay index feature hardlinks are broken on copy up
 _require_scratch_feature index
diff --git a/tests/overlay/043 b/tests/overlay/043
index 383151dd..56f89214 100755
--- a/tests/overlay/043
+++ b/tests/overlay/043
@@ -8,7 +8,7 @@
 # This is a variant of overlay/017 to test constant st_ino numbers for
 # non-samefs setup.
 #
-# This simple test demonstrates a known issue with overlayfs:
+# This simple test demonstrates an issue with overlayfs on kernel < v4.17:
 # - stat file A shows inode number X
 # - modify A to trigger copy up
 # - stat file A shows inode number Y != X
@@ -25,6 +25,8 @@ _begin_fstest auto quick copyup nonsamefs
 
 # real QA test starts here
 _supported_fs overlay
+_fixed_in_kernel_version "v4.17"
+
 # Use non-default scratch underlying overlay dirs, we need to check
 # them explicity after test.
 _require_scratch_nocheck
diff --git a/tests/overlay/044 b/tests/overlay/044
index 3f54b7ea..3f74890f 100755
--- a/tests/overlay/044
+++ b/tests/overlay/044
@@ -7,7 +7,7 @@
 # Test hardlink breakage on non-samefs setup
 # This is a variant of overlay/018 to test.
 #
-# This simple test demonstrates a known issue with overlayfs:
+# This simple test demonstrates an issue with overlayfs on kernel < v4.17:
 # - file A and B are hardlinked in lower
 # - modify A to trigger copy up
 # - file A is no longer a hardlink of file B
@@ -20,6 +20,8 @@ _begin_fstest auto quick copyup hardlink nonsamefs
 
 # real QA test starts here
 _supported_fs overlay
+_fixed_in_kernel_version "v4.17"
+
 # Use non-default scratch underlying overlay dirs, we need to check
 # them explicity after test.
 _require_scratch_nocheck
diff --git a/tests/overlay/054 b/tests/overlay/054
index d95427b6..ba20a7fc 100755
--- a/tests/overlay/054
+++ b/tests/overlay/054
@@ -37,6 +37,9 @@ _begin_fstest auto quick copyup redirect exportfs
 # real QA test starts here
 
 _supported_fs overlay
+_fixed_by_kernel_commit 2ca3c148a062 \
+	"ovl: check lower ancestry on encode of lower dir file handle"
+
 _require_scratch
 _require_test_program "open_by_handle"
 # We need to require all features together, because nfs_export cannot
diff --git a/tests/overlay/055 b/tests/overlay/055
index 45a3c107..367f038b 100755
--- a/tests/overlay/055
+++ b/tests/overlay/055
@@ -46,6 +46,9 @@ _cleanup()
 # real QA test starts here
 
 _supported_fs overlay
+_fixed_by_kernel_commit 2ca3c148a062 \
+	"ovl: check lower ancestry on encode of lower dir file handle"
+
 _require_test
 _require_test_program "open_by_handle"
 # Use non-default scratch underlying overlay dirs, we need to check
diff --git a/tests/overlay/063 b/tests/overlay/063
index 94726000..f7bd46e4 100755
--- a/tests/overlay/063
+++ b/tests/overlay/063
@@ -17,6 +17,9 @@ _begin_fstest auto quick whiteout
 
 # real QA test starts here
 _supported_fs overlay
+_fixed_by_kernel_commit 5e1275808630 \
+	"ovl: check whiteout in ovl_create_over_whiteout()"
+
 _require_scratch
 
 # Remove all files from previous tests
diff --git a/tests/overlay/065 b/tests/overlay/065
index 5f3fe097..e1bed4c7 100755
--- a/tests/overlay/065
+++ b/tests/overlay/065
@@ -38,6 +38,10 @@ _cleanup()
 
 # real QA test starts here
 _supported_fs overlay
+_fixed_in_kernel_version "v5.2"
+_fixed_by_kernel_commit 0be0bfd2de9d \
+	"ovl: fix regression caused by overlapping layers detection"
+
 # Use non-default scratch underlying overlay dirs, we need to check
 # them explicity after test.
 _require_scratch_nocheck
diff --git a/tests/overlay/067 b/tests/overlay/067
index 7dddb265..3f54a418 100755
--- a/tests/overlay/067
+++ b/tests/overlay/067
@@ -20,6 +20,9 @@ _begin_fstest auto quick copyup nonsamefs
 
 # real QA test starts here
 _supported_fs overlay
+_fixed_by_kernel_commit 9c6d8f13e9da \
+	"ovl: fix corner case of non-unique st_dev;st_ino"
+
 # Use non-default scratch underlying overlay dirs, we need to check
 # them explicity after test.
 _require_scratch_nocheck
diff --git a/tests/overlay/070 b/tests/overlay/070
index d433279a..a4ec2f03 100755
--- a/tests/overlay/070
+++ b/tests/overlay/070
@@ -8,7 +8,7 @@
 # nested overlay setup, where all layers of both overlays are on the
 # same fs.
 #
-# This simple test demonstrates a known issue with overlayfs:
+# This simple test demonstrates an issue with overlayfs on kernel < v4.17:
 # - stat file A shows inode number X
 # - modify A to trigger copy up
 # - stat file A shows inode number Y != X
@@ -35,6 +35,8 @@ _cleanup()
 
 # real QA test starts here
 _supported_fs overlay
+_fixed_in_kernel_version "v4.17"
+
 _require_scratch_nocheck
 _require_test_program "af_unix"
 _require_test_program "t_dir_type"
diff --git a/tests/overlay/071 b/tests/overlay/071
index 2ef28369..c22e3880 100755
--- a/tests/overlay/071
+++ b/tests/overlay/071
@@ -7,7 +7,7 @@
 # This is a variant of overlay/017 to test constant st_ino numbers for
 # nested overlay setup, where lower overlay layers are not on the same fs.
 #
-# This simple test demonstrates a known issue with overlayfs:
+# This simple test demonstrates an issue with overlayfs on kernel < v4.17:
 # - stat file A shows inode number X
 # - modify A to trigger copy up
 # - stat file A shows inode number Y != X
@@ -38,6 +38,8 @@ _cleanup()
 
 # real QA test starts here
 _supported_fs overlay
+_fixed_in_kernel_version "v4.17"
+
 _require_test
 _require_scratch_nocheck
 _require_test_program "af_unix"
diff --git a/tests/overlay/072 b/tests/overlay/072
index bdb608ff..6f5e77df 100755
--- a/tests/overlay/072
+++ b/tests/overlay/072
@@ -28,6 +28,8 @@ _begin_fstest auto quick copyup hardlink
 
 # real QA test starts here
 _supported_fs overlay
+_fixed_by_kernel_commit 83552eacdfc0 "ovl: fix WARN_ON nlink drop to zero"
+
 _require_scratch
 
 upperdir=$OVL_BASE_SCRATCH_MNT/$OVL_UPPER
diff --git a/tests/overlay/074 b/tests/overlay/074
index 833e7919..d3738649 100755
--- a/tests/overlay/074
+++ b/tests/overlay/074
@@ -22,6 +22,11 @@ _begin_fstest auto quick exportfs dangerous
 # real QA test starts here
 
 _supported_fs overlay
+_fixed_by_kernel_commit 144da23beab8 \
+	"ovl: return required buffer size for file handles"
+_fixed_by_kernel_commit 9aafc1b01873 \
+	"ovl: potential crash in ovl_fid_to_fh()"
+
 _require_scratch
 _require_test_program "open_by_handle"
 # We need to require all features together, because nfs_export cannot
diff --git a/tests/overlay/077 b/tests/overlay/077
index d22a1a94..702ff54c 100755
--- a/tests/overlay/077
+++ b/tests/overlay/077
@@ -18,6 +18,11 @@ _begin_fstest auto quick dir
 
 # real QA test starts here
 _supported_fs overlay
+_fixed_by_kernel_commit 65cd913ec9d9 \
+	"ovl: invalidate readdir cache on changes to dir with origin"
+_fixed_by_kernel_commit 9011c2791e63 \
+	"ovl: skip stale entries in merge dir cache iteration"
+
 _require_scratch_nocheck
 
 # Use small getdents bufsize to fit less than 10 entries
diff --git a/tests/overlay/078 b/tests/overlay/078
index 9e9be03f..3c15f4b7 100755
--- a/tests/overlay/078
+++ b/tests/overlay/078
@@ -33,6 +33,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_fs overlay
+_fixed_in_kernel_version "v5.13"
 
 _require_command "$LSATTR_PROG" lasttr
 _require_command "$CHATTR_PROG" chattr
-- 
2.25.1

