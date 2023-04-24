Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4562EC77B61
	for <linux-fstests@archiver.kernel.org>; Mon, 24 Apr 2023 21:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjDXVHp (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 24 Apr 2023 17:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232440AbjDXVHo (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 24 Apr 2023 17:07:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E4F6184
        for <fstests@vger.kernel.org>; Mon, 24 Apr 2023 14:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682370416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eyiEsxhqKo7Evs9Wh29L1S1TbPnWGlN8LcoQODm+gWo=;
        b=PAXJ6pYCGiv5cyIcupieAfi9A/3KUb9/r6oNYFzLQ5HdJuKYt6lz4c5pZFCd85AD9/1Ase
        R85i2bZV/LdwLA2ZEQVw2uYobwDCaDIrgOLVzuHYDIS7+tJ5HDFglQlc6CJroB/k0OjY66
        9dhXxdB0CMao2471fLyQ0BXJ0hfMmcg=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-BEAz2-vWM7OxJUaZgi0A0A-1; Mon, 24 Apr 2023 17:06:55 -0400
X-MC-Unique: BEAz2-vWM7OxJUaZgi0A0A-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2476a31ef4aso2768966a91.3
        for <fstests@vger.kernel.org>; Mon, 24 Apr 2023 14:06:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682370414; x=1684962414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eyiEsxhqKo7Evs9Wh29L1S1TbPnWGlN8LcoQODm+gWo=;
        b=IhgSyUJososgz6IttJKrxZWows+3EPdExahBX/xXDWLgkojaPOZRty0j+8ZSCltIOg
         gRtQTYStvOXtOa9OzoN+sQ5+ZD4fCPPNSmSL7DM4e2KftRvyIKsXmUyfEYgIS7GuOzJl
         uGzApE14mzIL4ayONOQ6MLzOH4ZBmslY5jznTVErQHZyFvKQnBCqO7KEn9VYma5Wz7M+
         XqsBPuk+gbltNNWfauOeYzuucyCIzuHon6fNM4/AmnwE5+HANND7VE/rKUSYwMBiCVnE
         cG9nRnwzlnDnUYeYcVG2ibh6nFED0j92Vx+0N2j1OQGPb2a+nBk+kNTZJJ2GyFy/xUSz
         0xSw==
X-Gm-Message-State: AAQBX9cjB9rMFxCEP5t7axXbQu8IrnZRlrIFcoREeP352YohvvAjwS/8
        937D3U17F1WrS0uMlozXom7yLw9gYTCYMjpo/0XtjPFGyNISCJtFq8KE6LTw/UYhOdUYuIRBHIa
        EirDxpG+ze7o8pqwouA==
X-Received: by 2002:a17:90a:ca81:b0:247:a272:71be with SMTP id y1-20020a17090aca8100b00247a27271bemr15387422pjt.46.1682370413976;
        Mon, 24 Apr 2023 14:06:53 -0700 (PDT)
X-Google-Smtp-Source: AKy350b1hlmk92Rl0SHnGAx1b3ulgtTKOZ3iPgfTjtxsq2ktlPqLx/YE0VwjmtFLENXF3WDd++sjxg==
X-Received: by 2002:a17:90a:ca81:b0:247:a272:71be with SMTP id y1-20020a17090aca8100b00247a27271bemr15387404pjt.46.1682370413580;
        Mon, 24 Apr 2023 14:06:53 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id y3-20020a634943000000b0051b460fd90fsm6827330pgk.8.2023.04.24.14.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 14:06:53 -0700 (PDT)
Date:   Tue, 25 Apr 2023 05:06:48 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Cc:     Gao Xiang <hsiangkao@linux.alibaba.com>, fstests@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
Subject: Re: [PATCH v2] src: fix detached_mounts_propagation compile errors
Message-ID: <20230424210648.53l3k2xmuj53nusa@zlang-mailbox>
References: <20230419032955.114278-1-hsiangkao@linux.alibaba.com>
 <20230420021106.41970-1-hsiangkao@linux.alibaba.com>
 <20230422135427.vbrnj6vh46omo34e@zlang-mailbox>
 <7243f364-e822-ce43-7e46-783c317d0a67@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7243f364-e822-ce43-7e46-783c317d0a67@linux.alibaba.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Apr 24, 2023 at 06:17:55PM +0800, Ziyang Zhang wrote:
> On 2023/4/22 21:54, Zorro Lang wrote:
> > On Thu, Apr 20, 2023 at 10:11:06AM +0800, Gao Xiang wrote:
> >> Newer glibc such as glibc 2.36 also defines 'struct mount_attr'
> >> in addition to <linux/mount.h>.  It will report as below when
> >> compiling with old linux kernel headers (without idmapped mounts,
> >> such as kernel-headers 5.10.134) but with newer glibc (here checked
> >> with glibc 2.36.6):
> >>
> >>     [CC]    detached_mounts_propagation
> >> In file included from detached_mounts_propagation.c:29:
> >> vfs/missing.h:115:8: error: redefinition of 'struct mount_attr'
> >>   115 | struct mount_attr {
> >>       |        ^~~~~~~~~~
> >> In file included from detached_mounts_propagation.c:23:
> >> /usr/include/sys/mount.h:210:8: note: originally defined here
> >>   210 | struct mount_attr
> >>       |        ^~~~~~~~~~
> >> gmake[3]: *** [Makefile:102: detached_mounts_propagation] Error 1
> >> gmake[2]: *** [include/buildrules:31: src] Error 2
> >> make[1]: *** [Makefile:51: default] Error 2
> >> make: *** [Makefile:49: default] Error 2
> >>
> >> Let's get rid of <linux/mount.h> as Christian suggested to avoid
> >> potential incompatibility between these two headers.
> >>
> >> Cc: Christian Brauner <brauner@kernel.org>
> >> Cc: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
> >> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> >> ---
> > 
> > This patch works on latest fedora, but it cause fstests can't be built on
> > RHEL-8 [1] and RHEL-9 [2], please check this incompatible problem.
> > 
> > Thanks,
> > Zorro
> > 
> > [1]
> > ...
> > Building include
> > Building lib
> > Building ltp
> > Building src
> >     [CC]    feature
> > In file included from /usr/include/linux/fs.h:18,
> >                  from /usr/include/xfs/linux.h:30,
> >                  from /usr/include/xfs/xfs.h:9,
> >                  from global.h:13,
> >                  from feature.c:29:
> > /usr/include/sys/mount.h:35:3: error: expected identifier before numeric constant
> >    MS_RDONLY = 1,  /* Mount read-only.  */
> >    ^~~~~~~~~
> > gmake[2]: *** [Makefile:112: feature] Error 1
> > gmake[1]: *** [include/buildrules:31: src] Error 2
> > make: *** [Makefile:51: default] Error 2
> > 
> > [2]
> > ...
> > Building include
> > Building lib
> > Building ltp
> > Building src
> >     [CC]    feature
> > In file included from /usr/include/linux/fs.h:19,
> >                  from /usr/include/xfs/linux.h:36,
> >                  from /usr/include/xfs/xfs.h:9,
> >                  from global.h:13,
> >                  from feature.c:29:
> > /usr/include/sys/mount.h:35:3: error: expected identifier before numeric constant
> >    35 |   MS_RDONLY = 1,                /* Mount read-only.  */
> >       |   ^~~~~~~~~
> > In file included from feature.c:49:
> > vfs/missing.h:116:8: error: redefinition of 'struct mount_attr'
> >   116 | struct mount_attr {
> >       |        ^~~~~~~~~~
> > In file included from /usr/include/linux/fs.h:19,
> >                  from /usr/include/xfs/linux.h:36,
> >                  from /usr/include/xfs/xfs.h:9,
> >                  from global.h:13,
> >                  from feature.c:29:
> > /usr/include/linux/mount.h:128:8: note: originally defined here
> >   128 | struct mount_attr {
> >       |        ^~~~~~~~~~
> > gmake[2]: *** [Makefile:112: feature] Error 1
> > gmake[1]: *** [include/buildrules:31: src] Error 2
> > make: *** [Makefile:51: default] Error 2
> > 
> > 
> >>  configure.ac                      | 2 +-
> >>  src/detached_mounts_propagation.c | 1 -
> >>  src/vfs/missing.h                 | 1 +
> >>  3 files changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/configure.ac b/configure.ac
> >> index 4687d8a3..bb29f37e 100644
> >> --- a/configure.ac
> >> +++ b/configure.ac
> >> @@ -74,7 +74,7 @@ AC_HAVE_FIEXCHANGE
> >>  
> >>  AC_CHECK_FUNCS([renameat2])
> >>  AC_CHECK_FUNCS([reallocarray])
> >> -AC_CHECK_TYPES([struct mount_attr], [], [], [[#include <linux/mount.h>]])
> >> +AC_CHECK_TYPES([struct mount_attr], [], [], [[#include <sys/mount.h>]])
> >>  AC_CHECK_TYPES([struct btrfs_qgroup_limit], [], [], [[
> >>  #include <stddef.h>
> >>  #include <linux/btrfs.h>
> >> diff --git a/src/detached_mounts_propagation.c b/src/detached_mounts_propagation.c
> >> index 17db2c02..4041c75f 100644
> >> --- a/src/detached_mounts_propagation.c
> >> +++ b/src/detached_mounts_propagation.c
> >> @@ -20,7 +20,6 @@
> >>  #include <stdio.h>
> >>  #include <stdlib.h>
> >>  #include <string.h>
> >> -#include <sys/mount.h>
> >>  #include <sys/stat.h>
> >>  #include <sys/syscall.h>
> >>  #include <sys/types.h>
> >> diff --git a/src/vfs/missing.h b/src/vfs/missing.h
> >> index 059e742d..04ab33d1 100644
> >> --- a/src/vfs/missing.h
> >> +++ b/src/vfs/missing.h
> >> @@ -18,6 +18,7 @@
> >>  #include <sys/types.h>
> >>  #include <syscall.h>
> >>  #include <unistd.h>
> >> +#include <sys/mount.h>
> >>  
> >>  #ifndef __NR_mount_setattr
> >>  	#if defined __alpha__
> >> -- 
> >> 2.24.4
> >>
> 
> Hi Zorro,
> 
> Can you try this patch, which is inspired by Yang Xu[1].
> 
> [1]https://lore.kernel.org/fstests/ed0bb9f0-c255-10d7-d711-36a464cd6512@fujitsu.com/T/#me981ae064b3ecb151b3321a4ee77f5d916cb017c
> 
> Regards,
> Zhang
> 
> 
> Patch:

Looks like not help [1]. The src/feature.c through global.h -> xfs/xfs.h
-> xfs/linux.h -> linux/fs.h to include linux/mount.h, then it include
"vfs/missing.h" manually. As you add "<sys/mount.h>" to vfs/missing.h,
so there's a conflict. 

Thanks,
Zorro

[1]
# make
Building include
Building lib
Building ltp
Building src
    [CC]    feature
In file included from /usr/include/linux/fs.h:18,
                 from /usr/include/xfs/linux.h:30,
                 from /usr/include/xfs/xfs.h:9,
                 from global.h:13,
                 from feature.c:29:
/usr/include/sys/mount.h:35:3: error: expected identifier before numeric constant
   MS_RDONLY = 1,  /* Mount read-only.  */
   ^~~~~~~~~
gmake[2]: *** [Makefile:112: feature] Error 1
gmake[1]: *** [include/buildrules:31: src] Error 2
make: *** [Makefile:51: default] Error 2

> 
> diff --git a/configure.ac b/configure.ac
> index cbf83779..060c0a5d 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -16,6 +16,7 @@ AC_CHECK_HEADERS([	assert.h		\
>  			sys/uuid.h		\
>  			sys/file.h		\
>  			sys/fcntl.h		\
> +			sys/mount.h		\
>  			sys/syssgi.h		\
>  			sys/param.h		\
>  			sys/stat.h		\
> @@ -27,6 +28,7 @@ AC_CHECK_HEADERS([	assert.h		\
>  			strings.h		\
>  			err.h			\
>  			linux/falloc.h		\
> +			linux/mount.h		\
>  			sys/fs/xfs_fsops.h	\
>  			sys/fs/xfs_itable.h	\
>  			xfs/platform_defs.h	\
> @@ -35,6 +37,10 @@ AC_CHECK_HEADERS([	assert.h		\
>  			sys/mman.h		\
>  ])
>  
> +AC_CHECK_FUNCS_ONCE([
> +	mount_setattr	
> +])
> +
>  AC_CHECK_HEADERS([xfs/xfs_log_format.h],,,[
>  #define _GNU_SOURCE
>  #include <xfs/libxfs.h>])
> @@ -68,7 +74,13 @@ AC_PACKAGE_WANT_LIBBTRFSUTIL
>  AC_HAVE_COPY_FILE_RANGE
>  AC_CHECK_FUNCS([renameat2])
>  AC_CHECK_FUNCS([reallocarray])
> -AC_CHECK_TYPES([struct mount_attr], [], [], [[#include <linux/mount.h>]])
> +AC_CHECK_TYPES([struct mount_attr], [], [],[[
> +#ifdef HAVE_MOUNT_SETATTR
> +# include <sys/mount.h>
> +#elif HAVE_LINUX_MOUNT_H
> +# include <linux/mount.h>
> +#endif
> +]])
>  AC_CHECK_TYPES([struct btrfs_qgroup_limit], [], [], [[
>  #include <stddef.h>
>  #include <linux/btrfs.h>
> diff --git a/src/vfs/missing.h b/src/vfs/missing.h
> index 059e742d..04ab33d1 100644
> --- a/src/vfs/missing.h
> +++ b/src/vfs/missing.h
> @@ -18,6 +18,7 @@
>  #include <sys/types.h>
>  #include <syscall.h>
>  #include <unistd.h>
> +#include <sys/mount.h>
>  
>  #ifndef __NR_mount_setattr
>  	#if defined __alpha__
> 

