Received: from mx1.redhat.com ([209.132.183.28]:52070 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751853AbdHQDTd (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 16 Aug 2017 23:19:33 -0400
Date: Thu, 17 Aug 2017 11:19:29 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] xfs: Test infinite loop while searching for a free inode
 slot
Message-ID: <20170817031929.GU14807@eguan.usersys.redhat.com>
References: <20170815125541.12243-1-cmaiolino@redhat.com>
 <20170816070214.GJ14807@eguan.usersys.redhat.com>
 <20170816073159.GL14807@eguan.usersys.redhat.com>
 <20170816155307.GA4794@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170816155307.GA4794@magnolia>
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Carlos Maiolino <cmaiolino@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Aug 16, 2017 at 08:53:07AM -0700, Darrick J. Wong wrote:
> On Wed, Aug 16, 2017 at 03:31:59PM +0800, Eryu Guan wrote:
> > On Wed, Aug 16, 2017 at 03:02:14PM +0800, Eryu Guan wrote:
> > > > +
> > > > +_scratch_unmount
> > > > +
> > > > +# agi->freecount is 0 here, corrupt it to show extra free inodes
> > > > +$XFS_DB_PROG -x -c "agi 0" -c "write -d freecount 10" $SCRATCH_DEV >/dev/null 2>&1
> > > 
> > > redirect stdout and stderr to $seqres.full for debug purpose
> > 
> > And you can use _scratch_xfs_db wrapper instead of open coded xfs_db
> > command.
> > 
> > And I found that "write -d" failed on a crc=0 XFS, though "write -c"
> > allows corrupted data and bad CRC, but touch couldn't reproduce the hang
> > in this case, because kernel detected bad crc first and aborted inode
> > creation.
> 
> What error did you get, specifically?
> 
> Sounds more like a bug in write/fuzz -d to me. :)

"Cannot recalculate CRCs on this type of object"

Though there's no crc enabled..

[root@dhcp-66-86-11 xfstests]# mkfs -t xfs -m crc=0 -f /dev/sda5
meta-data=/dev/sda5              isize=256    agcount=4, agsize=983040 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=0        finobt=0, sparse=0, rmapbt=0, reflink=0
data     =                       bsize=4096   blocks=3932160, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
log      =internal log           bsize=4096   blocks=2560, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
[root@dhcp-66-86-11 xfstests]# xfs_db -c "agi 0" -c "p freecount" /dev/sda5
freecount = 61
[root@dhcp-66-86-11 xfstests]# xfs_db -x -c "agi 0" -c "write -d freecount 10" /dev/sda5
Cannot recalculate CRCs on this type of object
[root@dhcp-66-86-11 xfstests]# xfs_db -c "agi 0" -c "p freecount" /dev/sda5
freecount = 61

Thanks,
Eryu

> 
> --D
> 
> > 
> > I think we can force a CRC enabled XFS by
> > 
> > _scratch_mkfs -m crc=1,finobt=0 >>$seqres.full 2>&1
> > 
> > Thanks,
> > Eryu
> > --
> > To unsubscribe from this list: send the line "unsubscribe fstests" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
