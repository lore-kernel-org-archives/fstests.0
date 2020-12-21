Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC36C433E0
	for <linux-fstests@archiver.kernel.org>; Mon, 21 Dec 2020 03:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CF8A22EBE
	for <linux-fstests@archiver.kernel.org>; Mon, 21 Dec 2020 03:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbgLUDHq (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 20 Dec 2020 22:07:46 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:55646 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725782AbgLUDHp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 20 Dec 2020 22:07:45 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=eguan@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UJCWX6L_1608520022;
Received: from localhost(mailfrom:eguan@linux.alibaba.com fp:SMTPD_---0UJCWX6L_1608520022)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 21 Dec 2020 11:07:02 +0800
Date:   Mon, 21 Dec 2020 11:07:02 +0800
From:   Eryu Guan <eguan@linux.alibaba.com>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     Eryu Guan <guaneryu@gmail.com>, fstests@vger.kernel.org
Subject: Re: [ANNOUNCE] fstests: master branch updated to 0ad1c034838d
Message-ID: <20201221030702.GS80581@e18g06458.et15sqa>
References: <5fdf8221.1c69fb81.8c656.9b9d@mx.google.com>
 <5FDFF40A.7090702@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5FDFF40A.7090702@cn.fujitsu.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Dec 21, 2020 at 09:02:02AM +0800, Xiao Yang wrote:
> On 2020/12/21 0:55, Eryu Guan wrote:
> > Hi all,
> >
> > The master branch of the xfstests repository at:
> >
> > 	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> >
> > have just been updated. As usual, this update contains some new tests and
> > various bug fixes and improvements.
> >
> > New btrfs tests btrfs/154 and btrfs/227 all currently fail with latest kernel.
> > And xfs/513 has been updated to catch a xfs bug, but it should pass with latest
> > kenrel.
> >
> > Also, unionmount tests has been improved to run with custom overlay mount
> > options by assigning $OVERLAY_MOUNT_OPTIONS to UNIONMOUNT_MNTOPTIONS. You need
> > to update your local unionmount tests to latest to contain commit 95be14e
> > ("Allow user provided options with or without -o")
> >
> > Thanks,
> > Eryu
> >
> > The new head of the master branch is commit:
> >
> > 0ad1c034838d overlay: run unionmount tests with custom overlay mount options
> >
> > New commits:
> >
> > Amir Goldstein (1):
> >       [0ad1c034838d] overlay: run unionmount tests with custom overlay mount options
> >
> > Brian Foster (1):
> >       [62cf7ce77f4f] generic/563: use a loop device to avoid partition incompatibility
> >
> > Eric Biggers (1):
> >       [a225507009a3] generic: test for creating duplicate filenames in encrypted dir
> >
> > Feiyu Zhu (1):
> >       [0c5013c565b7] src/t_enospc.c: Fix an error for the loop initialization declaration
> >
> > Filipe Manana (1):
> >       [eabfcdfe9084] btrfs: test incremental send after removing a directory and all its files
> >
> > Kaixu Xia (1):
> >       [c2dd12732f31] xfs/513: fix the regression caused by mount option uqnoenforce
> >
> > Nikolay Borisov (1):
> >       [2a7406efecc2] btrfs: Update btrfs/215
> >
> > Ritesh Harjani (1):
> >       [72dc169b442e] generic: Add test to check for mounting a huge sparse dm device
> >
> > Su Yue (1):
> >       [a633d252e3c4] shared/032: add options for jffs2
> >
> > Xiao Yang (1):
> >       [90d76997831e] src/multi_open_unlink: Stop using attr_set
> Hi Eryu,
> 
> Only applying above patch broke the building of xfstests. :-)
> See my explanation on the original patch set.

Thanks for the heads-up! That's weird, I didn't see compile error in my
testing.. Will look into that.

Thanks,
Eryu
