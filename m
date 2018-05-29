Received: from mx2.suse.de ([195.135.220.15]:39111 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935486AbeE2Q4I (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 29 May 2018 12:56:08 -0400
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6642AADA5
        for <fstests@vger.kernel.org>; Tue, 29 May 2018 16:56:05 +0000 (UTC)
From: Jan Kara <jack@suse.cz>
Subject: [PATCH 5/6] ext4/010: Fixup resize2fs and dumpe2fs usage
Date: Tue, 29 May 2018 18:56:00 +0200
Message-Id: <20180529165601.32133-6-jack@suse.cz>
In-Reply-To: <20180529165601.32133-1-jack@suse.cz>
References: <20180529165601.32133-1-jack@suse.cz>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>
List-ID: <fstests@vger.kernel.org>

Use $RESIZE2FS_PROG and $DUMPE2FS_PROG instead of names directly to make
progs be executed with full path. Also add proper feature test macros.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 tests/ext4/010 | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tests/ext4/010 b/tests/ext4/010
index c877bd7af43f..37ba2aaa7c85 100755
--- a/tests/ext4/010
+++ b/tests/ext4/010
@@ -47,8 +47,10 @@ _supported_fs ext4
 _supported_os Linux
 
 _require_scratch
+_require_dumpe2fs
 test -n "${FORCE_FUZZ}" || _require_scratch_ext4_crc
 _require_attrs
+_require_command "$RESIZE2FS_PROG" resize2fs
 
 rm -f $seqres.full
 TESTDIR="${SCRATCH_MNT}/scratchdir"
@@ -56,9 +58,9 @@ TESTFILE="${TESTDIR}/testfile"
 
 echo "+ create scratch fs"
 _scratch_mkfs_ext4 > /dev/null 2>&1
-dumpe2fs -g "${SCRATCH_DEV}" > /dev/null 2>&1 || _notrun "dumpe2fs -g not supported"
-resize2fs -M "${SCRATCH_DEV}" >> $seqres.full 2>&1
-nr_groups="$(dumpe2fs -g "${SCRATCH_DEV}" 2> /dev/null | tail -n 1 | cut -d : -f 1)"
+$DUMPE2FS_PROG -g "${SCRATCH_DEV}" > /dev/null 2>&1 || _notrun "dumpe2fs -g not supported"
+$RESIZE2FS_PROG -M "${SCRATCH_DEV}" >> $seqres.full 2>&1
+nr_groups="$($DUMPE2FS_PROG -g "${SCRATCH_DEV}" 2> /dev/null | tail -n 1 | cut -d : -f 1)"
 
 echo "+ mount fs image"
 _scratch_mount
@@ -74,7 +76,7 @@ echo "+ check fs"
 e2fsck -fn "${SCRATCH_DEV}" >> $seqres.full 2>&1 || _fail "fsck should not fail"
 
 echo "+ corrupt image"
-dumpe2fs -g "${SCRATCH_DEV}" 2>/dev/null | awk -F ':' '{if (int($6) > 0) {print $6}}' | while read blk; do
+$DUMPE2FS_PROG -g "${SCRATCH_DEV}" 2>/dev/null | awk -F ':' '{if (int($6) > 0) {print $6}}' | while read blk; do
 	debugfs -w -n -R "zap_block ${blk}" "${SCRATCH_DEV}" >> $seqres.full 2>&1 || _fail "inode bitmap fuzz failed"
 done
 
-- 
2.13.6

