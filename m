Return-Path: <SRS0=Jk7F=BU=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD540C433DF
	for <linux-fstests@archiver.kernel.org>; Mon, 10 Aug 2020 12:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A727120729
	for <linux-fstests@archiver.kernel.org>; Mon, 10 Aug 2020 12:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbgHJMHQ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 10 Aug 2020 08:07:16 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:4924 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726141AbgHJMHP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 10 Aug 2020 08:07:15 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R281e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=eguan@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0U5N3xms_1597061233;
Received: from localhost(mailfrom:eguan@linux.alibaba.com fp:SMTPD_---0U5N3xms_1597061233)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 10 Aug 2020 20:07:14 +0800
Date:   Mon, 10 Aug 2020 20:07:13 +0800
From:   Eryu Guan <eguan@linux.alibaba.com>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     Eryu Guan <guaneryu@gmail.com>, fstests@vger.kernel.org
Subject: Re: [ANNOUNCE] fstests: master branch updated to 59d1f998fd61
Message-ID: <20200810120713.GD80581@e18g06458.et15sqa>
References: <5f3030bc.1c69fb81.7519b.378d@mx.google.com>
 <5F312B85.5040002@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5F312B85.5040002@cn.fujitsu.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Aug 10, 2020 at 07:12:05PM +0800, Xiao Yang wrote:
> On 2020/8/10 1:21, Eryu Guan wrote:
> > Hi all,
> >
> > The master branch of the xfstests repository at:
> >
> > 	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> >
> > have just been updated. The most notable change is the DAX patchset from Xiao
> > Yang, which update & add new tests to test the new DAX mount behavior. Many
> > thanks to Xiao Yang for the patchset, and to Ira Weiny and Darrick J. Wong for
> > reviewing the patches!
> Hi Eryu,
> 
> Thank you for applying my patch set. :-)
> In addition, I also updated some helpers related to new dax option by
> another
> separate patch set[1] and hope you can apply it in next update.
> [1]:
> https://www.spinics.net/lists/fstests/msg14360.html
> https://www.spinics.net/lists/fstests/msg14359.html
> P.S. The patch set has been reviewed by Ira Weiny.

Thanks for the heads-up! I thought you've folded all dax-related patches
in the big patchset.. Would you please resend above two patches? with
Ira Weiny's reviewed-by tag?

Thanks,
Eryu
