Received: from mx1.redhat.com ([209.132.183.28]:43564 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751116AbcAKLwf (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 11 Jan 2016 06:52:35 -0500
Date: Mon, 11 Jan 2016 06:52:33 -0500
From: Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCH v2] xfs: test XFS torn log write detection
Message-ID: <20160111115233.GA31956@bfoster.bfoster>
References: <1451923421-16647-1-git-send-email-bfoster@redhat.com>
 <20160111040435.GH10456@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160111040435.GH10456@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

On Mon, Jan 11, 2016 at 03:04:35PM +1100, Dave Chinner wrote:
> On Mon, Jan 04, 2016 at 11:03:41AM -0500, Brian Foster wrote:
> > XFS torn log write detection includes a mechanism to inject CRC errors
> > into log records at runtime and shutdown the fs accordingly. This
> > ensures that the CRC verification pass on the subsequent mount discovers
> > an invalid record near the head of the log and considers it a torn
> > write.
> > 
> > This test runs a workload with error injection enabled and verifies that
> > the subsequent mount is successful. The test repeats for several
> > iterations using a random frequency factor for the error event each
> > time.
> > 
> > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > ---
> > 
> > Here's a v2 of the XFS log crc verification test case now that the
> > associated kernel code has been merged. The only change is the bugfix
> > noted in the changelog below.
> > 
> > Brian
> > 
> > v2:
> > - Update random failure frequency calculation to ensure factor is never
> >   0.
> > v1: http://article.gmane.org/gmane.comp.file-systems.fstests/1406
> > 
> >  tests/xfs/350     | 85 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  tests/xfs/350.out |  2 ++
> >  tests/xfs/group   |  1 +
> >  3 files changed, 88 insertions(+)
> >  create mode 100755 tests/xfs/350
> >  create mode 100644 tests/xfs/350.out
> > 
> > diff --git a/tests/xfs/350 b/tests/xfs/350
> > new file mode 100755
> > index 0000000..1a1de6f
> > --- /dev/null
> > +++ b/tests/xfs/350
> > @@ -0,0 +1,85 @@
> > +#! /bin/bash
> > +# FS QA Test No. 350
> > +#
> > +# Use the XFS log record CRC error injection mechanism to test torn writes to
> > +# the log. The error injection mechanism writes an invalid CRC and shuts down
> > +# the filesystem. The test verifies that a subsequent remount recovers the log
> > +# and that the filesystem is consistent.
> > +#
> > +# Note that this test requires a DEBUG mode kernel.
> > +#
> > +#-----------------------------------------------------------------------
> > +# Copyright (c) 2015 Red Hat, Inc. All Rights Reserved.
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
> > +#-----------------------------------------------------------------------
> > +#
> > +
> > +seq=`basename $0`
> > +seqres=$RESULT_DIR/$seq
> > +echo "QA output created by $seq"
> > +
> > +here=`pwd`
> > +tmp=/tmp/$$
> > +status=1	# failure is the default!
> > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > +
> > +_cleanup()
> > +{
> > +	cd /
> > +	rm -f $tmp.*
> > +	killall -9 fsstress > /dev/null 2>&1
> > +	wait > /dev/null 2>&1
> > +}
> > +
> > +rm -f $seqres.full
> > +
> > +# get standard environment, filters and checks
> > +. ./common/rc
> > +
> > +# real QA test starts here
> > +
> > +# Modify as appropriate.
> > +_supported_fs xfs
> > +_supported_os Linux
> > +_require_xfs_sysfs $(_short_dev $SCRATCH_DEV)/log/log_badcrc_factor
> 
> Scratch is not mounted at this point, so I don't think you can test
> the scratch device sysfs attrs here. I changed it to look at the
> test device instead and it works fine.
> 

Oops, thought I tested that. :/ Thanks.

Brian

> Cheers,
> 
> Dave.
> 
> -- 
> Dave Chinner
> david@fromorbit.com
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
