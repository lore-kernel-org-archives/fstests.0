Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99342C4338F
	for <linux-fstests@archiver.kernel.org>; Mon, 26 Jul 2021 18:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D55760F92
	for <linux-fstests@archiver.kernel.org>; Mon, 26 Jul 2021 18:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbhGZRba (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 26 Jul 2021 13:31:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:42844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231844AbhGZRb3 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 26 Jul 2021 13:31:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F9ED604DB;
        Mon, 26 Jul 2021 18:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627323118;
        bh=jQj+4sqsCxJN2m8CPa+nTISNy1uXe957CeJqOazxjEg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YqId424cy7BMgN3beL9b0UHokjwVLOMmXvvvaxX1DVSMK4qLTFGyOcaptNnGDur+G
         ULM/qLk5vXUrpbk0cveS/CwY3Ks9/pcDov9PpCdSHrNA1imEQt0JhQC892Q8xcby2x
         IcoonbnBO9SZI+XlOHrywUVHKHB5278aTKE+brPpsUyDKzzUUUJiuyl9PrjdhIOKi+
         Y4cBZi2nU32ZlnzxH1qV6P99OVjMRNwtPiknPIvGXxKR6OWYpTqzmZmh57NgnA4/m9
         J0GAJfFyO/F1CKNojRmi73z5YmHcG2GY/WWL5e4c8H3zWN5U4N2+1HJjC2CmyWU25R
         6W7KlcsUQtsCQ==
Date:   Mon, 26 Jul 2021 11:11:57 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v5] generic: test small swapfile without page-aligned
 contiguous blocks
Message-ID: <20210726181157.GA8586@magnolia>
References: <20210726094605.513174-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726094605.513174-1-zlang@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Jul 26, 2021 at 05:46:05PM +0800, Zorro Lang wrote:
> If a swapfile doesn't contain even a single page-aligned contiguous
> range of blocks, it's an invalid swapfile, and might cause kernel
> issue. This case covered commit 5808fecc5723 ("iomap: Fix negative
> assignment to unsigned sis->pages in iomap_swapfile_activate").
> 
> Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
> Signed-off-by: Zorro Lang <zlang@redhat.com>
> ---
> 
> Hi,
> 
> V5 rebase this case on the latest xfstests, to match the "group info" change:
> https://lore.kernel.org/fstests/60d89a67.1c69fb81.86c2c.d6c4@mx.google.com/
> 
> Thanks,
> Zorro
> 
>  tests/generic/640     | 77 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/640.out |  2 ++
>  2 files changed, 79 insertions(+)
>  create mode 100755 tests/generic/640
>  create mode 100644 tests/generic/640.out
> 
> diff --git a/tests/generic/640 b/tests/generic/640
> new file mode 100755
> index 00000000..494fcc1b
> --- /dev/null
> +++ b/tests/generic/640
> @@ -0,0 +1,77 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2021 Red Hat Inc.  All Rights Reserved.
> +#
> +# FS QA Test 640
> +#
> +# Test small swapfile which doesn't contain even a single page-aligned contiguous
> +# range of blocks. This case covered commit 5808fecc5723 ("iomap: Fix negative
> +# assignment to unsigned sis->pages in iomap_swapfile_activate").
> +#
> +. ./common/preamble
> +_begin_fstest auto quick swap
> +
> +# Import common functions
> +. ./common/filter
> +
> +# real QA test starts here
> +_supported_fs generic
> +_require_scratch
> +_require_scratch_swapfile
> +_require_test_program mkswap
> +_require_test_program swapon
> +_require_xfs_io_command fcollapse
> +
> +make_unaligned_swapfile()
> +{
> +	local fname=$1
> +	local n=$((psize / bsize - 1))
> +
> +	# Make sure the swapfile doesn't contain even a single page-aligned
> +	# contiguous range of blocks. This's necessary to cover the bug
> +	$XFS_IO_PROG -f -t -c "pwrite 0 $(((psize + bsize) * n))" $fname >> $seqres.full 2>&1
> +	for((i=1; i<=n; i++));do
> +		$XFS_IO_PROG -c "fcollapse $(((psize - bsize) * i)) $bsize" $fname
> +	done
> +	chmod 0600 $fname
> +	$CHATTR_PROG +C $fname > /dev/null 2>&1
> +	$here/src/mkswap $fname
> +}
> +
> +_scratch_mkfs >> $seqres.full 2>&1
> +_scratch_mount
> +psize=`get_page_size`
> +bsize=`_get_file_block_size $SCRATCH_MNT`
> +# Due to we need page-unaligned blocks, so blocksize < pagesize is necessary.
> +# If not, try to make a smaller enough block size
> +if [ $bsize -ge $psize ];then
> +	_scratch_unmount
> +	_scratch_mkfs_blocksized 1024 >> $seqres.full 2>&1
> +	if [ $? -ne 0 ];then
> +		_notrun "Can't make filesystem block size < page size."
> +	fi
> +	_scratch_mount
> +	bsize=`_get_file_block_size $SCRATCH_MNT`
> +	if [ $bsize -ne 1024 ];then
> +		_notrun "Can't force 1024-byte file block size."
> +	fi
> +fi
> +swapfile=$SCRATCH_MNT/$seq.swapfile
> +make_unaligned_swapfile $swapfile
> +# Expect EINVAL from swapon. If not, might miss 5808fecc5723 ("iomap: Fix
> +# negative assignment to unsigned sis->pages in iomap_swapfile_activate")
> +$here/src/swapon $swapfile
> +# Further testing, check if swap size <= swapfile size, if swapon passed
> +if [ $? -eq 0 ];then
> +	swapsize=$(awk -v fname="$swapfile" '{if ($1~fname) print $3}' /proc/swaps)
> +	swapsize=$((swapsize * 1024))
> +	filesize=$(_get_filesize $swapfile)
> +	if [ $swapsize -gt $filesize ]; then
> +		echo "Allocated swap size($swapsize) shouldn't be greater than swapfile size($filesize)"
> +	fi
> +fi
> +swapoff $swapfile 2>/dev/null

Do we actually need swapoff if swapon failed?  Or are you merely being
cautious?

--D

> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/640.out b/tests/generic/640.out
> new file mode 100644
> index 00000000..e1ab5390
> --- /dev/null
> +++ b/tests/generic/640.out
> @@ -0,0 +1,2 @@
> +QA output created by 640
> +swapon: Invalid argument
> -- 
> 2.31.1
> 
