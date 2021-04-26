Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1055C433ED
	for <linux-fstests@archiver.kernel.org>; Mon, 26 Apr 2021 14:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A12526115C
	for <linux-fstests@archiver.kernel.org>; Mon, 26 Apr 2021 14:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbhDZO5Q (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 26 Apr 2021 10:57:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33332 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233471AbhDZO5P (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 26 Apr 2021 10:57:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619448994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/zDjpAuN7jBALZx0MhXiu4ugiSArIGtb8ChEIKjlxL0=;
        b=Qn4OA6o5Yni7JgXgCivLBd28Z5BnX4S3VyqeIhH1aZ6wEbAqECywj+l6bNK9yu6GuAKHca
        dlbzNsUXm6XncV830pwaKlnZGdp14vk42PsZdp+Pp3rp2WznBKXiAESSBX0hfDQmddPyJZ
        NHAtysGtFKqLVbES1+eTvgRTVAyhyDs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-NaK07Vs8PeSzV8JoVVUdqA-1; Mon, 26 Apr 2021 10:56:29 -0400
X-MC-Unique: NaK07Vs8PeSzV8JoVVUdqA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00B3A1926DA1
        for <fstests@vger.kernel.org>; Mon, 26 Apr 2021 14:56:29 +0000 (UTC)
Received: from localhost.localdomain (bootp-73-5-251.rhts.eng.pek2.redhat.com [10.73.5.251])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 248DB6086F;
        Mon, 26 Apr 2021 14:56:26 +0000 (UTC)
From:   bxue@redhat.com
To:     fstests@vger.kernel.org
Cc:     bfoster@redhat.com, minlei@redhat.com, lczerner@redhat.com,
        Boyang Xue <bxue@redhat.com>
Subject: [PATCH v3] generic/563: tolerate small reads in "write -> read/write" sub-test
Date:   Mon, 26 Apr 2021 22:56:20 +0800
Message-Id: <20210426145620.1174139-1-bxue@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Boyang Xue <bxue@redhat.com>

On ext2/ext3, it's expected that several single block metadata reads can occur
when writing to file in the same cgroup (the stack is like below[1]). The
purpose of the "write -> read/write" subtest is to make sure the larger pwrite
is accounted to the correct cgroup, not necessarily enforce that zero bytes are
read in service of the write. This patch fixes the sub-test in order to tolerate
small reads in 1st cgroup.

[1] Callchain of the read:

@ext3_read_bio[
    submit_bio+1
    submit_bh_wbc+365
    ext4_read_bh+72
    ext4_get_branch+201
    ext4_ind_map_blocks+382
    ext4_map_blocks+295
    _ext4_get_block+170
    __block_write_begin_int+328
    ext4_write_begin+541
    generic_perform_write+213
    ext4_buffered_write_iter+167
    new_sync_write+345
    vfs_write+438
    __x64_sys_pwrite64+140
    do_syscall_64+51
    entry_SYSCALL_64_after_hwframe+68
, 5793, 12]: 3

Signed-off-by: Boyang Xue <bxue@redhat.com>
---
Hi,

This patch fix the "write -> read/write" sub-test in order to tolerate
small reads in service of the write (like read metadata).

Change from v2:
Restore write tolerance to 5%, to match the historical behavior of the
test.

Thanks,
Boyang

 tests/generic/563 | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/tests/generic/563 b/tests/generic/563
index b113eacf..e73acebd 100755
--- a/tests/generic/563
+++ b/tests/generic/563
@@ -60,6 +60,8 @@ check_cg()
 	cgname=$(basename $cgroot)
 	expectedread=$2
 	expectedwrite=$3
+	readtol=$4
+	writetol=$5
 	rbytes=0
 	wbytes=0
 
@@ -71,8 +73,8 @@ check_cg()
 			awk -F = '{ print $2 }'`
 	fi
 
-	_within_tolerance "read" $rbytes $expectedread 5% -v
-	_within_tolerance "write" $wbytes $expectedwrite 5% -v
+	_within_tolerance "read" $rbytes $expectedread $readtol -v
+	_within_tolerance "write" $wbytes $expectedwrite $writetol -v
 }
 
 # Move current process to another cgroup.
@@ -113,7 +115,7 @@ $XFS_IO_PROG -c "pread 0 $iosize" -c "pwrite 0 $iosize" -c fsync \
 	$SCRATCH_MNT/file >> $seqres.full 2>&1
 switch_cg $cgdir
 $XFS_IO_PROG -c fsync $SCRATCH_MNT/file
-check_cg $cgdir/$seq-cg $iosize $iosize
+check_cg $cgdir/$seq-cg $iosize $iosize 5% 5%
 
 # Write from one cgroup then read and write from a second. Writes are charged to
 # the first group and nothing to the second.
@@ -126,8 +128,12 @@ $XFS_IO_PROG -c "pread 0 $iosize" -c "pwrite 0 $iosize" $SCRATCH_MNT/file \
 	>> $seqres.full 2>&1
 switch_cg $cgdir
 $XFS_IO_PROG -c fsync $SCRATCH_MNT/file
-check_cg $cgdir/$seq-cg 0 $iosize
-check_cg $cgdir/$seq-cg-2 0 0
+# Use a fixed value tolerance for the expected value of zero here
+# because filesystems might perform a small number of metadata reads to
+# complete the write. On ext2/3 with 1k block size, the read bytes is
+# as large as 33792.
+check_cg $cgdir/$seq-cg 0 $iosize 33792 5%
+check_cg $cgdir/$seq-cg-2 0 0 0 0
 
 # Read from one cgroup, read & write from a second. Both reads and writes are
 # charged to the first group and nothing to the second.
@@ -140,8 +146,8 @@ $XFS_IO_PROG -c "pread 0 $iosize" -c "pwrite 0 $iosize" $SCRATCH_MNT/file \
 	>> $seqres.full 2>&1
 switch_cg $cgdir
 $XFS_IO_PROG -c fsync $SCRATCH_MNT/file
-check_cg $cgdir/$seq-cg $iosize $iosize
-check_cg $cgdir/$seq-cg-2 0 0
+check_cg $cgdir/$seq-cg $iosize $iosize 5% 5%
+check_cg $cgdir/$seq-cg-2 0 0 0 0
 
 echo "-io" > $cgdir/cgroup.subtree_control || _fail "subtree control"
 
-- 
2.27.0

