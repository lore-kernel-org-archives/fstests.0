Received: from cn.fujitsu.com ([59.151.112.132]:45290 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750759AbdEQBmq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 16 May 2017 21:42:46 -0400
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH v2 1/2] common: use _require_xfs_io_command() directly to check fiemap
Date: Wed, 17 May 2017 09:42:32 +0800
Message-ID: <1494985353-13746-1-git-send-email-yangx.jy@cn.fujitsu.com>
In-Reply-To: <20170516080455.GX7250@eguan.usersys.redhat.com>
References: <20170516080455.GX7250@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: eguan@redhat.com
Cc: amir73il@gmail.com, fstests@vger.kernel.org, Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

1) _require_fiemap and _require_xfs_io_command "fiemap" do the
   same thing, but some test cases use the former and some use
   the latter, so i feel they should be unified.

2) The number of helpers like this is slowly growing, but it's
   easy to simply use _require_xfs_io_command directly and just
   specify the command we want to check.

This is just a cleanup for keeping it simple.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 common/rc         | 12 ------------
 common/reflink    |  2 +-
 tests/generic/043 |  2 +-
 tests/generic/044 |  2 +-
 tests/generic/045 |  2 +-
 tests/generic/046 |  2 +-
 tests/generic/047 |  2 +-
 tests/generic/048 |  2 +-
 tests/generic/049 |  2 +-
 tests/generic/092 |  2 +-
 tests/generic/301 |  2 +-
 tests/generic/302 |  2 +-
 tests/generic/305 |  2 +-
 tests/generic/326 |  2 +-
 tests/generic/327 |  2 +-
 tests/generic/328 |  2 +-
 tests/generic/352 |  2 +-
 tests/generic/353 |  2 +-
 tests/generic/372 |  2 +-
 tests/generic/414 |  2 +-
 tests/generic/425 |  2 +-
 tests/xfs/180     |  2 +-
 tests/xfs/182     |  2 +-
 tests/xfs/184     |  2 +-
 tests/xfs/192     |  2 +-
 tests/xfs/193     |  2 +-
 tests/xfs/198     |  2 +-
 tests/xfs/200     |  2 +-
 tests/xfs/204     |  2 +-
 tests/xfs/207     |  2 +-
 tests/xfs/208     |  2 +-
 tests/xfs/209     |  2 +-
 tests/xfs/210     |  2 +-
 tests/xfs/211     |  2 +-
 tests/xfs/212     |  2 +-
 tests/xfs/213     |  2 +-
 tests/xfs/214     |  2 +-
 tests/xfs/231     |  2 +-
 tests/xfs/232     |  2 +-
 tests/xfs/344     |  2 +-
 tests/xfs/345     |  2 +-
 tests/xfs/346     |  2 +-
 tests/xfs/347     |  2 +-
 43 files changed, 42 insertions(+), 54 deletions(-)

diff --git a/common/rc b/common/rc
index aa35b5e..539f153 100644
--- a/common/rc
+++ b/common/rc
@@ -2940,12 +2940,6 @@ _require_metadata_journaling()
 	esac
 }
 
-# Does fiemap support?
-_require_fiemap()
-{
-	_require_xfs_io_command "fiemap"
-}
-
 _count_extents()
 {
 	$XFS_IO_PROG -c "fiemap" $1 | tail -n +2 | grep -v hole | wc -l
@@ -2956,12 +2950,6 @@ _count_holes()
 	$XFS_IO_PROG -c "fiemap" $1 | tail -n +2 | grep hole | wc -l
 }
 
-# Does fiemap support reporting xattr extents?
-_require_fiemap_attr()
-{
-	_require_xfs_io_command "fiemap" "-a"
-}
-
 _count_attr_extents()
 {
 	$XFS_IO_PROG -c "fiemap -a" $1 | tail -n +2 | grep -v hole | wc -l
diff --git a/common/reflink b/common/reflink
index 2e364e5..2a7c7b8 100644
--- a/common/reflink
+++ b/common/reflink
@@ -111,7 +111,7 @@ _require_scratch_reflink()
 _require_scratch_explicit_shared_extents()
 {
 	_require_scratch
-	_require_fiemap
+	_require_xfs_io_command "fiemap"
 	_require_scratch_reflink
 	_require_xfs_io_command "reflink"
 	local nr_extents
diff --git a/tests/generic/043 b/tests/generic/043
index 3d98ab0..784683e 100755
--- a/tests/generic/043
+++ b/tests/generic/043
@@ -41,7 +41,7 @@ _supported_os Linux IRIX
 
 _require_scratch
 _require_scratch_shutdown
-_require_fiemap
+_require_xfs_io_command "fiemap"
 _scratch_mkfs >/dev/null 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _scratch_mount
diff --git a/tests/generic/044 b/tests/generic/044
index eb64b86..f0dc0df 100755
--- a/tests/generic/044
+++ b/tests/generic/044
@@ -41,7 +41,7 @@ _supported_os Linux IRIX
 
 _require_scratch
 _require_scratch_shutdown
-_require_fiemap
+_require_xfs_io_command "fiemap"
 _scratch_mkfs >/dev/null 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _scratch_mount
diff --git a/tests/generic/045 b/tests/generic/045
index 5ef747f..b49d09e 100755
--- a/tests/generic/045
+++ b/tests/generic/045
@@ -41,7 +41,7 @@ _supported_os Linux IRIX
 
 _require_scratch
 _require_scratch_shutdown
-_require_fiemap
+_require_xfs_io_command "fiemap"
 _scratch_mkfs >/dev/null 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _scratch_mount
diff --git a/tests/generic/046 b/tests/generic/046
index 882cb09..54cb557 100755
--- a/tests/generic/046
+++ b/tests/generic/046
@@ -41,7 +41,7 @@ _supported_os Linux IRIX
 
 _require_scratch
 _require_scratch_shutdown
-_require_fiemap
+_require_xfs_io_command "fiemap"
 _scratch_mkfs >/dev/null 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _scratch_mount
diff --git a/tests/generic/047 b/tests/generic/047
index d7e4610..20f157e 100755
--- a/tests/generic/047
+++ b/tests/generic/047
@@ -42,7 +42,7 @@ _supported_os Linux IRIX
 
 _require_scratch
 _require_scratch_shutdown
-_require_fiemap
+_require_xfs_io_command "fiemap"
 _scratch_mkfs >/dev/null 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _scratch_mount
diff --git a/tests/generic/048 b/tests/generic/048
index 3f0bcc1..dc2ab20 100755
--- a/tests/generic/048
+++ b/tests/generic/048
@@ -42,7 +42,7 @@ _supported_os Linux IRIX
 
 _require_scratch
 _require_scratch_shutdown
-_require_fiemap
+_require_xfs_io_command "fiemap"
 _scratch_mkfs >/dev/null 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _scratch_mount
diff --git a/tests/generic/049 b/tests/generic/049
index 1f2a4b2..c7f1944 100755
--- a/tests/generic/049
+++ b/tests/generic/049
@@ -42,7 +42,7 @@ _supported_os Linux IRIX
 
 _require_scratch
 _require_scratch_shutdown
-_require_fiemap
+_require_xfs_io_command "fiemap"
 _scratch_mkfs >/dev/null 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _scratch_mount
diff --git a/tests/generic/092 b/tests/generic/092
index faf08f1..cc615f6 100755
--- a/tests/generic/092
+++ b/tests/generic/092
@@ -53,7 +53,7 @@ _supported_fs generic
 _supported_os Linux
 _require_test
 _require_xfs_io_command "falloc"
-_require_fiemap
+_require_xfs_io_command "fiemap"
 
 # First test to make sure that truncating at i_size trims the preallocated bit
 # past i_size
diff --git a/tests/generic/301 b/tests/generic/301
index 67b1a0c..1c6ea05 100755
--- a/tests/generic/301
+++ b/tests/generic/301
@@ -47,7 +47,7 @@ _cleanup()
 _supported_os Linux
 _require_scratch_reflink
 _require_cp_reflink
-_require_fiemap
+_require_xfs_io_command "fiemap"
 
 rm -f $seqres.full
 
diff --git a/tests/generic/302 b/tests/generic/302
index 3834f98..5643bb5 100755
--- a/tests/generic/302
+++ b/tests/generic/302
@@ -47,7 +47,7 @@ _cleanup()
 _supported_os Linux
 _require_scratch_reflink
 _require_cp_reflink
-_require_fiemap
+_require_xfs_io_command "fiemap"
 _require_odirect
 
 rm -f $seqres.full
diff --git a/tests/generic/305 b/tests/generic/305
index ceef333..cb05799 100755
--- a/tests/generic/305
+++ b/tests/generic/305
@@ -46,7 +46,7 @@ _cleanup()
 _supported_os Linux
 _require_scratch_reflink
 _require_cp_reflink
-_require_fiemap
+_require_xfs_io_command "fiemap"
 _require_quota
 _require_nobody
 _require_user
diff --git a/tests/generic/326 b/tests/generic/326
index 3568efe..c6cc9bb 100755
--- a/tests/generic/326
+++ b/tests/generic/326
@@ -46,7 +46,7 @@ _cleanup()
 _supported_os Linux
 _require_scratch_reflink
 _require_cp_reflink
-_require_fiemap
+_require_xfs_io_command "fiemap"
 _require_quota
 _require_nobody
 _require_odirect
diff --git a/tests/generic/327 b/tests/generic/327
index 05cfb4a..1e1ab6a 100755
--- a/tests/generic/327
+++ b/tests/generic/327
@@ -45,7 +45,7 @@ _cleanup()
 _supported_os Linux
 _require_scratch_reflink
 _require_cp_reflink
-_require_fiemap
+_require_xfs_io_command "fiemap"
 _require_quota
 _require_nobody
 _require_user
diff --git a/tests/generic/328 b/tests/generic/328
index 21ec9d3..1ad53fd 100755
--- a/tests/generic/328
+++ b/tests/generic/328
@@ -45,7 +45,7 @@ _cleanup()
 _supported_os Linux
 _require_scratch_reflink
 _require_cp_reflink
-_require_fiemap
+_require_xfs_io_command "fiemap"
 _require_quota
 _require_nobody
 _require_odirect
diff --git a/tests/generic/352 b/tests/generic/352
index 70e43fb..30eb43b 100755
--- a/tests/generic/352
+++ b/tests/generic/352
@@ -55,7 +55,7 @@ rm -f $seqres.full
 _supported_fs generic
 _supported_os Linux
 _require_scratch_reflink
-_require_fiemap
+_require_xfs_io_command "fiemap"
 
 _scratch_mkfs > /dev/null 2>&1
 _scratch_mount
diff --git a/tests/generic/353 b/tests/generic/353
index ca665cf..ddb9346 100755
--- a/tests/generic/353
+++ b/tests/generic/353
@@ -56,7 +56,7 @@ rm -f $seqres.full
 _supported_fs generic
 _supported_os Linux
 _require_scratch_reflink
-_require_fiemap
+_require_xfs_io_command "fiemap"
 
 _scratch_mkfs > /dev/null 2>&1
 _scratch_mount
diff --git a/tests/generic/372 b/tests/generic/372
index 51a3eca..08c81a9 100755
--- a/tests/generic/372
+++ b/tests/generic/372
@@ -46,7 +46,7 @@ _cleanup()
 _supported_os Linux
 _supported_fs generic
 _require_scratch_reflink
-_require_fiemap
+_require_xfs_io_command "fiemap"
 _require_scratch_explicit_shared_extents
 
 echo "Format and mount"
diff --git a/tests/generic/414 b/tests/generic/414
index ee85d73..6f2136e 100755
--- a/tests/generic/414
+++ b/tests/generic/414
@@ -47,7 +47,7 @@ _cleanup()
 _supported_os Linux
 _supported_fs generic
 _require_scratch_reflink
-_require_fiemap
+_require_xfs_io_command "fiemap"
 
 echo "Format and mount"
 _scratch_mkfs > $seqres.full 2>&1
diff --git a/tests/generic/425 b/tests/generic/425
index 31e8467..800afc5 100755
--- a/tests/generic/425
+++ b/tests/generic/425
@@ -48,7 +48,7 @@ _supported_os Linux
 _supported_fs generic
 _require_scratch
 _require_attrs
-_require_fiemap_attr
+_require_xfs_io_command "fiemap" "-a"
 
 echo "Format and mount"
 _scratch_mkfs > $seqres.full 2>&1
diff --git a/tests/xfs/180 b/tests/xfs/180
index ce2ac26..736267e 100755
--- a/tests/xfs/180
+++ b/tests/xfs/180
@@ -49,7 +49,7 @@ _supported_os Linux
 _supported_fs xfs
 _require_scratch_reflink
 _require_cp_reflink
-_require_fiemap
+_require_xfs_io_command "fiemap"
 _require_xfs_io_command "cowextsize"
 
 rm -f $seqres.full
diff --git a/tests/xfs/182 b/tests/xfs/182
index 4413c7d..6d7d21e 100755
--- a/tests/xfs/182
+++ b/tests/xfs/182
@@ -49,7 +49,7 @@ _supported_os Linux
 _supported_fs xfs
 _require_scratch_reflink
 _require_cp_reflink
-_require_fiemap
+_require_xfs_io_command "fiemap"
 _require_xfs_io_command "cowextsize"
 _require_odirect
 
diff --git a/tests/xfs/184 b/tests/xfs/184
index 54eb115..2ae19ab 100755
--- a/tests/xfs/184
+++ b/tests/xfs/184
@@ -49,7 +49,7 @@ _supported_os Linux
 _supported_fs xfs
 _require_scratch_reflink
 _require_cp_reflink
-_require_fiemap
+_require_xfs_io_command "fiemap"
 _require_xfs_io_command "cowextsize"
 _require_xfs_io_command "funshare"
 
diff --git a/tests/xfs/192 b/tests/xfs/192
index d8bdb25..eeb6025 100755
--- a/tests/xfs/192
+++ b/tests/xfs/192
@@ -49,7 +49,7 @@ _supported_os Linux
 _supported_fs xfs
 _require_scratch_reflink
 _require_cp_reflink
-_require_fiemap
+_require_xfs_io_command "fiemap"
 _require_xfs_io_command "cowextsize"
 _require_xfs_io_command "funshare"
 _require_odirect
diff --git a/tests/xfs/193 b/tests/xfs/193
index 76cb143..c45f05a 100755
--- a/tests/xfs/193
+++ b/tests/xfs/193
@@ -48,7 +48,7 @@ _supported_os Linux
 _supported_fs xfs
 _require_scratch_reflink
 _require_cp_reflink
-_require_fiemap
+_require_xfs_io_command "fiemap"
 _require_xfs_io_command "cowextsize"
 
 rm -f $seqres.full
diff --git a/tests/xfs/198 b/tests/xfs/198
index d185ca2..bdfd44a 100755
--- a/tests/xfs/198
+++ b/tests/xfs/198
@@ -48,7 +48,7 @@ _supported_os Linux
 _supported_fs xfs
 _require_scratch_reflink
 _require_cp_reflink
-_require_fiemap
+_require_xfs_io_command "fiemap"
 _require_xfs_io_command "cowextsize"
 _require_odirect
 
diff --git a/tests/xfs/200 b/tests/xfs/200
index e70fda3..328341c 100755
--- a/tests/xfs/200
+++ b/tests/xfs/200
@@ -51,7 +51,7 @@ _supported_os Linux
 _supported_fs xfs
 _require_scratch_reflink
 _require_cp_reflink
-_require_fiemap
+_require_xfs_io_command "fiemap"
 _require_xfs_io_command "cowextsize"
 _require_xfs_io_command "funshare"
 
diff --git a/tests/xfs/204 b/tests/xfs/204
index c0b69cf..9a134e9 100755
--- a/tests/xfs/204
+++ b/tests/xfs/204
@@ -51,7 +51,7 @@ _supported_os Linux
 _supported_fs xfs
 _require_scratch_reflink
 _require_cp_reflink
-_require_fiemap
+_require_xfs_io_command "fiemap"
 _require_xfs_io_command "cowextsize"
 _require_xfs_io_command "funshare"
 _require_odirect
diff --git a/tests/xfs/207 b/tests/xfs/207
index efa283f..f9998ee 100755
--- a/tests/xfs/207
+++ b/tests/xfs/207
@@ -48,7 +48,7 @@ _supported_os Linux
 _supported_fs xfs
 _require_scratch_reflink
 _require_cp_reflink
-_require_fiemap
+_require_xfs_io_command "fiemap"
 _require_xfs_io_command "cowextsize"
 
 rm -f $seqres.full
diff --git a/tests/xfs/208 b/tests/xfs/208
index 62192cb..b00e4ab 100755
--- a/tests/xfs/208
+++ b/tests/xfs/208
@@ -52,7 +52,7 @@ _supported_os Linux
 _supported_fs xfs
 _require_scratch_reflink
 _require_cp_reflink
-_require_fiemap
+_require_xfs_io_command "fiemap"
 _require_xfs_io_command "cowextsize"
 
 rm -f $seqres.full
diff --git a/tests/xfs/209 b/tests/xfs/209
index 9bf1f12..83ccdf6 100755
--- a/tests/xfs/209
+++ b/tests/xfs/209
@@ -45,7 +45,7 @@ _supported_os Linux
 _supported_fs xfs
 _require_scratch_reflink
 _require_cp_reflink
-_require_fiemap
+_require_xfs_io_command "fiemap"
 _require_xfs_io_command "cowextsize"
 
 rm -f $seqres.full
diff --git a/tests/xfs/210 b/tests/xfs/210
index d3a2716..8a77464 100755
--- a/tests/xfs/210
+++ b/tests/xfs/210
@@ -49,7 +49,7 @@ _supported_os Linux
 _supported_fs xfs
 _require_scratch_reflink
 _require_cp_reflink
-_require_fiemap
+_require_xfs_io_command "fiemap"
 _require_xfs_io_command "cowextsize"
 
 rm -f $seqres.full
diff --git a/tests/xfs/211 b/tests/xfs/211
index 0d150f1..bd4b799 100755
--- a/tests/xfs/211
+++ b/tests/xfs/211
@@ -49,7 +49,7 @@ _supported_os Linux
 _supported_fs xfs
 _require_scratch_reflink
 _require_cp_reflink
-_require_fiemap
+_require_xfs_io_command "fiemap"
 _require_xfs_io_command "cowextsize"
 _require_odirect
 
diff --git a/tests/xfs/212 b/tests/xfs/212
index 48235d4..90f6903 100755
--- a/tests/xfs/212
+++ b/tests/xfs/212
@@ -48,7 +48,7 @@ _supported_os Linux
 _supported_fs xfs
 _require_scratch_reflink
 _require_cp_reflink
-_require_fiemap
+_require_xfs_io_command "fiemap"
 
 rm -f $seqres.full
 
diff --git a/tests/xfs/213 b/tests/xfs/213
index 844166c..2029abb 100755
--- a/tests/xfs/213
+++ b/tests/xfs/213
@@ -48,7 +48,7 @@ _supported_os Linux
 _supported_fs xfs
 _require_scratch_reflink
 _require_cp_reflink
-_require_fiemap
+_require_xfs_io_command "fiemap"
 _require_quota
 _require_nobody
 _require_xfs_io_command "cowextsize"
diff --git a/tests/xfs/214 b/tests/xfs/214
index 01ffbaf..719ea2b 100755
--- a/tests/xfs/214
+++ b/tests/xfs/214
@@ -48,7 +48,7 @@ _supported_os Linux
 _supported_fs xfs
 _require_scratch_reflink
 _require_cp_reflink
-_require_fiemap
+_require_xfs_io_command "fiemap"
 _require_quota
 _require_nobody
 _require_xfs_io_command "cowextsize"
diff --git a/tests/xfs/231 b/tests/xfs/231
index f0b64c0..ac1dd16 100755
--- a/tests/xfs/231
+++ b/tests/xfs/231
@@ -52,7 +52,7 @@ _supported_fs xfs
 _require_scratch_reflink
 _require_cp_reflink
 _require_xfs_io_command "cowextsize"
-_require_fiemap
+_require_xfs_io_command "fiemap"
 
 old_cow_lifetime=$(cat /proc/sys/fs/xfs/speculative_cow_prealloc_lifetime)
 
diff --git a/tests/xfs/232 b/tests/xfs/232
index 6b74997..8638ee6 100755
--- a/tests/xfs/232
+++ b/tests/xfs/232
@@ -53,7 +53,7 @@ _supported_fs xfs
 _require_xfs_io_command "cowextsize"
 _require_scratch_reflink
 _require_cp_reflink
-_require_fiemap
+_require_xfs_io_command "fiemap"
 
 old_cow_lifetime=$(cat /proc/sys/fs/xfs/speculative_cow_prealloc_lifetime)
 
diff --git a/tests/xfs/344 b/tests/xfs/344
index 806f7ab..d5288cf 100755
--- a/tests/xfs/344
+++ b/tests/xfs/344
@@ -49,7 +49,7 @@ _supported_os Linux
 _supported_fs xfs
 _require_scratch_reflink
 _require_cp_reflink
-_require_fiemap
+_require_xfs_io_command "fiemap"
 _require_xfs_io_command "cowextsize"
 _require_xfs_io_command "funshare"
 _require_odirect
diff --git a/tests/xfs/345 b/tests/xfs/345
index 1684297..ccfdb8f 100755
--- a/tests/xfs/345
+++ b/tests/xfs/345
@@ -48,7 +48,7 @@ _supported_os Linux
 _supported_fs xfs
 _require_scratch_reflink
 _require_cp_reflink
-_require_fiemap
+_require_xfs_io_command "fiemap"
 _require_xfs_io_command "cowextsize"
 _require_xfs_io_command "funshare"
 
diff --git a/tests/xfs/346 b/tests/xfs/346
index 90fe5eb..f189b5d 100755
--- a/tests/xfs/346
+++ b/tests/xfs/346
@@ -49,7 +49,7 @@ _supported_os Linux
 _supported_fs xfs
 _require_scratch_reflink
 _require_cp_reflink
-_require_fiemap
+_require_xfs_io_command "fiemap"
 _require_xfs_io_command "cowextsize"
 _require_xfs_io_command "funshare"
 _require_odirect
diff --git a/tests/xfs/347 b/tests/xfs/347
index 2a13977..fbc5ce3 100755
--- a/tests/xfs/347
+++ b/tests/xfs/347
@@ -49,7 +49,7 @@ _supported_os Linux
 _supported_fs xfs
 _require_scratch_reflink
 _require_cp_reflink
-_require_fiemap
+_require_xfs_io_command "fiemap"
 _require_xfs_io_command "cowextsize"
 _require_xfs_io_command "funshare"
 
-- 
1.8.3.1



