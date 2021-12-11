Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3909CC433EF
	for <linux-fstests@archiver.kernel.org>; Sat, 11 Dec 2021 00:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345514AbhLKAth (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 10 Dec 2021 19:49:37 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:38924 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237381AbhLKAth (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 10 Dec 2021 19:49:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1F716CE2DDB
        for <fstests@vger.kernel.org>; Sat, 11 Dec 2021 00:46:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1501CC00446;
        Sat, 11 Dec 2021 00:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639183558;
        bh=5Jt4+JQfIjXiJuRHkNz/Hcawv2DpIjwErgjeuEkWq78=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pbXJEdli3ZEJAnQ0XLCn4QbupnLdY17YVV4NlNvmJt1q751ptBMHZKYYnLj2hRu2h
         IrakPMCN8ChpNIiFIg5i1dZWdQRtlSe6HdXj5KhVMwGMbhn7PSL6VrCFBlltKa3Ebj
         UqegM+Xt50E3UGBeAYkZD6X4Vfxul9Av9Wb/38/hLczPqolHUvBKQyqQrY7Pp8SJaS
         Tj8k1HcX68/TqkZpbftLQchauU87bVBuS8wwhpAJFIUL9pFQhQwLBjBsoIk/PXag/A
         bHH7Y+tnvCV8sonH3s158gF/oG3dTciJ0rYkbQhhO14doe1gEN0vxSibKyYCRf0naj
         oYXG4CeaDRxdA==
Date:   Fri, 10 Dec 2021 16:45:57 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2 12/16] generic: add direct-io CoW test for
 mixed&source extents
Message-ID: <20211211004557.GM69210@magnolia>
References: <20211125074752.274176-1-ruansy.fnst@fujitsu.com>
 <20211125074752.274176-13-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211125074752.274176-13-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Nov 25, 2021 at 03:47:48PM +0800, Shiyang Ruan wrote:
> Ensuring that copy on write in buffered mode works when the CoW
> range originally covers multiple extents, mixed with reflinked, unwritten,
> hole, regular and delalloc blocks.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  tests/generic/911     | 66 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/911.out | 12 ++++++++
>  2 files changed, 78 insertions(+)
>  create mode 100755 tests/generic/911
>  create mode 100644 tests/generic/911.out
> 
> diff --git a/tests/generic/911 b/tests/generic/911
> new file mode 100755
> index 00000000..57de8754
> --- /dev/null
> +++ b/tests/generic/911
> @@ -0,0 +1,66 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# FS QA Test No. 911
> +#
> +# Ensuring that copy on write in direct-io mode works when the CoW
> +# range originally covers multiple extents, mixed with reflinked, unwritten,
> +# hole, regular and delalloc blocks.
> +#   - Create a file with the following repeating sequence of blocks:
> +#     1. reflinked
> +#     2. unwritten
> +#     3. hole
> +#     4. regular block
> +#     5. delalloc
> +#   - directio CoW across the halfway mark, starting with the unwritten extent.
> +#   - Check that the files are now different where we say they're different.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick clone punch
> +
> +# Import common functions.
> +. ./common/filter
> +. ./common/reflink
> +
> +# real QA test starts here
> +_require_scratch_reflink
> +_require_xfs_io_command "falloc"
> +_require_xfs_io_command "fpunch"
> +_require_cp_reflink
> +_require_odirect

_requires_command $FILEFRAG_PROG filefrag

Otherwise, this looks like it's ready to go.

--D

> +echo "Format and mount"
> +_scratch_mkfs > $seqres.full 2>&1
> +_scratch_mount >> $seqres.full 2>&1
> +
> +testdir=$SCRATCH_MNT/test-$seq
> +mkdir $testdir
> +
> +echo "Create the original files"
> +blksz=65536
> +nr=64
> +filesize=$((blksz * nr))
> +_sweave_reflink_rainbow $blksz $nr $testdir/file1 $testdir/file3 >> $seqres.full
> +_scratch_cycle_mount
> +
> +echo "Compare files"
> +md5sum $testdir/file1 | _filter_scratch
> +md5sum $testdir/file3 | _filter_scratch
> +md5sum $testdir/file1.chk | _filter_scratch
> +
> +echo "directio CoW across the transition"
> +cowoff=$((filesize / 4))
> +cowsz=$((filesize / 2))
> +_sweave_reflink_rainbow_delalloc $blksz $nr $testdir/file1 >> $seqres.full
> +# now cow
> +$XFS_IO_PROG -d -f -c "pwrite -S 0x63 -b $cowsz $cowoff $cowsz" $testdir/file1 >> $seqres.full
> +_pwrite_byte 0x63 $cowoff $cowsz $testdir/file1.chk >> $seqres.full
> +_scratch_cycle_mount
> +
> +echo "Compare files"
> +md5sum $testdir/file1 | _filter_scratch
> +md5sum $testdir/file3 | _filter_scratch
> +md5sum $testdir/file1.chk | _filter_scratch
> +
> +# success, all done
> +status=0
> diff --git a/tests/generic/911.out b/tests/generic/911.out
> new file mode 100644
> index 00000000..e098fe3c
> --- /dev/null
> +++ b/tests/generic/911.out
> @@ -0,0 +1,12 @@
> +QA output created by 911
> +Format and mount
> +Create the original files
> +Compare files
> +6366fd359371414186688a0ef6988893  SCRATCH_MNT/test-911/file1
> +bdbcf02ee0aa977795a79d25fcfdccb1  SCRATCH_MNT/test-911/file3
> +6366fd359371414186688a0ef6988893  SCRATCH_MNT/test-911/file1.chk
> +directio CoW across the transition
> +Compare files
> +26aa3a0749b867ec58363c8539ee5471  SCRATCH_MNT/test-911/file1
> +bdbcf02ee0aa977795a79d25fcfdccb1  SCRATCH_MNT/test-911/file3
> +26aa3a0749b867ec58363c8539ee5471  SCRATCH_MNT/test-911/file1.chk
> -- 
> 2.34.0
> 
> 
> 
