Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D070C433EF
	for <linux-fstests@archiver.kernel.org>; Sat, 11 Dec 2021 00:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244179AbhLKAh6 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 10 Dec 2021 19:37:58 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:56290 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237517AbhLKAh6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 10 Dec 2021 19:37:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 258C6B821CD
        for <fstests@vger.kernel.org>; Sat, 11 Dec 2021 00:34:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E26C0C00446;
        Sat, 11 Dec 2021 00:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639182860;
        bh=rvGeZ0ICKLJgM7GCRXgd0fL16T4XEgCs9dSpMHVdZvo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R+r4SeGy4fAwMAc+wnycbabfNLBfHow04Ukl2HgULAIwXpOavJ2EiUdNPgINPUdD5
         vO74Sw/drr14UmCsMLPaoxFbftmGD24XrJlYCmcp3nyEoXUXEhkGAmRAOU6nfu1i4o
         4JS88m2Gc0TAoRM86cyUi7kbpYqLqXQ3diupD3BxOYUT2rqo4UybPOQ9Gj3w8XmXnC
         WvVaMTUkndSPFY+bh1Qba1B6PuQkI+Mr/32VwYDjgE6YoXlNou+XtDhv3IoEpk8CFJ
         rMIB3Leb3oVpOV9R90pCDrLY7rAKxeyiPbF+V5hlvnELY6N3WJuI663y7RRsSFQk7w
         A4Y722SFoFiAQ==
Date:   Fri, 10 Dec 2021 16:34:19 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2 04/16] generic: add mmap CoW test for
 holes&destination extents
Message-ID: <20211211003419.GE69210@magnolia>
References: <20211125074752.274176-1-ruansy.fnst@fujitsu.com>
 <20211125074752.274176-5-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211125074752.274176-5-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Nov 25, 2021 at 03:47:40PM +0800, Shiyang Ruan wrote:
> Ensuring that copy on write in mmap mode works when the CoW range originally
> covers multiple extents, some holes, some not.
> (MMAP version of generic/191,190)
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  tests/generic/903     | 59 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/903.out | 12 +++++++++
>  2 files changed, 71 insertions(+)
>  create mode 100755 tests/generic/903
>  create mode 100644 tests/generic/903.out
> 
> diff --git a/tests/generic/903 b/tests/generic/903
> new file mode 100755
> index 00000000..d0de3f26
> --- /dev/null
> +++ b/tests/generic/903
> @@ -0,0 +1,59 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# FS QA Test No. 903
> +#
> +# Ensuring that copy on write in mmap mode works when the CoW
> +# range originally covers multiple extents, some holes, some not.
> +# (MMAP version of generic/191,190)
> +#   - Create a file and truncate a second file.
> +#   - Reflink the odd blocks of the first file into the second file.
> +#   - mmap CoW across the halfway mark, starting with the unwritten extent.
> +#   - Check that the files are now different where we say they're different.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick clone
> +
> +# Import common functions.
> +. ./common/filter
> +. ./common/reflink
> +
> +# real QA test starts here
> +_require_scratch_reflink
> +_require_xfs_io_command "falloc"
> +
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
> +_weave_reflink_holes $blksz $nr $testdir/file1 $testdir/file3 >> $seqres.full
> +_scratch_cycle_mount
> +
> +echo "Compare files"
> +md5sum $testdir/file1 | _filter_scratch
> +md5sum $testdir/file3 | _filter_scratch
> +md5sum $testdir/file3.chk | _filter_scratch
> +
> +echo "mmap CoW across the transition"
> +cowoff=$((filesize / 4))
> +cowsz=$((filesize / 2))
> +mmapsz=$((cowoff + cowsz))
> +_mwrite_byte 0x63 $cowoff $cowsz $mmapsz $testdir/file3 >> $seqres.full
> +_mwrite_byte 0x63 $cowoff $cowsz $mmapsz $testdir/file3.chk >> $seqres.full
> +_scratch_cycle_mount
> +
> +echo "Compare files"
> +md5sum $testdir/file1 | _filter_scratch
> +md5sum $testdir/file3 | _filter_scratch
> +md5sum $testdir/file3.chk | _filter_scratch
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/903.out b/tests/generic/903.out
> new file mode 100644
> index 00000000..bf57acc7
> --- /dev/null
> +++ b/tests/generic/903.out
> @@ -0,0 +1,12 @@
> +QA output created by 903
> +Format and mount
> +Create the original files
> +Compare files
> +bdbcf02ee0aa977795a79d25fcfdccb1  SCRATCH_MNT/test-903/file1
> +fa50dba51826899c372464a153cb2117  SCRATCH_MNT/test-903/file3
> +fa50dba51826899c372464a153cb2117  SCRATCH_MNT/test-903/file3.chk
> +mmap CoW across the transition
> +Compare files
> +bdbcf02ee0aa977795a79d25fcfdccb1  SCRATCH_MNT/test-903/file1
> +09101629908f9bdd5d178e7ce20bb1bb  SCRATCH_MNT/test-903/file3
> +09101629908f9bdd5d178e7ce20bb1bb  SCRATCH_MNT/test-903/file3.chk
> -- 
> 2.34.0
> 
> 
> 
