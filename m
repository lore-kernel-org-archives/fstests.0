Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E255F17F7
	for <fstests@vger.kernel.org>; Wed, 23 Oct 2024 02:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729651996; cv=none; b=GCCzYXj10IOrrhzcUUFicdGaVaWBdkMA+uUMYtnLrMMfqP3KRn0/4ph1VI70wIaEBsTn7t1LgrDKDWBMr60A8x6tRwqJhabXmI3DvWsr1f+hqqekpRVmopyjmFWYRllCCpcf/oXUJA48pnN4KEsAjN/Mj9gvDigi99W2I8eVNc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729651996; c=relaxed/simple;
	bh=0uALj+LtjFdyxQq3mZakuCYvPJpyFjWdRt3V7YbhCr0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fBABQPlQKuqFZTx2KZCflflT3SUXDUdUejTnHYwcs/pjyfVjq2I3Nk/OYE22c/AJVOF9GT4EkXuqBvxbtwzBeB/0BMMCV6PirSq8iNIkDHagpgV33IEM07d14/QhMHOMZAzZk7/CqjgiQC3HF6YevOih4/oCPJso1f323wNMN9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MecLJqyu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MecLJqyu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C319BC4CEC3;
	Wed, 23 Oct 2024 02:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729651995;
	bh=0uALj+LtjFdyxQq3mZakuCYvPJpyFjWdRt3V7YbhCr0=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=MecLJqyueMa98z6SQqSEkFFuaZp7pEatewka1pBaGt79qG9+kFL0NigUjeELEPxZk
	 Kim2MDPzY6M9Z5H3m+KhVRNmxdUNTaw8JyT2sH/S2EIEC0b2ZwqZVbqu9DzZDqq4x6
	 kA36A8vqDyUmYgk9zcXW+Qm0BEeFg/3Y57EmGxxb3tzcrDAajQXUpUOYNNDScXpwT7
	 +x4IpBeEuGeR9RM6hpx5BdUWlJTHGVUCJJxcBhgCU8NXFV/D9aZEXJqH5Cl+eb4WLo
	 tL3T+5WiwQ7Nsc1ggWMu7Ojan5ADmzJtll+FdQzvPvlDKaPULdRZkr0anq/QZhAJfX
	 Ncd0fTcxW4xyg==
Message-ID: <6ffdf1df-e4a3-4799-81d4-22f206beb720@kernel.org>
Date: Wed, 23 Oct 2024 10:53:09 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, fstests@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 1/2] f2fs/006: add testcase to check out-of-space case
To: Zorro Lang <zlang@redhat.com>
References: <20241015025106.3203676-1-chao@kernel.org>
 <20241023023744.nvnuavzus26gjdj5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20241023023744.nvnuavzus26gjdj5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/23 10:37, Zorro Lang wrote:
> On Tue, Oct 15, 2024 at 10:51:05AM +0800, Chao Yu wrote:
>> This is a regression test to check whether f2fs handles dirty
>> data correctly when checkpoint is disabled, if lfs mode is on,
>> it will trigger OPU for all overwritten data, this will cost
>> free segments, so f2fs must account overwritten data as OPU
>> data when calculating free space, otherwise, it may run out
>> of free segments in f2fs' allocation function, resulting in
>> panic.
>>
>> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>   tests/f2fs/006     | 52 ++++++++++++++++++++++++++++++++++++++++++++++
>>   tests/f2fs/006.out |  6 ++++++
>>   2 files changed, 58 insertions(+)
>>   create mode 100755 tests/f2fs/006
>>   create mode 100644 tests/f2fs/006.out
>>
>> diff --git a/tests/f2fs/006 b/tests/f2fs/006
>> new file mode 100755
>> index 00000000..b359ef8f
>> --- /dev/null
>> +++ b/tests/f2fs/006
>> @@ -0,0 +1,52 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2024 Oppo.  All Rights Reserved.
>> +#
>> +# FS QA Test No. f2fs/006
>> +#
>> +# This is a regression test to check whether f2fs handles dirty
>> +# data correctly when checkpoint is disabled, if lfs mode is on,
>> +# it will trigger OPU for all overwritten data, this will cost
>> +# free segments, so f2fs must account overwritten data as OPU
>> +# data when calculating free space, otherwise, it may run out
>> +# of free segments in f2fs' allocation function, resulting in
>> +# panic.
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto quick
>> +
>> +_cleanup()
>> +{
>> +	rm -f $img
>> +	_scratch_unmount >> $seqres.full
>> +	cd /
>> +	rm -r -f $tmp.*
>> +}
>> +
>> +_require_scratch
>> +_scratch_mkfs >> $seqres.full
>> +_scratch_mount >> $seqres.full
>> +
>> +img=$SCRATCH_MNT/f2fs.img
>> +mnt=$SCRATCH_MNT/f2fs.mnt
>> +testfile=$mnt/testfile
>> +
>> +mkdir $mnt
>> +dd if=/dev/zero of=$img bs=1M count=100 2>/dev/null
>> +$MKFS_F2FS_PROG -f $img >/dev/null 2>&1
>> +sync
>> +
>> +# use mode=lfs to let f2fs always triggers OPU
>> +mount -t $FSTYP -o loop,mode=lfs,checkpoint=disable:10%,noinline_dentry $img $mnt
> 
> Hi Chao,
> 
> Is the loop device necessary? What if use SCRATCH_DEV and SCRATCH_MNT directly?

Hi Zorro,

It uses loop device to limit image size, so that we can speed
up padding steps of the test since it depends on ENOSPC state.

Or maybe we can mkfs.f2fs $SCRATCH_DEV w/ specified sector size?
Any suggestion?

Thanks,

> 
> Thanks,
> Zorro
> 
>> +
>> +dd if=/dev/zero of=$testfile bs=1M count=50 2>/dev/null
>> +
>> +# it may run out of free space of f2fs and hang kernel
>> +dd if=/dev/zero of=$testfile bs=1M count=50 conv=notrunc conv=fsync
>> +dd if=/dev/zero of=$testfile bs=1M count=50 conv=notrunc conv=fsync
>> +
>> +mount -o remount,checkpoint=enable $mnt
>> +umount $mnt
>> +
>> +status=0
>> +exit
>> diff --git a/tests/f2fs/006.out b/tests/f2fs/006.out
>> new file mode 100644
>> index 00000000..a2c7ba48
>> --- /dev/null
>> +++ b/tests/f2fs/006.out
>> @@ -0,0 +1,6 @@
>> +QA output created by 006
>> +50+0 records in
>> +50+0 records out
>> +dd: error writing '/mnt/scratch_f2fs/f2fs.mnt/testfile': No space left on device
>> +3+0 records in
>> +2+0 records out
>> -- 
>> 2.40.1
>>
> 

