Received: from mx1.redhat.com ([209.132.183.28]:33580 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751926AbeAOG3b (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 15 Jan 2018 01:29:31 -0500
Date: Mon, 15 Jan 2018 14:29:29 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v2 2/2] xfs: Regression test for invalid sb_logsunit
Message-ID: <20180115062929.GB3102@eguan.usersys.redhat.com>
References: <20180111180734.GD1168@magnolia>
 <1515737783-2061-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1515737783-2061-2-git-send-email-yangx.jy@cn.fujitsu.com>
 <20180112074921.GP5123@eguan.usersys.redhat.com>
 <20180112083605.GE27323@dastard>
 <20180112085005.GQ5123@eguan.usersys.redhat.com>
 <20180113022353.GH27323@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180113022353.GH27323@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: xiao yang <yangx.jy@cn.fujitsu.com>, fstests@vger.kernel.org, darrick.wong@oracle.com
List-ID: <fstests@vger.kernel.org>

On Sat, Jan 13, 2018 at 01:23:53PM +1100, Dave Chinner wrote:
> On Fri, Jan 12, 2018 at 04:50:05PM +0800, Eryu Guan wrote:
> > On Fri, Jan 12, 2018 at 07:36:05PM +1100, Dave Chinner wrote:
> > > On Fri, Jan 12, 2018 at 03:49:21PM +0800, Eryu Guan wrote:
> > > > On Fri, Jan 12, 2018 at 02:16:23PM +0800, xiao yang wrote:
> > > > > If log stripe unit isn't a multiple of the fs blocksize and mounting,
> > > > > the invalid sb_logsunit leads to crash as soon as we try to write to
> > > > > the log.
> > > > > 
> > > > > Signed-off-by: xiao yang <yangx.jy@cn.fujitsu.com>
> > > > > ---
> > > > >  tests/xfs/437     | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
> > > > >  tests/xfs/437.out |  2 ++
> > > > >  tests/xfs/group   |  1 +
> > > > >  3 files changed, 76 insertions(+)
> > > > >  create mode 100755 tests/xfs/437
> > > > >  create mode 100644 tests/xfs/437.out
> > > > > 
> > > > > diff --git a/tests/xfs/437 b/tests/xfs/437
> > > > > new file mode 100755
> > > > > index 0000000..f2b84ad
> > > > > --- /dev/null
> > > > > +++ b/tests/xfs/437
> > > > > @@ -0,0 +1,73 @@
> > > > > +#! /bin/bash
> > > > > +# FS QA Test No. 437
> > > > > +#
> > > > > +# Regression test for commit:
> > > > > +# 9c92ee2 ("xfs: validate sb_logsunit is a multiple of the fs blocksize")
> > > > > +#
> > > > > +# If log stripe unit isn't a multiple of the fs blocksize and mounting,
> > > > > +# the invalid sb_logsunit leads to crash as soon as we try to write to
> > > > > +# the log.
> > > > > +#
> > > > > +#-----------------------------------------------------------------------
> > > > > +# Copyright (c) 2018 FUJITSU.  All Rights Reserved.
> > > > > +# Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
> > > > > +#
> > > > > +# This program is free software; you can redistribute it and/or
> > > > > +# modify it under the terms of the GNU General Public License as
> > > > > +# published by the Free Software Foundation.
> > > > > +#
> > > > > +# This program is distributed in the hope that it would be useful,
> > > > > +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> > > > > +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > > > > +# GNU General Public License for more details.
> > > > > +#
> > > > > +# You should have received a copy of the GNU General Public License
> > > > > +# along with this program; if not, write the Free Software Foundation,
> > > > > +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> > > > > +#-----------------------------------------------------------------------
> > > > > +
> > > > > +seq=`basename "$0"`
> > > > > +seqres="$RESULT_DIR/$seq"
> > > > > +echo "QA output created by $seq"
> > > > > +
> > > > > +here=`pwd`
> > > > > +tmp=/tmp/$$
> > > > > +status=1    # failure is the default!
> > > > > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > > > > +
> > > > > +_cleanup()
> > > > > +{
> > > > > +	rm -rf $tmp.*
> > > > > +}
> > > > > +
> > > > > +# get standard environment and checks
> > > > > +. ./common/rc
> > > > > +
> > > > > +# real QA test starts here
> > > > > +_supported_os Linux
> > > > > +_supported_fs xfs
> > > > > +_require_scratch
> > > > 
> > > > This test triggers ASSERT failure and warning on debug build, thus
> > > > failed _dmesg_check, I think we need _disable_dmesg_check (and some
> > > > comments) too.
> > > > 
> > > > [1809960.157615] XFS (sda6): log stripe unit 4095 bytes must be a multiple of block size
> > > > [1809960.159228] XFS (sda6): AAIEEE! Log failed size checks. Abort!
> > > > [1809960.160534] XFS: Assertion failed: 0, file: fs/xfs/xfs_log.c, line: 679
> > > > [1809960.162298] WARNING: CPU: 1 PID: 2186 at fs/xfs/xfs_message.c:105 asswarn+0x1e/0x30 [xfs]
> > > 
> > > If it triggers debug asserts which have been put there to catch bugs
> > > in other utilities (like mkfs) on a current upstream debug kernel,
> > > then the test should not be part of the auto and quick groups.
> > 
> > This test corrupts the filesystem on purpose (I didn't make this clear
> > in my last reply, sorry about that), and xfs detects the corruption &
> > refuses the mount instead of crashing. So I think the ASSERT failure is
> > expected on debug build and we just need to ignore it.
> 
> Except that after that assert, the block device is now busy and can't
> be released, so we can't use the scratch device anymore. All tests
> after this assert has been triggered are going to fail because
> the block device is busy....
> 
> That's the whole point of adding debug asserts in cases like this -
> they are supposed to stop test execution in it's tracks and leave a
> corpse to analyse. The auto group regression tests are not supposed
> to take the machine down on normal test configs (i.e.
> CONFIG_XFS_DEBUG=y).

You're right, my test kernel was built with XFS_WARN not XFS_DEBUG, I
missed that the test would crash kernel even on patched kernel on
XFS_DEBUG builds. Thanks for pointing this out!

Eryu
