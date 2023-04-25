Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFA2C6FD18
	for <linux-fstests@archiver.kernel.org>; Tue, 25 Apr 2023 09:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbjDYJPY (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 25 Apr 2023 05:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233201AbjDYJPY (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 25 Apr 2023 05:15:24 -0400
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002C810FD
        for <fstests@vger.kernel.org>; Tue, 25 Apr 2023 02:15:20 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R811e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VgzeZJK_1682414117;
Received: from 30.97.56.166(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VgzeZJK_1682414117)
          by smtp.aliyun-inc.com;
          Tue, 25 Apr 2023 17:15:18 +0800
Message-ID: <624d6322-8b6c-36d4-eb64-7658a05f8062@linux.alibaba.com>
Date:   Tue, 25 Apr 2023 17:15:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH v2] src: Don't include <sys/mount.h> and <linux/mount.h>
 together
Content-Language: en-US
To:     Yang Xu <xuyang2018.jy@fujitsu.com>, fstests@vger.kernel.org
Cc:     hsiangkao@linux.alibaba.com, brauner@kernel.org
References: <7b567ffd-772d-11ee-957c-9621f3a581ff@linux.alibaba.com>
 <1682410890-19102-1-git-send-email-xuyang2018.jy@fujitsu.com>
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <1682410890-19102-1-git-send-email-xuyang2018.jy@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 2023/4/25 16:21, Yang Xu wrote:
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

Tested-by: Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
