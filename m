Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B1C1370
	for <fstests@vger.kernel.org>; Thu, 23 May 2024 04:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716438693; cv=none; b=F8w8i5bNAQXG3B9ckvaR0VwNVKqOlU7CkgDZWCkseWVgLCjXOPwRjbct0M+TIKB5q56sGpHQfeAk1UNXY1bIV+NzI6Ss75ZKrjF+/79Z5K2gRrJdIyK374KIRnM7YITWEIgw9hZ5RLkeMCWeoUESnUVad1F0wVvqm809hZp5m9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716438693; c=relaxed/simple;
	bh=/e2WuitijyhY3uNh5WYuR66hAdcYwa3EJfiakyKK574=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=nzgFFIiRUldoLReWMZiK0AEHU5oMCnLJxKiAXiVT7tz7SnwtFi1gTQGt61vHMg+kBn2S3NVrPuo5hiWCVtgoqfSl8ydYNHzWFX0e1b9mnEW2XXS4JUhuHLihAoJgceN1tAq6x1C5nxkYNBt2nXCNgy/McVC6P9BkDGbPFoIlK7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EhJW/jKm; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhJW/jKm"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-23f0d7d2ce6so3879038fac.2
        for <fstests@vger.kernel.org>; Wed, 22 May 2024 21:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716438690; x=1717043490; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PvFiIGsww+fro+gR9eKRjfzkCuXMhXbFpsEkPb8fPX4=;
        b=EhJW/jKmeSx2wC/NglwuYxH7ouuxwCgixmuoWjuG2ir+e4AsamEsnDhoKJiHYz0g3U
         KIXMCO3ASuV2faLGoYRYON9tsWwbq+GnwBR/RFyfqZK92G8C19F/pSUqNHzgeVWl7KiJ
         SKlcj0NJla72vYupZznLDucwRAK4YH6SkbEoLsdrOmGLtGfAtlrrgrl4o+ntq/imGIjn
         fS0Feqn0FndkHFzPZRpz/9hwvL27G+sIDDbCW4sQNpiXn2cGKYYvpzXMtJNoFHJnHavD
         D+IdPl4aW5yHGWgcmCajKGpEJ1KVB8BzNPwDqY9a5RoDlwOVmIoCU8Ke/WXkWVNffDKM
         Takw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716438690; x=1717043490;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PvFiIGsww+fro+gR9eKRjfzkCuXMhXbFpsEkPb8fPX4=;
        b=iLd9M+QTUeAh747/q3P9rILr85BdA4r1dRSXsMDj7W8brjtX+Hg6YCjlNDokiGlwe0
         SSWn1fV6PnUKivcUSlEMoMiG0h+q8kUjznVEH2oaYtVnl3esZ/9mCpH7XBDNN93I0fAW
         mROPNfK4hkizLYn1HXTaWxA0Bv9jbY+cRkWqjbBVb7sae8UYGSZCqN1e+WjCgfaW0Fxu
         eRRg8Uudv34cfUfCwvuEinxgfE/bv3CntZc6oyL9y2xx/zuKUEfjozulpADymebf0Q3k
         P57T2u5fivTh6P+IcSSY2v5sQ6syytpv+kmF/beUG3c4KHSrq1Yiwep0QssUKwq/ovVm
         xRyw==
X-Forwarded-Encrypted: i=1; AJvYcCUXFSyeflwynhfIMmGNzq5pCB8vOoKvp5McXKG7piMPEARAmdL2XnWbuZDXhDAF+RdqTJgUDwbrthmP5CwtVYfsFT4FH4Pk5g==
X-Gm-Message-State: AOJu0Yxl5wVPlYCW+hulLeKy1/sfhh/VRNcpEuISD8cjT3ci8MSFqXmZ
	iW88KRySxjeA9LS4B6sFSsgkeGahPl/e8VMzePUrzwOo9WAMXW8ojI5a3A==
X-Google-Smtp-Source: AGHT+IGjlpoMlpBSncP5L0Ur/WVcLLXhtVUUwSSxVWLVM+o2zFFKmcPFBG3r0rC1i0MRaigxzP2iZg==
X-Received: by 2002:a05:6870:5d8f:b0:24c:647a:719 with SMTP id 586e51a60fabf-24c68e3f40dmr4513745fac.50.1716438690363;
        Wed, 22 May 2024 21:31:30 -0700 (PDT)
Received: from dw-tp ([171.76.81.79])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a828c9sm23184987b3a.53.2024.05.22.21.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 21:31:29 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, fstests@vger.kernel.org
Cc: kernel@pankajraghav.com, gost.dev@samsung.com, mcgrof@kernel.org, djwong@kernel.org, zlang@redhat.com, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v2 3/3] xfs/008: use block size instead of the pagesize
In-Reply-To: <20240513131254.92412-4-kernel@pankajraghav.com>
Date: Thu, 23 May 2024 09:55:25 +0530
Message-ID: <87v835rw7e.fsf@gmail.com>
References: <20240513131254.92412-1-kernel@pankajraghav.com> <20240513131254.92412-4-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>

"Pankaj Raghav (Samsung)" <kernel@pankajraghav.com> writes:

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
> Reviewed-by: Zorro Lang <zlang@redhat.com>
> ---
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

I assume when the test might be written it might have assumed blocksize =
pagesize. Hence the dependency on pagesize in this test. 
If that assumption is correct, then we might not need these two paths
and can just make it blocksize.

Do you see any problem with blocksize for any of the paths
(bs = ps, bs < ps and bs > ps)?


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

^^^ This last comment about direct-io alignment is not valid anymore since kernel
2.6. Maybe it's time to rip that comment off.

From man 2 open
O_DIRECT
<...>
       If  none  of  the  above is available, then direct I/O support and alignment restrictions can only be assumed from known characteristics of the filesystem, the individual file, the underlying storage device(s), and the kernel
       version.  In Linux 2.4, most filesystems based on block devices require that the file offset and the length and memory address of all I/O segments be multiples of the filesystem block size (typically 4096  bytes).   In  Linux
       2.6.0, this was relaxed to the logical block size of the block device (typically 512 bytes).  A block device's logical block size can be determined using the ioctl(2) BLKSSZGET operation or from the shell using the command:

-ritesh

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
