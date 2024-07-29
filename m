Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA1AD535
	for <fstests@vger.kernel.org>; Mon, 29 Jul 2024 01:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722215427; cv=none; b=jZNhlcuASm9acKvgAJSNcwVBgY23EMjBCvBJsBkJYWTdMdcI6eg13hGMmNDqZhkok4Q3P7lw7+Ibu+aB6lJZozpo2zhELGK6G4nbyb2fTFkAZ5BR1wmkT6Tgc6iaiXA9h0dxeF0kgoq3FGCTEOFPHwrXT5FVuTKKbOwMk+tt9UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722215427; c=relaxed/simple;
	bh=rsdtn6n+gSqoqURluDSAQfnmhx9Esq3YqTSrLvnxxS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QJAmB/stT0HGJwF7jxUsP9RWVX7c9fNV2SYsWaiG+9BjB59kxDNQgEUscKHXggWvwZqj3SCn/51Rx0Pd2zRSqEmpE1QzqLKESVX30ZGFimZNKZ/fI3uXal6ARj9CNbrBS7RF9P6DwSEECigoiC/RKuIkZsi+zEg6/N2HaaBGOt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PcAEzclw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PcAEzclw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 724E8C116B1;
	Mon, 29 Jul 2024 01:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722215427;
	bh=rsdtn6n+gSqoqURluDSAQfnmhx9Esq3YqTSrLvnxxS0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PcAEzclworL6t1rf2+6Vdh2fxdjvg8rsB039fWwZni8pI9ILiDnIkndobfEcXgvy6
	 3teP7kohR+eNr0LWFT3ZXE4+0hDR987Nzp9jH6VJzQueTRDt/bzhr6xj3A6IJHV3fZ
	 Ja5+Y3v4yD0cH2LM23njc5T/zNlLfv2SSJjx+kOn9tGFfvf5R331WHKLl0BmxGOF5l
	 Al5FhCEo0cu8hFRrZDntdfSNFLE1D7NvKa/jEfAVfgra+MtnPgDbnP+QAHd3HmSkX3
	 2XslSuIuqjiqW1EKKYPc2Pb3ZC1JlBom6KMDLsztqxt2c50v5YBj/JOubSYKBr19+G
	 poRecwvLaa1XA==
Message-ID: <17f4eedc-f51a-4c1e-8386-71a1af6acec0@kernel.org>
Date: Mon, 29 Jul 2024 09:10:23 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] f2fs: test for race condition in between atomic_write
 and gc
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Jaegeuk Kim <jaegeuk@kernel.org>, Daeho Jeong <daehojeong@google.com>
References: <20240720074316.3302470-1-chao@kernel.org>
 <20240726154941.lzpunsvd53lnieoz@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240726154941.lzpunsvd53lnieoz@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/7/26 23:49, Zorro Lang wrote:
> On Sat, Jul 20, 2024 at 03:43:16PM +0800, Chao Yu wrote:
>> Test that we will simulate sqlite atomic write logic w/ below steps:
>> 1. create a regular file, and initialize it w/ 0xff data
>> 2. start transaction (via F2FS_IOC_START_ATOMIC_WRITE) on it
>> 3. write transaction data
>> 4. trigger foreground GC to migrate data block of the file
>> 5. commit and end the transaction
>> 6. check consistency of transaction
>> This is a regression test to check handling of race condition in
>> between atomic_write and GC.
>>
>> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
>> Cc: Daeho Jeong <daehojeong@google.com>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>> v2:
>> - add kill&wait in _clean() to avoid umount failure
>> - some cleanups
>> - use exported helpler
>>   tests/f2fs/003     | 65 ++++++++++++++++++++++++++++++++++++++++++++++
>>   tests/f2fs/003.out | 11 ++++++++
>>   2 files changed, 76 insertions(+)
>>   create mode 100755 tests/f2fs/003
>>   create mode 100644 tests/f2fs/003.out
>>
>> diff --git a/tests/f2fs/003 b/tests/f2fs/003
>> new file mode 100755
>> index 00000000..c30e874a
>> --- /dev/null
>> +++ b/tests/f2fs/003
>> @@ -0,0 +1,65 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2024 Oppo.  All Rights Reserved.
>> +#
>> +# FS QA Test No. f2fs/003
>> +#
>> +# Test that we will simulate sqlite atomic write logic w/ below steps:
>> +# 1. create a regular file, and initialize it w/ 0xff data
>> +# 2. start transaction (via F2FS_IOC_START_ATOMIC_WRITE) on it
>> +# 3. write transaction data
>> +# 4. trigger foreground GC to migrate data block of the file
>> +# 5. commit and end the transaction (via F2FS_IOC_COMMIT_ATOMIC_WRITE)
>> +# 6. check consistency of transaction w/ in-memory and on-disk data
>> +# This is a regression test to check handling of race condition in
>> +# between atomic_write and GC.
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto quick
>> +
>> +. ./common/filter
>> +
>> +_cleanup()
>> +{
>> +	kill -9 $atomic_write_pid > /dev/null 2>&1
>> +	wait > /dev/null 2>&1
> 
> This version looks good to me, just this place, we need to keep the default
> _cleanup steps.
> 
>          cd /
>          rm -r -f $tmp.*
> 
> I'll do this change when I merge this patch.
> 
> (And please don't forget to update the _fixed_by_xxxxx information later.)

No problem.

> 
> Reviewed-by: Zorro Lang <zlang@redhat.com>

Thank you for the review. :)

Thanks,

> 
> Thanks,
> Zorro
> 
>> +}
>> +
>> +_require_scratch
>> +_require_xfs_io_command "fpunch"
>> +
>> +_scratch_mkfs >> $seqres.full
>> +_scratch_mount >> $seqres.full
>> +
>> +dbfile=$SCRATCH_MNT/dbfile
>> +foo=$SCRATCH_MNT/foo
>> +bar=$SCRATCH_MNT/bar
>> +
>> +$XFS_IO_PROG -c "pwrite 0 512k -S 0xff" -c "fsync" -f $dbfile >> $seqres.full
>> +$XFS_IO_PROG -c "pwrite 0 2m" -c "fsync" -f $foo >> $seqres.full
>> +sync
>> +
>> +# start atomic_write on dbfile & write data to dbfile
>> +$F2FS_IO_PROG write 1 0 32 zero atomic_commit $dbfile 3000 >> $seqres.full &
>> +atomic_write_pid=$!
>> +
>> +$XFS_IO_PROG -c "fpunch 0 2m" $foo >> $seqres.full
>> +$XFS_IO_PROG -c "pwrite 0 2m" -c "fsync" -f $bar >> $seqres.full
>> +
>> +# persist all dirty data
>> +sync
>> +echo 3 > /proc/sys/vm/drop_caches
>> +
>> +# trigger foreground GC to migrate data block of atomic_file
>> +$F2FS_IO_PROG gc 1 $SCRATCH_MNT > /dev/null 2>&1
>> +
>> +# wait for atomic_write commit completion
>> +sleep 5
>> +# print in-memory data
>> +_hexdump $dbfile
>> +echo 3 > /proc/sys/vm/drop_caches
>> +# print on-disk data
>> +_hexdump $dbfile
>> +
>> +status=0
>> +exit
>> diff --git a/tests/f2fs/003.out b/tests/f2fs/003.out
>> new file mode 100644
>> index 00000000..64698d84
>> --- /dev/null
>> +++ b/tests/f2fs/003.out
>> @@ -0,0 +1,11 @@
>> +QA output created by 003
>> +000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  >................<
>> +*
>> +020000 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  >................<
>> +*
>> +080000
>> +000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  >................<
>> +*
>> +020000 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  >................<
>> +*
>> +080000
>> -- 
>> 2.40.1
>>
> 
