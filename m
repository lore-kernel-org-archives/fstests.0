Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FC4C38A02
	for <linux-fstests@archiver.kernel.org>; Sun, 30 Oct 2022 03:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiJ3Dbw (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 29 Oct 2022 23:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJ3Dbv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 29 Oct 2022 23:31:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666934687D
        for <fstests@vger.kernel.org>; Sat, 29 Oct 2022 20:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667100648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K+I7AYE5xAGm+ej8pDmP4KSGlE35GPlIkSJSeNUr2io=;
        b=PvXFOekRXbIwq332QNjDEEuxSpc8xNFTCEclK2uFNkyHPw2hj9k7SUeRaNm4fBc03td6wL
        3dAUQvfUg9UowrsH/l4xYdxRg90aOdbfjgnLrg9bbv4TGDWNPfrzdDuRb6ZcyPGBdT6+FJ
        A57SJdoGuZDfSYbJTbVT1g7psF8gBEM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-399-c9AAAdVIPUex4GBDdkNn3g-1; Sat, 29 Oct 2022 23:30:47 -0400
X-MC-Unique: c9AAAdVIPUex4GBDdkNn3g-1
Received: by mail-qv1-f71.google.com with SMTP id q16-20020a0ce210000000b004ba8976d3aaso4570002qvl.5
        for <fstests@vger.kernel.org>; Sat, 29 Oct 2022 20:30:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K+I7AYE5xAGm+ej8pDmP4KSGlE35GPlIkSJSeNUr2io=;
        b=oFpayb3p8MqQLQerGym/N6kiGkJRVn2Zzn0+9Ycve8KDmYCNdyc2GZrXebwZci9Hdn
         xqmDjGcBsMEkOX5vwqMMTvNWDE7XcSIu16R1Tl+I4YoQVIWLEXmHmmoY2NK0LMP9bsDY
         Ilm9vS/p+Ihpz7sVGPwmw+cjF3mp+fmwVG7AWjulo7t7ne4kgmWPamzNLSC1Zc987UMu
         9VlnYMDwYjafKxauWhSaoU8DNynCydm2/KdZvksqxz7yuPRhPlQi2C5lVSDQ0+Ccxo6D
         dwykUpjDVApLOnEAe2jXPi3bmL+LOdcvltkhts7CqoWA6Fp31CY3h21XS+yrKcRngXAs
         8vIw==
X-Gm-Message-State: ACrzQf3HSFecCbacxlMXuvdvQAyLWK34FKoYJ1uWxCGAfWd543nc0R5K
        OtxsXHcWZ5lNtEyMEHeIHLRPMu5bOnnnCBouMinJpv56imjplgdZ0IFFt4dkspokOirBY++YRv8
        1s42sjW1ezXrBVO/i3Ya6FM1ZJAYa7hf++Xce7HpJQXnbgNwJZIuqCgl6V8Jq95/VWw==
X-Received: by 2002:a05:6214:21e5:b0:4b3:f3e0:5432 with SMTP id p5-20020a05621421e500b004b3f3e05432mr5735936qvj.19.1667100646133;
        Sat, 29 Oct 2022 20:30:46 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7ljld8T68BMfo7yp1VxLrt41hcEKHITaj02f7tM14dmzeKba/FEbtDcOQeoJSUJYKpPL/wMw==
X-Received: by 2002:a05:6214:21e5:b0:4b3:f3e0:5432 with SMTP id p5-20020a05621421e500b004b3f3e05432mr5735922qvj.19.1667100645834;
        Sat, 29 Oct 2022 20:30:45 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id i22-20020ac871d6000000b003431446588fsm1736604qtp.5.2022.10.29.20.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 20:30:45 -0700 (PDT)
Date:   Sun, 30 Oct 2022 11:30:41 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org
Subject: Re: [PATCH 3/4] xfs: refactor filesystem realtime geometry detection
 logic
Message-ID: <20221030033041.giu6hui56dkipfl4@zlang-mailbox>
References: <166697890818.4183768.10822596619783607332.stgit@magnolia>
 <166697892518.4183768.8627162682551184087.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166697892518.4183768.8627162682551184087.stgit@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Oct 28, 2022 at 10:42:05AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> There are a lot of places where we open-code detecting the realtime
> extent size and extent count of a specific filesystem.  Refactor this
> into a couple of helpers to clean up the code.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---

Good to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

>  common/populate |    2 +-
>  common/xfs      |   31 +++++++++++++++++++++++++++++--
>  tests/xfs/146   |    2 +-
>  tests/xfs/147   |    2 +-
>  tests/xfs/530   |    3 +--
>  5 files changed, 33 insertions(+), 7 deletions(-)
> 
> 
> diff --git a/common/populate b/common/populate
> index 23b2fecf69..d9d4c6c300 100644
> --- a/common/populate
> +++ b/common/populate
> @@ -323,7 +323,7 @@ _scratch_xfs_populate() {
>  	fi
>  
>  	# Realtime Reverse-mapping btree
> -	is_rt="$($XFS_INFO_PROG "${SCRATCH_MNT}" | grep -c 'rtextents=[1-9]')"
> +	is_rt="$(_xfs_get_rtextents "$SCRATCH_MNT")"
>  	if [ $is_rmapbt -gt 0 ] && [ $is_rt -gt 0 ]; then
>  		echo "+ rtrmapbt btree"
>  		nr="$((blksz * 2 / 32))"
> diff --git a/common/xfs b/common/xfs
> index 9b6575b5f2..a995e0b5da 100644
> --- a/common/xfs
> +++ b/common/xfs
> @@ -174,6 +174,24 @@ _scratch_mkfs_xfs()
>  	return $mkfs_status
>  }
>  
> +# Get the number of realtime extents of a mounted filesystem.
> +_xfs_get_rtextents()
> +{
> +	local path="$1"
> +
> +	$XFS_INFO_PROG "$path" | grep 'rtextents' | \
> +		sed -e 's/^.*rtextents=\([0-9]*\).*$/\1/g'
> +}
> +
> +# Get the realtime extent size of a mounted filesystem.
> +_xfs_get_rtextsize()
> +{
> +	local path="$1"
> +
> +	$XFS_INFO_PROG "$path" | grep 'realtime.*extsz' | \
> +		sed -e 's/^.*extsz=\([0-9]*\).*$/\1/g'
> +}
> +
>  # Get the size of an allocation unit of a file.  Normally this is just the
>  # block size of the file, but for realtime files, this is the realtime extent
>  # size.
> @@ -191,7 +209,7 @@ _xfs_get_file_block_size()
>  	while ! $XFS_INFO_PROG "$path" &>/dev/null && [ "$path" != "/" ]; do
>  		path="$(dirname "$path")"
>  	done
> -	$XFS_INFO_PROG "$path" | grep realtime | sed -e 's/^.*extsz=\([0-9]*\).*$/\1/g'
> +	_xfs_get_rtextsize "$path"
>  }
>  
>  # Get the directory block size of a mounted filesystem.
> @@ -427,13 +445,22 @@ _require_xfs_crc()
>  # third option is -v, echo 1 for success and 0 for not.
>  #
>  # Starting with xfsprogs 4.17, this also works for unmounted filesystems.
> +# The feature 'realtime' looks for rtextents > 0.
>  _xfs_has_feature()
>  {
>  	local fs="$1"
>  	local feat="$2"
>  	local verbose="$3"
> +	local feat_regex="1"
>  
> -	local answer="$($XFS_INFO_PROG "$fs" 2>&1 | grep -w -c "$feat=1")"
> +	case "$feat" in
> +	"realtime")
> +		feat="rtextents"
> +		feat_regex="[1-9][0-9]*"
> +		;;
> +	esac
> +
> +	local answer="$($XFS_INFO_PROG "$fs" 2>&1 | grep -E -w -c "$feat=$feat_regex")"
>  	if [ "$answer" -ne 0 ]; then
>  		test "$verbose" = "-v" && echo 1
>  		return 0
> diff --git a/tests/xfs/146 b/tests/xfs/146
> index 5516d396bf..123bdff59f 100755
> --- a/tests/xfs/146
> +++ b/tests/xfs/146
> @@ -31,7 +31,7 @@ _scratch_mkfs > $seqres.full
>  _scratch_mount >> $seqres.full
>  
>  blksz=$(_get_block_size $SCRATCH_MNT)
> -rextsize=$($XFS_INFO_PROG $SCRATCH_MNT | grep realtime.*extsz | sed -e 's/^.*extsz=\([0-9]*\).*$/\1/g')
> +rextsize=$(_xfs_get_rtextsize "$SCRATCH_MNT")
>  rextblks=$((rextsize / blksz))
>  
>  echo "blksz $blksz rextsize $rextsize rextblks $rextblks" >> $seqres.full
> diff --git a/tests/xfs/147 b/tests/xfs/147
> index e21fdd330c..33b3c99633 100755
> --- a/tests/xfs/147
> +++ b/tests/xfs/147
> @@ -29,7 +29,7 @@ _scratch_mkfs -r extsize=256k > $seqres.full
>  _scratch_mount >> $seqres.full
>  
>  blksz=$(_get_block_size $SCRATCH_MNT)
> -rextsize=$($XFS_INFO_PROG $SCRATCH_MNT | grep realtime.*extsz | sed -e 's/^.*extsz=\([0-9]*\).*$/\1/g')
> +rextsize=$(_xfs_get_rtextsize "$SCRATCH_MNT")
>  rextblks=$((rextsize / blksz))
>  
>  echo "blksz $blksz rextsize $rextsize rextblks $rextblks" >> $seqres.full
> diff --git a/tests/xfs/530 b/tests/xfs/530
> index c960738db7..56f5e7ebdb 100755
> --- a/tests/xfs/530
> +++ b/tests/xfs/530
> @@ -73,8 +73,7 @@ _try_scratch_mount || _notrun "Couldn't mount fs with synthetic rt volume"
>  formatted_blksz="$(_get_block_size $SCRATCH_MNT)"
>  test "$formatted_blksz" -ne "$dbsize" && \
>  	_notrun "Tried to format with $dbsize blocksize, got $formatted_blksz."
> -$XFS_INFO_PROG $SCRATCH_MNT | grep -E -q 'realtime.*blocks=0' && \
> -	_notrun "Filesystem should have a realtime volume"
> +_require_xfs_has_feature "$SCRATCH_MNT" realtime
>  
>  echo "Consume free space"
>  fillerdir=$SCRATCH_MNT/fillerdir
> 

