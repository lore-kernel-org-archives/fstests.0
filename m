Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62985C433F5
	for <linux-fstests@archiver.kernel.org>; Fri, 29 Oct 2021 15:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4075D611C7
	for <linux-fstests@archiver.kernel.org>; Fri, 29 Oct 2021 15:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbhJ2PoQ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 29 Oct 2021 11:44:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:50342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229928AbhJ2PoP (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 29 Oct 2021 11:44:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C044611C4;
        Fri, 29 Oct 2021 15:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635522107;
        bh=5SfNAhWSIYEMi39ssKtuiJY4bOni57aAytK/NDTaL2Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s+q3MymJV/cX3+wq76ulWFj+FPyFGXs8miniqJNfTYU7im0CLnW2KqvuwcU4fNbyT
         ujpF4KYdt6UohONVqjY61uYHtop6gt8sMN2GZ7Lxpf4k9a3jCLLTkNx54w8lVI2Ek7
         kPtMO0iIE8jDc0WqPTsQnC88sNbaxNv/wny9xq1GktpC5iNX8eTVSCtQHztWVtU4bP
         9DiRtM1HzZ7N7ZAWBL648vA9lKyQgMS0c9wVkQ3e++Sh0xj06/JNEzVq2CY5QxX7xN
         TNC9KMCWhCzChzt0Yrd0wdcHodrkP4qdV1Ao228FfAUsatPiK0PCOjItw2o5WAam9K
         lrYm7l+HwvzLQ==
Date:   Fri, 29 Oct 2021 08:41:46 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 3/3] generic/201: fix the description
Message-ID: <20211029154146.GS24282@magnolia>
References: <20211029065943.3556529-1-ruansy.fnst@fujitsu.com>
 <20211029065943.3556529-4-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211029065943.3556529-4-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Oct 29, 2021 at 02:59:43PM +0800, Shiyang Ruan wrote:
> This case is test for 'unlink', and there is no umount operation here.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>

Thanks for fixing this

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  tests/generic/201     | 2 +-
>  tests/generic/201.out | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/generic/201 b/tests/generic/201
> index 9b65445a..2598b44a 100755
> --- a/tests/generic/201
> +++ b/tests/generic/201
> @@ -50,7 +50,7 @@ md5sum $testdir/file1 | _filter_scratch
>  md5sum $testdir/file3 | _filter_scratch
>  md5sum $testdir/file3.chk | _filter_scratch
>  
> -echo "CoW and unmount"
> +echo "CoW and unlink"
>  cowoff=$((filesize / 4))
>  cowsz=$((filesize / 2))
>  $XFS_IO_PROG -f -c "pwrite -S 0x63 -b $cowsz $cowoff $cowsz" $testdir/file3 >> $seqres.full
> diff --git a/tests/generic/201.out b/tests/generic/201.out
> index 52669d27..6867704a 100644
> --- a/tests/generic/201.out
> +++ b/tests/generic/201.out
> @@ -5,4 +5,4 @@ Compare files
>  bdbcf02ee0aa977795a79d25fcfdccb1  SCRATCH_MNT/test-201/file1
>  d3959a68638c50af07f0258e032cb554  SCRATCH_MNT/test-201/file3
>  d3959a68638c50af07f0258e032cb554  SCRATCH_MNT/test-201/file3.chk
> -CoW and unmount
> +CoW and unlink
> -- 
> 2.33.0
> 
> 
> 
