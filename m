Return-Path: <SRS0=ouML=YS=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015A1CA9EA0
	for <linux-fstests@archiver.kernel.org>; Fri, 25 Oct 2019 08:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB4C821D71
	for <linux-fstests@archiver.kernel.org>; Fri, 25 Oct 2019 08:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438004AbfJYIyh (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 25 Oct 2019 04:54:37 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:14449 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2437271AbfJYIyh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 25 Oct 2019 04:54:37 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=eguan@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Tg9MKNH_1571993666;
Received: from localhost(mailfrom:eguan@linux.alibaba.com fp:SMTPD_---0Tg9MKNH_1571993666)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 25 Oct 2019 16:54:27 +0800
Date:   Fri, 25 Oct 2019 16:54:26 +0800
From:   Eryu Guan <eguan@linux.alibaba.com>
To:     Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic/{569,570}: Filter pwrite64
Message-ID: <20191025085426.GG67926@e18g06458.et15sqa>
References: <1571992470-10289-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571992470-10289-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Oct 25, 2019 at 04:34:30PM +0800, Yang Xu wrote:
> When I backport fix commits into old kernel, pwrite action will report
> "pwrite64: Text file busy". Since xfsprogs without commit 2f9a125c3a39 
> ("xfsprogs: replace pread64/pwrite64 by equivalent pread/pwrite"),
> it will report pwrite64. I think these kernel patchs are simple, old kernel
> with lower version xfsprogs may backport these commits. So filter it.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> ---
>  tests/generic/569 | 4 ++--
>  tests/generic/570 | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/generic/569 b/tests/generic/569
> index 02fd8574..651af02f 100755
> --- a/tests/generic/569
> +++ b/tests/generic/569
> @@ -52,8 +52,8 @@ done
>  swapon $testfile 2>&1 | _filter_scratch
>  
>  # Can we write to it?
> -$XFS_IO_PROG -c 'pwrite -S 0x59 64k 64k' $testfile
> -$XFS_IO_PROG -d -c 'pwrite -S 0x60 64k 64k' $testfile
> +$XFS_IO_PROG -c 'pwrite -S 0x59 64k 64k' $testfile 2>&1 | sed -e "s/pwrite64/pwrite/"
> +$XFS_IO_PROG -d -c 'pwrite -S 0x60 64k 64k' $testfile 2>&1 | sed -e "s/pwrite64/pwrite/"

Ah, I forgot about this error message inconsistency in review.. thanks
for the fix!

But there's already a filter to do this, _filter_xfs_io_error, you could
use it directly.

Thanks,
Eryu

>  $XFS_IO_PROG -c 'mmap -rw 64k 64k' -c 'mwrite -S 0x61 64k 64k' $testfile
>  
>  # Can we change the file size?
> diff --git a/tests/generic/570 b/tests/generic/570
> index 1c5f39f1..43ca5c0b 100755
> --- a/tests/generic/570
> +++ b/tests/generic/570
> @@ -47,8 +47,8 @@ done
>  swapon $SCRATCH_DEV 2>&1 | _filter_scratch
>  
>  # Can we write to it?
> -$XFS_IO_PROG -c 'pwrite -S 0x59 64k 64k' $SCRATCH_DEV
> -$XFS_IO_PROG -d -c 'pwrite -S 0x60 64k 64k' $SCRATCH_DEV
> +$XFS_IO_PROG -c 'pwrite -S 0x59 64k 64k' $SCRATCH_DEV 2>&1 | sed -e "s/pwrite64/pwrite/"
> +$XFS_IO_PROG -d -c 'pwrite -S 0x60 64k 64k' $SCRATCH_DEV 2>&1 | sed -e "s/pwrite64/pwrite/"
>  $XFS_IO_PROG -c 'mmap -rw 64k 64k' -c 'mwrite -S 0x61 64k 64k' $SCRATCH_DEV
>  
>  # success, all done
> -- 
> 2.18.0
> 
> 
