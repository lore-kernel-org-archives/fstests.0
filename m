Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE44C433F5
	for <linux-fstests@archiver.kernel.org>; Sat, 11 Dec 2021 00:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345490AbhLKApk (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 10 Dec 2021 19:45:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237381AbhLKApk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 10 Dec 2021 19:45:40 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D64C061714
        for <fstests@vger.kernel.org>; Fri, 10 Dec 2021 16:42:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D0B69CE2DDB
        for <fstests@vger.kernel.org>; Sat, 11 Dec 2021 00:42:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1AD3C00446;
        Sat, 11 Dec 2021 00:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639183321;
        bh=ztsXUYvJfHk6rAV4YYNM0Sh5xxYrPx7vL/ffnXYsG7w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iRovcfgz1VvMc30Y1SlrZa9t+8LP5iQV9/HHODjEuYk2hweekgqDwHh1nZH/2kwPX
         9pQN2DbE7oCjBpO6/BiUXSwdApwvXKL5GocVRlGF2GHt9CCuKWUcUEwF7QMJOilc3V
         X9eZ+N3HU+ZAs0HXT91nPNiSZXkZ+n13WNHCMEyzrYXn/BszW/d8xHAOxMku38vV8z
         TzIoj3nDDrpLh2GYQZN655b7hHoNscSh+jAMVF7rpMrKgGHPRyFziNRDesiuhbu0dC
         IL5MruIAL94MzPY8eqK8vB/HQUSNtlomfb3ZjUwnyW9gEaziq4s4uncwrBXAwDRqmH
         sp1pTYDS44+8A==
Date:   Fri, 10 Dec 2021 16:42:00 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2 10/16] generic: add mmap CoW test for delalloc&source
 extents
Message-ID: <20211211004200.GK69210@magnolia>
References: <20211125074752.274176-1-ruansy.fnst@fujitsu.com>
 <20211125074752.274176-11-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211125074752.274176-11-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Nov 25, 2021 at 03:47:46PM +0800, Shiyang Ruan wrote:
> Ensuring that copy on write in mmap mode to the source file when the CoW range
> covers delalloc blocks and regular shared blocks.
> (MMAP version of generic/293,295)
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  common/reflink        |  3 ++
>  tests/generic/909     | 64 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/909.out | 12 ++++++++
>  3 files changed, 79 insertions(+)
>  create mode 100755 tests/generic/909
>  create mode 100644 tests/generic/909.out
> 
> diff --git a/common/reflink b/common/reflink
> index 84173d59..e304ddc8 100644
> --- a/common/reflink
> +++ b/common/reflink
> @@ -431,4 +431,7 @@ _sweave_reflink_holes_delalloc() {
>  		_pwrite_byte 0x64 $((blksz * i)) $blksz $sfile
>  		_pwrite_byte 0x64 $((blksz * i)) $blksz $sfile.chk
>  	done
> +	# make sure we actually got delalloc block
> +	$FILEFRAG_PROG -v $sfile 2>&1 | grep -q delalloc || \
> +		_notrun "test requires delayed allocation writes"

Same comment about _require_command $FILEFRAG_PROG "filefrag" as before.

generic/909 looks like a spot-on translation from pwrite to mmap write.

--D

>  }
> diff --git a/tests/generic/909 b/tests/generic/909
> new file mode 100755
> index 00000000..ef1233ea
> --- /dev/null
> +++ b/tests/generic/909
> @@ -0,0 +1,64 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# FS QA Test No. 909
> +#
> +# Ensuring that copy on write in mmap mode to the source file when the
> +# CoW range covers delalloc blocks and regular shared blocks.
> +# (MMAP version of generic/293,295)
> +#   - Create two files.
> +#   - Truncate the first file.
> +#   - Write the odd blocks of the first file.
> +#   - Reflink the odd blocks of the first file into the second file.
> +#   - Write the even blocks of the first file.
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
> +_sweave_reflink_holes_delalloc $blksz $nr $testdir/file1 >> $seqres.full
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
> diff --git a/tests/generic/909.out b/tests/generic/909.out
> new file mode 100644
> index 00000000..4f9a5d33
> --- /dev/null
> +++ b/tests/generic/909.out
> @@ -0,0 +1,12 @@
> +QA output created by 909
> +Format and mount
> +Create the original files
> +Compare files
> +b8a8a88d4c143f79900c4b4e79aa3e37  SCRATCH_MNT/test-909/file1
> +ce2023f765eba19677517c511886d5c9  SCRATCH_MNT/test-909/file3
> +b8a8a88d4c143f79900c4b4e79aa3e37  SCRATCH_MNT/test-909/file1.chk
> +mmap CoW across the transition
> +Compare files
> +35e2170e14665b780c6dec328d6a263b  SCRATCH_MNT/test-909/file1
> +ce2023f765eba19677517c511886d5c9  SCRATCH_MNT/test-909/file3
> +35e2170e14665b780c6dec328d6a263b  SCRATCH_MNT/test-909/file1.chk
> -- 
> 2.34.0
> 
> 
> 
