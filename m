Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491221607A4
	for <fstests@vger.kernel.org>; Fri, 15 Aug 2025 16:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755273689; cv=none; b=Y8DUB6qodUta0gxLgIF47HW8N91l+RJVIrPy5d8VWB+fE8ZZJlvUg+H40d527IUfi6LU2AK2taExkHu1Xk9yr3U4ra/AtIqHM0tzNm/2HZQXNyfoPZQI1yGH4ksQ3/Bh+4nGhQz4FIR6V+JCnKPOitqZijJFAskY1rqlkQAY4WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755273689; c=relaxed/simple;
	bh=ZagnOXtK2bAzCs9Bm5KQsE2Pl2BITR81ub0bZ1OdyJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5od3Z9ghPobEmulm9OmXg0inbF65q+FOcpB1ZMDgCS23OCaXVLMZnDpLPNTuNPwy08UwRiO0plrhAky05W39LTzGwFcJSsOKnQoKYjnwNYHKPba3c2wNIqxmd7Ql9m+JiEvdVaW+hOemNPgQ+IvI4PrctSFc4IdyDKvPKHd0eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S8S8g5Ju; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S8S8g5Ju"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755273687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t7zIJViFMTGRPSXqeocdaNgcPuKIfHn7AqwZgs3KNqw=;
	b=S8S8g5Juzlf8uYkjh1BS+VH4L5ZMyM/8FDWqD6fJefI/5rxjhI41I1MlG5MB8kKjsespZm
	Sal1feRN4j30D5IMJGXjEPNacGqXG8EIcpYJ+bbweqRhsBnhdsVGoUX/Mx6jDVhm5ti3Og
	sjafnaN7eMNUtyEYYDrpklZv2gd+KO4=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-M8ij5BevMceV2hqylEMoRw-1; Fri, 15 Aug 2025 12:01:25 -0400
X-MC-Unique: M8ij5BevMceV2hqylEMoRw-1
X-Mimecast-MFC-AGG-ID: M8ij5BevMceV2hqylEMoRw_1755273684
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-76e2e890901so3591242b3a.1
        for <fstests@vger.kernel.org>; Fri, 15 Aug 2025 09:01:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755273684; x=1755878484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7zIJViFMTGRPSXqeocdaNgcPuKIfHn7AqwZgs3KNqw=;
        b=vbMOm0lUQwRkweHC3yhSVQwQ1xnlQEbsJcEKrFhjLaQ3X1echH8QgXCpC3cTapxr+s
         nbURpanicRu7l+JkGl3BvWL+AcjEExAxgfNGCzT0AG2aypk3XC22G9RLqDcoAhpNuwBX
         RwXQFvhdwJ9x4bGFeOFsDCObOVjDSTL3xXzIE7wWYdEbGZbXv5rFs0OVaxCS3cMjAXIh
         yrT7N+my4o7xG7WXnAREd+4bsW7GbcqGhiTaAeZKlyj2OWF5vb8UxxQvsTO9+7cFYNLr
         49owxCdlJbGKz0EHJHaim8w3WubB6IhhaN6qUglbgjQw5mJa6BoUVh7Ah24Eg1sSMqCk
         qYYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaYiHHUKeIYNPAphUVDPUaX2HYWuqNM/pccIT7OxYfA3Jku9fKPjUaLjuL84oj42uZ+OilYr3z@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ22zRhIeAecTJC9ASWKhTc3s8vUrPl4/7KxQmpclL611YBKDQ
	+QzmDaN9V5lFU+Usp2VOsFeqRhlryHOZr4B4tuaZDveQGrBs/vW23rk21mt4N5GLBvmDggOLKAR
	Jvn+4TzPHzfWt/3MSXxNBigtP+z4XcQAEDHxlmrHWlSYCd/lWZqkgTkksnis=
X-Gm-Gg: ASbGncsbK3lcgx6FW/ucJUMSE3zRO8VyOM5B/G/qJiZxho49YRHJyVynFCftKDFn62k
	jFtrVMlWlASloW1pO6WxE57UqO+nufTsXEC4C6whCmU0tReB/DoRVum0Nf1DX+4AkbxCvClE1ub
	uxHjkAi5PYIpZtn4hBxue972olJt9fY5M/Xef2KSkYXlJhQojIRyMpmhBrADiDiUX20Ok3H4x/E
	08tTuLqhwnRGy/A0KYuY0KnUGfUX/D9bv2hL4FD/++lzXYKqA5APQz9X18Dz9PPsWEZ3gupvN1k
	K/k7kLD6FBKKtuCIc3BR/OCcfHpxTASNngZ1JEi4fLfNOKbwsTRnUBaCYBPOlf2D7voBLACNnjx
	4JgQI
X-Received: by 2002:a05:6a20:258d:b0:1f5:9024:3254 with SMTP id adf61e73a8af0-240d2d7d6f3mr4811307637.6.1755273684077;
        Fri, 15 Aug 2025 09:01:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgMp3e1XTigPaS6kNWf5YAQFA3G8AVx4PdH4JCXzN4E1mdijRlost0gaz+hwyPzL6CfnTXaw==
X-Received: by 2002:a05:6a20:258d:b0:1f5:9024:3254 with SMTP id adf61e73a8af0-240d2d7d6f3mr4811223637.6.1755273683475;
        Fri, 15 Aug 2025 09:01:23 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e4556670csm1404704b3a.79.2025.08.15.09.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 09:01:23 -0700 (PDT)
Date: Sat, 16 Aug 2025 00:01:18 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v3 2/3] f2fs/016: test special mount options
Message-ID: <20250815160118.ht3ymxihqqr2rhk2@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250804114016.2734919-1-chao@kernel.org>
 <20250804114016.2734919-2-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804114016.2734919-2-chao@kernel.org>

On Mon, Aug 04, 2025 at 07:40:15PM +0800, Chao Yu wrote:
> As f2fs changes to use new mount APIs, let's add a new testcase
> to check mount result for all f2fs supported special mount options
> and their combinations, in order to detect any inconsistency during
> mount.
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---

This version is good to me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/f2fs/016     | 50 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/f2fs/016.out | 33 ++++++++++++++++++++++++++++++
>  2 files changed, 83 insertions(+)
>  create mode 100755 tests/f2fs/016
>  create mode 100644 tests/f2fs/016.out
> 
> diff --git a/tests/f2fs/016 b/tests/f2fs/016
> new file mode 100755
> index 00000000..800f75fc
> --- /dev/null
> +++ b/tests/f2fs/016
> @@ -0,0 +1,50 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Chao Yu.  All Rights Reserved.
> +#
> +# FS QA Test No. f2fs/016
> +#
> +# This testcase tries to check stability of mount result
> +# w/ f2fs special mount options and their combination.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick mount
> +_require_kernel_config CONFIG_F2FS_FS_COMPRESSION
> +_require_kernel_config CONFIG_F2FS_FS_LZO
> +_require_kernel_config CONFIG_F2FS_FS_LZORLE
> +_require_kernel_config CONFIG_F2FS_FS_LZ4
> +_require_kernel_config CONFIG_F2FS_FS_LZ4HC
> +_require_kernel_config CONFIG_F2FS_FS_ZSTD
> +
> +options=(
> +#	mount_option			mkfs_option
> +	"inline_xattr_size=400"		"extra_attr,flexible_inline_xattr"\
> +	"compress_algorithm=lzo"	"extra_attr,compression"	\
> +	"compress_algorithm=lz4"	"extra_attr,compression"	\
> +	"compress_algorithm=zstd"	"extra_attr,compression"	\
> +	"compress_algorithm=lzo-rle"	"extra_attr,compression"	\
> +	"compress_algorithm=lz4:3"	"extra_attr,compression"	\
> +	"compress_algorithm=zstd:1"	"extra_attr,compression"	\
> +	"compress_log_size=8"		"extra_attr,compression"	\
> +	"compress_extension=so"		"extra_attr,compression"	\
> +	"nocompress_extension=so"	"extra_attr,compression"	\
> +	"nocompress_extension=*"	"extra_attr,compression"	\
> +	"compress_extension=so,nocompress_extension=so"			\
> +					"extra_attr,compression"	\
> +	"compress_chksum"		"extra_attr,compression"	\
> +	"compress_mode=fs"		"extra_attr,compression"	\
> +	"compress_mode=user"		"extra_attr,compression"	\
> +	"compress_cache"		"extra_attr,compression"	\
> +)
> +
> +for ((i=0;i<${#options[@]};i=i+2))
> +do
> +	echo "Option#$i: ${options[$i]} : ${options[$((i+1))]}"
> +	_scratch_mkfs "-O ${options[$((i+1))]}" >> $seqres.full || _fail "mkfs failed"
> +	_try_scratch_mount "-o ${options[$i]}" >> $seqres.full 2>&1
> +	echo $?
> +	_scratch_unmount >> $seqres.full 2>&1
> +done
> +
> +status=0
> +exit
> diff --git a/tests/f2fs/016.out b/tests/f2fs/016.out
> new file mode 100644
> index 00000000..a8c96972
> --- /dev/null
> +++ b/tests/f2fs/016.out
> @@ -0,0 +1,33 @@
> +QA output created by 016
> +Option#0: inline_xattr_size=400 : extra_attr,flexible_inline_xattr
> +0
> +Option#2: compress_algorithm=lzo : extra_attr,compression
> +0
> +Option#4: compress_algorithm=lz4 : extra_attr,compression
> +0
> +Option#6: compress_algorithm=zstd : extra_attr,compression
> +0
> +Option#8: compress_algorithm=lzo-rle : extra_attr,compression
> +0
> +Option#10: compress_algorithm=lz4:3 : extra_attr,compression
> +0
> +Option#12: compress_algorithm=zstd:1 : extra_attr,compression
> +0
> +Option#14: compress_log_size=8 : extra_attr,compression
> +0
> +Option#16: compress_extension=so : extra_attr,compression
> +0
> +Option#18: nocompress_extension=so : extra_attr,compression
> +0
> +Option#20: nocompress_extension=* : extra_attr,compression
> +32
> +Option#22: compress_extension=so,nocompress_extension=so : extra_attr,compression
> +32
> +Option#24: compress_chksum : extra_attr,compression
> +0
> +Option#26: compress_mode=fs : extra_attr,compression
> +0
> +Option#28: compress_mode=user : extra_attr,compression
> +0
> +Option#30: compress_cache : extra_attr,compression
> +0
> -- 
> 2.49.0
> 

