Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B75C433EF
	for <linux-fstests@archiver.kernel.org>; Thu,  2 Jun 2022 00:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbiFBAvn (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 1 Jun 2022 20:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbiFBAvm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 1 Jun 2022 20:51:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B477E59323
        for <fstests@vger.kernel.org>; Wed,  1 Jun 2022 17:51:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FA7D60FAC
        for <fstests@vger.kernel.org>; Thu,  2 Jun 2022 00:51:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED70CC385B8;
        Thu,  2 Jun 2022 00:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654131100;
        bh=sJNuBncM1IvqppMByKG+jERHQlPVZ9x6jRCg5qFg3l8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p09hLDNr61BnPb2qy+PuAUFVq2cYOYzpymdFKWJM2PAkhQ+NILoYt0tjrPUrscSBn
         YrPP3UdfruuITOOfHO28UxAqt0+qaZdC7wRqIM8urhxdSWQ+DbRJVqaJzSXTXCpuN7
         FqUcJwoS+O79INnOkju9L0pBRhjm3P7vUi1uU4QrOcjZcPqFhurWLRRJUZe7ckQqQU
         eSt9vEbJHBt8RvmRGIv2Xq8qLOCOXL8Ph8PYB69VxXik9FPuvsCfZ08mhAcmS1H7r0
         PIRBZ8UOiLSPj+GO3SYlc873VJ/konE4CkCvHDygO54FNFSfffOERRgXeW3kPmP8ek
         k76J2OBAEmhRQ==
Date:   Wed, 1 Jun 2022 17:51:39 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 4/8] generic/038: kill background threads on interrupt
Message-ID: <YpgJm3HURM3qVssn@magnolia>
References: <20220602003126.2903779-1-david@fromorbit.com>
 <20220602003126.2903779-5-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602003126.2903779-5-david@fromorbit.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jun 02, 2022 at 10:31:22AM +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> When I ctrl-c g/038, it either does nothing or it leaves processes
> running in the background. It is not cleaning up it's background
> processes correctly, so add kill vectors into the cleanup. Make sure
> we only kill in the cleanup trap if the background processes are
> running.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Looks ok,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  tests/generic/038 | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/tests/generic/038 b/tests/generic/038
> index c6cea94e..e9b49967 100755
> --- a/tests/generic/038
> +++ b/tests/generic/038
> @@ -36,6 +36,10 @@ _begin_fstest auto stress trim
>  # Override the default cleanup function.
>  _cleanup()
>  {
> +	[ -n "${create_pids}" ] && kill ${create_pids[@]}
> +	[ -n "${fallocate_pids}" ] && kill ${fallocate_pids[@]}
> +	[ -n "${trim_pids}" ] && kill ${trim_pids[@]}
> +	wait
>  	rm -fr $tmp
>  }
>  
> @@ -47,6 +51,8 @@ _supported_fs generic
>  _require_scratch
>  _require_xfs_io_command "falloc"
>  
> +echo "Silence is golden"
> +
>  # Keep allocating and deallocating 1G of data space with the goal of creating
>  # and deleting 1 block group constantly. The intention is to race with the
>  # fstrim loop below.
> @@ -113,7 +119,7 @@ create_files()
>  	done
>  
>  	wait ${create_pids[@]}
> -
> +	unset create_pids
>  }
>  
>  _scratch_mkfs >>$seqres.full 2>&1
> @@ -136,12 +142,8 @@ create_files "foobar"
>  kill ${fallocate_pids[@]}
>  kill ${trim_pids[@]}
>  wait
> +unset fallocate_pids
> +unset trim_pids
>  
> -# The fstests framework will now check for fs consistency with fsck.
> -# The trimming was racy and caused some btree nodes to get full of zeroes on
> -# disk, which obviously caused fs metadata corruption. The race often lead
> -# to missing free space entries in a block group's free space cache too.
> -
> -echo "Silence is golden"
>  status=0
>  exit
> -- 
> 2.35.1
> 
