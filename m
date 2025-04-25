Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7284B24DFF4
	for <fstests@vger.kernel.org>; Fri, 25 Apr 2025 14:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745590405; cv=none; b=AuI1kQWPpNzbZu/p3FcPTDe8ZPmapuHq0m3mT+KX0pij96SsDer+zFIT7Vux40fKmzwGT4blqrx88Xn1xodtbXR6cyPL7WW9FvmZ3j59ZfVoSis/eb/v9VQda9+S9mq8K/snZKYy8QR5O/NIqjNSQPzxJUGN4GGqL23/0WjoF/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745590405; c=relaxed/simple;
	bh=ofqAgE9W5miGhP1Rom91NkxCtUrwZ0yImFbNd5Bu+7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=caDgFxnpp4+gNUnxNGAchLhm48CMhM9jSB4lKPWwLqidAgY11Ach5Wvt1nVJV0MThyV4kcVLB9zfUyQGH9fIo7r2ZehhsjkT07Sc50tFlIL1Kru2uydQzUjDnNjLuAk/6eHfhX5how0OzRsuv3rLp75/Z3CF+1BQOoqBdvjdtRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W9DX1zeB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W9DX1zeB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745590402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+56DXeTRhlNEKH15kYjYN9CkoAbVGHVIzlTJdE9juGM=;
	b=W9DX1zeBH3YrlXvZkxrhZ0c+I6VSF/DVHDkSYBRJS9O0zH8m87pRAdi6/Wqzu/qqmZR48G
	3bzsoYQJZhy3KEXaPyr5RiQL0g0RRORpPGO0prXkFKlcLLDJ7Umovt+j3mvCRRtau6zk6x
	JGMnu2Lv3b+AW8JFcDXrzovAlFT9U+E=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-xdvcmpXoMUezen5GBkOAlQ-1; Fri, 25 Apr 2025 10:13:18 -0400
X-MC-Unique: xdvcmpXoMUezen5GBkOAlQ-1
X-Mimecast-MFC-AGG-ID: xdvcmpXoMUezen5GBkOAlQ_1745590397
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b0e5f28841dso1356305a12.2
        for <fstests@vger.kernel.org>; Fri, 25 Apr 2025 07:13:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745590397; x=1746195197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+56DXeTRhlNEKH15kYjYN9CkoAbVGHVIzlTJdE9juGM=;
        b=m/wvHrmLf2oh37s6uyhDj7J2Vhi0sFy+E+q+eB431aVDEglH+O/+FxLoAzH0KElX+O
         1t1fmtzR7PWxyVOCn6TK/3ulvJmEAO+gbqzXkavtf64NgKZoaXXEP3D9pvQcToBJ5w1M
         NkEB4lIhFx/mDKUfNhXhYjGHjrgT4SqYakoE0cW5aJ0WT28jj4hKJ/cEtLbv1RYLH6kQ
         uD0x9823dZGhTZrK5UgEXgXBLfjHqNpvh0f9PR+tIjVYFJDx1JHSSdjg+fUsaqi7LhDY
         W/Ma9+ZO6Q31yaNUPVSqoTvzHPbcgd7P/7bsL5kX7g+D/UrcIxHci2orudKx461AN/Ln
         pkNA==
X-Forwarded-Encrypted: i=1; AJvYcCWhQFs3jy4KGNz5X1x9O5fL2KVjo998BOD1XmL7vG3FPS1jl6wgONyH1kzF/x5xlQwiTxiTjTPE@vger.kernel.org
X-Gm-Message-State: AOJu0YzHqek2eYJ0eZi6JBR/FpjkUtbUFZggOzhq2/DhzLdAg3fw9rxk
	xJIH34S0+PA3bw1cIaETJi2h+Ttw7g66343F1KO5AI3uOm01jarCSGX0SOCK/KDVOwBUDNSuv9j
	aHO1TyqCCWxULVDIkK8/5uCQyu7oS54oL8ZORhw7HYxDvP+eGb9dTCQc=
X-Gm-Gg: ASbGncuhu57n+IXh7QnMkjWbf6XxLDIQoMXRw4hVLlZDb7flnBnVEPqOE74Q7D5pG5R
	VDeRmO03daC0U907r5jZD/EV0z4Unxbg9h1aROVt2UGzpC6rEfLQCg4H/gEiUj+PxfK4tzUzWt4
	YtTUlWn9ofvCyZ/7zkJ2T6QmEz/pe7o3HFV2lf8RnPpHranogu6H0Z/jmwZBTVUSKf5aCB1CrDM
	BlJNxj5H+FKvW6opNBak0Zd5S9PZ4QiBhO5hIlF630qMrWFMacdkJPlDWWZp6RoSFvIK1hcdUqq
	ikR8mtxcnrdT/VemLybC/6m7Tq+1eFPgUup90hj4et7cY0iHLC+2
X-Received: by 2002:a05:6a20:e18a:b0:1f5:8605:9530 with SMTP id adf61e73a8af0-2045b99adb4mr3830318637.28.1745590396908;
        Fri, 25 Apr 2025 07:13:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgvgTGq3g0gY77ie1PKeHiig1FtrvzCFz6cgKQ+lBDFCUMDkGrIrMmrFN45D5f6+SS26z8iQ==
X-Received: by 2002:a05:6a20:e18a:b0:1f5:8605:9530 with SMTP id adf61e73a8af0-2045b99adb4mr3830283637.28.1745590396565;
        Fri, 25 Apr 2025 07:13:16 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25a6a66dsm3269847b3a.102.2025.04.25.07.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 07:13:16 -0700 (PDT)
Date: Fri, 25 Apr 2025 22:13:11 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v2] f2fs/011: test to check out-of-space issue
Message-ID: <20250425141311.kgwsazvt6r65yfod@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250327055051.3827735-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250327055051.3827735-1-chao@kernel.org>

On Thu, Mar 27, 2025 at 01:50:51PM +0800, Chao Yu wrote:
> This is a regression testcase to check whether we will handle
> out-of-space case correctly during fallocate() on pinned file
> once we disable checkpoint.
> 
> Testcase:
> 1. mount f2fs w/ checkpoint=disable option
> 2. create fragmented file data
> 3. set flag w/ pinned flag
> 4. fallocate space for pinned file, expects panic due to running
> out of space.
> 
> We should apply both commit ("f2fs: fix to avoid panic once
> fallocation fails for pinfile") and commit ("f2fs: fix to avoid
> running out of free segments") to avoid system panic.
> Note that w/ these two commit, we fixed such issue in both
> convential and zoned block device.
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v2:
> - clean up codes suggested by Zorro
> - change output to expect ENOSPC error if we have applied fixes

Sorry I missed this V2, this version looks good to me. As there's not
more review points from f2fs list, so I'd like to merge it:

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/f2fs/011     | 53 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/f2fs/011.out |  2 ++
>  2 files changed, 55 insertions(+)
>  create mode 100755 tests/f2fs/011
>  create mode 100644 tests/f2fs/011.out
> 
> diff --git a/tests/f2fs/011 b/tests/f2fs/011
> new file mode 100755
> index 00000000..ec3d39ec
> --- /dev/null
> +++ b/tests/f2fs/011
> @@ -0,0 +1,53 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Chao Yu.  All Rights Reserved.
> +#
> +# FS QA Test No. f2fs/011
> +#
> +# This is a regression testcase to check whether we will handle
> +# out-of-space case correctly during fallocate() on pinned file
> +# once we disable checkpoint.
> +# 1. mount f2fs w/ checkpoint=disable option
> +# 2. create fragmented file data
> +# 3. set flag w/ pinned flag
> +# 4. fallocate space for pinned file, expects panic due to running
> +# out of space
> +# We should apply both commit ("f2fs: fix to avoid panic once
> +# fallocation fails for pinfile") and commit ("f2fs: fix to avoid
> +# running out of free segments") to avoid system panic.
> +# Note that w/ these two commit, we fixed such issue in both
> +# convential and zoned block device.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick
> +
> +_fixed_by_kernel_commit 48ea8b200414 \
> +	"f2fs: fix to avoid panic once fallocation fails for pinfile"
> +_fixed_by_kernel_commit xxxxxxxxxxxx \
> +	"f2fs: fix to avoid running out of free segments"
> +
> +_require_scratch
> +_require_command "$F2FS_IO_PROG" f2fs_io
> +
> +_scratch_mkfs_sized $((1*1024*1024*1024)) >> $seqres.full
> +_scratch_mount -o checkpoint=disable:10%
> +
> +pinfile=$SCRATCH_MNT/file
> +
> +# simulate fragment status in f2fs
> +for ((i=0;i<256;i++)) do
> +	$XFS_IO_PROG -f -c "pwrite 0 1m" $SCRATCH_MNT/$i >>$seqres.full
> +done
> +sync
> +
> +for ((i=0;i<256;i+=2)) do
> +	rm -f $SCRATCH_MNT/$i
> +done
> +sync
> +
> +touch $pinfile
> +$F2FS_IO_PROG pinfile set $pinfile >> $seqres.full
> +$XFS_IO_PROG -c "falloc 0 $((3*256*1024*1024))" $pinfile
> +
> +status=0
> +exit
> diff --git a/tests/f2fs/011.out b/tests/f2fs/011.out
> new file mode 100644
> index 00000000..559c3fdf
> --- /dev/null
> +++ b/tests/f2fs/011.out
> @@ -0,0 +1,2 @@
> +QA output created by 011
> +fallocate: No space left on device
> -- 
> 2.49.0
> 

