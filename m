Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D687487BE
	for <fstests@vger.kernel.org>; Wed, 23 Oct 2024 07:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729667906; cv=none; b=EVLQNvI00H4gpDgoJjc92urqUTMdrtYFz2aUEElI4KOc3WygyEf+rOrmVf4jSnevIxL1MTaCRhL2IBQEVxkE3484jWf5xDA01AQqMGr4X7x7/AkYmf2lIfosaWaKsbWfkTgtTf6P+kMRkUyMJA6jhJwpCMDh28zn1liVmpBcPEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729667906; c=relaxed/simple;
	bh=HZEpojZgfXGKFnv44xgyxZ4cy2+RhSZbW2dyEUNmQCA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XoDGzOu9ykXC9TuH8CNGSAOPe2/jWLmG4BXXEO9WBHCWWzC1VZkPhQe2OQg+V85u8um5av1jcBi/paLGXjwj1YMC9scRCRiGYkQGR5YRQzVftUnr7Zuu3vVnoU/9MHGwstYAOo9jGYcczauK87DoDPSx720MTkAD5SwvGBbqqaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/2hnwda; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/2hnwda"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 352E1C4CEC6;
	Wed, 23 Oct 2024 07:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729667905;
	bh=HZEpojZgfXGKFnv44xgyxZ4cy2+RhSZbW2dyEUNmQCA=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=b/2hnwdap2fSTu7TG+GXmjG9vu4lCnKz7oqQP59t8ZsU4Zwp2t9oL8IkN+zwMB8XC
	 FyIvpJdKXnp0rdb9Eur6pgIz8tnj8F3nRa2/N4RYxb4bwlu8hyZqYCWQjJSpjEnLGy
	 NMmFbBH7ZD67w7bEt6MGmCZ/oxZNuNKaUOry1B85+EHbEMZLoh0/T/nv6s4v6zE2HJ
	 o8htg3M8CdbOqIo4Zz4dyMpr6jP6a8EGY70uNN8oKUR9eDd0FG3sQJT9n6NfyWxRHK
	 13XhxMXLMnsyu4ViuU17ZcbR0wDHurljFUMMv15sQz1XHFZ4MHFDcHSsbD03bGJX43
	 7W7bh+Y+t/E/g==
Message-ID: <56b6a57d-c0db-4a6e-a7a9-e5d1a7396b83@kernel.org>
Date: Wed, 23 Oct 2024 15:18:21 +0800
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
Subject: Re: [PATCH 2/2] f2fs/007: add testcase to check consistency of
 compressed inode metadata
To: Zorro Lang <zlang@redhat.com>
References: <20241015025106.3203676-1-chao@kernel.org>
 <20241015025106.3203676-2-chao@kernel.org>
 <20241023030746.5e53w26p5qtfbpod@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20241023030746.5e53w26p5qtfbpod@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/23 11:07, Zorro Lang wrote:
> On Tue, Oct 15, 2024 at 10:51:06AM +0800, Chao Yu wrote:
>> metadata of compressed inode should always be consistent after file
>> compression, reservation, releasement and decompression, let's add
>> a testcase to check it.
>>
>> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
>> Cc: Qi Han <hanqi@vivo.com>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>   tests/f2fs/007     | 116 +++++++++++++++++++++++++++++++++++++++++++++
>>   tests/f2fs/007.out |   4 ++
>>   2 files changed, 120 insertions(+)
>>   create mode 100755 tests/f2fs/007
>>   create mode 100644 tests/f2fs/007.out
>>
>> diff --git a/tests/f2fs/007 b/tests/f2fs/007
>> new file mode 100755
>> index 00000000..274be806
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
> 
> Hi Chao,
> 
> Thanks for the new f2fs test cases.
> 
> If there's a known fix for this regression, please mark it by:
> 
> _fixed_by_kernel_commit .....

Zorro,

Yes, but not been merged yet, so let me add as below and replace
commit_id after upstreaming the fix.

_fixed_by_kernel_commit xxxxxxxxxxxx \
         "f2fs: compress: fix inconsistent update of i_blocks in release_compress_blocks and reserve_compress_blocks"

Thanks for all comments below, will fix all.

Thanks,

> 
>> +# can become inconsistent after file compression, reservation
>> +# releasement, and decompression.
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto quick
>                              ^^^^
>                              rw compress ?
> 
>> +
>> +_cleanup()
>> +{
>> +	cd /
>> +	rm -r -f tmp.*
>> +}
> 
> This's same with default _cleanup, so it can be removed.
> 
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
>> +filename=/mnt/scratch_f2fs/testfile30
>              ^^^^^^^^^^
> 
> $SCRATCH_MNT or ${testfile_prefix}30 ?
> 
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
>> +filename=/mnt/scratch_f2fs/testfile60
> 
> Same as above.
> 
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
>> +filename=/mnt/scratch_f2fs/testfile90
> 
> Same as above
> 
>> +buffer_compress_percentage=90
>> +EOF
>> +
>> +_require_fio $fio_config
>> +_require_scratch
> 
> I'd like to call _require_scratch at the beginning, especially you use
> SCRATCH_* things in $fio_config. You can refer to generic/095.
> 
>> +_scratch_mkfs "-f -O extra_attr,compression" >> $seqres.full
> 
> Can you make sure this mkfs never fail? Maybe:
>      || _fail "...."
> 
>> +_scratch_mount "-o compress_mode=user,compress_extension=*" >> $seqres.full
>> +
>> +echo -e "Run fio to initialize file w/ specified compress ratio" >> $seqres.full
>> +cat $fio_config >> $seqres.full
>> +$FIO_PROG $fio_config >> $seqres.full
>> +_scratch_unmount
>> +
>> +for i in 30 60 90; do
>> +	testfile=$testfile_prefix$i
>> +
>> +	_scratch_mount "-o compress_mode=user" >> $seqres.full
>> +	f2fs_io compress $testfile >> $seqres.full
>          ^^^^^^^
> $F2FS_IO_PROG
> 
>> +	cblocks=`f2fs_io get_cblocks $testfile`
>                   ^^^^^^^
> $F2FS_IO_PROG
> 
>> +	echo "compression ratio is: "$cblocks" / 256"
>> +
>> +	_scratch_unmount
>> +
>> +	# 1. check after compression
>> +	fsck -t $FSTYP -f $SCRATCH_DEV >> $seqres.full
> 
> _check_scratch_fs ?
> 
> If f2fs needs some custom operations, please change the _check_scratch_fs
> or _check_generic_filesystem.
> 
>> +	if [ $? -ne 0 ]; then
>> +		_fail "filesystem becomes corrupted after compress"
>> +	fi
>> +
>> +	_scratch_mount >> $seqres.full
>> +	f2fs_io release_cblocks $testfile >> $seqres.full
> 
> $F2FS_IO_PROG
> 
>> +	_scratch_unmount
>> +
>> +	# 2. check after releasement
>> +	fsck -t $FSTYP -f $SCRATCH_DEV >> $seqres.full
> 
> _check_scratch_fs
> 
>> +	if [ $? -ne 0 ]; then
>> +		_fail "filesystem becomes corrupted after release_cblocks"
>> +	fi
>> +
>> +	_scratch_mount >> $seqres.full
>> +	f2fs_io reserve_cblocks $testfile >> $seqres.full
> 
> $F2FS_IO_PROG
> 
>> +	_scratch_unmount
>> +
>> +	# 3. check after rservation
>> +	fsck -t $FSTYP -f $SCRATCH_DEV >> $seqres.full
> 
> _check_scratch_fs
> 
>> +	if [ $? -ne 0 ]; then
>> +		_fail "filesystem becomes corrupted after reserve_cblocks"
>> +	fi
>> +
>> +	_scratch_mount "-o compress_mode=user" >> $seqres.full
>> +	f2fs_io decompress $testfile >> $seqres.full
> 
> $F2FS_IO_PROG
> 
>> +	_scratch_unmount
>> +
>> +	# 4. check after decompression
>> +	fsck -t $FSTYP -f $SCRATCH_DEV >> $seqres.full
> 
> _check_scratch_fs
> 
> Thanks,
> Zorro
> 
>> +	if [ $? -ne 0 ]; then
>> +		_fail "filesystem becomes corrupted after decompress"
>> +	fi
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

