Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:15690 "EHLO
	ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751294AbbEFXNV (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 6 May 2015 19:13:21 -0400
Date: Thu, 7 May 2015 09:13:18 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] generic/081: wait for lv to be settled before creating
 fs on it
Message-ID: <20150506231318.GK21261@dastard>
References: <1428054075-20780-1-git-send-email-eguan@redhat.com>
 <20150504062708.GF15810@dastard>
 <20150506073251.GF1187@dhcp-13-216.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150506073251.GF1187@dhcp-13-216.nay.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, May 06, 2015 at 03:32:51PM +0800, Eryu Guan wrote:
> On Mon, May 04, 2015 at 04:27:08PM +1000, Dave Chinner wrote:
> > On Fri, Apr 03, 2015 at 05:41:15PM +0800, Eryu Guan wrote:
> > > Call 'udevadm settle' or 'udevsettle' or 'sleep 1' to make sure new lv
> > > is ready for use before making filesystem on it, depends on which
> > > command is available on the system.
> > > 
> > > Also sleep 1 before removing the test vg, as the snapshot may block the
> > > test vg from removal for a while.
> > > 
> > > Signed-off-by: Eryu Guan <eguan@redhat.com>
> > > ---
> > >  tests/generic/081 | 22 ++++++++++++++++++++++
> > >  1 file changed, 22 insertions(+)
> > > 
> > > diff --git a/tests/generic/081 b/tests/generic/081
> > > index e242c4c..8e1828b 100755
> > > --- a/tests/generic/081
> > > +++ b/tests/generic/081
> > > @@ -36,6 +36,9 @@ _cleanup()
> > >  	rm -f $tmp.*
> > >  	# lvm may have umounted it on I/O error, but in case it does not
> > >  	$UMOUNT_PROG $mnt >/dev/null 2>&1
> > > +	# fsync from xfs_io pins the snapshot in use for a while and blocks
> > > +	# vgremove, sleep 1 to avoid such failure
> > > +	sleep 1
> > 
> > Doesn't this indicate a bug in the LVM code? unmount flushes block
> > device caches, so there should be no IO remaining on the device
> > pinning it when unmount completes, right?
> 
> Maybe, I'm not sure here.. But it does cause problems to fstests, I have
> two workarounds now, adding sleep 1 before removing vg, delete fsync
> from xfs_io command. I preper to delete fsync, as bug is still
> reproducible without it and no extra workaround(sleep 1) is needed.
> 
> What do you think?

I think the bug should be triaged and fixed, not hidden by changing
or removing something from the test. I'd suggest trying to find what
the fsync is pinning in the filesyste/block device....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
