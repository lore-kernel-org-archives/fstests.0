Received: from aserp1040.oracle.com ([141.146.126.69]:23565 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750774AbdAXGpb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 24 Jan 2017 01:45:31 -0500
Date: Mon, 23 Jan 2017 22:45:25 -0800
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] xfs: test xfs_db source command
Message-ID: <20170124064525.GH4780@birch.djwong.org>
References: <20170123215750.GO14033@birch.djwong.org>
 <20170124043708.GE1859@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170124043708.GE1859@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Tue, Jan 24, 2017 at 12:37:08PM +0800, Eryu Guan wrote:
> On Mon, Jan 23, 2017 at 01:57:50PM -0800, Darrick J. Wong wrote:
> > Make sure that the 'source' command works correctly whether supplied
> > via command line or interactive prompt.
> > 
> > You probably want "xfs_db: fix the 'source' command when passed as a -c
> > option" in xfsprogs.
> > 
> > Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> > ---
> >  tests/xfs/400     |   69 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  tests/xfs/400.out |   11 ++++++++
> >  tests/xfs/group   |    1 +
> >  3 files changed, 81 insertions(+)
> >  create mode 100755 tests/xfs/400
> >  create mode 100644 tests/xfs/400.out
> > 
> > diff --git a/tests/xfs/400 b/tests/xfs/400
> > new file mode 100755
> > index 0000000..a11ea12
> > --- /dev/null
> > +++ b/tests/xfs/400
> > @@ -0,0 +1,69 @@
> > +#! /bin/bash
> > +# FS QA Test No. 400
> > +#
> > +# Test nesting the 'source' command in xfs_db via -c and interactive.
> > +#
> > +#-----------------------------------------------------------------------
> > +# Copyright (c) 2017 Oracle, Inc.  All Rights Reserved.
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
> > +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1303  USA
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
> > +trap "_cleanup; exit \$status" 0 1 2 3 7 15
> > +
> > +_cleanup()
> > +{
> > +	cd /
> > +	rm -rf $tmp.* $seqres.a $seqres.b
> > +}
> > +
> > +# get standard environment, filters and checks
> > +. ./common/rc
> > +
> > +# real QA test starts here
> > +_supported_os Linux
> > +_supported_fs xfs
> > +_require_scratch
> > +
> > +cat > $seqres.a << ENDL
> > +echo This is file A
> > +source $seqres.b
> > +ENDL
> > +cat > $seqres.b << ENDL
> > +echo This is file B
> > +ENDL
> 
> Seems $seqres.a/b should really be $tmp.a/b, they're used and cleaned up
> after test. I think $seqres.* is something can be saved after test for
> future reference.
> 
> I can fix them at commit time. Otherwise looks good to me.

Ok, thanks.

--D

> 
> Thanks,
> Eryu
