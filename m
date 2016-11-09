Received: from cn.fujitsu.com ([59.151.112.132]:20358 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753324AbcKIAYt (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 8 Nov 2016 19:24:49 -0500
Subject: Re: [PATCH] fstests: btrfs: Check false ENOSPC bug caused by
 incorrect metadata reserve
References: <20161108091515.20867-1-quwenruo@cn.fujitsu.com>
 <20161108105826.GN27776@eguan.usersys.redhat.com>
From: Qu Wenruo <quwenruo@cn.fujitsu.com>
Message-ID: <d9a9d224-2f21-5b77-a3e9-de271cd4e755@cn.fujitsu.com>
Date: Wed, 9 Nov 2016 08:24:38 +0800
MIME-Version: 1.0
In-Reply-To: <20161108105826.GN27776@eguan.usersys.redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



At 11/08/2016 06:58 PM, Eryu Guan wrote:
> On Tue, Nov 08, 2016 at 05:15:15PM +0800, Qu Wenruo wrote:
>> Due to the fact that btrfs uses different max extent size for
>> compressed and non-compressed write, it calculates metadata reservation
>> incorrectly.
>>
>> This can leads to false ENOSPC alert for compressed write.
>>
>> This test case will check it by using small fs and large nodesize, and
>> do parallel compressed write to trigger it.
>>
>> The fix is not merged and may change in the future, but the function is
>> good enough:
>> btrfs: improve inode's outstanding_extents computation
>> btrfs: fix false enospc for compression
>>
>> Signed-off-by: Qu Wenruo <quwenruo@cn.fujitsu.com>
>> ---
>>  tests/btrfs/132     | 89 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  tests/btrfs/132.out |  2 ++
>>  tests/btrfs/group   |  1 +
>>  3 files changed, 92 insertions(+)
>>  create mode 100755 tests/btrfs/132
>>  create mode 100644 tests/btrfs/132.out
>>
>> diff --git a/tests/btrfs/132 b/tests/btrfs/132
>> new file mode 100755
>> index 0000000..95c21ea
>> --- /dev/null
>> +++ b/tests/btrfs/132
>> @@ -0,0 +1,89 @@
>> +#! /bin/bash
>> +# FS QA Test 132
>> +#
>> +# Check if false ENOSPC will happen when parallel buffer write happens
>> +# The problem is caused by incorrect metadata reservation.
>> +#
>> +#-----------------------------------------------------------------------
>> +# Copyright (c) 2016 Fujitsu.  All Rights Reserved.
>> +#
>> +# This program is free software; you can redistribute it and/or
>> +# modify it under the terms of the GNU General Public License as
>> +# published by the Free Software Foundation.
>> +#
>> +# This program is distributed in the hope that it would be useful,
>> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> +# GNU General Public License for more details.
>> +#
>> +# You should have received a copy of the GNU General Public License
>> +# along with this program; if not, write the Free Software Foundation,
>> +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
>> +#-----------------------------------------------------------------------
>> +#
>> +
>> +seq=`basename $0`
>> +seqres=$RESULT_DIR/$seq
>> +echo "QA output created by $seq"
>> +
>> +here=`pwd`
>> +tmp=/tmp/$$
>> +status=1	# failure is the default!
>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>> +
>> +_cleanup()
>> +{
>> +	cd /
>> +	rm -f $tmp.*
>> +}
>> +
>> +# get standard environment, filters and checks
>> +. ./common/rc
>> +. ./common/filter
>> +
>> +# remove previous $seqres.full before test
>> +rm -f $seqres.full
>> +
>> +# real QA test starts here
>> +
>> +# Modify as appropriate.
>> +_supported_fs btrfs
>> +_supported_os Linux
>> +_require_scratch
>> +
>> +# Use small filesystem with maximum nodesize.
>> +# Since the false ENOSPC happens due to incorrect metadata reservation,
>> +# larger nodesize and small fs will make it much easier to reproduce
>> +_scratch_mkfs -b 512M -n 64k >> $seqres.full 2>&1
>
> How about override MKFS_OPTIONS and call _scratch_mkfs_sized? e.g.
>
> export MKFS_OPTIONS="-n 64k"
> _scratch_mkfs_sized $((512 * 1024 * 1024))

Overriding MKFS_OPTIONS makes us unable to parse more mkfs options, for 
example to test some incompatible features.

So I'd just parse this mkfs options as extra options.
>
>> +_scratch_mount "-o compress"
>> +
>> +sleep_time=$(($TIME_FACTOR * 15))
>> +loop_writer()
>> +{
>> +	offset=$1
>> +	len=$2
>> +	file=$3
>> +
>> +	while true;
>> +	do
>> +		# Only need stderr, and we need to specify small block size
>> +		# but still trigger compression
>> +		xfs_io -c "pwrite -b 8K $offset $len" $file 2>&1 > /dev/null
>
> Use $XFS_IO_PROG here.

Oh, I forgot it again...
>
>> +	done
>> +}
>> +
>> +touch $SCRATCH_MNT/testfile
>> +
>> +# Start 2 writter writting into the same file
>> +# The file is 142M, which is smaller than 1/2 of the filesystem,
>> +# so no other cause can lead to ENOSPC.
>> +loop_writer 0 128M $SCRATCH_MNT/testfile &
>> +loop_writer 128M 16M $SCRATCH_MNT/testfile &
>> +
>> +sleep $sleep_time
>> +
>> +kill 0
>> +sleep

Oh, I thought I typed "wait" not "sleep".

>
> This is not working for me, even I removed the suspicious "sleep", seems
> "132" itself was killed too.
>
> I'd save pids of background jobs and kill the pids and call wait to make
> sure all child processes exit running. e.g.
>
> loop_writer ... &
> pids=$!
> loop_writer ... &
> pids="$pids $!"
>
> sleep $sleep_time
> kill $pids
> wait
>
> And you're missing 'echo "Silence is golden"' in the test.

I'll update them soon.

Thanks,
Qu
>
> Thanks,
> Eryu
>
>> +
>> +status=0
>> +exit
>> diff --git a/tests/btrfs/132.out b/tests/btrfs/132.out
>> new file mode 100644
>> index 0000000..b096312
>> --- /dev/null
>> +++ b/tests/btrfs/132.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 132
>> +Silence is golden
>> diff --git a/tests/btrfs/group b/tests/btrfs/group
>> index c090604..ec8ad80 100644
>> --- a/tests/btrfs/group
>> +++ b/tests/btrfs/group
>> @@ -134,3 +134,4 @@
>>  129 auto quick send
>>  130 auto clone send
>>  131 auto quick
>> +132 auto compress
>> --
>> 2.7.4
>>
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe fstests" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-btrfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>


