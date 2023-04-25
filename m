Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32D1C77B61
	for <linux-fstests@archiver.kernel.org>; Tue, 25 Apr 2023 01:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbjDYB7S (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 24 Apr 2023 21:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232950AbjDYB7R (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 24 Apr 2023 21:59:17 -0400
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C0E40C3
        for <fstests@vger.kernel.org>; Mon, 24 Apr 2023 18:59:15 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VgxvfKr_1682387952;
Received: from 30.97.56.166(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VgxvfKr_1682387952)
          by smtp.aliyun-inc.com;
          Tue, 25 Apr 2023 09:59:13 +0800
Message-ID: <20b80d9e-9ef1-0811-152d-0f0f0eff7615@linux.alibaba.com>
Date:   Tue, 25 Apr 2023 09:59:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH v2] src: fix detached_mounts_propagation compile errors
Content-Language: en-US
To:     "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>,
        Zorro Lang <zlang@redhat.com>
Cc:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>
References: <20230419032955.114278-1-hsiangkao@linux.alibaba.com>
 <20230420021106.41970-1-hsiangkao@linux.alibaba.com>
 <20230422135427.vbrnj6vh46omo34e@zlang-mailbox>
 <7243f364-e822-ce43-7e46-783c317d0a67@linux.alibaba.com>
 <20230424210648.53l3k2xmuj53nusa@zlang-mailbox>
 <5cd6f60e-b725-6aa0-733b-ce92434694c8@fujitsu.com>
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <5cd6f60e-b725-6aa0-733b-ce92434694c8@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 2023/4/25 09:28, Yang Xu (Fujitsu) wrote:
> 

[...]

>>
>> Looks like not help [1]. The src/feature.c through global.h -> xfs/xfs.h
>> -> xfs/linux.h -> linux/fs.h to include linux/mount.h, then it include
>> "vfs/missing.h" manually. As you add "<sys/mount.h>" to vfs/missing.h,
>> so there's a conflict.
> 
> Yes, here is a complex problem than ltp because global.h includes 
> <linux/mount.h>. We don't include <sys/mount.h> or <linux/mount.h> 
> together on older glibc(glibc 2.36.6).  Newer glibc(glibc-2.37-1)[1] 
> seems has sloved this problem.
> 
> [1]https://sourceware.org/git/?p=glibc.git;a=commit;h=774058d72942249f71d74e7f2b639f77184160a6
> 
> I guess we can not use <sys/mount.h> header,
> then compile info as below:
> detached_mounts_propagation.c: In function 'main':
> detached_mounts_propagation.c:129:15: warning: implicit declaration of 
> function 'mount' [-Wimplicit-function-declaration]
>    129 |         ret = mount(NULL, base_dir, NULL, MS_REC | MS_SHARED, 
> NULL);
>        |               ^~~~~
> detached_mounts_propagation.c:176:23: warning: implicit declaration of 
> function 'umount2'; did you mean 'sys_umount2'? 
> [-Wimplicit-function-declaration]
>    176 |                 ret = umount2(target, MNT_DETACH);
>        |                       ^~~~~~~
>        |                       sys_umount2
> 
> 
> then we can use syscall wrapper directly instead of glibc wrapper
> --- a/src/detached_mounts_propagation.c
> +++ b/src/detached_mounts_propagation.c
> @@ -20,7 +20,6 @@
>   #include <stdio.h>
>   #include <stdlib.h>
>   #include <string.h>
> -#include <sys/mount.h>
>   #include <sys/stat.h>
>   #include <sys/syscall.h>
>   #include <sys/types.h>
> @@ -127,7 +126,7 @@ int main(int argc, char *argv[])
>          if (ret < 0)
>                  exit_log("%m - Failed to create new mount namespace");
> 
> -       ret = mount(NULL, base_dir, NULL, MS_REC | MS_SHARED, NULL);
> +       ret = sys_mount(NULL, base_dir, NULL, MS_REC | MS_SHARED, NULL);
>          if (ret < 0)
>                  exit_log("%m - Failed to make base_dir shared mountpoint");
> 
> @@ -174,7 +173,7 @@ int main(int argc, char *argv[])
>                  }
>                  close(fd_tree);
> 
> -               ret = umount2(target, MNT_DETACH);
> +               ret = sys_umount2(target, MNT_DETACH);
>                  if (ret < 0) {
>                          fprintf(stderr, "%m - Failed to unmount %s", 
> target);
>                          exit_code = EXIT_FAILURE;
> 
> 
> Best Regards
> Yang Xu
> 

Hi Yang,

You patch works for me(kernel: 5.10.134, glibc:2.36). I think we could just
modify detached_mounts_propagation.c to solve this problem.

Regards,
Zhang
