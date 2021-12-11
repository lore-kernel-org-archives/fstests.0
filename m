Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC89AC433F5
	for <linux-fstests@archiver.kernel.org>; Sat, 11 Dec 2021 00:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345480AbhLKAmY (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 10 Dec 2021 19:42:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345465AbhLKAmY (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 10 Dec 2021 19:42:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A44C061714
        for <fstests@vger.kernel.org>; Fri, 10 Dec 2021 16:38:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 70BA1B82A4D
        for <fstests@vger.kernel.org>; Sat, 11 Dec 2021 00:38:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38121C00446;
        Sat, 11 Dec 2021 00:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639183126;
        bh=R2rmGuSdWfcb58EzSEH18fPP3+tUgKV/zrG0mXXUVF4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jQ370fILYx/2pf8T3LKHMWmHz6mCyrxUX+2g9rXLoYjY1CSAY+uPOGRtxnAeS1M3I
         rl8leBQNjuBnlwvggSQ9JW7d3gb9u0qIaxvEgb3BWyFnk8j2ZEYeaAdnfi3BH0VnzV
         NxHCdplYUEhTkrqIGSXOuZxwhXWHB5NtTW1buZp0SltCqzJzLkVDIiw3hzqEK2AidS
         E+fxLYdzdgzyByyiQqbdMHwDrYY0kuP2eUkRS57R3Egpu7Lisru4EWxkbpJjmaYfq0
         SRvtBlGaRKY4UDEDBGKAHlkwpc4Ez8cZByu5jxQi48g6Um59xm6cvg4mrAAat6FcMG
         yGIIylXuWmGAQ==
Date:   Fri, 10 Dec 2021 16:38:45 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2 06/16] generic: add mmap CoW test for
 mixed&destination extents
Message-ID: <20211211003845.GG69210@magnolia>
References: <20211125074752.274176-1-ruansy.fnst@fujitsu.com>
 <20211125074752.274176-7-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211125074752.274176-7-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Nov 25, 2021 at 03:47:42PM +0800, Shiyang Ruan wrote:
> Ensuring that copy on write in mmap mode works when the CoW range originally
> covers multiple extents, mixed with reflinked, unwritten, hole, regular and
> delalloc blocks.
> (MMAP version of generic/200,199)
> 
> Also, add a check to make sure the delalloc block is accutally exist.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  common/reflink        |  3 ++
>  tests/generic/905     | 68 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/905.out | 12 ++++++++
>  3 files changed, 83 insertions(+)
>  create mode 100755 tests/generic/905
>  create mode 100644 tests/generic/905.out
> 
> diff --git a/common/reflink b/common/reflink
> index 38210673..84173d59 100644
> --- a/common/reflink
> +++ b/common/reflink
> @@ -362,6 +362,9 @@ _weave_reflink_rainbow_delalloc() {
>  		_pwrite_byte 0x62 $((blksz * i)) $blksz $dfile
>  		_pwrite_byte 0x62 $((blksz * i)) $blksz $dfile.chk
>  	done
> +	# make sure we actually got delalloc block
> +	$FILEFRAG_PROG -v $dfile 2>&1 | grep -q delalloc || \
> +		_notrun "test requires delayed allocation writes"

Same comment as the previous patch.  generic/905 itself looks like a
straightforward translation of the existing generic/200.

--D

>  }
>  
>  # Make the source file have interleaved regular blocks and reflinked blocks
> diff --git a/tests/generic/905 b/tests/generic/905
> new file mode 100755
> index 00000000..56cdcd27
> --- /dev/null
> +++ b/tests/generic/905
> @@ -0,0 +1,68 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# FS QA Test No. 905
> +#
> +# Ensuring that copy on write in mmap mode works when the CoW
> +# range originally covers multiple extents, mixed with reflinked, unwritten,
> +# hole, regular and delalloc blocks.
> +# (MMAP version of generic/200,199)
> +#   - Create a file with the following repeating sequence of blocks:
> +#     1. reflinked
> +#     2. unwritten
> +#     3. hole
> +#     4. regular block
> +#     5. delalloc
> +#   - mmap CoW across the halfway mark, starting with the unwritten extent.
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
> +_weave_reflink_rainbow $blksz $nr $testdir/file1 $testdir/file3 >> $seqres.full
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
> +_weave_reflink_rainbow_delalloc $blksz $nr $testdir/file3 >> $seqres.full
> +# now cow
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
> diff --git a/tests/generic/905.out b/tests/generic/905.out
> new file mode 100644
> index 00000000..6fb0be5f
> --- /dev/null
> +++ b/tests/generic/905.out
> @@ -0,0 +1,12 @@
> +QA output created by 905
> +Format and mount
> +Create the original files
> +Compare files
> +bdbcf02ee0aa977795a79d25fcfdccb1  SCRATCH_MNT/test-905/file1
> +6366fd359371414186688a0ef6988893  SCRATCH_MNT/test-905/file3
> +6366fd359371414186688a0ef6988893  SCRATCH_MNT/test-905/file3.chk
> +mmap CoW across the transition
> +Compare files
> +bdbcf02ee0aa977795a79d25fcfdccb1  SCRATCH_MNT/test-905/file1
> +26aa3a0749b867ec58363c8539ee5471  SCRATCH_MNT/test-905/file3
> +26aa3a0749b867ec58363c8539ee5471  SCRATCH_MNT/test-905/file3.chk
> -- 
> 2.34.0
> 
> 
> 
