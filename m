Return-Path: <SRS0=6UmA=54=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA49BC2BA2B
	for <linux-fstests@archiver.kernel.org>; Sun, 12 Apr 2020 11:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2EF9206E9
	for <linux-fstests@archiver.kernel.org>; Sun, 12 Apr 2020 11:15:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgDLLPG (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 12 Apr 2020 07:15:06 -0400
Received: from out20-50.mail.aliyun.com ([115.124.20.50]:48726 "EHLO
        out20-50.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbgDLLPG (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 12 Apr 2020 07:15:06 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2876137|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_social|0.0275014-0.00114789-0.971351;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03305;MF=guan@eryu.me;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.HFD76.4_1586690103;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.HFD76.4_1586690103)
          by smtp.aliyun-inc.com(10.147.40.26);
          Sun, 12 Apr 2020 19:15:04 +0800
Date:   Sun, 12 Apr 2020 19:16:01 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Vladimir Zapolskiy <vladimir@tuxera.com>
Cc:     Eryu Guan <guaneryu@gmail.com>, fstests@vger.kernel.org
Subject: Re: [PATCH 0/4] Assign a few generic tests to additional groups
Message-ID: <20200412111601.GA3923113@desktop>
References: <20200408135648.5824-1-vladimir@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408135648.5824-1-vladimir@tuxera.com>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Apr 08, 2020 at 04:56:44PM +0300, Vladimir Zapolskiy wrote:
> The rationale behind the proposed changes is to correct and improve
> granularity of some generic tests, so it becomes possible to control
> lists of run tests better, if there is given additional information
> about a test environment and tested filesystems.

Thanks for doing this! I think we could group these changes in a single
patch. Could you please resend with a single patch that does all the
group changes?

Thanks,
Eryu

> 
> Vladimir Zapolskiy (4):
>   Add generic/459 test to freeze group of tests
>   Add generic/482 test to thin group of tests
>   Add generic/529 test to acl group of tests
>   Add generic/530 test to shutdown group of tests
> 
>  tests/generic/group | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> -- 
> 2.25.1
> 
