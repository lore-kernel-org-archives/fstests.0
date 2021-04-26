Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF705C433ED
	for <linux-fstests@archiver.kernel.org>; Mon, 26 Apr 2021 15:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D1D161059
	for <linux-fstests@archiver.kernel.org>; Mon, 26 Apr 2021 15:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233971AbhDZPUR (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 26 Apr 2021 11:20:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44054 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233674AbhDZPUR (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 26 Apr 2021 11:20:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619450375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IFzB4KNaIFq/ofbLBvY4Ku1mpUHjaVK+bShHAz3FfEw=;
        b=FX38wh4eO2gMrKjqGP9aujCEx/+aIpUXRGBLrZtRVFPb2jFe7s5WhPZjRXeInaqK8B7NBp
        IopZuCHim+wf4+XrrjuMvgvhutHyJ8HgKgerEX9dNLLnW2KwLE4YNrBdaCyabIT2oCZLjf
        2zBWXNRH9dYHgipNDo108gdyW53zH/c=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-xeIx8_xhNvOzQtX1y5hAIw-1; Mon, 26 Apr 2021 11:19:33 -0400
X-MC-Unique: xeIx8_xhNvOzQtX1y5hAIw-1
Received: by mail-qt1-f197.google.com with SMTP id j3-20020ac874c30000b02901bab5879d6aso2322530qtr.0
        for <fstests@vger.kernel.org>; Mon, 26 Apr 2021 08:19:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IFzB4KNaIFq/ofbLBvY4Ku1mpUHjaVK+bShHAz3FfEw=;
        b=BJlFZq6bYYcv6Mfyf9n1Rtq5FHfCkh/ZxCo1AvpAcdCOiO/D5XRfdaJlU1gVkzEUtU
         nSfoTSeQAAl8AgeuL1yvbegRUdgFY9+7tEWLVfO5oL0tLmaa0ey/W+e7JhuGnNHVjRYe
         RPWUvwqAWE2qEOCrXvCsbClsUX+Br57TV8W4XoN2C9V+2tnpt3wjkbsYcrW3NKv2nyes
         1SHnNC9+JqkPl9b4wzUXTeI53n6SMHLXYmQQpJ3gt2kf2OvLuvZhx2At2t+tJosfjRBK
         tIdnqSK03yxDef3iNp3ocQ5Skwzrgo70JtibThbAxt9uM+chnmRaIJA6D7znBa/IoPjC
         IL7A==
X-Gm-Message-State: AOAM530FjIA3d//KHoi+HByEt9NfQnezXgh7DYiAGQerxuLhnr0nJl4U
        co7eLN3tgoIPjQI/r/kCVsb/BZVC01bKs0juDADKC73OmqCThHO8gUm0f2R43LTP9/HrSOCTpuY
        FmXpXc2PTSW/qhR/5YQ==
X-Received: by 2002:a05:6214:10ca:: with SMTP id r10mr18040150qvs.53.1619450372551;
        Mon, 26 Apr 2021 08:19:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxp5/9uFdRNLuV9EHxyHU3Ly6LFcJXoDO4FKApu+tGU7UxqAV/KnputtRv+CzaD2jNpwdbwrQ==
X-Received: by 2002:a05:6214:10ca:: with SMTP id r10mr18040130qvs.53.1619450372307;
        Mon, 26 Apr 2021 08:19:32 -0700 (PDT)
Received: from bfoster ([98.216.211.229])
        by smtp.gmail.com with ESMTPSA id f16sm4055268qtq.43.2021.04.26.08.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 08:19:31 -0700 (PDT)
Date:   Mon, 26 Apr 2021 11:19:29 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     bxue@redhat.com
Cc:     fstests@vger.kernel.org, minlei@redhat.com, lczerner@redhat.com
Subject: Re: [PATCH v3] generic/563: tolerate small reads in "write ->
 read/write" sub-test
Message-ID: <YIbaAawCMf10V4Rd@bfoster>
References: <20210426145620.1174139-1-bxue@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210426145620.1174139-1-bxue@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Apr 26, 2021 at 10:56:20PM +0800, bxue@redhat.com wrote:
> From: Boyang Xue <bxue@redhat.com>
> 
> On ext2/ext3, it's expected that several single block metadata reads can occur
> when writing to file in the same cgroup (the stack is like below[1]). The
> purpose of the "write -> read/write" subtest is to make sure the larger pwrite
> is accounted to the correct cgroup, not necessarily enforce that zero bytes are
> read in service of the write. This patch fixes the sub-test in order to tolerate
> small reads in 1st cgroup.
> 
> [1] Callchain of the read:
> 
> @ext3_read_bio[
>     submit_bio+1
>     submit_bh_wbc+365
>     ext4_read_bh+72
>     ext4_get_branch+201
>     ext4_ind_map_blocks+382
>     ext4_map_blocks+295
>     _ext4_get_block+170
>     __block_write_begin_int+328
>     ext4_write_begin+541
>     generic_perform_write+213
>     ext4_buffered_write_iter+167
>     new_sync_write+345
>     vfs_write+438
>     __x64_sys_pwrite64+140
>     do_syscall_64+51
>     entry_SYSCALL_64_after_hwframe+68
> , 5793, 12]: 3
> 
> Signed-off-by: Boyang Xue <bxue@redhat.com>
> ---

LGTM, thanks for the fixups:

Reviewed-by: Brian Foster <bfoster@redhat.com>

> Hi,
> 
> This patch fix the "write -> read/write" sub-test in order to tolerate
> small reads in service of the write (like read metadata).
> 
> Change from v2:
> Restore write tolerance to 5%, to match the historical behavior of the
> test.
> 
> Thanks,
> Boyang
> 
>  tests/generic/563 | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/tests/generic/563 b/tests/generic/563
> index b113eacf..e73acebd 100755
> --- a/tests/generic/563
> +++ b/tests/generic/563
> @@ -60,6 +60,8 @@ check_cg()
>  	cgname=$(basename $cgroot)
>  	expectedread=$2
>  	expectedwrite=$3
> +	readtol=$4
> +	writetol=$5
>  	rbytes=0
>  	wbytes=0
>  
> @@ -71,8 +73,8 @@ check_cg()
>  			awk -F = '{ print $2 }'`
>  	fi
>  
> -	_within_tolerance "read" $rbytes $expectedread 5% -v
> -	_within_tolerance "write" $wbytes $expectedwrite 5% -v
> +	_within_tolerance "read" $rbytes $expectedread $readtol -v
> +	_within_tolerance "write" $wbytes $expectedwrite $writetol -v
>  }
>  
>  # Move current process to another cgroup.
> @@ -113,7 +115,7 @@ $XFS_IO_PROG -c "pread 0 $iosize" -c "pwrite 0 $iosize" -c fsync \
>  	$SCRATCH_MNT/file >> $seqres.full 2>&1
>  switch_cg $cgdir
>  $XFS_IO_PROG -c fsync $SCRATCH_MNT/file
> -check_cg $cgdir/$seq-cg $iosize $iosize
> +check_cg $cgdir/$seq-cg $iosize $iosize 5% 5%
>  
>  # Write from one cgroup then read and write from a second. Writes are charged to
>  # the first group and nothing to the second.
> @@ -126,8 +128,12 @@ $XFS_IO_PROG -c "pread 0 $iosize" -c "pwrite 0 $iosize" $SCRATCH_MNT/file \
>  	>> $seqres.full 2>&1
>  switch_cg $cgdir
>  $XFS_IO_PROG -c fsync $SCRATCH_MNT/file
> -check_cg $cgdir/$seq-cg 0 $iosize
> -check_cg $cgdir/$seq-cg-2 0 0
> +# Use a fixed value tolerance for the expected value of zero here
> +# because filesystems might perform a small number of metadata reads to
> +# complete the write. On ext2/3 with 1k block size, the read bytes is
> +# as large as 33792.
> +check_cg $cgdir/$seq-cg 0 $iosize 33792 5%
> +check_cg $cgdir/$seq-cg-2 0 0 0 0
>  
>  # Read from one cgroup, read & write from a second. Both reads and writes are
>  # charged to the first group and nothing to the second.
> @@ -140,8 +146,8 @@ $XFS_IO_PROG -c "pread 0 $iosize" -c "pwrite 0 $iosize" $SCRATCH_MNT/file \
>  	>> $seqres.full 2>&1
>  switch_cg $cgdir
>  $XFS_IO_PROG -c fsync $SCRATCH_MNT/file
> -check_cg $cgdir/$seq-cg $iosize $iosize
> -check_cg $cgdir/$seq-cg-2 0 0
> +check_cg $cgdir/$seq-cg $iosize $iosize 5% 5%
> +check_cg $cgdir/$seq-cg-2 0 0 0 0
>  
>  echo "-io" > $cgdir/cgroup.subtree_control || _fail "subtree control"
>  
> -- 
> 2.27.0
> 

