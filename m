Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82BC4C4338F
	for <linux-fstests@archiver.kernel.org>; Mon, 26 Jul 2021 09:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 612B660F42
	for <linux-fstests@archiver.kernel.org>; Mon, 26 Jul 2021 09:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbhGZJFr (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 26 Jul 2021 05:05:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60967 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232838AbhGZJFp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 26 Jul 2021 05:05:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627292772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=s6SK5ZmzQjZb/M4/7gxH6x1zHwp4rhJ9APsrxcREfwQ=;
        b=fvsvna273aAtb6gFR1Huh0j24KiH29pLiE1yNtcarWhfEAi8RLAJC8+kfR5W5+Hu1gU+JA
        o2QyIRIlByoPGGDcwwkBeMI9ylo1B676oIYPG9S3uWfldKxRp+kOKSb0dncsy5/W9IDerp
        XZ4YK+19JceAkKhLa4kKzT76KucLMIw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-lMcfw1-COK6-IVfIxB--xA-1; Mon, 26 Jul 2021 05:46:10 -0400
X-MC-Unique: lMcfw1-COK6-IVfIxB--xA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7D47106F8C1
        for <fstests@vger.kernel.org>; Mon, 26 Jul 2021 09:46:09 +0000 (UTC)
Received: from zlang-laptop.redhat.com (ovpn-12-86.pek2.redhat.com [10.72.12.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0880C5DAA5
        for <fstests@vger.kernel.org>; Mon, 26 Jul 2021 09:46:08 +0000 (UTC)
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH v5] generic: test small swapfile without page-aligned contiguous blocks
Date:   Mon, 26 Jul 2021 17:46:05 +0800
Message-Id: <20210726094605.513174-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

If a swapfile doesn't contain even a single page-aligned contiguous
range of blocks, it's an invalid swapfile, and might cause kernel
issue. This case covered commit 5808fecc5723 ("iomap: Fix negative
assignment to unsigned sis->pages in iomap_swapfile_activate").

Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
Signed-off-by: Zorro Lang <zlang@redhat.com>
---

Hi,

V5 rebase this case on the latest xfstests, to match the "group info" change:
https://lore.kernel.org/fstests/60d89a67.1c69fb81.86c2c.d6c4@mx.google.com/

Thanks,
Zorro

 tests/generic/640     | 77 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/640.out |  2 ++
 2 files changed, 79 insertions(+)
 create mode 100755 tests/generic/640
 create mode 100644 tests/generic/640.out

diff --git a/tests/generic/640 b/tests/generic/640
new file mode 100755
index 00000000..494fcc1b
--- /dev/null
+++ b/tests/generic/640
@@ -0,0 +1,77 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2021 Red Hat Inc.  All Rights Reserved.
+#
+# FS QA Test 640
+#
+# Test small swapfile which doesn't contain even a single page-aligned contiguous
+# range of blocks. This case covered commit 5808fecc5723 ("iomap: Fix negative
+# assignment to unsigned sis->pages in iomap_swapfile_activate").
+#
+. ./common/preamble
+_begin_fstest auto quick swap
+
+# Import common functions
+. ./common/filter
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
+# Expect EINVAL from swapon. If not, might miss 5808fecc5723 ("iomap: Fix
+# negative assignment to unsigned sis->pages in iomap_swapfile_activate")
+$here/src/swapon $swapfile
+# Further testing, check if swap size <= swapfile size, if swapon passed
+if [ $? -eq 0 ];then
+	swapsize=$(awk -v fname="$swapfile" '{if ($1~fname) print $3}' /proc/swaps)
+	swapsize=$((swapsize * 1024))
+	filesize=$(_get_filesize $swapfile)
+	if [ $swapsize -gt $filesize ]; then
+		echo "Allocated swap size($swapsize) shouldn't be greater than swapfile size($filesize)"
+	fi
+fi
+swapoff $swapfile 2>/dev/null
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/640.out b/tests/generic/640.out
new file mode 100644
index 00000000..e1ab5390
--- /dev/null
+++ b/tests/generic/640.out
@@ -0,0 +1,2 @@
+QA output created by 640
+swapon: Invalid argument
-- 
2.31.1

