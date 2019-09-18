Received: from mx1.redhat.com ([209.132.183.28]:34028 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbfIRCvx (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 17 Sep 2019 22:51:53 -0400
Date: Wed, 18 Sep 2019 10:59:15 +0800
From: Zorro Lang <zlang@redhat.com>
Subject: Re: question of xfs/148 and xfs/149
Message-ID: <20190918025915.GK7239@dhcp-12-102.nay.redhat.com>
References: <4BF2FD5A942B1C4B828DDAF5635768C1041AB0E2@G08CNEXMBPEKD02.g08.fujitsu.local>
 <20190917163933.GC736475@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917163933.GC736475@magnolia>
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: "Xu, Yang" <xuyang2018.jy@cn.fujitsu.com>, "fstests@vger.kernel.org" <fstests@vger.kernel.org>, xfs <linux-xfs@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Tue, Sep 17, 2019 at 09:39:33AM -0700, Darrick J. Wong wrote:
> [add linux-xfs to cc]
> 
> On Tue, Sep 17, 2019 at 09:00:57AM +0000, Xu, Yang wrote:
> > HI All
> > 
> > When I investigated xfs/030 failure on upstream kernel after mering
> > xfstests commit d0e484ac699f ("check: wipe scratch devices between
> > tests"), I found two similar cases(xfs/148,xfs/149).

xfs/030 is weird, I've found it long time ago.

If I do a 'whole disk mkfs' (_scratch_mkfs_xfs), before this sized mkfs:

  _scratch_mkfs_xfs $DSIZE >/dev/null 2>&1

Everything looks clear, and test pass. I can't send a patch to do this,
because I don't know the reason.

I'm not familiar with xfs_repair so much, so I don't know what happens
underlying. I suppose the the part after the $DSIZE affect the xfs_repair,
but I don't know why the wipefs can cause that, wipefs only erase 4 bytes
at the beginning.

Darrick, do you know more about that?

Thanks,
Zorro

> > 
> > xfs/148 is a clone of test 030 using xfs_prepair64 instead of xfs_repair.
> > xfs/149 is a clone of test 031 using xfs_prepair instead of xfs_repair

I'm not worried about it too much, due to it always 'not run' and never
fails:)

xfs/148 [not run] parallel repair binary xfs_prepair64 is not installed
xfs/149 [not run] parallel repair binary xfs_prepair is not installed
Ran: xfs/148 xfs/149
Not run: xfs/148 xfs/149
Passed all 2 tests

> > 
> > But I don't find these two commands and know nothing about them.  If
> > these commands have been obsoleted long time ago, I think we can
> > remove the two cases. Or may I miss something?
> 
> <shrug> I think your analysis is correct, but let's see what the xfs
> list thinks.
> 
> --D
> 
> > 
> > Thanks
> > Yang Xu
> > 
> > 
