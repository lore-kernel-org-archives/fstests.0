Received: from mx1.redhat.com ([209.132.183.28]:57736 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752804AbdK2Kqa (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 29 Nov 2017 05:46:30 -0500
Date: Wed, 29 Nov 2017 18:46:28 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v2 3/3] generic/471: Partial direct write test
Message-ID: <20171129104628.GR2749@eguan.usersys.redhat.com>
References: <20171127184920.13864-1-rgoldwyn@suse.de>
 <20171127184920.13864-3-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171127184920.13864-3-rgoldwyn@suse.de>
Sender: fstests-owner@vger.kernel.org
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: fstests@vger.kernel.org, darrick.wong@oracle.com, Goldwyn Rodrigues <rgoldwyn@suse.com>
List-ID: <fstests@vger.kernel.org>

On Mon, Nov 27, 2017 at 12:49:20PM -0600, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Getting an error midway through a direct write would return an error
> and the error-code is returned in the write() call. However, partial
> data is over-written during the call.
> 
> This tests simulates the ENOSPC error to check for partial direct
> write consistency.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Changes since v1:
>  - Check for option pwrite -O
>  - Create a 200M file instead of multiple 40M files.
> 
> ---
>  tests/generic/471     | 90 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/471.out |  9 ++++++
>  tests/generic/group   |  1 +
>  3 files changed, 100 insertions(+)
>  create mode 100755 tests/generic/471
>  create mode 100644 tests/generic/471.out
> 
> diff --git a/tests/generic/471 b/tests/generic/471
> new file mode 100755
> index 00000000..a7780af1
> --- /dev/null
> +++ b/tests/generic/471
> @@ -0,0 +1,90 @@
> +#! /bin/bash
> +# FS QA Test No. 471
> +#
> +# write() to a file opened with O_DIRECT with count > remaining
> +# bytes. In case of a bug, the write returns ENOSPC wheras the
> +# showing no data is written, but the file contents are updated.
> +# Result should be the write should return remaining bytes
> +# (to aligned bytes) instead of ENOSPC error.
> +#
> +#-----------------------------------------------------------------------
> +# Copyright (c) 2017, SUSE Linux Products.  All Rights Reserved.
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
> +
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=1    # failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +    cd /
> +    rm -rf $tmp.* $testdir1
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/populate
> +. ./common/filter
> +. ./common/attr
> +
> +# real QA test starts here
> +_supported_os Linux
> +_require_odirect

Missed _require_scratch

> +_require_xfs_io_command pwrite -O
> +
> +rm -f $seqres.full
> +
> +echo "Reformat with 320M size"
> +umount $SCRATCH_MNT

No need to umount $SCRATCH_MNT, _require_scratch will do it for you.

> +sz_bytes=$((320 * 1024 * 1024))
> +_scratch_mkfs_sized $sz_bytes >> $seqres.full 2>&1
> +_scratch_mount >> $seqres.full 2>&1
> +testdir=$SCRATCH_MNT/test-$seq
> +rm -rf $testdir

No need to remove $testdir here, scratch_dev is freshly created.

> +mkdir $testdir
> +sync
> +
> +#Almost fill the filesystem
   ^^ add a space after '#' for comments

> +echo "Almost fill the filesystem"
> +$XFS_IO_PROG -f -c "pwrite 0 200M" $testdir/f1 > /dev/null
> +
> +# Create a file using buffered I/O which succeeds only partially
> +$XFS_IO_PROG -f -c "pwrite -w -S 0xaa 0 128M" $testdir/partial
> +
> +# re-write using direct I/O with another pattern using one single buffer, once
> +write_size=`$XFS_IO_PROG -d -c "pwrite -O -S 0xcd -V 1 -b 128M 0 128M" $testdir/partial | awk '/^wrote/ {split($2, bytes, "/"); print bytes[1]}'`

Hmm, I can see that "-O" requires bigger block size in this case. Then
how about reserving some space first and fill the rest then remove the
reserved file? So we have a fixed amount of space to do the test. e.g.

# reserve 2m space first
$XFS_IO_PROG -fc "pwrite 0 2m" $testdir/reserve
# fill the rest of the fs
$XFS_IO_PROG -fc "pwrite 0 320m" $testdir/fill
# remove the reserve file to get space free
rm -f $testdir/reserve
...
$XFS_IO_PROG -dc "pwrite -O -S 0xcd -V 1 -b 4m 0 4m" $testdir/partial
...

Thanks,
Eryu

> +if [ -z $write_size ]; then
> +	write_size=0
> +fi
> +
> +# If bug is not fixed, pwrite will return error and but still write data
> +if [ $write_size -gt 0 ]; then
> +	echo "pwrite wrote more than zero bytes."
> +else
> +	echo "pwrite wrote zero bytes"
> +fi
> +
> +# read the partial file to check if data written is of last write
> +$XFS_IO_PROG -c "pread 0 2M -v" $testdir/partial | _filter_xfs_io_unique
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/471.out b/tests/generic/471.out
> new file mode 100644
> index 00000000..e01687c8
> --- /dev/null
> +++ b/tests/generic/471.out
> @@ -0,0 +1,9 @@
> +QA output created by 471
> +Reformat with 320M size
> +Almost fill the filesystem
> +pwrite: No space left on device
> +pwrite wrote more than zero bytes.
> +00000000:  cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd  ................
> +*
> +read 2097152/2097152 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> diff --git a/tests/generic/group b/tests/generic/group
> index 11ccfb01..f4591620 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -473,3 +473,4 @@
>  468 shutdown auto quick metadata
>  469 auto quick
>  470 auto quick
> +471 auto quick rw
> -- 
> 2.14.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
