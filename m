Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59135 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751521AbbEFHcy (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 6 May 2015 03:32:54 -0400
Date: Wed, 6 May 2015 15:32:51 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] generic/081: wait for lv to be settled before creating
 fs on it
Message-ID: <20150506073251.GF1187@dhcp-13-216.nay.redhat.com>
References: <1428054075-20780-1-git-send-email-eguan@redhat.com>
 <20150504062708.GF15810@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150504062708.GF15810@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, May 04, 2015 at 04:27:08PM +1000, Dave Chinner wrote:
> On Fri, Apr 03, 2015 at 05:41:15PM +0800, Eryu Guan wrote:
> > Call 'udevadm settle' or 'udevsettle' or 'sleep 1' to make sure new lv
> > is ready for use before making filesystem on it, depends on which
> > command is available on the system.
> > 
> > Also sleep 1 before removing the test vg, as the snapshot may block the
> > test vg from removal for a while.
> > 
> > Signed-off-by: Eryu Guan <eguan@redhat.com>
> > ---
> >  tests/generic/081 | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> > 
> > diff --git a/tests/generic/081 b/tests/generic/081
> > index e242c4c..8e1828b 100755
> > --- a/tests/generic/081
> > +++ b/tests/generic/081
> > @@ -36,6 +36,9 @@ _cleanup()
> >  	rm -f $tmp.*
> >  	# lvm may have umounted it on I/O error, but in case it does not
> >  	$UMOUNT_PROG $mnt >/dev/null 2>&1
> > +	# fsync from xfs_io pins the snapshot in use for a while and blocks
> > +	# vgremove, sleep 1 to avoid such failure
> > +	sleep 1
> 
> Doesn't this indicate a bug in the LVM code? unmount flushes block
> device caches, so there should be no IO remaining on the device
> pinning it when unmount completes, right?

Maybe, I'm not sure here.. But it does cause problems to fstests, I have
two workarounds now, adding sleep 1 before removing vg, delete fsync
from xfs_io command. I preper to delete fsync, as bug is still
reproducible without it and no extra workaround(sleep 1) is needed.

What do you think?

> 
> >  	$LVM_PROG vgremove -f $vgname >>$seqres.full 2>&1
> >  	$LVM_PROG pvremove -f $SCRATCH_DEV >>$seqres.full 2>&1
> >  }
> > @@ -62,11 +65,30 @@ snapname=snap_$seq
> >  mnt=$TEST_DIR/mnt_$seq
> >  mkdir -p $mnt
> >  
> > +# use 'udevadm settle' or 'udevsettle' to wait for lv to be settled.
> > +# newer systems have udevadm command but older systems like RHEL5 don't.
> > +# But if neither one is available, just set it to "sleep 1" to wait for lv to
> > +# be settled
> > +UDEV_SETTLE_PROG="`set_prog_path udevadm`"
> > +if [ "$UDEV_SETTLE_PROG" == "" ]; then
> > +	# try udevsettle command
> > +	UDEV_SETTLE_PROG="`set_prog_path udevsettle`"
> > +else
> > +	# udevadm is available, add 'settle' as subcommand
> > +	UDEV_SETTLE_PROG="$UDEV_SETTLE_PROG settle"
> > +fi
> > +# neither command is available, use sleep 1
> > +if [ "$UDEV_SETTLE_PROG" == "" ]; then
> > +	UDEV_SETTLE_PROG="sleep 1"
> > +fi
> > +
> 
> This should probably go into common/config....

Makes sense.

> 
> >  # make sure there's enough disk space for 256M lv, test for 300M here in case
> >  # lvm uses some space for metadata
> >  _scratch_mkfs_sized $((300 * 1024 * 1024)) >>$seqres.full 2>&1
> >  $LVM_PROG vgcreate -f $vgname $SCRATCH_DEV >>$seqres.full 2>&1
> >  $LVM_PROG lvcreate --yes -L 256M -n $lvname $vgname >>$seqres.full 2>&1
> > +# wait for lv to be settled
> > +$UDEV_SETTLE_PROG >>$seqres.full 2>&1
> 
> "# wait for lvcreation to fully complete"

Thanks!

Eryu
