Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58858C2B9F8
	for <linux-fstests@archiver.kernel.org>; Tue, 25 May 2021 16:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3618D6140A
	for <linux-fstests@archiver.kernel.org>; Tue, 25 May 2021 16:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbhEYQKi (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 25 May 2021 12:10:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:46694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230150AbhEYQKi (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 25 May 2021 12:10:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1FBCD61378;
        Tue, 25 May 2021 16:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621958948;
        bh=KyA3nBnFyHZSB6Xhq0wVeDEAFAN4ikVxXi6EEb0blMg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sOAhijvCjfeEmLD+X4vigvDSk/I3gFAR850+UsGJG1HZYrozqX1ApyduR1G5upE9P
         epL8QSksc2y8rxez/xnhX1cBhpAGAT+CVnVmEmkeIzIwIEFlza1yl7HiVITbkHcw4g
         dyDc9xh62pFppGzL5+v69T9+gy/VffWfuQlNhZXVr7v4NbbVE9EdgW8CNQDod9rnqF
         B9iYmSoFM77TWcbVrNjte43xwQOBFh7GlX5dQeS14/FJBBYtyxy8WSBkxSwtVw43QV
         Wn7FxwwROnx1PzMg7ek05hoF7BDgW4Xg8SUp3MuYl23myd++VTOXVRbw4HkKXOEUOk
         np6ISyysJi9mg==
Date:   Tue, 25 May 2021 09:09:07 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] generic: test small swapfile without page-aligned
 contiguous blocks
Message-ID: <20210525160907.GB202095@locust>
References: <20210525044642.552682-1-zlang@redhat.com>
 <20210525044642.552682-2-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525044642.552682-2-zlang@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, May 25, 2021 at 12:46:42PM +0800, Zorro Lang wrote:
> If a swapfile doesn't contain even a single page-aligned contiguous
> range of blocks, it's an invalid swapfile, and might cause kernel
> issue. This case covered commit 5808fecc5723 ("iomap: Fix negative
> assignment to unsigned sis->pages in iomap_swapfile_activate").
> 
> Signed-off-by: Zorro Lang <zlang@redhat.com>
> ---
>  tests/generic/638     | 79 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/638.out |  2 ++
>  tests/generic/group   |  1 +
>  3 files changed, 82 insertions(+)
>  create mode 100755 tests/generic/638
>  create mode 100644 tests/generic/638.out
> 
> diff --git a/tests/generic/638 b/tests/generic/638
> new file mode 100755
> index 00000000..74bc39cb
> --- /dev/null
> +++ b/tests/generic/638
> @@ -0,0 +1,79 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2021 Red Hat Inc.  All Rights Reserved.
> +#
> +# FS QA Test 638
> +#
> +# Test small swapfile which doesn't contain even a single page-aligned contiguous
> +# range of blocks. This case covered commit 5808fecc5723 ("iomap: Fix negative
> +# assignment to unsigned sis->pages in iomap_swapfile_activate").
> +#
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +_supported_fs generic
> +_require_scratch
> +_require_scratch_swapfile
> +_require_test_program mkswap
> +_require_test_program swapon
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
> +bsize=`_get_block_size $SCRATCH_MNT`

_get_file_block_size, since fcollapse requires arguments aligned to the
file's allocation unit, which isn't necessarily the same as the fs block
size (bigalloc, rt, etc.)...

> +# Due to we need page-unaligned blocks, so blocksize < pagesize is necessary.
> +# If not, try to make a smaller enough block size
> +if [ $bsize -ge $psize ];then
> +	_scratch_unmount
> +	_scratch_mkfs_blocksized 1024 >> $seqres.full 2>&1

...which leads me to the next question, which is: Should the above
helper override mkfs options as necessary to enforce that the allocation
unit is 1024 bytes?  Or is it time for a new helper?

> +	if [ $? -ne 0 ];then
> +		_notrun "Can't make filesystem block size < page size"
> +	fi
> +	_scratch_mount
> +	bsize=1024

You probably want to re-check _get_file_block_size to make sure that you
actually got blocksize < pagesize in the format attempt.

--D

> +fi
> +swapfile=$SCRATCH_MNT/$seq.swapfile
> +make_unaligned_swapfile $swapfile
> +$here/src/swapon $swapfile
> +swapoff $swapfile
> +
> +echo "Silence is golden"
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/638.out b/tests/generic/638.out
> new file mode 100644
> index 00000000..3113b1e3
> --- /dev/null
> +++ b/tests/generic/638.out
> @@ -0,0 +1,2 @@
> +QA output created by 638
> +Silence is golden
> diff --git a/tests/generic/group b/tests/generic/group
> index b9614c69..5b9b3d1b 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -640,3 +640,4 @@
>  635 auto quick atime bigtime shutdown
>  636 auto quick swap
>  637 auto quick rw
> +638 auto quick swap
> -- 
> 2.31.1
> 
