Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F7A2E2299
	for <fstests@vger.kernel.org>; Fri, 24 Oct 2025 07:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761291117; cv=none; b=Jm5ZtbR1kWDUyL5eQx/tSR4m+fh754uCB4bEfrbJf7Aam170taD7Tfcx3z823ZZlV1erlvjGl0hfQN+mGZKL8EDzD92e49DvrCwcaANB6WVohNMDCRKeqlFor4H7H4U1xjhZagKm6XpZ/1C6u381s7g1ZHwy+yxGjvplyszgQ5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761291117; c=relaxed/simple;
	bh=hGGXbnlJbNirMVKZsmuNJSZHVRJA0rz2SBB/4/CB6WQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=HqimIP/dVL7d1DKvFLyODciPt1Us0nFiVFkwqcsAzO0WK/YYDhJZ0PVhe/KUNRPrQLzZPQw1YHp/ifuKXiBc2jWOjNbBGmXXpkD8/+RdWA9JYe5K8URoHtVNHJZeEOfVyFkKOYY7Z4mtbIr8XSHEq9+XnkK1nU9L8iW0rBF1slA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W4pBvXHg; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4pBvXHg"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-781ea2cee3fso1719111b3a.0
        for <fstests@vger.kernel.org>; Fri, 24 Oct 2025 00:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761291116; x=1761895916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1A7P5IMbPn+t40gCyqItOLfp70nnc5B3DPRJaxQKRqg=;
        b=W4pBvXHgcPqidzw48Ycy9P/eA+hD8L2VOrpdwfuCIm7zlvrRKabKcjHYQEs+dMzdSu
         P81HuReZ8am02yCKw4Hx+JovB4tKrzjtKRdfbNWocPbGKcdrmTmh2t5bCbUeelNO9Om0
         pEJ2GZTHQEWRKeWDGkrirsEm+b0lqhsBaNjtUD3ujVFQxhBj49DEsB8RdYKLRf9J7scF
         TDk1XnxS0nJjTmTy62zSd3MEkf3/VWw2Rmd6FZNQZzs9Z9qrgtqV20wO0FQ/rSj6bdlX
         R+EnvRe5n5ImiupTUm/xudYbMwoqLrLA08zmzqiK6mt5u27SP+XLU0qBUzBfK/6jS2q+
         FRqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761291116; x=1761895916;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1A7P5IMbPn+t40gCyqItOLfp70nnc5B3DPRJaxQKRqg=;
        b=tsO1rkLjfDYLqF8vQ/wqQu067BWCVY1bi6fl1iX8K+ZYef3HqgjgAWHxI0+4m+t3So
         m8tbTFj/kAdOlf/0c5V+jSOKskbJMgKLSHOmSdV5hat7rUpVxzbfA2MisXVSitDtIVQr
         ewJ/hqJeUk/Ya1Fo+k12gVceJlmvb4uTipwe218OJmR2nMKytJaRXyPhHMpWQD+TqT5b
         exXT5sDu3U1ieAPdOM+MO9+4BXhrK3rx1V4FonEpQCVJiQBwTZAf6Sa0pt6rrzTUTLdy
         zUGy9icrXFEFSAvBvh7LR24ay+UnVfNsJx2JaD9J3/ckLkv/hiH1i9q5YH2xEdBoWUnS
         8Y3A==
X-Gm-Message-State: AOJu0YywROO5jSWgR5acBFrsT9C6uq59msVK0buLEWpLjijB6Z9KO8q2
	g1+rnqhGVeWGlEw/RuDrjJtLQj5SkCqQsYGnKp2MaWKBHDZmhhnGTYQg
X-Gm-Gg: ASbGncttNXoOakck0Mmjn8GC2BhaP0mka292yrJK6q+ypBCHHR0mkCXUyfdm2dUyvtU
	ZsKFkXAASWwVVaD7q6vo7aYM6gQoF30AKhEbZKwmKvCCmjEiU/Nz16rMpMpIWLULk4DgO4Wxr5z
	F4nMa6X1Qby0Ae8FVFnxd9r2gLlSuVNZl1whS7BhqEWMMZ8a7/jzxEYM7cYGo5G8HUq0LT8T1F/
	GANKRN52YxsrKWxxenM9xdZt58nKlp1Ldr8MYFMV/hwopNsJEYa/l2uAdAPltz07DFDX+/r8M8T
	CC4GgPdFf7qxmVI/t1S55N73wIDDPnMTCGM/WFATrnSCKF7nl5BPTLJXYuUv1nBFb0/xs+yANFJ
	0t3RMzfNfv3H6La3RJD2ZLzVvlI8Z1xUFRoxPxcb43f8oCLpZemy6PEB9CwTSDEtRmCfJ0X6xI3
	49chcifQhhvP1ThlmMQkQoWiY5aWpBd3yiEKzNH8z/uWjwdM8dRVPl
X-Google-Smtp-Source: AGHT+IG/J5FlS1bROellmIONy1OUUsTDN1yuoEJ8FKRhOP/Hr0N9ZSHlvALYSp9AXRyRCWHg0DFhMQ==
X-Received: by 2002:a05:6a21:3397:b0:2e4:9004:52fb with SMTP id adf61e73a8af0-33de8fa0809mr1819180637.4.1761291115702;
        Fri, 24 Oct 2025 00:31:55 -0700 (PDT)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com ([49.207.202.82])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf4e2d787sm4233408a12.29.2025.10.24.00.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 00:31:55 -0700 (PDT)
Message-ID: <ee99fc234ccfc433662975d45f24c8900428e2ea.camel@gmail.com>
Subject: Re: [PATCH 2/8] common/rc: fix _require_xfs_io_shutdown
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: "Darrick J. Wong" <djwong@kernel.org>, zlang@redhat.com
Cc: fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Date: Fri, 24 Oct 2025 13:01:50 +0530
In-Reply-To: <176054617932.2391029.3304833304093152893.stgit@frogsfrogsfrogs>
References: 
	<176054617853.2391029.10911105763476647916.stgit@frogsfrogsfrogs>
	 <176054617932.2391029.3304833304093152893.stgit@frogsfrogsfrogs>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

On Wed, 2025-10-15 at 09:37 -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Capturing the output of _scratch_shutdown_handle requires one to enclose
> the callsite with $(), otherwise you're comparing the literal string
> "_scratch_shutdown_handle" to $SCRATCH_MNT, which always fails.
> 
> Also fix _require_xfs_io_command to handle testing the shutdown command
> correctly.
> 
> Cc: <fstests@vger.kernel.org> # v2025.06.22
> Fixes: 4b1cf3df009b22 ("fstests: add helper _require_xfs_io_shutdown")
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  common/rc |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> 
> diff --git a/common/rc b/common/rc
> index 1ec84263c917c0..1b78cd0c358bb9 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -619,7 +619,7 @@ _scratch_shutdown_and_syncfs()
>  # requirement down to _require_scratch_shutdown.
>  _require_xfs_io_shutdown()
>  {
> -	if [ _scratch_shutdown_handle != $SCRATCH_MNT ]; then
> +	if [ $(_scratch_shutdown_handle) != $SCRATCH_MNT ]; then
Yeah, right. _scratch_shutdown_handle is a function call and should be placed in a $() or ``. 
>  		# Most likely overlayfs
>  		_notrun "xfs_io -c shutdown not supported on $FSTYP"
>  	fi
> @@ -3073,6 +3073,11 @@ _require_xfs_io_command()
>  		rm -f $testfile.1
>  		param_checked="$param"
>  		;;
> +	"shutdown")
> +		testio=$($XFS_IO_PROG -f -x -c "$command $param" $testfile 2>&1)
> +		param_checked="$param"
> +		_test_cycle_mount
> +		;;
Looks good to me. Just curious, any reason why we are testing with TEST_DIR and not with
SCRATCH_MNT? 
Reviewed-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
>  	"utimes" )
>  		testio=`$XFS_IO_PROG -f -c "utimes 0 0 0 0" $testfile 2>&1`
>  		;;
> 

