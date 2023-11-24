Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A0B10CA
	for <fstests@vger.kernel.org>; Fri, 24 Nov 2023 03:31:34 -0800 (PST)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.57])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ScCV20v16zvRBQ;
	Fri, 24 Nov 2023 19:31:06 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 24 Nov 2023 19:31:31 +0800
Message-ID: <6fe26ecd-e0e1-3172-964e-7f19e2ff424f@huawei.com>
Date: Fri, 24 Nov 2023 19:31:31 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v3] ext4: Regression test of ext4_lblk_t overflow
Content-Language: en-US
To: "Darrick J. Wong" <djwong@kernel.org>
CC: <fstests@vger.kernel.org>, <zlang@redhat.com>, <guaneryu@gmail.com>,
	<amir73il@gmail.com>, <ritesh.list@gmail.com>, <yangerkun@huawei.com>, Baokun
 Li <libaokun1@huawei.com>
References: <20231122115314.875252-1-libaokun1@huawei.com>
 <20231122163203.GJ36175@frogsfrogsfrogs>
 <83e9bfca-28ef-d499-e2e2-488b2c269c12@huawei.com>
 <20231123170329.GK36175@frogsfrogsfrogs>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20231123170329.GK36175@frogsfrogsfrogs>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected

On 2023/11/24 1:03, Darrick J. Wong wrote:
> On Thu, Nov 23, 2023 at 09:46:37PM +0800, Baokun Li wrote:
>> On 2023/11/23 0:32, Darrick J. Wong wrote:
>>> On Wed, Nov 22, 2023 at 07:53:14PM +0800, Baokun Li wrote:
>>>> Append writes to a file approaching 16T and observe if a kernel crash is
>>>> caused by ext4_lblk_t overflow triggering BUG_ON at ext4_mb_new_inode_pa().
>>>> This is a regression test for commit bc056e7163ac ("ext4: fix BUG in
>>>> ext4_mb_new_inode_pa() due to overflow")
>>>>
>>>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>>>> ---
>>>> V1->V2:
>>>> 	Changes to make the use case more generic, not just for testing
>>>> 	ext4.(ext4 and xfs have been tested)
>>>> V2->V3:
>>>> 	Clean up the code and remove hardcoding.
>>>>
>>>>    tests/generic/737     | 53 +++++++++++++++++++++++++++++++++++++++++++
>>>>    tests/generic/737.out |  2 ++
>>>>    2 files changed, 55 insertions(+)
>>>>    create mode 100755 tests/generic/737
>>>>    create mode 100644 tests/generic/737.out
>>>>
>>>> diff --git a/tests/generic/737 b/tests/generic/737
>>>> new file mode 100755
>>>> index 00000000..29d428ad
>>>> --- /dev/null
>>>> +++ b/tests/generic/737
>>>> @@ -0,0 +1,53 @@
>>>> +#! /bin/bash
>>>> +# SPDX-License-Identifier: GPL-2.0
>>>> +# Copyright (c) 2023 HUAWEI.  All Rights Reserved.
>>>> +#
>>>> +# FS QA Test No. 737
>>>> +#
>>>> +# Append writes to a file approaching 16T and observe if a kernel crash is
>>>> +# caused by ext4_lblk_t overflow triggering BUG_ON at ext4_mb_new_inode_pa().
>>>> +# This is a regression test for commit
>>>> +# bc056e7163ac ("ext4: fix BUG in ext4_mb_new_inode_pa() due to overflow")
>>>> +#
>>>> +. ./common/preamble
>>>> +. ./common/populate
>>>> +_begin_fstest auto quick insert prealloc
>>>> +
>>>> +# real QA test starts here
>>>> +[[ "$FSTYP" =~ ext* ]] && _fixed_by_kernel_commit bc056e7163ac \
>>>> +	"ext4: fix BUG in ext4_mb_new_inode_pa() due to overflow"
>>>> +
>>>> +_require_odirect
>>>> +_require_xfs_io_command "falloc"
>>>> +_require_xfs_io_command "finsert"
>>>> +
>>>> +dev_size=$((100 * 1024 * 1024))
>>>> +_scratch_mkfs_sized $dev_size >>$seqres.full 2>&1 || _fail "mkfs failed"
>>>> +
>>>> +_scratch_mount
>>>> +blksz="$(_get_block_size ${SCRATCH_MNT})"
>>> _get_file_block_size, not _get_block_size.  The first one retrieves the
>>> file allocation unit (e.g. ext4 bigalloc cluster size / xfs rt extent
>>> size) whereas the second merely returns the base fs block size.
>>>
>>> That is an important distinction when you're messing with fallocate. :)
>> _get_file_block_size is implemented as follows：
>>
>> _get_file_block_size()
>> {
>>          if [ -z $1 ] || [ ! -d $1 ]; then
>>                  echo "Missing mount point argument for _get_file_block_size"
>>                  exit 1
>> fi
>>
>>          case "$FSTYP" in
>> "ocfs2")
>>                  stat -c '%o' $1
>> ;;
>> "xfs")
>>                  _xfs_get_file_block_size $1
>> ;;
>> *)
>>                  _get_block_size $1
>> ;;
>> esac
>> }
>>
>> The return values of ocfs2 and xfs may be different, but they are the same
>> for ext4. And the logical blocks recorded in ext4 are in blocks, not
>> clusters.
>> I'll replace _get_block_size with _get_file_block_size if
>> _get_file_block_size
>> should be used in xfs.
> Oh silly me, I forgot that the logical block mappings in ext4 remain in
> units of fs blocks, not bigalloc clusters.  So this doesn't make much of
> a difference.
>
>>>> +# Reserve 1M space
>>>> +$XFS_IO_PROG -f -c "falloc 0 1M" "${SCRATCH_MNT}/tmp" >> $seqres.full
>>>> +
>>>> +# Create a file (~16T) with logical block numbers close to overflow
>>>> +$XFS_IO_PROG -f -c "falloc 0 10M" "${SCRATCH_MNT}/file" >> $seqres.full
>>>> +insert_size=$((blksz * 4096 - 10 - 3))
>>> What if blksz == 64k ?  This won't compute a file position slightly
>>> below 16T.  I think the comment is wrong since you're trying to overflow
>>> the u32 ext4_lblk_t, correct?
>> Yes, the comment here is wrong. The actual intention here is to construct a
>> file with logical blocks close to 0x100000000.
>>> I think what you really want is something more like...
>>>
>>> # Shift the last 9M of the file preallocations to a position just short
>>> # of overflowing ext4_lblk_t.
>>> max_pos=$(( 0xffffffff * file_blksz ))
>>> finsert_len=$(( max_pos - ((10 + 3) << 20) ))
>>> $XFS_IO_PROG -f -c "finsert 1M ${finsert_len}" "${SCRATCH_MNT}/file" >> $seqres.full
>> Exactly!
>>> Not sure why you shift 9M of data to 13M below what I think is the
>>> upper range of ext4_lblk_t; I would have thought that would be
>>> (max_pos - 9MB) but I'm assuming you know the reproduction circumstances
>>> better than me...
>>>
>>> --D
>> At 4k block size, when appending writes to a file close to 16T, the block
>> allocation
>> request will be enlarged to 8M, and the current file size + block allocation
>> request
>> size will not exceed 16T.
>>
>> Therefore, the above is just using finsert to construct a file with maximum
>> logical
>> block number close to 0x100000000, the corresponding size at 4k can be in
>> the
>> range of (16T-8M, 16T), the insertion location does not have any special
>> meaning.
>>
>> 3M is not a special value, theoretically it can be in the range of (1M
>> (reserved tmp), 8M].
>> But ext4 reserves 2% of the blocks for metadata, which in this case is 2M,
>> so the
>> interval in which the problem can be triggered becomes (2M, 8M].
> Does the test trigger the bug on other blocksizes like 1k or 64k?
>
> Oh, there's a v4, will go look at that.
>
> --D
In 1k block size, the block allocation request will be enlarged to 2M,
the reserved 2% corresponds to 2M, so we can allocate this 2M extent
instead of the 1M extent of tmp. BUG_ON will only trigger when the
actual allocated request size is smaller than the above 2M. Therefore,
if the ext4 file size is greater than or equal to 100M, the 1k block size
cannot trigger the problem. In this case, we change the mkfs size to
80M, 3M to 2M, after testing, the problem can be triggered in
1k, 4k, 64k block size.

Please ignore the v4 sent yesterday, I will send a new v5 version soon.

Furthermore, while testing the 64k block, I found another bug, and I
will also send a patch to the ext4 mailing list as soon as possible.
>>>> +$XFS_IO_PROG -f -c "finsert 1M ${insert_size}M" "${SCRATCH_MNT}/file" >> $seqres.full
>>>> +
>>>> +# Filling up the free space ensures that the pre-allocated space is the reserved space.
>>>> +nr_free=$(stat -f -c '%f' ${SCRATCH_MNT})
>>>> +_fill_fs $((nr_free * blksz)) ${SCRATCH_MNT}/fill $blksz 0 >> $seqres.full 2>&1
>>>> +sync
>>>> +
>>>> +# Remove reserved space to gain free space for allocation
>>>> +rm -f ${SCRATCH_MNT}/tmp
>>>> +
>>>> +# Trying to allocate two blocks triggers BUG_ON.
>>>> +$XFS_IO_PROG -c "open -ad ${SCRATCH_MNT}/file" -c "pwrite -S 0xff 0 $((2 * blksz))" >> $seqres.full
>>>> +
>>>> +echo "Silence is golden"
>>>> +
>>>> +# success, all done
>>>> +status=0
>>>> +exit
>>>> diff --git a/tests/generic/737.out b/tests/generic/737.out
>>>> new file mode 100644
>>>> index 00000000..67b83d78
>>>> --- /dev/null
>>>> +++ b/tests/generic/737.out
>>>> @@ -0,0 +1,2 @@
>>>> +QA output created by 737
>>>> +Silence is golden
>>>> -- 
>>>> 2.31.1
>>>>
>>>>
>>
Thanks!
-- 
With Best Regards,
Baokun Li
.
