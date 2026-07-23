Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB9C383338
	for <fstests@vger.kernel.org>; Thu, 23 Jul 2026 05:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784782991; cv=none; b=b8l5XwRUQH0k2Nyvd5E8Zwnh8GO/Sq5+PYnm0GI5MxOcoj+HNQzoRpIUZrAE8vhmYUegK7vdYmSQvEXw2+SKJ889ue6vMPll6x1HtrPZ3FfmG/G/12EXKyex1RtqcH608x7mYeLA/h4XkL0MzySHuxkB1TJ/VYeTBmJ+Pqc0ugQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784782991; c=relaxed/simple;
	bh=DHuT/Ef4iroXC1LwpBjyYb7A8miGPe2FJLofPy4E7L4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DdqKIsd23beaAD+4nnFrwLIFQzumkzJdFbfQfYfrjP6O9/MF82ln42kg6LD7KoYicYTg0wS/chsdSb+Gw4uDt3bQEg9X5ytPE/z9kJ+o04hbLnLR/IhxER6VCsl9FDPFkrchYOrPIegie6cb2GgMugvoZ4ilVU1k/yqARWfH+s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DkkE6fmx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MThFIDRi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DkkE6fmx";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MThFIDRi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784782988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bz0h5K99nYXH5rax0VMHXemolIOZ/T15rGxJ7ldiQHM=;
	b=DkkE6fmxZiIEHPbtnV3ELLA9zPGpA4SqjFtWwdnXZTOnM87sUIvXxuOi0BeFbocVImZuC3
	w7fE4XCJmBuzzaC/JYmhpzRiv2J17X76qf7+6pvS4EWW64M3+fLjzvdXGJrJVhuxAbnikS
	Xqcg1tfqJ8xfrSDH7h0yVaU+ah0wpyg=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-EOaaesKzN3efnBwlKX6Gdw-1; Thu, 23 Jul 2026 01:03:07 -0400
X-MC-Unique: EOaaesKzN3efnBwlKX6Gdw-1
X-Mimecast-MFC-AGG-ID: EOaaesKzN3efnBwlKX6Gdw_1784782986
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cc7e86e7c5so5360145ad.3
        for <fstests@vger.kernel.org>; Wed, 22 Jul 2026 22:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784782986; x=1785387786; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bz0h5K99nYXH5rax0VMHXemolIOZ/T15rGxJ7ldiQHM=;
        b=MThFIDRikycQQXLgZxxingGjBiC0swvqxxC75YGvYFChlqNqn3YVT/zJNnTS4vdyDi
         6AXmlLk2pzhi9TlkLTesAq2eMlqHpmI8SINUQIOmT0vXrkkVUVqeLzt0rqLq7LN1AnHJ
         M5xjk33PZvWMueZoHsMkttd8jMjU3WAMDtEUPxA5A1MC4zyOMBA3chGSG6NJUUjxZnkv
         h0sBK/cuc/2Je+H3q+99wwEgqcSLI8hgqQL4c4BgVpWa1FHvVP8I2w+o43yW/rSbekny
         BzpxIBqqX/N7BSOUYrwa2zg1rMxrX4xDMur6F88f6Khv0ucaOfHwR3StfPLw9ZTwHLvY
         Gw3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784782986; x=1785387786;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bz0h5K99nYXH5rax0VMHXemolIOZ/T15rGxJ7ldiQHM=;
        b=tFjk2isir/RXGUgkdq5imJ2l1JUy6sz9My2i5IquMoncCW4G+ViQYxHDUsJnLZKoqG
         xwkAqideW5X03/VzKHGno+yyFUTCNka2JoZWReyHipvi2IlLaLZo4jl07rrwUcxAajq1
         rHs6wSL7+sCSUhd7QmLKQuFXFCIlsuFZm65HKhtN/Y3hGCK2Tnsmcn2Z/vajnKQMCt10
         +f9fG4qSNopl5slF8ABRYuHYjl5eNmL3y1G2qoDTD45CTJNjuxmgxCczwIVPr9tYXzZq
         rdjr3yzbLqI3YLbYljyWvwuio/uChVUKBqqLBvY14Xc9+9ZtdwUSe5VOPtkbKrT5v0Q3
         X/1w==
X-Forwarded-Encrypted: i=1; AHgh+RrIZGEB1Z9Es8VDr9zFxmhpzOPkQ1J7VVQ3jIfuItLfVsMQnoUM7jsiRgTJ4hmZsjvlamIOxafb@vger.kernel.org
X-Gm-Message-State: AOJu0Yw91cuW/zgL3+cCjMfTzwYqWK3gUnaDsnSf5NatAHBWrovcpLHY
	DV0+8tZoXITGM96XfWS97W/BjOmT620mQkwPgAMagJ6wuAjg11czZtebh3I5nP5DnGokdd9OA7F
	O9EgCWGrVAdiziFB4ILPKjjCtnQQxz6ZIfsu5ghcs+sW/qC/B5IgtdBNVej46hGX7ZhE=
X-Gm-Gg: AR+sD11JzP0lshMOUG87zmSMEdLaaBOhJHAUNb+xiL4F0/RAS1KKAYYI3TVYch7madJ
	HmADMGUDakCrtXPpkZZ31yFW52zni0CDeXiAJJBFetJInngHn4+DF/cg3+SxOMF+G9kE4JcdkU1
	8hY35IauO+BpvOmYSdnCrWcVv/Vct61BJUQaCfcakOZRGRF3gkBht7kQ5bPjL+cF+rywPps/zpL
	+jJXOB6v8taQau7u3zU8xjrfMfQtGIzT0HfTiUYMkmeyoG5Q7gLyldBlunlVJ1Euh9pjH3d6Ewz
	3e4A6ZrdXEesnVg5nTcP7kDbtCZy5bZ5zv+kK4iPleyyHUzohay31llvk4DaUXaZcK2c0ZC033o
	ye49W40x0taMb1O16hXm+PBQVzM4P+xY3hGj5u/zUMFECPLY=
X-Received: by 2002:a17:902:e841:b0:2cf:a1c1:c60e with SMTP id d9443c01a7336-2cfa6a5a0a3mr22246005ad.1.1784782986054;
        Wed, 22 Jul 2026 22:03:06 -0700 (PDT)
X-Received: by 2002:a17:902:e841:b0:2cf:a1c1:c60e with SMTP id d9443c01a7336-2cfa6a5a0a3mr22245655ad.1.1784782985588;
        Wed, 22 Jul 2026 22:03:05 -0700 (PDT)
Received: from ?IPV6:2001:8003:4b1b:d900:266e:8be8:569:ffa6? ([2001:8003:4b1b:d900:266e:8be8:569:ffa6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfa57542e0sm7418315ad.67.2026.07.22.22.03.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 22:03:04 -0700 (PDT)
Message-ID: <a2ed9331-795f-4604-9267-d2946e4beb35@redhat.com>
Date: Thu, 23 Jul 2026 15:03:01 +1000
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests Fix build errors on kernels before v5.1
To: Lukas Herbolt <lukas@herbolt.com>, fstests@vger.kernel.org
Cc: zlang@kernel.org
References: <20260722052256.2406451-3-lukas@herbolt.com>
Content-Language: en-US, en-AU
From: Donald Douwsma <ddouwsma@redhat.com>
In-Reply-To: <20260722052256.2406451-3-lukas@herbolt.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/7/26 15:22, Lukas Herbolt wrote:
> The FAN_REPORT_FID and fanotify_event_info_fid were introduced
> in v5.1. Currently there is no check if the kernel supports it
> making xfstests build to fail on older kernels.
> 
> Fixes: 29d120e41c3d ("generic: test fsnotify filesystem error reporting")
> 
> Signed-off-by: Lukas Herbolt <lukas@herbolt.com>

Looks good!
Reviewed-by: Donald Douwsma <ddouwsma@redhat.com>

> ---
>  configure.ac          |  1 +
>  include/builddefs.in  |  1 +
>  m4/package_libcdev.m4 | 14 ++++++++++++++
>  src/Makefile          |  6 +++++-
>  4 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 441f543c6089..feb24ddd8854 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -74,6 +74,7 @@ AC_NEED_INTERNAL_XFS_IOC_EXCHANGE_RANGE
>  AC_HAVE_FICLONE
>  AC_HAVE_TRIVIAL_AUTO_VAR_INIT
>  AC_HAVE_FILE_GETATTR
> +AC_HAVE_FANOTIFY_FID
>  
>  AC_CHECK_FUNCS([renameat2])
>  AC_CHECK_FUNCS([reallocarray])
> diff --git a/include/builddefs.in b/include/builddefs.in
> index 708d75b24d76..8e9e2e3b4113 100644
> --- a/include/builddefs.in
> +++ b/include/builddefs.in
> @@ -75,6 +75,7 @@ HAVE_RLIMIT_NOFILE = @have_rlimit_nofile@
>  NEED_INTERNAL_XFS_IOC_EXCHANGE_RANGE = @need_internal_xfs_ioc_exchange_range@
>  HAVE_FICLONE = @have_ficlone@
>  HAVE_FILE_GETATTR = @have_file_getattr@
> +HAVE_FANOTIFY_FID = @have_fanotify_fid@
>  
>  GCCFLAGS = -std=gnu11 -funsigned-char -fno-strict-aliasing -Wall
>  SANITIZER_CFLAGS += @autovar_init_cflags@
> diff --git a/m4/package_libcdev.m4 b/m4/package_libcdev.m4
> index 17f57f427410..340cdad3faf9 100644
> --- a/m4/package_libcdev.m4
> +++ b/m4/package_libcdev.m4
> @@ -102,3 +102,17 @@ AC_DEFUN([AC_HAVE_FILE_GETATTR],
>         AC_MSG_RESULT(yes)],[AC_MSG_RESULT(no)])
>      AC_SUBST(have_file_getattr)
>    ])
> +
> +# Check if we have fanotify FID support (Linux 5.1+)
> +AC_DEFUN([AC_HAVE_FANOTIFY_FID],
> +  [ AC_MSG_CHECKING([for fanotify FID support])
> +    AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
> +#include <sys/fanotify.h>
> +    ]], [[
> +       int x = FAN_REPORT_FID;
> +       struct fanotify_event_info_fid fid;
> +       (void)x; (void)fid;
> +    ]])],[have_fanotify_fid=yes
> +       AC_MSG_RESULT(yes)],[AC_MSG_RESULT(no)])
> +    AC_SUBST(have_fanotify_fid)
> +  ])
> diff --git a/src/Makefile b/src/Makefile
> index 31ac43b215e9..847fb168181e 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -36,7 +36,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
>  	fscrypt-crypt-util bulkstat_null_ocount splice-test chprojid_fail \
>  	detached_mounts_propagation ext4_resize t_readdir_3 splice2pipe \
>  	uuid_ioctl t_snapshot_deleted_subvolume fiemap-fault min_dio_alignment \
> -	rw_hint fs-monitor
> +	rw_hint
>  
>  EXTRA_EXECS = dmerror fill2attr fill2fs fill2fs_check scaleread.sh \
>  	      btrfs_crc32c_forged_name.py popdir.pl popattr.py \
> @@ -107,6 +107,10 @@ ifeq ($(HAVE_FICLONE),yes)
>       TARGETS += t_reflink_read_race
>  endif
>  
> +ifeq ($(HAVE_FANOTIFY_FID),yes)
> +     TARGETS += fs-monitor
> +endif
> +
>  ifeq ($(HAVE_LIBBTRFSUTIL), true)
>       LINUX_TARGETS += t_btrfs_received_uuid_ioctl
>  endif
> 
> base-commit: acb6d4cb84205a8e3f19ca470cfcf7bf6d93a509

