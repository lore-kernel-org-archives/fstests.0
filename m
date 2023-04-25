Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC07C6FD18
	for <linux-fstests@archiver.kernel.org>; Tue, 25 Apr 2023 07:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbjDYHmx (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 25 Apr 2023 03:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233303AbjDYHmu (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 25 Apr 2023 03:42:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9097193
        for <fstests@vger.kernel.org>; Tue, 25 Apr 2023 00:42:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7171560A56
        for <fstests@vger.kernel.org>; Tue, 25 Apr 2023 07:42:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9DA2C433EF;
        Tue, 25 Apr 2023 07:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682408568;
        bh=z8luO0Phv56gnkuLde0IZpZvL9kLD7SrG+JWuo3zqaY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HVOi+zzUIqxaHXq8KNPqetWSCte0ySopCtkSfRMJIyHvRgplf2oSISGacawMcbX7O
         5CkATDHKDH/8CJ/BTfX7Z3EWLTOQ2LDEI2pRdjSPsNS9XnTaP6K2q0R9nDFxknERVR
         +muDAClQYz8YIgqmmwIG0U/5N30GD9JK63YMlptZlOAYYaCPcvspVKPVvP93emm9EL
         pXbYx1/UGqAOXtyppNzQU2DkX5qQKsNxEu29fgWqQGHO3uzY72mDrH31mcmfdQBtQ4
         JG2bYVIxVrYoOE1gi3pSstHVJn2SVRZ8GNBqsIPQtPnpZnMKFhvecHv9354gxcsMjP
         wyWG4VajeeWfQ==
Date:   Tue, 25 Apr 2023 09:42:44 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     fstests@vger.kernel.org, hsiangkao@linux.alibaba.com,
        ZiyangZhang@linux.alibaba.com
Subject: Re: [PATCH] src/detached_mounts_propagation: Fix compile error
Message-ID: <20230425-bushaltestelle-zusprach-95047e3d0836@brauner>
References: <1682400834-16985-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1682400834-16985-1-git-send-email-xuyang2018.jy@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Apr 25, 2023 at 01:33:54PM +0800, Yang Xu wrote:
> Newer glibc such as glibc 2.36 also defines 'struct mount_attr'
> in addition to <linux/mount.h>(we also include this kernel header when using
> global.h).
> 
> Usually we should use glibc header instead of kernel header.
> But now mount.h is a special case because both new glibc header and
> kernel header all define "struct mount_attr'. They also define MS*
> macro.
> 
> Since we have some syscall wrapper in vfs/missing.h, we can use
> <linux.mount.h> directly instead of <sys/mount.h>.
> 
> In fact, newer glibc(2.37-1)[1] has sloved conflict problem between
> <sys/mount.h> and <linux/mount.h>. In the future(maybe ten years),
> we can remove this kernel header and use glibc header.
> 
> [1]https://sourceware.org/git/?p=glibc.git;a=commit;h=774058d72942249f71d74e7f2b639f77184160a6
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---

There are neither enough drugs nor curses to express how enraging this
header mess is. I've given up trying to understand what the "correct"
solution is. So if this thing below works,

Acked-by: Christian Brauner <brauner@kernel.org>

>  src/detached_mounts_propagation.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
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
> -- 
> 2.39.1
> 
