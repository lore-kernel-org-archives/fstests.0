Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A512C433FE
	for <linux-fstests@archiver.kernel.org>; Tue,  2 Nov 2021 15:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E43B660F58
	for <linux-fstests@archiver.kernel.org>; Tue,  2 Nov 2021 15:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234514AbhKBPbP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 2 Nov 2021 11:31:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55786 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234407AbhKBPbO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 2 Nov 2021 11:31:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635866919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t9snIIDkZY/bWfAH54U8CpRlywgDYIc+qdh8YwzrEzM=;
        b=EU9pGPSfpiv7o4YkKAC5vUiSmVvrp30+pB/pLvT7gvSz3ytLaERaR3NxqnoMQ4EBsKmFgQ
        KK00DqrpiAqfOOGggUW5cAMu2ml1+rm0NCMB1+HPPLArvacwvUMsB0zpchb+GQI/hgnwYf
        VlnoysHosD+MAlav7ktAyFbCJEetIV4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-PuLZyPwkMV2inodwxfrHfg-1; Tue, 02 Nov 2021 11:28:38 -0400
X-MC-Unique: PuLZyPwkMV2inodwxfrHfg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3887280A5C1
        for <fstests@vger.kernel.org>; Tue,  2 Nov 2021 15:28:37 +0000 (UTC)
Received: from andromeda.lan (unknown [10.40.193.94])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 911A0694B6
        for <fstests@vger.kernel.org>; Tue,  2 Nov 2021 15:28:36 +0000 (UTC)
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH 2/2] generic/643: Fix for 1k block sizes for ext2 and ext3
Date:   Tue,  2 Nov 2021 16:28:28 +0100
Message-Id: <20211102152828.26895-3-cmaiolino@redhat.com>
In-Reply-To: <20211102152828.26895-1-cmaiolino@redhat.com>
References: <20211102152828.26895-1-cmaiolino@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Currently this test fails on ext2 and ext3 filesystems using 1k block sizes,
because we set the maximum swap size the kernel is allowed to map according to
the mapping kernel created when enabling the original swap file.

But the translation from indirect block mapping to iomap extents associated with
the page alignment requirements imposed by iomap_swapfile_add_extent(), causes
this test to fail. The kernel end up mapping way less pages than the file
actually has.
After the file is extended by the test, the page alignment is not a problem
anymore and the kernel can use the whole space available in the swapfile,
written in its header, and this creates a variance bigger than what the current
test allows, making the tolerance check within the test to fail.

Fix this by using the swap size recorded in the swapfile header (reported by
mkswap), as the maximum swap size the kernel is allowed to map, instead of
reading the swap size mapped by the kernel from /proc.
Since the size hardcoded in the swapfile header is the limit allowed for the
kernel to map as swap area, this is the real limit the kernel can't map beyond,
and what this test should be checking for.

Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
---
 tests/generic/643 | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/tests/generic/643 b/tests/generic/643
index 7a1d3ec7..b7627743 100755
--- a/tests/generic/643
+++ b/tests/generic/643
@@ -36,34 +36,25 @@ _scratch_mount >> $seqres.full
 # Assuming we're not borrowing a FAT16 partition from Windows 3.1, we need an
 # unlikely enough name that we can grep /proc/swaps for this.
 swapfile=$SCRATCH_MNT/386spart.par
-_format_swapfile $swapfile 1m >> $seqres.full
+before_blocks=$(_format_swapfile $swapfile 1m)
 
 page_size=$(getconf PAGE_SIZE)
 
-swapfile_blocks() {
-	local swapfile="$1"
-
-	grep "$swapfile" /proc/swaps | awk '{print $3}'
-}
-
-_swapon_file $swapfile
-before_blocks=$(swapfile_blocks "$swapfile")
-swapoff $swapfile
-
 # Extend the length of the swapfile but do not rewrite the header.
 # The subsequent swapon should set up 1MB worth of blocks, not 2MB.
 $XFS_IO_PROG -f -c 'pwrite 1m 1m' $swapfile >> $seqres.full
 
 _swapon_file $swapfile
-after_blocks=$(swapfile_blocks "$swapfile")
+after_blocks=$(grep "$swapfile" /proc/swaps | awk '{print $3}')
 swapoff $swapfile
 
-# Both swapon attempts should have found approximately the same number of
-# blocks.  Unfortunately, mkswap and the kernel are a little odd -- the number
-# of pages that mkswap writes into the swapfile header is one page less than
-# the file size, and then the kernel itself doesn't always grab all the pages
-# advertised in the header.  Hence we let the number of swap pages increase by
-# two pages.  I'm looking at you, Mr. 64k pages on arm64...
+# The swapon attempt should have found approximately the same number of blocks
+# originally created by the mkswap.
+# Unfortunately, mkswap and the kernel are a little odd -- the number of pages
+# that mkswap writes into the swapfile header is one page less than the file
+# size, and then the kernel itself doesn't always grab all the pages advertised
+# in the header. Such cases include ext2 and ext3 with 1k block size and arm64
+# with its 64k pages. Hence we let the number of swap pages increase by two pages.
 page_variance=$(( page_size / 512 ))
 _within_tolerance "swap blocks" $after_blocks $before_blocks 0 $page_variance -v
 
-- 
2.31.1

