Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E12F18FDA5
	for <fstests@vger.kernel.org>; Mon, 28 Oct 2024 09:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730109403; cv=none; b=UsA1Mnm3+rumv1t9S/shP9n5reMmLqa+2mLHBA9Bihqo3/aT6s0HUlLV1ymiMgc0fggrF3ifc1et3XS5DC7eJRUjgqqiB16vFcTLx9l/SNim2faPY4/fbIWFK4e4VWQFh9cULi1ZxWr2MQP0FqVQIDgS992rL+SyQPwekX37neA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730109403; c=relaxed/simple;
	bh=Aw1TCrslxEE8zF/NKWKONs8Tgt/MP8lPVbB9dltlncg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sxT10h+lArhvtZQ87ymz+TcV5R/eipefAxiufZPsHC7L9LWR0aaa3xddzEX8caQ2BZaknWUjoM2R0f8xzRS+/+VOlKWaTkLXOkT/2lHAOP+6iJQLER5oxfNDAMIjA2SNrdKkd7ZQGo9FQUptiT31YfKblP9HFWS0S7H1q73eOAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SD2K2MIu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SD2K2MIu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AFAFC4CEC3;
	Mon, 28 Oct 2024 09:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730109402;
	bh=Aw1TCrslxEE8zF/NKWKONs8Tgt/MP8lPVbB9dltlncg=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=SD2K2MIu7RtjoaKThBfqnKXJaiFigFhtWMPd6EvOphgekE/75Vx8s+HRJHaAIK2AL
	 QkU5O5PXfLjlYl4jZPCom3zaSeOZqLk/G80BtUZKI9IleSnWnOg26JlwHuMYU9klwc
	 cRMyJUoX4v3iJHQZB3NIVoyWizrREUY8NZgpWNuRhvqGDrN6gsW9I/ZxHyvEogKp1g
	 g9cXFddF6QPrtjSyCSKnNCXV5hvDVbjvPSbopocxT5+jmEvPvU3KB3hOonX/EJZZDb
	 F2PwsmY3PChl1wOhwaasfotrA/0H0vvfWouUKiubONiNTOR4t7Nyh4gDqJhUHhvEY2
	 GP1sX54mXOHaA==
Message-ID: <85043d8c-78e3-43ef-a5ae-2299b63b67b7@kernel.org>
Date: Mon, 28 Oct 2024 17:56:39 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, fstests@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Qi Han <hanqi@vivo.com>
Subject: Re: [PATCH v2 2/2] f2fs/007: add testcase to check consistency of
 compressed inode metadata
To: Zorro Lang <zlang@redhat.com>
References: <20241023081602.3806579-1-chao@kernel.org>
 <20241023081602.3806579-2-chao@kernel.org>
 <20241025035824.3i62khlg3juccxeb@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20241025035824.3i62khlg3juccxeb@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/25 11:58, Zorro Lang wrote:
> On Wed, Oct 23, 2024 at 04:16:02PM +0800, Chao Yu wrote:
>> metadata of compressed inode should always be consistent after file
>> compression, reservation, releasement and decompression, let's add
>> a testcase to check it.
>>
>> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
>> Cc: Qi Han <hanqi@vivo.com>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>> v2:
>> - add _fixed_by_kernel_commit()
>> - code cleanup
>> - add error handling for _scratch_mkfs()
>>   tests/f2fs/007     | 116 +++++++++++++++++++++++++++++++++++++++++++++
>>   tests/f2fs/007.out |   4 ++
>>   2 files changed, 120 insertions(+)
>>   create mode 100755 tests/f2fs/007
>>   create mode 100644 tests/f2fs/007.out
>>
>> diff --git a/tests/f2fs/007 b/tests/f2fs/007
>> new file mode 100755
>> index 00000000..8979c21c
>> --- /dev/null
>> +++ b/tests/f2fs/007
>> @@ -0,0 +1,116 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2024 Oppo.  All Rights Reserved.
>> +#
>> +# FS QA Test No. f2fs/007
>> +#
>> +# This is a regression test to check whether compressed metadata
>> +# can become inconsistent after file compression, reservation
>> +# releasement, and decompression.
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto quick rw compress
>> +
>> +_fixed_by_kernel_commit xxxxxxxxxxxx \
>> +        "f2fs: compress: fix inconsistent update of i_blocks in release_compress_blocks and reserve_compress_blocks"
>> +
>> +testfile_prefix=$SCRATCH_MNT/testfile
>> +fio_config=$tmp.fio
>> +
>> +cat >$fio_config <<EOF
>> +[write_compressed_data_30]
>> +name=mytest
>> +ioengine=psync
>> +rw=write
>> +direct=0
>> +bs=1M
>> +filesize=1M
>> +numjobs=1
>> +filename=${testfile_prefix}30
>> +buffer_compress_percentage=30
>> +
>> +[write_compressed_data_60]
>> +name=mytest
>> +ioengine=psync
>> +rw=write
>> +direct=0
>> +bs=1M
>> +filesize=1M
>> +numjobs=1
>> +filename=${testfile_prefix}60
>> +buffer_compress_percentage=60
>> +
>> +[write_compressed_data_90]
>> +name=mytest
>> +ioengine=psync
>> +rw=write
>> +direct=0
>> +bs=1M
>> +filesize=1M
>> +numjobs=1
>> +filename=${testfile_prefix}90
>> +buffer_compress_percentage=90
>> +EOF
>> +
>> +_require_scratch
> 
> Better to move _require_scratch before "testfile_prefix=$SCRATCH_MNT/testfile".
> Due to we'd better to make sure there's $SCRATCH_MNT, before using it.
> 
>> +_require_fio $fio_config
>> +_scratch_mkfs "-f -O extra_attr,compression" >> $seqres.full || _fail "mkfs failed"
>> +_scratch_mount "-o compress_mode=user,compress_extension=*" >> $seqres.full
>> +
>> +echo -e "Run fio to initialize file w/ specified compress ratio" >> $seqres.full
>> +cat $fio_config >> $seqres.full
>> +$FIO_PROG $fio_config >> $seqres.full
>> +_scratch_unmount
>> +
>> +# force to repaire if filesystem is corrupted
>> +export FSCK_OPTIONS="-f $FSCK_OPTIONS"
>> +
>> +for i in 30 60 90; do
>> +	testfile=$testfile_prefix$i
>> +
>> +	_scratch_mount "-o compress_mode=user" >> $seqres.full
>> +	$F2FS_IO_PROG compress $testfile >> $seqres.full
>> +	cblocks=`$F2FS_IO_PROG get_cblocks $testfile`
>> +	echo "compression ratio is: "$cblocks" / 256"
>> +
>> +	_scratch_unmount
>> +
>> +	# 1. check after compression
>> +	_check_scratch_fs
>> +	if [ $? -ne 0 ]; then
>> +		_fail "filesystem becomes corrupted after compress"
>> +	fi
>> +
>> +	_scratch_mount >> $seqres.full
>> +	$F2FS_IO_PROG release_cblocks $testfile >> $seqres.full
>> +	_scratch_unmount
>> +
>> +	# 2. check after releasement
>> +	_check_scratch_fs
>> +	if [ $? -ne 0 ]; then
>> +		_fail "filesystem becomes corrupted after release_cblocks"
> 
> The _fail is not necessary, due to _check_scratch_fs will do "exit 1"
> if it find a corruption. If you need some message, maybe echo it before
> calling _check_scratch_fs?
> 
>> +	fi
>> +
>> +	_scratch_mount >> $seqres.full
>> +	$F2FS_IO_PROG reserve_cblocks $testfile >> $seqres.full
>> +	_scratch_unmount
>> +
>> +	# 3. check after rservation
>> +	_check_scratch_fs
>> +	if [ $? -ne 0 ]; then
>> +		_fail "filesystem becomes corrupted after reserve_cblocks"
>> +	fi
> 
> Same as above
> 
>> +
>> +	_scratch_mount "-o compress_mode=user" >> $seqres.full
>> +	$F2FS_IO_PROG decompress $testfile >> $seqres.full
>> +	_scratch_unmount
>> +
>> +	# 4. check after decompression
>> +	_check_scratch_fs
>> +	if [ $? -ne 0 ]; then
>> +		_fail "filesystem becomes corrupted after decompress"
>> +	fi
> 
> Same as above.

Okay, let me update the patch.

Thanks,

> 
> Thanks,
> Zorro
> 
>> +done
>> +
>> +status=0
>> +exit
>> diff --git a/tests/f2fs/007.out b/tests/f2fs/007.out
>> new file mode 100644
>> index 00000000..2ea71c18
>> --- /dev/null
>> +++ b/tests/f2fs/007.out
>> @@ -0,0 +1,4 @@
>> +QA output created by 007
>> +compression ratio is: 64 / 256
>> +compression ratio is: 128 / 256
>> +compression ratio is: 192 / 256
>> -- 
>> 2.40.1
>>
> 

