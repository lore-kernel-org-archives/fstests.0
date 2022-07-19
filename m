Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DA7C433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 19 Jul 2022 16:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiGSQuM (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 19 Jul 2022 12:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbiGSQuL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 19 Jul 2022 12:50:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACABF10566
        for <fstests@vger.kernel.org>; Tue, 19 Jul 2022 09:50:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 21DB9B81C37
        for <fstests@vger.kernel.org>; Tue, 19 Jul 2022 16:50:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0D13C341C6;
        Tue, 19 Jul 2022 16:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658249404;
        bh=cppxI2IhMzjqN+lZoF0a1PwPPzg4D1EGJlw5l+MjiCY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TrGmgJE4n4nRa2iwzHPoNIkYh1L/nsv8mOpJdn8U+wVgugc44JL2aKJqpYIVvGPUd
         72mcwV40YoxQczut4dv3d33WhsAnOcKYADOblwT01JGFHDKwqfi8EtHHRWOEWBX+xh
         mCCbRzv5L9+zCeAHY2SS+lhKI0n3b9x50KF20x7v675CetCZ/C+CmSXtYSMqVe4mah
         uqWxEVHE09wBc74brNqe3uhv1eA9LJBq+W7il94uAByw5YJwGmDpr3i6WGgyHvATDf
         DvH0+tLrPEItmiddfGxOtZ/baQqjHQ3kx321p38DGQkXqHUCyGB4XQeAUW82+Jyn19
         adsyoIkKLtUHQ==
Date:   Tue, 19 Jul 2022 09:50:04 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v3 3/3] xfs: add memory failure test for
 partly-reflinked&dax file
Message-ID: <YtbgvN/nH6E5tN8l@magnolia>
References: <20220520013534.2894233-1-ruansy.fnst@fujitsu.com>
 <20220520013534.2894233-4-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520013534.2894233-4-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, May 20, 2022 at 09:35:34AM +0800, Shiyang Ruan wrote:
> Verify that dax-rmap works for both normal extent and shared extent.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>

LGTM,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  tests/xfs/902     | 52 +++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/902.out |  9 ++++++++
>  2 files changed, 61 insertions(+)
>  create mode 100755 tests/xfs/902
>  create mode 100644 tests/xfs/902.out
> 
> diff --git a/tests/xfs/902 b/tests/xfs/902
> new file mode 100755
> index 00000000..85ae07a1
> --- /dev/null
> +++ b/tests/xfs/902
> @@ -0,0 +1,52 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# FS QA Test No. 902
> +#
> +# Test memory failure mechanism when dax and reflink working together
> +#   test for partly reflinked file
> +#
> +. ./common/preamble
> +_begin_fstest auto quick clone dax
> +
> +# Import common functions.
> +. ./common/filter
> +. ./common/reflink
> +
> +# real QA test starts here
> +_require_check_dmesg
> +_require_scratch_reflink
> +_require_xfs_scratch_rmapbt
> +_require_scratch_dax_mountopt "dax"
> +_require_test_program "t_mmap_cow_memory_failure"
> +
> +echo "Format and mount"
> +_scratch_mkfs > $seqres.full 2>&1
> +_scratch_mount "-o dax" >> $seqres.full 2>&1
> +
> +testdir=$SCRATCH_MNT/test-$seq
> +mkdir $testdir
> +
> +echo "Create the original files"
> +nr=16
> +blksz=$(get_page_size)
> +_pwrite_byte 0x61 0 $((blksz * nr)) $testdir/testfile >> $seqres.full
> +_pwrite_byte 0x62 0 $((blksz * nr)) $testdir/poisonfile >> $seqres.full
> +seq 0 2 $((nr - 1)) | while read i; do
> +	_reflink_range $testdir/testfile $((blksz * i)) \
> +		$testdir/poisonfile $((blksz * i)) $blksz >> $seqres.full
> +done
> +_scratch_cycle_mount "dax"
> +
> +echo "Inject memory failure (1 page)"
> +$here/src/t_mmap_cow_memory_failure -s1 -S1 -R $testdir/testfile -P $testdir/poisonfile
> +
> +echo "Inject memory failure (2 pages)"
> +# poison on reflinked page and not reflinked page
> +$here/src/t_mmap_cow_memory_failure -s2 -S2 -R $testdir/testfile -P $testdir/poisonfile
> +
> +_check_dmesg_for "Sending SIGBUS to t_mmap_cow_memo" || echo "Memory failure didn't kill the process"
> +_check_dmesg_for "recovery action for dax page: Recovered" || echo "Failured page didn't recovered"
> +
> +# success, all done
> +status=0
> diff --git a/tests/xfs/902.out b/tests/xfs/902.out
> new file mode 100644
> index 00000000..3c055d54
> --- /dev/null
> +++ b/tests/xfs/902.out
> @@ -0,0 +1,9 @@
> +QA output created by 902
> +Format and mount
> +Create the original files
> +Inject memory failure (1 page)
> +Inject poison...
> +Process is killed by signal: 7
> +Inject memory failure (2 pages)
> +Inject poison...
> +Process is killed by signal: 7
> -- 
> 2.35.1
> 
> 
> 
