Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04240C4332F
	for <linux-fstests@archiver.kernel.org>; Mon, 14 Nov 2022 19:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiKNTTq (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 14 Nov 2022 14:19:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235617AbiKNTTp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 14 Nov 2022 14:19:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C7626AE4
        for <fstests@vger.kernel.org>; Mon, 14 Nov 2022 11:19:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7DCD4B811BE
        for <fstests@vger.kernel.org>; Mon, 14 Nov 2022 19:19:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15865C433D6;
        Mon, 14 Nov 2022 19:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668453581;
        bh=vQdxfIOOf1FnGooCnhY44QHPDe5yAd5nlf5O4AHoUo4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=THMeHL8KwWCg73tpn7BIN8uubdAXNjhMLKrSoug0yzgNRbibzfcp7JnCKUPw8rVzn
         qlHFuzmd/W1OBhBepP+kNbhzb72l5c+N9kXPv3zoQIoZOvnB9kByE1RZPOv1AGgUOk
         YdsqZNSNoGfCa3DKU103o+Iab9EiKtKdNvzda6NEyCvdMHg6T5t7gSER6Xhe1sd1nU
         dhh6Z30Ec1t4dBAPgD52K148eCF0eFYJ+UeRBz1nhd7w+OQz8CoN70+5gLS1lm4WXy
         cH4s+w/tLrzeybVPatjClBI/TLLNgSuglt2uA1dlwexKx5sai+VGDhNxGfj01lOwJR
         5uTbdIiNLtnfQ==
Date:   Mon, 14 Nov 2022 11:19:40 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Xiao Yang <yangx.jy@fujitsu.com>
Cc:     zlang@redhat.com, fstests@vger.kernel.org, bfoster@redhat.com,
        y-goto@fujitsu.com
Subject: Re: [PATCH v2 2/2] generic/470: Replace thin volume with blkdiscard
 -z
Message-ID: <Y3KUzG6qfezmgkqX@magnolia>
References: <1668414903-13-1-git-send-email-yangx.jy@fujitsu.com>
 <1668414903-13-2-git-send-email-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1668414903-13-2-git-send-email-yangx.jy@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Nov 14, 2022 at 08:35:03AM +0000, Xiao Yang wrote:
> generic/470 was original designed to verify mmap(MAP_SYNC) which
> is only valid to the DAX capable device(e.g. PMEM). Thin volume[1] was
> introduced to fix the inconsistent filesystem issue[2] but it make
> the test become not run because it doesn't support DAX. As Darrick
> mentioned[3], zeroing the entire mapped range of scartch device
> can fix the issue as well, so I try to use blkdiscard -z instead.
> 
> [1]: https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?id=fc5870da485aec0f9196a0f2bed32f73f6b2c664
> [2]: https://lore.kernel.org/fstests/20190227061529.GF16436@dastard/
> [3]: https://lore.kernel.org/linux-xfs/Y1NRNtToQTjs0Dbd@magnolia/T/#me0e77cb0ecd80bf4b5109e4433cb4863ae6e6727
> 
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> ---
>  tests/generic/470 | 34 +++++++++++++++-------------------
>  1 file changed, 15 insertions(+), 19 deletions(-)
> 
> diff --git a/tests/generic/470 b/tests/generic/470
> index f3407511..6da2ec22 100755
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
> +MAPPED_LEN=$((512 * 1024 * 1024)) # 512 MiB
> +LEN=$((1024 * 1024)) # 1 MiB
>  
> -_log_writes_init $DMTHIN_VOL_DEV
> +_log_writes_init $SCRATCH_DEV $MAPPED_LEN
>  _log_writes_mkfs >> $seqres.full 2>&1
>  _log_writes_mount -o dax
>  
> -LEN=$((1024 * 1024)) # 1 MiB
> -
>  $XFS_IO_PROG -t -c "truncate $LEN" -c "mmap -S 0 $LEN" -c "mwrite 0 $LEN" \
>  	-c "log_writes -d $LOGWRITES_NAME -m preunmap" \
>  	-f $SCRATCH_MNT/test
> @@ -54,14 +45,19 @@ $XFS_IO_PROG -t -c "truncate $LEN" -c "mmap -S 0 $LEN" -c "mwrite 0 $LEN" \
>  # Unmount the scratch dir and tear down the log writes target
>  _log_writes_unmount
>  _log_writes_remove
> -_dmthin_check_fs
> +_check_scratch_fs
>  
> -# destroy previous filesystem so we can be sure our rebuild works
> -_mkfs_dev $DMTHIN_VOL_DEV >> $seqres.full 2>&1
> +# Forcibly zero the mapped range of scratch device and destroy
> +# previous filesystem so we can be sure our rebuild works.
> +# Note that blkdiscard -z will fall back to writing buffers of zeroes
> +# if scratch device doesn't support write zeroes operation(i.e.
> +# REQ_OP_WRITE_ZEROES).
> +$BLKDISCARD_PROG -fzl $MAPPED_LEN $SCRATCH_DEV >> $seqres.full 2>&1
> +_scratch_mkfs >> $seqres.full 2>&1

Thanks for fixing the comment, apologies for the delays.
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

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
> 
