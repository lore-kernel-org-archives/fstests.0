Received: from mx1.redhat.com ([209.132.183.28]:60394 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751649AbeEQSV5 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 17 May 2018 14:21:57 -0400
Date: Fri, 18 May 2018 02:21:55 +0800
From: Zorro Lang <zlang@redhat.com>
Subject: Re: Problems about xfstests g/475
Message-ID: <20180517182155.GD4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
References: <20180517090304.GB4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
 <20180517143057.GC4910@magnolia>
 <20180517154517.GC4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
 <20180517171211.GF4910@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517171211.GF4910@magnolia>
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, May 17, 2018 at 10:12:11AM -0700, Darrick J. Wong wrote:
> On Thu, May 17, 2018 at 11:45:17PM +0800, Zorro Lang wrote:
> > On Thu, May 17, 2018 at 07:30:57AM -0700, Darrick J. Wong wrote:
> > > On Thu, May 17, 2018 at 05:03:04PM +0800, Zorro Lang wrote:
> > > > Hi Darrick,
> > > > 
> > > > Sorry to trouble you, generic/475 rarely trigger an error[1] (test
> > > > on 4.16 kernel)
> > > > 
> > > > I checked the case, from the xfstests code below:
> > > > 
> > > > _dmerror_load_error_table()
> > > > {
> > > >         suspend_opt="--nolockfs"
> > > > 
> > > >         if [ "$1" = "lockfs" ]; then
> > > >                 suspend_opt=""
> > > >         elif [ -n "$*" ]; then
> > > >                 suspend_opt="$*"
> > > >         fi
> > > > 
> > > >         $DMSETUP_PROG suspend $suspend_opt error-test
> > > >         [ $? -ne 0 ] && _fail  "dmsetup suspend failed"
> > > > 
> > > >         $DMSETUP_PROG load error-test --table "$DMERROR_TABLE"
> > > >         [ $? -ne 0 ] && _fail "dmsetup failed to load error table"
> > > > 
> > > >         $DMSETUP_PROG resume error-test
> > > >         [ $? -ne 0 ] && _fail  "dmsetup resume failed"
> > > > }
> > > > 
> > > > _dmerror_load_error_table() use "--nolockfs" by default. But g/475 call
> > > > _dmerror_load_error_table without any argument, so it doesn't do the
> > > > things as it describes on comment -- "Loading error table without --nolockfs
> > > > option".
> > > > 
> > > > I'm confused, what is your expected test? Is this "--nolockfs" thing
> > > > cause this error[1]?
> > 
> > Thanks for your quick reply!
> > 
> > Can you confirm if
> > 
> >   _dmerror_load_error_table "lockfs"
> >   ...
> >   _dmerror_load_working_table "lockfs"
> > 
> > is what you really want to run in g/475?
> 
> The test simulates sudden disk disconnection by switching in dm-error
> without freezing or otherwise quiescing the filesystem, so passing
> --nolockfs to dmsetup is the correct behavior.
> 
> Calling _dmerror_load_error_table without 'lockfs' gets us the
> --nolockfs behavior (which confuses me every time I look at this),
> so the test is correct as written.  The comment for that hunk of code is
> atrociously incorrect and hard to understand, so I will rewrite it.

Thanks for your kind explanation :)

> 
> It would seem that you've uncovered a log replay bug in xfs. :)

Thanks,
Zorro

> 
> --D
> 
> > > > 
> > > > Thanks,
> > > > Zorro
> > > > 
> > > > 
> > > > [1]
> > > > meta-data=/dev/sda3              isize=512    agcount=4, agsize=1966080 blks
> > > >          =                       sectsz=512   attr=2, projid32bit=1
> > > >          =                       crc=1        finobt=1, sparse=0, rmapbt=0, reflink=0
> > > > data     =                       bsize=2048   blocks=7864320, imaxpct=25
> > > >          =                       sunit=0      swidth=0 blks
> > > > naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
> > > > log      =internal log           bsize=2048   blocks=5120, version=2
> > > >          =                       sectsz=512   sunit=0 blks, lazy-count=1
> > > > realtime =none                   extsz=4096   blocks=0, rtextents=0
> > > > seed = 1525927899
> > > > ...
> > > > ...
> > > > seed = 1525744142
> > > > mount failed
> > > > _check_xfs_filesystem: filesystem on /dev/sda3 has dirty log
> > > 
> > > Uh, I guess log recovery failed.  What did dmesg capture?
> > 
> > The whole g/475 dmesg output as below:
> > https://paste.fedoraproject.org/paste/Y8SDgGmw6CRLhEI4kRVCrQ
> > 
> > 
> > The last round test's dmesg output is:
> > 
> > [ 8201.588313] XFS (dm-0): metadata I/O error in "xlog_iodone" at daddr 0xf04fcc len 64 error 5 
> > [ 8201.590504] XFS (dm-0): metadata I/O error in "xlog_iodone" at daddr 0xf00025 len 64 error 5 
> > [ 8201.596839] XFS (dm-0): xfs_do_force_shutdown(0x2) called from line 1262 of file fs/xfs/xfs_log.c.  Return address = 00000000755f7a21 
> > [ 8201.597039] XFS (dm-0): Log I/O Error Detected.  Shutting down filesystem 
> > [ 8201.605368] XFS (dm-0): xfs_do_force_shutdown(0x2) called from line 1262 of file fs/xfs/xfs_log.c.  Return address = 00000000755f7a21 
> > [ 8201.607232] buffer_io_error: 17 callbacks suppressed 
> > [ 8201.607235] Buffer I/O error on dev dm-0, logical block 31457152, async page read 
> > [ 8201.607241] Buffer I/O error on dev dm-0, logical block 31457153, async page read 
> > [ 8201.607244] Buffer I/O error on dev dm-0, logical block 31457154, async page read 
> > [ 8201.607248] Buffer I/O error on dev dm-0, logical block 31457155, async page read 
> > [ 8201.607251] Buffer I/O error on dev dm-0, logical block 31457156, async page read 
> > [ 8201.607254] Buffer I/O error on dev dm-0, logical block 31457157, async page read 
> > [ 8201.607257] Buffer I/O error on dev dm-0, logical block 31457158, async page read 
> > [ 8201.607261] Buffer I/O error on dev dm-0, logical block 31457159, async page read 
> > [ 8201.617451] XFS (dm-0): Please umount the filesystem and rectify the problem(s) 
> > [ 8201.617467] XFS (dm-0): metadata I/O error in "xlog_iodone" at daddr 0xf05000 len 64 error 5 
> > [ 8201.717710] XFS (dm-0): xfs_do_force_shutdown(0x2) called from line 1262 of file fs/xfs/xfs_log.c.  Return address = 00000000755f7a21 
> > [ 8201.769082] XFS (dm-0): Unmounting Filesystem 
> > [ 8201.901650] XFS (dm-0): Mounting V5 Filesystem 
> > [ 8201.919089] XFS (dm-0): Log inconsistent or not a log (last==0, first!=1) 
> > [ 8201.925942] XFS (dm-0): empty log check failed 
> > [ 8201.930451] XFS (dm-0): log mount/recovery failed: error -22 
> > [ 8201.936260] XFS (dm-0): log mount failed 
> > [ 8202.245329] XFS (sda2): Unmounting Filesystem 
> > [ 8205.664753] XFS (sda2): Mounting V5 Filesystem 
> > [ 8205.727620] XFS (sda2): Ending clean mount 
> > [ 8206.112965] XFS (sda3): Mounting V5 Filesystem 
> > [ 8206.199215] XFS (sda3): Ending clean mount 
> > [ 8206.292347] XFS (sda2): Unmounting Filesystem 
> > [ 8207.996053] XFS (sda2): Mounting V5 Filesystem 
> > [ 8208.061478] XFS (sda2): Ending clean mount 
> > 
> > Thanks,
> > Zorro
> > 
> > > 
> > > --D
> > > 
> > > > *** xfs_logprint -t output ***
> > > > Log inconsistent or not a log (last==0, first!=1)
> > > > empty log check failed
> > > > xfs_logprint: failed to find head and tail, error: 22
> > > > xfs_logprint:
> > > >     data device: 0x803
> > > >     log device: 0x803 daddr: 15728660 length: 20480
> > > > 
> > > > *** end xfs_logprint output
> > > > _check_xfs_filesystem: filesystem on /dev/sda3 is inconsistent (c)
> > > > *** xfs_check output ***
> > > > Log inconsistent or not a log (last==0, first!=1)
> > > > empty log check failed
> > > > xlog_is_dirty: cannot find log head/tail (xlog_find_tail=22)
> > > > 
> > > > ERROR: cannot find log head/tail, run xfs_repair
> > > > *** end xfs_check output
> > > > _check_xfs_filesystem: filesystem on /dev/sda3 is inconsistent (r)
> > > > *** xfs_repair -n output ***
> > > > Phase 1 - find and verify superblock...
> > > > Phase 2 - using internal log
> > > >         - zero log...
> > > > Log inconsistent or not a log (last==0, first!=1)
> > > > empty log check failed
> > > > zero_log: cannot find log head/tail (xlog_find_tail=22)
> > > > *** end xfs_repair output
> > > > --
> > > > To unsubscribe from this list: send the line "unsubscribe fstests" in
> > > > the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe fstests" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > --
> > To unsubscribe from this list: send the line "unsubscribe fstests" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
