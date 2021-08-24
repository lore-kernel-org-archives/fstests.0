Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C998C4338F
	for <linux-fstests@archiver.kernel.org>; Tue, 24 Aug 2021 12:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64EA8604AC
	for <linux-fstests@archiver.kernel.org>; Tue, 24 Aug 2021 12:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236931AbhHXMvA (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 24 Aug 2021 08:51:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33346 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236858AbhHXMvA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 24 Aug 2021 08:51:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629809416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HoNYle1s3bXz8OUyv+jGmEhSjhuHmAmdzIpWY/w5NjM=;
        b=OLcJo4vdLibR3z1cNIViY+0ugR08Mx7puNOJg4ore/2312jWBvP0nBQq6ugF7Z9uADIHk3
        NB7QDEdYi/dyJWF3BhviYFA/oiUGmSKyzbYdgOEHjKu9HdLXxjtT5KAWh2ununE7b2sKW4
        UU9ItZ2M2r+fJSZVyAHuJelXS2UowUI=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-vqzaoSeXPoqU2hLAJamwgQ-1; Tue, 24 Aug 2021 08:50:14 -0400
X-MC-Unique: vqzaoSeXPoqU2hLAJamwgQ-1
Received: by mail-pl1-f199.google.com with SMTP id n1-20020a170902e54100b0012dbd2c897cso5523390plf.20
        for <fstests@vger.kernel.org>; Tue, 24 Aug 2021 05:50:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=HoNYle1s3bXz8OUyv+jGmEhSjhuHmAmdzIpWY/w5NjM=;
        b=cRqqrv1PnAkTPfG3pel3bFybxs4PON2dttwv1CR528tK3M9vFDcb3wtNdEPr6/Yyq6
         OLj5CdNG7b9AYBO7h0hdpqhkNiBDAFp0E71neUeFZK9bY6m+OLx0Joe7kk2fkctLiuwG
         utXycwfoQloh87FiBsf4gltJOHUnqmadVX4rR5OSUUDn+qiQww95rMtygEe2X9kapVvc
         a7aWnKqPS8RkWKCBMuo9swgiNKGdR5JsohaQNNNp3DqsPnFPCZDTNigCSIIXToonUknE
         dCdZemm7x1e1P2i96g1iImMGxXKYGmRd2mZe8CTEA3823acU18iFI5xyKyN2LDfyALLC
         k6tA==
X-Gm-Message-State: AOAM530jWpq64e43bY7OFdE8SfAHmoRlfAJTDkGV04jv7u6OOunnxiZ9
        8TDluUUr7fT+fe9fzHXXk6j+PnHL//XiaWBc70rsz5hEL6b00iuhFD4DuNWwQLWKKOhhe9+G8Y8
        34eiokCe45VcuL6pqyg==
X-Received: by 2002:a62:1787:0:b0:3eb:29b2:5e9 with SMTP id 129-20020a621787000000b003eb29b205e9mr11585243pfx.64.1629809413649;
        Tue, 24 Aug 2021 05:50:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw0Gd5gfx1ULF6XSRzEjInTSNEP+0b5/sSfcjXd2HgniaV/4hQ/mAn8mcjZCe5wPIMtYeznzQ==
X-Received: by 2002:a62:1787:0:b0:3eb:29b2:5e9 with SMTP id 129-20020a621787000000b003eb29b205e9mr11585214pfx.64.1629809413368;
        Tue, 24 Aug 2021 05:50:13 -0700 (PDT)
Received: from fedora ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id nk17sm2495732pjb.18.2021.08.24.05.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 05:50:13 -0700 (PDT)
Date:   Tue, 24 Aug 2021 21:11:00 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] idmap: override btrfs_ioctl_vol_args_v2 if system header
 doesn't have subvolid
Message-ID: <20210824131100.i75v7jmcekcfbp3h@fedora>
Mail-Followup-To: "Darrick J. Wong" <djwong@kernel.org>,
        fstests@vger.kernel.org
References: <20210823182138.GF12612@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210823182138.GF12612@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Aug 23, 2021 at 11:21:38AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> The struct btrfs_ioctl_vol_args_v2 in /usr/include/linux/btrfs.h on my
> system predates the inclusion of the "subvolid" field.  This causes the
> following build failure:
> 
> idmapped-mounts.c: In function 'btrfs_delete_subvolume_id':
> idmapped-mounts.c:9730:6: error: 'struct btrfs_ioctl_vol_args_v2' has no member named 'subvolid'
>  9730 |  args.subvolid = subvolid;
>       |      ^
> 
> Since this source file contains its own more uptodate copy of that
> structure, add some more autoconf/cpp magic so that we can override the
> struct definition if the system header doesn't have the desired field.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---

Thanks, I just hit it[1] too. This patch works on my old and new systems,
so good and helpful to me. I'd like to see it can be merged ASAP.

Reviewed-by: Zorro Lang <zlang@redhat.com>

[1]
    [CC]    idmapped-mounts
    [CC]    mount-idmapped
idmapped-mounts.c: In function 'btrfs_delete_subvolume_id':
idmapped-mounts.c:9730:6: error: 'struct btrfs_ioctl_vol_args_v2' has no member named 'subvolid'
  args.subvolid = subvolid;
      ^
gmake[3]: *** [Makefile:30: idmapped-mounts] Error 1
gmake[2]: *** [../include/buildrules:30: idmapped-mounts] Error 2
gmake[1]: *** [include/buildrules:30: src] Error 2



>  configure.ac                          |    2 +-
>  src/idmapped-mounts/idmapped-mounts.c |    6 +++++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 4117a302..36960910 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -79,7 +79,7 @@ AC_CHECK_TYPES([struct btrfs_ioctl_ino_lookup_args], [], [], [[#include <linux/b
>  AC_CHECK_TYPES([struct btrfs_ioctl_ino_lookup_user_args], [], [], [[#include <linux/btrfs.h>]])
>  AC_CHECK_TYPES([struct btrfs_ioctl_get_subvol_rootref_args], [], [], [[#include <linux/btrfs.h>]])
>  AC_CHECK_HEADERS([linux/btrfs.h linux/btrfs_tree.h])
> -
> +AC_CHECK_MEMBERS([struct btrfs_ioctl_vol_args_v2.subvolid], [], [], [[#include <linux/btrfs.h>]])
>  
>  AC_CONFIG_HEADER(include/config.h)
>  AC_CONFIG_FILES([include/builddefs])
> diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
> index 78b7cc09..40eb2cc6 100644
> --- a/src/idmapped-mounts/idmapped-mounts.c
> +++ b/src/idmapped-mounts/idmapped-mounts.c
> @@ -23,7 +23,11 @@
>  #include <unistd.h>
>  
>  #ifdef HAVE_LINUX_BTRFS_H
> +# ifndef HAVE_STRUCT_BTRFS_IOCTL_VOL_ARGS_V2_SUBVOLID
> +#  define btrfs_ioctl_vol_args_v2 override_btrfs_ioctl_vol_args_v2
> +# endif
>  #include <linux/btrfs.h>
> +# undef btrfs_ioctl_vol_args_v2
>  #endif
>  
>  #ifdef HAVE_LINUX_BTRFS_TREE_H
> @@ -9570,7 +9574,7 @@ struct btrfs_qgroup_inherit {
>  };
>  #endif
>  
> -#ifndef HAVE_STRUCT_BTRFS_IOCTL_VOL_ARGS_V2
> +#if !defined(HAVE_STRUCT_BTRFS_IOCTL_VOL_ARGS_V2) || !defined(HAVE_STRUCT_BTRFS_IOCTL_VOL_ARGS_V2_SUBVOLID)
>  
>  #ifndef BTRFS_SUBVOL_NAME_MAX
>  #define BTRFS_SUBVOL_NAME_MAX 4039
> 

