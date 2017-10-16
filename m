Received: from userp1040.oracle.com ([156.151.31.81]:29362 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752418AbdJPR7J (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 16 Oct 2017 13:59:09 -0400
Date: Mon, 16 Oct 2017 10:59:04 -0700
From: Liu Bo <bo.li.liu@oracle.com>
Subject: Re: [PATCH v2] Fstest: btrfs/151: test if device delete ends up with
 losing raid profile
Message-ID: <20171016175904.GB2516@localhost.localdomain>
Reply-To: bo.li.liu@oracle.com
References: <20171009173921.12569-1-bo.li.liu@oracle.com>
 <20171013194005.13500-1-bo.li.liu@oracle.com>
 <20171014053317.GU10593@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171014053317.GU10593@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sat, Oct 14, 2017 at 01:33:17PM +0800, Eryu Guan wrote:
> On Fri, Oct 13, 2017 at 01:40:05PM -0600, Liu Bo wrote:
> > Currently running 'btrfs device delete' can end up with losing data
> > raid profile (if any), this test is to reproduce the problem.
> > 
> > The fix is
> >      "Btrfs: avoid losing data raid profile when deleting a device"
> > 
> > Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
> > ---
> >  tests/btrfs/151     | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  tests/btrfs/151.out |  2 ++
> >  tests/btrfs/group   |  1 +
> >  3 files changed, 76 insertions(+)
> >  create mode 100755 tests/btrfs/151
> >  create mode 100644 tests/btrfs/151.out
> > 
> > diff --git a/tests/btrfs/151 b/tests/btrfs/151
> > new file mode 100755
> > index 0000000..1866cb6
> > --- /dev/null
> > +++ b/tests/btrfs/151
> > @@ -0,0 +1,73 @@
> > +#! /bin/bash
> > +# FS QA Test 151
> > +#
> > +# Test if it's losing data chunk's raid profile after 'btrfs device
> > +# remove'.
> > +#
> > +# The fix is
> > +#	Btrfs: avoid losing data raid profile when deleting a device
> > +#
> > +#-----------------------------------------------------------------------
> > +# Copyright (c) 2017 Oracle.  All Rights Reserved.
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
> > +}
> > +
> > +# get standard environment, filters and checks
> > +. ./common/rc
> > +. ./common/filter
> > +
> > +# remove previous $seqres.full before test
> > +rm -f $seqres.full
> > +
> > +# real QA test starts here
> > +
> > +# Modify as appropriate.
> > +_supported_fs btrfs
> > +_supported_os Linux
> > +_require_scratch
> > +_require_scratch_dev_pool 3
> > +
> > +# create raid1 for data
> > +_scratch_pool_mkfs "-d raid1 -b 1G" >> $seqres.full 2>&1
> > +
> > +# we need an empty data chunk, so nospace_cache is required.
> > +_scratch_mount -onospace_cache
> > +
> > +# if data chunk is empty, 'btrfs device remove' can change raid1 to
> > +# single.
> > +$BTRFS_UTIL_PROG device delete 2 $SCRATCH_MNT >> $seqres.full
> > +
> > +df_ret=`$BTRFS_UTIL_PROG filesystem df $SCRATCH_MNT`
> > +echo $df_ret | $AWK_PROG -F ':' '/Data,/ {print $1}'
> 
> Forgot to commit the changes before sending? It looks like the same as v1.
>

Sorry for the trouble, I've sent a 'PATCH v2 RESEND' for review.

Thanks,

-liubo
