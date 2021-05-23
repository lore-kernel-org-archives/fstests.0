Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6E9C4707A
	for <linux-fstests@archiver.kernel.org>; Sun, 23 May 2021 15:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 555E061244
	for <linux-fstests@archiver.kernel.org>; Sun, 23 May 2021 15:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbhEWPKF (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 23 May 2021 11:10:05 -0400
Received: from out20-49.mail.aliyun.com ([115.124.20.49]:48758 "EHLO
        out20-49.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbhEWPKF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 23 May 2021 11:10:05 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08214866|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00266964-0.000880458-0.99645;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047209;MF=guan@eryu.me;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.KHcBxvx_1621782516;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.KHcBxvx_1621782516)
          by smtp.aliyun-inc.com(10.147.41.187);
          Sun, 23 May 2021 23:08:37 +0800
Date:   Sun, 23 May 2021 23:08:36 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Christian Brauner <brauner@kernel.org>
Cc:     fstests@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH 0/7] idmapped mounts: extend testsuite and fixes
Message-ID: <YKpv9D1z2ox8sZte@desktop>
References: <20210507150100.968659-1-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210507150100.968659-1-brauner@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, May 07, 2021 at 05:00:53PM +0200, Christian Brauner wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
> 
> Hey,
> 
> This introduces two new idmapped mount tests.
> The first test extends the v3 fscaps tests for idmapped mounts.
> The second test verified that idmapped mounts behave correctly when
> nested user namespaces are used. In essence it creates a fairly complex
> nested user namespace hierarchy and then tests whether file ownership
> changes are correctly reflected in all idmapped mounts as seen from all
> those user namespaces.
> In addition this fixes a couple of minor things and shares more code
> between the mount-idmapped and idmapped-mounts binaries.

I applied the first 3 patches for this update. And I think patch 4 and 7
may need some rework. Patch 5 and 6 just didn't apply without patch 4.

Thanks,
Eryu

> 
> Thanks!
> Christian
> 
> Christian Brauner (7):
>   idmapped-mounts: remove unused set_cloexec() helper
>   idmapped-mounts: add missing newline to print_r()
>   idmapped-mounts: split out run_test() function
>   generic/637: add fscaps regression test
>   idmapped-mounts: refactor helpers
>   idmapped-mounts: add nested userns creation helpers
>   generic/638: add nested user namespace tests
> 
>  .gitignore                            |   2 +
>  src/idmapped-mounts/Makefile          |  16 +-
>  src/idmapped-mounts/idmapped-mounts.c | 931 ++++++++++++++++++++++++--
>  src/idmapped-mounts/mount-idmapped.c  | 228 +------
>  src/idmapped-mounts/utils.c           | 359 ++++++++--
>  src/idmapped-mounts/utils.h           | 102 ++-
>  tests/generic/637                     |  42 ++
>  tests/generic/637.out                 |   2 +
>  tests/generic/638                     |  42 ++
>  tests/generic/638.out                 |   2 +
>  tests/generic/group                   |   2 +
>  11 files changed, 1397 insertions(+), 331 deletions(-)
>  create mode 100755 tests/generic/637
>  create mode 100644 tests/generic/637.out
>  create mode 100755 tests/generic/638
>  create mode 100644 tests/generic/638.out
> 
> 
> base-commit: 40818883aecd19581a71cc096d07eb9106c11b10
> -- 
> 2.27.0
