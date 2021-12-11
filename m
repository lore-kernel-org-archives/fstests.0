Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88864C433F5
	for <linux-fstests@archiver.kernel.org>; Sat, 11 Dec 2021 00:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345504AbhLKAog (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 10 Dec 2021 19:44:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237381AbhLKAog (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 10 Dec 2021 19:44:36 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3FDC061714
        for <fstests@vger.kernel.org>; Fri, 10 Dec 2021 16:41:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9475BCE2DE4
        for <fstests@vger.kernel.org>; Sat, 11 Dec 2021 00:40:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBF7BC00446;
        Sat, 11 Dec 2021 00:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639183256;
        bh=PZaSjPxzBN83BDtWEopRGnqy1hqSsbr8SouI5EJWsLU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J2jmP6/uBBovQtRuMWNa4L7RL3epotVCqrQ2dSKRFaiUzjdTWo4uJj/q3iqHeHnIU
         PW1UuiuFfYHGhR3LpUzXrpsTcFwqkafjJBlDywW/rWhaB2lFH3Y8ECcjYsLAwVov+2
         reVfleI/lMLYX+ZCust3P0qoiJ+9DZ+Tm9fvHxERHQTWl+qFB1cRKVCHrA+PtBnPEb
         G5Zr93lq+RUeAjJZbQ8DALsfJ2iCHHVe5LL7Q4487+9sj3Lebf/nxzIvLVnw/rtlRK
         cC7sSE4mSFTFNNAf0Km8ihknTG/zqOg9KT2J16GdWzpjyPOmAUfcfQzO0xuYXghXYd
         zO6tQe51Yb+jQ==
Date:   Fri, 10 Dec 2021 16:40:56 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2 09/16] generic: add mmap CoW test for holes&source
 extents
Message-ID: <20211211004056.GJ69210@magnolia>
References: <20211125074752.274176-1-ruansy.fnst@fujitsu.com>
 <20211125074752.274176-10-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211125074752.274176-10-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Nov 25, 2021 at 03:47:45PM +0800, Shiyang Ruan wrote:
> Ensuring that copy on write in mmap mode to the source file when the CoW range
> covers holes and regular shared blocks.
> (MMAP version of generic/291,292)
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>

Looks good, and thanks for mentioning which test each of these new ones
came from!

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  tests/generic/908     | 62 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/908.out | 12 +++++++++
>  2 files changed, 74 insertions(+)
>  create mode 100755 tests/generic/908
>  create mode 100644 tests/generic/908.out
> 
> diff --git a/tests/generic/908 b/tests/generic/908
> new file mode 100755
> index 00000000..ad8de699
> --- /dev/null
> +++ b/tests/generic/908
> @@ -0,0 +1,62 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# FS QA Test No. 908
> +#
> +# Ensuring that copy on write in mmap mode to the source file when the
> +# CoW range covers holes and regular shared blocks.
> +# (MMAP version of generic/291,292)
> +#   - Create two files.
> +#   - Truncate the first file.
> +#   - Write the odd blocks of the first file.
> +#   - Reflink the odd blocks of the first file into the second file.
> +#   - mmap CoW the first file across the halfway mark, starting with the
> +#     regular extent.
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
> +_sweave_reflink_holes $blksz $nr $testdir/file1 $testdir/file3 >> $seqres.full
> +_scratch_cycle_mount
> +
> +echo "Compare files"
> +md5sum $testdir/file1 | _filter_scratch
> +md5sum $testdir/file3 | _filter_scratch
> +md5sum $testdir/file1.chk | _filter_scratch
> +
> +echo "mmap CoW across the transition"
> +cowoff=$((filesize / 4))
> +cowsz=$((filesize / 2))
> +mmapsz=$((cowoff + cowsz))
> +_mwrite_byte 0x63 $cowoff $cowsz $mmapsz $testdir/file1 >> $seqres.full
> +_mwrite_byte 0x63 $cowoff $cowsz $mmapsz $testdir/file1.chk >> $seqres.full
> +_scratch_cycle_mount
> +
> +echo "Compare files"
> +md5sum $testdir/file1 | _filter_scratch
> +md5sum $testdir/file3 | _filter_scratch
> +md5sum $testdir/file1.chk | _filter_scratch
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/908.out b/tests/generic/908.out
> new file mode 100644
> index 00000000..c8c670ac
> --- /dev/null
> +++ b/tests/generic/908.out
> @@ -0,0 +1,12 @@
> +QA output created by 908
> +Format and mount
> +Create the original files
> +Compare files
> +b8a8a88d4c143f79900c4b4e79aa3e37  SCRATCH_MNT/test-908/file1
> +ce2023f765eba19677517c511886d5c9  SCRATCH_MNT/test-908/file3
> +b8a8a88d4c143f79900c4b4e79aa3e37  SCRATCH_MNT/test-908/file1.chk
> +mmap CoW across the transition
> +Compare files
> +e8cf59797f0b3758c8878c368bb4cf7e  SCRATCH_MNT/test-908/file1
> +ce2023f765eba19677517c511886d5c9  SCRATCH_MNT/test-908/file3
> +e8cf59797f0b3758c8878c368bb4cf7e  SCRATCH_MNT/test-908/file1.chk
> -- 
> 2.34.0
> 
> 
> 
