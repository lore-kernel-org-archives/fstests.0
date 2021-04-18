Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BE4C43460
	for <linux-fstests@archiver.kernel.org>; Sun, 18 Apr 2021 10:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0873D6121D
	for <linux-fstests@archiver.kernel.org>; Sun, 18 Apr 2021 10:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhDRLAB (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 18 Apr 2021 07:00:01 -0400
Received: from out20-98.mail.aliyun.com ([115.124.20.98]:59450 "EHLO
        out20-98.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbhDRLAA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 18 Apr 2021 07:00:00 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1604814|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0781489-0.00414685-0.917704;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047204;MF=guan@eryu.me;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.K.o7Ikt_1618743570;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.K.o7Ikt_1618743570)
          by smtp.aliyun-inc.com(10.147.44.129);
          Sun, 18 Apr 2021 18:59:30 +0800
Date:   Sun, 18 Apr 2021 18:59:30 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Sun Ke <sunke32@huawei.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic/619: a better way to get tot_avail_size
Message-ID: <YHwRErNapsLoaiDD@desktop>
References: <20210415045102.4099962-1-sunke32@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210415045102.4099962-1-sunke32@huawei.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Apr 15, 2021 at 12:51:02AM -0400, Sun Ke wrote:
> When FSTYP is tmpfs, $DF_PROG --block-size=1 $SCRATCH_DEV is not suitted.
> 
> Signei-off-by: Sun Ke <sunke32@huawei.com>
> ---
>  tests/generic/619 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/619 b/tests/generic/619
> index 3c43fe746917..76d6b2c470b9 100755
> --- a/tests/generic/619
> +++ b/tests/generic/619
> @@ -89,7 +89,7 @@ calc_thread_cnt()
>  	IFS=',' read -ra fratio <<< $file_ratio
>  	file_ratio_cnt=${#fratio[@]}
>  
> -	tot_avail_size=$($DF_PROG --block-size=1 $SCRATCH_DEV | awk 'FNR == 2 { print $5 }')

Does s/$SCRATCH_DEV/$SCRATCH_MNT/ work for you? And please replace 'awk'
with $AWK_PROG while we're at it.

Thanks,
Eryu

> +	tot_avail_size=$(echo $($DF_PROG | grep -w $SCRATCH_DEV | awk '{print $5}')*1024 | $BC_PROG)
>  	avail_size=$(echo $tot_avail_size*$disk_saturation | $BC_PROG)
>  	thread_cnt=$(echo "$file_ratio_cnt*($avail_size/$file_ratio_unit)" | $BC_PROG)
>  
> -- 
> 2.25.4
