Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD59C433DB
	for <linux-fstests@archiver.kernel.org>; Sun,  7 Feb 2021 16:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D8BF64E3A
	for <linux-fstests@archiver.kernel.org>; Sun,  7 Feb 2021 16:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbhBGQby (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 7 Feb 2021 11:31:54 -0500
Received: from out20-63.mail.aliyun.com ([115.124.20.63]:45124 "EHLO
        out20-63.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhBGQbx (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 7 Feb 2021 11:31:53 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1743749|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0461635-0.00138417-0.952452;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047199;MF=guan@eryu.me;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.JWTB02X_1612715467;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.JWTB02X_1612715467)
          by smtp.aliyun-inc.com(10.147.40.233);
          Mon, 08 Feb 2021 00:31:07 +0800
Date:   Mon, 8 Feb 2021 00:31:07 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic/233,270: unlimit the max locked memory size for
 io_uring
Message-ID: <20210207163107.GI2350@desktop>
References: <20210127072143.247849-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210127072143.247849-1-zlang@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jan 27, 2021 at 03:21:43PM +0800, Zorro Lang wrote:
> The ltp/fsstress always fails on io_uring_queue_init() by returnning
> ENOMEM. Due to io_uring accounts memory it needs under the rlimit
> memlocked option, which can be quite low on some setups, especially
> on 64K pagesize machine. root isn't under this restriction, but
> regular users are. So only g/233 and g/270 which use $qa_user to run
> fsstress are failed.
> 
> To avoid this failure, set max locked memory to unlimited before doing
> fsstress, then restore it after test done.

I'm wondering if we could just set 'ulimit -l unlimited' in check? so
all tests inherits the unlimited mlock setting. For root, this doesn't
change anything, but command runs by regular user could get unlimited
lockable memory. And new tests won't have to worry about running
fsstress/fsx as $qa_user.

Thanks,
Eryu
