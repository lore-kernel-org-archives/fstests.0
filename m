Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32371C77B61
	for <linux-fstests@archiver.kernel.org>; Tue, 25 Apr 2023 07:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbjDYHtH (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 25 Apr 2023 03:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbjDYHsg (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 25 Apr 2023 03:48:36 -0400
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C37DD308
        for <fstests@vger.kernel.org>; Tue, 25 Apr 2023 00:47:53 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R461e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VgzEyOp_1682408869;
Received: from 30.97.56.166(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VgzEyOp_1682408869)
          by smtp.aliyun-inc.com;
          Tue, 25 Apr 2023 15:47:50 +0800
Message-ID: <7b567ffd-772d-11ee-957c-9621f3a581ff@linux.alibaba.com>
Date:   Tue, 25 Apr 2023 15:47:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH] src/detached_mounts_propagation: Fix compile error
Content-Language: en-US
To:     Yang Xu <xuyang2018.jy@fujitsu.com>, fstests@vger.kernel.org
Cc:     hsiangkao@linux.alibaba.com, brauner@kernel.org
References: <1682400834-16985-1-git-send-email-xuyang2018.jy@fujitsu.com>
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <1682400834-16985-1-git-send-email-xuyang2018.jy@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 2023/4/25 13:33, Yang Xu wrote:
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

Hi Yang,

Unfortunately, we find another error after applying this patch:

Building vfs
    [CC]    vfstest
In file included from utils.h:32,
                 from utils.c:21:
missing.h:115:8: error: redefinition of 'struct mount_attr'
  115 | struct mount_attr {
      |        ^~~~~~~~~~
In file included from utils.c:13:
/usr/include/sys/mount.h:210:8: note: originally defined here
  210 | struct mount_attr
      |        ^~~~~~~~~~
gmake[4]: *** [Makefile:30: vfstest] Error 1
gmake[3]: *** [../include/buildrules:31: vfs] Error 2
gmake[2]: *** [include/buildrules:31: src] Error 2
make[1]: *** [Makefile:51: default] Error 2
make: *** [Makefile:49: default] Error 2


Looks like we have to fix src/vfs/utils.c too because it includes both <sys/mount.h>
and "utils.h" and "utils.h" includes "missing.h".

I simply remove #include <sys/mount.h> in src/vfs/utils.c and it works:

diff --git a/src/vfs/utils.c b/src/vfs/utils.c
index 6db7a11d..f30e3bd9 100644
--- a/src/vfs/utils.c
+++ b/src/vfs/utils.c
@@ -10,7 +10,6 @@
 #include <stdlib.h>
 #include <sys/eventfd.h>
 #include <sys/fsuid.h>
-#include <sys/mount.h>
 #include <sys/prctl.h>
 #include <sys/socket.h>
 #include <sys/stat.h>
