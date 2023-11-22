Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513FA197
	for <fstests@vger.kernel.org>; Wed, 22 Nov 2023 03:28:36 -0800 (PST)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.57])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SZzWY3HNMzvR61;
	Wed, 22 Nov 2023 19:28:09 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 22 Nov 2023 19:28:33 +0800
Message-ID: <731f0033-3a50-d006-add1-538ff141671c@huawei.com>
Date: Wed, 22 Nov 2023 19:28:32 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2] ext4: Regression test of ext4_lblk_t overflow
Content-Language: en-US
To: Zorro Lang <zlang@redhat.com>
CC: <fstests@vger.kernel.org>, <guaneryu@gmail.com>, <amir73il@gmail.com>,
	<ritesh.list@gmail.com>, <yangerkun@huawei.com>, Baokun Li
	<libaokun1@huawei.com>
References: <20231120070327.1922631-1-libaokun1@huawei.com>
 <20231121092853.2fpd4sar77intbho@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20231121092853.2fpd4sar77intbho@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected

On 2023/11/21 17:28, Zorro Lang wrote:
> On Mon, Nov 20, 2023 at 03:03:27PM +0800, Baokun Li wrote:
>> Append writes to a file approaching 16T and observe if a kernel crash is
>> caused by ext4_lblk_t overflow triggering BUG_ON at ext4_mb_new_inode_pa().
>> This is a regression test for commit bc056e7163ac ("ext4: fix BUG in
>> ext4_mb_new_inode_pa() due to overflow")
>>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> ---
>> V1->V2:
>> 	Changes to make the use case more generic, not just for testing
>> 	ext4.(ext4 and xfs have been tested)
> Thanks for this change,
>
>>   tests/generic/737     | 55 +++++++++++++++++++++++++++++++++++++++++++
>>   tests/generic/737.out |  2 ++
>>   2 files changed, 57 insertions(+)
>>   create mode 100755 tests/generic/737
>>   create mode 100644 tests/generic/737.out
>>
>> diff --git a/tests/generic/737 b/tests/generic/737
>> new file mode 100755
>> index 00000000..a65c448b
>> --- /dev/null
>> +++ b/tests/generic/737
>> @@ -0,0 +1,55 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2023 HUAWEI.  All Rights Reserved.
>> +#
>> +# FS QA Test No. 737
>> +#
>> +# Append writes to a file approaching 16T and observe if a kernel crash is
>> +# caused by ext4_lblk_t overflow triggering BUG_ON at ext4_mb_new_inode_pa().
>> +# This is a regression test for commit
>> +# bc056e7163ac ("ext4: fix BUG in ext4_mb_new_inode_pa() due to overflow")
>> +#
>> +#set -x
> Useless comment "set -x"
Oh, I'm sorry, it was for debugging and I forgot to delete it.
>> +. ./common/preamble
>> +. ./common/populate
>> +_begin_fstest auto quick insert prealloc
>> +
>> +# real QA test starts here
>> +_fixed_by_kernel_commit bc056e7163ac \
>> +	"ext4: fix BUG in ext4_mb_new_inode_pa() due to overflow"
> [[ "$FSTYP" =~ ext* ]] && ....
This looks good.
>
>> +
>> +_require_xfs_io_command "falloc"
>> +_require_xfs_io_command "finsert"
>> +
>> +# Initalize a 4k 100M fs
> It might not be 4k block size, so this comment is useless. Or you can say
> better to use "4k" block size to tigger the bug:)
OK!
>> +dev_size=$((100 * 1024 * 1024))
>> +_scratch_mkfs_sized $dev_size >>$seqres.full 2>&1 || _fail "mkfs failed"
>> +
>> +_scratch_mount
>> +blksz="$(_get_block_size ${SCRATCH_MNT})"
>> +_require_odirect $blksz
> I think the _require_odirect can be move up, before the mkfs calling.
Totally agree!
>> +
>> +# Reserve 1M space
>> +$XFS_IO_PROG -f -c "falloc 0 1M" "${SCRATCH_MNT}/tmp" >> $seqres.full
>> +
>> +# Create a file (~16T) with logical block numbers close to overflow
>> +$XFS_IO_PROG -f -c "falloc 0 10M" "${SCRATCH_MNT}/file" >> $seqres.full
>> +insert_size=$((blksz * 4096 - 10 - 3))
>> +$XFS_IO_PROG -f -c "finsert 1M ${insert_size}M" "${SCRATCH_MNT}/file" >> $seqres.full
>> +
>> +# Filling up the free space ensures that the pre-allocated space is the reserved space.
>> +nr_free=$(stat -f -c '%f' ${SCRATCH_MNT})
>> +_fill_fs $((nr_free * blksz)) ${SCRATCH_MNT}/fill $blksz 0 >> $seqres.full 2>&1
>> +sync
>> +
>> +# Remove reserved space to gain free space for allocation
>> +rm -f ${SCRATCH_MNT}/tmp
>> +
>> +# Trying to allocate two blocks triggers BUG_ON.
>> +$XFS_IO_PROG -c "open -ad ${SCRATCH_MNT}/file" -c "pwrite -S 0xff 0 8192" >> $seqres.full
> Shouldn't the 8192 be "$((2 * blksz))", if the comment says "two blocks" ?
Okay, I'll change it to "$((2 * blksz))".
> I tried 1024 blocksize, really can't reproduce this bug, do you know why? Maybe
> related with the falloc/finsert size?
I'm not sure why this isn't triggered at a block size of 1024, I haven't 
looked into this in depth.
> Anyway, it covers this bug on default block size of ext4, and can be a generic
> test on other conditions.
>
> Thanks,
> Zorro

Yes! Thank you very much for your review!

>> +
>> +echo "Silence is golden"
>> +
>> +# success, all done
>> +status=0
>> +exit
>> diff --git a/tests/generic/737.out b/tests/generic/737.out
>> new file mode 100644
>> index 00000000..67b83d78
>> --- /dev/null
>> +++ b/tests/generic/737.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 737
>> +Silence is golden
>> -- 
>> 2.31.1
>>
Thanks!
-- 
With Best Regards,
Baokun Li
.
