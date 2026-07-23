Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909093EEADF
	for <fstests@vger.kernel.org>; Thu, 23 Jul 2026 08:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784795223; cv=none; b=u3UwZy3407xOkzLk0gKvrq7isCH8g0ZxMGU14cju4CIsckqpytFyKTTexzvpoFptAPjIY37BLEx20+15Xt7QBoyeVR87BYz0dcPUdlCK44+FmrQJ7+ppdzzS/CMOtSfIaMRDl2D9sg3k3YwLPNqxIzxmylDaVH/ZYypijDNAf8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784795223; c=relaxed/simple;
	bh=2APrBGV/cvlzIcEvhRW7GqUGBggUItI69o9S2NIp6ZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nTm8a+8d3+Oruse5b48YtJ78S048uT0/D8sgD7IgnSKRgd1pHGJwz1RKDaAdQrzoBv1ZwEjeGWyoT12orMuGYYJmkFK2WKieqN8usVmC50qsLQ7qfJipImkRDRm00K2FTnirHJbAwUtOHm6L1UNuO/qUhe47Yt7nbX+8OD6xvzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IPWEaRPH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=T4Bxc/aH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IPWEaRPH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="T4Bxc/aH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784795216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dj701yK2KVyFPsPsXjvl6aR/GLi0CUf+IqVEJuOAsxk=;
	b=IPWEaRPHnMYM2U95dFl3XQFmYvL/EySMU+CXs19Vc1zFRTLHQCaOEYa+20aaRXKMKn3sW7
	MdG0mBzFkRvVCEr5eZZiN+9wDJdszm2J354nhnnQvqi//rB9Iw0U+OgScyjx1ZYMbJJI3y
	jW5DePwO92RI45uXMGOqTFiHRu79Zbk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-55jKq4F5M06sxoUrmAZwfg-1; Thu, 23 Jul 2026 04:26:54 -0400
X-MC-Unique: 55jKq4F5M06sxoUrmAZwfg-1
X-Mimecast-MFC-AGG-ID: 55jKq4F5M06sxoUrmAZwfg_1784795213
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4954dcd6131so3959665e9.3
        for <fstests@vger.kernel.org>; Thu, 23 Jul 2026 01:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784795213; x=1785400013; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dj701yK2KVyFPsPsXjvl6aR/GLi0CUf+IqVEJuOAsxk=;
        b=T4Bxc/aHm/eajjaLMZeiPzL+jRx9jFA+IrpVSUlChQzvLttRdiw07cYr6+Z993hlcQ
         LHRY0xSzNp+McZ8EZH23RLYjChoZ97gN6nRjjxvezyzqxA6aJFrh5jBuSskOigSx+xDE
         GwxMrQ6MlR2IKoIfidac6sNSITqTnPbb6faMH5TG2prI5WqaxeZ9UlZugjZ9kWbpNWDn
         UZM+iBtq+plMeqajoeaVGdK7JNhgrMgz+g/ULbaPg8DfA9VWQHZYtVmcvQOJs6DASimx
         PB6P/KXr2aTTaD4t3bSvv266ACexa9Os7HASiZ/9qAoQtqz3NzjSKXQzFiVMuyL8clke
         drrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784795213; x=1785400013;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dj701yK2KVyFPsPsXjvl6aR/GLi0CUf+IqVEJuOAsxk=;
        b=h9/gpmnVzJsPE4gSKQl6Xpl6l6S9urnQ0VEsr3/KKf0ZVOHqP8McaOJojh8CmWt5ng
         cFTa5VnCDoSVJlJaTkEmHEmxeFlzj8/mRIxnrgylQeQ1pkWQRREgOcjhr1CU1FztcxYV
         sbea16xDKRHyz+3KbjLdv+VvQZtlOUrmppzTNClk9FPb0OOcfrtZA9ry+FG2cTE63z4r
         Ki+4z8IxX0gADX/OBUWMf/JH58/Y/ZRNpakBti+275xDmRi/6AQmeYKXZ8mAb6RV+ruW
         9zEKGbP6B6agK0m9eApGCXLNt+gWYz6zoMIGlYY5GSz6hR8SzWdW6BlqCgUQLJsA7tyz
         GTOg==
X-Forwarded-Encrypted: i=1; AHgh+Rr2yO6Q8VDJ9y+LWKcLvFcIYMYpsIAhud34q1wDF7B/6H2qQyybNfVAa3FhDrlbI1RtlUnYONCl@vger.kernel.org
X-Gm-Message-State: AOJu0YwIpQHPF1/PD7H5ScamiAx1lCQz9K5iy1iTn0pvxqFfENTHY7Pw
	42qlQdqmeQ7PtM8Rsc07FRovgNbVxa9ZNhcOYN6JutFYEpY7RRXW0TM+rGysfIJujIBzBnELDPd
	2nR0vY2IxtA2A3Q1lBxlbwIRdd+zTlYmHFBp28MhQno0lvSvI4aakNPgFcg==
X-Gm-Gg: AR+sD10U1h87VXzAtzoTaGqm7r6z1gs8mcntimJ07G8MksUYEc28tG5nSabiPueBhPg
	LxhScrgpjQNLTUW1TxLRHT0VaNpiVjDcHJ6M/ajhk11OcCZqYTfsHBPztJPKCkYRIt0G1Ps1Bsw
	q13WgfCYndabka5BvOOkgyEBYnd9iDmN87oG8uVG/do5d1/qQIE8fgpZyvuAJHxl/XRwiQsVLrp
	omLuqGxq+/afYX71i3ONU+gxyJQ2uWtVYPsSnJCuloohIfqCKgvvhWeDrMIa7tQDY1mEYFvnUgJ
	HVhZwv7SY31OHxDPWvRVDRXxvUNZYG0iRR3IWwMWytKvncL55xvV1ocHSp47lV9kpeDqk4qLqdz
	Wxo0hoMzPGMLKUMonIzeWkJbSWoWraUWRwEo=
X-Received: by 2002:a05:600c:5490:b0:490:c6c2:52 with SMTP id 5b1f17b1804b1-49573cbf852mr20551035e9.3.1784795213309;
        Thu, 23 Jul 2026 01:26:53 -0700 (PDT)
X-Received: by 2002:a05:600c:5490:b0:490:c6c2:52 with SMTP id 5b1f17b1804b1-49573cbf852mr20550665e9.3.1784795212712;
        Thu, 23 Jul 2026 01:26:52 -0700 (PDT)
Received: from aalbersh-thinkpadx1carbongen13.rmtcz.csb ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c63678sm12303372f8f.29.2026.07.23.01.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 01:26:52 -0700 (PDT)
Date: Thu, 23 Jul 2026 10:26:51 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Donald Douwsma <ddouwsma@redhat.com>
Cc: Lukas Herbolt <lukas@herbolt.com>, fstests@vger.kernel.org, 
	zlang@kernel.org
Subject: Re: [PATCH] fstests Fix build errors on kernels before v5.1
Message-ID: <amHPADzkqM9F25Rm@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
References: <20260722052256.2406451-3-lukas@herbolt.com>
 <amCMdrK8EscbPTAp@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
 <26d5ba218032a5468d359fb598234b99@herbolt.com>
 <d5f276e5-a3ef-4f5e-aa68-aafeec595ee4@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d5f276e5-a3ef-4f5e-aa68-aafeec595ee4@redhat.com>

On 2026-07-23 15:27:13, Donald Douwsma wrote:
> On 23/7/26 03:49, Lukas Herbolt wrote:
> > On 2026-07-22 11:35, Andrey Albershteyn wrote:
> >> On 2026-07-22 07:22:58, Lukas Herbolt wrote:
> >>> The FAN_REPORT_FID and fanotify_event_info_fid were introduced
> >>> in v5.1. Currently there is no check if the kernel supports it
> >>> making xfstests build to fail on older kernels.
> >>>
> >>> Fixes: 29d120e41c3d ("generic: test fsnotify filesystem error reporting")
> >>>
> >>> Signed-off-by: Lukas Herbolt <lukas@herbolt.com>
> >>
> >> Looks good to me
> >> Reviewed-by: Andrey Albershteyn <aalbersh@kernel.org>
> >>
> >>> ---
> >>>  configure.ac          |  1 +
> >>>  include/builddefs.in  |  1 +
> >>>  m4/package_libcdev.m4 | 14 ++++++++++++++
> >>>  src/Makefile          |  6 +++++-
> >>>  4 files changed, 21 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/configure.ac b/configure.ac
> >>> index 441f543c6089..feb24ddd8854 100644
> >>> --- a/configure.ac
> >>> +++ b/configure.ac
> >>> @@ -74,6 +74,7 @@ AC_NEED_INTERNAL_XFS_IOC_EXCHANGE_RANGE
> >>>  AC_HAVE_FICLONE
> >>>  AC_HAVE_TRIVIAL_AUTO_VAR_INIT
> >>>  AC_HAVE_FILE_GETATTR
> >>> +AC_HAVE_FANOTIFY_FID
> >>>
> >>>  AC_CHECK_FUNCS([renameat2])
> >>>  AC_CHECK_FUNCS([reallocarray])
> >>> diff --git a/include/builddefs.in b/include/builddefs.in
> >>> index 708d75b24d76..8e9e2e3b4113 100644
> >>> --- a/include/builddefs.in
> >>> +++ b/include/builddefs.in
> >>> @@ -75,6 +75,7 @@ HAVE_RLIMIT_NOFILE = @have_rlimit_nofile@
> >>>  NEED_INTERNAL_XFS_IOC_EXCHANGE_RANGE = @need_internal_xfs_ioc_exchange_range@
> >>>  HAVE_FICLONE = @have_ficlone@
> >>>  HAVE_FILE_GETATTR = @have_file_getattr@
> >>> +HAVE_FANOTIFY_FID = @have_fanotify_fid@
> >>>
> >>>  GCCFLAGS = -std=gnu11 -funsigned-char -fno-strict-aliasing -Wall
> >>>  SANITIZER_CFLAGS += @autovar_init_cflags@
> >>> diff --git a/m4/package_libcdev.m4 b/m4/package_libcdev.m4
> >>> index 17f57f427410..340cdad3faf9 100644
> >>> --- a/m4/package_libcdev.m4
> >>> +++ b/m4/package_libcdev.m4
> >>> @@ -102,3 +102,17 @@ AC_DEFUN([AC_HAVE_FILE_GETATTR],
> >>>         AC_MSG_RESULT(yes)],[AC_MSG_RESULT(no)])
> >>>      AC_SUBST(have_file_getattr)
> >>>    ])
> >>> +
> >>> +# Check if we have fanotify FID support (Linux 5.1+)
> >>> +AC_DEFUN([AC_HAVE_FANOTIFY_FID],
> >>> +  [ AC_MSG_CHECKING([for fanotify FID support])
> >>> +    AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
> >>> +#include <sys/fanotify.h>
> >>> +    ]], [[
> >>> +       int x = FAN_REPORT_FID;
> >>> +       struct fanotify_event_info_fid fid;
> >>> +       (void)x; (void)fid;
> >>> +    ]])],[have_fanotify_fid=yes
> >>> +       AC_MSG_RESULT(yes)],[AC_MSG_RESULT(no)])
> >>> +    AC_SUBST(have_fanotify_fid)
> >>> +  ])
> >>> diff --git a/src/Makefile b/src/Makefile
> >>> index 31ac43b215e9..847fb168181e 100644
> >>> --- a/src/Makefile
> >>> +++ b/src/Makefile
> >>> @@ -36,7 +36,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
> >>>      fscrypt-crypt-util bulkstat_null_ocount splice-test chprojid_fail \
> >>>      detached_mounts_propagation ext4_resize t_readdir_3 splice2pipe \
> >>>      uuid_ioctl t_snapshot_deleted_subvolume fiemap-fault min_dio_alignment \
> >>> -    rw_hint fs-monitor
> >>> +    rw_hint
> >>>
> >>>  EXTRA_EXECS = dmerror fill2attr fill2fs fill2fs_check scaleread.sh \
> >>>            btrfs_crc32c_forged_name.py popdir.pl popattr.py \
> >>> @@ -107,6 +107,10 @@ ifeq ($(HAVE_FICLONE),yes)
> >>>       TARGETS += t_reflink_read_race
> >>>  endif
> >>>
> >>> +ifeq ($(HAVE_FANOTIFY_FID),yes)
> >>> +     TARGETS += fs-monitor
> >> ...
> >>>       LINUX_TARGETS += t_btrfs_received_uuid_ioctl
> >>
> >> hah just noticed that fstests "supports" different targets (darwin,
> >> freebsd), not sure if it works at all
> > 
> > Ugh! Indeed that should be LINUX_TARGETS += fs-monitor
> > I will send v2
> 
> I think this was mainly to allow for IRIX back when fstests ran there, the 
> last of which were removed by 
> 
> bc2568f9 fstests: remove IRIX test program open_unlink
> 
> A lot of the more recent programs in TARGETS look like they wouldn't apply 
> to anything outside of linux, i.e. t_ext4_dax_journal_corruption and 
> t_ext4_dax_inline_corruption.
> 
> Given the use of configure to decide what to compile in it may be clearer
> if this was just simplified to use TARGETS in the long term.

Yeah, it just need a cleanup

-- 
- Andrey

