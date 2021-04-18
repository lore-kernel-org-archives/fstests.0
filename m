Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60954C433ED
	for <linux-fstests@archiver.kernel.org>; Sun, 18 Apr 2021 12:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36333610FC
	for <linux-fstests@archiver.kernel.org>; Sun, 18 Apr 2021 12:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbhDRMug (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 18 Apr 2021 08:50:36 -0400
Received: from out20-85.mail.aliyun.com ([115.124.20.85]:45164 "EHLO
        out20-85.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbhDRMug (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 18 Apr 2021 08:50:36 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1175063|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.139472-0.00706636-0.853462;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047192;MF=guan@eryu.me;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.K.qGSwQ_1618750206;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.K.qGSwQ_1618750206)
          by smtp.aliyun-inc.com(10.147.42.22);
          Sun, 18 Apr 2021 20:50:06 +0800
Date:   Sun, 18 Apr 2021 20:50:06 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Pavel Reichl <preichl@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v3 1/4] common/rc: Add _require_{chown,chmod}()
Message-ID: <YHwq/hmeTmGktR/G@desktop>
References: <20210415094905.61853-1-preichl@redhat.com>
 <20210415094905.61853-2-preichl@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210415094905.61853-2-preichl@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Apr 15, 2021 at 11:49:02AM +0200, Pavel Reichl wrote:
> Add helper functions that ensure that test is only executed on file
> systems that implement chown, chmod and symbolic links.
> 
> Fixed test are: generic/{87,88,125,126,128,193,314,317,355,597,598}
> 
> Signed-off-by: Pavel Reichl <preichl@redhat.com>
> ---
>  common/rc         | 23 +++++++++++++++++++++++
>  tests/generic/087 |  1 +
>  tests/generic/088 |  1 +
>  tests/generic/125 |  1 +
>  tests/generic/126 |  1 +
>  tests/generic/128 |  1 +
>  tests/generic/193 |  1 +
>  tests/generic/314 |  1 +
>  tests/generic/317 |  1 +
>  tests/generic/355 |  1 +
>  tests/generic/597 |  1 +
>  tests/generic/598 |  1 +
>  12 files changed, 34 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 23f86ce6..be292aaf 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2115,6 +2115,29 @@ _require_user()
>      [ "$?" == "0" ] || _notrun "$qa_user cannot execute commands."
>  }
>  
> +# check for a chown support
> +#
> +_require_chown()
> +{
> +	rnd_uid=4242
> +
> +	_require_test
> +
> +	local file="$TEST_DIR/chown_testfile"
> +	touch $file
> +	chown ${rnd_uid}:${rnd_uid} $file >/dev/null 2>&1 \
> +		|| _notrun "chown is not supported ${FSTYP}"
> +	rm -f $file
> +}
> +
> +
> +# check for a chmod support
> +#
> +_require_chmod()
> +{
> +	_require_chown

It's not clear to me why _require_chown also works for _require_chmod,
other than actually doing chmod test. Some comments would be good.

Thanks,
Eryu

P.S. I've applied other patches in this patchset, thanks for the fixes!
