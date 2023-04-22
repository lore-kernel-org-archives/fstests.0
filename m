Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F800C6FD18
	for <linux-fstests@archiver.kernel.org>; Sat, 22 Apr 2023 13:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjDVNzR (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 22 Apr 2023 09:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjDVNzQ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 22 Apr 2023 09:55:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D321BF2
        for <fstests@vger.kernel.org>; Sat, 22 Apr 2023 06:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682171674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mzKkFUTouY/XFyPfxrV9trtLRIK4NQuy1VDw//dc6yg=;
        b=gk7r7dSM480iVN3WPQkoFMV2P7f+AM59mKiRG4f19XeL2Fslfo9zEC3lwgEfXXYxxCg8BK
        1xrAlrH4vPcELqTpgtKJ/nqVzlmrxpEefoyy1+6VqiJIvZU35nY/nyD0AIT/V4OHSJRbFh
        06BnnTSfjyw9vBrDlZCYT+7kmvA4kgI=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-S_A2R12KPKy4ygM5Ujnheg-1; Sat, 22 Apr 2023 09:54:33 -0400
X-MC-Unique: S_A2R12KPKy4ygM5Ujnheg-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-63b68f53f9aso2145346b3a.0
        for <fstests@vger.kernel.org>; Sat, 22 Apr 2023 06:54:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682171672; x=1684763672;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mzKkFUTouY/XFyPfxrV9trtLRIK4NQuy1VDw//dc6yg=;
        b=RhxbPWoQvCJHqbYkqHSJ1zFGPmSr6NT5697RWm9bC5WD4m7NeWCl341kIzrKZtSaOJ
         tF470vZLcjNo5N9JDq8vHyvlVaPlKg7xdi3zGo2kLw0lkvR5H+JmqbzJtYF8WuBXN8sz
         9D1ZFQLc923sxwv8y9P4HHfpSF3ydSw7T6LwSseVVYPtzt/yLL/FNbcDSlxZUN58q/oZ
         p+mvXc7f+E8Vv8vCND9Cs5GaUd3PeyHsmt86Z8NWASjQCji2hk6uEJf2QKjDZbfO1MKV
         O8valn07rz+0uqdOJE2UVUM0/L5KN/CjoiyB6SfmPGFxXsyCivcRdCfFgEptw9fPd5Vk
         XC0g==
X-Gm-Message-State: AAQBX9c1oxM6g+NRDcDxU9RYMuaZSsvNAZZzvQ0hOddNdn9MYl9v/CQ0
        JSa1NB8ERFl4llTAKvmyujLD/j+canyA+DKTGQUxKzF9Y7R6pc6woWPL4sFTCxghzBOBON/OGLO
        SEB+Gfnz4lXyahf6RPUgb5zPyJoct
X-Received: by 2002:a05:6a00:cd2:b0:627:6328:79f1 with SMTP id b18-20020a056a000cd200b00627632879f1mr11493426pfv.34.1682171671913;
        Sat, 22 Apr 2023 06:54:31 -0700 (PDT)
X-Google-Smtp-Source: AKy350aUxJ9XUgEhgypqYYulYs/dFi+7dETTK1YXslr/M7KGdk/7ZG9Az8rsFgvjYFV/qrCqrQJ98Q==
X-Received: by 2002:a05:6a00:cd2:b0:627:6328:79f1 with SMTP id b18-20020a056a000cd200b00627632879f1mr11493406pfv.34.1682171671569;
        Sat, 22 Apr 2023 06:54:31 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id c4-20020aa78804000000b0062e00158bf4sm4519719pfo.208.2023.04.22.06.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Apr 2023 06:54:31 -0700 (PDT)
Date:   Sat, 22 Apr 2023 21:54:27 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     fstests@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
Subject: Re: [PATCH v2] src: fix detached_mounts_propagation compile errors
Message-ID: <20230422135427.vbrnj6vh46omo34e@zlang-mailbox>
References: <20230419032955.114278-1-hsiangkao@linux.alibaba.com>
 <20230420021106.41970-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420021106.41970-1-hsiangkao@linux.alibaba.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Apr 20, 2023 at 10:11:06AM +0800, Gao Xiang wrote:
> Newer glibc such as glibc 2.36 also defines 'struct mount_attr'
> in addition to <linux/mount.h>.  It will report as below when
> compiling with old linux kernel headers (without idmapped mounts,
> such as kernel-headers 5.10.134) but with newer glibc (here checked
> with glibc 2.36.6):
> 
>     [CC]    detached_mounts_propagation
> In file included from detached_mounts_propagation.c:29:
> vfs/missing.h:115:8: error: redefinition of 'struct mount_attr'
>   115 | struct mount_attr {
>       |        ^~~~~~~~~~
> In file included from detached_mounts_propagation.c:23:
> /usr/include/sys/mount.h:210:8: note: originally defined here
>   210 | struct mount_attr
>       |        ^~~~~~~~~~
> gmake[3]: *** [Makefile:102: detached_mounts_propagation] Error 1
> gmake[2]: *** [include/buildrules:31: src] Error 2
> make[1]: *** [Makefile:51: default] Error 2
> make: *** [Makefile:49: default] Error 2
> 
> Let's get rid of <linux/mount.h> as Christian suggested to avoid
> potential incompatibility between these two headers.
> 
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---

This patch works on latest fedora, but it cause fstests can't be built on
RHEL-8 [1] and RHEL-9 [2], please check this incompatible problem.

Thanks,
Zorro

[1]
...
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

[2]
...
Building include
Building lib
Building ltp
Building src
    [CC]    feature
In file included from /usr/include/linux/fs.h:19,
                 from /usr/include/xfs/linux.h:36,
                 from /usr/include/xfs/xfs.h:9,
                 from global.h:13,
                 from feature.c:29:
/usr/include/sys/mount.h:35:3: error: expected identifier before numeric constant
   35 |   MS_RDONLY = 1,                /* Mount read-only.  */
      |   ^~~~~~~~~
In file included from feature.c:49:
vfs/missing.h:116:8: error: redefinition of 'struct mount_attr'
  116 | struct mount_attr {
      |        ^~~~~~~~~~
In file included from /usr/include/linux/fs.h:19,
                 from /usr/include/xfs/linux.h:36,
                 from /usr/include/xfs/xfs.h:9,
                 from global.h:13,
                 from feature.c:29:
/usr/include/linux/mount.h:128:8: note: originally defined here
  128 | struct mount_attr {
      |        ^~~~~~~~~~
gmake[2]: *** [Makefile:112: feature] Error 1
gmake[1]: *** [include/buildrules:31: src] Error 2
make: *** [Makefile:51: default] Error 2


>  configure.ac                      | 2 +-
>  src/detached_mounts_propagation.c | 1 -
>  src/vfs/missing.h                 | 1 +
>  3 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 4687d8a3..bb29f37e 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -74,7 +74,7 @@ AC_HAVE_FIEXCHANGE
>  
>  AC_CHECK_FUNCS([renameat2])
>  AC_CHECK_FUNCS([reallocarray])
> -AC_CHECK_TYPES([struct mount_attr], [], [], [[#include <linux/mount.h>]])
> +AC_CHECK_TYPES([struct mount_attr], [], [], [[#include <sys/mount.h>]])
>  AC_CHECK_TYPES([struct btrfs_qgroup_limit], [], [], [[
>  #include <stddef.h>
>  #include <linux/btrfs.h>
> diff --git a/src/detached_mounts_propagation.c b/src/detached_mounts_propagation.c
> index 17db2c02..4041c75f 100644
> --- a/src/detached_mounts_propagation.c
> +++ b/src/detached_mounts_propagation.c
> @@ -20,7 +20,6 @@
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
> -#include <sys/mount.h>
>  #include <sys/stat.h>
>  #include <sys/syscall.h>
>  #include <sys/types.h>
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
> -- 
> 2.24.4
> 

