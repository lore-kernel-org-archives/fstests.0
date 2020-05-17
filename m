Return-Path: <SRS0=PZom=67=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5C1C433DF
	for <linux-fstests@archiver.kernel.org>; Sun, 17 May 2020 15:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 391C6206F4
	for <linux-fstests@archiver.kernel.org>; Sun, 17 May 2020 15:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgEQPup (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 17 May 2020 11:50:45 -0400
Received: from out20-86.mail.aliyun.com ([115.124.20.86]:41861 "EHLO
        out20-86.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbgEQPup (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 17 May 2020 11:50:45 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.09499673|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00894501-0.00174143-0.989314;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03311;MF=guan@eryu.me;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.HZscXO2_1589730630;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.HZscXO2_1589730630)
          by smtp.aliyun-inc.com(10.147.41.178);
          Sun, 17 May 2020 23:50:31 +0800
Date:   Sun, 17 May 2020 23:50:30 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Eric Sandeen <sandeen@redhat.com>
Cc:     fstests <fstests@vger.kernel.org>
Subject: Re: [PATCH 1/3] fstests: add _require_sysctl helper
Message-ID: <20200517155030.GC2704@desktop>
References: <99a3164b-ee00-113c-e0aa-41eab9633364@redhat.com>
 <2989bb14-5d77-5e91-d415-2a5bdfcff7a6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2989bb14-5d77-5e91-d415-2a5bdfcff7a6@redhat.com>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, May 05, 2020 at 03:17:38PM -0500, Eric Sandeen wrote:
> New _require_sysctl test to ensure that the sysctl we wish to test is
> available on the system.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---
> 
> diff --git a/common/rc b/common/rc
> index 2000bd9d..2734dbf6 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4208,6 +4208,12 @@ _require_bsd_process_accounting()
>  	$ACCTON_PROG off >> $seqres.full
>  }
>  
> +_require_sysctl()

IMHO, this name seems a bit confusing, it looks like it requires the
sysctl command itself. How about _require_sysctl_entry ?

> +{
> +	name=$1

Declare local var with 'local'.

> +	sysctl $name &>/dev/null || _notrun "$name sysctl unavailable"
> +}

And I think this patch could be folded into the first test that takes
use of it, i.e. patch 2.

Thanks,
Eryu

> +
>  init_rc
>  
>  ################################################################################
