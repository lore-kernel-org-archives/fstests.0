Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CD1C433F5
	for <linux-fstests@archiver.kernel.org>; Fri,  8 Apr 2022 17:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234680AbiDHRLE (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 8 Apr 2022 13:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbiDHRLD (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 8 Apr 2022 13:11:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 973D4FFF66
        for <fstests@vger.kernel.org>; Fri,  8 Apr 2022 10:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649437738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=8Su7Zqp9VbuppjomnYRpDpVcC1p6fHHYKDULtx5+etk=;
        b=TMRkT0AReGD/qmAmu/mdgWxNpAg93/VooJHzh8hqoIcHBrjNbf08gMGWh5jDz9F7AEoEJV
        ZWWJHWNhnq5XRTe7nWuW98qoNvTIPeBPS8PaDz9SLVN+07bnu3nd6NLia7VIkmuuyRaf2+
        JvselCBHsQ3iwzdmlV1iuKYeXpRmJQU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-9ePI9cqJPFO0Vi4UARFPgg-1; Fri, 08 Apr 2022 13:08:57 -0400
X-MC-Unique: 9ePI9cqJPFO0Vi4UARFPgg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 56CA2811E80
        for <fstests@vger.kernel.org>; Fri,  8 Apr 2022 17:08:57 +0000 (UTC)
Received: from zlang-laptop.redhat.com (ovpn-12-61.pek2.redhat.com [10.72.12.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1AB272024CC6
        for <fstests@vger.kernel.org>; Fri,  8 Apr 2022 17:08:55 +0000 (UTC)
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH v2] xfs: test xfsdump when an inode < root inode is present
Date:   Sat,  9 Apr 2022 01:08:47 +0800
Message-Id: <20220408170847.1088522-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Eric Sandeen <sandeen@redhat.com>

This tests a longstanding bug where xfsdumps are not properly
created when an inode is present on the filesytsem which has
a lower number than the root inode.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
Signed-off-by: Zorro Lang <zlang@redhat.com>
---

Friendly ping for reviewing.

Thanks,
Zorro

 common/dump       |  1 +
 tests/xfs/543     | 63 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/543.out | 47 +++++++++++++++++++++++++++++++++++
 3 files changed, 111 insertions(+)
 create mode 100755 tests/xfs/543
 create mode 100644 tests/xfs/543.out

diff --git a/common/dump b/common/dump
index ea16d442..ab48cd13 100644
--- a/common/dump
+++ b/common/dump
@@ -219,6 +219,7 @@ _require_tape()
 
 _wipe_fs()
 {
+    [[ "$WIPE_FS" = "no" ]] && return
     _require_scratch
 
     _scratch_mkfs_xfs >>$seqres.full || _fail "mkfs failed"
diff --git a/tests/xfs/543 b/tests/xfs/543
new file mode 100755
index 00000000..4e3c823a
--- /dev/null
+++ b/tests/xfs/543
@@ -0,0 +1,63 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 Red Hat, Inc. All Rights Reserved.
+#
+# FS QA Test 543
+#
+# Create a filesystem which contains an inode with a lower number
+# than the root inode. Ensure that xfsdump/xfsrestore handles this.
+#
+. ./common/preamble
+_begin_fstest auto quick dump
+
+# Import common functions.
+. ./common/dump
+
+_supported_fs xfs
+_require_scratch
+
+# A large stripe unit will put the root inode out quite far
+# due to alignment, leaving free blocks ahead of it.
+_scratch_mkfs_xfs -d sunit=1024,swidth=1024 > $seqres.full 2>&1
+
+# Mounting /without/ a stripe should allow inodes to be allocated
+# in lower free blocks, without the stripe alignment.
+_scratch_mount -o sunit=0,swidth=0
+
+root_inum=$(stat -c %i $SCRATCH_MNT)
+
+# Consume space after the root inode so that the blocks before
+# root look "close" for the next inode chunk allocation
+$XFS_IO_PROG -f -c "falloc 0 16m" $SCRATCH_MNT/fillfile
+
+# And make a bunch of inodes until we (hopefully) get one lower
+# than root, in a new inode chunk.
+echo "root_inum: $root_inum" >> $seqres.full
+for i in $(seq 0 4096) ; do
+	fname=$SCRATCH_MNT/$(printf "FILE_%03d" $i)
+	touch $fname
+	inum=$(stat -c "%i" $fname)
+	[[ $inum -lt $root_inum ]] && break
+done
+
+echo "created: $inum" >> $seqres.full
+
+[[ $inum -lt $root_inum ]] || _notrun "Could not set up test"
+
+# Now try a dump and restore. Cribbed from xfs/068
+WIPE_FS="no"
+_create_dumpdir_stress
+
+echo -n "Before: " >> $seqres.full
+_count_dumpdir_files | tee $tmp.before >> $seqres.full
+
+# filter out the file count, it changes as fsstress adds new operations
+_do_dump_restore | sed -e "/entries processed$/s/[0-9][0-9]*/NUM/g"
+
+echo -n "After: " >> $seqres.full
+_count_restoredir_files | tee $tmp.after >> $seqres.full
+diff -u $tmp.before $tmp.after
+
+# success, all done
+status=0
+exit
diff --git a/tests/xfs/543.out b/tests/xfs/543.out
new file mode 100644
index 00000000..a5224aaf
--- /dev/null
+++ b/tests/xfs/543.out
@@ -0,0 +1,47 @@
+QA output created by 543
+Creating directory system to dump using fsstress.
+
+-----------------------------------------------
+fsstress : -f link=10 -f creat=10 -f mkdir=10 -f truncate=5 -f symlink=10
+-----------------------------------------------
+xfsdump|xfsrestore ...
+xfsdump  -s DUMP_SUBDIR - SCRATCH_MNT | xfsrestore  - RESTORE_DIR
+xfsrestore: using file dump (drive_simple) strategy
+xfsrestore: searching media for dump
+xfsrestore: examining media file 0
+xfsrestore: dump description: 
+xfsrestore: hostname: HOSTNAME
+xfsrestore: mount point: SCRATCH_MNT
+xfsrestore: volume: SCRATCH_DEV
+xfsrestore: session time: TIME
+xfsrestore: level: 0
+xfsrestore: session label: ""
+xfsrestore: media label: ""
+xfsrestore: file system ID: ID
+xfsrestore: session id: ID
+xfsrestore: media ID: ID
+xfsrestore: searching media for directory dump
+xfsrestore: reading directories
+xfsrestore: NUM directories and NUM entries processed
+xfsrestore: directory post-processing
+xfsrestore: restoring non-directory files
+xfsrestore: restore complete: SECS seconds elapsed
+xfsrestore: Restore Status: SUCCESS
+xfsdump: using file dump (drive_simple) strategy
+xfsdump: level 0 dump of HOSTNAME:SCRATCH_MNT
+xfsdump: dump date: DATE
+xfsdump: session id: ID
+xfsdump: session label: ""
+xfsdump: ino map <PHASES>
+xfsdump: ino map construction complete
+xfsdump: estimated dump size: NUM bytes
+xfsdump: /var/xfsdump/inventory created
+xfsdump: creating dump session media file 0 (media 0, file 0)
+xfsdump: dumping ino map
+xfsdump: dumping directories
+xfsdump: dumping non-directory files
+xfsdump: ending media file
+xfsdump: media file size NUM bytes
+xfsdump: dump size (non-dir files) : NUM bytes
+xfsdump: dump complete: SECS seconds elapsed
+xfsdump: Dump Status: SUCCESS
-- 
2.31.1

