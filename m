Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3986C433EF
	for <linux-fstests@archiver.kernel.org>; Wed, 27 Apr 2022 18:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbiD0SK7 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 27 Apr 2022 14:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbiD0SK6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 27 Apr 2022 14:10:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED7613F28
        for <fstests@vger.kernel.org>; Wed, 27 Apr 2022 11:07:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7496BB828C4
        for <fstests@vger.kernel.org>; Wed, 27 Apr 2022 18:07:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17B76C385A9;
        Wed, 27 Apr 2022 18:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651082863;
        bh=xaFp/ECYXvps1eCLbacrRWDqkhkqpFFyeklNQSYP08I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vi0dhC5lPcj09A+ZYYD2XuFLCf5/RoPPCZxD7F7YvWjBlTiSw26euIeb/lh2BvW1I
         CCo/v/oZGq2dnpA1y6QnQjWZnWC2gTO3WaO/hwR2ZwH0LgoIol8rLS0ZfH1/roQycn
         CR16HYkyHyMFhUN7LVLCvxZUCnLELNtWYKE9klaINfSI4TYuMc3HJcb2WQYDTfa7Kl
         KGSCnREcFokBwPsWLK1/EsXEROBsTe0Pb4d/eVUzru4Ym7gc8LoTirYJ9sh4t9uGM+
         pzMATOKrwbBN3wG8wALdpYfrb16WBSu3lawooK9kSp5Vc+bl5a7RtlT5qr8knIxbKS
         StNy3lAPifm+w==
Date:   Wed, 27 Apr 2022 11:07:42 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 2/3] xfs: add memory failure test for dax&reflink mode
Message-ID: <20220427180742.GL17014@magnolia>
References: <20220311151816.2174870-1-ruansy.fnst@fujitsu.com>
 <20220311151816.2174870-3-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311151816.2174870-3-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Mar 11, 2022 at 11:18:15PM +0800, Shiyang Ruan wrote:
> Verify that the dax-rmap feature works.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>

With the same 'posion' -> 'poison' fix applied,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  tests/xfs/901     | 49 +++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/901.out |  9 +++++++++
>  2 files changed, 58 insertions(+)
>  create mode 100755 tests/xfs/901
>  create mode 100644 tests/xfs/901.out
> 
> diff --git a/tests/xfs/901 b/tests/xfs/901
> new file mode 100755
> index 00000000..a94a0c06
> --- /dev/null
> +++ b/tests/xfs/901
> @@ -0,0 +1,49 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# FS QA Test No. 901
> +#
> +# Test memory failure mechanism when dax and reflink working together
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
> +_require_cp_reflink
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
> +filesize=65536
> +_pwrite_byte 0x61 0 $filesize $testdir/testfile >> $seqres.full
> +_cp_reflink $testdir/testfile $testdir/posionfile >> $seqres.full
> +_scratch_cycle_mount "dax"
> +
> +echo "Inject memory failure (1 page)"
> +# create two processes:
> +#  process1: mread 4k to cause page fault, and wait
> +#  process2: mread 4k to cause page fault, then inject posion on this 4k page
> +$here/src/t_mmap_cow_memory_failure -s1 -S1 -R $testdir/testfile -P $testdir/posionfile
> +
> +echo "Inject memory failure (2 pages)"
> +$here/src/t_mmap_cow_memory_failure -s2 -S2 -R $testdir/testfile -P $testdir/posionfile
> +
> +_check_dmesg_for "Sending SIGBUS to t_mmap_cow_memo" || echo "Memory failure didn't kill the process"
> +_check_dmesg_for "recovery action for dax page: Recovered" || echo "Failured page didn't recovered"
> +
> +# success, all done
> +status=0
> diff --git a/tests/xfs/901.out b/tests/xfs/901.out
> new file mode 100644
> index 00000000..92d64846
> --- /dev/null
> +++ b/tests/xfs/901.out
> @@ -0,0 +1,9 @@
> +QA output created by 901
> +Format and mount
> +Create the original files
> +Inject memory failure (1 page)
> +Inject posion...
> +Process is killed by signal: 7
> +Inject memory failure (2 pages)
> +Inject posion...
> +Process is killed by signal: 7
> -- 
> 2.35.1
> 
> 
> 
