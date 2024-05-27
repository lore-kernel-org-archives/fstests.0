Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF102AE75
	for <fstests@vger.kernel.org>; Mon, 27 May 2024 17:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716831187; cv=none; b=hQ3LlPqRn9a4I6SCXk3GnwPUfhw8sO8qilHJ9+o53loawd6SqWTWdGcG8GWYSlMdhQaKMqwRNAv6NENs7iQeR4iIZ4NnPxFdgZPp8VmmaoQOa+WfhYsHpoToNoAqHdzPspOI9vy23nR/8FmF4jr6/zpSU30mrKDbFb+sDA5yTdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716831187; c=relaxed/simple;
	bh=yWuqM7Hcjs3/SzUzpDYw38VyE1GiAvp5TMwobI/bJSM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=RWUO1LtT/LREeqRfCT1WEuZTZJPCVSewJ+80IHRIsL60NxqxgM6A75UajZviYB7flukesyIFN1uyoZ1WFpLptdxAjrBNVq/mjkULoHmBA043oqWZ1tnaz8O9YIb4D0rqLGjDH0qQ9LZZE6Hj07R6NHN6CqVmTQYvEuW0r57xgs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k9Sx4mU9; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9Sx4mU9"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7007324a568so914420b3a.3
        for <fstests@vger.kernel.org>; Mon, 27 May 2024 10:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716831185; x=1717435985; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A2DKqx6QZ21CH7HmldvcoHuZN66fnGy47RUJxdOb3IM=;
        b=k9Sx4mU9iGD01vN7vMrhvetUXzadr2SF04jrOWDK8hw/IHV/KKFDpIdShOLYLu251l
         Y+FtR2jN5ay7fhYERc9Ylt+cNxzgJ5GVcBhPx723lVXbEUpR+02+Y3J1bv9DKcQ+r6Sv
         mFhL9ahJgmkzO91jHviMN04FWUU+4oTc2Rbi2tpa19hBNYEK6t0eOjkNMnhz2FKDzihQ
         N+CmhuZ/lB5x4EtPfclPFfbZqTphIn4A8PMcjShpIP+1AAkIvofghPDb4EiLNegcKxd3
         T7WRUZr9KtGs1C5Azg+3KNoLgfvf8d6XG1HEPY8hmtWpuVyuUFSzewlWNVx60dx91Q+a
         MenA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716831185; x=1717435985;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A2DKqx6QZ21CH7HmldvcoHuZN66fnGy47RUJxdOb3IM=;
        b=OvxoOjUbNvdyc+cSx4CrBV8RJwCIWOAjJdRpgLAnhrceqjCcqhjb3ZNtw/4SMW0ufp
         2o/GctXIi5YZMXnAlo3bTkeD33yol3ovhvOxwvIyAsNgWOBPIY0UDKUuH9HZGnF8Mdmh
         V3psZdTy2zzXsv2uJEpKDK1cuVx0RBstdXXtOeD+K2aljjGG/B1OXv6B/olVLNDMjRjv
         eorxvT1ncSqe2G4Nml79K/+YC8QnOmxyAOjxmLNr/X9WICHS7QB+WDss6z6j79nlxlSW
         aA2yAFt2ASPXjIZWnW9IlJ+tx5vilPjBlFBTKau+YLllUJDdBu/zQZXB7HBOAoLQeOo7
         WWaA==
X-Forwarded-Encrypted: i=1; AJvYcCU2EzkJ1p27lBk3QuNNUKZpnA4ixxM/xTSajItt4m/HD53o/E3UZSWJXNP2nQcFDk+D1K7SNV2S2OPnLTx9I6Kv+42bpR5Z0w==
X-Gm-Message-State: AOJu0Yxgjg+BMDQIoO0LQtRW+BibJoYjEi47gzg+wuyBYUOtUa55YDx0
	ywUKWB2T8a8RXUD3bg81IL70YcZrXhn4Hi5FuMdWZVk3YE3siCB/
X-Google-Smtp-Source: AGHT+IHVisAvyD/S7E8o3zZbftLAfLUAhaKKcL9f5qfEY4qaBEnzXsb/y+tiw+IEDphbGqvgyrKcyw==
X-Received: by 2002:a05:6a20:1056:b0:1af:a4d0:161d with SMTP id adf61e73a8af0-1b212cc84fbmr9513493637.13.1716831184776;
        Mon, 27 May 2024 10:33:04 -0700 (PDT)
Received: from dw-tp ([171.76.80.73])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fc05a363sm5143201b3a.64.2024.05.27.10.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 10:33:04 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, fstests@vger.kernel.org
Cc: djwong@kernel.org, mcgrof@kernel.org, gost.dev@samsung.com, zlang@redhat.com, kernel@pankajraghav.com, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v3 3/3] xfs/008: use block size instead of the pagesize
In-Reply-To: <20240527114834.167521-4-kernel@pankajraghav.com>
Date: Mon, 27 May 2024 22:33:16 +0530
Message-ID: <87le3v5grv.fsf@gmail.com>
References: <20240527114834.167521-1-kernel@pankajraghav.com> <20240527114834.167521-4-kernel@pankajraghav.com>
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

Thanks for addressing the comments. I agree it should be just blocksize
itself. Even the randholes.c only takes -b blocksize.
(Minor nit below)

Looks good to me. Please feel free to add - 

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  tests/xfs/008     | 20 +++++++++-----------
>  tests/xfs/008.out |  8 ++++----
>  2 files changed, 13 insertions(+), 15 deletions(-)
>
> diff --git a/tests/xfs/008 b/tests/xfs/008
> index e7d6153b..f42b3ac8 100755
> --- a/tests/xfs/008
> +++ b/tests/xfs/008
> @@ -10,8 +10,7 @@
>  _begin_fstest rw ioctl auto quick
>  
>  status=0	# success is the default!
> -pgsize=`$here/src/feature -s`
> -
> +blksize=$(_get_file_block_size "$TEST_DIR")

nit: maybe we should move blksize calculation to after _require_test ??

>  # Override the default cleanup function.
>  _cleanup()
>  {
> @@ -21,7 +20,7 @@ _cleanup()
>  
>  _filter()
>  {
> -    sed -e "s/-b $pgsize/-b PGSIZE/g" \
> +    sed -e "s/-b $blksize/-b BLKSIZE/g" \
>  	-e "s/-l .* -c/-l FSIZE -c/g"
>  }
>  
> @@ -73,18 +72,17 @@ _require_test
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
> -# note: direct IO requires page aligned IO
> +_do_test 4 50 "-d -l `expr 200 \* $blksize` -c 50 -b $blksize"
> +_do_test 5 100 "-d -l `expr 400 \* $blksize` -c 100 -b $blksize"
>  
>  # todo: realtime.
>  
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
