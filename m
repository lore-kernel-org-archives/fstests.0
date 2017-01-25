Received: from mx1.redhat.com ([209.132.183.28]:37968 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751875AbdAYKYV (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 25 Jan 2017 05:24:21 -0500
Date: Wed, 25 Jan 2017 18:24:20 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] btrfs: add regression test for setxattr on subvolume
 directory
Message-ID: <20170125102420.GJ1859@eguan.usersys.redhat.com>
References: <28ac6254ad926413836489a46cbf14497f4802ed.1485327013.git.osandov@fb.com>
 <20170125092024.GH1859@eguan.usersys.redhat.com>
 <60fac92f-8918-2517-7cad-e8ba9cfe4774@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60fac92f-8918-2517-7cad-e8ba9cfe4774@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Qu Wenruo <quwenruo@cn.fujitsu.com>
Cc: Omar Sandoval <osandov@osandov.com>, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, kernel-team@fb.com
List-ID: <fstests@vger.kernel.org>

On Wed, Jan 25, 2017 at 05:30:32PM +0800, Qu Wenruo wrote:
> 
> 
> At 01/25/2017 05:20 PM, Eryu Guan wrote:
> > On Tue, Jan 24, 2017 at 10:50:29PM -0800, Omar Sandoval wrote:
> > > From: Omar Sandoval <osandov@fb.com>
> > > 
> > > This is a regression test for "Btrfs: disable xattr operations on
> > > subvolume directories". On v4.9, it will result in an aborted
> > > transaction.
> > > 
> > > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > 
> > Looks good to me overall, tested with 4.10-rc5 kernel with and without
> > the proposed kernel fix, results are all as expected. Some minor issues
> > inline.
> > 
> > > ---
> > >  tests/btrfs/047     | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  tests/btrfs/047.out |  2 ++
> > >  tests/btrfs/group   |  1 +
> > >  3 files changed, 72 insertions(+)
> > >  create mode 100644 tests/btrfs/047
> > 
> > Better to add new test with mode 755, otherwise git diff shows mode
> > changes after tests being run.
> > 
> > >  create mode 100644 tests/btrfs/047.out
> > > 
> > > diff --git a/tests/btrfs/047 b/tests/btrfs/047
> > > new file mode 100644
> > > index 00000000..c3222f8b
> > > --- /dev/null
> > > +++ b/tests/btrfs/047
> > > @@ -0,0 +1,69 @@
> > > +#! /bin/bash
> > > +# FS QA Test 047
> > > +#
> > > +# Test that we can't set xattrs on read-only subvolume placeholder directories.
> > > +# Regression test for Btrfs: disable xattr operations on subvolume directories.
> > > +#
> > > +#-----------------------------------------------------------------------
> > > +# Copyright (c) 2017 Facebook.  All Rights Reserved.
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
> > > +#-----------------------------------------------------------------------
> > > +#
> > > +
> > > +seq=`basename $0`
> > > +seqres=$RESULT_DIR/$seq
> > > +echo "QA output created by $seq"
> > > +
> > > +here=`pwd`
> > > +tmp=/tmp/$$
> > > +status=1	# failure is the default!
> > > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > > +
> > > +_cleanup()
> > > +{
> > > +	cd /
> > > +	rm -f $tmp.*
> > > +}
> > > +
> > > +# get standard environment, filters and checks
> > > +. ./common/rc
> > > +. ./common/filter
> > > +. ./common/attr
> > > +
> > > +# remove previous $seqres.full before test
> > > +rm -f $seqres.full
> > > +
> > > +# real QA test starts here
> > > +
> > > +_supported_fs btrfs
> > > +_supported_os Linux
> > > +_require_attrs
> > > +_require_scratch
> > > +
> > > +_scratch_mkfs >/dev/null 2>&1
> > > +_scratch_mount
> > > +
> > > +_run_btrfs_util_prog subvolume create "$SCRATCH_MNT/parent"
> > > +_run_btrfs_util_prog subvolume create "$SCRATCH_MNT/parent/child"
> > > +_run_btrfs_util_prog subvolume snapshot "$SCRATCH_MNT/parent" "$SCRATCH_MNT/snapshot"
> > 
> > Please avoid using "run_check" (called by _run_btrfs_util_prog) if
> > possible. We can use $BTRFS_UTIL_PROG directly and throw away stdout or
> > append it to $seqres.full, and stderr from these commands will break the
> > golden image.
> 
> Isn't it designed to use "run_check" to break the test case if it returns
> any thing other than 0?

The whole fstests is built upon the golden image matching mechanism,
it's designed to let you don't have to check the return value of
commands. IMO, this run_check should not be introduced in the first
place. I agree that this "golden image matching" has some problems, e.g.
we have to write lots of filters to make the outputs deterministic, it
has both up and down sides, as well as the "check return value" way. But
that's the way fstests has chosen to go since the beginning.

> 
> IMHO any stderr output should be unexpected in this case.

Yes, so any unexpected output breaks & fails the test, and we can see
why it fails from the diff output. And run_check "hides" this info and
makes it harder to parse the result, e.g.

-setfattr: SCRATCH_MNT/snapshot/child: Operation not supported
+failed: '/usr/local/bin/btrfs filesystem sync /mnt/testarea/scratch'
+(see /root/workspace/xfstests/results//btrfs/btrfs/047.full for details)

And without run_check:

-setfattr: SCRATCH_MNT/snapshot/child: Operation not supported
+ERROR: sync ioctl failed on '/mnt/testarea/scratch': No such file or directory

We know why and where it fails.

Thanks,
Eryu
