Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D2DC433F5
	for <linux-fstests@archiver.kernel.org>; Sat, 11 Dec 2021 00:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241568AbhLKAhI (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 10 Dec 2021 19:37:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237517AbhLKAhI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 10 Dec 2021 19:37:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5C1C061714
        for <fstests@vger.kernel.org>; Fri, 10 Dec 2021 16:33:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3F718B82A17
        for <fstests@vger.kernel.org>; Sat, 11 Dec 2021 00:33:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2733C00446;
        Sat, 11 Dec 2021 00:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639182809;
        bh=MMTSCtO1XEOJCLC+157GpyA6ILpLgSNuoL9rRnkHhgY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d6EXpiLIAGyYo1Av9Ic+duunCNrGdmzwUS7bhzU5k+NqbAVK3QlsBkHwvk79lW/i4
         xtniIfmY6iGymTFVkSK2T6gj+VbfVkIlNN+0dqRB2UvBbZp5MLwNm9Xu21kx3XTPf1
         7ys5Oj/bea5T18xJdM3M7yU4ei88TTImxcqPupfFoYxC8r4fDkCdaaYeMOG4jZkPsQ
         U4cplEOA3/qrd57xjytugXS+U3HzrcTPZ7QysPQcCYIX6mg7gos4FZjuGJrHgmvwyB
         /rg447H0ADhqsU/TekKA5FeQToKVF7tVmUpE4PW67hJXSfOYuSTeV+6sjGx6jzcB5D
         L+XHrXLRxS0pg==
Date:   Fri, 10 Dec 2021 16:33:29 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2 03/16] generic: add mmap CoW test for
 unwritten&destination extents
Message-ID: <20211211003329.GD69210@magnolia>
References: <20211125074752.274176-1-ruansy.fnst@fujitsu.com>
 <20211125074752.274176-4-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211125074752.274176-4-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Nov 25, 2021 at 03:47:39PM +0800, Shiyang Ruan wrote:
> Ensuring that copy on write in mmap mode works when the CoW range originally
> covers multiple extents, some unwritten, some not.
> (MMAP version of generic/189,188)
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>

At first I was a little concerned that _mwrite'ing file3.chk could
result in us failing to notice a bug in the mmap write paths that hits
both reflink and cow writes, but then I realized that this is one of
those tests that encode the md5sum in the golden output, so of course
we'd notice.  I think this looks good, so:

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  tests/generic/902     | 59 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/902.out | 12 +++++++++
>  2 files changed, 71 insertions(+)
>  create mode 100755 tests/generic/902
>  create mode 100644 tests/generic/902.out
> 
> diff --git a/tests/generic/902 b/tests/generic/902
> new file mode 100755
> index 00000000..457b039a
> --- /dev/null
> +++ b/tests/generic/902
> @@ -0,0 +1,59 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# FS QA Test No. 902
> +#
> +# Ensuring that copy on write in mmap mode works when the CoW
> +# range originally covers multiple extents, some unwritten, some not.
> +# (MMAP version of generic/189,188)
> +#   - Create a file and fallocate a second file.
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
> +_weave_reflink_unwritten $blksz $nr $testdir/file1 $testdir/file3 >> $seqres.full
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
> diff --git a/tests/generic/902.out b/tests/generic/902.out
> new file mode 100644
> index 00000000..bc951255
> --- /dev/null
> +++ b/tests/generic/902.out
> @@ -0,0 +1,12 @@
> +QA output created by 902
> +Format and mount
> +Create the original files
> +Compare files
> +bdbcf02ee0aa977795a79d25fcfdccb1  SCRATCH_MNT/test-902/file1
> +fa50dba51826899c372464a153cb2117  SCRATCH_MNT/test-902/file3
> +fa50dba51826899c372464a153cb2117  SCRATCH_MNT/test-902/file3.chk
> +mmap CoW across the transition
> +Compare files
> +bdbcf02ee0aa977795a79d25fcfdccb1  SCRATCH_MNT/test-902/file1
> +09101629908f9bdd5d178e7ce20bb1bb  SCRATCH_MNT/test-902/file3
> +09101629908f9bdd5d178e7ce20bb1bb  SCRATCH_MNT/test-902/file3.chk
> -- 
> 2.34.0
> 
> 
> 
