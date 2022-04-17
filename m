Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2945AC433EF
	for <linux-fstests@archiver.kernel.org>; Sun, 17 Apr 2022 17:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbiDQRnO (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 17 Apr 2022 13:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234633AbiDQRnN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 17 Apr 2022 13:43:13 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEE42ED6F
        for <fstests@vger.kernel.org>; Sun, 17 Apr 2022 10:40:35 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id u3so16303047wrg.3
        for <fstests@vger.kernel.org>; Sun, 17 Apr 2022 10:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bv5Clvhy0rg8EVirJAR7ceUdDh2MX3Hs9RPnNFMdvGU=;
        b=NbWPej7dCfRcRLv5Ftx9KqJwSskataUktmFfX33NejisIpyTNJXljLOoi7075tohaJ
         S7vcb09P4bz0RArWWX30bgzZjVsFeYz+Kv9Kyio2Ex+MplCxJYi1sSaJ4T6EU9bwsvLJ
         4Qw8GDorxfRVN1vTHjfqdBbnBy6iFHPRV/r3v0cZYWHlE/EvfSHjUrJW0hXSWQ1P/9bp
         gs2TUvO0dYnJlqXgCgdHsYyCetvHrG62iN2fSXTFlzig58fuZD1nDv0tePeQGIcKj4AZ
         LK9Z/584bUNQCTvZu1bMMrsXoRrnCFUCRuxNYj4/L9z7AIJu6htA5AO4G9ZyVG9B7JR8
         MTsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bv5Clvhy0rg8EVirJAR7ceUdDh2MX3Hs9RPnNFMdvGU=;
        b=nCnj8sVrwgGw1Vh/lE1FY/G6SIpJlhxVN3Cxtb7FFW3vbMhTZGSl57xXwuRUp9RyA6
         5bGcoQC5v5qWwPu0QyMlMzH7YCvNMQ8DqRVOJXfoZjxKLa7+CWS08SUDC7owH0OoXaD+
         rJnezgSWccD+t6KeMezlwpwADhGw9uE1Tu3Cd4jlUHrCvHo88DE29dPFivAvekP3DJ77
         UFE6SwRwUuP1TY7bhII7nWgx7v0Lcii99KuNTxMm6nLeA21AwZIIr+KwynlkN9mM+2BV
         xTvBYsPklfuMkPvVMuS+xVdduIKSPl5iRuQI1cz3w1cJGH7OlskdYlBqzYnLrKRgHqwf
         8POA==
X-Gm-Message-State: AOAM530u00ZAe9T2SEtk5PQK241UuK4vSlEZ/t7nVYUoVNj6V7v8esip
        n9haMpXDFkGFCWXDWLgnvac=
X-Google-Smtp-Source: ABdhPJwTYNOGPwu3g2dN+KKXc1HsJgSN8jnTVC+RKNMZPYFj3noeNyilrzEZsEOc+jGHGm+Sa3CeNw==
X-Received: by 2002:a05:6000:716:b0:207:ac94:9459 with SMTP id bs22-20020a056000071600b00207ac949459mr6234789wrb.467.1650217234213;
        Sun, 17 Apr 2022 10:40:34 -0700 (PDT)
Received: from localhost.localdomain ([5.29.13.154])
        by smtp.gmail.com with ESMTPSA id v18-20020adfc5d2000000b0020589b76704sm9108564wrg.70.2022.04.17.10.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 10:40:33 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Eryu Guan <guaneryu@gmail.com>, Zorro Lang <zlang@redhat.com>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        Luis Chamberlain <mcgrof@kernel.org>, fstests@vger.kernel.org
Subject: [PATCH 2/3] common: print hints for reasons of test failures
Date:   Sun, 17 Apr 2022 20:40:22 +0300
Message-Id: <20220417174023.3244263-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220417174023.3244263-1-amir73il@gmail.com>
References: <20220417174023.3244263-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Introduce helpers _known_issue_before_kernel() and
_fixed_by_kernel_commit() that can be used to hint testers why a test
might be failing and aid in auto-generating of expunge lists for
downstream kernel testing.

Annotate fix kernel commits for some overlayfs tests and fix kernel
version for some overlayfs tests testing for legacy behavior whose
fixes are not likely to be backported to stable kernels.

This is modeled after LTP's 'make filter-known-fails' and
print_failure_hints() using struct tst_tag annotations.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 check             | 10 +++++++++-
 common/preamble   |  2 +-
 common/rc         | 14 ++++++++++++++
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
 28 files changed, 96 insertions(+), 9 deletions(-)

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
index 1d37dcbd..2e9dc408 100644
--- a/common/rc
+++ b/common/rc
@@ -1597,6 +1597,19 @@ _supported_fs()
 		_notrun "not suitable for this filesystem type: $FSTYP"
 }
 
+_known_issue_before_kernel()
+{
+	echo "HINT: You _MAY_ be hit by a known issue on kernel version < $1." >> $seqres.hints
+	echo >> $seqres.hints
+}
+
+_fixed_by_kernel_commit()
+{
+	echo "HINT: You _MAY_ be missing kernel fix:" >> $seqres.hints
+	echo "      $*" >> $seqres.hints
+	echo >> $seqres.hints
+}
+
 # check if a FS on a device is mounted
 # if so, verify that it is mounted on mount point
 # if fstype is given as argument, verify that it is also
@@ -4916,6 +4929,7 @@ _require_kernel_config()
 	_has_kernel_config $1 || _notrun "Installed kernel not built with $1"
 }
 
+
 init_rc
 
 ################################################################################
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
index 8a091615..d160ff49 100755
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
+_known_issue_before_kernel "v4.19"
+
 _require_scratch
 _require_xfs_io_command "open"
 
diff --git a/tests/overlay/017 b/tests/overlay/017
index 15b0d613..00ca126c 100755
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
+_known_issue_before_kernel "v4.14"
+
 _require_scratch
 _require_test_program "af_unix"
 _require_test_program "t_dir_type"
diff --git a/tests/overlay/018 b/tests/overlay/018
index b09bca9c..0d1cbfa5 100755
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
+_known_issue_before_kernel "v4.13"
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
index 145b4b34..7bde49ee 100755
--- a/tests/overlay/038
+++ b/tests/overlay/038
@@ -15,6 +15,8 @@ _begin_fstest auto quick copyup
 
 # real QA test starts here
 _supported_fs overlay
+_known_issue_before_kernel "v4.14"
+
 # Use non-default scratch underlying overlay dirs, we need to check
 # them explicity after test.
 _require_scratch_nocheck
diff --git a/tests/overlay/041 b/tests/overlay/041
index 762e7389..084aaad6 100755
--- a/tests/overlay/041
+++ b/tests/overlay/041
@@ -17,6 +17,8 @@ _begin_fstest auto quick copyup nonsamefs
 
 # real QA test starts here
 _supported_fs overlay
+_known_issue_before_kernel "v4.17"
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
index 383151dd..e6510ae5 100755
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
+_known_issue_before_kernel "v4.17"
+
 # Use non-default scratch underlying overlay dirs, we need to check
 # them explicity after test.
 _require_scratch_nocheck
diff --git a/tests/overlay/044 b/tests/overlay/044
index 3f54b7ea..b11f4359 100755
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
+_known_issue_before_kernel "v4.17"
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
index 5f3fe097..38430f86 100755
--- a/tests/overlay/065
+++ b/tests/overlay/065
@@ -38,6 +38,10 @@ _cleanup()
 
 # real QA test starts here
 _supported_fs overlay
+_known_issue_before_kernel "v5.2"
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
index d433279a..f7f926f9 100755
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
+_known_issue_before_kernel "v4.17"
+
 _require_scratch_nocheck
 _require_test_program "af_unix"
 _require_test_program "t_dir_type"
diff --git a/tests/overlay/071 b/tests/overlay/071
index 2ef28369..4f35a8d9 100755
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
+_known_issue_before_kernel "v4.17"
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
index 9e9be03f..d71f09bf 100755
--- a/tests/overlay/078
+++ b/tests/overlay/078
@@ -33,6 +33,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_fs overlay
+_known_issue_before_kernel "v5.13"
 
 _require_command "$LSATTR_PROG" lasttr
 _require_command "$CHATTR_PROG" chattr
-- 
2.35.1

