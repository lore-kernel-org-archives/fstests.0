Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7709C433B4
	for <linux-fstests@archiver.kernel.org>; Fri, 23 Apr 2021 11:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 891EC61468
	for <linux-fstests@archiver.kernel.org>; Fri, 23 Apr 2021 11:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhDWLH7 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 23 Apr 2021 07:07:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54826 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229871AbhDWLH6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 23 Apr 2021 07:07:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619176042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2V5/qg/7b2mzgwegTNNBzQJGdexDyvvKIyI/glg1eog=;
        b=OUrVqKvlSuQ58W/1rTomGvf63J9+jXO4SnE+4JuDW1Z6R29TqL6c1PPMjDWrn1gf8WGRyQ
        WDD+Bp0ZhEar9zM5Xm1CTpq4hsHSxxWSJML6Ea4b2TgNZ7eFg/Kb/9lKOqL8HlbWucmuS6
        PgnMbnod7H/UEvZOwvpJTevu/wgn14I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-r3v6AYx-PJeYbjd5mU2XYw-1; Fri, 23 Apr 2021 07:07:20 -0400
X-MC-Unique: r3v6AYx-PJeYbjd5mU2XYw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B3B7218B9F49
        for <fstests@vger.kernel.org>; Fri, 23 Apr 2021 11:07:19 +0000 (UTC)
Received: from bfoster (ovpn-112-25.rdu2.redhat.com [10.10.112.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 29A0A19D9B;
        Fri, 23 Apr 2021 11:07:19 +0000 (UTC)
Date:   Fri, 23 Apr 2021 07:07:17 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     bxue@redhat.com
Cc:     fstests@vger.kernel.org, minlei@redhat.com, lczerner@redhat.com
Subject: Re: [PATCH v2] generic/563: tolerate small reads in "write ->
 read/write" sub-test
Message-ID: <YIKqZZTRZPFjtQwh@bfoster>
References: <20210422153147.1049666-1-bxue@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422153147.1049666-1-bxue@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Apr 22, 2021 at 11:31:47PM +0800, bxue@redhat.com wrote:
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
> Hi,
> 
> This patch fix the "write -> read/write" sub-test in order to tolerate
> small reads in service of the write (like read metadata).
> 
> Change from v1:
> (1) More details in commit log, including example call stack
> (2) Set the fixed tolerance value to 33792 for accuracy
> (3) Update percentage tolerance value to fixed value 0, where doesn't
> fail the test
> 
> Tested pass on ext2/ext3/ext4 x 1k/2k/4k blksize.
> 
> Thanks,
> Boyang
> 
>  tests/generic/563 | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/tests/generic/563 b/tests/generic/563
> index b113eacf..44394b4b 100755
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
> +check_cg $cgdir/$seq-cg 0 $iosize 33792 0

Shouldn't that last parameter (write tolerance) remain as 5%?

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
> +check_cg $cgdir/$seq-cg $iosize $iosize 5% 0

And here too? Otherwise the patch LGTM.

Brian

> +check_cg $cgdir/$seq-cg-2 0 0 0 0
>  
>  echo "-io" > $cgdir/cgroup.subtree_control || _fail "subtree control"
>  
> -- 
> 2.27.0
> 

