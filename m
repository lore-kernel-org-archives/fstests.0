Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:49707 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751295AbcGQXaK (ORCPT
	<rfc822;fstests@vger.kernel.org>); Sun, 17 Jul 2016 19:30:10 -0400
Date: Mon, 18 Jul 2016 09:30:03 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 6/6] xfstests: Add mkfs input validation tests
Message-ID: <20160717233003.GX1922@dastard>
References: <1468500214-6237-1-git-send-email-jtulak@redhat.com>
 <1468500214-6237-7-git-send-email-jtulak@redhat.com>
 <20160716093358.GL2432@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160716093358.GL2432@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Jan Tulak <jtulak@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sat, Jul 16, 2016 at 05:33:58PM +0800, Eryu Guan wrote:
> On Thu, Jul 14, 2016 at 02:43:34PM +0200, Jan Tulak wrote:
> > +do_mkfs_fail -l lazy-count=1garbage $SCRATCH_DEV
> > +do_mkfs_fail -l lazy-count=2 $SCRATCH_DEV
> > +do_mkfs_fail -l lazy-count=0 -m crc=1 $SCRATCH_DEV
> > +do_mkfs_fail -l version=1 -m crc=1 $SCRATCH_DEV
> 
> This test fails in my DAX testing, where SCRATCH_DEV is ramdisk. The
> mkfs itself should fail, but it passed. Log version 2 was used
> automatically, instead of prompting "V2 logs always enabled for CRC
> enabled filesytems"
> 
> [root@dhcp-66-86-11 xfstests]# mkfs -t xfs -f -l version=1 -m crc=1 /dev/ram0
> meta-data=/dev/ram0              isize=512    agcount=1, agsize=4096 blks
>          =                       sectsz=4096  attr=2, projid32bit=1
>          =                       crc=1        finobt=1, sparse=0
> data     =                       bsize=4096   blocks=4096, imaxpct=25
>          =                       sunit=0      swidth=0 blks
> naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
> log      =internal log           bsize=4096   blocks=1605, version=2
>          =                       sectsz=4096  sunit=1 blks, lazy-count=1
> realtime =none                   extsz=4096   blocks=0, rtextents=0
> 
> Is it a mkfs.xfs bug or the test case should handle the special case?

Looks like it might be a side effect of using a 4k sector size. v1
logs only supported 512 byte sectors, so it's entirely possible that
the sector size is silently overriding the log version
specification. Probably should be fixed in mkfs.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
