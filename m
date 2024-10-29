Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B510C17BD6
	for <fstests@vger.kernel.org>; Tue, 29 Oct 2024 07:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730188066; cv=none; b=CrcZfRwl3REF1oWDP+tbXxXMpqe6WIwTwSoEEXMxJ2LbnMnC96lrRU8PaKscYluCID3KwPuyMva5OJD6I8bAhHRYyHmJB2dfALn6uvhj4Q6jeHDsva8NHC3jKRa1dNoJsDlgEde6blClOaLFRtG3Yc5FJFeYN6MmwRMeq6rS/5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730188066; c=relaxed/simple;
	bh=5p3svHAkNxkSh97zKZkxSvBXYWMJQfLj/K6ZploJeb4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uaDj3jLEOfID0BoFLkjWK/F8E/83L6x12EdXPCYuIlBnPGSo5jc8a9k7mSEMh4WLcvuREaFxCJiR/WYv4Lbti7AagiZEiiRrEJh1A2gMjkjAjBU2k9BDxNcbYBQOpLT2MaZDTB1ENUVN6bbX1RT4IO5XtvHnikFIpvWgOI9wrw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VCfbXKXX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCfbXKXX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64AD1C4CECD;
	Tue, 29 Oct 2024 07:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730188066;
	bh=5p3svHAkNxkSh97zKZkxSvBXYWMJQfLj/K6ZploJeb4=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=VCfbXKXXzVjDh7FSmljN/6/MYphw7JOnKZ7T1+1senSfyt/OUGx5Jj5v51YldrAXf
	 VrPpW48VT6sZkzvK3Tv6xTK6LIx3sJ9bNxGOJz4voGxL/kqbnjU3vK52es0+T0RtgU
	 NgHJYRtiavF9hMO5L61Tv5vt4DpA3K1Jm14qQbnBc373JeYsbaURwKRISXFgWfktRL
	 MJ0iL9UxEl/u6YALcjWdtjs3OZwRfBN4SmkxBdxa3NxcU51ER8LZu5fD8Et0xZ8okG
	 RGkuOqrw0nH/E5btf6nGN3N5T3Apfg+GKD741QdzcJney7u6tU4iDzigv4a//nY8Mw
	 mbGpD7+bECiSw==
Message-ID: <8244a092-4775-47a4-8754-1bb1d1ea3c56@kernel.org>
Date: Tue, 29 Oct 2024 15:47:41 +0800
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
Subject: Re: [PATCH v3 2/2] f2fs/007: add testcase to check consistency of
 compressed inode metadata
To: Zorro Lang <zlang@redhat.com>
References: <20241028141800.1788356-1-chao@kernel.org>
 <20241028141800.1788356-2-chao@kernel.org>
 <20241029062104.pepwqv4w4scvgiy4@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20241029062104.pepwqv4w4scvgiy4@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/29 14:21, Zorro Lang wrote:
> On Mon, Oct 28, 2024 at 10:18:00PM +0800, Chao Yu wrote:
>> metadata of compressed inode should always be consistent after file
>> compression, reservation, releasement and decompression, let's add
>> a testcase to check it.
>>
>> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
>> Cc: Qi Han <hanqi@vivo.com>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>> v3:
>> - move _require_scratch before use of $SCRATCH_MNT
>> - output message before _check_scratch_fs
>>   tests/f2fs/007     | 108 +++++++++++++++++++++++++++++++++++++++++++++
>>   tests/f2fs/007.out |  16 +++++++
>>   2 files changed, 124 insertions(+)
>>   create mode 100755 tests/f2fs/007
>>   create mode 100644 tests/f2fs/007.out
>>
>> diff --git a/tests/f2fs/007 b/tests/f2fs/007
>> new file mode 100755
>> index 00000000..805d88fa
>> --- /dev/null
>> +++ b/tests/f2fs/007
>> @@ -0,0 +1,108 @@
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
>> +_require_scratch
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
> 
>                repair
> 
>> +export FSCK_OPTIONS="-f $FSCK_OPTIONS"
> 
> JFYI, if f2f2 always hope to force to repair, you can think about changing the _fsck_opts()
> in common/config.

Got it, thanks for your reminder.

> 
> Others look good to me, I'll help to fix above typo when I merge it. Thanks for you patch.

Thank you!

Thanks,

> 
> Reviewed-by: Zorro Lang <zlang@redhat.com>
> 
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
>> +	echo "check fs after compress"
>> +	_check_scratch_fs
>> +
>> +	_scratch_mount >> $seqres.full
>> +	$F2FS_IO_PROG release_cblocks $testfile >> $seqres.full
>> +	_scratch_unmount
>> +
>> +	# 2. check after releasement
>> +	echo "check fs after release_cblocks"
>> +	_check_scratch_fs
>> +
>> +	_scratch_mount >> $seqres.full
>> +	$F2FS_IO_PROG reserve_cblocks $testfile >> $seqres.full
>> +	_scratch_unmount
>> +
>> +	# 3. check after rservation
>> +	echo "check fs after reserve_cblocks"
>> +	_check_scratch_fs
>> +
>> +	_scratch_mount "-o compress_mode=user" >> $seqres.full
>> +	$F2FS_IO_PROG decompress $testfile >> $seqres.full
>> +	_scratch_unmount
>> +
>> +	# 4. check after decompression
>> +	echo "check fs after decompress"
>> +	_check_scratch_fs
>> +done
>> +
>> +status=0
>> +exit
>> diff --git a/tests/f2fs/007.out b/tests/f2fs/007.out
>> new file mode 100644
>> index 00000000..a4b76300
>> --- /dev/null
>> +++ b/tests/f2fs/007.out
>> @@ -0,0 +1,16 @@
>> +QA output created by 007
>> +compression ratio is: 64 / 256
>> +check fs after compress
>> +check fs after release_cblocks
>> +check fs after reserve_cblocks
>> +check fs after decompress
>> +compression ratio is: 128 / 256
>> +check fs after compress
>> +check fs after release_cblocks
>> +check fs after reserve_cblocks
>> +check fs after decompress
>> +compression ratio is: 192 / 256
>> +check fs after compress
>> +check fs after release_cblocks
>> +check fs after reserve_cblocks
>> +check fs after decompress
>> -- 
>> 2.40.1
>>
> 

