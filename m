Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37328 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751677AbbEGDLH (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 6 May 2015 23:11:07 -0400
Date: Thu, 7 May 2015 11:11:03 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] generic/081: wait for lv to be settled before creating
 fs on it
Message-ID: <20150507031103.GI1187@dhcp-13-216.nay.redhat.com>
References: <1428054075-20780-1-git-send-email-eguan@redhat.com>
 <20150504062708.GF15810@dastard>
 <20150506073251.GF1187@dhcp-13-216.nay.redhat.com>
 <20150506231318.GK21261@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150506231318.GK21261@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, May 07, 2015 at 09:13:18AM +1000, Dave Chinner wrote:
> On Wed, May 06, 2015 at 03:32:51PM +0800, Eryu Guan wrote:
> > On Mon, May 04, 2015 at 04:27:08PM +1000, Dave Chinner wrote:
> > > On Fri, Apr 03, 2015 at 05:41:15PM +0800, Eryu Guan wrote:
> > > > Call 'udevadm settle' or 'udevsettle' or 'sleep 1' to make sure new lv
> > > > is ready for use before making filesystem on it, depends on which
> > > > command is available on the system.
> > > > 
> > > > Also sleep 1 before removing the test vg, as the snapshot may block the
> > > > test vg from removal for a while.
> > > > 
> > > > Signed-off-by: Eryu Guan <eguan@redhat.com>
> > > > ---
> > > >  tests/generic/081 | 22 ++++++++++++++++++++++
> > > >  1 file changed, 22 insertions(+)
> > > > 
> > > > diff --git a/tests/generic/081 b/tests/generic/081
> > > > index e242c4c..8e1828b 100755
> > > > --- a/tests/generic/081
> > > > +++ b/tests/generic/081
> > > > @@ -36,6 +36,9 @@ _cleanup()
> > > >  	rm -f $tmp.*
> > > >  	# lvm may have umounted it on I/O error, but in case it does not
> > > >  	$UMOUNT_PROG $mnt >/dev/null 2>&1
> > > > +	# fsync from xfs_io pins the snapshot in use for a while and blocks
> > > > +	# vgremove, sleep 1 to avoid such failure
> > > > +	sleep 1
> > > 
> > > Doesn't this indicate a bug in the LVM code? unmount flushes block
> > > device caches, so there should be no IO remaining on the device
> > > pinning it when unmount completes, right?
> > 
> > Maybe, I'm not sure here.. But it does cause problems to fstests, I have
> > two workarounds now, adding sleep 1 before removing vg, delete fsync
> > from xfs_io command. I preper to delete fsync, as bug is still
> > reproducible without it and no extra workaround(sleep 1) is needed.
> > 
> > What do you think?
> 
> I think the bug should be triaged and fixed, not hidden by changing
> or removing something from the test. I'd suggest trying to find what
> the fsync is pinning in the filesyste/block device....

OK, I'll send out a v3 to get the udevadm settle part in first and leave
this part as it is for now.

(I tried a self-built lvm binary to debug but I couldn't reproduce the
issue with it, and I see the issue in only one of my kvm guests. I'll
dig deeper.)

Thanks,
Eryu
