Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078166FCC
	for <fstests@vger.kernel.org>; Wed, 17 Jul 2024 02:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721182509; cv=none; b=Lb2RKn9GIJVkukI8rw+l5/HGqBOpxAGf3UC0IHa1FfwbjVrmUQT1bSBoxgug/FLGx/Aemn5kVNljOrXUH95P8jV1tyMb6a1541A3R2qqgAHZ65CDbek/dSo6T0NMxNbt3Kb/PkNwSjaawszVutWc9EX07ynaDihzBKj1/qD7lA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721182509; c=relaxed/simple;
	bh=JDMdTBK533cE5W5mFyM7mGuboxDe9l/eKUVpOdZrZ7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ElHkrbfC/T96s8RnM5Bi28HvISVcoLH703cLemm7sA+JA09L1UXkWpHg88AHo84ugVOITdbWM1x7O+n+IMEjZUpXXzR2l4YgugjbiKUK3EEBIGOhBgC0iyfK1hj/q0+dF0WO5EU/W8mrUi/S/ymdJBhCb+XlTTlRCMBuF/jgFyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cAPZoRkz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cAPZoRkz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E35CC4AF0B;
	Wed, 17 Jul 2024 02:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721182508;
	bh=JDMdTBK533cE5W5mFyM7mGuboxDe9l/eKUVpOdZrZ7A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cAPZoRkz5bOLp1XOTUkssEeKzvJ67dbBD77aPtCOWcWKcLR+BWat2BMPjlLZ7bsRd
	 etgMGetD7jtxB6RZgCSNi/1xmeKvwOj4JL9OD8Qanw8FwJ1XNQT3kJm6MKD/z4Ujxs
	 GoMliS4L+djKjphL5HZ8k+vQjF1mGEhTbYgmOCGnVCFIGBvNXGVa5E1tX++eSqx/HJ
	 wBpQb0s6L1GZhus285MKVRWcnxcZwyZVaOiJPShvOJXygyLL9jxQBjfKhZZZZtJ6cM
	 gSIzG88hyN045x7uAIaneAYeB9XgDZzLGgAZWitnEaahhcD9P109Fu4Jgf4B4IWUUo
	 fibZREA71/U2w==
Message-ID: <9809963e-1cb5-4884-92b7-6855f2556f46@kernel.org>
Date: Wed, 17 Jul 2024 10:15:04 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: test for race condition in between atomic_write and
 dio
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Jaegeuk Kim <jaegeuk@kernel.org>, Daeho Jeong <daehojeong@google.com>
References: <20240625140233.3907012-1-chao@kernel.org>
 <20240716110342.2jhwp3wn65pvhoyd@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240716110342.2jhwp3wn65pvhoyd@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/7/16 19:03, Zorro Lang wrote:
> On Tue, Jun 25, 2024 at 10:02:33PM +0800, Chao Yu wrote:
>> In this patch, we simulate race case in between sqlite atomic write
>> and direct IO w/ below steps:
>> 1. create a regular file, and initialize it w/ 0xff data
>> 2. start transaction (via F2FS_IOC_START_ATOMIC_WRITE) on it
>> 3. write transaction data
>> 4. trigger direct read/write IO on it to check whether it fails or not
>> 5. commit and end the transaction (via F2FS_IOC_COMMIT_ATOMIC_WRITE)
>> This is a regression test to check handling of race condition in
>> between atomic_write and direct IO.
>>
>> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
>> Cc: Daeho Jeong <daehojeong@google.com>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>   tests/f2fs/004     | 45 +++++++++++++++++++++++++++++++++++++++++++++
>>   tests/f2fs/004.out |  3 +++
>>   2 files changed, 48 insertions(+)
>>   create mode 100755 tests/f2fs/004
>>   create mode 100644 tests/f2fs/004.out
>>
>> diff --git a/tests/f2fs/004 b/tests/f2fs/004
>> new file mode 100755
>> index 00000000..26862cb5
>> --- /dev/null
>> +++ b/tests/f2fs/004
>> @@ -0,0 +1,45 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2024 Oppo.  All Rights Reserved.
>> +#
>> +# FS QA Test No. f2fs/004
>> +#
>> +# Test that we will simulate race case in between sqlite atomic write
>> +# and direct IO w/ below steps:
>> +# 1. create a regular file, and initialize it w/ 0xff data
>> +# 2. start transaction (via F2FS_IOC_START_ATOMIC_WRITE) on it
>> +# 3. write transaction data
>> +# 4. trigger direct read/write IO to check whether it fails or not
>> +# 5. commit and end the transaction (via F2FS_IOC_COMMIT_ATOMIC_WRITE)
>> +# This is a regression test to check handling of race condition in
>> +# between atomic_write and direct IO.
> 
> Same as last patch, please add _fixed_by_kernel_commit.
> 
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto quick
>> +
>> +. ./common/filter
>> +
>> +_supported_fs f2fs
>     ^^^^^
> It's not needed
> 
>> +_require_scratch
>> +_require_xfs_io_command "pwrite"
>     ^^^^
> It can be removed too I think.
> 
>> +
>> +_scratch_mkfs >> $seqres.full
>> +_scratch_mount >> $seqres.full
>> +
>> +dbfile=$SCRATCH_MNT/dbfile
>> +
>> +# start atomic_write on dbfile & write data to dbfile
>> +touch $dbfile
>> +$F2FS_IO_PROG write 1 0 32 zero atomic_commit $dbfile 3000 >> $seqres.full &
> 
> There's a backgroup process too. Better to make sure it's done "kill && wait"
> before the end of the test.
> 
>> +
>> +# simulate concurrent direct read/write IO
>> +$XFS_IO_PROG -d -c "pread 0 128k" $dbfile
>> +$XFS_IO_PROG -d -c "pwrite 0 128k" $dbfile
> 
> Do you need _require_odirect (not sure about that:).
> 
>> +
>> +# wait for atomic_write commit completion
>> +sleep 5
>> +
>> +_scratch_unmount
>     ^^^^
> It's not necessary.

Zorro, thanks for the comments, will update.

Thanks,

> 
> Thanks,
> Zorro
> 
>> +
>> +status=0
>> +exit
>> diff --git a/tests/f2fs/004.out b/tests/f2fs/004.out
>> new file mode 100644
>> index 00000000..3af79541
>> --- /dev/null
>> +++ b/tests/f2fs/004.out
>> @@ -0,0 +1,3 @@
>> +QA output created by 004
>> +pread: Operation not supported
>> +pwrite: Operation not supported
>> -- 
>> 2.40.1
>>
>>
> 
