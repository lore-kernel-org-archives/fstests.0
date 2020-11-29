Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07376C64E7C
	for <linux-fstests@archiver.kernel.org>; Sun, 29 Nov 2020 08:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7D942076C
	for <linux-fstests@archiver.kernel.org>; Sun, 29 Nov 2020 08:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbgK2INR (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 29 Nov 2020 03:13:17 -0500
Received: from out20-25.mail.aliyun.com ([115.124.20.25]:36021 "EHLO
        out20-25.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgK2INR (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 29 Nov 2020 03:13:17 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1936201|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00963387-0.00123003-0.989136;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047208;MF=guan@eryu.me;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.J0ZYEiV_1606637554;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.J0ZYEiV_1606637554)
          by smtp.aliyun-inc.com(10.147.44.129);
          Sun, 29 Nov 2020 16:12:35 +0800
Date:   Sun, 29 Nov 2020 16:12:34 +0800
From:   Eryu Guan <guan@eryu.me>
To:     XiaoLi Feng <xifeng@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] common/rc: add _filter_scratch in _test_inode_flag
Message-ID: <20201129081234.GP3853@desktop>
References: <20201123062526.18465-1-xifeng@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123062526.18465-1-xifeng@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Nov 23, 2020 at 02:25:26PM +0800, Xiaoli Feng wrote:
> From: Xiaoli Feng <xifeng@redhat.com>
> 
> Avoid the invalid failure when the path of file include test flag.
> 
> Signed-off-by: Xiaoli Feng <xifeng@redhat.com>

Would you please elaborate this issue in more details? It seems your
SCRATCH_MNT contains a string that matches $flag so _test_inode_flag
returns a false positive. But that only fixes SCRATCH_MNT, what if
TEST_DIR contains the string as well?

Thanks,
Eryu

> ---
>  common/rc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index b5a504e0..04080331 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3069,7 +3069,7 @@ _test_inode_flag()
>  	local flag=$1
>  	local file=$2
>  
> -	if $XFS_IO_PROG -r -c 'lsattr -v' "$file" | grep -q "$flag" ; then
> +	if $XFS_IO_PROG -r -c 'lsattr -v' "$file" | _filter_scratch | grep -q "$flag" ; then
>  		return 0
>  	fi
>  	return 1
> -- 
> 2.18.1
