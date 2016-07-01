Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:45732 "EHLO
	ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751830AbcGABin (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 30 Jun 2016 21:38:43 -0400
Date: Fri, 1 Jul 2016 11:31:52 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 1/2] xfstests: support dm-delay to introduce I/O delays
Message-ID: <20160701013152.GX27480@dastard>
References: <1467290974-13203-1-git-send-email-bfoster@redhat.com>
 <1467290974-13203-2-git-send-email-bfoster@redhat.com>
 <20160630131922.GC23649@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160630131922.GC23649@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Brian Foster <bfoster@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Jun 30, 2016 at 09:19:22PM +0800, Eryu Guan wrote:
> On Thu, Jun 30, 2016 at 08:49:33AM -0400, Brian Foster wrote:
> > Add some infrastructure in common/dmdelay to support use of the dm-delay
> > device-mapper module within tests. This is effectively copied from the
> > existing infrastructure in common/dmflakey. This provides the ability to
> > delay I/O. It only supports delaying read I/O as that is all that is
> > required at this point in time.
> > 
> > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > ---
> >  common/dmdelay | 89 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 89 insertions(+)
> >  create mode 100644 common/dmdelay
> > 
> > diff --git a/common/dmdelay b/common/dmdelay
> > new file mode 100644
> > index 0000000..c53e2dd
> > --- /dev/null
> > +++ b/common/dmdelay
> > @@ -0,0 +1,89 @@
> > +##/bin/bash
> > +#
> > +# Copyright (c) 2016 Red Hat, Inc.  All Rights Reserved.
> > +#
> > +# This program is free software; you can redistribute it and/or
> > +# modify it under the terms of the GNU General Public License as
> > +# published by the Free Software Foundation.
> > +#
> > +# This program is distributed in the hope that it would be useful,
> > +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> > +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > +# GNU General Public License for more details.
> > +#
> > +# You should have received a copy of the GNU General Public License
> > +# along with this program; if not, write the Free Software Foundation,
> > +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> > +#
> > +#
> > +# common functions for setting up and tearing down a dmdelay device
> > +
> > +DELAY_NONE=0
> > +DELAY_READ=1
> > +
> > +echo $MOUNT_OPTIONS | grep -q dax
> > +if [ $? -eq 0 ]; then
> > +	_notrun "Cannot run tests with DAX on dmdelay devices"
> > +fi
> > +
> > +_init_delay()
> > +{
> > +	local BLK_DEV_SIZE=`blockdev --getsz $SCRATCH_DEV`
> > +	DELAY_DEV=/dev/mapper/delay-test
> > +	DELAY_TABLE="0 $BLK_DEV_SIZE delay $SCRATCH_DEV 0 0"
> > +	DELAY_TABLE_RDELAY="0 $BLK_DEV_SIZE delay $SCRATCH_DEV 0 10000 $SCRATCH_DEV 0 0"
> > +	$DMSETUP_PROG create delay-test --table "$DELAY_TABLE" || \
> > +		_fatal "failed to create delay device"
> > +	$DMSETUP_PROG mknodes > /dev/null 2>&1
> > +}
> > +
> > +_mount_delay()
> > +{
> > +	_scratch_options mount
> > +	mount -t $FSTYP $SCRATCH_OPTIONS $MOUNT_OPTIONS $DELAY_DEV $SCRATCH_MNT
> 
> I replaced mount with $MOUNT_PROG :)

Shouldn't this also be using _common_dev_mount_options()?, as per
_scratch_mount_options?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
