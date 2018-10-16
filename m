Received: from szxga04-in.huawei.com ([45.249.212.190]:14077 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726962AbeJPPVn (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 16 Oct 2018 11:21:43 -0400
From: "zhangyi (F)" <yi.zhang@huawei.com>
Subject: [PATCH v2 1/4] overlay: correct fsck.overlay exit code
Date: Tue, 16 Oct 2018 15:45:56 +0800
Message-ID: <20181016074559.24728-2-yi.zhang@huawei.com>
In-Reply-To: <20181016074559.24728-1-yi.zhang@huawei.com>
References: <20181016074559.24728-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org, amir73il@gmail.com
Cc: guaneryu@gmail.com, miklos@szeredi.hu, yi.zhang@huawei.com, miaoxie@huawei.com
List-ID: <fstests@vger.kernel.org>

fsck.overlay should return correct exit code to show the file system
status after fsck, instead of return 0 means consistency and !0 means
inconsistency or something bad happened.

Fix the following three exit code after running fsck.overlay:

- Return FSCK_OK if the input file system is consistent,
- Return FSCK_NONDESTRUCT if the file system inconsistent errors
  corrected,
- Return FSCK_UNCORRECTED if the file system still have inconsistent
  errors.

This patch also add a helper function to run fsck.overlay and check
the return value is expected or not.

Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
---
 common/overlay    | 29 +++++++++++++++++++++++++++++
 tests/overlay/045 | 27 +++++++++------------------
 tests/overlay/046 | 36 ++++++++++++------------------------
 tests/overlay/056 |  9 +++------
 4 files changed, 53 insertions(+), 48 deletions(-)

diff --git a/common/overlay b/common/overlay
index b526f24..4cc2829 100644
--- a/common/overlay
+++ b/common/overlay
@@ -12,6 +12,16 @@ export OVL_XATTR_NLINK="trusted.overlay.nlink"
 export OVL_XATTR_UPPER="trusted.overlay.upper"
 export OVL_XATTR_METACOPY="trusted.overlay.metacopy"
 
+# Export exit code used by fsck.overlay program
+export FSCK_OK=0
+export FSCK_NONDESTRUCT=1
+export FSCK_REBOOT=2
+export FSCK_UNCORRECTED=4
+export FSCK_ERROR=8
+export FSCK_USAGE=16
+export FSCK_CANCELED=32
+export FSCK_LIBRARY=128
+
 # helper function to do the actual overlayfs mount operation
 _overlay_mount_dirs()
 {
@@ -193,6 +203,25 @@ _overlay_fsck_dirs()
 			   -o workdir=$workdir $*
 }
 
+# Run fsck and check the return value
+_run_check_fsck()
+{
+	# The first arguments is the expected fsck program exit code, the
+	# remaining arguments are the input parameters of the fsck program.
+	local expect_ret=$1
+	local lowerdir=$2
+	local upperdir=$3
+	local workdir=$4
+	shift 4
+
+	_overlay_fsck_dirs $lowerdir $upperdir $workdir $* >> \
+			$seqres.full 2>&1
+	fsck_ret=$?
+
+	[[ "$fsck_ret" == "$expect_ret" ]] || \
+		echo "fsck return unexpected value:$expect_ret,$fsck_ret"
+}
+
 _overlay_check_dirs()
 {
 	local lowerdir=$1
diff --git a/tests/overlay/045 b/tests/overlay/045
index acc7087..ed23258 100755
--- a/tests/overlay/045
+++ b/tests/overlay/045
@@ -96,8 +96,7 @@ echo "+ Orphan whiteout"
 make_test_dirs
 make_whiteout $lowerdir/foo $upperdir/{foo,bar}
 
-_overlay_fsck_dirs $lowerdir $upperdir $workdir -p >> $seqres.full 2>&1 || \
-	echo "fsck should not fail"
+_run_check_fsck $FSCK_NONDESTRUCT $lowerdir $upperdir $workdir -p
 ls $lowerdir
 ls $upperdir
 
@@ -107,8 +106,7 @@ make_test_dirs
 touch $lowerdir2/{foo,bar}
 make_whiteout $upperdir/foo $lowerdir/bar
 
-_overlay_fsck_dirs "$lowerdir:$lowerdir2" $upperdir $workdir -p >> \
-	 $seqres.full 2>&1 || echo "fsck should not fail"
+_run_check_fsck $FSCK_OK "$lowerdir:$lowerdir2" $upperdir $workdir -p
 check_whiteout $upperdir/foo $lowerdir/bar
 
 # Test orphan whiteout in opaque directory, should remove
@@ -119,8 +117,7 @@ touch $lowerdir/testdir/foo
 make_opaque_dir $upperdir/testdir
 make_whiteout $upperdir/testdir/foo
 
-_overlay_fsck_dirs $lowerdir $upperdir $workdir -p >> $seqres.full 2>&1 || \
-	echo "fsck should not fail"
+_run_check_fsck $FSCK_NONDESTRUCT $lowerdir $upperdir $workdir -p
 ls $upperdir/testdir
 
 # Test orphan whiteout whose parent path is not an merged directory,
@@ -135,8 +132,7 @@ make_whiteout $lowerdir/testdir2
 make_opaque_dir $lowerdir/testdir3
 make_whiteout $upperdir/{testdir1/foo,/testdir2/foo,testdir3/foo,testdir4/foo}
 
-_overlay_fsck_dirs "$lowerdir:$lowerdir2" $upperdir $workdir -p >> \
-	$seqres.full 2>&1 || echo "fsck should not fail"
+_run_check_fsck $FSCK_NONDESTRUCT "$lowerdir:$lowerdir2" $upperdir $workdir -p
 ls $upperdir/testdir1
 ls $upperdir/testdir2
 ls $upperdir/testdir3
@@ -150,8 +146,7 @@ touch $lowerdir/testdir/foo
 make_redirect_dir $upperdir/testdir "origin"
 make_whiteout $upperdir/testdir/foo
 
-_overlay_fsck_dirs $lowerdir $upperdir $workdir -p >> $seqres.full 2>&1 || \
-	echo "fsck should not fail"
+_run_check_fsck $FSCK_NONDESTRUCT $lowerdir $upperdir $workdir -p
 ls $upperdir/testdir
 
 # Test valid whiteout in redirect directory cover file in lower
@@ -163,8 +158,7 @@ touch $lowerdir/origin/foo
 make_redirect_dir $upperdir/testdir "origin"
 make_whiteout $upperdir/testdir/foo
 
-_overlay_fsck_dirs $lowerdir $upperdir $workdir -p >> $seqres.full 2>&1 || \
-	echo "fsck should not fail"
+_run_check_fsck $FSCK_OK $lowerdir $upperdir $workdir -p
 check_whiteout $upperdir/testdir/foo
 
 # Test valid whiteout covering lower target whose parent directory
@@ -177,8 +171,7 @@ make_redirect_dir $lowerdir/testdir "origin"
 mkdir -p $upperdir/testdir/subdir
 make_whiteout $upperdir/testdir/subdir/foo
 
-_overlay_fsck_dirs "$lowerdir:$lowerdir2" $upperdir $workdir -p \
-	>> $seqres.full 2>&1 || echo "fsck should not fail"
+_run_check_fsck $FSCK_OK "$lowerdir:$lowerdir2" $upperdir $workdir -p
 check_whiteout $upperdir/testdir/subdir/foo
 
 # Test invalid whiteout in opaque subdirectory in a redirect directory,
@@ -191,8 +184,7 @@ make_redirect_dir $upperdir/testdir "origin"
 make_opaque_dir $upperdir/testdir/subdir
 make_whiteout $upperdir/testdir/subdir/foo
 
-_overlay_fsck_dirs $lowerdir $upperdir $workdir -p >> $seqres.full 2>&1 || \
-	echo "fsck should not fail"
+_run_check_fsck $FSCK_NONDESTRUCT $lowerdir $upperdir $workdir -p
 ls $upperdir/testdir/subdir
 
 # Test valid whiteout in reidrect subdirectory in a opaque directory
@@ -205,8 +197,7 @@ make_opaque_dir $upperdir/testdir
 make_redirect_dir $upperdir/testdir/subdir "/origin"
 make_whiteout $upperdir/testdir/subdir/foo
 
-_overlay_fsck_dirs $lowerdir $upperdir $workdir -p >> $seqres.full 2>&1 || \
-        echo "fsck should not fail"
+_run_check_fsck $FSCK_OK $lowerdir $upperdir $workdir -p
 check_whiteout $upperdir/testdir/subdir/foo
 
 # success, all done
diff --git a/tests/overlay/046 b/tests/overlay/046
index 6338a38..21645c1 100755
--- a/tests/overlay/046
+++ b/tests/overlay/046
@@ -121,8 +121,7 @@ echo "+ Invalid redirect"
 make_test_dirs
 make_redirect_dir $upperdir/testdir "invalid"
 
-_overlay_fsck_dirs $lowerdir $upperdir $workdir -p >> $seqres.full 2>&1 || \
-	echo "fsck should not fail"
+_run_check_fsck $FSCK_NONDESTRUCT $lowerdir $upperdir $workdir -p
 check_no_redirect $upperdir/testdir
 
 # Test invalid redirect xattr point to a file origin, should remove
@@ -131,8 +130,7 @@ make_test_dirs
 touch $lowerdir/origin
 make_redirect_dir $upperdir/testdir "origin"
 
-_overlay_fsck_dirs $lowerdir $upperdir $workdir -p >> $seqres.full 2>&1 || \
-	echo "fsck should not fail"
+_run_check_fsck $FSCK_NONDESTRUCT $lowerdir $upperdir $workdir -p
 check_no_redirect $upperdir/testdir
 
 # Test valid redirect xattr point to a directory origin in the same directory,
@@ -143,8 +141,7 @@ mkdir $lowerdir/origin
 make_whiteout $upperdir/origin
 make_redirect_dir $upperdir/testdir "origin"
 
-_overlay_fsck_dirs $lowerdir $upperdir $workdir -p >> $seqres.full 2>&1 || \
-	echo "fsck should not fail"
+_run_check_fsck $FSCK_OK $lowerdir $upperdir $workdir -p
 check_redirect $upperdir/testdir "origin"
 
 # Test valid redirect xattr point to a directory origin in different directories
@@ -155,8 +152,7 @@ mkdir $lowerdir/origin
 make_whiteout $upperdir/origin
 make_redirect_dir $upperdir/testdir1/testdir2 "/origin"
 
-_overlay_fsck_dirs $lowerdir $upperdir $workdir -p >> $seqres.full 2>&1 || \
-	echo "fsck should not fail"
+_run_check_fsck $FSCK_OK $lowerdir $upperdir $workdir -p
 check_redirect $upperdir/testdir1/testdir2 "/origin"
 
 # Test valid redirect xattr but missing whiteout to cover lower target,
@@ -166,8 +162,7 @@ make_test_dirs
 mkdir $lowerdir/origin
 make_redirect_dir $upperdir/testdir "origin"
 
-_overlay_fsck_dirs $lowerdir $upperdir $workdir -p >> $seqres.full 2>&1 || \
-	echo "fsck should not fail"
+_run_check_fsck $FSCK_NONDESTRUCT $lowerdir $upperdir $workdir -p
 check_redirect $upperdir/testdir "origin"
 check_whiteout $upperdir/origin
 
@@ -178,8 +173,7 @@ mkdir $lowerdir/{testdir1,testdir2}
 make_redirect_dir $upperdir/testdir1 "testdir2"
 make_redirect_dir $upperdir/testdir2 "testdir1"
 
-_overlay_fsck_dirs $lowerdir $upperdir $workdir -p >> $seqres.full 2>&1 || \
-	echo "fsck should not fail"
+_run_check_fsck $FSCK_OK $lowerdir $upperdir $workdir -p
 check_redirect $upperdir/testdir1 "testdir2"
 check_redirect $upperdir/testdir2 "testdir1"
 
@@ -191,8 +185,7 @@ mkdir $lowerdir/testdir
 make_redirect_dir $upperdir/testdir "invalid"
 
 # Question get yes answer: Should set opaque dir ?
-_overlay_fsck_dirs $lowerdir $upperdir $workdir -y >> $seqres.full 2>&1 || \
-	echo "fsck should not fail"
+_run_check_fsck $FSCK_NONDESTRUCT $lowerdir $upperdir $workdir -y
 check_no_redirect $upperdir/testdir
 check_opaque $upperdir/testdir
 
@@ -205,12 +198,10 @@ make_redirect_dir $lowerdir/testdir1 "origin"
 make_redirect_dir $lowerdir/testdir2 "origin"
 make_redirect_dir $upperdir/testdir3 "origin"
 
-_overlay_fsck_dirs "$lowerdir:$lowerdir2" $upperdir $workdir -p >> \
-	$seqres.full 2>&1 && echo "fsck should fail"
+_run_check_fsck $FSCK_UNCORRECTED "$lowerdir:$lowerdir2" $upperdir $workdir -p
 
 # Question get yes answer: Duplicate redirect directory, remove xattr ?
-_overlay_fsck_dirs "$lowerdir:$lowerdir2" $upperdir $workdir -y >> \
-	$seqres.full 2>&1 || echo "fsck should not fail"
+_run_check_fsck $FSCK_NONDESTRUCT "$lowerdir:$lowerdir2" $upperdir $workdir -y
 redirect_1=`check_redirect $lowerdir/testdir1 "origin" 2>/dev/null`
 redirect_2=`check_redirect $lowerdir/testdir2 "origin" 2>/dev/null`
 [[ $redirect_1 == $redirect_2 ]] && echo "Redirect xattr incorrect"
@@ -223,12 +214,10 @@ make_test_dirs
 mkdir $lowerdir/origin $upperdir/origin
 make_redirect_dir $upperdir/testdir "origin"
 
-_overlay_fsck_dirs $lowerdir $upperdir $workdir -p >> $seqres.full 2>&1 && \
-	echo "fsck should fail"
+_run_check_fsck $FSCK_UNCORRECTED $lowerdir $upperdir $workdir -p
 
 # Question get yes answer: Duplicate redirect directory, remove xattr ?
-_overlay_fsck_dirs $lowerdir $upperdir $workdir -y >> $seqres.full 2>&1 || \
-	echo "fsck should not fail"
+_run_check_fsck $FSCK_NONDESTRUCT $lowerdir $upperdir $workdir -y
 check_no_redirect $upperdir/testdir
 
 # Test duplicate redirect xattr with lower same name directory exists,
@@ -240,8 +229,7 @@ make_redirect_dir $upperdir/testdir "invalid"
 
 # Question one get yes answer: Duplicate redirect directory, remove xattr?
 # Question two get yes answer: Should set opaque dir ?
-_overlay_fsck_dirs $lowerdir $upperdir $workdir -y >> $seqres.full 2>&1 || \
-	echo "fsck should not fail"
+_run_check_fsck $FSCK_NONDESTRUCT $lowerdir $upperdir $workdir -y
 check_no_redirect $upperdir/testdir
 check_opaque $upperdir/testdir
 
diff --git a/tests/overlay/056 b/tests/overlay/056
index 44ffb54..8679b55 100755
--- a/tests/overlay/056
+++ b/tests/overlay/056
@@ -96,8 +96,7 @@ $UMOUNT_PROG $SCRATCH_MNT
 remove_impure $upperdir/testdir1
 remove_impure $upperdir/testdir2
 
-_overlay_fsck_dirs $lowerdir $upperdir $workdir -p >> $seqres.full 2>&1 || \
-	echo "fsck should not fail"
+_run_check_fsck $FSCK_NONDESTRUCT $lowerdir $upperdir $workdir -p
 check_impure $upperdir/testdir1
 check_impure $upperdir/testdir2
 
@@ -108,8 +107,7 @@ make_test_dirs
 mkdir $lowerdir/origin
 make_redirect_dir $upperdir/testdir/subdir "/origin"
 
-_overlay_fsck_dirs $lowerdir $upperdir $workdir -p >> $seqres.full 2>&1 || \
-	echo "fsck should not fail"
+_run_check_fsck $FSCK_NONDESTRUCT $lowerdir $upperdir $workdir -p
 check_impure $upperdir/testdir
 
 # Test missing impure xattr in directory which has merge directories,
@@ -118,8 +116,7 @@ echo "+ Missing impure(3)"
 make_test_dirs
 mkdir $lowerdir/testdir $upperdir/testdir
 
-_overlay_fsck_dirs $lowerdir $upperdir $workdir -p >> $seqres.full 2>&1 || \
-	echo "fsck should not fail"
+_run_check_fsck $FSCK_NONDESTRUCT $lowerdir $upperdir $workdir -p
 check_impure $upperdir
 
 # success, all done
-- 
2.5.0
