Return-Path: <SRS0=PZom=67=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EE0C433DF
	for <linux-fstests@archiver.kernel.org>; Sun, 17 May 2020 16:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78E31206D8
	for <linux-fstests@archiver.kernel.org>; Sun, 17 May 2020 16:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbgEQQMN (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 17 May 2020 12:12:13 -0400
Received: from out20-98.mail.aliyun.com ([115.124.20.98]:41787 "EHLO
        out20-98.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728033AbgEQQMM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 17 May 2020 12:12:12 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1174302|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.01362-0.0129606-0.973419;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03295;MF=guan@eryu.me;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.HZsZ-L2_1589731929;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.HZsZ-L2_1589731929)
          by smtp.aliyun-inc.com(10.147.43.230);
          Mon, 18 May 2020 00:12:10 +0800
Date:   Mon, 18 May 2020 00:12:09 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Eric Sandeen <sandeen@sandeen.net>
Cc:     fstests <fstests@vger.kernel.org>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2/2 V2] fstests: add _require_mknod
Message-ID: <20200517161209.GF2704@desktop>
References: <07e0ecad-11fd-9bc2-7e49-9470f7511b27@sandeen.net>
 <f7caf338-26ec-8a6c-4a91-4a037c12440e@sandeen.net>
 <42fcddeb-7274-bf41-3475-16eae0f78e92@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42fcddeb-7274-bf41-3475-16eae0f78e92@sandeen.net>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, May 08, 2020 at 09:23:42AM -0500, Eric Sandeen wrote:
> Add a _require_mknod test so that filesystems with no ->mknod
> operation will _notrun instead of fail.
> 
> Signed-off-by: Eric Sandeen <sandeen@sandeen.net>
> ---
> 
> V2 trim the long line, sorry.
> 
> diff --git a/common/rc b/common/rc
> index 2734dbf6..b50a4294 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4214,6 +4215,13 @@ _require_sysctl()
>  	sysctl $name &>/dev/null || _notrun "$name sysctl unavailable"
>  }
>  
> +_require_mknod()
> +{
> +	mknod $TEST_DIR/$tmp.null c 1 3 \

$tmp points to /tmp/$$, so this mknod is trying to make node at

	$TEST_DIR//tmp/<pid>

which will always fail.

Use $TEST_DIR/$seq.null instead?

And I don't see any callers of this require rule, shouldn't existing
tests that use mknod be updated to require this rule?

Thanks,
Eryu

> +		|| _notrun "$FSTYP does not support mknod/mkfifo"
> +	rm -f $TEST_DIR/$tmp.null
> +}
> +
>  init_rc
>  
>  ################################################################################
> 
