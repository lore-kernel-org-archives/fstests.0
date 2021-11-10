Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5667C433FE
	for <linux-fstests@archiver.kernel.org>; Wed, 10 Nov 2021 12:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF1C961168
	for <linux-fstests@archiver.kernel.org>; Wed, 10 Nov 2021 12:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbhKJMoT (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 10 Nov 2021 07:44:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:35535 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231472AbhKJMoT (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 10 Nov 2021 07:44:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636548091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OypIIn1QXUpEu2Tgbw0ep5Akw5mv1ZMmJglEvcPEv7U=;
        b=BAvi6Jt3aF6NyYEERx4FKZT+lhi0K3RTo1KDMTy6I2f4NwTrwRUHkUt/JbrWe5s4AEL/cI
        7eSqOexBfEoLu3xrDVmO5f7KgouoVT2zFBCS2j1pU0WDsVkxYFZE4dlB61F830LU1635+I
        QSSzwrikUFMqaLrZAPI0lXCvynJ9YBM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-1EcnndUsO0-msZNFm8dgbQ-1; Wed, 10 Nov 2021 07:41:30 -0500
X-MC-Unique: 1EcnndUsO0-msZNFm8dgbQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1BDC2104FC0D
        for <fstests@vger.kernel.org>; Wed, 10 Nov 2021 12:41:29 +0000 (UTC)
Received: from andromeda.lan (unknown [10.40.193.231])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8528E5D9DE
        for <fstests@vger.kernel.org>; Wed, 10 Nov 2021 12:41:28 +0000 (UTC)
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH V2 2/2] generic/643: Fix for 1k block sizes for ext2 and ext3
Date:   Wed, 10 Nov 2021 13:41:19 +0100
Message-Id: <20211110124119.43974-3-cmaiolino@redhat.com>
In-Reply-To: <20211110124119.43974-1-cmaiolino@redhat.com>
References: <20211110124119.43974-1-cmaiolino@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
reading the swap size mapped by the kernel from /proc. This also makes
the first swap{on/off} cycle unnecessary, so remove it.

Since the size hardcoded in the swapfile header is the limit allowed for the
kernel to map as swap area, this is the real limit the kernel can't map beyond,
and what this test should be checking for.

This patch also slightly changes the way the test check the swap size
'after' the swap file is extended. Instead of retrieving the information
from /proc/swaps directly, the test now relies on 'swapon' tool. This
enables the test to retrieve the swap size in bytes directly, same unit
returned by _format_swapfile. This avoid possible miscalculations caused by
retrieving swap size in different units.

Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
---
V2:
	- use swapon to retrieve swap size instead of reading
	  /proc/swaps
	- rephrase patch's description

 tests/generic/643 | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/tests/generic/643 b/tests/generic/643
index 7a1d3ec7..9a0ec2c3 100755
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
+after_blocks=$(swapon --show --bytes |grep $swapfile | awk '{print $3}')
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

