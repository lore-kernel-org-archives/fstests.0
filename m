Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5683DC433DB
	for <linux-fstests@archiver.kernel.org>; Tue,  9 Mar 2021 04:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 228416527D
	for <linux-fstests@archiver.kernel.org>; Tue,  9 Mar 2021 04:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbhCIECC (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 8 Mar 2021 23:02:02 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:40646 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229611AbhCIEBb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 8 Mar 2021 23:01:31 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=eguan@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UR.n8Jq_1615262479;
Received: from localhost(mailfrom:eguan@linux.alibaba.com fp:SMTPD_---0UR.n8Jq_1615262479)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 09 Mar 2021 12:01:19 +0800
Date:   Tue, 9 Mar 2021 12:01:19 +0800
From:   Eryu Guan <eguan@linux.alibaba.com>
To:     guan@eryu.me, fstests@vger.kernel.org
Subject: Re: [PATCH v2] xfstests: rename RENAME_WHITEOUT test on fs no enough
 sapce
Message-ID: <20210309040119.GF96449@e18g06458.et15sqa>
References: <20210308134327.345579-1-zlang@redhat.com>
 <20210309031129.GD3499219@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210309031129.GD3499219@localhost.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Mar 09, 2021 at 11:11:29AM +0800, Zorro Lang wrote:
> On Mon, Mar 08, 2021 at 09:43:27PM +0800, Zorro Lang wrote:
> > This's a regression test for linux 6b4b8e6b4ad8 ("ext4: fix bug for
> > rename with RENAME_WHITEOUT"). Rename a file with RENAME_WHITEOUT
> > flag might cause corruption when there's not enough space to
> > complete this renaming operation.
> > 
> > Signed-off-by: Zorro Lang <zlang@redhat.com>
> > Signed-off-by: Sun Ke <sunke32@huawei.com>
> > ---
> 
> Hi Eryu,
> 
> Sorry I made a typo mistake on the patch subject, The 'sapce' should be 'space'.
> If you don't mind, please help to modify it when you merge this patch. Or feel

Sure, no problem :)

Thanks,
Eryu
