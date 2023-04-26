Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2B4C77B60
	for <linux-fstests@archiver.kernel.org>; Wed, 26 Apr 2023 14:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240570AbjDZOAj (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 26 Apr 2023 10:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbjDZOAi (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 26 Apr 2023 10:00:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B343659C
        for <fstests@vger.kernel.org>; Wed, 26 Apr 2023 06:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682517593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FWfb92iwXUPW0jc5Q5tQXl3a3kyst37kElU/p/azixE=;
        b=g6WKP8SExV1qdzwdpBsBKNxu5SKovBOyqHSM0JzLaaQT/CDJf/jRJPC185rP/VPHPxehbs
        nETsY1n0VXgSr7ZYuKQiH96w0jtsoweSVlO13289f4Zf1V+bK4nOkc0mHmZqbOzmpn6A14
        IcWrMmnyLUC7z9u2Hz9f5vh9KmZzdSc=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-grC3Zl7ANaqvlZOeKWwXXA-1; Wed, 26 Apr 2023 09:59:51 -0400
X-MC-Unique: grC3Zl7ANaqvlZOeKWwXXA-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-24bfaeb5ef1so375719a91.0
        for <fstests@vger.kernel.org>; Wed, 26 Apr 2023 06:59:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682517590; x=1685109590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FWfb92iwXUPW0jc5Q5tQXl3a3kyst37kElU/p/azixE=;
        b=k1owzyEkhPzHpkIzcFfkaTbtMEHe5+35RAr1rp635fuxc+nHmdRxunyeu925giAHSe
         WpuZz1z5DRlopGzhAgLRIkGMLbv27x1NZvz7rnofXi5QNt66meqcEeBmBz0Kbvz3mlkZ
         vRjpD+2TLHC6rNAUxgS9yoXG1+9Jt/56cm/8NRsiNKhNBXz+csAmwzjlrx5YY1xnyp50
         zBQVfnDY0fZQIg1Qy4FWCabLtwS07UEbfePE1zdEJ7IrqYV/i4Qof0D+KcpUaGVztyyr
         XnYd5Vg7vTLrUedA2bG0iVmUIvoPt+ZjhNaU32e8/xQm3tgacbfVQKu8fXKWdR6UBNbw
         YUrg==
X-Gm-Message-State: AAQBX9fpLf3E6sT1EmpAEVUqPPeeTMyw+UXqA51CXUJywb/VN+vHMOG/
        31AjtRWudmy3mKjd4jMb8YIfXXe3O4/9XPWN+Vc/8kb0JFE6P72zBD5wjjq8AynXdE2iOzYRSEG
        +ojAjnvOprDJ+eEpZuA==
X-Received: by 2002:a17:90a:3186:b0:23e:fa90:ba37 with SMTP id j6-20020a17090a318600b0023efa90ba37mr18236153pjb.49.1682517590488;
        Wed, 26 Apr 2023 06:59:50 -0700 (PDT)
X-Google-Smtp-Source: AKy350aFCqHow0zxAXERF6vWx7ivJ0lUhumMJyqYzNf2XhaTfyCEWNsYKacc4T+ZRrW7JyXJodK/gA==
X-Received: by 2002:a17:90a:3186:b0:23e:fa90:ba37 with SMTP id j6-20020a17090a318600b0023efa90ba37mr18236128pjb.49.1682517589991;
        Wed, 26 Apr 2023 06:59:49 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id bv21-20020a17090af19500b002465e66256asm9875791pjb.11.2023.04.26.06.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 06:59:49 -0700 (PDT)
Date:   Wed, 26 Apr 2023 21:59:44 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     fstests@vger.kernel.org, hsiangkao@linux.alibaba.com,
        brauner@kernel.org, ZiyangZhang@linux.alibaba.com
Subject: Re: [PATCH v2] src: Don't include <sys/mount.h> and <linux/mount.h>
 together
Message-ID: <20230426135944.46y4r5jsa7a2m4s4@zlang-mailbox>
References: <7b567ffd-772d-11ee-957c-9621f3a581ff@linux.alibaba.com>
 <1682410890-19102-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1682410890-19102-1-git-send-email-xuyang2018.jy@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Apr 25, 2023 at 04:21:30PM +0800, Yang Xu wrote:
> Newer glibc such as glibc 2.36 also defines 'struct mount_attr'
> in addition to <linux/mount.h>.
> 
> Usually we should use glibc header instead of kernel header.
> But now mount.h is a special case because both new glibc header and
> kernel header all define "struct mount_attr'. They also define MS* macro.
> 
> Since we have some syscall wrapper in vfs/missing.h, we can use <linux.mount.h> directly
> instead of <sys/mount.h> for detached_mounts_propagation.c.
> 
> For utils.c, it doesn't use the macro or function in <sys/mount.h>, so
> remove it directly.
> 
> In fact, newer glibc(2.37-1)[1] has sloved conflict problem between <sys/mount.h> and <linux/mount.h>.
> In the future(maybe ten years), we can remove this kernel header and use glibc header.
> 
> [1]https://sourceware.org/git/?p=glibc.git;a=commit;h=774058d72942249f71d74e7f2b639f77184160a6
> 
> Acked-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---

The commit log makes sense to me. (Except some lines are too long, I prefer
each general lines in commit log less than 70 chars. I'll adjust that a bit
hen I merge it).

This version looks good to me, and doesn't break RHEL 8/9 system this time.
Thanks!

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  src/detached_mounts_propagation.c | 5 ++---
>  src/vfs/utils.c                   | 1 -
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/src/detached_mounts_propagation.c b/src/detached_mounts_propagation.c
> index 17db2c02..dd11f7be 100644
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
> @@ -127,7 +126,7 @@ int main(int argc, char *argv[])
>  	if (ret < 0)
>  		exit_log("%m - Failed to create new mount namespace");
>  
> -	ret = mount(NULL, base_dir, NULL, MS_REC | MS_SHARED, NULL);
> +	ret = sys_mount(NULL, base_dir, NULL, MS_REC | MS_SHARED, NULL);
>  	if (ret < 0)
>  		exit_log("%m - Failed to make base_dir shared mountpoint");
>  
> @@ -174,7 +173,7 @@ int main(int argc, char *argv[])
>  		}
>  		close(fd_tree);
>  
> -		ret = umount2(target, MNT_DETACH);
> +		ret = sys_umount2(target, MNT_DETACH);
>  		if (ret < 0) {
>  			fprintf(stderr, "%m - Failed to unmount %s", target);
>  			exit_code = EXIT_FAILURE;
> diff --git a/src/vfs/utils.c b/src/vfs/utils.c
> index 9e67ac37..0ab5de15 100644
> --- a/src/vfs/utils.c
> +++ b/src/vfs/utils.c
> @@ -10,7 +10,6 @@
>  #include <stdlib.h>
>  #include <sys/eventfd.h>
>  #include <sys/fsuid.h>
> -#include <sys/mount.h>
>  #include <sys/prctl.h>
>  #include <sys/socket.h>
>  #include <sys/stat.h>
> -- 
> 2.39.1
> 

