Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D091C38A2D
	for <linux-fstests@archiver.kernel.org>; Mon, 24 Oct 2022 04:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiJXEJk (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 24 Oct 2022 00:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiJXEJi (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 24 Oct 2022 00:09:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F01F38B
        for <fstests@vger.kernel.org>; Sun, 23 Oct 2022 21:09:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 90CC7B80E9E
        for <fstests@vger.kernel.org>; Mon, 24 Oct 2022 04:09:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39E9AC433D6;
        Mon, 24 Oct 2022 04:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666584558;
        bh=w4494IicCGKPcax91ZhtZz8aPR6HlyM0FJOAgoXwLxc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ghZ2ThgsxVdbEoW54IMNphCMa3h4kftsdajxanc752rOfyvzqcaOa+odyNqLtLpka
         JkMcwoTclIxipoWGD3pNLQb7wEhWQoTMWva5oNrbbh2b9aUxeniaYAiPP90hh8+yai
         FeQwqlkWkjJjZPY0jxESeAFGpYKgatSTRikU2JBPAzJ5pt1CYphfnAkZ5pvPyrjB1I
         SiUXhqMcjMGxJE22xzYm1Izu70jt3nOoBiBfwrF74eKHcQ3t0kMUX8ccdZ1cjj5P8l
         Kgp+Ai99nc2bddxCmWbZbS5UBrYDorv8fLFyXU9QCH7BVlqgohFPkUCwwqeElv5hTV
         ATMUYlYq2NjWw==
Date:   Sun, 23 Oct 2022 21:09:17 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Cc:     "zlang@redhat.com" <zlang@redhat.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "bfoster@redhat.com" <bfoster@redhat.com>,
        "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
Subject: Re: [PATCH RESEND 2/2] generic/470: Replace thin volume with
 blkdiscard -z
Message-ID: <Y1YP7ehSZUdVS4/J@magnolia>
References: <20221023064810.847110-1-yangx.jy@fujitsu.com>
 <20221023064810.847110-2-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221023064810.847110-2-yangx.jy@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Oct 23, 2022 at 06:48:13AM +0000, yangx.jy@fujitsu.com wrote:
> generic/470 was original designed to verify mmap(MAP_SYNC) which
> is only vaild to the DAX capable device(e.g. PMEM). Thin volume[1] was
> introduced to fix the inconsistent filesystem issue[2] but it make
> the test become not run because it doesn't support DAX. As Darrick
> mentioned[3], discarding the entire mapped range of scartch device
> can fix the issue as well, so I try to use blkdiscard -z instead.

That might be ok for the *other* dm-logwrites tests, but isn't the
fundamental problem here (generic/470, specifically) that device mapper
cannot run on top of pmem?

--D

> [1]: https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?id=fc5870da485aec0f9196a0f2bed32f73f6b2c664
> [2]: https://lore.kernel.org/fstests/20190227061529.GF16436@dastard/
> [3]: https://lore.kernel.org/linux-xfs/Y1NRNtToQTjs0Dbd@magnolia/T/#me0e77cb0ecd80bf4b5109e4433cb4863ae6e6727
> 
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> ---
>  tests/generic/470 | 31 ++++++++++++-------------------
>  1 file changed, 12 insertions(+), 19 deletions(-)
> 
> diff --git a/tests/generic/470 b/tests/generic/470
> index f3407511..d2846a38 100755
> --- a/tests/generic/470
> +++ b/tests/generic/470
> @@ -15,38 +15,29 @@ _cleanup()
>  {
>  	cd /
>  	_log_writes_cleanup
> -	_dmthin_cleanup
>  	rm -f $tmp.*
>  }
>  
>  # Import common functions.
>  . ./common/filter
> -. ./common/dmthin
>  . ./common/dmlogwrites
>  
>  # real QA test starts here
>  _supported_fs generic
> -_require_scratch_nocheck
> +_require_scratch
>  _require_no_logdev
>  _require_log_writes_dax_mountopt "dax"
> -_require_dm_target thin-pool
>  _require_xfs_io_command "mmap" "-S"
>  _require_xfs_io_command "log_writes"
> +_require_command "$BLKDISCARD_PROG" blkdiscard
>  
> -devsize=$((1024*1024*200 / 512))        # 200m phys/virt size
> -csize=$((1024*64 / 512))                # 64k cluster size
> -lowspace=$((1024*1024 / 512))           # 1m low space threshold
> -
> -# Use a thin device to provide deterministic discard behavior. Discards are used
> -# by the log replay tool for fast zeroing to prevent out-of-order replay issues.
> -_dmthin_init $devsize $devsize $csize $lowspace
> +RANGE=$((512 * 1024 * 1024)) # 512 MiB
> +LEN=$((1024 * 1024)) # 1 MiB
>  
> -_log_writes_init $DMTHIN_VOL_DEV
> +_log_writes_init $SCRATCH_DEV $RANGE
>  _log_writes_mkfs >> $seqres.full 2>&1
>  _log_writes_mount -o dax
>  
> -LEN=$((1024 * 1024)) # 1 MiB
> -
>  $XFS_IO_PROG -t -c "truncate $LEN" -c "mmap -S 0 $LEN" -c "mwrite 0 $LEN" \
>  	-c "log_writes -d $LOGWRITES_NAME -m preunmap" \
>  	-f $SCRATCH_MNT/test
> @@ -54,14 +45,16 @@ $XFS_IO_PROG -t -c "truncate $LEN" -c "mmap -S 0 $LEN" -c "mwrite 0 $LEN" \
>  # Unmount the scratch dir and tear down the log writes target
>  _log_writes_unmount
>  _log_writes_remove
> -_dmthin_check_fs
> +_check_scratch_fs
>  
> -# destroy previous filesystem so we can be sure our rebuild works
> -_mkfs_dev $DMTHIN_VOL_DEV >> $seqres.full 2>&1
> +# Discard the mapped range of scratch device and destroy previous filesystem
> +# so we can be sure our rebuild works
> +$BLKDISCARD_PROG -fzl $RANGE $SCRATCH_DEV >> $seqres.full 2>&1
> +_scratch_mkfs >> $seqres.full 2>&1
>  
>  # check pre-unmap state
> -_log_writes_replay_log preunmap $DMTHIN_VOL_DEV
> -_dmthin_mount
> +_log_writes_replay_log preunmap $SCRATCH_DEV
> +_scratch_mount
>  
>  # We should see $SCRATCH_MNT/test as having 1 MiB in block allocations
>  du -sh $SCRATCH_MNT/test | _filter_scratch | _filter_spaces
> -- 
> 2.34.1
