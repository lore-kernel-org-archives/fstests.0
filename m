Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4563C433DB
	for <linux-fstests@archiver.kernel.org>; Sun, 14 Mar 2021 11:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73EB164EBE
	for <linux-fstests@archiver.kernel.org>; Sun, 14 Mar 2021 11:37:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235029AbhCNLhA (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 14 Mar 2021 07:37:00 -0400
Received: from out20-97.mail.aliyun.com ([115.124.20.97]:44291 "EHLO
        out20-97.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234904AbhCNLgf (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 14 Mar 2021 07:36:35 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07526681|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.155349-0.00979337-0.834858;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047190;MF=guan@eryu.me;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.JkuYqxp_1615721792;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.JkuYqxp_1615721792)
          by smtp.aliyun-inc.com(10.147.42.135);
          Sun, 14 Mar 2021 19:36:33 +0800
Date:   Sun, 14 Mar 2021 19:36:32 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic/095: don't silence fio error output
Message-ID: <YE31QG7qhHQY2E6S@desktop>
References: <20210202062253.24478-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202062253.24478-1-zlang@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi Zorro,

On Tue, Feb 02, 2021 at 02:22:53PM +0800, Zorro Lang wrote:
> This case print both fio stdout and stderr to .full file, that cause
> we miss some unexpected failures when there's a bug. For example:
> 
>   file:io_u.c:1803, func=io_u error, error=Block device required
> 
> This's an regression issue we find on a downstream kernel, not in
> upstream. So release unexpected fio error output to find more issues.
> 
> Signed-off-by: Zorro Lang <zlang@redhat.com>
> ---
>  tests/generic/095 | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/generic/095 b/tests/generic/095
> index 9afaa761..30fe77a5 100755
> --- a/tests/generic/095
> +++ b/tests/generic/095
> @@ -98,8 +98,11 @@ _require_fio $fio_config
>  _scratch_mkfs >>$seqres.full 2>&1
>  _scratch_mount
>  
> +# There's a known EIO failure to report collisions between directio and buffered
> +# writes to userspace, refer to upstream linux 5a9d929d6e13. So ignore EIO error
> +# at here.
> +$FIO_PROG $fio_config --ignore_error=,EIO --output=$seqres.full

I found that with this change, EIO is ignored and the return value of
fio command is 0 as expected, but the output breaks golden image and
fails the test.

[root@fedoravm xfstests]# ./check -s xfs_4k_reflink generic/095
SECTION       -- xfs_4k_reflink
RECREATING    -- xfs on /dev/mapper/testvg-lv1
FSTYP         -- xfs (debug)
PLATFORM      -- Linux/x86_64 fedoravm 5.11.0 #5 SMP Sun Feb 28 21:50:24 CST 2021
MKFS_OPTIONS  -- -f -f -b size=4k -m reflink=1,rmapbt=1 /dev/mapper/testvg-lv2
MOUNT_OPTIONS -- /dev/mapper/testvg-lv2 /mnt/scratch

generic/095 4s ... - output mismatch (see /root/workspace/xfstests/results//xfs_4k_reflink/generic/095.out.bad)
    --- tests/generic/095.out   2018-02-25 15:15:00.097388035 +0800
    +++ /root/workspace/xfstests/results//xfs_4k_reflink/generic/095.out.bad    2021-03-14 19:32:04.126884255 +0800
    @@ -1,2 +1,7 @@
     QA output created by 095
    +job9: No I/O performed by mmap, perhaps try --debug=io option for details?
    +job9: No I/O performed by mmap, perhaps try --debug=io option for details?
    +job9: No I/O performed by mmap, perhaps try --debug=io option for details?
    +job9: No I/O performed by mmap, perhaps try --debug=io option for details?
    +job9: No I/O performed by mmap, perhaps try --debug=io option for details?
     Silence is golden

Did you hit the same failure? If so I think we should filter out this
message.

Thanks,
Eryu

>  echo "Silence is golden"
> -$FIO_PROG $fio_config >>$seqres.full 2>&1
>  
>  # xfs generates WARNINGs on purpose when applications mix buffered/mmap IO with
>  # direct IO on the same file. On the other hand, this fio job has been proven
> -- 
> 2.29.2
