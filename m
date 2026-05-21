Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029243438A2
	for <fstests@vger.kernel.org>; Thu, 21 May 2026 00:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779323178; cv=none; b=tyxo69sXgHz0+HDNAYRJg5uTCf48Wz69wQ7DhRSh9ylAzRMvHnF1WYMw/Tc0doJm/+h36c/seg0WRyv/mWMzdi/2C2Fh0e3WEnaA1neZr0Od6U52Yr7fc6L3WH2pcy6A2RIzsnSMLT/PNX1nRx+tgDOtL+S4VrTEx5dmCBdam+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779323178; c=relaxed/simple;
	bh=IeYsMcfBJj6+1NyQSz5P5ZxwS/25moLbQ8UEorDL0Wo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=F2VWOOjM6xNKc2YRTs0fe/NHipK+z5uesoIvvRDoBLmpYVlLUczA8iE+cIaTxc6f40VCJQKwKQ8qMKb7YCp8MPw0750ruupdp93fwMJOAlUvpTAh4FfZungL3ckRUgkOpjHxxQJucuP/45DcSRFasi8T4BZ1In50RWO2YMr73po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWe+Q7av; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWe+Q7av"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4983E1F000E9;
	Thu, 21 May 2026 00:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779323175;
	bh=Qk6vc+HDG6D8dvUIDmq4mkBfCVo0cShiIRU/MQzSCrc=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To;
	b=LWe+Q7av5x1o10cQEi4hpGQ+gzoWR68jq+IUsintOO0XBr/i2DvDqMU1U2+awfKUl
	 OBzhOWBv7k65hdFKZ8GIrzjkqWf52P7228BA2XKYrmR8/w6aWDqPboWnvOKwkIFgEh
	 ik0KM6+NJlRo4enHdOHg+O1WdKDLBt1SqETf7USdR1wIrqq/uSOCXU4yUKm6PrY8uw
	 KDwF06CQ5tkbW0gYB44oKv9pfe5YtS5uI6t/DvrcfiZDJyqBytBm6xev3NNl6py9GK
	 VOaQLIfAdnICE+gbjnyugF77Y9HstimEiZGhr6xSMVqyjEoI33hpqR3a1ki8fQsXII
	 l8LnIRRllNf1g==
Message-ID: <76060445-9b71-486b-bfac-9cc8b439d166@kernel.org>
Date: Thu, 21 May 2026 00:26:12 +0000
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org
Subject: Re: [PATCH] f2fs/025: test to do sanity check section type correctly
 in f2fs GC
To: fstests@vger.kernel.org, jaegeuk@kernel.org, jprusakowski@google.com,
 joannechien@google.com, linux-f2fs-devel@lists.sourceforge.net
References: <20260518101252.445214-1-chao@kernel.org>
 <ag2Rh-4_Tp082XXx@zlang-mailbox>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <ag2Rh-4_Tp082XXx@zlang-mailbox>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/20/26 12:28, Zorro Lang wrote:
> On Mon, May 18, 2026 at 06:12:52PM +0800, Chao Yu wrote:
>> Without commit 520760b9f915 ("f2fs: optimize representative type determination
>> in GC"), f2fs GC will report inconsistent segment type in large section issue,
>> and then it will force to shutdown filesystem.
>>
>> [  768.190903] F2FS-fs (loop51): Inconsistent segment (3) type [1, 0] in SIT and SSA
>>
>> The reason is f2fs kernel will assume all segment type inside large section is
>> the same, during GC it loads type from one segment and compare it to other
>> segments' type, however due to recovery flow, the chosen segment may has zero
>> valid blocks w/ different segment type, since the segment is invalid(free) one,
>> it will never be migrated, so that we should not treat such state as abnormal
>> condition.
>>
>> This testcase is created to simulate above condition to see whether f2fs kernel
>> module can handle it correctly
>>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>   tests/f2fs/025     | 88 ++++++++++++++++++++++++++++++++++++++++++++++
>>   tests/f2fs/025.out |  2 ++
>>   2 files changed, 90 insertions(+)
>>   create mode 100644 tests/f2fs/025
>>   create mode 100644 tests/f2fs/025.out
>>
>> diff --git a/tests/f2fs/025 b/tests/f2fs/025
>> new file mode 100644
>> index 00000000..1eba7158
>> --- /dev/null
>> +++ b/tests/f2fs/025
>> @@ -0,0 +1,88 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2026 Chao Yu <chao@kernel.org>
>> +#
>> +# FS QA Test No. f2fs/025
>> +#
>> +# Check whether f2fs will encounter cp_error (Inconsistent segment type)
>> +# when doing sanity check on type of segments inside large section during
>> +# garbage collection.
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto quick
>> +
>> +_fixed_by_kernel_commit 520760b9f915 \
>> +	"f2fs: optimize representative type determination in GC"
>> +
>> +. ./common/filter
>> +
>> +_cleanup()
>> +{
>> +	cd /
>> +	rm -r -f $tmp.*
>> +}
>> +
>> +_require_scratch
>> +_require_xfs_io_command "pwrite"
>> +_require_xfs_io_command "truncate"
>> +_require_command "$F2FS_IO_PROG" f2fs_io
>> +_require_check_dmesg
>> +
>> +# Format with 96MB size and 2 segments per section
>> +_scratch_mkfs_sized $((96 * 1024 * 1024)) "" "-s 2" >> $seqres.full 2>&1
>> +
>> +# Mount with mode=lfs
>> +_scratch_mount -o mode=lfs >> $seqres.full 2>&1
>> +
>> +# Create files to fill whole filesystem, then segment type will be changed to node type
>> +for ((i=0;i<5120;i++)) do
>> +	touch $SCRATCH_MNT/$i >> $seqres.full 2>&1
> 
> 5120 * 4k = 20MB
> 
>> +done
>> +sync
>> +
>> +# Remove all files to create free(empty) node segments
>> +rm -f $SCRATCH_MNT/*
>> +sync
>> +
>> +# Allocate free space so that we have chance to reuse free(empty) node segments
>> +$XFS_IO_PROG -f -c "pwrite -b 4k 0 1928k" $SCRATCH_MNT/file >> $seqres.full 2>&1
>> +sync
>> +
>> +$XFS_IO_PROG -c "truncate 0" $SCRATCH_MNT/file >> $seqres.full 2>&1
>> +$XFS_IO_PROG -d -c "pwrite -b 4k 0 16M" $SCRATCH_MNT/file >> $seqres.full 2>&1
>> +$XFS_IO_PROG -c "truncate 0" $SCRATCH_MNT/file >> $seqres.full 2>&1
>> +$XFS_IO_PROG -d -c "pwrite -b 4k 0 16M" $SCRATCH_MNT/file >> $seqres.full 2>&1
>> +$XFS_IO_PROG -c "truncate 0" $SCRATCH_MNT/file >> $seqres.full 2>&1
>> +sync
>> +
>> +$XFS_IO_PROG -d -c "pwrite -b 4k 0 8M" $SCRATCH_MNT/file >> $seqres.full 2>&1
>> +$XFS_IO_PROG -c "truncate 0" $SCRATCH_MNT/file >> $seqres.full 2>&1
>> +$XFS_IO_PROG -d -c "pwrite -b 4k 0 32K" $SCRATCH_MNT/file >> $seqres.full 2>&1
>> +$XFS_IO_PROG -c "truncate 0" $SCRATCH_MNT/file >> $seqres.full 2>&1
> 
> 1928k + 16M + 16M + 8M + 32K ~= 40M
> 
>> +$XFS_IO_PROG -d -c "pwrite -b 4k 0 2M" -c "fsync" $SCRATCH_MNT/file >> $seqres.full 2>&1
> 
> 96M - 40M - 20M = 36M
> 
> I'm not a f2fs expert, I think you hope to (almost) fill the fs before this 2M
> pwrite step. If so, I'm wondering can we ensure that other metadata takes ~36 MB

Zorro, thanks for the review.

Actually, we don't need to write metadata to other ~36 MB space, because node log
and data log are start from different area of block addresses, more details as below:

warm_node type log starts from beginning of block addresses
https://git.kernel.org/pub/scm/linux/kernel/git/chao/f2fs-tools.git/tree/mkfs/f2fs_format.c#n662

warm_data type log starts from middle of block addresses
https://git.kernel.org/pub/scm/linux/kernel/git/chao/f2fs-tools.git/tree/mkfs/f2fs_format.c#n668

With lfs mode, warm_data log can allocate forward until to the end of block addresses,
and then start from beginning of block addresss, then we can expect it reuse the
area which were used by node log.

> of space, thereby guaranteeing that this 2 MB write triggers the reuse of that
> 1928 KB segment (no matter with any MKFS_OPTIONS)?

Oh, I may miss to consider MKFS_OPTIONS and MOUNT_OPTIONS, what do you think of
clearing both MKFS_OPTIONS and MOUNT_OPTIONS before the test?

Thanks,

> 
> Thanks,
> Zorro
> 
>> +
>> +# Shutdown the filesystem without checkpoint
>> +$F2FS_IO_PROG shutdown 2 $SCRATCH_MNT >> $seqres.full 2>&1
>> +
>> +_scratch_unmount >> $seqres.full 2>&1
>> +
>> +_scratch_mount -o mode=lfs >> $seqres.full 2>&1
>> +
>> +# Run urgent_gc mode to trigger garbage collection
>> +dev_name=$(_short_dev $SCRATCH_DEV)
>> +if [ -f /sys/fs/f2fs/$dev_name/gc_urgent ]; then
>> +	echo 1 > /sys/fs/f2fs/$dev_name/gc_urgent
>> +fi
>> +
>> +# Wait background GC thread to wake up to run and potentially encounter the inconsistency
>> +sleep 5
>> +
>> +_scratch_unmount >> $seqres.full 2>&1
>> +
>> +# Check whether the dmesg has the warning indicating the bug
>> +_check_dmesg_for "F2FS-fs \($dev_name\): Inconsistent segment" && \
>> +	_fail "F2FS-fs ($dev_name): Inconsistent segment type detected in dmesg!"
>> +
>> +echo "Silence is golden"
>> +status=0
>> +exit
>> diff --git a/tests/f2fs/025.out b/tests/f2fs/025.out
>> new file mode 100644
>> index 00000000..3d70951e
>> --- /dev/null
>> +++ b/tests/f2fs/025.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 025
>> +Silence is golden
>> -- 
>> 2.49.0
>>

