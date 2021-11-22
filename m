Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3F7C433F5
	for <linux-fstests@archiver.kernel.org>; Mon, 22 Nov 2021 10:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235267AbhKVKVx (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 22 Nov 2021 05:21:53 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:60469 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234129AbhKVKVx (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 22 Nov 2021 05:21:53 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=eguan@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Uxg1LE6_1637576325;
Received: from localhost(mailfrom:eguan@linux.alibaba.com fp:SMTPD_---0Uxg1LE6_1637576325)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 22 Nov 2021 18:18:45 +0800
Date:   Mon, 22 Nov 2021 18:18:45 +0800
From:   Eryu Guan <eguan@linux.alibaba.com>
To:     cmaiolino@redhat.com
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH V2 0/2] xfstests: Fix generic/643 on ext2 and ext3
Message-ID: <20211122101845.GZ60846@e18g06458.et15sqa>
References: <20211110124119.43974-1-cmaiolino@redhat.com>
 <20211122084917.qki4cortq5gumdzw@andromeda.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122084917.qki4cortq5gumdzw@andromeda.lan>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Nov 22, 2021 at 09:49:17AM +0100, Carlos Maiolino wrote:
> Ping.

I think this patchset has been applied and pushed to upstream in last
week's update. Would you please check if you could see them after
pulling the latest update?

Thanks,
Eryu

> 
> > 
> > This is the 2nd version of this series to fix test g/643.
> > 
> > This version ensures _format_swapfile helper returns the swap size in bytes
> > every time (previous version returned it in a different unit, depending on the
> > swap's size) and updates remaining users of _format_swapfile() to discard its
> > return value.
> > 
> > This also slightly change patch 2, making g/643 to use swapon to retrieve swap
> > size (more details in the patch's description).
> > 
> > Original cover-letter below.
> > 
> > 
> > Currently, generic/643 test fails on ext2 and ext3 filesystems when using 1k
> > block sizes.
> > The failure itself happens due the mapping of indirect blocks to iomap extents
> > and the aligment constraints imposed by iomap. Specific details are described in
> > patch 2.
> > 
> > To fix the test, I modified it to use the swapfile size described in the swap
> > header (patch 2), and to retrieve such information, at mkswap time, I modified
> > the _format_swapfile() function, and I believe such modification requires its own
> > patch (patch 1).
> > 
> > These changes have also been tested on 64k pages (both on arm and PPC) to ensure
> > it doesn't break the test on such architectures.
> > 
> > Carlos Maiolino (2):
> >   common/rc: Enable _format_swapfile to return the swap size
> >   generic/643: Fix for 1k block sizes for ext2 and ext3
> > 
> >  common/rc         | 10 +++++++---
> >  tests/btrfs/173   |  2 +-
> >  tests/btrfs/174   |  2 +-
> >  tests/btrfs/175   |  4 ++--
> >  tests/btrfs/176   |  2 +-
> >  tests/btrfs/177   |  2 +-
> >  tests/generic/356 |  2 +-
> >  tests/generic/357 |  2 +-
> >  tests/generic/493 |  2 +-
> >  tests/generic/494 |  2 +-
> >  tests/generic/554 |  2 +-
> >  tests/generic/569 |  2 +-
> >  tests/generic/643 | 27 +++++++++------------------
> >  13 files changed, 28 insertions(+), 33 deletions(-)
> > 
> > -- 
> > 2.31.1
> > 
> 
> -- 
> Carlos
