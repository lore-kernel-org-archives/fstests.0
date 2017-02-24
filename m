Received: from mx1.redhat.com ([209.132.183.28]:42134 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751257AbdBXJrJ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 24 Feb 2017 04:47:09 -0500
Date: Fri, 24 Feb 2017 17:47:06 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] generic/409: reflink concurrent operations
Message-ID: <20170224094706.GF24562@eguan.usersys.redhat.com>
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

I'm having the same question as Darrick's, is this test reproducing some
kind of bugs for you?

> 
> Signed-off-by: Nave Vardy <nave.vardy@plexistor.com>
> ---
>  tests/generic/409     | 97 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/409.out |  2 ++
>  tests/generic/group   |  1 +
>  3 files changed, 100 insertions(+)
>  create mode 100644 tests/generic/409

0755 file mode for new test. This is done automatically if you use
"./new generic" to setup new test template.

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

Same question on the filesystem size.

> +_scratch_mount || _fail "mount failed"
> +
> +echo "Silence is golden"
> +
> +workfile=${SCRATCH_MNT}/workfile
> +light_clone=${SCRATCH_MNT}/light_clone
> +
> +file_size=$((10 * 1024 * 1024))
> +bs=4096
> +block_num=$((file_size / bs))
> +reflinks_num=20
> +
> +$XFS_IO_PROG -f -c "pwrite 0 $file_size" $workfile >> $seqres.full
> +
> +#create all reflinkfs
> +for ((i=1; i<reflinks_num; i++));
> +do
> +	cp --reflink $workfile ${light_clone}_$i
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
> +		fi

I don't see much concurrency in this loop, for each block_index there's
only one pread process and reflinks_num processes doing pwrite or
fpunch. Seems only pwrites are racing with pwrites and fpunchs are
racing with fpunchs. How about:

for ((block_index=0; block_index<block_num; block_index++)); do
	for ((i=0; i<reflinks_num; i++)); do
		$XFS_IO_PROG -c "pread ..." ... &
		if [ $((i % 2)) -eq 0 ]; then
			$XFS_IO_PROG -c "pwrite ..." ... &
		else
			$XFS_IO_PROG -c "fpunch ..." ... &
		fi
	done
	wait
done

So for every pwrite or fpunch there's a pread racing with it. But
because I don't know if you're reproducing some specific bug with this
loop, I'm not sure if my version still works.

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

If you decide to increase the concurrency/workload, probably the test
will not be quick enough to fit in quick group :)

Thanks,
Eryu

> -- 
> 2.5.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
