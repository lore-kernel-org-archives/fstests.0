Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42586 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753102AbbBYXbY (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 25 Feb 2015 18:31:24 -0500
Date: Wed, 25 Feb 2015 18:31:15 -0500
From: Brian Foster <bfoster@redhat.com>
Subject: Re: ramdisk problems in 4.0-rc1? (was Re: [PATCH 1/4] xfs/104: log
 size too small for 4k sector drives)
Message-ID: <20150225233115.GA1009@bfoster.bfoster>
References: <1424818479-10083-1-git-send-email-david@fromorbit.com>
 <1424818479-10083-2-git-send-email-david@fromorbit.com>
 <20150225161151.GC28053@bfoster.bfoster>
 <20150225223248.GH4251@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150225223248.GH4251@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org, boaz@plexistor.com, axboe@fb.com
List-ID: <fstests@vger.kernel.org>

On Thu, Feb 26, 2015 at 09:32:48AM +1100, Dave Chinner wrote:
> [cc linux-fsdevel, Boaz and others]
> 
> On Wed, Feb 25, 2015 at 11:11:51AM -0500, Brian Foster wrote:
> > On Wed, Feb 25, 2015 at 09:54:36AM +1100, Dave Chinner wrote:
> > > From: Dave Chinner <dchinner@redhat.com>
> > > 
> > > xfs/104, xfs/119, xfs/291 and xfs/297 have small fixed log sizes. A
> > > recent change to the kernel ramdisk changed it's physical sector
> > > size from 512B to 4kB, and this results in mkfs calculating a log
> > > size larger than the fixed test size and hence the tests fail.
> > > 
> > > Change the log size to a larger size that works with 4k sectors, and
> > > also increase the size of the filesystem being created so that the
> > > amount of data space in the filesystem does not change and hence
> > > does not perturb the rest of the test.
> > > 
> > > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > > ---
> > 
> > Well for some reason I can't mount a ramdisk on the current tot to test
> > this. In fact, I can't mount _anything_ after the ramdisk mount attempt.
> > The mount actually reports success too, but there's nothing there... :/
> > 
> > # modprobe brd
> > # mkfs.xfs -f /dev/ram0 
> > meta-data=/dev/ram0              isize=256    agcount=1, agsize=4096
> > blks
> >          =                       sectsz=4096  attr=2, projid32bit=1
> >          =                       crc=0        finobt=0
> > data     =                       bsize=4096   blocks=4096, imaxpct=25
> >          =                       sunit=0      swidth=0 blks
> > naming   =version 2              bsize=4096   ascii-ci=0 ftype=0
> > log      =internal log           bsize=4096   blocks=1605, version=2
> >          =                       sectsz=4096  sunit=1 blks, lazy-count=1
> > realtime =none                   extsz=4096   blocks=0, rtextents=0
> > # mount /dev/ram0 /mnt/
> > # mount | grep mnt
> > # umount  /mnt/
> > umount: /mnt/: not mounted
> > 
> > ... and then I can't even mount my normal scratch device until after a
> > reboot:
> > 
> > # mount /dev/test/scratch /mnt/
> > # mount | grep mnt
> > # umount  /mnt/
> > umount: /mnt/: not mounted
> 
> Ok, so that's just plain broken. What's in dmesg?
> 

Once I got back to this I found that for some reason systemd is
immediately invoking a umount on the mount. :/ No idea why or how to
stop it, but if I do something like this:

mount /dev/ram0 /mnt; cd /mnt

... I can occasionally win the race and get systemd to spin in a
umount() cycle trying to undo the mount. I haven't gone back to confirm
it's the same behavior with the normal devices at that point, but I
suspect it is, perhaps due to getting into some kind of bad state.

So fyi that this particular problem doesn't appear to be directly kernel
related...

Brian

> As it is, I'm seeing plenty of weirdness in 4.0-rc1 on ramdisks as
> well. Apart from the change to 4k physical sector size causing all
> sorts of chaos with xfstests results due to it changing mkfs.xfs
> behaviour, I'm also seeing this happen randomly:
> 
> ....
> Feb 25 11:48:35 test4 dave: run xfstest generic/083
> Feb 25 11:48:37 test4 kernel: [ 8732.316223] XFS (ram1): Mounting V5 Filesystem
> Feb 25 11:48:37 test4 kernel: [ 8732.318904] XFS (ram1): Ending clean mount
> Feb 25 11:48:40 test4 kernel: [ 8735.871968] XFS (ram1): Unmounting Filesystem
> Feb 25 11:48:40 test4 kernel: [ 8735.930160]  ram1: [POWERTEC] p1 p2 p3 p4 p5 p6 p7
> Feb 25 11:48:40 test4 kernel: [ 8735.932081] ram1: p2 start 3158599292 is beyond EOD, truncated
> Feb 25 11:48:40 test4 kernel: [ 8735.933983] ram1: p3 size 1627389952 extends beyond EOD, truncated
> Feb 25 11:48:40 test4 kernel: [ 8735.936177] ram1: p4 size 1158021120 extends beyond EOD, truncated
> Feb 25 11:48:40 test4 kernel: [ 8735.938269] ram1: p5 start 50924556 is beyond EOD, truncated
> Feb 25 11:48:40 test4 kernel: [ 8735.940103] ram1: p6 size 67108864 extends beyond EOD, truncated
> Feb 25 11:48:40 test4 kernel: [ 8735.942101] ram1: p7 start 4294967295 is beyond EOD, truncated
> Feb 25 11:48:40 test4 dave: run xfstest generic/088
> ....
> 
> Something is causing partition rescans on ram devices that don't
> have partitions, and this is new behaviour. Boaz, your commit
> 937af5ecd05 ("brd: Fix all partitions BUGs") seems the likely cause
> of this problem I'm seeing - looks likea behaviour regression to
> me as no other block device I have on any machine running the
> same kernel throws these strange warnings from partition probing...
> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
