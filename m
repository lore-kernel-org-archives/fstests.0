Received: from mx1.redhat.com ([209.132.183.28]:45948 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753144AbdKIIJG (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 9 Nov 2017 03:09:06 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5774C85A02
        for <fstests@vger.kernel.org>; Thu,  9 Nov 2017 08:09:06 +0000 (UTC)
Received: from dhcp-12-148.nay.redhat.com (dhcp-12-148.nay.redhat.com [10.66.12.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4592760BE3
        for <fstests@vger.kernel.org>; Thu,  9 Nov 2017 08:09:05 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH] generic/252: fix aiocp buffer alignment
Date: Thu,  9 Nov 2017 16:09:01 +0800
Message-Id: <20171109080901.11214-1-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

g/252 fails on 4k hard sector size disk, due to aiocp.c use 512
bytes alignment by default. So use the '-a' option of aiocp, to
specify a proper alignment size.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---

Test this patch with below sector size:
TEST_DEV       SCRATCH_DEV
4k             4k
4k             512
512            4k
512            512

All passed.

Thanks,
Zorro

 tests/generic/252 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/generic/252 b/tests/generic/252
index ffedd569..418465b0 100755
--- a/tests/generic/252
+++ b/tests/generic/252
@@ -69,6 +69,7 @@ nr=640
 bufnr=128
 filesize=$((blksz * nr))
 bufsize=$((blksz * bufnr))
+alignment=`_min_dio_alignment $TEST_DEV`
 
 _require_fs_space $SCRATCH_MNT $((filesize / 1024 * 5 / 4))
 
@@ -85,7 +86,7 @@ $XFS_IO_PROG -f -c "pwrite -S 0x63 $bufsize 1" $testdir/file2 >> $seqres.full
 $XFS_IO_PROG -f -c "pwrite -S 0x63 -b $bufsize 0 $filesize" $TEST_DIR/moo >> $seqres.full
 sync
 _dmerror_load_error_table
-$AIO_TEST -f DIRECT -b $bufsize $TEST_DIR/moo $testdir/file2 >> $seqres.full
+$AIO_TEST -a $alignment -f DIRECT -b $bufsize $TEST_DIR/moo $testdir/file2 >> $seqres.full
 _dmerror_load_working_table
 _dmerror_unmount
 _dmerror_mount
-- 
2.13.6

