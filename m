Received: from aserp1040.oracle.com ([141.146.126.69]:31709 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933054AbdCaQLe (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 31 Mar 2017 12:11:34 -0400
Date: Fri, 31 Mar 2017 09:11:26 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v2] generic/418: Add test for fallocate()
 PUNCH_HOLE|KEEP_SIZE
Message-ID: <20170331161126.GB10881@birch.djwong.org>
References: <8044718e71d02568f3fe84fc57478e9ca99b4f1a.1489799266.git.calvinowens@fb.com>
 <20170320063849.GI14226@eguan.usersys.redhat.com>
 <5c0dee13-0fc0-2c25-bdde-2dfc1b24b1e4@fb.com>
 <20170331042456.z6hak722a5ofajp6@Haydn>
 <20170331053039.GJ22845@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170331053039.GJ22845@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Calvin Owens <calvinowens@fb.com>, fstests@vger.kernel.org, kernel-team@fb.com
List-ID: <fstests@vger.kernel.org>

On Fri, Mar 31, 2017 at 01:30:39PM +0800, Eryu Guan wrote:
> On Thu, Mar 30, 2017 at 09:24:56PM -0700, Calvin Owens wrote:
> > Verify that punching holes at ends of files does not alter st_size if we
> > pass FALLOC_FL_KEEP_SIZE to fallocate().
> > 
> > Signed-off-by: Calvin Owens <calvinowens@fb.com>
> > ---
> >  tests/generic/418     | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/418.out |  3 +++
> >  tests/generic/group   |  1 +
> >  3 files changed, 67 insertions(+)
> >  create mode 100755 tests/generic/418
> >  create mode 100644 tests/generic/418.out
> > 
> > diff --git a/tests/generic/418 b/tests/generic/418
> > new file mode 100755
> > index 0000000..e04d08c
> > --- /dev/null
> > +++ b/tests/generic/418
> > @@ -0,0 +1,63 @@
> > +#! /bin/bash
> > +# FS QA Test 418
> > +#
> > +# Verify fallocate(mode=FALLOC_FL_KEEP_SIZE|FALLOC_FL_PUNCH_HOLE) does
> > +# not alter the file size.
> > +#
> > +#-----------------------------------------------------------------------
> > +# Copyright (c) 2017 Calvin Owens.  All Rights Reserved.
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
> > +_supported_fs generic
> > +_supported_os Linux
> > +_require_test

I think this test needs a "_require_xfs_io_command fpunch".

> > +
> > +testfile="${TEST_DIR}/testfile"
> > +
> > +echo "Testing fallocate(mode=FALLOC_FL_KEEP_SIZE|FALLOC_FL_PUNCH_HOLE)"
> > +$XFS_IO_PROG -fc "pwrite -b 2048 0 2048" $testfile
> 
> Need to either discard the stdout or filter stdout then update .out
> file, otherwise test fails with
> 
>     +wrote 2048/2048 bytes at offset 0
>     +2 KiB, 1 ops; 0.0000 sec (122 MiB/sec and 62500.0000 ops/sec)
> 
> I think discarding stdout is sufficient, any pwrite error to stderr will
> break golden image and fail the test.
> 
> $XFS_IO_PROG -fc "pwrite -b 2048 0 2048" $testfile >/dev/null
> 
> > +$XFS_IO_PROG -c "fpunch 2048 2048" $testfile
> > +$XFS_IO_PROG -c "stat" $testfile 2>/dev/null | grep -F 'stat.size'
> 
> Minor nit, I'd rather not discarding stderr, with similar reason above.
> 
> These are straightforward updates, I can fix them at commit time if
> you're OK with the fixes.

Usually we toss the xfs_io stdout stuff into $seqres.full so that it's
recorded somewhere just in case someone wants to see what xfs_io thinks
it did.

--D

> 
> Thanks,
> Eryu
> 
> > +
> > +# success, all done
> > +status=0
> > +exit
> > diff --git a/tests/generic/418.out b/tests/generic/418.out
> > new file mode 100644
> > index 0000000..9927731
> > --- /dev/null
> > +++ b/tests/generic/418.out
> > @@ -0,0 +1,3 @@
> > +QA output created by 418
> > +Testing fallocate(mode=FALLOC_FL_KEEP_SIZE|FALLOC_FL_PUNCH_HOLE)
> > +stat.size = 2048
> > diff --git a/tests/generic/group b/tests/generic/group
> > index f0096bb..068aa61 100644
> > --- a/tests/generic/group
> > +++ b/tests/generic/group
> > @@ -420,3 +420,4 @@
> >  415 auto clone
> >  416 auto enospc
> >  417 auto quick shutdown log
> > +418 auto quick punch
> > -- 
> > 2.9.3
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
