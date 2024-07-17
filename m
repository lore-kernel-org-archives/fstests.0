Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7926E4685
	for <fstests@vger.kernel.org>; Wed, 17 Jul 2024 02:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721182341; cv=none; b=si8POPRZMznXrilpvcU1Hvjp66dbtPaQ4OtPIZBSxNXBtYSaj9VwB/GydVOohvt/3hSjUp2MfL+38dSGODBPsoOAbAyL5navIvO3xi0HA2da2bRFCEOHwKSlT7JSfcDcoY59+sOH2wZyKz5hPFq3tP9724HA5Avo6cPSeyG+U2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721182341; c=relaxed/simple;
	bh=r18DYM9L0j/fdMY2uog1UdcMmZiz6cjxEKC8Pnyj0xI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XmMU+s8ZSjiZvEYrMLZXxChnkecmW9xV+v0z3kPhB/YrhHh/dSZv6yWEZyIGnV+55IL6OHAuI2pExFJSJYxLzrXqJV+O6fidZKxovBAi535x83fIWQFZYDMFBDDFrCYulzc0ruUQVDrUeOe/o7yCkhAnmphaCOG96FK/bi2OfRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UbHbIYx2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UbHbIYx2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5826C116B1;
	Wed, 17 Jul 2024 02:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721182341;
	bh=r18DYM9L0j/fdMY2uog1UdcMmZiz6cjxEKC8Pnyj0xI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UbHbIYx2l0scUaNJxuzM21ymvFnJp1ApE7FNyOtDWhdz214AyCv0eBIFroP7SufHQ
	 TqmxFNGmoN0Bsc6jDf2QbDoqYXXExmXnYtNWqID+m7y92O01kweFSiqlu2+y2dd3aF
	 y70RC29GBhprgKANYu4tm6z0yn8SPw3L871nib57UlYh+C1gcquA5k9is+5gtpVjS5
	 yOBQ/HVIpHQIYIv0cUQhIHbKbl1HdIeiBEE7mu41XOMhoYn7oL4AogRWL5J+0BbqwG
	 X4FPWhGik9CWxUFCWWwDaUxQ1q7zPopkhRja1VbMmlk70Ge/q2eOhEyydHW8GEdvfg
	 SJTls0cluoNiw==
Message-ID: <fba75c06-b0d9-4e92-b673-9c11314744c1@kernel.org>
Date: Wed, 17 Jul 2024 10:12:16 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: test for race condition in between atomic_write and
 gc
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Daeho Jeong <daehojeong@google.com>
References: <20240625030416.3553498-1-chao@kernel.org>
 <20240716105710.v76icnjhqmvjmgsd@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240716105710.v76icnjhqmvjmgsd@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/7/16 18:57, Zorro Lang wrote:
> On Tue, Jun 25, 2024 at 11:04:16AM +0800, Chao Yu wrote:
>> Test that we will simulate sqlite atomic write logic w/ below steps:
>> 1. create a regular file, and initialize it w/ 0xff data
>> 2. start transaction (via F2FS_IOC_START_ATOMIC_WRITE) on it
>> 3. write transaction data
>> 4. trigger foreground GC to migrate data block of the file
>> 5. commit and end the transaction (via F2FS_IOC_COMMIT_ATOMIC_WRITE)
>> 6. check consistency of transaction w/ in-memory and on-disk data
>> This is a regression test to check handling of race condition in
>> between atomic_write and GC.
> 
> Hi Chao,
> 
> Sorry for the late reviewing. As this's a regression test, so which onne
> kernel commit fix this known issue, please specify it by:
> 
> _fixed_by_kernel_commit $commit_id $commit_subject

Hi Zorro,

Since the fixed patch has not been merged yet, so what about adding this line
after merging the fix?

> 
>>
>> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
>> Cc: Daeho Jeong <daehojeong@google.com>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>   tests/f2fs/003     | 61 ++++++++++++++++++++++++++++++++++++++++++++++
>>   tests/f2fs/003.out | 11 +++++++++
>>   2 files changed, 72 insertions(+)
>>   create mode 100755 tests/f2fs/003
>>   create mode 100644 tests/f2fs/003.out
>>
>> diff --git a/tests/f2fs/003 b/tests/f2fs/003
>> new file mode 100755
>> index 00000000..d8311c4c
>> --- /dev/null
>> +++ b/tests/f2fs/003
>> @@ -0,0 +1,61 @@
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
>> +_supported_fs f2fs
>      ^^^^^
> This line is not necessary now.
> 
>> +_require_scratch
>> +_require_xfs_io_command "pwrite"
> 
> pwrite is a basic command of xfs_io, so I think this line is not necessary.
> 
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
> 
> As there's a background process, shouldn't we do kill and wait in _cleanup
> to make sure unmount won't hit EBUSY?
> 
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
>> +od -x $dbfile
>> +echo 3 > /proc/sys/vm/drop_caches
>> +# print on-disk data
>> +od -x $dbfile
> 
> There's a common helper named "_hexdump" in common/rc, can that be used?
> 
>> +
>> +_scratch_unmount
> 
> The SCRATCH_DEV will be unmounted at the end of the test, don't need to
> do this manually if it's not a necessary test step.

Let me update this patch according to your comments, thanks.

Thanks,

> 
> Thanks,
> Zorro
> 
>> +
>> +status=0
>> +exit
>> diff --git a/tests/f2fs/003.out b/tests/f2fs/003.out
>> new file mode 100644
>> index 00000000..d6c8a637
>> --- /dev/null
>> +++ b/tests/f2fs/003.out
>> @@ -0,0 +1,11 @@
>> +QA output created by 003
>> +0000000 0000 0000 0000 0000 0000 0000 0000 0000
>> +*
>> +0400000 ffff ffff ffff ffff ffff ffff ffff ffff
>> +*
>> +2000000
>> +0000000 0000 0000 0000 0000 0000 0000 0000 0000
>> +*
>> +0400000 ffff ffff ffff ffff ffff ffff ffff ffff
>> +*
>> +2000000
>> -- 
>> 2.40.1
>>
> 
