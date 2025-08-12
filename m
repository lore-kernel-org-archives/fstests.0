Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D68E1D435F
	for <fstests@vger.kernel.org>; Tue, 12 Aug 2025 12:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755002170; cv=none; b=RAqjGh17MuG/dqRhf7ygGu6X6fTtfblHFZKOBc0fydih4p53KxFzbqV+cyWuNeS8Qo3SlW1GlDnUm909e79SQNQLbtXXNhyECxPPO9vIVIq39JSTSBdTlazBfyYtB9tRsqS04lm9DPKG8w+7Rxihc6qZCveDPzNdstrI0BScxGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755002170; c=relaxed/simple;
	bh=prox4gHGKbGX3a9wsroZiJykHtZqi1ku5iRdaDj3zgk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TLgIFA67rRTncyiF3lpdRxIsKhl4GonJYZKmO3EUkmwz9CHbuayUhCBPfKYMOfQJIqjl6rrwNAavfneprnbpuL8VcpjqTFvydIbzhdCNZ0KQ3lB1rPBGpDNgXiWMbWmJaJ3ySKEdgLUW4kkhxHepW1QcMUWkLZ1TXeaJprMjDWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBRniQgz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBRniQgz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF669C4CEF0;
	Tue, 12 Aug 2025 12:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755002170;
	bh=prox4gHGKbGX3a9wsroZiJykHtZqi1ku5iRdaDj3zgk=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=dBRniQgzCZxUbgPvudVoG7a0TfmX4MYW4vuAxyeF34uTeIDpEv8ZTWQ4OqHCM5sNn
	 KnCjPK7jFvRTujMMwsPYll/Vx/u6vZ6h1oYoXYqCWPoUdMk2b5z7eJ6gVfXzG8Y9cj
	 LRogFMNhEBrlt0HOFqaxW+7sIBLxm0Y8DuuVH7uDmY3/lDBHsnIaGtVRsfRZON3TU4
	 /9eMy4kBv1Z8WXj3zjxN8LqfvtsNSta8Q6HZwy5MzOCQPKVDB5JC5g/+NQC/Qmi8gR
	 9wjkvRWop7dnfP8ctK/T1dZbqiNDiQu5YkCWD01fuP2HF8If7qW8omkVo7WWM/Oesj
	 UN3iuLF6J1/CA==
Message-ID: <28c2bec6-4ebc-4ac3-9a87-8d5adbe91dbf@kernel.org>
Date: Tue, 12 Aug 2025 20:36:06 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
 jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/3] f2fs/018: check data eof after partial truncation on
 compressed cluster
To: Zorro Lang <zlang@redhat.com>
References: <20250811094415.1053545-1-chao@kernel.org>
 <20250812085656.kg3dsukgbde6skrd@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250812085656.kg3dsukgbde6skrd@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/12/25 16:56, Zorro Lang wrote:
> On Mon, Aug 11, 2025 at 05:44:13PM +0800, Chao Yu wrote:
>> This is a regression testcase, it is added to check below case
>> and its variants:
>> - write 16k data into compressed file (data will be compressed)
>> - truncate file to 12k (truncate partial data in compressed cluster)
>> - truncate file to 20k
>> - verify data in range of [12k, 16k] to see whether data is all zero
>> or not
>>
>> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>  tests/f2fs/018     | 58 ++++++++++++++++++++++++++++++++++++++++++++++
>>  tests/f2fs/018.out |  2 ++
>>  2 files changed, 60 insertions(+)
>>  create mode 100755 tests/f2fs/018
>>  create mode 100644 tests/f2fs/018.out
>>
>> diff --git a/tests/f2fs/018 b/tests/f2fs/018
>> new file mode 100755
>> index 00000000..ca727d24
>> --- /dev/null
>> +++ b/tests/f2fs/018
>> @@ -0,0 +1,58 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2025 Chao Yu.  All Rights Reserved.
>> +#
>> +# FS QA Test No. f2fs/018
>> +#
>> +# This is a regression test to check whether page eof will be
>> +# zero or not after we truncate partial data in compressed
>> +# cluster.
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto quick rw compress
>> +
>> +_fixed_by_kernel_commit ba8dac350faf \
>> +	"f2fs: fix to zero post-eof page"
>> +_fixed_by_kernel_commit xxxxxxxxxxxx \
>> +	"f2fs: fix to zero data after EOF for compressed file correctly"
>> +
>> +_require_scratch
>> +_require_fio
>> +
>> +testfile=$SCRATCH_MNT/testfile
>> +
>> +check_data_eof()
>> +{
>> +	local eof_start=$1
>> +	local eof_size=$2
>> +	local filesize=$3
>> +	local offset1=$4
>> +	local offset2=$5
>> +	local offset3=$6
>> +
>> +	_scratch_mkfs "-O extra_attr,compression" >> $seqres.full || _fail "mkfs failed"
>> +	_scratch_mount "-o compress_extension=*" >> $seqres.full
>> +
>> +	xfs_io -f -c "pwrite 0 $filesize" -c "fsync" $testfile >> $seqres.full
>> +	xfs_io -c "truncate $offset1" $testfile
>> +	xfs_io -c "truncate $offset2" $testfile
> 
> replace "xfs_io" with "$XFS_IO_PROG"

Oops, yes, will update.

> 
>> +
>> +	if [ "$offset3" ]; then
>> +		xfs_io -c "truncate $offset3" $testfile
> 
> Same as above.
> 
> And generally we need: _require_xfs_io_command "truncate"

Ditto,

> 
>> +	fi
>> +
>> +	$FIO_PROG --name=verify-data --filename=$testfile --rw=read --verify=pattern \
>> +		--verify_pattern=0x00 --do_verify=1 --verify_only --offset=$eof_start \
>> +		--size=$eof_size >> $seqres.full 2>&1 || _fail "eof data is not zero"
> 
> Generally we do `_require_fio $fio_config` to make sure all arguments are supported
> by current fio version and FSTYP, refer to generic/366. But as this is a f2fs only
> test, and if you make sure you don't use any new/special fio arguments, I can accept
> this. Or you can refer to generic/366.

Okay, let me take a look.

> 
>> +	_scratch_unmount
> 
> I'm not familar with f2fs much, may I ask why we need to mkfs&mount ... umount
> in each test loop?

Oh, seems it doesn't need to, let me check and clean up it.

Thanks,

> 
> Thanks,
> Zorro
> 
>> +}
>> +
>> +check_data_eof 12k 4k 16k 12k 20k
>> +check_data_eof 10k 6k 16k 10k 20k
>> +check_data_eof 12k 4k 16k 8k 12k 20k
>> +check_data_eof 10k 6k 16k 8k 10k 20k
>> +
>> +echo "Silence is golden"
>> +
>> +status=0
>> +exit
>> diff --git a/tests/f2fs/018.out b/tests/f2fs/018.out
>> new file mode 100644
>> index 00000000..8849e303
>> --- /dev/null
>> +++ b/tests/f2fs/018.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 018
>> +Silence is golden
>> -- 
>> 2.49.0
>>
> 

