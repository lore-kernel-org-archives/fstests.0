Received: from cn.fujitsu.com ([222.73.24.84]:51022 "EHLO song.cn.fujitsu.com"
        rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1750698AbcKBEOQ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 2 Nov 2016 00:14:16 -0400
From: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
Subject: [PATCH v5 1/2] common/populate: use _require_xfs_io_command() in right place
Date: Wed,  2 Nov 2016 12:07:26 +0800
Message-Id: <20161102040727.5765-1-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, eguan@redhat.com, darrick.wong@oracle.com
List-ID: <fstests@vger.kernel.org>

In original common/populate codes, we put _require_xfs_io_command "falloc" and
_require_xfs_io_command "fpunch" in the begin of common/populate, but it's
not appropriate, for fs, which does not support falloc and punch, will not
be able to use other helper functions in common/populate, so here I choose
to put _require_xfs_io_command "falloc" or "punch" in helper function which
really use falloc and fpunch.

And xfs/120 uses fpunch, add _require_xfs_io_command "fpunch".

Signed-off-by: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
---
 common/populate | 7 ++++---
 tests/xfs/120   | 1 +
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/common/populate b/common/populate
index d0003c5..3b9b531 100644
--- a/common/populate
+++ b/common/populate
@@ -22,9 +22,6 @@
 #  Mountain View, CA 94043, USA, or: http://www.sgi.com
 #-----------------------------------------------------------------------
 
-_require_xfs_io_command "falloc"
-_require_xfs_io_command "fpunch"
-
 _require_xfs_db_blocktrash_z_command() {
 	test "${FSTYP}" = "xfs" || _notrun "cannot run xfs_db on ${FSTYP}"
 	$XFS_DB_PROG -x -f -c 'blocktrash -z' "${TEST_DEV}" | grep -q 'nothing on stack' || _notrun "blocktrash -z not supported"
@@ -90,6 +87,8 @@ __populate_fill_fs() {
 # types of metadata block
 _scratch_xfs_populate() {
 	_scratch_mount
+	_require_xfs_io_command "fpunch"
+
 	blksz="$(stat -f -c '%s' "${SCRATCH_MNT}")"
 	dblksz="$(xfs_info "${SCRATCH_MNT}" | grep naming.*bsize | sed -e 's/^.*bsize=//g' -e 's/\([0-9]*\).*$/\1/g')"
 	leaf_lblk="$((32 * 1073741824 / blksz))"
@@ -192,6 +191,8 @@ _scratch_xfs_populate() {
 # types of metadata block
 _scratch_ext4_populate() {
 	_scratch_mount
+	_require_xfs_io_command "fpunch"
+
 	blksz="$(stat -f -c '%s' "${SCRATCH_MNT}")"
 	dblksz="${blksz}"
 	leaf_lblk="$((32 * 1073741824 / blksz))"
diff --git a/tests/xfs/120 b/tests/xfs/120
index 3deece6..631e2f2 100755
--- a/tests/xfs/120
+++ b/tests/xfs/120
@@ -47,6 +47,7 @@ _cleanup()
 _supported_fs xfs
 _supported_os Linux
 
+_require_xfs_io_command "fpunch"
 _require_scratch
 test -n "${FORCE_FUZZ}" || _require_scratch_xfs_crc
 _require_attrs
-- 
2.9.0



