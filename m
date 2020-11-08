Return-Path: <SRS0=C4aD=EO=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256FAC388F9
	for <linux-fstests@archiver.kernel.org>; Sun,  8 Nov 2020 06:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D269820719
	for <linux-fstests@archiver.kernel.org>; Sun,  8 Nov 2020 06:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbgKHGhG (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 8 Nov 2020 01:37:06 -0500
Received: from out20-1.mail.aliyun.com ([115.124.20.1]:53873 "EHLO
        out20-1.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgKHGhG (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 8 Nov 2020 01:37:06 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.213337|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_news_journal|0.0140567-0.00171047-0.984233;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047211;MF=guan@eryu.me;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.Iu0Klfi_1604817421;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.Iu0Klfi_1604817421)
          by smtp.aliyun-inc.com(10.147.43.230);
          Sun, 08 Nov 2020 14:37:02 +0800
Date:   Sun, 8 Nov 2020 14:37:01 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] common/rc: allow setting $SCRATCH_FS_MOUNT_OPTS
Message-ID: <20201108063701.GG3853@desktop>
References: <20201105150936.410407-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105150936.410407-1-jlayton@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Nov 05, 2020 at 10:09:36AM -0500, Jeff Layton wrote:
> We already have a $TEST_FS_MOUNT_OPTS which gets applied only to the
> test mount, but we don't have a corresponding variable for the scratch
> mount. Add one.

MOUNT_OPTIONS is used for the scratch mount, and
_common_dev_mount_options includes it. Would you please confirm if that
works for you?

Thanks,
Eryu

> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  common/rc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index 65ebfe201139..23874d1e5b8e 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -308,7 +308,7 @@ _scratch_mount_options()
>  {
>  	_scratch_options mount
>  
> -	echo `_common_dev_mount_options $*` $SCRATCH_OPTIONS \
> +	echo `_common_dev_mount_options $*` $SCRATCH_OPTIONS $SCRATCH_FS_MOUNT_OPTS \
>  					$SCRATCH_DEV $SCRATCH_MNT
>  }
>  
> -- 
> 2.28.0
