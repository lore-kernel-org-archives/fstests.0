Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED405C433DB
	for <linux-fstests@archiver.kernel.org>; Sun, 28 Mar 2021 15:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4D1C61976
	for <linux-fstests@archiver.kernel.org>; Sun, 28 Mar 2021 15:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhC1Pjd (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 28 Mar 2021 11:39:33 -0400
Received: from out20-85.mail.aliyun.com ([115.124.20.85]:60857 "EHLO
        out20-85.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbhC1PjB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 28 Mar 2021 11:39:01 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.09651522|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0572433-0.00121186-0.941545;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047211;MF=guan@eryu.me;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.JrZGd-8_1616945933;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.JrZGd-8_1616945933)
          by smtp.aliyun-inc.com(10.147.42.135);
          Sun, 28 Mar 2021 23:38:54 +0800
Date:   Sun, 28 Mar 2021 23:38:53 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Pavel Reichl <preichl@redhat.com>
Cc:     fstests@vger.kernel.org, zlang@redhat.com, xzhou@redhat.com
Subject: Re: [PATCH 1/5] common: Add _require_{chown,chmod}()
Message-ID: <YGCjDa1NY2aZB9x+@desktop>
References: <20210326154134.309159-1-preichl@redhat.com>
 <20210326154134.309159-2-preichl@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210326154134.309159-2-preichl@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Mar 26, 2021 at 04:41:30PM +0100, Pavel Reichl wrote:
> Add helper function that ensures that test is only executed on file
> systems that implement chown and chmod.
> 
> Signed-off-by: Pavel Reichl <preichl@redhat.com>

I think patch 1 and patch 2 could be folded into one patch, introduce
new helpers and use them in the same patch.

Thanks,
Eryu

> ---
>  common/rc | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 0ce3cb0d..b18d37fd 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2129,6 +2129,24 @@ _require_user()
>      [ "$?" == "0" ] || _notrun "$qa_user cannot execute commands."
>  }
>  
> +# check for a chown support
> +#
> +_require_chown()
> +{
> +	if [ "$FSTYP" = "exfat" ]; then
> +		_notrun "chown is not supported on $FSTYP"
> +	fi
> +}
> +
> +# check for a chmod support
> +#
> +_require_chmod()
> +{
> +	if [ "$FSTYP" = "exfat" ]; then
> +		_notrun "chmod is not supported on $FSTYP"
> +	fi
> +}
> +
>  # check for a group on the machine, fsgqa as default
>  #
>  _require_group()
> -- 
> 2.30.2
