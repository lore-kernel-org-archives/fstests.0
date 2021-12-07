Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E2DC433F5
	for <linux-fstests@archiver.kernel.org>; Tue,  7 Dec 2021 00:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344696AbhLGAbY (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 6 Dec 2021 19:31:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344456AbhLGAbY (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 6 Dec 2021 19:31:24 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F76C061746
        for <fstests@vger.kernel.org>; Mon,  6 Dec 2021 16:27:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8BD4ACE17E3
        for <fstests@vger.kernel.org>; Tue,  7 Dec 2021 00:27:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F94C004DD;
        Tue,  7 Dec 2021 00:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638836869;
        bh=Fn9v1DFC8+m+sM6/x3yZr4joV0WJoOnQE9TjKDiF2p4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BD6SpuutxdP22SkReTYvVPhHiG/8/LkQf6DRP7C6VtUPtilLyROuKWGavegW8mupj
         n+2fqXEwg0KIi61UajLVW3uB3hg+LIAL21IdlHteJhMvVRHyGubbw8C/qcLQbPvF4q
         npsE4TJCRNV9Ju5lrXWpa1g/yekOAAea8NXNOsuv7xIilW569mIZhdALtCHQtk90if
         GOQ1hsZv8a5KYRENmDHiDMpYYZzK6ZFxImLpSXhdOFS+c2NOixTC9ziwDGsNaOSuj7
         /jVzXJyN+XWCpbNsNGr/PeSfN2UPd5zDJRmoXyLob4pkGZiZQF3yM3fzOOjBO03MIA
         IKLavxvdpFU2g==
Date:   Mon, 6 Dec 2021 16:27:48 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2 16/16] generic: add race test that mmap write to
 target of reflink
Message-ID: <20211207002748.GC8442@magnolia>
References: <20211125074752.274176-1-ruansy.fnst@fujitsu.com>
 <20211125074752.274176-17-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211125074752.274176-17-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Nov 25, 2021 at 03:47:52PM +0800, Shiyang Ruan wrote:
> Test for races or FS corruption when mmap writing to a file that's also
> the target of a reflink operation. (MMAP version of generic/168,170)
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>

Looks pretty straightforward,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  tests/generic/915     | 64 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/915.out |  4 +++
>  2 files changed, 68 insertions(+)
>  create mode 100755 tests/generic/915
>  create mode 100644 tests/generic/915.out
> 
> diff --git a/tests/generic/915 b/tests/generic/915
> new file mode 100755
> index 00000000..365f304c
> --- /dev/null
> +++ b/tests/generic/915
> @@ -0,0 +1,64 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# FS QA Test No. 915
> +#
> +# Test for races or FS corruption when mmap writing to a file that's also
> +# the target of a reflink operation. (MMAP version of generic/168,170)
> +#
> +. ./common/preamble
> +_begin_fstest auto clone
> +
> +_register_cleanup "_cleanup" BUS
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
> +finished_file=/tmp/finished
> +rm -rf $finished_file
> +mkdir $testdir
> +
> +loops=1024
> +nr_loops=$((loops - 1))
> +blksz=65536
> +
> +echo "Initialize files"
> +echo >> $seqres.full
> +_pwrite_byte 0x61 0 $((loops * blksz)) $testdir/file1 >> $seqres.full
> +_pwrite_byte 0x62 0 $((loops * blksz)) $testdir/file2 >> $seqres.full
> +_scratch_cycle_mount
> +
> +# mmap overwriter...
> +overwrite() {
> +	while [ ! -e $finished_file ]; do
> +		seq $nr_loops -1 0 | while read i; do
> +			$XFS_IO_PROG -f -c "mmap -rw $((i * blksz)) $blksz" \
> +				-c "mwrite -S 0x63 $((i * blksz)) $blksz" $testdir/file2 >> $seqres.full
> +		done
> +	done
> +}
> +
> +echo "Reflink and mmap write the target"
> +overwrite &
> +seq 1 10 | while read j; do
> +	seq 0 $nr_loops | while read i; do
> +		_reflink_range  $testdir/file1 $((i * blksz)) \
> +				$testdir/file2 $((i * blksz)) $blksz >> $seqres.full
> +		[ $? -ne 0 ] && exit
> +	done
> +done
> +touch $finished_file
> +wait
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/915.out b/tests/generic/915.out
> new file mode 100644
> index 00000000..4e77847b
> --- /dev/null
> +++ b/tests/generic/915.out
> @@ -0,0 +1,4 @@
> +QA output created by 915
> +Format and mount
> +Initialize files
> +Reflink and mmap write the target
> -- 
> 2.34.0
> 
> 
> 
