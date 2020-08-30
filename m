Return-Path: <SRS0=JoHA=CI=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5160BC433E6
	for <linux-fstests@archiver.kernel.org>; Sun, 30 Aug 2020 16:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EB2D2076D
	for <linux-fstests@archiver.kernel.org>; Sun, 30 Aug 2020 16:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbgH3Q0D (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 30 Aug 2020 12:26:03 -0400
Received: from out20-39.mail.aliyun.com ([115.124.20.39]:48860 "EHLO
        out20-39.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbgH3Q0D (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 30 Aug 2020 12:26:03 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2278793|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0121892-0.00357131-0.98424;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03293;MF=guan@eryu.me;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.IQDipto_1598804759;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.IQDipto_1598804759)
          by smtp.aliyun-inc.com(10.147.41.137);
          Mon, 31 Aug 2020 00:25:59 +0800
Date:   Mon, 31 Aug 2020 00:25:59 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     guaneryu@gmail.com, fstests@vger.kernel.org
Subject: Re: [PATCH] common/config: Allow sections names to contain hyphen
Message-ID: <20200830162559.GE3853@desktop>
References: <20200625123744.17812-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200625123744.17812-1-nborisov@suse.com>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jun 25, 2020 at 03:37:44PM +0300, Nikolay Borisov wrote:
> Current regular expression in get_config_sections allows section names
> to consist of alphanumeric character and underscore. Extend it to
> also allow the hyphen '-' character.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Sorry, this patch fell off my radar.. Applied!

Thanks,
Eryu

> ---
>  common/config | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/config b/common/config
> index 8023273da115..63d486125a76 100644
> --- a/common/config
> +++ b/common/config
> @@ -449,7 +449,7 @@ known_hosts()
>  # in the section name otherwise the section will not be resognised.
>  # Section name must be contained between square brackets.
>  get_config_sections() {
> -	sed -n -e "s/^\[\([[:alnum:]_]*\)\]/\1/p" < $1
> +	sed -n -e "s/^\[\([[:alnum:]_-]*\)\]/\1/p" < $1
>  }
>  
>  if [ ! -f "$HOST_OPTIONS" ]; then
> -- 
> 2.17.1
> 
