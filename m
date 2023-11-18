Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672A1D6A
	for <fstests@vger.kernel.org>; Fri, 17 Nov 2023 19:08:12 -0800 (PST)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.57])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SXJWc6nLbzNm5Z;
	Sat, 18 Nov 2023 11:03:56 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 18 Nov 2023 11:08:10 +0800
Message-ID: <d8478c10-56f0-614a-776e-f721048a534f@huawei.com>
Date: Sat, 18 Nov 2023 11:08:10 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] ext4: Regression test of ext4_lblk_t overflow
To: Zorro Lang <zlang@redhat.com>
CC: <fstests@vger.kernel.org>, <guaneryu@gmail.com>, <amir73il@gmail.com>,
	<ritesh.list@gmail.com>, <yangerkun@huawei.com>, Baokun Li
	<libaokun1@huawei.com>
References: <20231028070123.971548-1-libaokun1@huawei.com>
 <20231117142451.mhjdsgbqljzkvzuv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20231117142451.mhjdsgbqljzkvzuv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected

On 2023/11/17 22:24, Zorro Lang wrote:
> Hi Baokun,
>
> Thanks for this new coverage, some review points as below ...
>
Hi Zorro,

Thank you for your careful review！

>>   tests/ext4/062     | 53 ++++++++++++++++++++++++++++++++++++++++++++++
>>   tests/ext4/062.out |  2 ++
>>   2 files changed, 55 insertions(+)
>>   create mode 100755 tests/ext4/062
>>   create mode 100644 tests/ext4/062.out
>>
>> diff --git a/tests/ext4/062 b/tests/ext4/062
>> new file mode 100755
>> index 00000000..0ae4ed80
>> --- /dev/null
>> +++ b/tests/ext4/062
>> @@ -0,0 +1,53 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2023 HUAWEI.  All Rights Reserved.
>> +#
>> +# FS QA Test No. 062
>> +#
>> +# Append writes to a file approaching 16T and observe if a kernel crash is
>> +# caused by ext4_lblk_t overflow triggering BUG_ON at ext4_mb_new_inode_pa().
>> +# This is a regression test for commit
>> +# bc056e7163ac ("ext4: fix BUG in ext4_mb_new_inode_pa() due to overflow")
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto quick insert
>                                     ^^^
>                                     prealloc
I'll add this.
>> +
>> +# real QA test starts here
>> +_supported_fs ext4
>> +_fixed_by_kernel_commit bc056e7163ac \
>> +	"ext4: fix BUG in ext4_mb_new_inode_pa() due to overflow"
>> +
>> +_require_xfs_io_command "falloc"
>> +_require_xfs_io_command "open"
>> +_require_xfs_io_command "pwrite"
> I think we don't need to check the "open" and "pwrite" operations,
> if you don't need special option for them.
OK!
>> +_require_scratch_size_nocheck $((100 * 1024))   # 100MB in KB
> I think 100MB is small enough, don't need this check.
All right!
>> +
>> +# Initalize a 4k 100M ext4 fs
>> +dev_size=$((100 * 1024 * 1024))
>> +MKFS_OPTIONS="-b 4096 $MKFS_OPTIONS" _scratch_mkfs_sized $dev_size \
>> +	>>$seqres.full 2>&1 || _fail "mkfs failed"
> Can we use bsize=$(_get_file_block_size ....) to get the real block size,
> to avoid use a specific mkfs option?
> If so, my second question is if this case can be a generic case. The test
> steps look common enough, I'm glad to see what will happen on other
> filesystems through this test.
The reason for specifying 4096 for formatting here is that mkfs.ext4 
specifies a
default block size of 1024 when the disk image is 100M.

Although these operations appear to be generic scenarios, the 
reproduction of
this problem relies on ext4's pre-allocation mechanism. Block allocation 
requests
are scaled up in ext4_mb_normalize_request(), and the extra blocks are 
used for
preallocation to reduce fragmentation. Therefore, this test case is 
placed only in
the ext4 test suite.
>
>> +
>> +_scratch_mount
>> +
>> +# Reserve 1M space
>> +$XFS_IO_PROG -f -c "falloc 0 1M" "${SCRATCH_MNT}/tmp" >> $seqres.full 2>&1
>> +
>> +# Create a file with logical block numbers close to overflow
>> +$XFS_IO_PROG -f -c "falloc 0 10M" "${SCRATCH_MNT}/file" >> $seqres.full 2>&1
>> +$XFS_IO_PROG -f -c "finsert 1M 16777203M" "${SCRATCH_MNT}/file" >> $seqres.full 2>&1
> _require_xfs_io_command "finsert"
Okay.
>
>> +
>> +# Filling up the free space ensures that the pre-allocated space is the reserved space.
>> +$XFS_IO_PROG -f -c "falloc 0 80388096" "${SCRATCH_MNT}/fill" >> $seqres.full 2>&1
> Can we make sure this step fill the whole free space? There's a helper in
> common/populate named _fill_fs, please check if it's what you want?
The remaining space for a 100M 4k ext4 image after the previous 
operations is
80388096, so we can confirm that we can fill the entire free space here.
Of course, using _fill_fs is also workable, but it's faster to do it in 
a single fallocate.
>> +
>> +# Remove reserved space to gain free space for allocation
>> +rm -f ${SCRATCH_MNT}/tmp
>> +
>> +# Trying to allocate two blocks triggers BUG_ON.
>> +$XFS_IO_PROG -c "open -ad ${SCRATCH_MNT}/file" -c "pwrite -S 0xff 0 8192" >> $seqres.full 2>&1
> Oh, you need open -d option, that means you need direct IO, so you need:
> _require_odirect

Indeed!

> And all above xfs_io commands, include falloc, finsert, open and pwrite.
> You can redirect the stdout to $seqres.full, but better *not* to change
> the stderr, for we can find errors if they fail (except that expected ENOSPC).
Ok, I'll remove the unnecessary "2>&1"!
>> +
>> +umount "${SCRATCH_MNT}"
> The $SCRATCH_MNT will be unmounted at the end of the testing, don't need to do
> it manually, except this's a necessary step of the reproducer.
Okay, I will remove it.
>
>> +echo "Silence is golden"
>> +
>> +# success, all done
>> +status=0
>> +exit
>> diff --git a/tests/ext4/062.out b/tests/ext4/062.out
>> new file mode 100644
>> index 00000000..a1578f48
>> --- /dev/null
>> +++ b/tests/ext4/062.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 062
>> +Silence is golden
>> -- 
>> 2.31.1
>>
>>
>
Thanks!
-- 
With Best Regards,
Baokun Li
.
