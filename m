Received: from mx1.redhat.com ([209.132.183.28]:45108 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750924AbcGSEf1 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 19 Jul 2016 00:35:27 -0400
Date: Tue, 19 Jul 2016 12:35:24 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] fstests: btrfs: Test send on heavily deduped file
Message-ID: <20160719043524.GL27776@eguan.usersys.redhat.com>
References: <20160719024402.19324-1-quwenruo@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160719024402.19324-1-quwenruo@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Qu Wenruo <quwenruo@cn.fujitsu.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Jul 19, 2016 at 10:44:02AM +0800, Qu Wenruo wrote:
> For fully deduped file, whose file extents are all pointing to the same
> extent, btrfs backref walk can be very time consuming, long enough to
> trigger softlock.
> 
> Unfortunately, btrfs send is one of the caller of such backref walk
> under an O(n) loop, making the total time complexity to O(n^3) or more.
> 
> And even worse, btrfs send will allocate memory in such loop, to trigger
> OOM on system with small memory(<4G).
> 
> This test case will check if btrfs send will cause these problems.
> 
> Reporeted-by: Tsutomu Itoh <t-itoh@jp.fujitsu.com>
> To: Filipe Manana <fdmanana@gmail.com>
> Signed-off-by: Qu Wenruo <quwenruo@cn.fujitsu.com>
> ---
> To Filipe:
>   For the soft lockup, I will try my best to figure out some method to
>   avoid such lockup (but it will still be very time consuming though).
> 
>   But for the OOM problem, would you mind disabling clone/reflink
>   detection in btrfs send?
> 
>   In fact we should really avoid doing full backref walk inside an O(n)
>   loop (just like previous fiemap ioctl test case), and avoid any full
>   backref walk if possible.
>   So I'm afraid that's the only solution yet.
> 
> Thanks,
> Qu
> ---
>  tests/btrfs/127     | 89 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/127.out |  3 ++
>  tests/btrfs/group   |  1 +
>  3 files changed, 93 insertions(+)
>  create mode 100755 tests/btrfs/127
>  create mode 100644 tests/btrfs/127.out
> 
> diff --git a/tests/btrfs/127 b/tests/btrfs/127
> new file mode 100755
> index 0000000..a31a653
> --- /dev/null
> +++ b/tests/btrfs/127
> @@ -0,0 +1,89 @@
> +#! /bin/bash
> +# FS QA Test 127
> +#
> +# Check if btrfs send can handle large deduped file, whose file extents
> +# are all pointing to one extent.
> +# Such file structure will cause quite large pressure to any operation which
> +# iterates all backref of one extent.
> +# And unfortunately, btrfs send is one of these operations, and will cause
> +# softlock or OOM on systems with small memory(<4G).
> +#
> +#-----------------------------------------------------------------------
> +# Copyright (c) 2016 Fujitsu. All Rights Reserved.
> +#
> +# This program is free software; you can redistribute it and/or
> +# modify it under the terms of the GNU General Public License as
> +# published by the Free Software Foundation.
> +#
> +# This program is distributed in the hope that it would be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program; if not, write the Free Software Foundation,
> +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> +#-----------------------------------------------------------------------
> +#
> +
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +. ./common/reflink
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs btrfs
> +_supported_os Linux
> +_require_scratch
> +_require_scratch_reflink
> +
> +_scratch_mkfs > /dev/null 2>&1
> +_scratch_mount
> +
> +nr_extents=$((4096 * $LOAD_FACTOR))
> +
> +# Use 128K blocksize, the default value of both deduperemove or
> +# inband dedupe
> +blocksize=$((128 * 1024))
> +file=$SCRATCH_MNT/foobar
> +
> +# create the initial file, whose file extents are all point to one extent
> +_pwrite_byte 0xcdcdcdcd 0 $blocksize  $file | _filter_xfs_io
> +
> +for i in $(seq 1 $(($nr_extents - 1))); do
> +	_reflink_range $file 0 $file $(($i * $blocksize)) $blocksize \
> +		> /dev/null 2>&1
> +done
> +
> +# create a RO snapshot, so we can send out the snapshot
> +_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/ro_snap
> +
> +# send out the subvolume, and it will either:
> +# 1) OOM since memory is allocated inside a O(n^3) loop
> +# 2) Softlock since time consuming backref walk is called without scheduling.
> +# the send destination is not important, just send will cause the problem
> +_run_btrfs_util_prog send $SCRATCH_MNT/ro_snap > /dev/null 2>&1
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/127.out b/tests/btrfs/127.out
> new file mode 100644
> index 0000000..8b08bf8
> --- /dev/null
> +++ b/tests/btrfs/127.out
> @@ -0,0 +1,3 @@
> +QA output created by 127
> +wrote 131072/131072 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index a21a80a..d9174b5 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -129,3 +129,4 @@
>  124 auto replace
>  125 auto replace
>  126 auto quick qgroup
> +127 auto clone send

This test uses $LOAD_FACTOR, so it should be in 'stress' group. And it
hangs the latest kernel, stop other tests from running, I think we can
add it to 'dangerous' group as well.

I can fix them at merge time, if there's no other major updates to be
done. (I'll let the patch sitting in the list for more time, in case
others have more review comments).

Thanks,
Eryu
