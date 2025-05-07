Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC9B78C9C
	for <fstests@vger.kernel.org>; Wed,  7 May 2025 03:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746587859; cv=none; b=XjbSCU46U5fZynEhvTqoM+8T9S29eNhIhpH7tr1ohwnsPcYJ4gwmvbmUCG13rVxF4AF/D9Ksxft4O+5sYKoF9hX0iS3tNc3fcfxhSKfuBdbuDEwTwO7kex4hpv70RF4mDCOeI1RVyYEBH5TlrWZftpaCnXRKDFG98WROv/jguJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746587859; c=relaxed/simple;
	bh=PCpx3cYzYX0hsD6EmUQWh2G/WPYfCQ+gGZYu0je5w1E=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Cc9M7Xx/+Kb1IxXkx3KnbwmesN+rO4cgAaLJQZGOT9SEDyHarV59Uv/VQyBuBS3N1C6ceKgfNDpYaJwjlxzDp0QEtaoPdCoAwsL4ahFfJrMMdXjmJv4hZ4dvXr7Vjrohae+9BQ7tTvOyIsetMNBM4xCa5T0qzwoTQHerx8R7krE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DeI0mpU5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DeI0mpU5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2FFAC4CEE4;
	Wed,  7 May 2025 03:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746587858;
	bh=PCpx3cYzYX0hsD6EmUQWh2G/WPYfCQ+gGZYu0je5w1E=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=DeI0mpU5IZWvK/F/ZoyRo22qIWMjNjeIHWIX21ua0uMWJ0v/TJOoZtPWHrBpup29e
	 Xo44VrfGm4xk2af55K3Ju2hPiq29eB5uGOG86m61+hrtTFJPlkURybmM6ZnpqoZXpA
	 MFEgBEJTQRpFqO8xjHvRzDrmXDWhxUHC/QuwBjd7PyvFYWmFqSjARAm4Dmj5bs0kw3
	 79vs7DV/hvs6eI9xhMFBb/M8DzkHjqiMwgvthgySf4emmMUrM4FfEsFjKRDpSWJUQz
	 ehCs2ICdI8VOt0Ft7SNr363FE1QWl9mR9fkkmfkpekfV7DbzumObw4s4dioAVW5NS4
	 v5ULAMti3Ta4A==
Message-ID: <041198dd-c6b5-4c7e-baa2-89a9f1297317@kernel.org>
Date: Wed, 7 May 2025 11:17:34 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
 jaegeuk@kernel.org, Daeho Jeong <daehojeong@google.com>,
 linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v2] f2fs/013: test to check potential
 corruption on atomic_write file
To: Daeho Jeong <daeho43@gmail.com>
References: <20250506070210.539539-1-chao@kernel.org>
 <CACOAw_xzP+dfhhFsOLTOagU-QPeUUOzSpyZLO7dArvAe4F8H8g@mail.gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <CACOAw_xzP+dfhhFsOLTOagU-QPeUUOzSpyZLO7dArvAe4F8H8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/7/25 04:25, Daeho Jeong wrote:
> On Tue, May 6, 2025 at 12:05 AM Chao Yu via Linux-f2fs-devel
> <linux-f2fs-devel@lists.sourceforge.net> wrote:
>>
>> This is a regression testcase to check whether we will handle database
>> inode dirty status correctly:
>> 1. mount f2fs image w/ timeout fault injection option
>> 2. create a regular file, and write data into the file
>> 3. start transaction on the file (via F2FS_IOC_START_ATOMIC_WRITE)
>> 4. write transaction data to the file
>> 5. commit and end the transaction (via F2FS_IOC_COMMIT_ATOMIC_WRITE)
>> 6. meanwhile loop call fsync in parallel
>> Before f098aeba04c9 ("f2fs: fix to avoid atomicity corruption of atomic
>> file"), database file may become corrupted after atomic write while
>> there is concurrent dirty inode flush in background.
>>
>> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
>> Cc: Daeho Jeong <daehojeong@google.com>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>> v2:
>> - fix description of test steps
>> - add missing "_require_kernel_config CONFIG_F2FS_FAULT_INJECTION"
>> - add missing "_require_command "$F2FS_IO_PROG" f2fs_io"
>> - put correct filesize in the golden output
>>  tests/f2fs/013     | 71 ++++++++++++++++++++++++++++++++++++++++++++++
>>  tests/f2fs/013.out |  2 ++
>>  2 files changed, 73 insertions(+)
>>  create mode 100755 tests/f2fs/013
>>  create mode 100644 tests/f2fs/013.out
>>
>> diff --git a/tests/f2fs/013 b/tests/f2fs/013
>> new file mode 100755
>> index 00000000..4cf56840
>> --- /dev/null
>> +++ b/tests/f2fs/013
>> @@ -0,0 +1,71 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2025 Chao Yu.  All Rights Reserved.
>> +#
>> +# FS QA Test No. f2fs/013
>> +#
>> +# This is a regression testcase to check whether we will handle database
>> +# inode dirty status correctly:
>> +# 1. mount f2fs image w/ timeout fault injection option
>> +# 2. create a regular file, and write data into the file
>> +# 3. start transaction on the file (via F2FS_IOC_START_ATOMIC_WRITE)
>> +# 4. write transaction data to the file
>> +# 5. commit and end the transaction (via F2FS_IOC_COMMIT_ATOMIC_WRITE)
>> +# 6. meanwhile loop call fsync in parallel
>> +# Before f098aeba04c9 ("f2fs: fix to avoid atomicity corruption of atomic
>> +# file"), database file may become corrupted after atomic write while
>> +# there is concurrent dirty inode flush in background.
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto quick
>> +_require_kernel_config CONFIG_F2FS_FAULT_INJECTION
>> +_require_command "$F2FS_IO_PROG" f2fs_io
>> +
>> +_cleanup()
>> +{
>> +       [ -n "$atomic_write_pid" ] && kill -9 $atomic_write_pid
>> +       wait
>> +       cd /
>> +       rm -r -f $tmp.*
>> +}
>> +
>> +_fixed_by_kernel_commit f098aeba04c9 \
>> +       "f2fs: fix to avoid atomicity corruption of atomic file"
>> +
>> +_require_scratch
>> +
>> +_scratch_mkfs >> $seqres.full
>> +# note that it relis on FAULT_TIMEOUT fault injection support in f2fs
> 
> relis -> relies

Will fix.

> 
>> +_scratch_mount "-o fault_injection=1,fault_type=4194304" >> $seqres.full
>> +
>> +dbfile=$SCRATCH_MNT/file.db
>> +
>> +# initialize database file
>> +$XFS_IO_PROG -c "pwrite 0 4k" -c "fsync" -f $dbfile >> $seqres.full
>> +
>> +# sync filesystem to clear dirty inode
>> +sync
>> +
>> +# start atomic_write on src.db database file and commit transaction
>> +$F2FS_IO_PROG write 1 0 2 zero atomic_commit $dbfile >> $seqres.full &
> 
> I think we might have some timing issues here like background f2fs_io
> ends earlier than foreground fsync() loop.

What about adding a sysfs entry to control timeout, by default it's
1 second, we can tune it to 5 second for this case?

Thanks,

> 
>> +atomic_write_pid=$!
>> +
>> +# call fsync to flush dirty inode of database file in parallel
>> +for ((j=0;j<1000;j++)) do
>> +       $F2FS_IO_PROG fsync $dbfile >> $seqres.full
>> +done
>> +
>> +wait $atomic_write_pid
>> +unset atomic_write_pid
>> +
>> +# flush dirty data and drop cache
>> +sync
>> +echo 3 > /proc/sys/vm/drop_caches
>> +
>> +stat $dbfile -c %s
>> +
>> +rm $dbfile
>> +sync
>> +
>> +status=0
>> +exit
>> diff --git a/tests/f2fs/013.out b/tests/f2fs/013.out
>> new file mode 100644
>> index 00000000..d9271f75
>> --- /dev/null
>> +++ b/tests/f2fs/013.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 013
>> +8192
>> --
>> 2.49.0
>>
>>
>>
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

