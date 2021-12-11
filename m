Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFEF2C433EF
	for <linux-fstests@archiver.kernel.org>; Sat, 11 Dec 2021 00:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345421AbhLKAaS (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 10 Dec 2021 19:30:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244258AbhLKAaS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 10 Dec 2021 19:30:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B9EC061714
        for <fstests@vger.kernel.org>; Fri, 10 Dec 2021 16:26:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D99EB82A17
        for <fstests@vger.kernel.org>; Sat, 11 Dec 2021 00:26:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 298C2C00446;
        Sat, 11 Dec 2021 00:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639182400;
        bh=1igxaOEdjJ8gyDJjgxwn1L4JKprMS0ZU0Ui74LafY44=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p3NW+CWvDbIcRXLlP+JIpTFEgLbA/w077cc4XmHS6gE6+9ueQL6jV9k3zzGd1ReoL
         PiXfQiWi1D2saeObOBSQu3PDuG2JCBtp5G7PFJgDbrhQWgJjSoYbHzGslJy+xlMR3+
         9Wu8EC9jxwmaHV6A5Ii/rl6N7JJ0vQT9qox897fyfOoEDsV5nj4huqNMwF3DuyVT3m
         fie1ohS7QllpD1JrHYMpvHylReVLwEnSyehqfagLavrfzt4cthw9QCW15H7nj11CQT
         STEBXd8gYeVrl4AwrEkk87Qt/Vg0runAbX80dZhZjpBOvbn7bgYSQN0JgnqXhNYc3v
         eUyEBA481QNUw==
Date:   Fri, 10 Dec 2021 16:26:39 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2 01/16] generic: add mmap CoW test for ranges of two
 shared files
Message-ID: <20211211002639.GB69210@magnolia>
References: <20211125074752.274176-1-ruansy.fnst@fujitsu.com>
 <20211125074752.274176-2-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211125074752.274176-2-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Nov 25, 2021 at 03:47:37PM +0800, Shiyang Ruan wrote:
> Ensuring that copy on write in mmap mode works when the CoW range originally
> covers multiple extents. (MMAP version of generic/185,183)
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>

Looks good,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  tests/generic/900     | 69 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/900.out | 14 +++++++++
>  2 files changed, 83 insertions(+)
>  create mode 100755 tests/generic/900
>  create mode 100644 tests/generic/900.out
> 
> diff --git a/tests/generic/900 b/tests/generic/900
> new file mode 100755
> index 00000000..de76cd00
> --- /dev/null
> +++ b/tests/generic/900
> @@ -0,0 +1,69 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# FS QA Test No. 900
> +#
> +# Ensuring that copy on write in mmap mode works when the CoW
> +# range originally covers multiple extents. (MMAP version of generic/185,183)
> +#   - Create two files
> +#   - Reflink the odd blocks of the first file into a third file.
> +#   - Reflink the even blocks of the second file into the third file.
> +#   - mmap CoW across the halfway mark.
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
> +_pwrite_byte 0x61 0 $filesize $testdir/file1 >> $seqres.full
> +_pwrite_byte 0x62 0 $filesize $testdir/file2 >> $seqres.full
> +seq 0 2 $((nr-1)) | while read f; do
> +	_reflink_range $testdir/file1 $((blksz * f)) $testdir/file3 $((blksz * f)) $blksz >> $seqres.full
> +	_pwrite_byte 0x61 $((blksz * f)) $blksz $testdir/file3.chk >> $seqres.full
> +done
> +seq 1 2 $((nr-1)) | while read f; do
> +	_reflink_range $testdir/file2 $((blksz * f)) $testdir/file3 $((blksz * f)) $blksz >> $seqres.full
> +	_pwrite_byte 0x62 $((blksz * f)) $blksz $testdir/file3.chk >> $seqres.full
> +done
> +_scratch_cycle_mount
> +
> +echo "Compare files"
> +md5sum $testdir/file1 | _filter_scratch
> +md5sum $testdir/file2 | _filter_scratch
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
> +md5sum $testdir/file2 | _filter_scratch
> +md5sum $testdir/file3 | _filter_scratch
> +md5sum $testdir/file3.chk | _filter_scratch
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/900.out b/tests/generic/900.out
> new file mode 100644
> index 00000000..b2569ab0
> --- /dev/null
> +++ b/tests/generic/900.out
> @@ -0,0 +1,14 @@
> +QA output created by 900
> +Format and mount
> +Create the original files
> +Compare files
> +bdbcf02ee0aa977795a79d25fcfdccb1  SCRATCH_MNT/test-900/file1
> +b83f9394092e15bdcda585cd8e776dc6  SCRATCH_MNT/test-900/file2
> +d3959a68638c50af07f0258e032cb554  SCRATCH_MNT/test-900/file3
> +d3959a68638c50af07f0258e032cb554  SCRATCH_MNT/test-900/file3.chk
> +mmap CoW across the transition
> +Compare files
> +bdbcf02ee0aa977795a79d25fcfdccb1  SCRATCH_MNT/test-900/file1
> +b83f9394092e15bdcda585cd8e776dc6  SCRATCH_MNT/test-900/file2
> +55968a95dfc0120df4e8485576514320  SCRATCH_MNT/test-900/file3
> +55968a95dfc0120df4e8485576514320  SCRATCH_MNT/test-900/file3.chk
> -- 
> 2.34.0
> 
> 
> 
