Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BBBC48BCF
	for <linux-fstests@archiver.kernel.org>; Sun, 13 Jun 2021 14:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD65A610A1
	for <linux-fstests@archiver.kernel.org>; Sun, 13 Jun 2021 14:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbhFMOrB (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 13 Jun 2021 10:47:01 -0400
Received: from out20-3.mail.aliyun.com ([115.124.20.3]:51378 "EHLO
        out20-3.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbhFMOrB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 13 Jun 2021 10:47:01 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07537976|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.076994-0.000641318-0.922365;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047190;MF=guan@eryu.me;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.KRmSChP_1623595497;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.KRmSChP_1623595497)
          by smtp.aliyun-inc.com(10.147.40.26);
          Sun, 13 Jun 2021 22:44:57 +0800
Date:   Sun, 13 Jun 2021 22:44:57 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Sun Ke <sunke32@huawei.com>
Cc:     fstests@vger.kernel.org, yuchao0@huawei.com
Subject: Re: [PATCH] generic/103: leave more space for f2fs
Message-ID: <YMYZ6dW7w7p4liLC@desktop>
References: <20210611112211.1408767-1-sunke32@huawei.com>
 <20210611112211.1408767-2-sunke32@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210611112211.1408767-2-sunke32@huawei.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Jun 11, 2021 at 07:22:10PM +0800, Sun Ke wrote:
> It failed on f2fs:
>      QA output created by 103
>     +fallocate: No space left on device
>      Silence is golden.
>     ...
> 
> Try to leave ~512KB, but during the fallocate, f2fs will be filled.
> Provide error prompt: "fallocate: No space left on device".
> 
> Leave more space for f2fs.

And this also could be a bug in f2fs, that couldn't fallocate enough
space when free space is larger than request size.

I think the whole patchset needs review from f2fs folks.

Thanks,
Eryu

> 
> Signed-off-by: Sun Ke <sunke32@huawei.com>
> ---
> I add some test code
> 	+       df
> 			avail=`_get_available_space $SCRATCH_MNT`
> 	+       echo "avail = ${avail}"
> 			filesizekb=$((avail / 1024 - 512))
> 	+       echo "filesizekb = ${filesizekb}"
> 			$XFS_IO_PROG -fc "falloc 0 ${filesizekb}k" $file
> 	+       df
> 	}
> 
> f2fs:
> 	QA output created by 103
> 	+Filesystem       1K-blocks       Used   Available Use% Mounted on
> 	...
> 	+/dev/sdb          12580864     553292    12027572   5% /mnt/scratch
> 	+avail = 12316233728
> 	+filesizekb = 12027060
> 	+fallocate: No space left on device
> 	+Filesystem       1K-blocks       Used   Available Use% Mounted on
> 	...
> 	+/dev/sdb          12580864   12580864           0 100% /mnt/scratch
> 	Silence is golden.
> 
> xfs:
> 	QA output created by 103
> 	+Filesystem       1K-blocks       Used   Available Use% Mounted on
> 	...
> 	+/dev/sdb          12572672     120828    12451844   1% /mnt/scratch
> 	+avail = 12750688256
> 	+filesizekb = 12451332
> 	+Filesystem       1K-blocks       Used   Available Use% Mounted on
> 	...
> 	+/dev/sdb          12572672   12572160         512 100% /mnt/scratch
> 	Silence is golden.
> 
> f2fs:
> 	QA output created by 103
> 	+Filesystem       1K-blocks       Used   Available Use% Mounted on
> 	...
> 	+/dev/sdb          12319880      41048    11633304   1% /mnt/scratch
> 	+avail = 11912503296
> 	+filesizekb = 11632792
> 	+Filesystem       1K-blocks       Used   Available Use% Mounted on
> 	...
> 	+/dev/sdb          12319880   11673844         508 100% /mnt/scratch
> 	Silence is golden.
> 
> after change (f2fs)
> 	QA output created by 103
> 	Filesystem       1K-blocks       Used   Available Use% Mounted on
> 	...
> 	/dev/sdb          12580864   12580396         468 100% /tmp/scratch
> 	Silence is golden.
> 
>  tests/generic/103 | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/generic/103 b/tests/generic/103
> index b22b0159623e..dfce3870781c 100755
> --- a/tests/generic/103
> +++ b/tests/generic/103
> @@ -40,10 +40,18 @@ rm -f $seqres.full
>  _consume_freesp()
>  {
>  	file=$1
> +	leave=512
> +
> +	# Try to leave ~512KB, but during the fallocate, f2fs will be filled.
> +	# Provide error prompt: "fallocate: No space left on device". Leave
> +	# more space for f2fs.
> +	if [ $FSTYP == "f2fs" ]; then
> +		leave=12288
> +	fi
>  
>  	# consume nearly all available space (leave ~512kB)
>  	avail=`_get_available_space $SCRATCH_MNT`
> -	filesizekb=$((avail / 1024 - 512))
> +	filesizekb=$((avail / 1024 - $leave))
>  	$XFS_IO_PROG -fc "falloc 0 ${filesizekb}k" $file
>  }
>  
> -- 
> 2.25.4
