Return-Path: <SRS0=cgbt=IF=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DE5C433E0
	for <linux-fstests@archiver.kernel.org>; Sun,  7 Mar 2021 16:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBAE0650D0
	for <linux-fstests@archiver.kernel.org>; Sun,  7 Mar 2021 16:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbhCGQAY (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 7 Mar 2021 11:00:24 -0500
Received: from out20-1.mail.aliyun.com ([115.124.20.1]:44170 "EHLO
        out20-1.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbhCGQAS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 7 Mar 2021 11:00:18 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.101928|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.11404-0.000807312-0.885152;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047201;MF=guan@eryu.me;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.JhdlJm-_1615132816;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.JhdlJm-_1615132816)
          by smtp.aliyun-inc.com(10.147.40.7);
          Mon, 08 Mar 2021 00:00:16 +0800
Date:   Mon, 8 Mar 2021 00:00:16 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     fstests@vger.kernel.org, anju@linux.vnet.ibm.com
Subject: Re: [PATCH 2/3] common/rc: Add _require_get_hugepagesize and fix
 _require_label_get_max
Message-ID: <YET4kDkPZ+OaAQ4S@desktop>
References: <cover.1612951443.git.riteshh@linux.ibm.com>
 <05dbc4b37d77e03bc288feb07815f737efbf2abd.1612951443.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05dbc4b37d77e03bc288feb07815f737efbf2abd.1612951443.git.riteshh@linux.ibm.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Feb 11, 2021 at 09:01:45AM +0530, Ritesh Harjani wrote:
> _notrun executed from a subshell $(cmd) won't exit it's parent.
> Hence _require_*** functions shouldn't have below statements.
> 	dummy=$(_label_get_max)
> Also add a function _require_get_hugepagesize(), since it seems the
> intention of _get_hugepagesize() is to also '_notrun' when the hugepagesize
> is not a valid number.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
>  common/rc | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index 649b1cfd884a..1831714198af 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -175,6 +175,12 @@ _get_hugepagesize()
>  	echo $((hugepgsz * 1024))
>  }
> 
> +_require_get_hugepagesize()
> +{
> +	# Just a dummy for _notrun if hugepagesize is not supported
> +	_get_hugepagesize
> +}
> +

I think this hunk should be moved to patch 3.

Otherwise patch looks fine to me. And I applied patch 1 for next update,
thanks!

Eryu

>  _mount()
>  {
>      $MOUNT_PROG `_mount_ops_filter $*`
> @@ -4250,7 +4256,7 @@ _label_get_max()
>  _require_label_get_max()
>  {
>  	# Just call _label_get_max which will notrun if appropriate
> -	dummy=$(_label_get_max)
> +	_label_get_max
>  }
> 
>  _dmsetup_remove()
> --
