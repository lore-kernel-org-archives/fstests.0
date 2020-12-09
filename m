Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B54BC433FE
	for <linux-fstests@archiver.kernel.org>; Wed,  9 Dec 2020 04:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3C3123A79
	for <linux-fstests@archiver.kernel.org>; Wed,  9 Dec 2020 04:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbgLIEXc (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 8 Dec 2020 23:23:32 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:47707 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726303AbgLIEXc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 8 Dec 2020 23:23:32 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=eguan@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UI0raxQ_1607487769;
Received: from localhost(mailfrom:eguan@linux.alibaba.com fp:SMTPD_---0UI0raxQ_1607487769)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 09 Dec 2020 12:22:49 +0800
Date:   Wed, 9 Dec 2020 12:22:49 +0800
From:   Eryu Guan <eguan@linux.alibaba.com>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>, guaneryu@gmail.com,
        fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] src/dmiperf: Stop using attr_setf
Message-ID: <20201209042249.GR80581@e18g06458.et15sqa>
References: <20201208064005.1187031-1-yangx.jy@cn.fujitsu.com>
 <20201208064005.1187031-2-yangx.jy@cn.fujitsu.com>
 <20201208182423.GI106271@magnolia>
 <5FD02476.2040909@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5FD02476.2040909@cn.fujitsu.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Dec 09, 2020 at 09:12:22AM +0800, Xiao Yang wrote:
> On 2020/12/9 2:24, Darrick J. Wong wrote:
> >On Tue, Dec 08, 2020 at 02:40:05PM +0800, Xiao Yang wrote:
> >>Avoid the following warning by replacing deprecated
> >>attr_setf with fsetxattr:
> >>---------------------------------------------------
> >>dmiperf.c:192:2: warning: 'attr_setf' is deprecated: Use fsetxattr instead [-Wdeprecated-declarations]
> >>---------------------------------------------------
> >I frankly wonder if it's time to kill the DMI tests since I've never
> >seen it and none of the functionality is upstream.
> Hi Darrick,
> 
> Agreed.  I wanted to remove it yesterday but I am not sure if it
> will be used in future.
> 
> I will remove it directly in v2 patch if Eryu or anyone also approves it.

I agree to kill the dmi tests, because even xfs maintain wants to kill
them :)

Thanks,
Eryu
