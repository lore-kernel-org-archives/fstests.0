Received: from mx1.redhat.com ([209.132.183.28]:53546 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932287AbdK2KZa (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 29 Nov 2017 05:25:30 -0500
Date: Wed, 29 Nov 2017 18:25:28 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v2 2/3] generic/470: Test RWF_NOWAIT
Message-ID: <20171129102528.GQ2749@eguan.usersys.redhat.com>
References: <20171127184920.13864-1-rgoldwyn@suse.de>
 <20171127184920.13864-2-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171127184920.13864-2-rgoldwyn@suse.de>
Sender: fstests-owner@vger.kernel.org
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: fstests@vger.kernel.org, darrick.wong@oracle.com, Goldwyn Rodrigues <rgoldwyn@suse.com>
List-ID: <fstests@vger.kernel.org>

On Mon, Nov 27, 2017 at 12:49:19PM -0600, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Tests the RWF_NOWAIT flag so the I/O returns immediately with -EAGAIN
> on a new file since it requires block allocation.
> 
> It creates a file, syncs it, and overwrites the file with RWF_NOWAIT.
> This should succeed.
> 
> Finally, read the contents to make sure the overwrite is successful.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Changes since v1:
>  - Fix testdir name
>  - use of $XFS_IO_PROG instead of xfs_io
>  - check pwrite accepts -N
> 
> ---
>  tests/generic/470     | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/470.out | 13 +++++++++
>  tests/generic/group   |  1 +
>  3 files changed, 88 insertions(+)
>  create mode 100755 tests/generic/470
>  create mode 100644 tests/generic/470.out
> 
> diff --git a/tests/generic/470 b/tests/generic/470
> new file mode 100755
> index 00000000..7439dfd3
> --- /dev/null
> +++ b/tests/generic/470
> @@ -0,0 +1,74 @@
> +#! /bin/bash
> +# FS QA Test No. 470
> +#
> +# write() to a file opened with O_DIRECT with count > remaining
> +# bytes. Result should be remaining bytes (to aligned bytes) instead
> +# of ENOSPC error

Wrong test description? It seems for generic/471.

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
> +    rm -rf $tmp.* $testdir
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
> +_require_scratch

I think this test can be run on $TEST_DEV directly, so _require_test
here and do all the tests in $TEST_DIR would be fine.

> +_require_xfs_io_command pwrite -N
> +
> +_scratch_mkfs > /dev/null 2>&1
> +_scratch_mount > /dev/null 2>&1
> +testdir=$SCRATCH_MNT/test-$seq
> +mkdir $testdir
> +
> +# Create a file with pwrite nowait (will fail with EAGAIN)
> +$XFS_IO_PROG -f -d -c "pwrite -N -V 1 -b 128M 0 128M" $testdir/f1
> +
> +# Write the file without nowait
> +$XFS_IO_PROG -f -d -c "pwrite -S 0xaa -W -w -V 1 -b 128M 0 128M" $testdir/f1 | _filter_xfs_io

Hmm, any reason using 128M block size? I'm afraid it will cause problems
when memory is low.

> +
> +time_taken=`$XFS_IO_PROG -d -c "pwrite -S 0xbb -N -V 1 -b 1M 4M 1M" $testdir/f1 | awk '/^1/ {print $5}'`
> +if (( $(echo "$time_taken < 0.05" | bc -l) )); then
> +	echo "RWF_NOWAIT time is within limits."
> +else
> +	echo "RWF_NOWAIT took $time_taken seconds"
> +fi

This looks fragile to me, at least this needs a big comment.

> +
> +$XFS_IO_PROG -c "pread -v 0 128M" $testdir/f1 | _filter_xfs_io_unique
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/470.out b/tests/generic/470.out
> new file mode 100644
> index 00000000..6d47b219
> --- /dev/null
> +++ b/tests/generic/470.out
> @@ -0,0 +1,13 @@
> +QA output created by 470
> +pwrite: Resource temporarily unavailable
> +wrote 134217728/134217728 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +RWF_NOWAIT time is within limits.
> +00000000:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +*
> +00400000:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> +*
> +00500000:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +*
> +read 134217728/134217728 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> diff --git a/tests/generic/group b/tests/generic/group
> index 6c3bb03a..11ccfb01 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -472,3 +472,4 @@
>  467 auto quick exportfs
>  468 shutdown auto quick metadata
>  469 auto quick
> +470 auto quick

Perhaps 'rw' group too.

Thanks,
Eryu

> -- 
> 2.14.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
