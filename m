Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC14E83
	for <fstests@vger.kernel.org>; Sun, 19 Nov 2023 19:44:23 -0800 (PST)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.57])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4SYYFJ4QzRz1P8X4;
	Mon, 20 Nov 2023 11:40:52 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 20 Nov 2023 11:44:18 +0800
Message-ID: <a28b6f57-af85-e263-4733-dcb21048b696@huawei.com>
Date: Mon, 20 Nov 2023 11:44:17 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] ext4: Regression test of ext4_lblk_t overflow
Content-Language: en-US
To: Zorro Lang <zlang@redhat.com>
CC: <fstests@vger.kernel.org>, <guaneryu@gmail.com>, <amir73il@gmail.com>,
	<ritesh.list@gmail.com>, <yangerkun@huawei.com>, Baokun Li
	<libaokun1@huawei.com>
References: <20231028070123.971548-1-libaokun1@huawei.com>
 <20231117142451.mhjdsgbqljzkvzuv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <d8478c10-56f0-614a-776e-f721048a534f@huawei.com>
 <20231119131427.topibmy2xdi36a7x@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20231119131427.topibmy2xdi36a7x@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected

On 2023/11/19 21:14, Zorro Lang wrote:
> On Sat, Nov 18, 2023 at 11:08:10AM +0800, Baokun Li wrote:
>> On 2023/11/17 22:24, Zorro Lang wrote:
>>> Hi Baokun,
>>>
>>> Thanks for this new coverage, some review points as below ...
>>>
>> Hi Zorro,
>>
>> Thank you for your careful review！
>>
>>>> +
>>>> +# Initalize a 4k 100M ext4 fs
>>>> +dev_size=$((100 * 1024 * 1024))
>>>> +MKFS_OPTIONS="-b 4096 $MKFS_OPTIONS" _scratch_mkfs_sized $dev_size \
>>>> +	>>$seqres.full 2>&1 || _fail "mkfs failed"
>>> Can we use bsize=$(_get_file_block_size ....) to get the real block size,
>>> to avoid use a specific mkfs option?
>>> If so, my second question is if this case can be a generic case. The test
>>> steps look common enough, I'm glad to see what will happen on other
>>> filesystems through this test.
>> The reason for specifying 4096 for formatting here is that mkfs.ext4
>> specifies a
>> default block size of 1024 when the disk image is 100M.
> Is the reproducer related with the block size. If it's not, we can use
> "bsize=$(_get_file_block_size $SCRATCH_MNT)" to get the block size, and change
> later 4096 to $bsize.
This problem is really hard to reproduce when the block size is 1024, 
but the
good thing is that the default block size specified in 
_scratch_mkfs_sized()
is 4096, so we can leave the block size of 4096 unspecified here.
>
>> Although these operations appear to be generic scenarios, the reproduction
>> of
>> this problem relies on ext4's pre-allocation mechanism. Block allocation
>> requests
>> are scaled up in ext4_mb_normalize_request(), and the extra blocks are used
>> for
>> preallocation to reduce fragmentation. Therefore, this test case is placed
>> only in
>> the ext4 test suite.
> Sure it's a reproducer for ext4, but it can be run for other filesystems
> which support falloc and finsert. And:
>    _require_xfs_io_command "falloc"
>    _require_xfs_io_command "finsert"
> will make sure the current FSTYP supports these two features. So it can
> be a bug coverage for ext4, and a generic test case for other fs.
Totally agree, I'll put it in generic test suite in next version, the 
execution of
this use case takes only 1-2s, it doesn't seem to have any impact.
>>>> +
>>>> +_scratch_mount
>>>> +
>>>> +# Reserve 1M space
>>>> +$XFS_IO_PROG -f -c "falloc 0 1M" "${SCRATCH_MNT}/tmp" >> $seqres.full 2>&1
>>>> +
>>>> +# Create a file with logical block numbers close to overflow
>>>> +$XFS_IO_PROG -f -c "falloc 0 10M" "${SCRATCH_MNT}/file" >> $seqres.full 2>&1
>>>> +$XFS_IO_PROG -f -c "finsert 1M 16777203M" "${SCRATCH_MNT}/file" >> $seqres.full 2>&1
>>> _require_xfs_io_command "finsert"
>> Okay.
>>>> +
>>>> +# Filling up the free space ensures that the pre-allocated space is the reserved space.
>>>> +$XFS_IO_PROG -f -c "falloc 0 80388096" "${SCRATCH_MNT}/fill" >> $seqres.full 2>&1
>>> Can we make sure this step fill the whole free space? There's a helper in
>>> common/populate named _fill_fs, please check if it's what you want?
>> The remaining space for a 100M 4k ext4 image after the previous operations
>> is
>> 80388096, so we can confirm that we can fill the entire free space here.
>> Of course, using _fill_fs is also workable, but it's faster to do it in a
>> single fallocate.
> I'm not sure how the reservation works, if there're 90M free space, and you
> try to reserve 90+M, will once fallocate calling trys to reserve each free
> blocks, before returning error? If it's not, I think the _fill_fs might be
> what you want.
>
> Thanks,
> Zorro
ext4_fallocate will try to allocate all free blocks if the size to be 
allocated exceeds
the free space on the filesystem, but will still return an error. I've 
tested _fill_fs and
it works well too. I will use _fill_fs in the next release to make this 
use case more generic.

Thanks!
-- 
With Best Regards,
Baokun Li
.

