Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54951C4332F
	for <linux-fstests@archiver.kernel.org>; Sun, 13 Nov 2022 17:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbiKMR6A (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 13 Nov 2022 12:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbiKMR57 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 13 Nov 2022 12:57:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A959BDEC6
        for <fstests@vger.kernel.org>; Sun, 13 Nov 2022 09:57:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 68FFDB80C81
        for <fstests@vger.kernel.org>; Sun, 13 Nov 2022 17:57:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1445CC433D6;
        Sun, 13 Nov 2022 17:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668362275;
        bh=QA2S8U4ph5j+rxsBClev5Qh/5TPYYBr9C0qKWvTl7LI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nMOiIUu+xrDAuCn3De3ZwiJ9ChJNprjtDKN8ploIZ31f0FPKQc+Dss/kDMFbTvfeg
         WDf3XpIIzUpalVXfb8QgdBP0O8a1BnCupwltV1xfK7zwjTnJlM1Uw0GZolGBoN224D
         CZ3AEj6yKvB4yNPRCzDAA9TAzI4cR7CkJMK7X01DqHyYxb04+IvcQ8kDozYoUE3Lw4
         Fz46peU6GUOzmKPtHrMBub/QbNGtPBICD5tQIW+0r0pq8eA5ez7vgcfwvcrjGV+alC
         w1cjMmB05/mKopLKbyfmzgXk4vJ45ZcavpeACOHl8XROdJRph+b5af5VA/nCuonK03
         e2XLKdlE2AU1Q==
Date:   Sun, 13 Nov 2022 09:57:54 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Cc:     "zlang@redhat.com" <zlang@redhat.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "bfoster@redhat.com" <bfoster@redhat.com>,
        "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
Subject: Re: [PATCH RESEND 2/2] generic/470: Replace thin volume with
 blkdiscard -z
Message-ID: <Y3EwIvDfZdIlzHKg@magnolia>
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
> 
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

You used -z, which means the comment should say "Forcibly zero the
mapped range of the scratch device..." and note that blkdiscard -z will
fall back to writing buffers of zeroes if the device doesn't support
WRITE SAME with zeroes.

I think the logic in here looks good though.

--D

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
