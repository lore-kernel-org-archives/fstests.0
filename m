Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	LOTS_OF_MONEY,MAILING_LIST_MULTI,MONEY_NOHTML,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDACC433E0
	for <linux-fstests@archiver.kernel.org>; Mon,  1 Mar 2021 16:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12D5664FD3
	for <linux-fstests@archiver.kernel.org>; Mon,  1 Mar 2021 16:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234596AbhCAQfb (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 1 Mar 2021 11:35:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:36326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234870AbhCAQ3N (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 1 Mar 2021 11:29:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D678464EEC;
        Mon,  1 Mar 2021 16:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614615768;
        bh=D59geVbGnDL9Lbu0d64oQlUiyGNfkePFkE+kCGJ3uFQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZfWuaS4Yqi7m6ht5LnSuKhvg3JRIgRH0TnfEix3h0+hyiaoMPwUcj9XNOF9ZWiRDq
         aiqVMiDnCKE77Jk2X4YSuMNjWDm8CXYNCQ6DTewUrfB17X/XxZ1dCsp1opjjkvuRja
         ELR3NGxcGw7WLqowDiqLZ7SdV3/lvm4bb08BM2/z5ayGooUghPNtqsDnMZNeSxBMkT
         sRGHlL+1Lqc0SgCYU1M8Y16kY4xTnhGic4pb+Bx2DlfAMoqs43fT1boixZAPMmMKJn
         BdP9gZbVNLkSpVqULfXJnrw6cjAtm6yC5TFa5jo6Kmrk9JZci1v5TtAMFqU7P2OdUR
         q6KoAZth9XPig==
Date:   Mon, 1 Mar 2021 08:22:47 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] xfstests: remove _require_no_rtinherit completely
Message-ID: <20210301162247.GC7269@magnolia>
References: <20210301014603.147159-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210301014603.147159-1-zlang@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Mar 01, 2021 at 09:46:03AM +0800, Zorro Lang wrote:
> The _require_no_rtinherit has been removed by:
>   0ac0d8fb ("common: remove _require_no_rtinherit")
> 
> But some cases still remain the _require_no_rtinherit, so remove
> them all.
> 
> Signed-off-by: Zorro Lang <zlang@redhat.com>

Urrrrrrk, I didn't notice that this half of the removal ended up in the
wrong patch. :(

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  tests/generic/250 | 7 ++++---
>  tests/generic/252 | 6 +++---
>  tests/generic/441 | 7 ++++---
>  tests/generic/484 | 7 ++++---
>  tests/generic/487 | 7 ++++---
>  5 files changed, 19 insertions(+), 15 deletions(-)
> 
> diff --git a/tests/generic/250 b/tests/generic/250
> index eaa2f884..102bf500 100755
> --- a/tests/generic/250
> +++ b/tests/generic/250
> @@ -33,12 +33,13 @@ _require_scratch
>  _require_dm_target error
>  _require_xfs_io_command "falloc"
>  _require_odirect
> -# This test uses "dm" without taking into account the data could be on
> -# realtime subvolume, thus the test will fail with rtinherit=1
> -_require_no_rtinherit
>  
>  rm -f $seqres.full
>  
> +# Disable the scratch rt device to avoid test failures relating to the rt
> +# bitmap consuming all the free space in our small data device.
> +unset SCRATCH_RTDEV
> +
>  fssize=$((196 * 1048576))
>  echo "Format and mount"
>  $XFS_IO_PROG -d -c "pwrite -S 0x69 -b 1048576 0 $fssize" $SCRATCH_DEV >> $seqres.full
> diff --git a/tests/generic/252 b/tests/generic/252
> index 61369759..809e8020 100755
> --- a/tests/generic/252
> +++ b/tests/generic/252
> @@ -32,14 +32,14 @@ _cleanup()
>  _require_scratch
>  _require_dm_target error
>  _require_xfs_io_command "falloc"
> -# This test uses "dm" without taking into account the data could be on
> -# realtime subvolume, thus the test will fail with rtinherit=1
> -_require_no_rtinherit
>  _require_aiodio "aiocp"
>  AIO_TEST="$here/src/aio-dio-regress/aiocp"
>  
>  rm -f $seqres.full
>  
> +# Disable the scratch rt device to avoid test failures relating to the rt
> +# bitmap consuming all the free space in our small data device.
> +unset SCRATCH_RTDEV
>  
>  fssize=$((196 * 1048576))
>  echo "Format and mount"
> diff --git a/tests/generic/441 b/tests/generic/441
> index 6ad449bb..bedbcb08 100755
> --- a/tests/generic/441
> +++ b/tests/generic/441
> @@ -32,9 +32,6 @@ _cleanup()
>  
>  # real QA test starts here
>  _require_scratch
> -# This test uses "dm" without taking into account the data could be on
> -# realtime subvolume, thus the test will fail with rtinherit=1
> -_require_no_rtinherit
>  
>  # Generally, we want to avoid journal errors on the extended testcase. Only
>  # unset the -s flag if we have a logdev
> @@ -57,6 +54,10 @@ _require_test_program dmerror
>  
>  rm -f $seqres.full
>  
> +# Disable the scratch rt device to avoid test failures relating to the rt
> +# bitmap consuming all the free space in our small data device.
> +unset SCRATCH_RTDEV
> +
>  echo "Format and mount"
>  _scratch_mkfs > $seqres.full 2>&1
>  _dmerror_init
> diff --git a/tests/generic/484 b/tests/generic/484
> index ad39e45b..331cd1ad 100755
> --- a/tests/generic/484
> +++ b/tests/generic/484
> @@ -37,14 +37,15 @@ _cleanup()
>  
>  # real QA test starts here
>  _require_scratch_nocheck
> -# This test uses "dm" without taking into account the data could be on
> -# realtime subvolume, thus the test will fail with rtinherit=1
> -_require_no_rtinherit
>  _require_dm_target error
>  _require_xfs_io_command "syncfs"
>  
>  rm -f $seqres.full
>  
> +# Disable the scratch rt device to avoid test failures relating to the rt
> +# bitmap consuming all the free space in our small data device.
> +unset SCRATCH_RTDEV
> +
>  echo "Format and mount"
>  _scratch_mkfs > $seqres.full 2>&1
>  _dmerror_init
> diff --git a/tests/generic/487 b/tests/generic/487
> index 197b2385..1aa97ada 100755
> --- a/tests/generic/487
> +++ b/tests/generic/487
> @@ -32,9 +32,6 @@ _cleanup()
>  
>  # real QA test starts here
>  _require_scratch_nocheck
> -# This test uses "dm" without taking into account the data could be on
> -# realtime subvolume, thus the test will fail with rtinherit=1
> -_require_no_rtinherit
>  
>  sflag='-s'
>  case $FSTYP in
> @@ -50,6 +47,10 @@ _require_dm_target error
>  
>  rm -f $seqres.full
>  
> +# Disable the scratch rt device to avoid test failures relating to the rt
> +# bitmap consuming all the free space in our small data device.
> +unset SCRATCH_RTDEV
> +
>  echo "Format and mount"
>  _scratch_mkfs > $seqres.full 2>&1
>  _dmerror_init
> -- 
> 2.29.2
> 
