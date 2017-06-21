Received: from userp1040.oracle.com ([156.151.31.81]:31893 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751113AbdFUSBw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 21 Jun 2017 14:01:52 -0400
Date: Wed, 21 Jun 2017 11:01:46 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v2] ext4: fsmap tests
Message-ID: <20170621180146.GE3787@birch.djwong.org>
References: <20170602225220.GA5634@birch.djwong.org>
 <20170620151500.GA17669@eguan.usersys.redhat.com>
 <20170620155848.GB3787@birch.djwong.org>
 <20170621074339.GC17669@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170621074339.GC17669@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Wed, Jun 21, 2017 at 03:43:39PM +0800, Eryu Guan wrote:
> On Tue, Jun 20, 2017 at 08:58:48AM -0700, Darrick J. Wong wrote:
> > On Tue, Jun 20, 2017 at 11:15:00PM +0800, Eryu Guan wrote:
> > > On Fri, Jun 02, 2017 at 03:52:20PM -0700, Darrick J. Wong wrote:
> > > > Test the GETFSMAP ioctl against ext4.
> > > > 
> > > > Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> > > > ---
> > > >  tests/ext4/700     |   76 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> > > >  tests/ext4/700.out |    7 +++++
> > > >  tests/ext4/701     |   65 ++++++++++++++++++++++++++++++++++++++++++++
> > > >  tests/ext4/701.out |    3 ++
> > > >  tests/ext4/702     |   66 +++++++++++++++++++++++++++++++++++++++++++++
> > > >  tests/ext4/702.out |    4 +++
> > > >  tests/ext4/group   |    3 ++
> > > >  7 files changed, 224 insertions(+)
> > > >  create mode 100755 tests/ext4/700
> > > >  create mode 100644 tests/ext4/700.out
> > > >  create mode 100755 tests/ext4/701
> > > >  create mode 100644 tests/ext4/701.out
> > > >  create mode 100755 tests/ext4/702
> > > >  create mode 100644 tests/ext4/702.out
> > > > 
> > > > diff --git a/tests/ext4/700 b/tests/ext4/700
> > > > new file mode 100755
> > > > index 0000000..a4a1b83
> > > > --- /dev/null
> > > > +++ b/tests/ext4/700
> > > > @@ -0,0 +1,76 @@
> > > > +#! /bin/bash
> > > > +# FS QA Test No. 700
> > > > +#
> > > > +# Check that getfsmap reports the BG metadata we're expecting.
> > > > +#
> > > > +#-----------------------------------------------------------------------
> > > > +# Copyright (c) 2017, Oracle and/or its affiliates.  All Rights Reserved.
> > > > +#
> > > > +# This program is free software; you can redistribute it and/or
> > > > +# modify it under the terms of the GNU General Public License as
> > > > +# published by the Free Software Foundation.
> > > > +#
> > > > +# This program is distributed in the hope that it would be useful,
> > > > +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> > > > +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > > > +# GNU General Public License for more details.
> > > > +#
> > > > +# You should have received a copy of the GNU General Public License
> > > > +# along with this program; if not, write the Free Software Foundation,
> > > > +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> > > > +#-----------------------------------------------------------------------
> > > > +
> > > > +seq=`basename "$0"`
> > > > +seqres="$RESULT_DIR/$seq"
> > > > +echo "QA output created by $seq"
> > > > +
> > > > +here=`pwd`
> > > > +tmp=/tmp/$$
> > > > +status=1    # failure is the default!
> > > > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > > > +
> > > > +_cleanup()
> > > > +{
> > > > +	cd /
> > > > +	rm -f "$tmp".* $TEST_DIR/fsmap $TEST_DIR/testout
> > > > +}
> > > > +
> > > > +# get standard environment, filters and checks
> > > > +. ./common/rc
> > > > +. ./common/filter
> > > > +
> > > > +# real QA test starts here
> > > > +_supported_os Linux
> > > > +_supported_fs ext4
> > > > +_require_scratch
> > > > +_require_xfs_io_command "fsmap"
> > > > +
> > > > +rm -f "$seqres.full"
> > > > +
> > > > +echo "Format and mount"
> > > > +_scratch_mkfs > "$seqres.full" 2>&1
> > > > +_scratch_mount
> > > > +
> > > > +echo "Get fsmap" | tee -a $seqres.full
> > > > +$XFS_IO_PROG -c 'fsmap' $SCRATCH_MNT > $TEST_DIR/fsmap
> > > > +cat $TEST_DIR/fsmap >> $seqres.full
> > > > +
> > > > +echo "Check fs metadata" | tee -a $seqres.full
> > > > +x=$(grep -c 'static fs metadata' $TEST_DIR/fsmap)
> > > > +test $x -gt 0 || echo "No fs metadata?"
> > > 
> > > This test fails if I use external log dev (with 4.12-rc5 kernel and
> > > djwong-devel branch of your xfsprogs tree).
> > > 
> > >     --- tests/ext4/026.out      2017-06-20 20:44:11.307128655 +0800
> > >     +++ /root/xfstests/results//ext4/026.out.bad        2017-06-20 21:02:31.361452548 +0800
> > >     @@ -2,6 +2,10 @@
> > >      Format and mount
> > >      Get fsmap
> > >      Check fs metadata
> > >     +No fs metadata?
> > >      Check block bitmap
> > >     +No block bitmaps?
> > 
> > Uhoh. :)
> > 
> > Strangely, I couldn't reproduce this; maybe our software our out of
> > sync?  Can you send me results/ext4/026.out ?
> 
> You mean 026.full? Anyway, I attached both 026.full and 026.out.bad.
> 
> BTW, I'm using e2fsprogs 'next' branch, HEAD is "474f67a libext2fs: fix
> fsync(2) detection", not sure if that matters.

Aha, you're using 1024b blocks... which evidently is broken in the kernel.

> 
> > 
> > >      Check inode bitmap
> > >      ...
> > > 
> > > Seems this test assmues internal journal? Do we need a new
> > > _require_no_logdev rule? (BTW, ext4/701 fails too if external log is
> > > set).
> > > 
> > > > +
> > > > +echo "Check block bitmap" | tee -a $seqres.full
> > > > +x=$(grep -c 'special 102:1' $TEST_DIR/fsmap)
> > > > +test $x -gt 0 || echo "No block bitmaps?"
> > > > +
> > > > +echo "Check inode bitmap" | tee -a $seqres.full
> > > > +x=$(grep -c 'special 102:2' $TEST_DIR/fsmap)
> > > 
> > > It's not clear to me why "special 102:1" and "special 102:2" represent
> > > "block bitmaps" and "inode bitmaps", do you mind adding some comments?
> > 
> > Those are ext4-specific owner codes, which xfs_io of course doesn't know
> > much about other than to print the raw number data.
> > 
> > > Also, the format of fsmap output seems not match the manpage? In
> > > xfs_io.8 we have
> > > extent: major:minor [startblock..endblock]: owner startoffset..endoffset length
> > > 
> > > and a fsmap output on ext4 filesystem is like
> > > 51: 8:33 [12582912..12583039]: special 102:3 128
> > > 
> > > So I assume 'special' is the 'owner' field, but '102:3' doesn't seem
> > > like offsets?
> > 
> > Yeah... Eric complained about the undiscoverable spaces in the owner
> > field too.  The whole field is 'special 102:2'.  Maybe we should just
> > use the (new) machine-readable format switch instead.  Sort of waiting
> > on Eric to pull all those patches into xfsprogs though...
> > 
> > > > +test $x -gt 0 || echo "No inode bitmaps?"
> > > > +
> > > > +echo "Check inodes" | tee -a $seqres.full
> > > > +x=$(grep -c 'inodes' $TEST_DIR/fsmap)
> > > > +test $x -gt 0 || echo "No inodes?"
> > > > +
> > > > +# success, all done
> > > > +status=0
> > > > +exit
> > > > diff --git a/tests/ext4/700.out b/tests/ext4/700.out
> > > > new file mode 100644
> > > > index 0000000..3984319
> > > > --- /dev/null
> > > > +++ b/tests/ext4/700.out
> > > > @@ -0,0 +1,7 @@
> > > > +QA output created by 700
> > > > +Format and mount
> > > > +Get fsmap
> > > > +Check fs metadata
> > > > +Check block bitmap
> > > > +Check inode bitmap
> > > > +Check inodes
> > > > diff --git a/tests/ext4/701 b/tests/ext4/701
> > > > new file mode 100755
> > > > index 0000000..6ae93d7
> > > > --- /dev/null
> > > > +++ b/tests/ext4/701
> > > > @@ -0,0 +1,65 @@
> > > > +#! /bin/bash
> > > > +# FS QA Test No. 701
> > > > +#
> > > > +# Populate filesystem, check that fsmap -n10000 matches fsmap -n1.
> > > > +#
> > > > +#-----------------------------------------------------------------------
> > > > +# Copyright (c) 2017, Oracle and/or its affiliates.  All Rights Reserved.
> > > > +#
> > > > +# This program is free software; you can redistribute it and/or
> > > > +# modify it under the terms of the GNU General Public License as
> > > > +# published by the Free Software Foundation.
> > > > +#
> > > > +# This program is distributed in the hope that it would be useful,
> > > > +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> > > > +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > > > +# GNU General Public License for more details.
> > > > +#
> > > > +# You should have received a copy of the GNU General Public License
> > > > +# along with this program; if not, write the Free Software Foundation,
> > > > +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> > > > +#-----------------------------------------------------------------------
> > > > +
> > > > +seq=`basename "$0"`
> > > > +seqres="$RESULT_DIR/$seq"
> > > > +echo "QA output created by $seq"
> > > > +
> > > > +here=`pwd`
> > > > +tmp=/tmp/$$
> > > > +status=1    # failure is the default!
> > > > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > > > +
> > > > +_cleanup()
> > > > +{
> > > > +	cd /
> > > > +	rm -f "$tmp".* $TEST_DIR/a $TEST_DIR/b
> > > > +}
> > > > +
> > > > +# get standard environment, filters and checks
> > > > +. ./common/rc
> > > > +. ./common/filter
> > > > +. ./common/populate
> > > > +
> > > > +# real QA test starts here
> > > > +_supported_os Linux
> > > > +_supported_fs ext4
> > > > +_require_scratch
> > > > +_require_populate_commands
> > > > +_require_xfs_io_command "fsmap"
> > > > +
> > > > +rm -f "$seqres.full"
> > > > +
> > > > +echo "Format and mount"
> > > > +_scratch_populate_cached nofill > $seqres.full 2>&1
> > > 
> > > This test would take very long time for me to finish, it's been running
> > > for 1 hour and it's still running. Seems like there're too many extents
> > > to report.
> > > 
> > > [root@ibm-x3550m3-05 xfsprogs-dev]# du -hs /mnt/testarea/test/a
> > > 163M    /mnt/testarea/test/a
> > > [root@ibm-x3550m3-05 xfsprogs-dev]# wc -l /mnt/testarea/test/a
> > > 3170842 /mnt/testarea/test/a
> > > 
> > > I digged into it a bit, it was _scratch_populate_cached that restored a
> > > ext4 image with external journal to current test, which has no external
> > > log used (because I ran this test first with external journal set), so
> > > _scratch_mount failed to mount SCRATCH_DEV and fsmap works on rootfs,
> > > which resulted in very long extents list.
> > > 
> > > I think we should take LOGDEV into account when deciding if cached fs
> > > image should be used, e.g. I did this update to common/populate and test
> > > worked fine for me.
> > > 
> > > -       meta_descr="FSTYP ${FSTYP} MKFS_OPTIONS ${MKFS_OPTIONS} SIZE $(blockdev --getsz "${SCRATCH_DEV}") ARGS $@"
> > > +       meta_descr="FSTYP ${FSTYP} MKFS_OPTIONS ${MKFS_OPTIONS} SIZE $(blockdev --getsz "${SCRATCH_DEV}") LOGDEV ${SCRATCH_LOGDEV} USE_EXTERNAL ${USE_EXTERNAL} ARGS $@"
> > 
> > Yes, though for XFS please add the rtdev configuration too.  I think
> > maybe something like this:
> > 
> > case "${FSTYP}" in
> > "ext4")
> > 	extra_descr="LOGDEV ${SCRATCH_LOGDEV} USE_EXTERNAL ${USE_EXTERNAL}";;
> > "xfs")
> > 	extra_descr="LOGDEV ${SCRATCH_LOGDEV} USE_EXTERNAL ${USE_EXTERNAL} RTDEV ${SCRATCH_RTDEV}";;
> > "btrfs")
> > 	extra_descr="<multi-device configuration here>...";;
> > *)
> > 	extra_descr=
> > 	;;
> > esac
> 
> Yeah, this looks better. Would like to do this update in your next
> version? :)

I guess I can roll it up for my next patchbomb.

--D

> 
> Thanks,
> Eryu



