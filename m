Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60D2200C3
	for <fstests@vger.kernel.org>; Fri, 24 May 2024 15:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716563223; cv=none; b=AofFWPXikaUNAnhONgZFKyRuNohC7fCi/LRlaIl54Yep+kBrk+pa1JT0XTxyk0tswf/4fae8atGfImfhOWB42n7t7SdY481JP7m2Qj2fKFK1JM6TC4P0HL10Sdyf0feHPxEsrhaanDJYYyKsvxI+m8bI5IaXxtojv7NgUXxczf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716563223; c=relaxed/simple;
	bh=pLoOu9rh7C0J4zwpXjshA36p9Pn+TZNTv3nqLvlkNw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qPWwEo3H1Bc/smR84RwIwKyGuSBfGcQ2uCvb94SlRW4vauPLp/y8XxHEp8l1MpHThL4KHzrJZuFE8uMVUQPxd+PTYYoWcnpzZUB2cRUrd2K2jScyRrizPFmr5kA/ocI/zkoFL8fla9Oa/mb47Y6C5jVQ+0NcBaDxd2DDKMU1Cdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1cjEumH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1cjEumH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FCF8C2BD11;
	Fri, 24 May 2024 15:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716563223;
	bh=pLoOu9rh7C0J4zwpXjshA36p9Pn+TZNTv3nqLvlkNw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M1cjEumHXCK8REmFYFkt/HbKTHMRezOPCuJSFOyuf6jFKZt5gvjutUC67CxYndmU5
	 7v87qFLgAE3iuKHvBneEyWPPODuHehPSfo810ZRNwSuUEBIjwfbKgltCjqwQJbOwSw
	 ti19ZhjJpzO55ZvHn0ptdwD57R3UXyYCTvPJgBTzljoZVF3X82ihQlhP5oW4ZGebHa
	 jeFL4xAmUEz99Z0Zkve5Eg4OYmPhlJGUuEX7Z4rkEuCVCFrtYzIQMRUYKxXO7WQTOs
	 n5f5f4a+Sht6eY/nVpIa7mj7gisUdrzlq3dMi33qRvQmFVzOhsSHK2/5ylxrREuD/o
	 oW4EDAm7SoWvQ==
Date: Fri, 24 May 2024 08:07:02 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Chandan Babu R <chandanbabu@kernel.org>
Cc: fstests@vger.kernel.org, zlang@kernel.org
Subject: Re: [PATCH] _test_mkfs: Include external log device (if any) when
 creating fs on TEST_DEV
Message-ID: <20240524150702.GA52977@frogsfrogsfrogs>
References: <20240524073104.615253-1-chandanbabu@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524073104.615253-1-chandanbabu@kernel.org>

On Fri, May 24, 2024 at 01:01:01PM +0530, Chandan Babu R wrote:
> Test execution fails when testing XFS with external log device and when
> RECREATE_TEST_DEV is set to true. This is because _test_mkfs() is invoked as
> part of recreating the filesystem on test device and this function does not
> include the external log device as part of the mkfs.xfs command line.
> 
> _test_mount() invoked later fails since it passes an external log device to
> the mount syscall which the kernel does not expect to find.
> 
> To fix this bug, this commit modifies _test_mkfs() to invoke _test_options()
> in order to compute the value of TEST_OPTIONS and includes the resulting value
> in the mkfs.xfs command line.
> 
> Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>

Doh
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  common/rc | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index 0fe56382..6562ccd7 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -614,7 +614,8 @@ _test_mkfs()
>  	$MKFS_PROG -t $FSTYP -- -F $MKFS_OPTIONS $* $TEST_DEV
>  	;;
>      xfs)
> -	$MKFS_PROG -t $FSTYP -- -f $MKFS_OPTIONS $* $TEST_DEV
> +	_test_options mkfs
> +	$MKFS_PROG -t $FSTYP -- -f $TEST_OPTIONS $MKFS_OPTIONS $* $TEST_DEV
>  	;;
>      bcachefs)
>  	$MKFS_BCACHEFS_PROG $MKFS_OPTIONS $* $TEST_DEV > /dev/null
> -- 
> 2.43.0
> 
> 
