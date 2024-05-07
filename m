Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DC916C870
	for <fstests@vger.kernel.org>; Tue,  7 May 2024 18:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715105421; cv=none; b=aCwrHMfliCMrlbXXTr+INwXA2GvBGMpiW1xlpVtAFSURnWhtiwi8iz3tOCTkXSmtK0rvvrYZCduQod9ajF2IlYlrmZx30YTQZdO2/oJ/9piKXXUeqCfP81kGrgFpkKoT3m8FPU2zjN5ykMCmhFx/J6yta+ARhx3bEIkM+E42HHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715105421; c=relaxed/simple;
	bh=3OQ/TScbH6oBn/UigGEy06iQiF4YgddFY1fnVRVdAR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+jtI370L1jrUz6ZhKIc4oHpE/vjry/3Dgf2d/u0g7p0XNx2mXtUEeHconQnLhqe7gF1kzZq0a9tOQyZlh1BO6PnGi2DonQbou7/OrfGPYJOyzQzWRiwqOOA0esFHEVPuVGIHWbkGTUsgetQ1pocdwAh5YgAic2tRaXNmEzpCYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NNmkJArl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NNmkJArl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715105418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u6F025a9ow/HuJgUM7vW3/RmXKNwnaCf9AJQNwpJyuM=;
	b=NNmkJArl5uhhh0Ljh7tbiJ3S/R66UIC6o0kwCau7vzcY/kxI7wRr58WqMxn/G7nYL5qvGe
	wZicNny3sfbqY+yYTejMjokB8j80SD4UZouKmGzWTSB4szjEP2KrnR+BuwcWQ3YsCoGz5y
	xvTrHhOm0e3E6+rSkcH1pXhwdcNndHY=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-F07bMiC1MuWdMZIXvnbV1g-1; Tue, 07 May 2024 14:10:13 -0400
X-MC-Unique: F07bMiC1MuWdMZIXvnbV1g-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6f454878580so2983861b3a.3
        for <fstests@vger.kernel.org>; Tue, 07 May 2024 11:10:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715105412; x=1715710212;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u6F025a9ow/HuJgUM7vW3/RmXKNwnaCf9AJQNwpJyuM=;
        b=GrB50Hc7g+cdD/3yHbFdHzs/SAket4D9C0+1/yhaWL5wyNzQryPpRGU0SpOtJ43MWW
         GllyaW2xvyssHrXudUxDMpMOuXKVA3P2d3stHDd9gQ5P4NhYhvJpY8Z52Avi9VFdgdZf
         oqnfOHDCbpmpnHX40VlSS1ttN61lAuldiRW40kpCUULdygddq6cgEATLGXRuImIeo5tf
         AP6/x0SPUrYAF/3uGKC2zreHikxvbNXky2YPiYZuyej2Ym0gRSp+auEZM8afFrAJjx6h
         tbSqYrCumb7/dGUk50sEskXaaFts3XztdUffW+IIl01yMIwPJBD5GFc3nw0vF7ZIo3BN
         B5gQ==
X-Gm-Message-State: AOJu0Yw9/r2Jma0GKF5PBC+6pYwwZXLzhQBpXX2Neda5gWAAGJQJgfjE
	/70TORtZ4lxJguFOXRdi1jWVwAGwtRMLGZL1L2U5XoZtqZ/hX2BpgyJd6b9vgChJJNKCzp5KrLN
	2MXPpPVsE8jcE1VPx044N+upIaYEvXtUzPlq2fFCrSyuJdrT3E82UEhk=
X-Received: by 2002:a62:aa1a:0:b0:6ec:e785:98b9 with SMTP id d2e1a72fcca58-6f49c2a2b29mr446406b3a.27.1715105412327;
        Tue, 07 May 2024 11:10:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESJFN4MHTca1chlAH0Vgf9pvD2GaAGkUuRXEkVr12DLi3QKuUVIfbKF99JtFoHztsjFI/wAQ==
X-Received: by 2002:a62:aa1a:0:b0:6ec:e785:98b9 with SMTP id d2e1a72fcca58-6f49c2a2b29mr446370b3a.27.1715105411744;
        Tue, 07 May 2024 11:10:11 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ei46-20020a056a0080ee00b006f446816ae0sm9002789pfb.147.2024.05.07.11.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 11:10:11 -0700 (PDT)
Date: Wed, 8 May 2024 02:10:06 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: fstests@vger.kernel.org, djwong@kernel.org, gost.dev@samsung.com,
	mcgrof@kernel.org, ritesh.list@gmail.com,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 3/3] xfs/008: use block size instead of the pagesize
Message-ID: <20240507181006.ohncfaneb6uili3x@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240506150119.184097-1-kernel@pankajraghav.com>
 <20240506150119.184097-4-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506150119.184097-4-kernel@pankajraghav.com>

On Mon, May 06, 2024 at 05:01:19PM +0200, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> The testcase estimates to have ratio of 1:3/4 for holes:filesize. This
> holds true where the blocksize is always less than or equal to pagesize
> and the total size of the file is calculated based on the pagesize.
> There is an implicit assumption that blocksize will always be less than
> the pagesize.
> 
> LBS support will enable bs > ps where a minimum IO size is one block,
> which can be greater than a page. Adjust the size calculation to be
> based on the blocksize and not the pagesize.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---

Looks good to me, thanks!

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/xfs/008     | 19 ++++++++++---------
>  tests/xfs/008.out |  8 ++++----
>  2 files changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/tests/xfs/008 b/tests/xfs/008
> index e7d6153b..e37e435a 100755
> --- a/tests/xfs/008
> +++ b/tests/xfs/008
> @@ -11,7 +11,8 @@ _begin_fstest rw ioctl auto quick
>  
>  status=0	# success is the default!
>  pgsize=`$here/src/feature -s`
> -
> +fileblksize=$(_get_file_block_size "$TEST_DIR")
> +blksize=$((fileblksize > pgsize ? fileblksize : pgsize))
>  # Override the default cleanup function.
>  _cleanup()
>  {
> @@ -21,7 +22,7 @@ _cleanup()
>  
>  _filter()
>  {
> -    sed -e "s/-b $pgsize/-b PGSIZE/g" \
> +    sed -e "s/-b $blksize/-b BLKSIZE/g" \
>  	-e "s/-l .* -c/-l FSIZE -c/g"
>  }
>  
> @@ -73,17 +74,17 @@ _require_test
>  # We are trying to create roughly 50 or 100 holes in a file
>  # using random writes. Assuming a good distribution of 50 writes
>  # in a file, the file only needs to be 3-4x the size of the write
> -# size muliplied by the number of writes. Hence we use 200 * pgsize
> -# for files we want 50 holes in and 400 * pgsize for files we want
> +# size muliplied by the number of writes. Hence we use 200 * blksize
> +# for files we want 50 holes in and 400 * blksize for files we want
>  # 100 holes in. This keeps the runtime down as low as possible.
>  #
> -_do_test 1 50 "-l `expr 200 \* $pgsize` -c 50 -b $pgsize"
> -_do_test 2 100 "-l `expr 400 \* $pgsize` -c 100 -b $pgsize"
> -_do_test 3 100 "-l `expr 400 \* $pgsize` -c 100 -b 512"   # test partial pages
> +_do_test 1 50 "-l `expr 200 \* $blksize` -c 50 -b $blksize"
> +_do_test 2 100 "-l `expr 400 \* $blksize` -c 100 -b $blksize"
> +_do_test 3 100 "-l `expr 400 \* $blksize` -c 100 -b 512"   # test partial blocks
>  
>  # rinse, lather, repeat for direct IO
> -_do_test 4 50 "-d -l `expr 200 \* $pgsize` -c 50 -b $pgsize"
> -_do_test 5 100 "-d -l `expr 400 \* $pgsize` -c 100 -b $pgsize"
> +_do_test 4 50 "-d -l `expr 200 \* $blksize` -c 50 -b $blksize"
> +_do_test 5 100 "-d -l `expr 400 \* $blksize` -c 100 -b $blksize"
>  # note: direct IO requires page aligned IO
>  
>  # todo: realtime.
> diff --git a/tests/xfs/008.out b/tests/xfs/008.out
> index 5e3ae8e3..0941e218 100644
> --- a/tests/xfs/008.out
> +++ b/tests/xfs/008.out
> @@ -1,10 +1,10 @@
>  QA output created by 008
>  
> -randholes.1 : -l FSIZE -c 50 -b PGSIZE
> +randholes.1 : -l FSIZE -c 50 -b BLKSIZE
>  ------------------------------------------
>  holes is in range
>  
> -randholes.2 : -l FSIZE -c 100 -b PGSIZE
> +randholes.2 : -l FSIZE -c 100 -b BLKSIZE
>  ------------------------------------------
>  holes is in range
>  
> @@ -12,10 +12,10 @@ randholes.3 : -l FSIZE -c 100 -b 512
>  ------------------------------------------
>  holes is in range
>  
> -randholes.4 : -d -l FSIZE -c 50 -b PGSIZE
> +randholes.4 : -d -l FSIZE -c 50 -b BLKSIZE
>  ------------------------------------------
>  holes is in range
>  
> -randholes.5 : -d -l FSIZE -c 100 -b PGSIZE
> +randholes.5 : -d -l FSIZE -c 100 -b BLKSIZE
>  ------------------------------------------
>  holes is in range
> -- 
> 2.34.1
> 

