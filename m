Received: from mx1.redhat.com ([209.132.183.28]:40406 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752245AbcF3N4S (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 30 Jun 2016 09:56:18 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BAD0DD4D84
	for <fstests@vger.kernel.org>; Thu, 30 Jun 2016 13:47:27 +0000 (UTC)
Date: Thu, 30 Jun 2016 21:47:25 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 1/2] xfstests: support dm-delay to introduce I/O delays
Message-ID: <20160630134725.GF23649@eguan.usersys.redhat.com>
References: <1467290974-13203-1-git-send-email-bfoster@redhat.com>
 <1467290974-13203-2-git-send-email-bfoster@redhat.com>
 <20160630131922.GC23649@eguan.usersys.redhat.com>
 <20160630134402.GA1055@laptop.bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160630134402.GA1055@laptop.bfoster>
Sender: fstests-owner@vger.kernel.org
To: Brian Foster <bfoster@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Jun 30, 2016 at 09:44:02AM -0400, Brian Foster wrote:
> On Thu, Jun 30, 2016 at 09:19:22PM +0800, Eryu Guan wrote:
> > On Thu, Jun 30, 2016 at 08:49:33AM -0400, Brian Foster wrote:
> > > Add some infrastructure in common/dmdelay to support use of the dm-delay
> > > device-mapper module within tests. This is effectively copied from the
> > > existing infrastructure in common/dmflakey. This provides the ability to
> > > delay I/O. It only supports delaying read I/O as that is all that is
> > > required at this point in time.
> > > 
> > > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > > ---
> > >  common/dmdelay | 89 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 89 insertions(+)
> > >  create mode 100644 common/dmdelay
> > > 
> > > diff --git a/common/dmdelay b/common/dmdelay
> > > new file mode 100644
> > > index 0000000..c53e2dd
> > > --- /dev/null
> > > +++ b/common/dmdelay
> > > @@ -0,0 +1,89 @@
> > > +##/bin/bash
> > > +#
> > > +# Copyright (c) 2016 Red Hat, Inc.  All Rights Reserved.
> > > +#
> > > +# This program is free software; you can redistribute it and/or
> > > +# modify it under the terms of the GNU General Public License as
> > > +# published by the Free Software Foundation.
> > > +#
> > > +# This program is distributed in the hope that it would be useful,
> > > +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> > > +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > > +# GNU General Public License for more details.
> > > +#
> > > +# You should have received a copy of the GNU General Public License
> > > +# along with this program; if not, write the Free Software Foundation,
> > > +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> > > +#
> > > +#
> > > +# common functions for setting up and tearing down a dmdelay device
> > > +
> > > +DELAY_NONE=0
> > > +DELAY_READ=1
> > > +
> > > +echo $MOUNT_OPTIONS | grep -q dax
> > > +if [ $? -eq 0 ]; then
> > > +	_notrun "Cannot run tests with DAX on dmdelay devices"
> > > +fi
> > > +
> > > +_init_delay()
> > > +{
> > > +	local BLK_DEV_SIZE=`blockdev --getsz $SCRATCH_DEV`
> > > +	DELAY_DEV=/dev/mapper/delay-test
> > > +	DELAY_TABLE="0 $BLK_DEV_SIZE delay $SCRATCH_DEV 0 0"
> > > +	DELAY_TABLE_RDELAY="0 $BLK_DEV_SIZE delay $SCRATCH_DEV 0 10000 $SCRATCH_DEV 0 0"
> > > +	$DMSETUP_PROG create delay-test --table "$DELAY_TABLE" || \
> > > +		_fatal "failed to create delay device"
> > > +	$DMSETUP_PROG mknodes > /dev/null 2>&1
> > > +}
> > > +
> > > +_mount_delay()
> > > +{
> > > +	_scratch_options mount
> > > +	mount -t $FSTYP $SCRATCH_OPTIONS $MOUNT_OPTIONS $DELAY_DEV $SCRATCH_MNT
> > 
> > I replaced mount with $MOUNT_PROG :)
> > 
> 
> Thanks.
> 
> > > +}
> > > +
> > > +_unmount_delay()
> > > +{
> > > +	$UMOUNT_PROG $SCRATCH_MNT
> > > +}
> > > +
> > > +_cleanup_delay()
> > > +{
> > > +	# If dmsetup load fails then we need to make sure to do resume here
> > > +	# otherwise the umount will hang
> > > +	$DMSETUP_PROG resume delay-test > /dev/null 2>&1
> > > +	$UMOUNT_PROG $SCRATCH_MNT > /dev/null 2>&1
> > > +	# wait for device to be fully settled so that 'dmsetup remove' doesn't
> > > +	# fail due to EBUSY
> > > +	$UDEV_SETTLE_PROG >/dev/null 2>&1
> > > +	$DMSETUP_PROG remove delay-test > /dev/null 2>&1
> > > +	$DMSETUP_PROG mknodes > /dev/null 2>&1
> > > +}
> > > +
> > > +# _load_delay_table <table> [lockfs]
> > > +#
> > > +# This defaults to --nolockfs, which doesn't freeze_fs() before loading the new
> > > +# table, so it simulates power failure.
> > 
> > Seems this comment is for dmflakey and needs update. Can you please
> > confirm? I can fix it at commit time if needs update, no v2 is needed.
> > 
> 
> Hmm, the command itself is part of the dmsetup suspend command, but the
> power failure bit is probably not relevant since we aren't dropping
> I/Os. We could just kill that part of the comment (everything after the
> comma)..?

Looks fine to me. Updated and committed. Thanks for the test!

Eryu
