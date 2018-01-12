Received: from userp2130.oracle.com ([156.151.31.86]:57260 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934044AbeALQmV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 12 Jan 2018 11:42:21 -0500
Date: Fri, 12 Jan 2018 08:41:30 -0800
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v2 2/2] xfs: Regression test for invalid sb_logsunit
Message-ID: <20180112164130.GF5606@magnolia>
References: <20180111180734.GD1168@magnolia>
 <1515737783-2061-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1515737783-2061-2-git-send-email-yangx.jy@cn.fujitsu.com>
 <20180112074921.GP5123@eguan.usersys.redhat.com>
 <20180112083605.GE27323@dastard>
 <20180112085005.GQ5123@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180112085005.GQ5123@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Dave Chinner <david@fromorbit.com>, xiao yang <yangx.jy@cn.fujitsu.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Jan 12, 2018 at 04:50:05PM +0800, Eryu Guan wrote:
> On Fri, Jan 12, 2018 at 07:36:05PM +1100, Dave Chinner wrote:
> > On Fri, Jan 12, 2018 at 03:49:21PM +0800, Eryu Guan wrote:
> > > On Fri, Jan 12, 2018 at 02:16:23PM +0800, xiao yang wrote:
> > > > If log stripe unit isn't a multiple of the fs blocksize and mounting,
> > > > the invalid sb_logsunit leads to crash as soon as we try to write to
> > > > the log.
> > > > 
> > > > Signed-off-by: xiao yang <yangx.jy@cn.fujitsu.com>
> > > > ---
> > > >  tests/xfs/437     | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
> > > >  tests/xfs/437.out |  2 ++
> > > >  tests/xfs/group   |  1 +
> > > >  3 files changed, 76 insertions(+)
> > > >  create mode 100755 tests/xfs/437
> > > >  create mode 100644 tests/xfs/437.out
> > > > 
> > > > diff --git a/tests/xfs/437 b/tests/xfs/437
> > > > new file mode 100755
> > > > index 0000000..f2b84ad
> > > > --- /dev/null
> > > > +++ b/tests/xfs/437
> > > > @@ -0,0 +1,73 @@
> > > > +#! /bin/bash
> > > > +# FS QA Test No. 437
> > > > +#
> > > > +# Regression test for commit:
> > > > +# 9c92ee2 ("xfs: validate sb_logsunit is a multiple of the fs blocksize")
> > > > +#
> > > > +# If log stripe unit isn't a multiple of the fs blocksize and mounting,
> > > > +# the invalid sb_logsunit leads to crash as soon as we try to write to
> > > > +# the log.
> > > > +#
> > > > +#-----------------------------------------------------------------------
> > > > +# Copyright (c) 2018 FUJITSU.  All Rights Reserved.
> > > > +# Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
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
> > > > +	rm -rf $tmp.*
> > > > +}
> > > > +
> > > > +# get standard environment and checks
> > > > +. ./common/rc
> > > > +
> > > > +# real QA test starts here
> > > > +_supported_os Linux
> > > > +_supported_fs xfs
> > > > +_require_scratch
> > > 
> > > This test triggers ASSERT failure and warning on debug build, thus
> > > failed _dmesg_check, I think we need _disable_dmesg_check (and some
> > > comments) too.
> > > 
> > > [1809960.157615] XFS (sda6): log stripe unit 4095 bytes must be a multiple of block size
> > > [1809960.159228] XFS (sda6): AAIEEE! Log failed size checks. Abort!
> > > [1809960.160534] XFS: Assertion failed: 0, file: fs/xfs/xfs_log.c, line: 679
> > > [1809960.162298] WARNING: CPU: 1 PID: 2186 at fs/xfs/xfs_message.c:105 asswarn+0x1e/0x30 [xfs]
> > 
> > If it triggers debug asserts which have been put there to catch bugs
> > in other utilities (like mkfs) on a current upstream debug kernel,
> > then the test should not be part of the auto and quick groups.

This particular assert triggers because we rejected the log geometry
options thta we just read off the disk.  I don't think this scenario is
that much different from a block verifier rejecting a block (two printks
and an assert(0) for a corrupt field seem a bit much to me but clearly
someone wanted that to fail noisily), so I think it better just to
filter this particular assertion.

Frankly I think I'd just as soon get rid of the ASSERT since I've been
moving the disk verifiers away from ASSERT->BUGing on garbage disk
contents.

> This test corrupts the filesystem on purpose (I didn't make this clear
> in my last reply, sorry about that), and xfs detects the corruption &
> refuses the mount instead of crashing. So I think the ASSERT failure is
> expected on debug build and we just need to ignore it.
> 
> And the test reproduces the crash quickly and reliably on buggy kernel
> and passes (if we ignore the ASSERT failure) on patched kernel, it
> serves as a good 'auto' and 'quick' regression test to me.

It ought to be in 'fuzzers' too...

--D

> Thanks,
> Eryu
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
