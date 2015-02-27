Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:19392 "EHLO
	ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754226AbbB0A6l (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 26 Feb 2015 19:58:41 -0500
Date: Fri, 27 Feb 2015 11:58:37 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: ramdisk problems in 4.0-rc1? (was Re: [PATCH 1/4] xfs/104: log
 size too small for 4k sector drives)
Message-ID: <20150227005837.GG18360@dastard>
References: <1424818479-10083-1-git-send-email-david@fromorbit.com>
 <1424818479-10083-2-git-send-email-david@fromorbit.com>
 <20150225161151.GC28053@bfoster.bfoster>
 <20150225223248.GH4251@dastard>
 <20150225233115.GA1009@bfoster.bfoster>
 <20150225234343.GI4251@dastard>
 <54EECF53.8010207@plexistor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54EECF53.8010207@plexistor.com>
Sender: fstests-owner@vger.kernel.org
To: Boaz Harrosh <boaz@plexistor.com>
Cc: Brian Foster <bfoster@redhat.com>, fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org, axboe@fb.com
List-ID: <fstests@vger.kernel.org>

On Thu, Feb 26, 2015 at 09:46:27AM +0200, Boaz Harrosh wrote:
> On 02/26/2015 01:43 AM, Dave Chinner wrote:
> > On Wed, Feb 25, 2015 at 06:31:15PM -0500, Brian Foster wrote:
> >> On Thu, Feb 26, 2015 at 09:32:48AM +1100, Dave Chinner wrote:
> >>> [cc linux-fsdevel, Boaz and others]
> >>>
> >>> On Wed, Feb 25, 2015 at 11:11:51AM -0500, Brian Foster wrote:
> >>>> On Wed, Feb 25, 2015 at 09:54:36AM +1100, Dave Chinner wrote:
> >>>>> From: Dave Chinner <dchinner@redhat.com>
> >>>>>
> >>>>> xfs/104, xfs/119, xfs/291 and xfs/297 have small fixed log sizes. A
> >>>>> recent change to the kernel ramdisk changed it's physical sector
> >>>>> size from 512B to 4kB, and this results in mkfs calculating a log
> >>>>> size larger than the fixed test size and hence the tests fail.
> >>>>>
> >>>>> Change the log size to a larger size that works with 4k sectors, and
> >>>>> also increase the size of the filesystem being created so that the
> >>>>> amount of data space in the filesystem does not change and hence
> >>>>> does not perturb the rest of the test.
> >>>>>
> >>>>> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> >>>>> ---
> >>>>
> >>>> Well for some reason I can't mount a ramdisk on the current tot to test
> >>>> this. In fact, I can't mount _anything_ after the ramdisk mount attempt.
> >>>> The mount actually reports success too, but there's nothing there... :/
> >>>>
> >>>> # modprobe brd
> >>>> # mkfs.xfs -f /dev/ram0 
> >>>> meta-data=/dev/ram0              isize=256    agcount=1, agsize=4096
> >>>> blks
> >>>>          =                       sectsz=4096  attr=2, projid32bit=1
> >>>>          =                       crc=0        finobt=0
> >>>> data     =                       bsize=4096   blocks=4096, imaxpct=25
> >>>>          =                       sunit=0      swidth=0 blks
> >>>> naming   =version 2              bsize=4096   ascii-ci=0 ftype=0
> >>>> log      =internal log           bsize=4096   blocks=1605, version=2
> >>>>          =                       sectsz=4096  sunit=1 blks, lazy-count=1
> >>>> realtime =none                   extsz=4096   blocks=0, rtextents=0
> >>>> # mount /dev/ram0 /mnt/
> >>>> # mount | grep mnt
> >>>> # umount  /mnt/
> >>>> umount: /mnt/: not mounted
> >>>>
> >>>> ... and then I can't even mount my normal scratch device until after a
> >>>> reboot:
> >>>>
> >>>> # mount /dev/test/scratch /mnt/
> >>>> # mount | grep mnt
> >>>> # umount  /mnt/
> >>>> umount: /mnt/: not mounted
> >>>
> >>> Ok, so that's just plain broken. What's in dmesg?
> >>>
> >>
> >> Once I got back to this I found that for some reason systemd is
> >> immediately invoking a umount on the mount. :/ No idea why or how to
> >> stop it, but if I do something like this:
> >>
> >> mount /dev/ram0 /mnt; cd /mnt
> >>
> >> ... I can occasionally win the race and get systemd to spin in a
> >> umount() cycle trying to undo the mount. I haven't gone back to confirm
> >> it's the same behavior with the normal devices at that point, but I
> >> suspect it is, perhaps due to getting into some kind of bad state.
> >>
> >> So fyi that this particular problem doesn't appear to be directly kernel
> >> related...
> > 
> > It may still be related to the kernel changes  e.g. by triggering
> > udev events when they didn't previously. The only machine I have
> > that is triggering the partition probing is also the only test
> > machine that I have that runs systemd and it didn't have this
> > problem on 3.19.
> > 
> 
> Sigh, thanks Dave. Yes you are correct my patch enabled the
> udev events, as part of fixing ramdisk with partitions.
> This is because if you do not enable them then mount by UUID
> and all sort of lsblk and friends do not work.

Sure, that's what the gendisk abstraction just you. But why am I
seeing random partition probes on a ramdisk that *isn't using
partitions*?

> I did try to test this in all kind of ways, xfstest+ext4
> as well, and ran with it on Fedora 20 for a while, sorry
> about that.
> 
> It looks like the system anticipates that ramdisk "should
> not have these events"

Right, but not because it's a ramdisk. Those events should not be
occurring because I'm not creating or destroying devices, I'm not
changing partition tables, I'm not resizing ramdisks or partitions,
and so on. I'm simply mkfs'ing, mounting and unmounting filesystems
on the ramdisks - nothing should be generating device based udev
events...

Finding the trigger that is causing these events will tell us what
the bug is - restricting the config won't help, especially as DAX
will *always* be enabled on my test machines as it's something
needed in my test matrix. I'm not sure how to go about finding that
trigger right now and as such I won't really have time to look at it
until after lsfmm/vault...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
