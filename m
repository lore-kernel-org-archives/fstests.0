Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B71F2EAB64
	for <fstests@vger.kernel.org>; Wed, 18 Jun 2025 15:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750259950; cv=none; b=FH4Ey4ntPGs2K+j3AEVn24R5KzqibYSEQAItovoQHldZ2JJqtjhDO04ajiONvR0Son0fMcjTEhxGC/2LQeRuNkaG4VNY1L7XpKL8/GHXfXNFV1vrJpxfsupOZUdRsSMwaRcMLvNqe4IDYu5dFZiVuKbe6g01t7As16bl8/d+fJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750259950; c=relaxed/simple;
	bh=ojX4SF6dGhndv11TGfE6g7yZKJplokgNmTmVtt2GsQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n1IAwVaPfBlremIIiQRl2+IK2OIbpwQG3kPVj3SYlKW0lzAm7UtOzRkWvPLfwBPYApRCxYenUBccHJFaJJncTdOBqfmkIudLj9brNIcZK06te/red1gyH5IKndf4eyHN1Hdyf4+VZeut/C3VUIsl/jQmPvnnV7wNCDtR1GEPsYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JENYYAVG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JENYYAVG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750259947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z30kNtOgZyp00dZO2HkhAR2TtTggoK+GDbdlcN7uCQ8=;
	b=JENYYAVG+UcqxVY8yGzpdEhfJ59waDL6VXVMjxyu/fo9P/zQt6WTK2tbeemjJUeR9u70vJ
	R9Lnxg9fus+IBW+hQR2N9ufHAmexqarAjXU7pb+EVrcXp/U0yNkCFLv1o/2F8mPhvCk3gi
	BLv5SWoufhEOTF+x2tvRoZ9rNRXUs8g=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-ky4SrLkCMsa33FN_Rdziiw-1; Wed, 18 Jun 2025 11:19:05 -0400
X-MC-Unique: ky4SrLkCMsa33FN_Rdziiw-1
X-Mimecast-MFC-AGG-ID: ky4SrLkCMsa33FN_Rdziiw_1750259945
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-748f3d4c7e7so201131b3a.3
        for <fstests@vger.kernel.org>; Wed, 18 Jun 2025 08:19:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750259944; x=1750864744;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z30kNtOgZyp00dZO2HkhAR2TtTggoK+GDbdlcN7uCQ8=;
        b=rOnZl+jvDHslv3q1H5P01GjDF9sO3pamO7+EGZo8w6tpg5dky2xVaSd5I87/QZZKtq
         Gz5dHObTVO6E5QWRwrkepkrM0Zajl7YcPbxF0Ml8/2f61eOFSkmaX7j4gCFJDtBCpGW8
         pZQfEo0P8KWrIoMgyzUQMf3k8RnAO1er35Jan2ORf8RX3ZV1GyCxc2o6uxIqX8LRcIAx
         Qkxhw/YqFzTpwRx/Gz7bWpiSAGgYjIN/d0msMiLBytegdSaH3Tc4p2LhqDZeNomHPqma
         zNIfdLjF6hTQmM6pho1YveKL41bPCF+nhN9ycoD9KubBISHxF60YYNU6zhYnA7GmqwH9
         qe2w==
X-Forwarded-Encrypted: i=1; AJvYcCUSIqSbHvsfytgb6YGfvNJRxtuzhYAP17qYp0YYzNXrC2veKaksd4tpC4oBF278QvpnRGKn2xKP@vger.kernel.org
X-Gm-Message-State: AOJu0YxdtanOCxgm/lCU9fBXx+VEoBkp6M3pJCMZnBYS8krNbs2laI67
	Mh6egh3du5SXqBzLXJEK6ngMDgG7QPPpfPsRyeDwXgFIMBHbV+j5gIEM91GNXRP9CN/FzuvzeAE
	PMb22rfi1a1spM5sezc5hVO399CU7vaUet9k9rHiHEuvaWKl05KQApGPJkIGN0bKKSIw=
X-Gm-Gg: ASbGncvvQ0yZ6KdnRyh4BmdE9njEHSAfgvHzipcSNXjdaaXAnOLibg5FtRNBQ7hAd5t
	myjvK7U7vmT/upxOoXLSjixL0Svc7VjiiIhe0j73LpiJIb+OkIX05O/EnizOubsRa3hGj3ByXnO
	u9mltVw3XO+2U4opNIcx/kArpMBqeDR/H76nlcVGo35V+08umgEU7Zf2LeIwQXsquW1hkakQ4mi
	PnuN8kopvfZxwqU/t73BxHLO6zZsTDsFvA3FmGjEw4NQ/sUCrDFG6g+O3waGFXb0L8gJrM8wnCN
	vpdFo/UlPTkzld91sm1Ui7TimX4dqD6UZ1Utby38qokqbqKkXXki0W58c0D+NyY=
X-Received: by 2002:a05:6a21:348b:b0:21f:8d4f:9e3b with SMTP id adf61e73a8af0-21fbd495049mr29550986637.7.1750259944574;
        Wed, 18 Jun 2025 08:19:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaDScrc7zLSZGrtoxWrDo0y2u9/Nhj/Z/6vpLaxl4ORVAkYvGWbDe0RJikOFJTf4L+E5x3dg==
X-Received: by 2002:a05:6a21:348b:b0:21f:8d4f:9e3b with SMTP id adf61e73a8af0-21fbd495049mr29550941637.7.1750259944180;
        Wed, 18 Jun 2025 08:19:04 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fe1643ebdsm11109593a12.26.2025.06.18.08.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 08:19:03 -0700 (PDT)
Date: Wed, 18 Jun 2025 23:18:59 +0800
From: Zorro Lang <zlang@redhat.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	linux-unionfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 1/3] fstests: add helper _scratch_shutdown_and_syncfs
Message-ID: <20250618151859.fly75yltbk3xaanb@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250609151915.2638057-1-amir73il@gmail.com>
 <20250609151915.2638057-2-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609151915.2638057-2-amir73il@gmail.com>

On Mon, Jun 09, 2025 at 05:19:13PM +0200, Amir Goldstein wrote:
> Test xfs/546 has to chain syncfs after shutdown and cannot
> use the _scratch_shitdown helper, because after shutdown a fd
> cannot be opened to execute syncfs on.
> 
> The xfs_io command of chaining syncfs after shutdown is rather
> more complex to execute in the derived overlayfs test overlay/087.
> 
> Add a helper to abstract this complexity from test writers.
> Add a _require statement to match.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---

As we talked, I think this version is good to me, I'll merge it with
the typo fix which Darrick metioned :)

Reviewed-by: Zorro Lang <zlang@redhat.com>

Thanks,
Zorro

>  common/rc         | 27 +++++++++++++++++++++++++++
>  tests/overlay/087 | 13 +++----------
>  tests/xfs/546     |  5 ++---
>  3 files changed, 32 insertions(+), 13 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index f71cc8f0..d9a8b52e 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -595,6 +595,27 @@ _scratch_shutdown_handle()
>  	fi
>  }
>  
> +_scratch_shutdown_and_syncfs()
> +{
> +	if [ $FSTYP = "overlay" ]; then
> +		# In lagacy overlay usage, it may specify directory as
> +		# SCRATCH_DEV, in this case OVL_BASE_SCRATCH_DEV
> +		# will be null, so check OVL_BASE_SCRATCH_DEV before
> +		# running shutdown to avoid shutting down base fs accidently.
> +		if [ -z $OVL_BASE_SCRATCH_DEV ]; then
> +			_fail "_scratch_shutdown: call _require_scratch_shutdown first in test"
> +		fi
> +		# This command is complicated a bit because in the case of overlayfs the
> +		# syncfs fd needs to be opened before shutdown and it is different from the
> +		# shutdown fd, so we cannot use the _scratch_shutdown() helper.
> +		# Filter out xfs_io output of active fds.
> +		$XFS_IO_PROG -x -c "open $(_scratch_shutdown_handle)" -c 'shutdown -f ' \
> +				-c close -c syncfs $SCRATCH_MNT | grep -vF '[00'
> +	else
> +		$XFS_IO_PROG -x -c 'shutdown -f ' -c syncfs $SCRATCH_MNT
> +	fi
> +}
> +
>  _move_mount()
>  {
>  	local mnt=$1
> @@ -4102,6 +4123,12 @@ _require_scratch_shutdown()
>  	_scratch_unmount
>  }
>  
> +_require_scratch_shutdown_and_syncfs()
> +{
> +	_require_xfs_io_command syncfs
> +	_require_scratch_shutdown
> +}
> +
>  _check_s_dax()
>  {
>  	local target=$1
> diff --git a/tests/overlay/087 b/tests/overlay/087
> index a5afb0d5..2ad069db 100755
> --- a/tests/overlay/087
> +++ b/tests/overlay/087
> @@ -32,9 +32,8 @@ _begin_fstest auto quick mount shutdown
>  
>  
>  # Modify as appropriate.
> -_require_xfs_io_command syncfs
>  _require_scratch_nocheck
> -_require_scratch_shutdown
> +_require_scratch_shutdown_and_syncfs
>  
>  [ "$OVL_BASE_FSTYP" == "xfs" ] || \
>  	_notrun "base fs $OVL_BASE_FSTYP has unknown behavior with syncfs after shutdown"
> @@ -43,19 +42,13 @@ _require_scratch_shutdown
>  # bother checking the filesystem afterwards since we never wrote anything.
>  echo "=== syncfs after shutdown"
>  _scratch_mount
> -# This command is complicated a bit because in the case of overlayfs the
> -# syncfs fd needs to be opened before shutdown and it is different from the
> -# shutdown fd, so we cannot use the _scratch_shutdown() helper.
> -# Filter out xfs_io output of active fds.
> -$XFS_IO_PROG -x -c "open $(_scratch_shutdown_handle)" -c 'shutdown -f ' -c close -c syncfs $SCRATCH_MNT | \
> -	grep -vF '[00'
> +_scratch_shutdown_and_syncfs
>  
>  # Now repeat the same test with a volatile overlayfs mount and expect no error
>  _scratch_unmount
>  echo "=== syncfs after shutdown (volatile)"
>  _scratch_mount -o volatile
> -$XFS_IO_PROG -x -c "open $(_scratch_shutdown_handle)" -c 'shutdown -f ' -c close -c syncfs $SCRATCH_MNT | \
> -	grep -vF '[00'
> +_scratch_shutdown_and_syncfs
>  
>  # success, all done
>  status=0
> diff --git a/tests/xfs/546 b/tests/xfs/546
> index 316ffc50..c50d41a6 100755
> --- a/tests/xfs/546
> +++ b/tests/xfs/546
> @@ -27,14 +27,13 @@ _begin_fstest auto quick shutdown
>  
>  
>  # Modify as appropriate.
> -_require_xfs_io_command syncfs
>  _require_scratch_nocheck
> -_require_scratch_shutdown
> +_require_scratch_shutdown_and_syncfs
>  
>  # Reuse the fs formatted when we checked for the shutdown ioctl, and don't
>  # bother checking the filesystem afterwards since we never wrote anything.
>  _scratch_mount
> -$XFS_IO_PROG -x -c 'shutdown -f ' -c syncfs $SCRATCH_MNT
> +_scratch_shutdown_and_syncfs
>  
>  # success, all done
>  status=0
> -- 
> 2.34.1
> 

