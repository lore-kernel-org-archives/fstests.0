Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA0222337
	for <fstests@vger.kernel.org>; Sun,  4 Feb 2024 13:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707052531; cv=none; b=J2r8hGo7RuyNb9xgKnvvcZFDXkg7G7rkDFFWHdlOOKCibpfk90E+vQl2DlK2dTOZu/dpzumSK74GAE+jAHEjO6glG4zUalRxRRng9LRtGpn8FlSZ6xWVAEmpPBF1pRQeN0C5rI6ObThywrCtRfzrII1yKBAWzJPZw40Qjc03YHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707052531; c=relaxed/simple;
	bh=CoHXpdBjd4fWUj/c5qQ8LMn61AkWL0vC3uZ+k84u5aE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P/z0o+n1QaIPUZu1P7uoC9SOAYkCI8wVO3nZ5HTjbiW9ya03hStkjE0JpOP1ZWmVQxjW8EFVEUDOpH8V/v4/a25JREoIyfR997doA/FtIckmBAKh0ft2mf4JJJtEzdZOmduSmK/PfqPOJWHjRAy4fkdXjXaq06dAYc1wLXvdPrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GV3mDcM+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GV3mDcM+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707052527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lxyP1JsFMLPRUoWk0k5pEtCyUPIcZiMCq+pimvMnsVg=;
	b=GV3mDcM+VBvlAE2O1RWTDxHbPOfHFDqd4KL5afCmBxD8OpGJ5sfV8Zik7rOIMSCzivFtbz
	jgA6ARt4ElpWN6U+w7sorHUik8Z48FhVuM1fa08qxsJp5RJToQYufgqf7gQg22pkDxXvtD
	/lBf/5Fr8ojV6D+6oAbtzeTMUShBDCU=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-zN4ddls5Mri8CKthTvCAYQ-1; Sun, 04 Feb 2024 08:15:26 -0500
X-MC-Unique: zN4ddls5Mri8CKthTvCAYQ-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6e02aaa5a15so658601b3a.3
        for <fstests@vger.kernel.org>; Sun, 04 Feb 2024 05:15:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707052525; x=1707657325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lxyP1JsFMLPRUoWk0k5pEtCyUPIcZiMCq+pimvMnsVg=;
        b=meICj98UKe2gFacesDAddgrYMTuUoT+17kzKy8jxZEppfmlh8h/925D3l5tv+U+MLp
         YN1uFskre6WDVvquAmxTDvpULk5tDmWpy0vkW/hffACAWr0C9/K8k/4QZSQzPRRm73iQ
         JmRyc1HVe7VReq1ZUNfj/QdevkVJcwoMlYhji6NkLlDVUbqtr996M5QiXtVZfiDLHUQH
         V1V0mI9P0qkOJwRl/IfceHxmYzrCUsWVrpG1JAwmDkuxRgM10l2Gg5gKf13COY9LQiQz
         rKq6tPsAM/hjlo4jpCcjBqMNzjTyd3nZKRXBDd3vegyoRW9KwOSOHgaLs4ha9+4IF0DX
         7enA==
X-Gm-Message-State: AOJu0YzcP6pII/Q7o+PVHADuvpawffSQuc3EAyDGsvc4LqvXRD+dDfDi
	TULo9ou/Klj77qotTF7nb04RAqsWijo/K1kcv4jI6i8u1IEorp5TWtFohgsXzhYyPdG6shanPql
	4QKZpzMSqyvI4L5LAUBA3IxhzQZE7/ws7ZcHfsNDDuOZiDxVgGb0h00o=
X-Received: by 2002:a05:6a20:4393:b0:19c:ae4c:1757 with SMTP id i19-20020a056a20439300b0019cae4c1757mr7058218pzl.52.1707052525002;
        Sun, 04 Feb 2024 05:15:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHillRBxEnghE7mYJ3gj+fGKT62tHMay+Pp6uivYAIanVjZ99nOfjKV532TLL1l/4QP9oz/oA==
X-Received: by 2002:a05:6a20:4393:b0:19c:ae4c:1757 with SMTP id i19-20020a056a20439300b0019cae4c1757mr7058206pzl.52.1707052524630;
        Sun, 04 Feb 2024 05:15:24 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUk+312/AzI5SqOv46D9p4PGcpkytsM/MnH0ROcIvvo3xqVt4JnkVnyn77PFcPTuDmAvAxjb+70HgDwzbIf+94eI4f02KNTql3NxK0=
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id g8-20020a056a0023c800b006ddb0b0ff0dsm4776259pfc.34.2024.02.04.05.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 05:15:24 -0800 (PST)
Date: Sun, 4 Feb 2024 21:15:21 +0800
From: Zorro Lang <zlang@redhat.com>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] t_snapshot_deleted_subvolume: add check for
 BTRFS_IOC_SNAP_DESTROY_V2
Message-ID: <20240204131521.wnueevl6y4snk5lx@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240201042348.147733-1-xuyang2018.jy@fujitsu.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201042348.147733-1-xuyang2018.jy@fujitsu.com>

On Wed, Jan 31, 2024 at 11:23:48PM -0500, Yang Xu wrote:
> On some platform, struct btrfs_ioctl_vol_args_v2 is defined, but the
> macros BTRFS_IOC_SNAP_DESTROY_V2 is not defined. This will cause
> compile error. Add check for BTRFS_IOC_SNAP_DESTROY_V2 to solve this
> problem.
> 
> BTRFS_IOC_SNAP_CREATE_V2 and BTRFS_IOC_SUBVOL_CREATE_V2 were
> introduced together with struct btrfs_ioctl_vol_args_v2 by the
> commit 55e301fd57a6 ("Btrfs: move fs/btrfs/ioctl.h to
> include/uapi/linux/btrfs.h"). So there is no need to check them.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---

This patch is good to me, and test passed on rhel-8.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  configure.ac                       |  1 +
>  src/t_snapshot_deleted_subvolume.c | 10 +++++-----
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index b22fc52b..b14b1ab8 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -109,6 +109,7 @@ AC_CHECK_MEMBERS([struct btrfs_ioctl_vol_args_v2.subvolid], [], [], [[
>  #include <stddef.h>
>  #include <linux/btrfs.h>
>  ]])
> +AC_CHECK_DECLS([BTRFS_IOC_SNAP_DESTROY_V2],,,[#include <linux/btrfs.h>])
>  
>  AC_CONFIG_HEADERS([include/config.h])
>  AC_CONFIG_FILES([include/builddefs])
> diff --git a/src/t_snapshot_deleted_subvolume.c b/src/t_snapshot_deleted_subvolume.c
> index c3adb1c4..402c0515 100644
> --- a/src/t_snapshot_deleted_subvolume.c
> +++ b/src/t_snapshot_deleted_subvolume.c
> @@ -20,11 +20,6 @@
>  #define BTRFS_IOCTL_MAGIC 0x94
>  #endif
>  
> -#ifndef BTRFS_IOC_SNAP_DESTROY_V2
> -#define BTRFS_IOC_SNAP_DESTROY_V2 \
> -	_IOW(BTRFS_IOCTL_MAGIC, 63, struct btrfs_ioctl_vol_args_v2)
> -#endif
> -
>  #ifndef BTRFS_IOC_SNAP_CREATE_V2
>  #define BTRFS_IOC_SNAP_CREATE_V2 \
>  	_IOW(BTRFS_IOCTL_MAGIC, 23, struct btrfs_ioctl_vol_args_v2)
> @@ -58,6 +53,11 @@ struct btrfs_ioctl_vol_args_v2 {
>  };
>  #endif
>  
> +#if !HAVE_DECL_BTRFS_IOC_SNAP_DESTROY_V2
> +#define BTRFS_IOC_SNAP_DESTROY_V2 \
> +	_IOW(BTRFS_IOCTL_MAGIC, 63, struct btrfs_ioctl_vol_args_v2)
> +#endif
> +
>  int main(int argc, char **argv)
>  {
>  	if (argc != 2) {
> -- 
> 2.39.3
> 
> 

