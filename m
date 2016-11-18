Received: from mail.kernel.org ([198.145.29.136]:36960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751989AbcKRTgY (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 18 Nov 2016 14:36:24 -0500
Date: Fri, 18 Nov 2016 11:36:19 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v2] generic/392: add a testcase to check some inline
 truncation behaviors
Message-ID: <20161118193619.GB31226@jaegeuk>
References: <20161117034715.71966-1-jaegeuk@kernel.org>
 <20161117180436.GB74211@jaegeuk>
 <20161118064306.GG27776@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161118064306.GG27776@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-ID: <fstests@vger.kernel.org>

On Fri, Nov 18, 2016 at 02:43:06PM +0800, Eryu Guan wrote:
> On Thu, Nov 17, 2016 at 10:04:36AM -0800, Jaegeuk Kim wrote:
> > This patch introduces a new testcase to test some small truncations to check
> > inline_data and its cached data are truncated correctly at the same time.
> > 
> > The inline_data feature was introduced in ext4 and f2fs as follows.
> >  ext4 : http://lwn.net/Articles/468678/
> >  f2fs : http://lwn.net/Articles/573408/
> > 
> > The basic idea is embedding small-sized file's data into relatively large
> > inode space.
> > In ext4, up to 132 bytes of data can be stored in 256 bytes-sized inode.
> > In f2fs, up to 3.4KB of data can be embedded into 4KB-sized inode block.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  tests/generic/392     | 128 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/392.out |  45 ++++++++++++++++++
> >  tests/generic/group   |   1 +
> >  3 files changed, 174 insertions(+)
> >  create mode 100644 tests/generic/392
> >  create mode 100644 tests/generic/392.out
> > 
> > diff --git a/tests/generic/392 b/tests/generic/392
> > new file mode 100644
> > index 0000000..c45018a
> > --- /dev/null
> > +++ b/tests/generic/392
> > @@ -0,0 +1,128 @@
> > +#! /bin/bash
> > +# FS QA Test No. generic/392
> > +#
> > +# Test some small truncations to check inline_data and its cached data are
> > +# truncated correctly at the same time.
> > +#
> > +# The inline_data feature was introduced in ext4 and f2fs as follows.
> > +#  ext4 : http://lwn.net/Articles/468678/
> > +#  f2fs : http://lwn.net/Articles/573408/
> > +#
> > +# The basic idea is embedding small-sized file's data into relatively large
> > +# inode space.
> > +# In ext4, up to 132 bytes of data can be stored in 256 bytes-sized inode.
> > +# In f2fs, up to 3.4KB of data can be embedded into 4KB-sized inode block.
> > +#
> > +#-----------------------------------------------------------------------
> > +# Copyright (c) 2014 Jaegeuk Kim.  All Rights Reserved.
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
> > +    cd /
> > +    rm -f $tmp.*
> > +}
> > +
> > +# get standard environment, filters and checks
> > +. ./common/rc
> > +. ./common/filter
> > +
> > +_supported_fs generic
> > +_supported_os Linux
> > +_require_scratch
> > +
> > +testfile=$SCRATCH_MNT/testfile
> > +OD_CMD="od -A x -t x1z"
> 
> This passed my test now. Thanks!
> 
> > +
> > +_scratch_mkfs > /dev/null 2>&1
> > +_scratch_mount
> > +
> > +# 1. make a file containing inline_data.
> > +# 2. "truncated 0"  is to check cached page #0 was truncated entirely.
> > +# 3. "truncated 50" is to check inline_data was truncated within its inode.
> > +$XFS_IO_PROG -t -f \
> > +	-c "pwrite -S 0x58 0 40" `# write    |XXXXXXXXXXXXXXXXXXXXXXXX|` \
> > +	-c "fsync"							 \
> > +	-c "truncate 0"          `# truncate |                        |` \
> > +	-c "truncate 50"         `# truncate |                        |` \
> > +$testfile | _filter_xfs_io
> > +
> > +echo "= truncate inline_data after #0 page was truncated entirely ="
> > +$OD_CMD $testfile
> > +_scratch_remount
> 
> Seems you missed my comments on this "_scratch_remount".
> _scratch_remount without any arguments is a no-op, do you mean
> _scratch_cycle_mount here?

Ah, right.
Will send v3.
Thanks,

> 
> Thanks
> Eryu
