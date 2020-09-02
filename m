Return-Path: <SRS0=Km02=CL=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C96DC433E7
	for <linux-fstests@archiver.kernel.org>; Wed,  2 Sep 2020 15:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 308FF204FD
	for <linux-fstests@archiver.kernel.org>; Wed,  2 Sep 2020 15:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgIBPtQ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:49:16 -0400
Received: from out20-50.mail.aliyun.com ([115.124.20.50]:35782 "EHLO
        out20-50.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbgIBPtN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 2 Sep 2020 11:49:13 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07754757|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_social|0.00410682-0.00142377-0.994469;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03307;MF=guan@eryu.me;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.IRsBH2L_1599061740;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.IRsBH2L_1599061740)
          by smtp.aliyun-inc.com(10.147.40.200);
          Wed, 02 Sep 2020 23:49:01 +0800
Date:   Wed, 2 Sep 2020 23:48:55 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Hou Tao <houtao1@huawei.com>
Cc:     richard@nod.at, guaneryu@gmail.com, yuchao0@huawei.com,
        fstests@vger.kernel.org
Subject: Re: [PATCH v2 1/2] generic: add test for race between listxattr and
 setxatr
Message-ID: <20200902154855.GF3853@desktop>
References: <364596a1-c9bb-3a10-a132-0f43907c2241@huawei.com>
 <20200822114132.61227-1-houtao1@huawei.com>
 <20200830162322.GD3853@desktop>
 <c41ee2c2-f08f-be1f-b7a3-5cc52b49d29a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c41ee2c2-f08f-be1f-b7a3-5cc52b49d29a@huawei.com>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Aug 31, 2020 at 11:01:05AM +0800, Hou Tao wrote:
> Hi,
> 
> On 2020/8/31 0:23, Eryu Guan wrote:
> > On Sat, Aug 22, 2020 at 07:41:32PM +0800, Hou Tao wrote:
> >> Add reproducer for a bug on ubifs where listxattr() copies
> >> the newly created xattr names regardless of the remaining
> >> buffer size, fails the assertion of used buffer size,
> >> and may corrupt buffer memory.
> >>
> >> Signed-off-by: Hou Tao <houtao1@huawei.com>
> >> ---
> >> v2: accommodate f2fs by reducing the number of created xattrs for f2fs
> > 
> > Thanks for the test and revision! Is there a fix available for the ubifs
> > bug? If so would you please mention the kernel commit ID in commit log
> > as well?
> > 
> The fixes [1] have not been reviewed yet, so we may need to hold on until the fixes get merged ?
> 
> [1]: https://lore.kernel.org/linux-mtd/20200630130438.141649-1-houtao1@huawei.com/

It's better to have the fixes merged first, but we do merge tests before
the fixes landed in. But I'd like to see at least some reviews/acks on
the fixes first.

Thanks,
Eryu
