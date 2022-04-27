Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C7AC433F5
	for <linux-fstests@archiver.kernel.org>; Wed, 27 Apr 2022 18:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiD0SUN (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 27 Apr 2022 14:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244739AbiD0SUB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 27 Apr 2022 14:20:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A16B393D5
        for <fstests@vger.kernel.org>; Wed, 27 Apr 2022 11:16:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1203BB82539
        for <fstests@vger.kernel.org>; Wed, 27 Apr 2022 18:16:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A40C385A7;
        Wed, 27 Apr 2022 18:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651083406;
        bh=WZ/xpCRHECt+Gi/EvEti6vplz2UZxpAoP5G37FX1RU8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lTMSK8UFzuHJj3JfPh8iQM2MiE9YTL9UYpuCPxrfh+ISa791OVHXdcibT8MDJWGus
         dTLOhtjTwgeZ22WjcZclMq5zpp2v8+2OTPG8JRZtwUZqF2lOz8OCqVIY/rcFX2eXWu
         rPxHrus8SOzNt5WB35PNojzMi31lrUMqn8AZ1xlxzquoRINshtav2ZRgH98kQuEaz5
         VVaoFbVZFgkkjTCTww9TUVrUQQl/zrJDa59RrIjOownsc2+XD4dGOl2tlcl3NWpb9V
         54NRi9LOq1REFZnGgD6s1uSXPkOcIRYvh5CZaGdymJUAq95k3MZpeppZd4drBi4c0X
         EbCID634MylHQ==
Date:   Wed, 27 Apr 2022 11:16:46 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 3/3] xfs: add memory failure test for
 partly-reflinked&dax file
Message-ID: <20220427181646.GN17014@magnolia>
References: <20220311151816.2174870-1-ruansy.fnst@fujitsu.com>
 <20220311151816.2174870-4-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311151816.2174870-4-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Mar 11, 2022 at 11:18:16PM +0800, Shiyang Ruan wrote:
> Verify that dax-rmap works for both normal extent and shared extent.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  tests/xfs/902     | 52 +++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/902.out |  9 ++++++++
>  2 files changed, 61 insertions(+)
>  create mode 100755 tests/xfs/902
>  create mode 100644 tests/xfs/902.out
> 
> diff --git a/tests/xfs/902 b/tests/xfs/902
> new file mode 100755
> index 00000000..291d34fd
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
> +blksz=4096

And I guess while I'm whinging about not embedding the page size in the
C source code, the test script shouldn't be doing that either.

blksz=$(get_page_size)

--D

> +_pwrite_byte 0x61 0 $((blksz * nr)) $testdir/testfile >> $seqres.full
> +_pwrite_byte 0x62 0 $((blksz * nr)) $testdir/posionfile >> $seqres.full
> +seq 0 2 $((nr - 1)) | while read i; do
> +	_reflink_range $testdir/testfile $((blksz * i)) \
> +		$testdir/posionfile $((blksz * i)) $blksz >> $seqres.full
> +done
> +_scratch_cycle_mount "dax"
> +
> +echo "Inject memory failure (1 page)"
> +$here/src/t_mmap_cow_memory_failure -s1 -S1 -R $testdir/testfile -P $testdir/posionfile
> +
> +echo "Inject memory failure (2 pages)"
> +# posion on reflinked page and not reflinked page
> +$here/src/t_mmap_cow_memory_failure -s2 -S2 -R $testdir/testfile -P $testdir/posionfile
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
