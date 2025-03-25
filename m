Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981F81F4C83
	for <fstests@vger.kernel.org>; Tue, 25 Mar 2025 06:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742885957; cv=none; b=UwtZMJFETud2bG4KrQTLaCRPp211JNOBef1Dd6q+XdvwLtH9wF7QLWaMeQya4Ur4tPuao8KDFX+JNrfHlszvR2h12beaa6zYlOTSJ9acyPtFbhJ6UA7gH17TpmWYqi5KT7CJ2Awn7fbFNpVvUQu5F3c53xDVlr/Q6okIKrXzuIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742885957; c=relaxed/simple;
	bh=KJTdAsEL/0ZMZpo4gzToh+crD41MLDFt9Xm+PUAS5NM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Rp4GfKZ2trb2GNmEYJBx0axIAFk4DFazal95UFRFtEzlt7MJ41d+oEkk39CsU48Gph7d1IgHgYtudn5ZUbtjxZ7MLLyolMe/Zd6Cb2639bp+KQKkU4itf95A0kEs5D5cxpnbYprzeum6DBhk2aGqdCHIUNDAdgCs/rhEx57TjTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TeZQE5SG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TeZQE5SG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11EF3C4CEEA;
	Tue, 25 Mar 2025 06:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742885957;
	bh=KJTdAsEL/0ZMZpo4gzToh+crD41MLDFt9Xm+PUAS5NM=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=TeZQE5SGPooAGf6hqSybwvn7rDyWC0y16xToaKGZSKVzc6pe85JrlAPbWIDHXvQHz
	 iqSNHlXlhOCZhYPO+KRJvK5V1/Osm42AsJgcH8l5M+YgA2u/cj/827MQ1CtLt/cZ2I
	 7bk4dnqAqQPhLNHqgEF6o+UVbNS1lTe+YStNhPC3nmzyq1B6RZFi9xkRei0YRWPj7l
	 nJIT1oWluPI4RPA42ntT+LpvwE74K//g/0fVzRmb3C90pB9NsyBE02Z/niiYNfxsVM
	 RrIjoS1aQ88oH7NZXh9O2uJ5/PfEWzRbQsX01Pzyl0PCK0wu2H/Nbt/m4y3hapoBQ/
	 42P+cKgX9Qv/w==
Message-ID: <e439117b-9f91-43c0-9203-1786a7372c95@kernel.org>
Date: Tue, 25 Mar 2025 14:59:11 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
 jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Daeho Jeong <daehojeong@google.com>, Jianan Huang <huangjianan@xiaomi.com>
Subject: Re: [PATCH] f2fs/010: test dirty status handling on database file
To: Zorro Lang <zlang@redhat.com>
References: <20250324123836.3098377-1-chao@kernel.org>
 <20250325011854.svncwerxilkimg5j@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250325011854.svncwerxilkimg5j@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/25/25 09:18, Zorro Lang wrote:
> On Mon, Mar 24, 2025 at 08:38:36PM +0800, Chao Yu wrote:
>> This is a regression testcase to check whether we will handle database
>> inode dirty status correctly:
>> 1. create a regular file, and write data into the file
>> 2. start transaction on the file (via F2FS_IOC_START_ATOMIC_WRITE)
>> 3. write transaction data to the file
>> 4. rename the file
>> 5. commit and end the transaction (via F2FS_IOC_COMMIT_ATOMIC_WRITE)
>> 6. drop caches in order to call f2fs_evict_inode()
>> It expects kernel panic will gone after we apply commit 03511e936916
>> ("f2fs: fix inconsistent dirty state of atomic file").
>>
>> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
>> Cc: Daeho Jeong <daehojeong@google.com>
>> Cc: Jianan Huang <huangjianan@xiaomi.com>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>  tests/f2fs/010     | 68 ++++++++++++++++++++++++++++++++++++++++++++++
>>  tests/f2fs/010.out |  2 ++
>>  2 files changed, 70 insertions(+)
>>  create mode 100755 tests/f2fs/010
>>  create mode 100644 tests/f2fs/010.out
>>
>> diff --git a/tests/f2fs/010 b/tests/f2fs/010
>> new file mode 100755
>> index 00000000..360c09b9
>> --- /dev/null
>> +++ b/tests/f2fs/010
>> @@ -0,0 +1,68 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2025 Chao Yu.  All Rights Reserved.
>> +#
>> +# FS QA Test No. f2fs/010
>> +#
>> +# This is a regression testcase to check whether we will handle database
>> +# inode dirty status correctly:
>> +# 1. create a regular file, and write data into the file
>> +# 2. start transaction on the file (via F2FS_IOC_START_ATOMIC_WRITE)
>> +# 3. write transaction data to the file
>> +# 4. rename the file
>> +# 5. commit and end the transaction (via F2FS_IOC_COMMIT_ATOMIC_WRITE)
>> +# 6. drop caches in order to call f2fs_evict_inode()
>> +# It expects kernel panic will gone after we apply commit 03511e936916
>> +# ("f2fs: fix inconsistent dirty state of atomic file").
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto quick
>> +
>> +_cleanup()
>> +{
>> +	kill -9 $atomic_write_pid > /dev/null 2>&1
> 
> [ -n "$atomic_write_pid" ] && kill -9 $atomic_write_pid
> 
>> +	wait
>> +	cd /
>> +	rm -r -f $tmp.*
>> +}
>> +
>> +_fixed_by_kernel_commit 03511e936916 \
>> +	"f2fs: fix inconsistent dirty state of atomic file"
>> +
>> +_require_scratch
>> +_require_command "$F2FS_IO_PROG" f2fs_io
>> +
>> +_scratch_mkfs >> $seqres.full
>> +_scratch_mount >> $seqres.full
>> +
>> +src_db=$SCRATCH_MNT/src.db
>> +dst_db=$SCRATCH_MNT/dst.db
>> +
>> +# initialize database file
>> +$XFS_IO_PROG -c "pwrite 0 4k" -c "fsync" -f $src_db >> $seqres.full
>> +
>> +# sync filesystem to clear dirty inode
>> +sync
>> +
>> +# start atomic_write on src.db database file and commit transaction after 3000ms
>> +$F2FS_IO_PROG write 1 0 0 zero atomic_commit $src_db 3000 >> $seqres.full &
>> +atomic_write_pid=$!
>> +
>> +# wait a moment to let atomic write starts
>> +sleep 1
>> +
>> +# it will dirty inode when updating i_pino
>> +mv $src_db $dst_db
>> +
>> +# wait for atomic_write commit completion
>> +sleep 4
>> +
>> +# drop caches in order to call f2fs_evict_inode()
>> +echo 3 > /proc/sys/vm/drop_caches
>> +
>> +wait $atomic_write_pid
> 
> So after this line, the $atomic_write_pid has been released. If so, how about:
> 
> unset atomic_write_pid
> 
> And then in _cleanup function .... (see above)
> 
> Others look good to me,

Oh, correct, will fix this. Thank you!

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
>> diff --git a/tests/f2fs/010.out b/tests/f2fs/010.out
>> new file mode 100644
>> index 00000000..1d83a8d6
>> --- /dev/null
>> +++ b/tests/f2fs/010.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 010
>> +Silence is golden
>> -- 
>> 2.48.1
>>
> 

