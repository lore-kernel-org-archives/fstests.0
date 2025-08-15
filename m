Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243561B423C
	for <fstests@vger.kernel.org>; Fri, 15 Aug 2025 07:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755242670; cv=none; b=Db05J1qa+cUkezrwrHIrY+i47PgpLiIyab4o9W/zC6hhgTIa1iMLfZz9+4baPscWn8b9T4alAvw7vpxQw6YRdEqhH3H3k3zseTDCcgR/uNL18NTNCtWGRL3QJ0RZg7mHlAlvz9hQt8DPqVJ7AUVkMumejmtHhsbjg8qKpAs0w2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755242670; c=relaxed/simple;
	bh=FmbOj40jrFapiXTbimXsVNU3tIo0ZnAjE9hXb0fbSSY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hJtGfge4qlhohM7+h71ow2hsgH469lLWr+qC41i1c9nkiQVOl7ZkITqebQ7BH+7g9PuMCfS/d7XtAHeaS60Y1nGXEMpbbUN4/mqwdNC7gk63htx474sKmQ20TTF/lD3rvkP+izULQ0gQcsfVE7Edo+a00UO6/fv76kUsZyCDZbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CwKGYmhc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CwKGYmhc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 163A2C4CEEB;
	Fri, 15 Aug 2025 07:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755242669;
	bh=FmbOj40jrFapiXTbimXsVNU3tIo0ZnAjE9hXb0fbSSY=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=CwKGYmhcQRPT0NxEnmjEn2J+Qo/RXbH586M3R++R0bA34MwBPdruyV3dyzaV22bca
	 DYuGcy61loKr0XovQMs5btNuhl2XC/F5WGP2MSYECeDcn2tUkpr4J+12Gr3M676HZG
	 dFXwTxX4Gagnz6F3oze+7/MClLThhnmlvcYSEBYtfZYsxK2xfTKSXd03QJ/Dl6OyCS
	 PrDm6/Bb5QVrX1Yr4m3yKm8FPGlbVHmN12X8JYSvjUfuOWXpxjld3kdvQN/5aKSLCH
	 BwM8tgWcg5Wu84v5gj4ccFwvaG/woW/Q8/gFgfIYiKAdohk3yiAPRAbusDMDLyQQFN
	 ZA1NgMNbAYxuw==
Message-ID: <fd2ecc04-5958-49e4-8c01-a30420a204a5@kernel.org>
Date: Fri, 15 Aug 2025 15:24:26 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
 jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v2 1/3] f2fs/018: check data eof after partial truncation
 on compressed cluster
To: Zorro Lang <zlang@redhat.com>
References: <20250814090712.2119455-1-chao@kernel.org>
 <20250814205334.obe6tmyhphngntdv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250814205334.obe6tmyhphngntdv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/15/25 04:53, Zorro Lang wrote:
> On Thu, Aug 14, 2025 at 05:07:10PM +0800, Chao Yu wrote:
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
>> v2:
>> - add missing _require_xfs_io_command "truncate"
>> - add missing _require_fio $fio_config
>> - use $XFS_IO_PROG instead of xfs_io
>> - avoid mkfs&mount .. umount for each round test
>>  tests/f2fs/018     | 77 ++++++++++++++++++++++++++++++++++++++++++++++
>>  tests/f2fs/018.out |  2 ++
>>  2 files changed, 79 insertions(+)
>>  create mode 100755 tests/f2fs/018
>>  create mode 100644 tests/f2fs/018.out
>>
>> diff --git a/tests/f2fs/018 b/tests/f2fs/018
>> new file mode 100755
>> index 00000000..e1047f78
>> --- /dev/null
>> +++ b/tests/f2fs/018
>> @@ -0,0 +1,77 @@
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
>> +_require_xfs_io_command "truncate"
>> +_require_scratch
>> +
>> +testfile=$SCRATCH_MNT/testfile
>> +fio_config=$tmp.fio
>> +
>> +cat >$fio_config <<EOF
>> +[global]

I updated task name from global to verify-data to avoid
"No job(s) defined" error from fio.

>> +filename=$testfile
>> +rw=read
>> +verify=pattern
>> +verify_pattern=0x00
>> +do_verify=1
>> +verify_only
>> +offset=0
>> +size=4k
>> +numjobs=1
>> +EOF
>> +_require_fio $fio_config
> 
> Hmm... that looks strange if you create fio config file but don't use it later :-D
> 
> How about:
> 
> build_fio_config()
> {
> 	local offset=$1
> 	local size=$2
> 
> 	cat >$fio_config <<EOF
> [global]
> filename=$testfile
> rw=read
> verify=pattern
> verify_pattern=0x00
> do_verify=1
> verify_only
> offset=$offset
> size=$size
> numjobs=1
> EOF

cat $fio_config >> $seqres.full

To record fio config in seqres.full

> }
> 
> build_fio_config 0 4k
> _require_fio $fio_config

Add _cleanup() to remove $testfile created in last testcase.

> 
>> +
>> +_scratch_mkfs "-O extra_attr,compression" >> $seqres.full || _fail "mkfs failed"
>> +_scratch_mount "-o compress_extension=*" >> $seqres.full
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
>> +
> 
> rm -f $testfile
> 
>> +	$XFS_IO_PROG -f -c "pwrite 0 $filesize" -c "fsync" $testfile >> $seqres.full
>> +	$XFS_IO_PROG -c "truncate $offset1" $testfile
>> +	$XFS_IO_PROG -c "truncate $offset2" $testfile
>> +
>> +	if [ "$offset3" ]; then
>> +		xfs_io -c "truncate $offset3" $testfile
>                 ^^^^^^
>        $XFS_IO_PROG
> 
>> +	fi
>> +
>> +	$FIO_PROG --name=verify-data --filename=$testfile --rw=read --verify=pattern \
>> +		--verify_pattern=0x00 --do_verify=1 --verify_only --offset=$eof_start \
>> +		--size=$eof_size >> $seqres.full 2>&1 || _fail "eof data is not zero"
> 
> build_fio_config $eof_start $eof_size
> $FIO_PROG $fio_config >> $seqres.full 2>&1
> 
>> +
>> +	rm -f $testfile
> 
> Move this line to above, then
> 
> return $?
> 
>> +}
>> +
>> +check_data_eof 12k 4k 16k 12k 20k
>> +check_data_eof 10k 6k 16k 10k 20k
>> +check_data_eof 12k 4k 16k 8k 12k 20k
>> +check_data_eof 10k 6k 16k 8k 10k 20k
> 
> run_check check_data_eof 12k 4k 16k 12k 20k
> run_check check_data_eof 10k 6k 16k 10k 20k
> run_check check_data_eof 12k 4k 16k 8k 12k 20k
> run_check check_data_eof 10k 6k 16k 8k 10k 20k
> 
> This can help you to know which line fails if one of them is failed. Or you
> always get "eof data is not zero", no matter which line fails :)

Looks nice!

> 
>> +
>> +_scratch_unmount
> 
> This unmount looks useless, due to SCRATCH_DEV is always unmounted after a test done.

Thanks for all your suggestion, will update v3.

Thanks,

> 
> Thanks,
> Zorro
> 
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

