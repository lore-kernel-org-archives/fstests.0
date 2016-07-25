Received: from cn.fujitsu.com ([59.151.112.132]:53766 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751127AbcGYHNb (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 25 Jul 2016 03:13:31 -0400
Subject: Re: [PATCH] generic/371: run write(2) and fallocate(2) in parallel
References: <20160721073025.25557-1-wangxg.fnst@cn.fujitsu.com>
 <20160721104100.GD27776@eguan.usersys.redhat.com>
From: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
Message-ID: <5795BB67.2030506@cn.fujitsu.com>
Date: Mon, 25 Jul 2016 15:10:31 +0800
MIME-Version: 1.0
In-Reply-To: <20160721104100.GD27776@eguan.usersys.redhat.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

hello,

On 07/21/2016 06:41 PM, Eryu Guan wrote:
> On Thu, Jul 21, 2016 at 03:30:25PM +0800, Wang Xiaoguang wrote:
>> Currently in btrfs, there is something wrong with fallocate(2)'s data
>> space reservation, it'll temporarily occupy more data space thant it
>> really needs, which in turn will impact other operations' data request.
>>
>> In this test case, it runs write(2) and fallocate(2) in parallel and the
>> total needed data space for these two operations don't exceed whole fs
>> free data space, to see whether we will get any unexpected ENOSPC error.
>>
>> Signed-off-by: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
>> ---
>>   tests/generic/371     | 119 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>   tests/generic/371.out |   2 +
>>   tests/generic/group   |   1 +
>>   3 files changed, 122 insertions(+)
>>   create mode 100755 tests/generic/371
>>   create mode 100644 tests/generic/371.out
>>
>> diff --git a/tests/generic/371 b/tests/generic/371
>> new file mode 100755
>> index 0000000..b85327a
>> --- /dev/null
>> +++ b/tests/generic/371
>> @@ -0,0 +1,119 @@
>> +#! /bin/bash
>> +# FS QA Test 371
>> +#
>> +# Run write(2) and fallocate(2) in parallel and the total needed data space
>> +# for these operations don't exceed whole fs free data space, to see whether
>> +# we will get any unexpected ENOSPC error.
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
>> +# Modify as appropriate.
>> +_supported_fs generic
>> +_supported_os Linux
>> +_require_scratch
> Need '_require_xfs_io_command "falloc"', otherwise test fails on ext3/2,
> because they don't support fallocate(2).
OK, I see.

>
>> +
>> +_scratch_mkfs_sized $((256 * 1024 * 1024)) >> $seqres.full 2>&1
>> +_scratch_mount
>> +
>> +testfile1=$SCRATCH_MNT/testfile1
>> +testfile2=$SCRATCH_MNT/testfile2
>> +
>> +write_work()
>> +{
>> +	rm -f $testfile1
>> +	while [ 1 ]; do
>> +		$XFS_IO_PROG -f -c "pwrite 0 80M" $testfile1 >>$seqres.full 2>&1
>> +		grep "No space left on device" $seqres.full >/dev/null
>> +		if [ $? -eq 0 ]; then
>> +			echo "unexpected ENOSPC error occurs"
>> +			exit 1
>> +		fi
> No need to grep for error message, just redirect stdout to /dev/null and
> any error will appear in stderr, which will break golden image.
>
> And $seqres.full is where we dump logs for debug purpose, tests should
> dump output they need to somewhere like $tmp.<suffix>
I see.

>
>> +		rm -f $testfile1
>> +	done
>> +}
>> +
>> +fallocate_work()
>> +{
>> +	rm -f  $testfile2
>> +	while [ 1 ]; do
>> +		$XFS_IO_PROG -f -c "falloc 0 80M" $testfile2 >>$seqres.full 2>&1
>> +		grep "No space left on device" $seqres.full >/dev/null
>> +		if [ $? -eq 0 ]; then
>> +			echo "unexpected ENOSPC error occurs"
>> +			exit 1
>> +		fi
>> +	rm -f $testfile2
>> +	done
>> +}
>> +
>> +run_time=$((180 * $TIME_FACTOR))
> 180s is too long time, I can reproduce it in around 10s on my test vm,
> just loop for 100 times for each operation (pwrite and falloc)
>
>> +write_work &
>> +write_work_pid=$!
>> +fallocate_work &
>> +fallocate_work_pid=$!
>> +
>> +for ((elapsed_time = 0; elapsed_time < run_time; elapsed_time += 5)); do
>> +	kill -0 $write_work_pid >/dev/null 2>&1
>> +	if [ $? -ne 0 ]; then
>> +		kill $fallocate_work_pid >/dev/null 2>&1
>> +		break
>> +	fi
>> +
>> +	kill -0 $fallocate_work_pid >/dev/null 2>&1
>> +	if [ $? -ne 0 ]; then
>> +		kill $write_work_pid >/dev/null 2>&1
>> +		break
>> +	fi
>> +	sleep 5
>> +done
>> +
>> +kill $fallocate_work_pid >/dev/null 2>&1
>> +kill $write_work_pid >/dev/null 2>&1
>> +wait
>> +
>> +# wait un-finished xfs_io
>> +while ps aux | grep "xfs_io" | grep -qv grep; do
>> +	sleep 1
>> +done
> And this seems unnecessarily complicated
>
> So I'd write it as:
>
> echo "Silence is golden"
> for ((i=0; i<100; i++)); do
>          $XFS_IO_PROG -fc "pwrite 0 80M" $testfile1 >/dev/null
>          rm -f $testfile1
> done &
> pids=$!
> for ((i=0; i<100; i++)); do
>          $XFS_IO_PROG -fc "falloc 0 80M" $testfile2 >/dev/null
>          rm -f $testfile2
> done &
> pids="$pids $!"
>
> wait $pids
> status=0
> exit
>
> btrfs failed due to extra "pwrite64: No space left on device" output from
> xfs_io, and ext4 and xfs passed the test within 15s for me.
Thanks for you cleaner scripts.
New patch will be sent soon.

Regards,
Xiaoguang Wang

>
>> +
>> +echo "Silence is golden"
>> +status=0
>> +exit
>> diff --git a/tests/generic/371.out b/tests/generic/371.out
>> new file mode 100644
>> index 0000000..22ec8a2
>> --- /dev/null
>> +++ b/tests/generic/371.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 371
>> +Silence is golden
>> diff --git a/tests/generic/group b/tests/generic/group
>> index 97ecb65..3d4a802 100644
>> --- a/tests/generic/group
>> +++ b/tests/generic/group
>> @@ -373,3 +373,4 @@
>>   368 auto quick richacl
>>   369 auto quick richacl
>>   370 auto quick richacl
>> +371 auto enospc prealloc stress
> So we can add 'quick' group and remove 'stress'.
>
> Thanks,
> Eryu
>
>



