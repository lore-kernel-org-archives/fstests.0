Received: from mx2.suse.de ([195.135.220.15]:45475 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751063AbdAPPfe (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 16 Jan 2017 10:35:34 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7A1EDABB2
        for <fstests@vger.kernel.org>; Mon, 16 Jan 2017 15:35:32 +0000 (UTC)
From: David Sterba <dsterba@suse.com>
Subject: [PATCH] common/btrfs: add helper to detect dump-super or btrfs-show-super, fix btrfs/011
Date: Mon, 16 Jan 2017 16:35:12 +0100
Message-Id: <20170116153512.16573-1-dsterba@suse.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
List-ID: <fstests@vger.kernel.org>

The command btrfs-show-super is not supposed to be distributed but was
useful for testing. The same functionality is now present as
'btrfs inspect-internal dump-super', let's detect which one is available
and use it in btrfs/011 that fails with btrfs-progs 4.8.4+ .

Signed-off-by: David Sterba <dsterba@suse.com>
---
 common/btrfs    | 11 +++++++++++
 tests/btrfs/011 |  2 +-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/common/btrfs b/common/btrfs
index c821d54ef291..96c3635bcc51 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -48,6 +48,17 @@ _require_btrfs_qgroup_report()
 	touch ${RESULT_DIR}/require_scratch.require_qgroup_report
 }
 
+_require_btrfs_dump_super()
+{
+	if [ ! -x "$BTRFS_SHOW_SUPER_PROG" ]; then
+		_require_command "$BTRFS_UTIL_PROG" btrfs
+		if ! $BTRFS_UTIL_PROG inspect-internal dump-super --help >& /dev/null; then
+			_notrun "Missing btrfs-show-super or inspect-internal dump-super"
+		fi
+		BTRFS_SHOW_SUPER_PROG="$BTRFS_UTIL_PROG inspect-internal dump-super"
+	fi
+}
+
 _run_btrfs_util_prog()
 {
 	run_check $BTRFS_UTIL_PROG $*
diff --git a/tests/btrfs/011 b/tests/btrfs/011
index 6bc5ba2d51a2..918742717528 100755
--- a/tests/btrfs/011
+++ b/tests/btrfs/011
@@ -62,7 +62,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fs btrfs
 _require_scratch_nocheck
 _require_scratch_dev_pool 4
-_require_command "$BTRFS_SHOW_SUPER_PROG" btrfs-show-super
+_require_btrfs_dump_super
 
 rm -f $seqres.full
 rm -f $tmp.tmp
-- 
2.10.1

