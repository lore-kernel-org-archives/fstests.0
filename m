Received: from imap.thunk.org ([74.207.234.97]:34544 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750987AbcBMRlQ (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sat, 13 Feb 2016 12:41:16 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 16/16] xfstests: remove _need_to_be_root
Date: Sat, 13 Feb 2016 12:41:09 -0500
Message-Id: <1455385269-26319-17-git-send-email-tytso@mit.edu>
In-Reply-To: <1455385269-26319-1-git-send-email-tytso@mit.edu>
References: <1455385269-26319-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: hughd@google.com, Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

The check script requires that it be run as root, so adding
individualized checks for this in each teat is not needed.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 README            |  4 ----
 common/dump       |  2 --
 common/rc         | 13 -------------
 tests/btrfs/002   |  1 -
 tests/btrfs/003   |  1 -
 tests/btrfs/004   |  1 -
 tests/btrfs/007   |  1 -
 tests/btrfs/011   |  1 -
 tests/btrfs/017   |  1 -
 tests/btrfs/025   |  1 -
 tests/btrfs/026   |  1 -
 tests/btrfs/029   |  1 -
 tests/btrfs/030   |  1 -
 tests/btrfs/031   |  1 -
 tests/btrfs/034   |  1 -
 tests/btrfs/037   |  1 -
 tests/btrfs/038   |  1 -
 tests/btrfs/039   |  1 -
 tests/btrfs/040   |  1 -
 tests/btrfs/041   |  1 -
 tests/btrfs/043   |  1 -
 tests/btrfs/044   |  1 -
 tests/btrfs/045   |  1 -
 tests/btrfs/046   |  1 -
 tests/btrfs/047   |  1 -
 tests/btrfs/048   |  1 -
 tests/btrfs/049   |  1 -
 tests/btrfs/050   |  1 -
 tests/btrfs/051   |  1 -
 tests/btrfs/052   |  1 -
 tests/btrfs/053   |  1 -
 tests/btrfs/054   |  1 -
 tests/btrfs/055   |  1 -
 tests/btrfs/056   |  1 -
 tests/btrfs/057   |  1 -
 tests/btrfs/058   |  1 -
 tests/btrfs/059   |  1 -
 tests/btrfs/076   |  1 -
 tests/btrfs/077   |  1 -
 tests/btrfs/078   |  1 -
 tests/btrfs/079   |  1 -
 tests/btrfs/080   |  1 -
 tests/btrfs/081   |  1 -
 tests/btrfs/083   |  1 -
 tests/btrfs/084   |  1 -
 tests/btrfs/085   |  1 -
 tests/btrfs/086   |  1 -
 tests/btrfs/087   |  1 -
 tests/btrfs/088   |  1 -
 tests/btrfs/089   |  1 -
 tests/btrfs/091   |  1 -
 tests/btrfs/092   |  1 -
 tests/btrfs/093   |  1 -
 tests/btrfs/094   |  1 -
 tests/btrfs/095   |  1 -
 tests/btrfs/096   |  1 -
 tests/btrfs/097   |  1 -
 tests/btrfs/098   |  1 -
 tests/btrfs/099   |  1 -
 tests/btrfs/100   |  1 -
 tests/btrfs/101   |  1 -
 tests/btrfs/102   |  1 -
 tests/btrfs/103   |  1 -
 tests/btrfs/104   |  1 -
 tests/btrfs/105   |  3 +--
 tests/btrfs/106   |  1 -
 tests/btrfs/107   |  1 -
 tests/btrfs/108   |  1 -
 tests/btrfs/109   |  1 -
 tests/btrfs/110   |  1 -
 tests/btrfs/111   |  1 -
 tests/btrfs/112   |  1 -
 tests/btrfs/113   |  1 -
 tests/btrfs/116   |  1 -
 tests/btrfs/117   |  1 -
 tests/ext4/271    |  1 -
 tests/ext4/301    |  1 -
 tests/ext4/302    |  1 -
 tests/ext4/303    |  1 -
 tests/ext4/304    |  1 -
 tests/ext4/307    |  1 -
 tests/ext4/308    |  1 -
 tests/generic/019 |  1 -
 tests/generic/026 |  1 -
 tests/generic/034 |  1 -
 tests/generic/037 |  1 -
 tests/generic/038 |  1 -
 tests/generic/039 |  1 -
 tests/generic/040 |  1 -
 tests/generic/041 |  1 -
 tests/generic/056 |  1 -
 tests/generic/057 |  1 -
 tests/generic/059 |  1 -
 tests/generic/065 |  1 -
 tests/generic/066 |  1 -
 tests/generic/071 |  1 -
 tests/generic/073 |  1 -
 tests/generic/090 |  1 -
 tests/generic/093 |  2 --
 tests/generic/098 |  1 -
 tests/generic/101 |  1 -
 tests/generic/102 |  1 -
 tests/generic/104 |  1 -
 tests/generic/106 |  1 -
 tests/generic/107 |  1 -
 tests/generic/177 |  1 -
 tests/generic/193 |  1 -
 tests/generic/230 |  1 -
 tests/generic/231 |  1 -
 tests/generic/232 |  1 -
 tests/generic/233 |  1 -
 tests/generic/234 |  1 -
 tests/generic/235 |  1 -
 tests/generic/237 |  1 -
 tests/generic/265 |  1 -
 tests/generic/266 |  1 -
 tests/generic/267 |  1 -
 tests/generic/268 |  1 -
 tests/generic/269 |  1 -
 tests/generic/270 |  1 -
 tests/generic/271 |  1 -
 tests/generic/272 |  1 -
 tests/generic/276 |  1 -
 tests/generic/278 |  1 -
 tests/generic/279 |  1 -
 tests/generic/281 |  1 -
 tests/generic/282 |  1 -
 tests/generic/283 |  1 -
 tests/generic/299 |  1 -
 tests/generic/300 |  1 -
 tests/generic/311 |  1 -
 tests/generic/314 |  1 -
 tests/generic/317 |  1 -
 tests/generic/318 |  1 -
 tests/generic/319 |  1 -
 tests/generic/321 |  1 -
 tests/generic/322 |  1 -
 tests/generic/324 |  1 -
 tests/generic/325 |  1 -
 tests/shared/002  |  1 -
 tests/shared/051  |  1 -
 tests/shared/272  |  1 -
 tests/xfs/003     |  2 --
 tests/xfs/004     |  1 -
 tests/xfs/067     |  1 -
 tests/xfs/114     |  1 -
 tests/xfs/189     |  1 -
 147 files changed, 1 insertion(+), 166 deletions(-)

diff --git a/README b/README
index 7fa0089..c0d966d 100644
--- a/README
+++ b/README
@@ -172,10 +172,6 @@ Test script environment:
      3. By default, tests are run as the same uid as the person
 	executing the control script "check" that runs the test scripts.
 
-	If you need to be root, add a call to the shell procedure
-	_need_to_be_root ... this will do nothing or exit with an
-	error message depending on your current uid.
-
      4. Some other useful shell procedures:
 
 	_get_fqdn		- echo the host's fully qualified
diff --git a/common/dump b/common/dump
index 2db7378..d6663e0 100644
--- a/common/dump
+++ b/common/dump
@@ -60,8 +60,6 @@ session_label="stress_$seq"
 nobody=4 # define this uid/gid as a number
 do_quota_check=true # do quota check if quotas enabled
 
-_need_to_be_root
-
 # install our cleaner
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
diff --git a/common/rc b/common/rc
index 0e5320f..370464b 100644
--- a/common/rc
+++ b/common/rc
@@ -1076,19 +1076,6 @@ _fix_malloc()
     '
 }
 
-# check if run as root
-#
-_need_to_be_root()
-{
-    id=`id | $SED_PROG -e 's/(.*//' -e 's/.*=//'`
-    if [ "$id" -ne 0 ]
-    then
-	echo "Arrgh ... you need to be root (not uid=$id) to run this test"
-	exit 1
-    fi
-}
-
-
 #
 # _df_device : get an IRIX style df line for a given device
 #
diff --git a/tests/btrfs/002 b/tests/btrfs/002
index 35e857b..fce5d95 100755
--- a/tests/btrfs/002
+++ b/tests/btrfs/002
@@ -41,7 +41,6 @@ trap "_cleanup ; exit \$status" 0 1 2 3 15
 . ./common/rc
 . ./common/filter
 
-_need_to_be_root
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch
diff --git a/tests/btrfs/003 b/tests/btrfs/003
index ae7e377..51cff46 100755
--- a/tests/btrfs/003
+++ b/tests/btrfs/003
@@ -46,7 +46,6 @@ _cleanup()
 . ./common/rc
 . ./common/filter
 
-_need_to_be_root
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch
diff --git a/tests/btrfs/004 b/tests/btrfs/004
index d588c5b..905770a 100755
--- a/tests/btrfs/004
+++ b/tests/btrfs/004
@@ -47,7 +47,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common/filter
 
 # real QA test starts here
-_need_to_be_root
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch
diff --git a/tests/btrfs/007 b/tests/btrfs/007
index 82d093a..57f9a79 100755
--- a/tests/btrfs/007
+++ b/tests/btrfs/007
@@ -47,7 +47,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common/filter
 
 # real QA test starts here
-_need_to_be_root
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch
diff --git a/tests/btrfs/011 b/tests/btrfs/011
index 72c53ab..91ddebb 100755
--- a/tests/btrfs/011
+++ b/tests/btrfs/011
@@ -59,7 +59,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common/filter
 
 # real QA test starts here
-_need_to_be_root
 _supported_fs btrfs
 _require_scratch_nocheck
 _require_scratch_dev_pool 4
diff --git a/tests/btrfs/017 b/tests/btrfs/017
index 34c5f0a..3f409d3 100755
--- a/tests/btrfs/017
+++ b/tests/btrfs/017
@@ -48,7 +48,6 @@ _cleanup()
 
 # real QA test starts here
 
-_need_to_be_root
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch
diff --git a/tests/btrfs/025 b/tests/btrfs/025
index 76ec2dd..81ae943 100755
--- a/tests/btrfs/025
+++ b/tests/btrfs/025
@@ -47,7 +47,6 @@ _cleanup()
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch
-_need_to_be_root
 
 rm -f $seqres.full
 
diff --git a/tests/btrfs/026 b/tests/btrfs/026
index 60908cc..876651d 100755
--- a/tests/btrfs/026
+++ b/tests/btrfs/026
@@ -42,7 +42,6 @@ _cleanup()
 . ./common/filter
 
 # real QA test starts here
-_need_to_be_root
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch
diff --git a/tests/btrfs/029 b/tests/btrfs/029
index 87c289b..c390c95 100755
--- a/tests/btrfs/029
+++ b/tests/btrfs/029
@@ -55,7 +55,6 @@ _supported_os Linux
 _require_test
 _require_scratch
 _require_cp_reflink
-_need_to_be_root
 
 reflink_test_dir=$TEST_DIR/test-$seq
 rm -rf $reflink_test_dir
diff --git a/tests/btrfs/030 b/tests/btrfs/030
index a76a410..a8e08f6 100755
--- a/tests/btrfs/030
+++ b/tests/btrfs/030
@@ -54,7 +54,6 @@ _supported_fs btrfs
 _supported_os Linux
 _require_scratch
 _require_fssum
-_need_to_be_root
 
 rm -f $seqres.full
 
diff --git a/tests/btrfs/031 b/tests/btrfs/031
index fe8cd4e..c2b11dd 100755
--- a/tests/btrfs/031
+++ b/tests/btrfs/031
@@ -52,7 +52,6 @@ _supported_os Linux
 _require_test
 _require_scratch
 _require_cp_reflink
-_need_to_be_root
 
 _checksum_files()
 {
diff --git a/tests/btrfs/034 b/tests/btrfs/034
index 38952a3..179c827 100755
--- a/tests/btrfs/034
+++ b/tests/btrfs/034
@@ -44,7 +44,6 @@ _cleanup()
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch
-_need_to_be_root
 
 rm -f $seqres.full
 
diff --git a/tests/btrfs/037 b/tests/btrfs/037
index 2591a33..5c0ea66 100755
--- a/tests/btrfs/037
+++ b/tests/btrfs/037
@@ -51,7 +51,6 @@ _cleanup()
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch
-_need_to_be_root
 
 rm -f $seqres.full
 
diff --git a/tests/btrfs/038 b/tests/btrfs/038
index 4941d3e..d75ed48 100755
--- a/tests/btrfs/038
+++ b/tests/btrfs/038
@@ -50,7 +50,6 @@ _supported_fs btrfs
 _supported_os Linux
 _require_scratch
 _require_fssum
-_need_to_be_root
 
 rm -f $seqres.full
 
diff --git a/tests/btrfs/039 b/tests/btrfs/039
index 758b23c..ac7144f 100755
--- a/tests/btrfs/039
+++ b/tests/btrfs/039
@@ -53,7 +53,6 @@ _supported_fs btrfs
 _supported_os Linux
 _require_scratch
 _require_fssum
-_need_to_be_root
 
 rm -f $seqres.full
 
diff --git a/tests/btrfs/040 b/tests/btrfs/040
index dfd495c..c97ed50 100755
--- a/tests/btrfs/040
+++ b/tests/btrfs/040
@@ -53,7 +53,6 @@ _supported_fs btrfs
 _supported_os Linux
 _require_scratch
 _require_fssum
-_need_to_be_root
 
 rm -f $seqres.full
 
diff --git a/tests/btrfs/041 b/tests/btrfs/041
index 9639787..8bb74cd 100755
--- a/tests/btrfs/041
+++ b/tests/btrfs/041
@@ -53,7 +53,6 @@ _supported_fs btrfs
 _supported_os Linux
 _require_test
 _require_scratch
-_need_to_be_root
 
 rm -f $seqres.full
 mkdir $restore_dir
diff --git a/tests/btrfs/043 b/tests/btrfs/043
index 4993349..1ba5acd 100755
--- a/tests/btrfs/043
+++ b/tests/btrfs/043
@@ -49,7 +49,6 @@ _supported_fs btrfs
 _supported_os Linux
 _require_scratch
 _require_fssum
-_need_to_be_root
 
 rm -f $seqres.full
 
diff --git a/tests/btrfs/044 b/tests/btrfs/044
index 5565b86..9d6d212 100755
--- a/tests/btrfs/044
+++ b/tests/btrfs/044
@@ -54,7 +54,6 @@ _supported_fs btrfs
 _supported_os Linux
 _require_scratch
 _require_fssum
-_need_to_be_root
 
 rm -f $seqres.full
 
diff --git a/tests/btrfs/045 b/tests/btrfs/045
index 8570fa6..bdafbab 100755
--- a/tests/btrfs/045
+++ b/tests/btrfs/045
@@ -70,7 +70,6 @@ _supported_fs btrfs
 _supported_os Linux
 _require_scratch
 _require_fssum
-_need_to_be_root
 
 rm -f $seqres.full
 
diff --git a/tests/btrfs/046 b/tests/btrfs/046
index 288fb7f..6bf5000 100755
--- a/tests/btrfs/046
+++ b/tests/btrfs/046
@@ -54,7 +54,6 @@ _supported_os Linux
 _require_test
 _require_scratch
 _require_fssum
-_need_to_be_root
 
 rm -f $seqres.full
 rm -fr $send_files_dir
diff --git a/tests/btrfs/047 b/tests/btrfs/047
index 2c50bf6..6d7d351 100755
--- a/tests/btrfs/047
+++ b/tests/btrfs/047
@@ -62,7 +62,6 @@ _require_scratch
 _require_fssum
 _require_xfs_io_command "fiemap"
 _require_btrfs_send_stream_version
-_need_to_be_root
 
 send_files_dir=$TEST_DIR/btrfs-test-$seq
 
diff --git a/tests/btrfs/048 b/tests/btrfs/048
index dc7386d..c2cb4a6 100755
--- a/tests/btrfs/048
+++ b/tests/btrfs/048
@@ -48,7 +48,6 @@ _supported_os Linux
 _require_test
 _require_scratch
 _require_btrfs "property"
-_need_to_be_root
 
 send_files_dir=$TEST_DIR/btrfs-test-$seq
 
diff --git a/tests/btrfs/049 b/tests/btrfs/049
index 38ed7ad..4ec5dd8 100755
--- a/tests/btrfs/049
+++ b/tests/btrfs/049
@@ -48,7 +48,6 @@ _cleanup()
 # real QA test starts here
 _supported_fs btrfs
 _supported_os Linux
-_need_to_be_root
 _require_scratch
 _require_dm_target flakey
 
diff --git a/tests/btrfs/050 b/tests/btrfs/050
index b72408a..9a1f5e4 100755
--- a/tests/btrfs/050
+++ b/tests/btrfs/050
@@ -54,7 +54,6 @@ _supported_os Linux
 _require_test
 _require_scratch
 _require_fssum
-_need_to_be_root
 
 send_files_dir=$TEST_DIR/btrfs-test-$seq
 
diff --git a/tests/btrfs/051 b/tests/btrfs/051
index 1ddfb74..9ffbde3 100755
--- a/tests/btrfs/051
+++ b/tests/btrfs/051
@@ -51,7 +51,6 @@ _supported_os Linux
 _require_test
 _require_scratch
 _require_fssum
-_need_to_be_root
 
 send_files_dir=$TEST_DIR/btrfs-test-$seq
 
diff --git a/tests/btrfs/052 b/tests/btrfs/052
index babc127..599d261 100755
--- a/tests/btrfs/052
+++ b/tests/btrfs/052
@@ -45,7 +45,6 @@ _supported_fs btrfs
 _supported_os Linux
 _require_scratch
 _require_cloner
-_need_to_be_root
 
 rm -f $seqres.full
 
diff --git a/tests/btrfs/053 b/tests/btrfs/053
index 43a831c..06dcaff 100755
--- a/tests/btrfs/053
+++ b/tests/btrfs/053
@@ -54,7 +54,6 @@ _require_test
 _require_scratch
 _require_fssum
 _require_attrs
-_need_to_be_root
 
 # max(16384, PAGE_SIZE) is the default leaf/node size on btrfs-progs v3.12+.
 # Older versions just use max(4096, PAGE_SIZE).
diff --git a/tests/btrfs/054 b/tests/btrfs/054
index 33241b0..606fb40 100755
--- a/tests/btrfs/054
+++ b/tests/btrfs/054
@@ -60,7 +60,6 @@ _supported_fs btrfs
 _supported_os Linux
 _require_test
 _require_scratch
-_need_to_be_root
 
 send_files_dir=$TEST_DIR/btrfs-test-$seq
 
diff --git a/tests/btrfs/055 b/tests/btrfs/055
index 1f50850..29afdba 100755
--- a/tests/btrfs/055
+++ b/tests/btrfs/055
@@ -51,7 +51,6 @@ _require_scratch
 _require_cloner
 _require_btrfs_fs_feature "no_holes"
 _require_btrfs_mkfs_feature "no-holes"
-_need_to_be_root
 
 rm -f $seqres.full
 
diff --git a/tests/btrfs/056 b/tests/btrfs/056
index 6dc3bfd..ef515a1 100755
--- a/tests/btrfs/056
+++ b/tests/btrfs/056
@@ -56,7 +56,6 @@ _require_cloner
 _require_btrfs_fs_feature "no_holes"
 _require_btrfs_mkfs_feature "no-holes"
 _require_dm_target flakey
-_need_to_be_root
 
 rm -f $seqres.full
 
diff --git a/tests/btrfs/057 b/tests/btrfs/057
index 605bd02..8d35579 100755
--- a/tests/btrfs/057
+++ b/tests/btrfs/057
@@ -42,7 +42,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common/filter
 
 # real QA test starts here
-_need_to_be_root
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch
diff --git a/tests/btrfs/058 b/tests/btrfs/058
index 4d45686..ecfe857 100755
--- a/tests/btrfs/058
+++ b/tests/btrfs/058
@@ -56,7 +56,6 @@ _require_scratch
 # Requiring flink command tests for the presence of the -T option used
 # to pass O_TMPFILE to open(2).
 _require_xfs_io_command "flink"
-_need_to_be_root
 
 rm -f $seqres.full
 
diff --git a/tests/btrfs/059 b/tests/btrfs/059
index 3379ead..b9a6ef4 100755
--- a/tests/btrfs/059
+++ b/tests/btrfs/059
@@ -51,7 +51,6 @@ _supported_os Linux
 _require_test
 _require_scratch
 _require_btrfs "property"
-_need_to_be_root
 
 rm -f $seqres.full
 
diff --git a/tests/btrfs/076 b/tests/btrfs/076
index 16d674d..1c86d81 100755
--- a/tests/btrfs/076
+++ b/tests/btrfs/076
@@ -50,7 +50,6 @@ _supported_fs btrfs
 _supported_os Linux
 _require_test
 _require_scratch
-_need_to_be_root
 
 rm -f $seqres.full
 
diff --git a/tests/btrfs/077 b/tests/btrfs/077
index fdaaf9e..e56fe5b 100755
--- a/tests/btrfs/077
+++ b/tests/btrfs/077
@@ -58,7 +58,6 @@ _supported_fs btrfs
 _supported_os Linux
 _require_scratch
 _require_fssum
-_need_to_be_root
 
 send_files_dir=$TEST_DIR/btrfs-test-$seq
 
diff --git a/tests/btrfs/078 b/tests/btrfs/078
index 48de357..2c1dfa3 100755
--- a/tests/btrfs/078
+++ b/tests/btrfs/078
@@ -48,7 +48,6 @@ _cleanup()
 . ./common/filter
 
 # real QA test starts here
-_need_to_be_root
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch
diff --git a/tests/btrfs/079 b/tests/btrfs/079
index 4f59ff9..6aee3a3 100755
--- a/tests/btrfs/079
+++ b/tests/btrfs/079
@@ -58,7 +58,6 @@ _cleanup()
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch
-_need_to_be_root
 # Since xfs_io's fiemap always use SYNC flag and can't be unset,
 # we must use filefrag to call fiemap without SYNC flag.
 _require_command "/usr/sbin/filefrag" filefrag
diff --git a/tests/btrfs/080 b/tests/btrfs/080
index a5d3b38..b1474d1 100755
--- a/tests/btrfs/080
+++ b/tests/btrfs/080
@@ -53,7 +53,6 @@ _cleanup()
 . ./common/filter
 
 # real QA test starts here
-_need_to_be_root
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch_nocheck
diff --git a/tests/btrfs/081 b/tests/btrfs/081
index 40fa426..c367a01 100755
--- a/tests/btrfs/081
+++ b/tests/btrfs/081
@@ -50,7 +50,6 @@ _cleanup()
 . ./common/filter
 
 # real QA test starts here
-_need_to_be_root
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch
diff --git a/tests/btrfs/083 b/tests/btrfs/083
index e4b6767..47fc3e7 100755
--- a/tests/btrfs/083
+++ b/tests/btrfs/083
@@ -52,7 +52,6 @@ _supported_fs btrfs
 _supported_os Linux
 _require_scratch
 _require_fssum
-_need_to_be_root
 
 send_files_dir=$TEST_DIR/btrfs-test-$seq
 
diff --git a/tests/btrfs/084 b/tests/btrfs/084
index a9e26be..55e989a 100755
--- a/tests/btrfs/084
+++ b/tests/btrfs/084
@@ -51,7 +51,6 @@ _supported_fs btrfs
 _supported_os Linux
 _require_scratch
 _require_fssum
-_need_to_be_root
 
 send_files_dir=$TEST_DIR/btrfs-test-$seq
 
diff --git a/tests/btrfs/085 b/tests/btrfs/085
index d82f79a..3dbc67f 100755
--- a/tests/btrfs/085
+++ b/tests/btrfs/085
@@ -55,7 +55,6 @@ _supported_fs btrfs
 _supported_os Linux
 _require_scratch
 _require_dm_target flakey
-_need_to_be_root
 
 BTRFS_DEBUG_TREE_PROG="`set_prog_path btrfs-debug-tree`"
 _require_command "$BTRFS_DEBUG_TREE_PROG" btrfs-debug-tree
diff --git a/tests/btrfs/086 b/tests/btrfs/086
index 77c8da6..ea5489b 100755
--- a/tests/btrfs/086
+++ b/tests/btrfs/086
@@ -53,7 +53,6 @@ _supported_fs btrfs
 _supported_os Linux
 _require_scratch
 _require_cloner
-_need_to_be_root
 
 rm -f $seqres.full
 
diff --git a/tests/btrfs/087 b/tests/btrfs/087
index b8ee3e1..b4a62e5 100755
--- a/tests/btrfs/087
+++ b/tests/btrfs/087
@@ -57,7 +57,6 @@ _supported_fs btrfs
 _supported_os Linux
 _require_scratch
 _require_fssum
-_need_to_be_root
 
 send_files_dir=$TEST_DIR/btrfs-test-$seq
 
diff --git a/tests/btrfs/088 b/tests/btrfs/088
index 79268ec..7b8e128 100755
--- a/tests/btrfs/088
+++ b/tests/btrfs/088
@@ -51,7 +51,6 @@ _supported_fs btrfs
 _supported_os Linux
 _require_scratch
 _require_fail_make_request
-_need_to_be_root
 
 SYSFS_BDEV=`_sysfs_dev $SCRATCH_DEV`
 
diff --git a/tests/btrfs/089 b/tests/btrfs/089
index 5372698..db7d511 100755
--- a/tests/btrfs/089
+++ b/tests/btrfs/089
@@ -46,7 +46,6 @@ _cleanup()
 # real QA test starts here
 
 # Modify as appropriate.
-_need_to_be_root
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch
diff --git a/tests/btrfs/091 b/tests/btrfs/091
index feac551..16b5c16 100755
--- a/tests/btrfs/091
+++ b/tests/btrfs/091
@@ -43,7 +43,6 @@ _cleanup()
 
 # real QA test starts here
 
-_need_to_be_root
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch
diff --git a/tests/btrfs/092 b/tests/btrfs/092
index d727493..71fceec 100755
--- a/tests/btrfs/092
+++ b/tests/btrfs/092
@@ -56,7 +56,6 @@ _supported_fs btrfs
 _supported_os Linux
 _require_scratch
 _require_fssum
-_need_to_be_root
 
 send_files_dir=$TEST_DIR/btrfs-test-$seq
 
diff --git a/tests/btrfs/093 b/tests/btrfs/093
index 643c6be..64b7aa2 100755
--- a/tests/btrfs/093
+++ b/tests/btrfs/093
@@ -50,7 +50,6 @@ _supported_fs btrfs
 _supported_os Linux
 _require_scratch
 _require_cloner
-_need_to_be_root
 
 rm -f $seqres.full
 
diff --git a/tests/btrfs/094 b/tests/btrfs/094
index 45f108d..52b7ed2 100755
--- a/tests/btrfs/094
+++ b/tests/btrfs/094
@@ -56,7 +56,6 @@ _supported_fs btrfs
 _supported_os Linux
 _require_scratch
 _require_cloner
-_need_to_be_root
 
 send_files_dir=$TEST_DIR/btrfs-test-$seq
 
diff --git a/tests/btrfs/095 b/tests/btrfs/095
index dec530c..b477b57 100755
--- a/tests/btrfs/095
+++ b/tests/btrfs/095
@@ -48,7 +48,6 @@ _cleanup()
 . ./common/dmflakey
 
 # real QA test starts here
-_need_to_be_root
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch
diff --git a/tests/btrfs/096 b/tests/btrfs/096
index 896a209..039e09d 100755
--- a/tests/btrfs/096
+++ b/tests/btrfs/096
@@ -40,7 +40,6 @@ _cleanup()
 . ./common/filter
 
 # real QA test starts here
-_need_to_be_root
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch
diff --git a/tests/btrfs/097 b/tests/btrfs/097
index d1cfff1..4b4dd18 100755
--- a/tests/btrfs/097
+++ b/tests/btrfs/097
@@ -46,7 +46,6 @@ _supported_fs btrfs
 _supported_os Linux
 _require_scratch
 _require_cloner
-_need_to_be_root
 
 send_files_dir=$TEST_DIR/btrfs-test-$seq
 
diff --git a/tests/btrfs/098 b/tests/btrfs/098
index 49f6d16..f916c37 100755
--- a/tests/btrfs/098
+++ b/tests/btrfs/098
@@ -44,7 +44,6 @@ _cleanup()
 . ./common/dmflakey
 
 # real QA test starts here
-_need_to_be_root
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch
diff --git a/tests/btrfs/099 b/tests/btrfs/099
index 05e1ad2..70f07b5 100755
--- a/tests/btrfs/099
+++ b/tests/btrfs/099
@@ -46,7 +46,6 @@ _cleanup()
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch
-_need_to_be_root
 
 # Use big blocksize to ensure there is still enough space left for metadata
 # space reserve.
diff --git a/tests/btrfs/100 b/tests/btrfs/100
index cd385e1..38f53f8 100755
--- a/tests/btrfs/100
+++ b/tests/btrfs/100
@@ -44,7 +44,6 @@ _cleanup()
 
 _supported_fs btrfs
 _supported_os Linux
-_need_to_be_root
 _require_scratch_dev_pool 3
 _require_dm_target error
 
diff --git a/tests/btrfs/101 b/tests/btrfs/101
index 8d7af85..ed91457 100755
--- a/tests/btrfs/101
+++ b/tests/btrfs/101
@@ -44,7 +44,6 @@ _cleanup()
 
 _supported_fs btrfs
 _supported_os Linux
-_need_to_be_root
 _require_scratch_dev_pool 3
 _require_btrfs_dev_del_by_devid
 _require_dm_target error
diff --git a/tests/btrfs/102 b/tests/btrfs/102
index 9f0bea0..7a33c6b 100755
--- a/tests/btrfs/102
+++ b/tests/btrfs/102
@@ -41,7 +41,6 @@ _cleanup()
 . ./common/filter
 
 # real QA test starts here
-_need_to_be_root
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch
diff --git a/tests/btrfs/103 b/tests/btrfs/103
index a5a252a..caa979a 100755
--- a/tests/btrfs/103
+++ b/tests/btrfs/103
@@ -41,7 +41,6 @@ _cleanup()
 . ./common/filter
 
 # real QA test starts here
-_need_to_be_root
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch
diff --git a/tests/btrfs/104 b/tests/btrfs/104
index efc0d74..6afaa02 100755
--- a/tests/btrfs/104
+++ b/tests/btrfs/104
@@ -58,7 +58,6 @@ rm -f $seqres.full
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch
-_need_to_be_root
 
 rm -f $seqres.full
 
diff --git a/tests/btrfs/105 b/tests/btrfs/105
index be051fe..cdbdb8f 100755
--- a/tests/btrfs/105
+++ b/tests/btrfs/105
@@ -48,7 +48,6 @@ _cleanup()
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch
-_need_to_be_root
 
 send_files_dir=$TEST_DIR/btrfs-test-$seq
 
@@ -109,4 +108,4 @@ echo "File digest in the new filesystem:"
 md5sum $SCRATCH_MNT/mysnap2_ro/foo/bar | _filter_scratch
 
 status=0
-exit
\ No newline at end of file
+exit
diff --git a/tests/btrfs/106 b/tests/btrfs/106
index c7e61f7..98f0d08 100755
--- a/tests/btrfs/106
+++ b/tests/btrfs/106
@@ -43,7 +43,6 @@ _cleanup()
 . ./common/filter
 
 # real QA test starts here
-_need_to_be_root
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch
diff --git a/tests/btrfs/107 b/tests/btrfs/107
index a5ad71a..e5516e6 100755
--- a/tests/btrfs/107
+++ b/tests/btrfs/107
@@ -50,7 +50,6 @@ rm -f $seqres.full
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch
-_need_to_be_root
 
 # Use 64K file size to match any sectorsize
 # And with a unaligned tailing range to ensure it will be at least 2 pages
diff --git a/tests/btrfs/108 b/tests/btrfs/108
index 18e5b99..9c6d35d 100755
--- a/tests/btrfs/108
+++ b/tests/btrfs/108
@@ -47,7 +47,6 @@ _cleanup()
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch
-_need_to_be_root
 _require_cp_reflink
 _require_xfs_io_command "fpunch"
 
diff --git a/tests/btrfs/109 b/tests/btrfs/109
index b86336c..8ee1aa1 100755
--- a/tests/btrfs/109
+++ b/tests/btrfs/109
@@ -47,7 +47,6 @@ _cleanup()
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch
-_need_to_be_root
 _require_cp_reflink
 
 send_files_dir=$TEST_DIR/btrfs-test-$seq
diff --git a/tests/btrfs/110 b/tests/btrfs/110
index 45c0ce3..7548af4 100755
--- a/tests/btrfs/110
+++ b/tests/btrfs/110
@@ -46,7 +46,6 @@ _cleanup()
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch
-_need_to_be_root
 
 send_files_dir=$TEST_DIR/btrfs-test-$seq
 
diff --git a/tests/btrfs/111 b/tests/btrfs/111
index e597db7..56085dc 100755
--- a/tests/btrfs/111
+++ b/tests/btrfs/111
@@ -46,7 +46,6 @@ _cleanup()
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch
-_need_to_be_root
 
 send_files_dir=$TEST_DIR/btrfs-test-$seq
 
diff --git a/tests/btrfs/112 b/tests/btrfs/112
index 45f68fc..a0177f6 100755
--- a/tests/btrfs/112
+++ b/tests/btrfs/112
@@ -42,7 +42,6 @@ _cleanup()
 . ./common/filter
 
 # real QA test starts here
-_need_to_be_root
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch
diff --git a/tests/btrfs/113 b/tests/btrfs/113
index 72866aa..93ab47d 100755
--- a/tests/btrfs/113
+++ b/tests/btrfs/113
@@ -44,7 +44,6 @@ _cleanup()
 . ./common/filter
 
 # real QA test starts here
-_need_to_be_root
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch
diff --git a/tests/btrfs/116 b/tests/btrfs/116
index c51e135..1ea88c1 100755
--- a/tests/btrfs/116
+++ b/tests/btrfs/116
@@ -44,7 +44,6 @@ _cleanup()
 . ./common/filter
 
 # real QA test starts here
-_need_to_be_root
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch
diff --git a/tests/btrfs/117 b/tests/btrfs/117
index f2e58de..a028da5 100755
--- a/tests/btrfs/117
+++ b/tests/btrfs/117
@@ -49,7 +49,6 @@ _supported_fs btrfs
 _supported_os Linux
 _require_scratch
 _require_cp_reflink
-_need_to_be_root
 
 rm -f $seqres.full
 
diff --git a/tests/ext4/271 b/tests/ext4/271
index 217d0d8..844364f 100755
--- a/tests/ext4/271
+++ b/tests/ext4/271
@@ -38,7 +38,6 @@ trap "rm -f $tmp.*; exit \$status" 0 1 2 3 15
 # real QA test starts here
 _supported_fs ext4
 _supported_os Linux
-_need_to_be_root
 _require_scratch
 
 rm -f $seqres.full
diff --git a/tests/ext4/301 b/tests/ext4/301
index d6547c5..4e21acd 100755
--- a/tests/ext4/301
+++ b/tests/ext4/301
@@ -40,7 +40,6 @@ trap "rm -f $tmp.*; exit \$status" 0 1 2 3 15
 # real QA test starts here
 _supported_os Linux
 _supported_fs ext4
-_need_to_be_root
 _require_scratch
 _require_defrag
 
diff --git a/tests/ext4/302 b/tests/ext4/302
index 45cd28c..6ed8ce0 100755
--- a/tests/ext4/302
+++ b/tests/ext4/302
@@ -41,7 +41,6 @@ trap "rm -f $tmp.*; exit \$status" 0 1 2 3 15
 # real QA test starts here
 _supported_os Linux
 _supported_fs ext4
-_need_to_be_root
 _require_scratch
 _require_defrag
 
diff --git a/tests/ext4/303 b/tests/ext4/303
index 64a6405..b925aa3 100755
--- a/tests/ext4/303
+++ b/tests/ext4/303
@@ -41,7 +41,6 @@ trap "rm -f $tmp.*; exit \$status" 0 1 2 3 15
 # real QA test starts here
 _supported_os Linux
 _supported_fs ext4
-_need_to_be_root
 _require_scratch
 _require_defrag
 
diff --git a/tests/ext4/304 b/tests/ext4/304
index cc03190..ceb82d6 100755
--- a/tests/ext4/304
+++ b/tests/ext4/304
@@ -42,7 +42,6 @@ trap "rm -f $tmp.*; exit \$status" 0 1 2 3 15
 # real QA test starts here
 _supported_os Linux
 _supported_fs ext4
-_need_to_be_root
 _require_scratch
 _require_defrag
 
diff --git a/tests/ext4/307 b/tests/ext4/307
index 673b9ce..505737d 100755
--- a/tests/ext4/307
+++ b/tests/ext4/307
@@ -61,7 +61,6 @@ _workout()
 _supported_fs generic
 _supported_fs ext4
 _supported_os Linux
-_need_to_be_root
 _require_scratch
 _require_defrag
 _require_xfs_io_command "falloc"
diff --git a/tests/ext4/308 b/tests/ext4/308
index 948ff3f..74bfc1b 100755
--- a/tests/ext4/308
+++ b/tests/ext4/308
@@ -43,7 +43,6 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
-_need_to_be_root
 _require_scratch
 _require_defrag
 _require_xfs_io_command "falloc"
diff --git a/tests/generic/019 b/tests/generic/019
index 1137ffe..84e62f5 100755
--- a/tests/generic/019
+++ b/tests/generic/019
@@ -37,7 +37,6 @@ status=1	# failure is the default!
 . ./common/filter
 _supported_fs generic
 _supported_os Linux
-_need_to_be_root
 _require_scratch
 _require_fail_make_request
 
diff --git a/tests/generic/026 b/tests/generic/026
index ab75839..4d3fac6 100755
--- a/tests/generic/026
+++ b/tests/generic/026
@@ -50,7 +50,6 @@ _supported_fs generic
 _supported_os Linux
 _require_test
 _require_scratch
-_need_to_be_root
 _acl_setup_ids
 _require_acls
 _require_acl_get_max
diff --git a/tests/generic/034 b/tests/generic/034
index 1065c70..6727b98 100755
--- a/tests/generic/034
+++ b/tests/generic/034
@@ -50,7 +50,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # real QA test starts here
 _supported_fs generic
 _supported_os Linux
-_need_to_be_root
 _require_scratch
 _require_dm_target flakey
 _require_metadata_journaling $SCRATCH_DEV
diff --git a/tests/generic/037 b/tests/generic/037
index 76e3bf4..d7dcfe2 100755
--- a/tests/generic/037
+++ b/tests/generic/037
@@ -51,7 +51,6 @@ _cleanup()
 . ./common/attr
 
 # real QA test starts here
-_need_to_be_root
 _supported_fs generic
 _supported_os Linux
 _require_scratch
diff --git a/tests/generic/038 b/tests/generic/038
index 4d3977a..59aed67 100755
--- a/tests/generic/038
+++ b/tests/generic/038
@@ -65,7 +65,6 @@ _cleanup()
 . ./common/filter
 
 # real QA test starts here
-_need_to_be_root
 _supported_fs generic
 _supported_os Linux
 _require_scratch
diff --git a/tests/generic/039 b/tests/generic/039
index 21c04d2..7d62393 100755
--- a/tests/generic/039
+++ b/tests/generic/039
@@ -54,7 +54,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # real QA test starts here
 _supported_fs generic
 _supported_os Linux
-_need_to_be_root
 _require_scratch
 _require_dm_target flakey
 _require_metadata_journaling $SCRATCH_DEV
diff --git a/tests/generic/040 b/tests/generic/040
index 7e90e00..2aeccdd 100755
--- a/tests/generic/040
+++ b/tests/generic/040
@@ -59,7 +59,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # real QA test starts here
 _supported_fs generic
 _supported_os Linux
-_need_to_be_root
 _require_scratch
 _require_dm_target flakey
 _require_metadata_journaling $SCRATCH_DEV
diff --git a/tests/generic/041 b/tests/generic/041
index 7816389..283c305 100755
--- a/tests/generic/041
+++ b/tests/generic/041
@@ -63,7 +63,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # real QA test starts here
 _supported_fs generic
 _supported_os Linux
-_need_to_be_root
 _require_scratch
 _require_dm_target flakey
 _require_metadata_journaling $SCRATCH_DEV
diff --git a/tests/generic/056 b/tests/generic/056
index b720690..6ca3b1a 100755
--- a/tests/generic/056
+++ b/tests/generic/056
@@ -52,7 +52,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # real QA test starts here
 _supported_fs generic
 _supported_os Linux
-_need_to_be_root
 _require_scratch
 _require_dm_target flakey
 _require_metadata_journaling $SCRATCH_DEV
diff --git a/tests/generic/057 b/tests/generic/057
index fa4d17a..76f438e 100755
--- a/tests/generic/057
+++ b/tests/generic/057
@@ -52,7 +52,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # real QA test starts here
 _supported_fs generic
 _supported_os Linux
-_need_to_be_root
 _require_scratch
 _require_dm_target flakey
 _require_metadata_journaling $SCRATCH_DEV
diff --git a/tests/generic/059 b/tests/generic/059
index de4e7ce..c3a6044 100755
--- a/tests/generic/059
+++ b/tests/generic/059
@@ -57,7 +57,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # real QA test starts here
 _supported_fs generic
 _supported_os Linux
-_need_to_be_root
 _require_scratch
 _require_dm_target flakey
 _require_metadata_journaling $SCRATCH_DEV
diff --git a/tests/generic/065 b/tests/generic/065
index 37077d5..935f414 100755
--- a/tests/generic/065
+++ b/tests/generic/065
@@ -53,7 +53,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # real QA test starts here
 _supported_fs generic
 _supported_os Linux
-_need_to_be_root
 _require_scratch
 _require_dm_target flakey
 _require_metadata_journaling $SCRATCH_DEV
diff --git a/tests/generic/066 b/tests/generic/066
index 3c215bd..c42b11b 100755
--- a/tests/generic/066
+++ b/tests/generic/066
@@ -57,7 +57,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # real QA test starts here
 _supported_fs generic
 _supported_os Linux
-_need_to_be_root
 _require_scratch
 _require_dm_target flakey
 _require_attrs
diff --git a/tests/generic/071 b/tests/generic/071
index 1b0f558..65ed0c7 100755
--- a/tests/generic/071
+++ b/tests/generic/071
@@ -45,7 +45,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # real QA test starts here
 _supported_fs generic
 _supported_os Linux
-_need_to_be_root
 _require_scratch
 _require_xfs_io_command "falloc"
 
diff --git a/tests/generic/073 b/tests/generic/073
index 1c92c66..9e3794f 100755
--- a/tests/generic/073
+++ b/tests/generic/073
@@ -53,7 +53,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # real QA test starts here
 _supported_fs generic
 _supported_os Linux
-_need_to_be_root
 _require_scratch
 _require_dm_target flakey
 _require_metadata_journaling $SCRATCH_DEV
diff --git a/tests/generic/090 b/tests/generic/090
index 1bc9b16..eeb1831 100755
--- a/tests/generic/090
+++ b/tests/generic/090
@@ -51,7 +51,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # real QA test starts here
 _supported_fs generic
 _supported_os Linux
-_need_to_be_root
 _require_scratch
 _require_dm_target flakey
 _require_metadata_journaling $SCRATCH_DEV
diff --git a/tests/generic/093 b/tests/generic/093
index 8f810a6..af58888 100755
--- a/tests/generic/093
+++ b/tests/generic/093
@@ -65,8 +65,6 @@ _require_attrs
 
 rm -f $seqres.full
 
-_need_to_be_root
-
 echo "QA output created by $seq"
 echo ""
 file=$TEST_DIR/$seq.file
diff --git a/tests/generic/098 b/tests/generic/098
index 4945630..838bb5d 100755
--- a/tests/generic/098
+++ b/tests/generic/098
@@ -46,7 +46,6 @@ _cleanup()
 . ./common/filter
 
 # real QA test starts here
-_need_to_be_root
 _supported_fs generic
 _supported_os Linux
 _require_scratch
diff --git a/tests/generic/101 b/tests/generic/101
index 8771a17..f4f6c36 100755
--- a/tests/generic/101
+++ b/tests/generic/101
@@ -47,7 +47,6 @@ _cleanup()
 . ./common/dmflakey
 
 # real QA test starts here
-_need_to_be_root
 _supported_fs generic
 _supported_os Linux
 _require_scratch
diff --git a/tests/generic/102 b/tests/generic/102
index abc3994..3cdc2ba 100755
--- a/tests/generic/102
+++ b/tests/generic/102
@@ -41,7 +41,6 @@ trap "exit \$status" 0 1 2 3 15
 . ./common/filter
 
 # real QA test starts here
-_need_to_be_root
 _supported_fs generic
 _supported_os Linux
 _require_scratch
diff --git a/tests/generic/104 b/tests/generic/104
index ceab94b..7917199 100755
--- a/tests/generic/104
+++ b/tests/generic/104
@@ -45,7 +45,6 @@ _cleanup()
 . ./common/dmflakey
 
 # real QA test starts here
-_need_to_be_root
 _supported_fs generic
 _supported_os Linux
 _require_scratch
diff --git a/tests/generic/106 b/tests/generic/106
index 9dd2e6b..efad8c8 100755
--- a/tests/generic/106
+++ b/tests/generic/106
@@ -44,7 +44,6 @@ _cleanup()
 . ./common/dmflakey
 
 # real QA test starts here
-_need_to_be_root
 _supported_fs generic
 _supported_os Linux
 _require_scratch
diff --git a/tests/generic/107 b/tests/generic/107
index 6b5f2bb..e0a9245 100755
--- a/tests/generic/107
+++ b/tests/generic/107
@@ -47,7 +47,6 @@ _cleanup()
 . ./common/dmflakey
 
 # real QA test starts here
-_need_to_be_root
 _supported_fs generic
 _supported_os Linux
 _require_scratch
diff --git a/tests/generic/177 b/tests/generic/177
index c11d1c6..0aeb8e4 100755
--- a/tests/generic/177
+++ b/tests/generic/177
@@ -48,7 +48,6 @@ _cleanup()
 . ./common/dmflakey
 
 # real QA test starts here
-_need_to_be_root
 _supported_fs generic
 _supported_os Linux
 _require_scratch
diff --git a/tests/generic/193 b/tests/generic/193
index cd3c0b0..6d0754f 100755
--- a/tests/generic/193
+++ b/tests/generic/193
@@ -72,7 +72,6 @@ _supported_os Linux
 
 _require_test
 _require_user
-_need_to_be_root
 
 test_root=$TEST_DIR/$seq.$$.root
 test_user=$TEST_DIR/$seq.$$.user
diff --git a/tests/generic/230 b/tests/generic/230
index 0b1b3bf..8efa65d 100755
--- a/tests/generic/230
+++ b/tests/generic/230
@@ -45,7 +45,6 @@ _supported_os Linux #IRIX
 _require_scratch
 _require_quota
 _require_user
-_need_to_be_root
 
 test_files()
 {
diff --git a/tests/generic/231 b/tests/generic/231
index feda0c1..3133cfe 100755
--- a/tests/generic/231
+++ b/tests/generic/231
@@ -69,7 +69,6 @@ _supported_os Linux
 _require_scratch
 _require_quota
 _require_user
-_need_to_be_root
 
 _scratch_mkfs >> $seqres.full 2>&1
 _scratch_mount "-o usrquota,grpquota"
diff --git a/tests/generic/232 b/tests/generic/232
index 1323809..6b19779 100755
--- a/tests/generic/232
+++ b/tests/generic/232
@@ -69,7 +69,6 @@ _supported_fs generic
 _supported_os Linux
 _require_scratch
 _require_quota
-_need_to_be_root
 
 _scratch_mkfs > $seqres.full 2>&1
 _scratch_mount "-o usrquota,grpquota"
diff --git a/tests/generic/233 b/tests/generic/233
index d50d280..1405d0e 100755
--- a/tests/generic/233
+++ b/tests/generic/233
@@ -74,7 +74,6 @@ _supported_os Linux
 _require_scratch
 _require_quota
 _require_user
-_need_to_be_root
 
 _scratch_mkfs > $seqres.full 2>&1
 _scratch_mount "-o usrquota,grpquota"
diff --git a/tests/generic/234 b/tests/generic/234
index 30be0e9..75a2c23 100755
--- a/tests/generic/234
+++ b/tests/generic/234
@@ -91,7 +91,6 @@ _supported_fs generic
 _supported_os Linux #IRIX
 _require_scratch
 _require_quota
-_need_to_be_root
 
 # real QA test starts here
 rm -f $seqres.full
diff --git a/tests/generic/235 b/tests/generic/235
index e27fd3d..59456b6 100755
--- a/tests/generic/235
+++ b/tests/generic/235
@@ -45,7 +45,6 @@ _supported_os Linux #IRIX
 _require_scratch
 _require_quota
 _require_user
-_need_to_be_root
 
 # real QA test starts here
 rm -f $seqres.full
diff --git a/tests/generic/237 b/tests/generic/237
index f2669cd..75b1b55 100755
--- a/tests/generic/237
+++ b/tests/generic/237
@@ -55,7 +55,6 @@ _require_test
 
 rm -f $seqres.full
 
-_need_to_be_root
 _acl_setup_ids
 _require_acls
 
diff --git a/tests/generic/265 b/tests/generic/265
index 607867d..8e9d5bc 100755
--- a/tests/generic/265
+++ b/tests/generic/265
@@ -46,7 +46,6 @@ _cleanup()
 _supported_os Linux
 _require_scratch_reflink
 _require_cp_reflink
-_need_to_be_root
 _require_dm_target error
 
 rm -f $seqres.full
diff --git a/tests/generic/266 b/tests/generic/266
index 102df76..4f9816a 100755
--- a/tests/generic/266
+++ b/tests/generic/266
@@ -46,7 +46,6 @@ _cleanup()
 _supported_os Linux
 _require_scratch_reflink
 _require_cp_reflink
-_need_to_be_root
 _require_dm_target error
 
 rm -f $seqres.full
diff --git a/tests/generic/267 b/tests/generic/267
index 24b7b7c..e3a6b0c 100755
--- a/tests/generic/267
+++ b/tests/generic/267
@@ -46,7 +46,6 @@ _cleanup()
 _supported_os Linux
 _require_scratch_reflink
 _require_cp_reflink
-_need_to_be_root
 _require_dm_target error
 
 rm -f $seqres.full
diff --git a/tests/generic/268 b/tests/generic/268
index c17ea57..c7dcd57 100755
--- a/tests/generic/268
+++ b/tests/generic/268
@@ -47,7 +47,6 @@ _cleanup()
 _supported_os Linux
 _require_scratch_reflink
 _require_cp_reflink
-_need_to_be_root
 _require_dm_target error
 
 rm -f $seqres.full
diff --git a/tests/generic/269 b/tests/generic/269
index d2043d4..ee353a5 100755
--- a/tests/generic/269
+++ b/tests/generic/269
@@ -64,7 +64,6 @@ _workout()
 # real QA test starts here
 _supported_fs generic
 _supported_os Linux
-_need_to_be_root
 _require_scratch
 
 rm -f $seqres.full
diff --git a/tests/generic/270 b/tests/generic/270
index 255ebf2..e6874c9 100755
--- a/tests/generic/270
+++ b/tests/generic/270
@@ -78,7 +78,6 @@ _supported_fs generic
 _supported_os Linux
 _require_quota
 _require_user
-_need_to_be_root
 _require_scratch
 
 rm -f $seqres.full
diff --git a/tests/generic/271 b/tests/generic/271
index 955478e..fc3c3c6 100755
--- a/tests/generic/271
+++ b/tests/generic/271
@@ -46,7 +46,6 @@ _cleanup()
 _supported_os Linux
 _require_scratch_reflink
 _require_cp_reflink
-_need_to_be_root
 _require_dm_target error
 _require_odirect
 
diff --git a/tests/generic/272 b/tests/generic/272
index 7560214..feaadae 100755
--- a/tests/generic/272
+++ b/tests/generic/272
@@ -46,7 +46,6 @@ _cleanup()
 _supported_os Linux
 _require_scratch_reflink
 _require_cp_reflink
-_need_to_be_root
 _require_dm_target error
 _require_odirect
 
diff --git a/tests/generic/276 b/tests/generic/276
index 560daba..c6d7a63 100755
--- a/tests/generic/276
+++ b/tests/generic/276
@@ -46,7 +46,6 @@ _cleanup()
 _supported_os Linux
 _require_scratch_reflink
 _require_cp_reflink
-_need_to_be_root
 _require_dm_target error
 _require_odirect
 
diff --git a/tests/generic/278 b/tests/generic/278
index 6d0c828..527356d 100755
--- a/tests/generic/278
+++ b/tests/generic/278
@@ -47,7 +47,6 @@ _cleanup()
 _supported_os Linux
 _require_scratch_reflink
 _require_cp_reflink
-_need_to_be_root
 _require_dm_target error
 _require_odirect
 
diff --git a/tests/generic/279 b/tests/generic/279
index 67da34b..2f1ec4f 100755
--- a/tests/generic/279
+++ b/tests/generic/279
@@ -46,7 +46,6 @@ _cleanup()
 _supported_os Linux
 _require_scratch_reflink
 _require_cp_reflink
-_need_to_be_root
 _require_dm_target error
 
 rm -f $seqres.full
diff --git a/tests/generic/281 b/tests/generic/281
index 71e3dd7..c95acf2 100755
--- a/tests/generic/281
+++ b/tests/generic/281
@@ -46,7 +46,6 @@ _cleanup()
 _supported_os Linux
 _require_scratch_reflink
 _require_cp_reflink
-_need_to_be_root
 _require_dm_target error
 
 rm -f $seqres.full
diff --git a/tests/generic/282 b/tests/generic/282
index 38714e0..6452025 100755
--- a/tests/generic/282
+++ b/tests/generic/282
@@ -46,7 +46,6 @@ _cleanup()
 _supported_os Linux
 _require_scratch_reflink
 _require_cp_reflink
-_need_to_be_root
 _require_dm_target error
 
 rm -f $seqres.full
diff --git a/tests/generic/283 b/tests/generic/283
index 6d8701f..8d56ac3 100755
--- a/tests/generic/283
+++ b/tests/generic/283
@@ -47,7 +47,6 @@ _cleanup()
 _supported_os Linux
 _require_scratch_reflink
 _require_cp_reflink
-_need_to_be_root
 _require_dm_target error
 
 rm -f $seqres.full
diff --git a/tests/generic/299 b/tests/generic/299
index 4174de0..40265c8 100755
--- a/tests/generic/299
+++ b/tests/generic/299
@@ -41,7 +41,6 @@ trap "rm -f $tmp.*; exit \$status" 0 1 2 3 15
 # real QA test starts here
 _supported_fs generic
 _supported_os Linux
-_need_to_be_root
 _require_scratch
 _require_odirect
 
diff --git a/tests/generic/300 b/tests/generic/300
index a12aba6..c187f43 100755
--- a/tests/generic/300
+++ b/tests/generic/300
@@ -41,7 +41,6 @@ trap "rm -f $tmp.*; exit \$status" 0 1 2 3 15
 # real QA test starts here
 _supported_fs generic
 _supported_os Linux
-_need_to_be_root
 _require_scratch
 _require_odirect
 
diff --git a/tests/generic/311 b/tests/generic/311
index 69bc1bf..2d4413b 100755
--- a/tests/generic/311
+++ b/tests/generic/311
@@ -53,7 +53,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # real QA test starts here
 _supported_fs generic
 _supported_os Linux
-_need_to_be_root
 _require_scratch_nocheck
 _require_dm_target flakey
 _require_metadata_journaling $SCRATCH_DEV
diff --git a/tests/generic/314 b/tests/generic/314
index 294fb23..65d3513 100755
--- a/tests/generic/314
+++ b/tests/generic/314
@@ -46,7 +46,6 @@ _supported_fs generic
 _require_test
 _require_acls
 _require_user
-_need_to_be_root
 
 rm -rf $TEST_DIR/$seq-dir
 
diff --git a/tests/generic/317 b/tests/generic/317
index a5d8804..9d9499b 100755
--- a/tests/generic/317
+++ b/tests/generic/317
@@ -58,7 +58,6 @@ _supported_os Linux
 rm -f $seqres.full
 
 _require_scratch
-_need_to_be_root
 _require_user
 _require_ugid_map
 _require_userns
diff --git a/tests/generic/318 b/tests/generic/318
index f850a9b..e284317 100755
--- a/tests/generic/318
+++ b/tests/generic/318
@@ -58,7 +58,6 @@ _supported_os Linux
 rm -f $seqres.full
 
 _require_scratch
-_need_to_be_root
 _acl_setup_ids
 _require_acls
 _require_ugid_map
diff --git a/tests/generic/319 b/tests/generic/319
index 046969f..d1eea4a 100755
--- a/tests/generic/319
+++ b/tests/generic/319
@@ -52,7 +52,6 @@ _supported_os Linux
 _supported_fs generic
 _require_acls
 _require_scratch
-_need_to_be_root
 
 rm -f $seqres.full
 
diff --git a/tests/generic/321 b/tests/generic/321
index 7c6c823..8798503 100755
--- a/tests/generic/321
+++ b/tests/generic/321
@@ -42,7 +42,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # real QA test starts here
 _supported_fs generic
 _supported_os Linux
-_need_to_be_root
 _require_scratch_nocheck
 _require_dm_target flakey
 _require_metadata_journaling $SCRATCH_DEV
diff --git a/tests/generic/322 b/tests/generic/322
index 9c925a4..475a31c 100755
--- a/tests/generic/322
+++ b/tests/generic/322
@@ -42,7 +42,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # real QA test starts here
 _supported_fs generic
 _supported_os Linux
-_need_to_be_root
 _require_scratch_nocheck
 _require_dm_target flakey
 _require_metadata_journaling $SCRATCH_DEV
diff --git a/tests/generic/324 b/tests/generic/324
index 5e642dc..47cb3db 100755
--- a/tests/generic/324
+++ b/tests/generic/324
@@ -41,7 +41,6 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
-_need_to_be_root
 _require_scratch
 _require_defrag
 _require_xfs_io_command "falloc"
diff --git a/tests/generic/325 b/tests/generic/325
index 0994ff6..a0b641a 100755
--- a/tests/generic/325
+++ b/tests/generic/325
@@ -52,7 +52,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # real QA test starts here
 _supported_fs generic
 _supported_os Linux
-_need_to_be_root
 _require_scratch
 _require_dm_target flakey
 _require_metadata_journaling $SCRATCH_DEV
diff --git a/tests/shared/002 b/tests/shared/002
index eb8713b..88b2826 100755
--- a/tests/shared/002
+++ b/tests/shared/002
@@ -57,7 +57,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # less than 1000 xattrs with very small values.
 _supported_fs btrfs xfs
 _supported_os Linux
-_need_to_be_root
 _require_scratch
 _require_dm_target flakey
 _require_attrs
diff --git a/tests/shared/051 b/tests/shared/051
index 262cef1..1b2d2cf 100755
--- a/tests/shared/051
+++ b/tests/shared/051
@@ -76,7 +76,6 @@ _require_test
 
 rm -f $seqres.full
 
-_need_to_be_root
 _acl_setup_ids
 _require_acls
 
diff --git a/tests/shared/272 b/tests/shared/272
index 11b2a00..8ec2c36 100755
--- a/tests/shared/272
+++ b/tests/shared/272
@@ -84,7 +84,6 @@ chattr_opt: $chattr_opt" >>$seqres.full
 # real QA test starts here
 _supported_fs ext3 ext4
 _supported_os Linux
-_need_to_be_root
 _require_scratch
 
 rm -f $seqres.full
diff --git a/tests/xfs/003 b/tests/xfs/003
index 2eed40f..0fd4cfa 100755
--- a/tests/xfs/003
+++ b/tests/xfs/003
@@ -35,8 +35,6 @@ here=`pwd`
 status=0	# success is the default!
 trap "rm -f $tmp.*; exit \$status" 0 1 2 3 15
 
-_need_to_be_root
-
 # real QA test starts here
 _supported_fs xfs
 _supported_os IRIX Linux
diff --git a/tests/xfs/004 b/tests/xfs/004
index cf17286..59b8997 100755
--- a/tests/xfs/004
+++ b/tests/xfs/004
@@ -60,7 +60,6 @@ _populate_scratch()
 _supported_fs xfs
 _supported_os IRIX Linux
 
-_need_to_be_root
 _require_scratch
 _require_no_large_scratch_dev
 
diff --git a/tests/xfs/067 b/tests/xfs/067
index 27f5713..c68ec09 100755
--- a/tests/xfs/067
+++ b/tests/xfs/067
@@ -40,7 +40,6 @@ trap "rm -f $tmp.*; exit \$status" 0 1 2 3 15
 _supported_fs xfs
 _supported_os Linux
 
-_need_to_be_root
 _require_attrs
 _require_acls
 _require_scratch
diff --git a/tests/xfs/114 b/tests/xfs/114
index f8601ec..50cc71b 100755
--- a/tests/xfs/114
+++ b/tests/xfs/114
@@ -309,7 +309,6 @@ _supported_os IRIX
 
 _require_scratch
 _require_attrs
-_need_to_be_root
 
 rm -f $seqres.full
 
diff --git a/tests/xfs/189 b/tests/xfs/189
index 540a0d7..636f6f0 100755
--- a/tests/xfs/189
+++ b/tests/xfs/189
@@ -236,7 +236,6 @@ _putback_scratch_fstab()
 _supported_fs xfs
 _supported_os Linux
 
-_need_to_be_root
 _require_scratch
 _require_noattr2
 
-- 
2.5.0

