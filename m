Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:65378 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752813AbbDGBg1 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 6 Apr 2015 21:36:27 -0400
Date: Tue, 7 Apr 2015 11:36:11 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 6/9] generic: test I/O error path by fully filling dm
 snapshot
Message-ID: <20150407013611.GA13731@dastard>
References: <1426846618-23413-7-git-send-email-eguan@redhat.com>
 <1427896455-12048-1-git-send-email-eguan@redhat.com>
 <20150401175710.GF4756@bfoster.bfoster>
 <20150401222954.GF28621@dastard>
 <20150402041041.GF16808@dhcp-13-216.nay.redhat.com>
 <20150402111145.GA3808@laptop.bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150402111145.GA3808@laptop.bfoster>
Sender: fstests-owner@vger.kernel.org
To: Brian Foster <bfoster@redhat.com>
Cc: Eryu Guan <eguan@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Apr 02, 2015 at 07:11:45AM -0400, Brian Foster wrote:
> On Thu, Apr 02, 2015 at 12:10:41PM +0800, Eryu Guan wrote:
> > On Thu, Apr 02, 2015 at 09:29:54AM +1100, Dave Chinner wrote:
> > > On Wed, Apr 01, 2015 at 01:57:10PM -0400, Brian Foster wrote:
> > > > On Wed, Apr 01, 2015 at 09:54:15PM +0800, Eryu Guan wrote:
> > > > Kind of a nit, but we could be a bit more explicit and do a '-c fsync'
> > > > after the pwrite here? That way it's clear that writeback to disk is
> > > > part of the core test and we have a little feedback in $seqres.full that
> > > > I/O errors occurred, as expected.
> > > 
> > > Added the -c fsync as I pulled it in.
> > 
> > I was thinking about adding fsync or sync at first, but it causes
> > problems in cleanup. For some reason(I don't know clearly) fsync
> > sometimes pins the snapshot in use and vgremove can't remove all lvs, so
> > SCRATCH_DEV is still used by the test vg when running next test
> > 
> > our local _scratch_mkfs routine ...                                                                                                                                              
> > mkfs.xfs: cannot open /dev/sda6: Device or resource busy                                                                                         
> > check: failed to mkfs $SCRATCH_DEV using specified options
> > 
> > From 081.full I can see
> > 
> > Logical volume vg_081/snap_081 contains a filesystem in use.
> > 
> > The test vg/lv has to be removed manually after the test
> > 
> > vgremove -f vg_081
> > 
> > I don't find a proper way to fix it yet, but simply adding 'sleep 1'
> > before vgremove in _cleanup works for me
> 
> Hmm, I haven't seen that one. Seems fine for me as a temporary
> workaround though. Perhaps include it with the udev-settle thing that
> Dave needs on the creation side of things..?

More than likely. I hate udev at times....

FWIW, there's also other issues here, and I think I've finally also
worked out why dm-flakey tests have interesting problems when run on
ramdisks.

$ cat /home/dave/src/xfstests-dev/results//xfs/generic/081.full

[ snip scratch_mkfs output ]

  Physical volume "/dev/ram1" successfully created
  Volume group "vg_081" successfully created
  Logical volume "base_081" created
  Volume group "vg_081" not found
Failed to create snapshot
  Volume group "vg_081" not found
  Skipping volume group vg_081
  Can't open /dev/ram1 exclusively - not removing. Mounted filesystem?

Which is interesting, because:

$ sudo lvm vgcreate foobar /dev/ram1
  Physical volume "/dev/ram1" successfully created
  Volume group "foobar" successfully created
$ sudo lvm lvcreate -L 256M -n wtf foobar
  Logical volume "wtf" created
$ sudo lvm pvscan
  PV /dev/ram1   VG foobar   lvm2 [3.81 GiB / 3.56 GiB free]
  Total: 1 [3.81 GiB] / in use: 1 [3.81 GiB] / in no VG: 0 [0   ]
$ sudo lvm lvscan
  ACTIVE            '/dev/foobar/wtf' [256.00 MiB] inherit
(failed reverse-i-search)`hexd': sudo MKFS_OPTIONS="-m crc=1,finobt=1" ./c^Cck -g auto
$ sudo hexdump /dev/mapper/foobar-wtf
0000000 0000 0000 0000 0000 0000 0000 0000 0000
*
10000000
$ sudo hexdump /dev/ram1
0000000 0000 0000 0000 0000 0000 0000 0000 0000
*
0000200 414c 4542 4f4c 454e 0001 0000 0000 0000
0000210 5d39 644e 0020 0000 564c 324d 3020 3130
0000220 6a54 6b6b 5a5a 7175 4c70 5434 5866 6450
0000230 4f73 6552 5330 3333 4c79 4157 6144 7678
0000240 0000 f424 0000 0000 0000 0010 0000 0000
.....
$ sudo mkfs.xfs /dev/mapper/foobar-wtf
meta-data=/dev/mapper/foobar-wtf isize=256    agcount=4, agsize=16384 blks
         =                       sectsz=4096  attr=2, projid32bit=1
         =                       crc=0        finobt=0
data     =                       bsize=4096   blocks=65536, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0 ftype=0
log      =internal log           bsize=4096   blocks=1605, version=2
         =                       sectsz=4096  sunit=1 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
$ sudo hexdump /dev/ram1
0000000 0000 0000 0000 0000 0000 0000 0000 0000
*
f4240000
$ sudo lvm lvscan
  No volume groups found
$

because running mkfs.xfs on the LVM volume is causing the entire
underlying physical device to be erased. The machine has to be
rebooted at this point because /dev/ram1 is now stuck with
references that cannot be removed.

Oh, I bet the problem is the final flush ioctl that mkfs sends:

3420  pwrite(4, "XFSB\0\0\20\0\0\0\0\0\0\1\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4096, 0) = 4096
3420  fsync(4)                          = 0
3420  ioctl(4, BLKFLSBUF, 0)            = 0
3420  close(4)                          = 0
3420  exit_group(0)                     = ?
3420  +++ exited with 0 +++

Now, when mkfs.xfs is run on the ramdisk, it has a reference to the
ramdisk and so brd ignores BLKFLSBUF. I bet that LVM doesn't hold a
reference to the underlying block device, and so when brd receives
the BLKFLSBUF passed down from /dev/mapper/foobar-wtf it sees no
references and so removes all pages...

This seems like a proper screwup - the brd code is abusing BLKFLSBUF
to mean "free all the memory" rather than "flush dirty buffers to
stable storage" like everyone else expects it to be.

Hence I suspect we need a new _requires rule here for DM based tests
to stop them from running on brd devices. I'll have a look at
rolling it into the DM requires statements and see how that goes...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
