Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E61C433E0
	for <linux-fstests@archiver.kernel.org>; Sun, 14 Mar 2021 16:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D558764EB6
	for <linux-fstests@archiver.kernel.org>; Sun, 14 Mar 2021 16:00:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234138AbhCNP7c (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 14 Mar 2021 11:59:32 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:51219 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233966AbhCNP7D (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 14 Mar 2021 11:59:03 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R451e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=eguan@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0URrT5Bz_1615737539;
Received: from localhost(mailfrom:eguan@linux.alibaba.com fp:SMTPD_---0URrT5Bz_1615737539)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 14 Mar 2021 23:59:00 +0800
Date:   Sun, 14 Mar 2021 23:58:59 +0800
From:   Eryu Guan <eguan@linux.alibaba.com>
To:     Eryu Guan <guan@eryu.me>, fstests@vger.kernel.org
Subject: Re: [PATCH] common/rc: specifically make new xfs in _test_mkfs
Message-ID: <20210314155859.GA64722@e18g06458.et15sqa>
References: <20210311121213.1348303-1-zlang@redhat.com>
 <YE32jkUjOxc0pc1Z@desktop>
 <20210314143458.GM3499219@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210314143458.GM3499219@localhost.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Mar 14, 2021 at 10:34:59PM +0800, Zorro Lang wrote:
> On Sun, Mar 14, 2021 at 07:42:06PM +0800, Eryu Guan wrote:
> > On Thu, Mar 11, 2021 at 08:12:13PM +0800, Zorro Lang wrote:
> > > When we test different filesystems with different sections in config
> > > file, always hit below failure:
> > >    ...
> > >    our local _test_mkfs routine ...
> > >    mkfs.xfs: /dev/vdb1 appears to contain an existing filesystem (xfs)
> > >    mkfs.xfs: Use the -f option to force overwrite.
> > >    check: failed to mkfs $TEST_DEV using specified options
> > >    ...
> > > 
> > > To fix this problem, change the _test_mkfs to deal with xfs creation
> > > properly. Due to xfstests uses _test_mkfs rarely, currently only in
> > > check program, so I don't intend to write a whole new series of
> > > _test_mkfs_xfs_* functions likes what _scratch_mkfs_xfs_* does.
> > > 
> > > Reported-by: Carlos Maiolino <cmaiolino@redhat.com>
> > > Signed-off-by: Zorro Lang <zlang@redhat.com>
> > 
> > I also have defined different test sections in config file to test
> > different filesysms, but I didn't hit this failure. And it turns out
> > that I have "-f" in MKFS_OPTIONS, e.g.
> > 
> > 	[xfs_prjquota_crc]
> > 	FSTYP=xfs
> > 	MKFS_OPTIONS="-f -b size=4k -m crc=1"
> > 	MOUNT_OPTIONS="-o prjquota"
> > 
> > 	[xfs_allquota_reflink]
> > 	FSTYP=xfs
> > 	MKFS_OPTIONS="-f -b size=4k -m crc=1,reflink=1,rmapbt=1"
> > 	MOUNT_OPTIONS="-o usrquota,grpquota,prjquota"
> 
> Yes, set "-f" in MKFS_OPTIONS will help.
> 
> BTW, according to below logic:
> 
>     if $RECREATE_TEST_DEV || [ "$OLD_FSTYP" != "$FSTYP" ]; then
>         ...
>         if ! _test_mkfs >$tmp.err 2>&1
> 
> Your TEST_DEV might not be re-created, except you set RECREATE_TEST_DEV=ture.

Yes, I also have RECREATE_TEST_DEV=true set in my local.config

> I hit this failure due to I set:
> [ext4]
> FSTYP=ext4
> ...
> 
> [xfs]
> FSTYP=xfs
> ...
> 
> And ext4 use "-F" by default, but xfs doesn't.
> 
>     ext2|ext3|ext4)
>         $MKFS_PROG -t $FSTYP -- -F $MKFS_OPTIONS $* $TEST_DEV
> 
> This patch isn't necessary, due to there's workaround. I'm fine if you'd like
> to Nack it.

Agreed, not taken :)

Thanks,
Eryu
