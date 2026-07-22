Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE653BB669
	for <fstests@vger.kernel.org>; Wed, 22 Jul 2026 09:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784712951; cv=none; b=INAldIi/bXT6lrWLHo93TulgtqaPbFML/pXdK942GJq2cpLloNxxhs+hEXgyDLISxT/Bsn7Q+pfYJnxU9IAvqXcPc6UBzER21GcVFeNN5MnenPDDXgN+8GBPnFvqknOsD/raLFWdF0ULvacbq3LGTJuqyol9Uh1xq/56LJkLoI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784712951; c=relaxed/simple;
	bh=tZMkopl6DThslNJ1XpDFFejfAxyPBTpCXNMJrXZlYVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uiA7Gkq9JK3BQ6zV1/m+2sbGIkFDZiyDBBx8m/vGIJQpdH8YBxpKUQxgRymQV0cRz+7AlVyrzkXrAeZXCh8IY18/WK1xUDVdv2JdcGgQk6zsu+yYOkrfbFmpE7VLAgG/TT9Ree/XkTjEzjjUgyGU8uq8wGP4+jecO0KfnQ1ZmGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rf/zTja1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZroRTe3b; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rf/zTja1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZroRTe3b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784712949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p1IS6cCxkORKw5RK6A2vmvXNVdf8uWkOCBi9hRRTKQs=;
	b=Rf/zTja1PZ7Jy0bNwGWV1X3Z2BQEsPh8Q5DLKMvhFYlTPr5ff9JZPX0NXBcxZxqC8P9vuX
	6eNYACzPK9Be+khx4H5uPowS0vPeFCkjKRZDVJY5A84ozgqm/vMqxaoeheNDi/vh6RZWfN
	mzuBPbMO8GiUnY8KrBsKXqfoY7e5x78=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-bOQTgCrUMF-1WtGN_i3M7A-1; Wed, 22 Jul 2026 05:35:47 -0400
X-MC-Unique: bOQTgCrUMF-1WtGN_i3M7A-1
X-Mimecast-MFC-AGG-ID: bOQTgCrUMF-1WtGN_i3M7A_1784712946
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-493bfc3b84aso66287565e9.0
        for <fstests@vger.kernel.org>; Wed, 22 Jul 2026 02:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784712946; x=1785317746; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=p1IS6cCxkORKw5RK6A2vmvXNVdf8uWkOCBi9hRRTKQs=;
        b=ZroRTe3bQshHpVScjmfLwOfkvvJRFd7dUsRB+Rj/2CQgmeP5Y58uiGWtJXYsZ8M0Lm
         vY+z41dCEbuV2KMahuTedPEG1j4UxnnZUwSNduWhv91XlpQqE0zNzMkDjncLU77d3HYe
         4im4ISZiX5OUlNiGbvkiBC640IYlCSXn+ZcJqhzYkbIR610s9jcb/OW5ktpAHyt/Rhv+
         b48EDeQt0Va6wa5DUoy0i8dtsXAgjHcEkQsWz9W0vmGf5QV15mHgQdHcya1SIR3JHqoA
         gQdQ61DBSpETG1exYv2Xy3NGhPvk9hanZZijeAf8FSpVCQcbpZIyn3fNBCJC37IxJAzl
         WhrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784712946; x=1785317746;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p1IS6cCxkORKw5RK6A2vmvXNVdf8uWkOCBi9hRRTKQs=;
        b=dpOPg867SUhP7hOnYQQILzyrBxJuAGAG3bH9zLIe2NXqU/duYpGpXk9nRqnU5GoDa6
         WvV2Cx0YRHf2nDTUW2O/PJgQ5BiPiahPl2e/fcPU/ldWBcv4Xl4muFdf52BkOptiQ4uL
         yaSpZX4HBL0rhHBG9M+Lxlq7xsDAJ/U54rOsgoQYCutjLm7hd1lmVQM/d/XqTzi0mXxs
         tuUYN+RXGUSINck2tiwi5nYb30RiIGWcmQ/yyxK9nGomo1I4yZ35hM4vpLHkiGPNfrgS
         d4WF8/zYvWJD7PBepE1RMCU+kuk7ww9WYOHk1hZ9Fm9mEiK77Fvg0bzFlO26E3goD7q5
         Tbxw==
X-Gm-Message-State: AOJu0YzWWB8iiJGGda0i3OHakGYCpzyOL74OLjFbheeWs7mn22eHORZf
	CG2X823+WGiumEwx1tqYX7dQ3k40jYSZj3PwOqRubR1Xpc73yXa7SwV+pZI8hMEd6dDj4Gd9eli
	3P33jdmsgWlQKhvW1qYI2MZJRkoAsKPbzeKB/3uKfFeZjXDXnMSC6rorj9g==
X-Gm-Gg: AR+sD10jjRq+aiBUo+tpU968/Pwwyw4AOEjulxIifL0a1g/NQjh5H8p4iHJGGRSCxqD
	ZeCqTObFYy4S88fh92YWsO9uFbPbF9dA2KK7tjpDvvsKarw5m/PuybFYzZ3idEM3hcp7qkUtKBL
	1C9k0tGW9AYiJ18tOJxZayKoQUqsaObkil0vpA9HD+kGd5Oi+7lyeE0M3YaJKuNw2BWua5b/ExO
	MA/Z/Et2G1qeEWza+3m6PlI2C1RGKVOU1io1ClskU302IN7JIoyALC00I997bicZd7knMP/rUi0
	LB8MGgTD9BJqGiDrGCpFZr0tKHX9+ilRT8FRpyDkOUNh6DVLopMtv0RskuiXEaQqhXh6SrbwrnO
	OEuW/gRCJ6+MWkXEo/7K4vjYKpQ/ccDB4ChI=
X-Received: by 2002:a05:600c:49aa:b0:495:5943:b76c with SMTP id 5b1f17b1804b1-4955943b9dfmr114333895e9.34.1784712946178;
        Wed, 22 Jul 2026 02:35:46 -0700 (PDT)
X-Received: by 2002:a05:600c:49aa:b0:495:5943:b76c with SMTP id 5b1f17b1804b1-4955943b9dfmr114333585e9.34.1784712945598;
        Wed, 22 Jul 2026 02:35:45 -0700 (PDT)
Received: from aalbersh-thinkpadx1carbongen13.rmtcz.csb ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956bc68d4esm24811365e9.0.2026.07.22.02.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 02:35:45 -0700 (PDT)
Date: Wed, 22 Jul 2026 11:35:44 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Lukas Herbolt <lukas@herbolt.com>
Cc: fstests@vger.kernel.org, zlang@kernel.org
Subject: Re: [PATCH] fstests Fix build errors on kernels before v5.1
Message-ID: <amCMdrK8EscbPTAp@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
References: <20260722052256.2406451-3-lukas@herbolt.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722052256.2406451-3-lukas@herbolt.com>

On 2026-07-22 07:22:58, Lukas Herbolt wrote:
> The FAN_REPORT_FID and fanotify_event_info_fid were introduced
> in v5.1. Currently there is no check if the kernel supports it
> making xfstests build to fail on older kernels.
> 
> Fixes: 29d120e41c3d ("generic: test fsnotify filesystem error reporting")
> 
> Signed-off-by: Lukas Herbolt <lukas@herbolt.com>

Looks good to me
Reviewed-by: Andrey Albershteyn <aalbersh@kernel.org>

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
...
>       LINUX_TARGETS += t_btrfs_received_uuid_ioctl

hah just noticed that fstests "supports" different targets (darwin,
freebsd), not sure if it works at all

-- 
- Andrey

