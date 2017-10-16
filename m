Received: from aserp1040.oracle.com ([141.146.126.69]:22476 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753515AbdJPRrC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 16 Oct 2017 13:47:02 -0400
Date: Mon, 16 Oct 2017 10:46:55 -0700
From: Liu Bo <bo.li.liu@oracle.com>
Subject: Re: [PATCH] Fstest: btrfs/151: test if device delete ends up with
 losing raid profile
Message-ID: <20171016174655.GA2516@localhost.localdomain>
Reply-To: bo.li.liu@oracle.com
References: <20171009173921.12569-1-bo.li.liu@oracle.com>
 <20171012070657.GA10593@eguan.usersys.redhat.com>
 <20171013180843.GC1553@lim.localdomain>
 <0269b274-26e7-3be8-97a0-334e12dcbb11@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0269b274-26e7-3be8-97a0-334e12dcbb11@suse.com>
Sender: fstests-owner@vger.kernel.org
To: Nikolay Borisov <nborisov@suse.com>
Cc: Eryu Guan <eguan@redhat.com>, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Oct 16, 2017 at 09:57:11AM +0300, Nikolay Borisov wrote:
> 
> 
> On 13.10.2017 21:08, Liu Bo wrote:
> > On Thu, Oct 12, 2017 at 03:06:57PM +0800, Eryu Guan wrote:
> >> On Mon, Oct 09, 2017 at 11:39:21AM -0600, Liu Bo wrote:
> >>> Currently running 'btrfs device delete' can end up with losing data raid
> >>> profile (if any), this test is to reproduce the problem.
> >>>
> >>> The fix is
> >>>      "Btrfs: avoid losing data raid profile when deleting a device"
> >>>
> >>> Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
> >>> ---
> >>>  tests/btrfs/151     | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> >>>  tests/btrfs/151.out |  2 ++
> >>>  tests/btrfs/group   |  1 +
> >>>  3 files changed, 76 insertions(+)
> >>>  create mode 100755 tests/btrfs/151
> >>>  create mode 100644 tests/btrfs/151.out
> >>>
> >>> diff --git a/tests/btrfs/151 b/tests/btrfs/151
> >>> new file mode 100755
> >>> index 0000000..1866cb6
> >>> --- /dev/null
> >>> +++ b/tests/btrfs/151
> >>> @@ -0,0 +1,73 @@
> >>> +#! /bin/bash
> >>> +# FS QA Test 151
> >>> +#
> >>> +# Test if it's losing data chunk's raid profile after 'btrfs device
> >>> +# remove'.
> >>> +#
> >>> +# The fix is
> >>> +#	Btrfs: avoid losing data raid profile when deleting a device
> >>> +#
> >>> +#-----------------------------------------------------------------------
> >>> +# Copyright (c) 2017 Oracle.  All Rights Reserved.
> >>> +#
> >>> +# This program is free software; you can redistribute it and/or
> >>> +# modify it under the terms of the GNU General Public License as
> >>> +# published by the Free Software Foundation.
> >>> +#
> >>> +# This program is distributed in the hope that it would be useful,
> >>> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> >>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >>> +# GNU General Public License for more details.
> >>> +#
> >>> +# You should have received a copy of the GNU General Public License
> >>> +# along with this program; if not, write the Free Software Foundation,
> >>> +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> >>> +#-----------------------------------------------------------------------
> >>> +#
> >>> +
> >>> +seq=`basename $0`
> >>> +seqres=$RESULT_DIR/$seq
> >>> +echo "QA output created by $seq"
> >>> +
> >>> +here=`pwd`
> >>> +tmp=/tmp/$$
> >>> +status=1	# failure is the default!
> >>> +trap "_cleanup; exit \$status" 0 1 2 3 15
> >>> +
> >>> +_cleanup()
> >>> +{
> >>> +	cd /
> >>> +	rm -f $tmp.*
> >>> +}
> >>> +
> >>> +# get standard environment, filters and checks
> >>> +. ./common/rc
> >>> +. ./common/filter
> >>> +
> >>> +# remove previous $seqres.full before test
> >>> +rm -f $seqres.full
> >>> +
> >>> +# real QA test starts here
> >>> +
> >>> +# Modify as appropriate.
> >>> +_supported_fs btrfs
> >>> +_supported_os Linux
> >>> +_require_scratch
> >>
> >> Better to have _require_btrfs_dev_del_by_devid too.
> >>
> > 
> > OK.
> > 
> >>> +_require_scratch_dev_pool 3
> >>
> >> Hmm, this only reproduces for me if I have exact three devices in
> >> SCRATCH_DEV_POOL, large dev pool passed the test. If this can only be
> >> reproduced with a three-device setup, I think we need to limit the dev
> >> pool size to at most 3, e.g.
> >>
> >> # <comments about why we need exact 3 devices>
> >> _scratch_dev_pool_get 3
> >> <do test here>
> >> _scratch_dev_pool_put
> >> status=0
> >> exit
> > 
> > Oops, you're totally right.
> > 
> >>
> >>> +
> >>> +# create raid1 for data
> >>> +_scratch_pool_mkfs "-d raid1 -b 1G" >> $seqres.full 2>&1
> >>> +
> >>> +# we need an empty data chunk, so nospace_cache is required.
> >>> +_scratch_mount -onospace_cache
> >>> +
> >>> +# if data chunk is empty, 'btrfs device remove' can change raid1 to
> >>> +# single.
> >>> +$BTRFS_UTIL_PROG device delete 2 $SCRATCH_MNT >> $seqres.full
> >>> +
> >>> +df_ret=`$BTRFS_UTIL_PROG filesystem df $SCRATCH_MNT`
> >>> +echo $df_ret | $AWK_PROG -F ':' '/Data,/ {print $1}'
> >>
> >> I'd like to avoid saving outputs in a variable, it's easy to cause
> >> subtle problems without proper quoting, as Dave found out in this thread
> >>
> >> [whacky issue] xfs/277 endlessly looping in _require_xfs_io_command
> >> http://www.spinics.net/lists/fstests/msg07501.html
> >>
> >> How about:
> >>
> >> # save btrfs filesystem df output for debug purpose
> >> $BTRFS_UTIL_PROG filesystem df $SCRATCH_MNT >>$seqres.full 2>&1
> >> $BTRFS_UTIL_PROG filesystem df $SCRATCH_MNT | \
> >> 	$AWK_PROG -F ':' '/Data,/ {print $1}'
> > 
> > That makes sense to me, will update it.
> 
> Also instead of invoking fi df twice and running the risk of something
> changing (you never know), how about using tee?
>

Sounds good, will update it.

Thanks,

-liubo
> > 
> > Thanks for the comments.
> > 
> > thanks,
> > 
> > -liubo
> > 
> >>
> >> Thanks,
> >> Eryu
> >>
> >>> +
> >>> +# success, all done
> >>> +status=0
> >>> +exit
> >>> diff --git a/tests/btrfs/151.out b/tests/btrfs/151.out
> >>> new file mode 100644
> >>> index 0000000..0a1de06
> >>> --- /dev/null
> >>> +++ b/tests/btrfs/151.out
> >>> @@ -0,0 +1,2 @@
> >>> +QA output created by 151
> >>> +Data, RAID1
> >>> diff --git a/tests/btrfs/group b/tests/btrfs/group
> >>> index e73bb1b..a7ff7b0 100644
> >>> --- a/tests/btrfs/group
> >>> +++ b/tests/btrfs/group
> >>> @@ -153,3 +153,4 @@
> >>>  148 auto quick rw
> >>>  149 auto quick send compress
> >>>  150 auto quick dangerous
> >>> +151 auto quick
> >>> -- 
> >>> 2.5.0
> >>>
> >>> --
> >>> To unsubscribe from this list: send the line "unsubscribe fstests" in
> >>> the body of a message to majordomo@vger.kernel.org
> >>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-btrfs" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
