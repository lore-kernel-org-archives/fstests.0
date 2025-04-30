Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CB220DD63
	for <fstests@vger.kernel.org>; Wed, 30 Apr 2025 08:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746002054; cv=none; b=rUgwHjInwge/QHKXF5sCz4MwHfq0cCYx7d1xm1S/xZIL8Svb3MJNEwKGtQcicJ03PsvhXCZ0D41BxWtGapA3/xtY4hYpFcoTAx2OvFcfHTwk175FVB/doJ5G5eAboq4Qiwq0lbxdXa2mwSgynU4lufOvXLiwRdn7xScUxBEQPA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746002054; c=relaxed/simple;
	bh=FNsCtHtCx/Sd7I2KUFjadOP3HRc+4lYX5B5/DFefry8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=ETw7dW6KTZ4ayajvTszXbY2jDUlvZK55o4Wzyk6pIPHOUBDF2Pdbvkqtl87nLJnlppFWLF6lZnhGIKnexlnDPTVvVmeXIOef1s7oVo4sl8N9A7d3zPd62DDCKwNY6QBP6JRrr4yeuTzNnaKdpD/6W7n/nilhAGBhdnKxIjVH6SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a3xcxaig; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3xcxaig"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22423adf751so70323085ad.2
        for <fstests@vger.kernel.org>; Wed, 30 Apr 2025 01:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746002052; x=1746606852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Amd9n6lJP4T5pKeTAdekvPx4V1lxhlZYDSpC6FVp02E=;
        b=a3xcxaigNSNCUm4EusrF2qtPPPNgvK3kvuoAPMxIklbT0dsqRpBM/CVCb7CnsyQX9O
         K2SSl9ipXoCtmlrSmyBaYDcN88dWJh3RKeNBr58ssdE4flZCXi7VAcsKOz3eQxtIdH+Z
         SqEJwLjTqNrYORhiDxx8HIMS6wcXYTFg87VrmZtvJUWXsdIxBKMGmFmN7WNJNHec/3GN
         Jy+l00TZ8iT6eGIgtXps0Uy/rbKyNEy6Tb7cKndBMuYopuNdg4gMCL1cxXmNS4MrpkKr
         61vtz9zpauMcmazkCePgwFJC7Pzkw2tJOZP7H5Om676Mhjf4nIMGfTGXGLrHJcxoJpMs
         wsUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746002052; x=1746606852;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Amd9n6lJP4T5pKeTAdekvPx4V1lxhlZYDSpC6FVp02E=;
        b=vej6Yk5DE8yNL4IKTWshUjKx+ieCfFItA6Cq1MV9YF0lXbvwMEfBKEBEDwGEdFMbYS
         qia019XTSzyXFpsxH219n4h0+B4CVf5DBvhZradtk75IOJNRz40M36PZf2hzuzXCpKpU
         IQhCpaIo84/bEcI3U1MjICDo68jKTH+pmbDSYepchZFtmAvd/9VxkOXCnK3zhH1Tbl1m
         b/D5tqa3i5xJd6rP1qKzg3vRfdZi1iWj5bVMcwLE4KJtZcygsZ/GxDLG8jHgi5rfzbuZ
         QB/8gzZaUAo/G+OXmEOchctKqy6zgcfgMnb+4bz6pajOfspI7TPZxRvP/nYJQOU9mqK9
         wUVA==
X-Forwarded-Encrypted: i=1; AJvYcCU1lVA78eWuWyLfO/vcxPx3m5eIGR6mRK0U7Q25A4lqzMFMnTZSiWiL1+IG2V8N9oooUatViYJl@vger.kernel.org
X-Gm-Message-State: AOJu0YwsLUoC+bdjpBzwtOXNLuacjUOS58JJmlwq6tpLWddZswNd1R3Q
	z8jYENlDLogwpbvyLqY0c/FeqRSLjmOjbRIh1KLOvz1Q5Uz7VwFf
X-Gm-Gg: ASbGncvqTopQSTQ2FZq3e7Ectd1gDzpBGSFIiOE5FQOsOLA8VrHRvxdaAfOfoaN/X+s
	mPn/4AUvSc4VBdr/gV3FepIHiFuHoVGxH1DFkIKesaqm67Ra4KYAdU0JNYz895eCO9NyTzg4Nje
	/xg0AddDe5VEJSoFPfPmSiZLWBgw67O6FV5hV6ctj7i1qzwfKeSl4zdZ40WWvzoSGPS3kXwPr89
	tDvk14gKNDXEMDzLQ7meaRBHInSyvu+S6BcxYAUAtnY7bluvp5fOrQ2tlDkXEglTYBNHDRhNJ8h
	xWEjj0STSdqye2L1BY6WsLjrlmQMtzEtAN/A0lSHds8MnffMoOBOrVTQJnSY7GChv6tvk9MKylm
	BifEbRSWuyfSV84ZUyw==
X-Google-Smtp-Source: AGHT+IHIuzi3eTb97QX89fgs3bX9kbpHpQUY0W0/vaoagzHIOz+iJ88E7Da19FMueMB6svYQYV/CbQ==
X-Received: by 2002:a17:903:2f43:b0:22d:c52e:2dae with SMTP id d9443c01a7336-22df34dd80bmr34711865ad.18.1746002051662;
        Wed, 30 Apr 2025 01:34:11 -0700 (PDT)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db50e7b45sm116263875ad.135.2025.04.30.01.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 01:34:11 -0700 (PDT)
Message-ID: <2cf4c78230559c62ca1be758ec9a069cbcbf8a9f.camel@gmail.com>
Subject: Re: [PATCH 26/28] stale-handle.c: use syncfs() rather than sync()
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
Cc: zlang@kernel.org
Date: Wed, 30 Apr 2025 14:04:08 +0530
In-Reply-To: <20250417031208.1852171-27-david@fromorbit.com>
References: <20250417031208.1852171-1-david@fromorbit.com>
	 <20250417031208.1852171-27-david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

On Thu, 2025-04-17 at 13:01 +1000, Dave Chinner wrote:
> xfs/238 runs stale_handle to create 1000 inodes, grab their file
> handles, unlink them and then try to open them from the stored file
> handles.  It takes a ridiculously long time to run under
> check-parallel because it runs sync() multiple times:
> 
> xfs/238        144s
> 
> When running check-parallel, sync() can take a -long- time to
> run as there can be dozens of filesystems that need to be synced,
> not to mention sync getting hung up behind all the mount and
> unmounts that are also being run.
> 
> Convert the sync() calls to syncfs() so that they only try to sync
> the filesystem under test and not the entire system. This avoids
> interactions and delays with other tests and mount/unmount
> operations, hence allowing both the test and the overall
> check-parallel operation to run faster:
Yes, filesystem wise sync is makes more sense. I remember similar
changes with your previous check-parralel patch series as well.
> 
> xfs/238        5s
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  src/stale_handle.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/src/stale_handle.c b/src/stale_handle.c
> index 2acd4968c..fd8b3ec61 100644
> --- a/src/stale_handle.c
> +++ b/src/stale_handle.c
> @@ -21,7 +21,7 @@
>  int main(int argc, char **argv)
>  {
>  	int	i;
> -	int	fd;
> +	int	fd, test_dir_fd;
>  	int	ret;
>  	int	failed = 0;
>  	char	fname[MAXPATHLEN];
Not related to this change: 
A lot of local variables are being used in this test:
char	fname[MAXPATHLEN];
void	*handle[NUMFILES];
size_t	hlen[NUMFILES];
char fshandle[256];
Is this fine? Shouldn't we limit the usage of so much local stack?

> @@ -44,6 +44,12 @@ int main(int argc, char **argv)
>  		return EXIT_FAILURE;
>  	}
>  
> +	test_dir_fd = open(test_dir, O_RDONLY|O_DIRECTORY);
> +	if (test_dir_fd < 0) {
> +		perror(test_dir);
> +		return EXIT_FAILURE;
> +	}
> +
Now that we are already opening the test_dir to get an fd of the
filessytem being tested, should we remove the stat call(line 42) just
before this open call and instead use this open call to check the
presence/absence of test_dir?

Other than this, the rest of the changes look good to me (some minor
comments below but not related to this change).

Feel free to add 
Reviewed-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>

 	ret = path_to_fshandle(test_dir, (void **)fshandle, &fshlen);
>  	if (ret < 0) {
>  		perror("path_to_fshandle");
> @@ -66,7 +72,7 @@ int main(int argc, char **argv)
>  	}
>  
>  	/* sync to get the new inodes to hit the disk */
> -	sync();
> +	syncfs(test_dir_fd);
>  
>  	/* create the handles */
>  	for (i=0; i < NUMFILES; i++) {
Not related to this change and minor:
Shouldn't we replace usage of sprintf with snprintf()s?
--NR
> @@ -89,10 +95,10 @@ int main(int argc, char **argv)
>  	}
>  
>  	/* sync to get log forced for unlink transactions to hit the
> disk */
> -	sync();
> +	syncfs(test_dir_fd);
>  
>  	/* sync once more FTW */
> -	sync();
> +	syncfs(test_dir_fd);
>  
>  	/*
>  	 * now drop the caches so that unlinked inodes are reclaimed
> and
> @@ -120,6 +126,7 @@ int main(int argc, char **argv)
>  		free_handle(handle[i], hlen[i]);
>  		failed++;
>  	}
> +	close(test_dir_fd);
>  	if (failed)
>  		return EXIT_FAILURE;
>  	return EXIT_SUCCESS;

