Received: from mail-pg0-f68.google.com ([74.125.83.68]:35317 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750842AbeELN11 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 12 May 2018 09:27:27 -0400
Date: Sat, 12 May 2018 21:27:23 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] Fstests: ext4: test block reservation leak with bigalloc
Message-ID: <20180512132723.GT8373@desktop>
References: <1525702193-54402-1-git-send-email-bo.liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525702193-54402-1-git-send-email-bo.liu@linux.alibaba.com>
Sender: fstests-owner@vger.kernel.org
To: Liu Bo <bo.liu@linux.alibaba.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, May 07, 2018 at 10:09:53PM +0800, Liu Bo wrote:
> This is to reproduce a leak case of block reservation when bigalloc
> and delalloc are enabled.

Would you please provide more details about the leak? That helps to
understand what the test wants to execrise, and people still could know
the test purpose years later :)

> 
> Signed-off-by: Liu Bo <bo.liu@linux.alibaba.com>
> ---
>  tests/ext4/033     | 89 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/ext4/033.out | 14 +++++++++
>  tests/ext4/group   |  1 +
>  3 files changed, 104 insertions(+)
>  create mode 100755 tests/ext4/033
>  create mode 100644 tests/ext4/033.out
> 
> diff --git a/tests/ext4/033 b/tests/ext4/033
> new file mode 100755
> index 00000000..74f1a83d
> --- /dev/null
> +++ b/tests/ext4/033
> @@ -0,0 +1,89 @@
> +#! /bin/bash
> +# FS QA Test 033
> +#
> +# Reproduce ext4 block reservation leak when mkfs.ext4 -Obigalloc and
> +# mount -odelalloc .
> +#
> +#-----------------------------------------------------------------------
> +# Copyright (c) 2018 Alibaba Group.  All Rights Reserved.
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
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs ext4
> +_supported_os Linux
> +
> +_require_scratch
> +_require_scratch_ext4_feature "bigalloc"

Need "_require_xfs_io_command falloc"

> +
> +_scratch_mkfs -Obigalloc

Need to drop the mkfs output or redirect them to $seqres.full, test
fails currently because of the mkfs output.

Also, I think you need to specify the cluster size explicitly, i.e.
"-C 64k", otherwise test passes unexpectedly on 2k block size ext4, as
the default cluster size is not always 64k, but "16 times the block
size" (mke2fs(8)).

> +
> +# explicitly mount with -odelalloc since -onodelalloc won't trigger the
> +# mentioned bug.
> +_scratch_mount -odelalloc
> +
> +# case 1: two delayed extents result in leak.
> +$XFS_IO_PROG -f -c "pwrite 0 1" -c "pwrite 16k 1" -c "fsync" $SCRATCH_MNT/file1 | _filter_xfs_io
> +
> +# Since the default cluster size is 64K, and all the writes we've made are in
> +# one cluster, thus du is supposed to report 64K.
> +echo "du $SCRATCH_MNT/file1 | $AWK_PROG '{print \$1}'" >> $seqres.full
> +du $SCRATCH_MNT/file1 | $AWK_PROG '{print $1}' | tee -a $seqres.full
> +
> +# case 2: (one allocated extent + one delayed extent) result in leak.
> +$XFS_IO_PROG -f -c "pwrite 0 1" -c "fsync" -c "pwrite 16k 1" -c "fsync" $SCRATCH_MNT/file2 | _filter_xfs_io
> +
> +# Since the default cluster size is 64K, and all the writes we've made are in
> +# one cluster, thus du is supposed to report 64K.

No need to repeat the same comments again and again :)

> +echo "du $SCRATCH_MNT/file2 | $AWK_PROG '{print \$1}'" >> $seqres.full
> +du $SCRATCH_MNT/file2 | $AWK_PROG '{print $1}' | tee -a $seqres.full

Make this a local helper function?

Thanks,
Eryu

> +
> +# case 3: (one unwritten extent + one delayed extent) result in leak.
> +$XFS_IO_PROG -f -c "falloc 0 1" -c "pwrite 16k 1" -c "fsync" $SCRATCH_MNT/file3 | _filter_xfs_io
> +
> +# Since the default cluster size is 64K, and all the writes we've made are in
> +# one cluster, thus du is supposed to report 64K.
> +echo "du $SCRATCH_MNT/file3 | $AWK_PROG '{print \$1}'" >> $seqres.full
> +du $SCRATCH_MNT/file3 | $AWK_PROG '{print $1}' | tee -a $seqres.full
> +
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/ext4/033.out b/tests/ext4/033.out
> new file mode 100644
> index 00000000..7ff3d28f
> --- /dev/null
> +++ b/tests/ext4/033.out
> @@ -0,0 +1,14 @@
> +QA output created by 033
> +wrote 1/1 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wrote 1/1 bytes at offset 16384
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +64
> +wrote 1/1 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wrote 1/1 bytes at offset 16384
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +64
> +wrote 1/1 bytes at offset 16384
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +64
> diff --git a/tests/ext4/group b/tests/ext4/group
> index 5bd15f82..c0d9df28 100644
> --- a/tests/ext4/group
> +++ b/tests/ext4/group
> @@ -35,6 +35,7 @@
>  030 auto quick dax
>  031 auto quick dax
>  032 auto quick ioctl resize
> +033 quick auto
>  271 auto rw quick
>  301 aio auto ioctl rw stress defrag
>  302 aio auto ioctl rw stress defrag
> -- 
> 2.14.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
