Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396B427453
	for <fstests@vger.kernel.org>; Sat, 16 Aug 2025 07:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755328174; cv=none; b=FktdulvJr+ZtqmOhwTXZK0TJWWbmLSSYrONuj6kRIZyFQIlizGuR46uDCNZi47T/PvaqXuEfKpsbjo0XsMk2wFlNBe5LVafL7mqOtfxobYrd6bWX16ciNiarOOSnZyEKQAwClmBQ2T8ERwdMTv3mEyyuIDokUpNNGk4zMzzVaus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755328174; c=relaxed/simple;
	bh=lJ6wXxR2A+ClkwJB51oyVnDf1WJTdsz/gHtRcw3vA9Y=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Uvdwsqm+qJYmJUoDdlFEEFaI0kG/EbHLqCl5NC6CGTG5U+y88McGWs4TE/nU49z6B7jFqXXKD3khrjiOd62y/vd3a7Q/tBb/oglSmwm+XkfuqSXWdN4q6zfzCA55GPMwAzID65PVDtA5ePRYcMSKOAGbe+Q/T9RUDmgWl9t1i+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULJC82Dl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULJC82Dl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 469AEC4CEEF;
	Sat, 16 Aug 2025 07:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755328173;
	bh=lJ6wXxR2A+ClkwJB51oyVnDf1WJTdsz/gHtRcw3vA9Y=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=ULJC82DlPmfbv5OgrKXCie3HV2HxI2xlMxGwxBvZ09YDtMhiRrcPJC9SBefCzEzfQ
	 2lTTv49WXWegYlHZBGi08yWTacoQTCsSV/av653rtVEe5GNs8p+q71N9WE7u8sstrO
	 ds59JKzyoqTC4+H08hQFVSntTP5p2PJfJig5U/15BvhkuyAyzfeYuhBB6qE6f723K0
	 A9siD+8hCr2PIiI5elSag1cXGj3ultghSAcf1iWzDF5Np6gnw0PfIfyJpWlS143Rq4
	 nc5XTKuFXvRcTjx+7mDfyRtRX9M+CS9SCSb7s7cTqJDv1fDb0j3wbK59qFvlF0NDzi
	 DxZFtwmucS+AQ==
Message-ID: <5e82abea-1dab-4a0c-bb9b-e1ac4eb4544f@kernel.org>
Date: Sat, 16 Aug 2025 15:09:29 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
 jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v3 1/3] f2fs/018: check data eof after partial truncation
 on compressed cluster
To: Zorro Lang <zlang@redhat.com>
References: <20250815081405.2523015-1-chao@kernel.org>
 <20250815153127.aqjzltcxsdktar23@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250815153127.aqjzltcxsdktar23@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/8/15 23:31, Zorro Lang wrote:
> On Fri, Aug 15, 2025 at 04:14:03PM +0800, Chao Yu wrote:
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
>> v3:
>> - introduce build_fio_config() for cleanup
>> - use run_check() to check return value of check_data_eof()
>> - add _cleanup
>> - use $XFS_IO_PROG instead of xfs_io
>>   tests/f2fs/018     | 89 ++++++++++++++++++++++++++++++++++++++++++++++
>>   tests/f2fs/018.out |  2 ++
>>   2 files changed, 91 insertions(+)
>>   create mode 100755 tests/f2fs/018
>>   create mode 100644 tests/f2fs/018.out
>>
>> diff --git a/tests/f2fs/018 b/tests/f2fs/018
>> new file mode 100755
>> index 00000000..8013042d
>> --- /dev/null
>> +++ b/tests/f2fs/018
>> @@ -0,0 +1,89 @@
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
>> +build_fio_config()
>> +{
>> +	local offset=$1
>> +	local size=$2
>> +
>> +	cat >$fio_config <<EOF
>> +[verify-data]
>> +filename=$testfile
>> +rw=read
>> +verify=pattern
>> +verify_pattern=0x00
>> +do_verify=1
>> +verify_only
>> +offset=$offset
>> +size=$size
>> +numjobs=1
>> +EOF
>> +	cat $fio_config >> $seqres.full
>> +}
>> +
>> +build_fio_config 0 4k
>> +_require_fio $fio_config
>> +
>> +_cleanup()
>> +{
>> +       rm -f $testfile
>> +}
> 
> This _cleanup isn't necessary, the $testfile is on SCRATCH_DEV, we don't
> need to cleanup SCRATCH_DEV manually.
> 
> Others look good to me, I can help to remove above _cleanup function when
> I merge this patchset, if other 2 patches are good to merge too :)

Fine to me. :)

> 
> Reviewed-by: Zorro Lang <zlang@redhat.com>

Thanks a lot for all your review and suggestion.

Thanks,

> 
> Thanks,
> Zorro
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
>> +	rm -f $testfile
>> +
>> +	$XFS_IO_PROG -f -c "pwrite 0 $filesize" -c "fsync" $testfile >> $seqres.full
>> +	$XFS_IO_PROG -c "truncate $offset1" $testfile
>> +	$XFS_IO_PROG -c "truncate $offset2" $testfile
>> +
>> +	if [ "$offset3" ]; then
>> +		$XFS_IO_PROG -c "truncate $offset3" $testfile
>> +	fi
>> +
>> +	build_fio_config $eof_start $eof_size
>> +	$FIO_PROG $fio_config >> $seqres.full 2>&1
>> +
>> +	return $?
>> +}
>> +
>> +run_check check_data_eof 12k 4k 16k 12k 20k
>> +run_check check_data_eof 10k 6k 16k 10k 20k
>> +run_check check_data_eof 12k 4k 16k 8k 12k 20k
>> +run_check check_data_eof 10k 6k 16k 8k 10k 20k
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

