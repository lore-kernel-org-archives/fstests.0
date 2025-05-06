Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F9F28B4E5
	for <fstests@vger.kernel.org>; Tue,  6 May 2025 03:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746502427; cv=none; b=XdaVmZyPrGOlfUwRn7puomw6cMIfrnwMP2syCwU8EGcrag+QTsW0PGpbSsfDqu7D6Iwexi4mXk3j57AuWC3OHtgZmzse99uICNPUEkN+kF+fdVHJqEIBRKQiM7eOd7J16yNWK7JmuWrXr1XQuL61jLwmg4Fp9S7GbbrGo0w5cS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746502427; c=relaxed/simple;
	bh=C1iFfoOl+L86fs3Nd1p0CEe6atefIAIDAYQUzU53RmI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CjbxJj5URKnUpRbPFpC9xFlWqMG4pR/cf7zZkMK2fuPDKaRlgJGCvpUVm8qAmUmyNa3Ey8Zdl0HmWwacxPygRd1PI1aJnD6PWsyndmMPvq6gNm588NuNeHY0GA4jPM4RwC9wqNw6lP+xm6bh2JAE76uUxoDEej9N7U5scK/rk7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZl/IFp5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZl/IFp5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AAB1C4CEE4;
	Tue,  6 May 2025 03:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746502426;
	bh=C1iFfoOl+L86fs3Nd1p0CEe6atefIAIDAYQUzU53RmI=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=NZl/IFp5mCjytVAMhH4LJHfm2h7dAE6CLUYZdj2npYsHKYLyHbuaDXtMZf5+GBtE7
	 ZriVzqwtgxu0Cr+vojwK9dUmfNOz5oiKbCcgZ/hgVAO7F9UB4P83cK7CSoO1PYNrs8
	 GIru8hWeDsYhueryMcPZp7L6WrseKC1x9nForoj8l/FuaeGuaOr3mifhOVkr1+cJAp
	 he7k2GBJ481vE4IR+w9hus1HgGHDDgkMDljyx5Z8YwpCvEga/N5msfuP29AprLXrxS
	 I/u/etfW/gYhzP25WRfCkzHogd5aibcIcrPNIAj9jcFU8+LCJ6hXLG5YiZmehxcmYJ
	 1/UfuEVctuL/Q==
Message-ID: <98c05eae-7cbb-49a8-8c0e-6f328a87ebf8@kernel.org>
Date: Tue, 6 May 2025 11:33:44 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
 jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Daeho Jeong <daehojeong@google.com>
Subject: Re: [PATCH] f2fs/013: test to check potential corruption on
 atomic_write file
To: David Disseldorp <ddiss@suse.de>
References: <20250430024731.2722027-1-chao@kernel.org>
 <20250502182729.2f6ec951.ddiss@suse.de>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250502182729.2f6ec951.ddiss@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi David,

On 2025/5/2 16:31, David Disseldorp wrote:
> Hi Chao Yu,
> 
> On Wed, 30 Apr 2025 10:47:31 +0800, Chao Yu wrote:
> 
>> This is a regression testcase to check whether we will handle database
>> inode dirty status correctly:
>> 1. make sure disk quota is enabled
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
>>   tests/f2fs/013     | 73 ++++++++++++++++++++++++++++++++++++++++++++++
>>   tests/f2fs/013.out |  2 ++
>>   2 files changed, 75 insertions(+)
>>   create mode 100755 tests/f2fs/013
>>   create mode 100644 tests/f2fs/013.out
>>
>> diff --git a/tests/f2fs/013 b/tests/f2fs/013
>> new file mode 100755
>> index 00000000..3db8448c
>> --- /dev/null
>> +++ b/tests/f2fs/013
>> @@ -0,0 +1,73 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2025 Chao Yu.  All Rights Reserved.
>> +#
>> +# FS QA Test No. f2fs/013
>> +#
>> +# This is a regression testcase to check whether we will handle database
>> +# inode dirty status correctly:
>> +# 1. make sure disk quota is enabled
> 
> Where is the check that disk quota is enabled?

Oh, I tested this testcase, it passed no matter disk quota on or off, let
me remove this description.

> 
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
>> +
>> +_cleanup()
>> +{
>> +	[ -n "$atomic_write_pid" ] && kill -9 $atomic_write_pid
>> +	wait
>> +	cd /
>> +	rm -r -f $tmp.*
>> +}
>> +
>> +_fixed_by_kernel_commit f098aeba04c9 \
>> +	"f2fs: fix to avoid atomicity corruption of atomic file"
>> +
>> +_require_scratch
>> +
>> +_scratch_mkfs >> $seqres.full
>> +# note that it relis on FAULT_TIMEOUT fault injection support in f2fs
>> +_scratch_mount "-o fault_injection=1,fault_type=4194304" >> $seqres.full
> 
> This requires CONFIG_F2FS_FAULT_INJECTION=y, although now I see that
> parse_options() just ignores them and the test still passes fine with
> CONFIG_F2FS_FAULT_INJECTION unset. Does it make sense to run without
> FAULT_TIMEOUT injection? It'd likely make sense to just _notrun if fault
> injection is unavailable.

Yes, the testcase relies on CONFIG_F2FS_FAULT_INJECTION, let me add a
requirement condition for that.

If FAULT_TIMEOUT injection is not supported, mount() will fail.

> 
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
>> +atomic_write_pid=$!
>> +
>> +# call fsync to flush dirty inode of database file in parallel
>> +for ((j=0;j<1000;j++)) do
>> +	$F2FS_IO_PROG fsync $dbfile >> $seqres.full
>> +done
>> +
>> +wait $atomic_write_pid
>> +unset atomic_write_pid
>> +
>> +# flush dirty data and drop cache
>> +sync
>> +echo 3 > /proc/sys/vm/drop_caches
>> +
>> +newsize=`stat $dbfile -c %s`
>> +if [ "$newsize" != "8192" ]; then
>> +	_fail "filesize is inconsistent:"$newsize
>> +fi
> 
> nit: I think it'd be simpler to do:
>    stat $dbfile -c %s
> ...and just put the 8192 in the golden output.

Looks fine to me.

Thanks for the review, let me revise all in v2.

Thanks,

> 
>> +rm $dbfile
>> +sync
>> +
>> +echo "Silence is golden"
>> +
>> +status=0
>> +exit
>> diff --git a/tests/f2fs/013.out b/tests/f2fs/013.out
>> new file mode 100644
>> index 00000000..3e66423b
>> --- /dev/null
>> +++ b/tests/f2fs/013.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 013
>> +Silence is golden
> 

