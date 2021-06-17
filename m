Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D7B5C2B9F4
	for <linux-fstests@archiver.kernel.org>; Thu, 17 Jun 2021 05:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6931F6128C
	for <linux-fstests@archiver.kernel.org>; Thu, 17 Jun 2021 05:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbhFQFHr (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 17 Jun 2021 01:07:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48735 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229551AbhFQFHr (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 17 Jun 2021 01:07:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623906340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=a49kdpoU+HeoLAUHit+7/Dd4HTyKxXimmh5gQrIVRmA=;
        b=hsXmleBa4tE1X4AhPW+xHnNyGSsxHp+7ppgWs7N1n0mZ3fB1E6B8HTykdWmKNLtC0zDi5j
        gIoLsEB5OS9fnPCz0JfXzhAMJY8KO1iaQcszsfT82g+yLrhQPsMr3rTSwAMiLIeu9+wYOi
        Q0yxUU35JtpnY+4NMRRphMPbDi/cxB0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-ogZjKsHgMViUY0i9P45I4g-1; Thu, 17 Jun 2021 01:05:38 -0400
X-MC-Unique: ogZjKsHgMViUY0i9P45I4g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D199DF8A4
        for <fstests@vger.kernel.org>; Thu, 17 Jun 2021 05:05:37 +0000 (UTC)
Received: from zlang-laptop.redhat.com (ovpn-12-111.pek2.redhat.com [10.72.12.111])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8AF0018AD4
        for <fstests@vger.kernel.org>; Thu, 17 Jun 2021 05:05:36 +0000 (UTC)
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH v3] generic: test small swapfile without page-aligned contiguous blocks
Date:   Thu, 17 Jun 2021 13:05:25 +0800
Message-Id: <20210617050525.902967-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

If a swapfile doesn't contain even a single page-aligned contiguous
range of blocks, it's an invalid swapfile, and might cause kernel
issue. This case covered commit 5808fecc5723 ("iomap: Fix negative
assignment to unsigned sis->pages in iomap_swapfile_activate").

Signed-off-by: Zorro Lang <zlang@redhat.com>
---

Thanks the review from Darrick, V3 did below changes:
1) Add _require_xfs_io_command fcollapse
2) Change the notrun output if block size isn't 1024.

Thanks,
Zorro

 tests/generic/639     | 83 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/639.out |  2 ++
 tests/generic/group   |  1 +
 3 files changed, 86 insertions(+)
 create mode 100755 tests/generic/639
 create mode 100644 tests/generic/639.out

diff --git a/tests/generic/639 b/tests/generic/639
new file mode 100755
index 00000000..c8d0c6c5
--- /dev/null
+++ b/tests/generic/639
@@ -0,0 +1,83 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2021 Red Hat Inc.  All Rights Reserved.
+#
+# FS QA Test No. 639
+#
+# Test small swapfile which doesn't contain even a single page-aligned contiguous
+# range of blocks. This case covered commit 5808fecc5723 ("iomap: Fix negative
+# assignment to unsigned sis->pages in iomap_swapfile_activate").
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+_supported_fs generic
+_require_scratch
+_require_scratch_swapfile
+_require_test_program mkswap
+_require_test_program swapon
+_require_xfs_io_command fcollapse
+
+make_unaligned_swapfile()
+{
+	local fname=$1
+	local n=$((psize / bsize - 1))
+
+	# Make sure the swapfile doesn't contain even a single page-aligned
+	# contiguous range of blocks. This's necessary to cover the bug
+	$XFS_IO_PROG -f -t -c "pwrite 0 $(((psize + bsize) * n))" $fname >> $seqres.full 2>&1
+	for((i=1; i<=n; i++));do
+		$XFS_IO_PROG -c "fcollapse $(((psize - bsize) * i)) $bsize" $fname
+	done
+	chmod 0600 $fname
+	$CHATTR_PROG +C $fname > /dev/null 2>&1
+	$here/src/mkswap $fname
+}
+
+_scratch_mkfs >> $seqres.full 2>&1
+_scratch_mount
+psize=`get_page_size`
+bsize=`_get_file_block_size $SCRATCH_MNT`
+# Due to we need page-unaligned blocks, so blocksize < pagesize is necessary.
+# If not, try to make a smaller enough block size
+if [ $bsize -ge $psize ];then
+	_scratch_unmount
+	_scratch_mkfs_blocksized 1024 >> $seqres.full 2>&1
+	if [ $? -ne 0 ];then
+		_notrun "Can't make filesystem block size < page size."
+	fi
+	_scratch_mount
+	bsize=`_get_file_block_size $SCRATCH_MNT`
+	if [ $bsize -ne 1024 ];then
+		_notrun "Can't force 1024-byte file block size."
+	fi
+fi
+swapfile=$SCRATCH_MNT/$seq.swapfile
+make_unaligned_swapfile $swapfile
+$here/src/swapon $swapfile
+swapoff $swapfile
+
+echo "Silence is golden"
+# success, all done
+status=0
+exit
diff --git a/tests/generic/639.out b/tests/generic/639.out
new file mode 100644
index 00000000..62c66537
--- /dev/null
+++ b/tests/generic/639.out
@@ -0,0 +1,2 @@
+QA output created by 639
+Silence is golden
diff --git a/tests/generic/group b/tests/generic/group
index 9a636b23..48ffa3c7 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -641,3 +641,4 @@
 636 auto quick swap
 637 auto quick dir
 638 auto quick rw
+639 auto quick swap
-- 
2.31.1

