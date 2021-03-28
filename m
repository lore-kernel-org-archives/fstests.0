Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0C4C433DB
	for <linux-fstests@archiver.kernel.org>; Sun, 28 Mar 2021 15:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B9F961976
	for <linux-fstests@archiver.kernel.org>; Sun, 28 Mar 2021 15:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbhC1PlO (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 28 Mar 2021 11:41:14 -0400
Received: from out20-50.mail.aliyun.com ([115.124.20.50]:47278 "EHLO
        out20-50.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbhC1PlB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 28 Mar 2021 11:41:01 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1461262|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0260457-0.000735599-0.973219;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047199;MF=guan@eryu.me;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.JrZUze9_1616946058;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.JrZUze9_1616946058)
          by smtp.aliyun-inc.com(10.147.40.233);
          Sun, 28 Mar 2021 23:40:59 +0800
Date:   Sun, 28 Mar 2021 23:40:58 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Pavel Reichl <preichl@redhat.com>
Cc:     fstests@vger.kernel.org, zlang@redhat.com, xzhou@redhat.com
Subject: Re: [PATCH 4/5] generic/554: hide permision warning on exfat
Message-ID: <YGCjirErrfGsmcGZ@desktop>
References: <20210326154134.309159-1-preichl@redhat.com>
 <20210326154134.309159-5-preichl@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210326154134.309159-5-preichl@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Mar 26, 2021 at 04:41:33PM +0100, Pavel Reichl wrote:
> Signed-off-by: Pavel Reichl <preichl@redhat.com>
> ---
>  tests/generic/554 | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/generic/554 b/tests/generic/554
> index fa4f97d2..365628e2 100755
> --- a/tests/generic/554
> +++ b/tests/generic/554
> @@ -46,7 +46,15 @@ $XFS_IO_PROG -f -c "pwrite -S 0x61 0 128k" $SCRATCH_MNT/file >> $seqres.full 2>&
>  
>  echo swap files return ETXTBUSY
>  _format_swapfile $SCRATCH_MNT/swapfile 16m
> -swapon $SCRATCH_MNT/swapfile
> +if [ "$FSTYP" = "exfat" ]; then
> +	# exfat does not support posix file permisions, so warning is
> +	# to be expected
> +	swapon $SCRATCH_MNT/swapfile 2>&1 |\
> +		grep -v 'insecure permission' >> $seqres.full
> +else
> +	swapon $SCRATCH_MNT/swapfile
> +fi

Introduce a new helper like _format_swapfile and do the check there?

Thanks,
Eryu

> +
>  $XFS_IO_PROG -f -c "copy_range -l 32k $SCRATCH_MNT/file" $SCRATCH_MNT/swapfile
>  swapoff $SCRATCH_MNT/swapfile
>  
> -- 
> 2.30.2
