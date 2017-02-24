Received: from userp1040.oracle.com ([156.151.31.81]:37283 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751791AbdBXDjD (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 23 Feb 2017 22:39:03 -0500
Date: Thu, 23 Feb 2017 19:38:28 -0800
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] generic/409: reflink concurrent operations
Message-ID: <20170224033828.GC22332@birch.djwong.org>
References: <1487853054-3194-1-git-send-email-nave.vardy@plexistor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1487853054-3194-1-git-send-email-nave.vardy@plexistor.com>
Sender: fstests-owner@vger.kernel.org
To: Nave Vardy <nave.vardy@plexistor.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Feb 23, 2017 at 02:30:54PM +0200, Nave Vardy wrote:
> reflink: concurrent operations test
> 
> perform read operation on the target file while
> doing write or fpunch operations on the reflinks.

A read vs. (write|fpunch) race... is this a regression test for a
specific problem you found?

> Signed-off-by: Nave Vardy <nave.vardy@plexistor.com>
> ---
>  tests/generic/409     | 97 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/409.out |  2 ++
>  tests/generic/group   |  1 +
>  3 files changed, 100 insertions(+)
>  create mode 100644 tests/generic/409
>  create mode 100644 tests/generic/409.out
> 
> diff --git a/tests/generic/409 b/tests/generic/409
> new file mode 100644
> index 0000000..eb1da13
> --- /dev/null
> +++ b/tests/generic/409
> @@ -0,0 +1,97 @@
> +#!/bin/bash
> +# FS QA Test No. 409
> +#
> +# test for races between write or fpunch operations on reflinked files
> +# to read operations on the targed file
> +#
> +#-----------------------------------------------------------------------
> +#
> +# Copyright (c) 2017 Plexistor Ltd. All Rights Reserved.
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
> +#
> +#-----------------------------------------------------------------------
> +
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=0    # success is the default!
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
> +. ./common/reflink
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +_supported_fs generic
> +_supported_os Linux
> +_require_scratch_reflink
> +_require_cp_reflink
> +
> +_scratch_mkfs_sized $((400 * 1024 ** 2)) >> $seqres.full 2>&1 || _fail "mkfs failed"

Any particular reason for formatting a 400MB filesystem?

_require_fs_space is customary for "skip test if we don't have this much
free space"

> +_scratch_mount || _fail "mount failed"
> +
> +echo "Silence is golden"

Until something fails, and now you have to go figure out which part of
the test script has the failed command.

It's much easier to diagnose test failures if the test case occasionally
echoes a section heading into the output file so that any error output
can be pinpointed to within a few lines.

> +
> +workfile=${SCRATCH_MNT}/workfile
> +light_clone=${SCRATCH_MNT}/light_clone
> +
> +file_size=$((10 * 1024 * 1024))
> +bs=4096

Um, what if the block size isn't 4k?  Does this test case work on a
filesystem with 64k blocks?  Or weird things like ocfs2 that map
clusters instead of blocks?

_get_file_block_size perhaps?

> +block_num=$((file_size / bs))
> +reflinks_num=20
> +
> +$XFS_IO_PROG -f -c "pwrite 0 $file_size" $workfile >> $seqres.full
> +
> +#create all reflinkfs

"create all reflinks" ?

> +for ((i=1; i<reflinks_num; i++));
> +do
> +	cp --reflink $workfile ${light_clone}_$i

_cp_reflink?

> +done
> +
> +#for each block simultaneously write to all reflinks
> +for ((block_index=0; block_index<block_num; block_index++));
> +do
> +	for ((i=0; i<reflinks_num; i++));
> +	do
> +		if [ $i -eq 0 ]; then
> +			$XFS_IO_PROG -c "pread $((block_index * bs)) $bs" \
> +						$workfile >> $seqres.full &
> +		elif [ $((block_index % 2)) -eq 0 ]; then
> +			$XFS_IO_PROG -c "pwrite $((block_index * bs)) $bs" \
> +					${light_clone}_$i  >> $seqres.full &
> +		else
> +			$XFS_IO_PROG -c "fpunch $((block_index * bs)) $bs" \
> +					${light_clone}_$i >> $seqres.full &

So... is this test only concerned with pread/pwrite/fpunch returning
some kind of error code or crashing the kernel?  Should we check that
the read data is the old shared data, the newly written data, or zeroes?

--D

> +		fi
> +	done
> +	# wait for all threads to join before moving to next index
> +	wait
> +done
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/409.out b/tests/generic/409.out
> new file mode 100644
> index 0000000..6f11537
> --- /dev/null
> +++ b/tests/generic/409.out
> @@ -0,0 +1,2 @@
> +QA output created by 409
> +Silence is golden
> diff --git a/tests/generic/group b/tests/generic/group
> index d14f221..27ff229 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -411,3 +411,4 @@
>  406 auto quick dangerous
>  407 auto quick clone metadata
>  408 auto quick clone dedupe metadata
> +409 auto quick clone
> -- 
> 2.5.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
