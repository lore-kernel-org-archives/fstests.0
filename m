Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F45266B64
	for <fstests@vger.kernel.org>; Wed, 13 Aug 2025 15:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099260; cv=none; b=Zw9ZnNRVVZarWNCY52vT4RdzRTUm5UqxxPKXxQtLn6Xv8ljxIqJRt8ZOX9czXGWO0DytSDyNZW5/SLsPMD2ebvQsBABk9PAC8lYt66sd4xkC1uX43Xi0wKM9uG59AtZGK/lTVoGoUeyoRQ2j9+7/wpwzuynv5CDrWCo4StMgg2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099260; c=relaxed/simple;
	bh=u0idpI1IFEykvnYBr78+uhJyxFpy3HygSKk992ML0L0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ogOjLdG59fzRP1l6SgueYI7YuEqKPHF0nfT63Z8XTvWIFPYTmUsGb22YO2/2TV6qMJcNnDn04N2K+zfDqSEyXoHH7LprXQpAJWCaaPbNrXi6xi/pN8fbWaU5PDdfMXhBkMs9ycuzmRSjCco3geu7TrtC+qGzcXCWLogdxu14/Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vp4OJyJM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vp4OJyJM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755099255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pag5QE+HiCvWX75OLxAtakXCKsO90brfj8/L9hsgDYY=;
	b=Vp4OJyJMrG5f7JU+45aqTBtqJCuV41sJdawEP6gRlNfW4nJ0/Jj+pnOjKal2xQ8TK6ScLb
	hh5RKq8DtifqjAngV1+DMbf/o4v8NaHmZhWFQAR50uy20KVd9guZL/4lEjAoOi682qcWlz
	dMlBfw6M30B/XjtFgAB3ZadQIeqcExc=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-FeoJd40yN6K9vcSuG2cIQg-1; Wed, 13 Aug 2025 11:34:14 -0400
X-MC-Unique: FeoJd40yN6K9vcSuG2cIQg-1
X-Mimecast-MFC-AGG-ID: FeoJd40yN6K9vcSuG2cIQg_1755099253
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b4225ab1829so4881026a12.0
        for <fstests@vger.kernel.org>; Wed, 13 Aug 2025 08:34:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755099253; x=1755704053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pag5QE+HiCvWX75OLxAtakXCKsO90brfj8/L9hsgDYY=;
        b=nS99ii4CoCNAkzrwnwsjVFXayY/apnYJRt8HoH78HYpOVTdWnc0spRQNBjS/MYUc58
         rtUsGfdLngOHDYN/sp0LOSp0YTOpa9AlEVO9A9VlNYf8gxZV9maKYIZ00EpCtugD9kIV
         mfeXrDtkfnRk77fyyvQn92C7F6aFds/wNxvJd4NFdR8/bPaVMFSnsWO+hzh+4Itl4QoO
         +OQCsh3kDhHpuNFe0WTgXR4GzvLWi09nEvlI5GmQYquOi1nZ0uRLxWwbV4ft3nogEqT/
         fjXFepqX6LzcotDgxVLsSic6oxIKAQllnS4uRzRZAZClfOW4jbMFaHHVt+mDiWozDjZc
         KpWA==
X-Forwarded-Encrypted: i=1; AJvYcCXtzQUOJuSNLioJQ0F5x2mHfrhrdFc3wHsIidj1DnpuEvMr6C8bKEj9CG8dGJ0k5wtjrf85kRcl@vger.kernel.org
X-Gm-Message-State: AOJu0YxM5eS5m7ArqyUrVlgUwD7YuwBOduxIytKM3H5K5s76onC/OUcO
	ljCUHf39PaajxZBW3bRTVukgKZdPTh9SaSEP0jrRYWkUBK8yS3FK/7L52pljpftUF0ZIUoiDdKK
	8TvMo/0IFm7O4wDw0z7aIULL2rhmUyZi1W3/43/wWdv6Pv1jUTaACUfiKlcw=
X-Gm-Gg: ASbGncvtmWsLZ/qbV/SSYZZ268GWqfVceNY3H8rX+KHVJIODpE2RFzHeneApo60fnVX
	mn9Nui04QoL4G73FYEsXy41MVJthpFMmcTZqsrodKFmVIJDSfqODSc+3xgPyNPhEL/sre3+OXqV
	QrwEDvEGGPoXoFlBA73g2G/zfYMpPaXlOkqwwbkCUgpKeuBHebtLgkPbOeV8mtBbXXQm7oyN7Y0
	Z3Qj3FhZRtrfe/Y59/6EuYwyNA5A6G8XfJ0Q2u9LIzTUsniG+eVFSAq8TJU5O59i3+yWweh+VKz
	g6UaFDQR4iLzT9zdTM2wMDjQpjylwEHHoAST2l52DOJEIPkOYwwp36PvNbr8zhI9YPOEkdmsRol
	YCWm5
X-Received: by 2002:a05:6a20:5491:b0:23d:ac50:3339 with SMTP id adf61e73a8af0-240a8b501b9mr6527620637.29.1755099253039;
        Wed, 13 Aug 2025 08:34:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWhZ+vun122BU6gTYyKkDtgHjV7RxtoofcOawSJj065vUnyH6vWTSz4pE7zBE/XIQ1Jd1Lkw==
X-Received: by 2002:a05:6a20:5491:b0:23d:ac50:3339 with SMTP id adf61e73a8af0-240a8b501b9mr6527568637.29.1755099252612;
        Wed, 13 Aug 2025 08:34:12 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfcf523sm32268158b3a.90.2025.08.13.08.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:34:12 -0700 (PDT)
Date: Wed, 13 Aug 2025 23:34:07 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 3/3] f2fs/020: do sanity check on i_xattr_nid
Message-ID: <20250813153407.b2ldb3u3zuw4ckbs@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250811094415.1053545-1-chao@kernel.org>
 <20250811094415.1053545-3-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811094415.1053545-3-chao@kernel.org>

On Mon, Aug 11, 2025 at 05:44:15PM +0800, Chao Yu wrote:
> This is a regression test:
> 1. create directory
> 2. add a new xattr entry to create xattr node
> 3. use inject.f2fs to inject nid of xattr node w/ ino in a file
> 4. check whether f2fs kernel module will detect and report such
>    corruption in the file
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  tests/f2fs/020     | 50 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/f2fs/020.out |  2 ++
>  2 files changed, 52 insertions(+)
>  create mode 100755 tests/f2fs/020
>  create mode 100644 tests/f2fs/020.out
> 
> diff --git a/tests/f2fs/020 b/tests/f2fs/020
> new file mode 100755
> index 00000000..a6a08c8f
> --- /dev/null
> +++ b/tests/f2fs/020
> @@ -0,0 +1,50 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Chao Yu.  All Rights Reserved.
> +#
> +# FS QA Test No. f2fs/020
> +#
> +# This is a regression test:
> +# 1. create directory
> +# 2. add a new xattr entry to create xattr node
> +# 3. use inject.f2fs to inject nid of xattr node w/ ino in a file
> +# 4. check whether f2fs kernel module will detect and report such
> +#    corruption in the file
> +#
> +. ./common/preamble
> +_begin_fstest auto quick rw
> +
> +_cleanup()
> +{
> +	_scratch_mkfs >> $seqres.full
> +}
> +
> +_fixed_by_kernel_commit 061cf3a84bde \
> +	"f2fs: fix to do sanity check on ino and xnid"
> +
> +export MKFS_OPTIONS=""
> +_require_scratch

Same review points with patch 2/3, 

> +_require_command "$F2FS_INJECT_PROG" inject.f2fs
> +
> +testdir=$SCRATCH_MNT/testdir
> +
> +_scratch_mkfs >> $seqres.full
> +_scratch_mount "-o user_xattr,noinline_xattr"
> +
> +mkdir $testdir
> +# add a new xattr entry to create xattr node
> +setfattr -n user.abc -v 123 $testdir

You can call `_require_attrs user` at first, then use "$SETFATTR_PROG"

> +
> +_scratch_unmount
> +
> +# inject i_xattr_nid w/ nid of inode node
> +$F2FS_INJECT_PROG --node --mb i_xattr_nid --nid 4 --val 4 $SCRATCH_DEV >> $seqres.full
> +
> +_scratch_mount
> +mkdir $testdir/dir >> $seqres.full 2>&1

May I ask what kind of failure will this case hit, if there's the bug?

Thanks,
Zorro

> +_scratch_unmount
> +
> +echo "Silence is golden"
> +
> +status=0
> +exit
> diff --git a/tests/f2fs/020.out b/tests/f2fs/020.out
> new file mode 100644
> index 00000000..20d7944e
> --- /dev/null
> +++ b/tests/f2fs/020.out
> @@ -0,0 +1,2 @@
> +QA output created by 020
> +Silence is golden
> -- 
> 2.49.0
> 

