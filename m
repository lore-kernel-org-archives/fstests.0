Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356F12253E6
	for <fstests@vger.kernel.org>; Mon, 10 Mar 2025 09:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741599997; cv=none; b=Qa4/a4yP1tchVq5JSHRbUh1NlwDXubQJ6E03FtMQsm+fZIdGQx+hDL0IW0qYh+6q3Pp709NvP7kyHpnTyFTF/UBA+ZQLOQtOSvkDd26Gz4BTjySAPTcn0pb0YajKQwzmXKB7b0AvuD1e0p0QqmtYysf3aylWOoO0NHW915TJPIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741599997; c=relaxed/simple;
	bh=dcXEUFug6D8brVanUiIMLLCorna/mNPQSinIVrWWZ3o=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iqBRz8HiRlzHEVZ4IUifEBFgyjcqfgLYVODLk9U2cr2n4+3hrnN00KP5lvyDTCtp2I05j4upbfs6AfEWAQDbXZzpglYRULg9V8yBNJ3b4BFvkOYUWCsM8cm7x79xZdrFMRKRRjupPrlxHgeyBj6aJ7lXMJyNQWb9CS/HRgndwCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0AsezGZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0AsezGZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F1AC4CEE5;
	Mon, 10 Mar 2025 09:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741599996;
	bh=dcXEUFug6D8brVanUiIMLLCorna/mNPQSinIVrWWZ3o=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=S0AsezGZvFLFVMuXi6YOnxMPdTOqib/FVoMehJOJjiISnZlJXzO/OsM/aatzd+0j3
	 qfEXourI+9XeaH6/b+YIDP1J4Rqhtna5BBOB+AW0peSb0oNPOXAnEoA5ObB5LyPtcO
	 U4WyKLFCkAew1Sdd8wnhKunrHY7b8EtzS0EgJd1cGBYpz4XxpKRrWfIky39zefZ/5s
	 OnI7FqXVEKGrlShMb7jNdzsMJj1UKFYrlZcOm4uAB+y+aFiJhsN6GRqr8N0fwQZK1d
	 NzPhtaROeL82P1c1J3wZ1htM6G5RFzIVb+RW5EeZ+2reiitjihAnE9gPeM7f1MU6yf
	 Fv3Te8V+uD+Qg==
Message-ID: <16a90282-2245-4765-8d0e-a1bff48853a3@kernel.org>
Date: Mon, 10 Mar 2025 17:46:32 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
 jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 4/4] f2fs/009: detect and repair nlink corruption
To: David Disseldorp <ddiss@suse.de>
References: <20250306081809.2397527-1-chao@kernel.org>
 <20250306081809.2397527-4-chao@kernel.org>
 <20250307150212.7cda01f2.ddiss@suse.de>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250307150212.7cda01f2.ddiss@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/7/25 12:02, David Disseldorp wrote:
> Thanks for submitting the new test. It looks good aside from a few minor
> things below...
> 
> On Thu,  6 Mar 2025 16:18:09 +0800, Chao Yu wrote:
> 
>> This is a regression test to check whether fsck can handle corrupted
>> nlinks correctly, it uses inject.f2fs to inject nlinks w/ wrong value,
>> and expects fsck.f2fs can detect such corruption and do the repair.
>>
>> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>  tests/f2fs/009     | 142 +++++++++++++++++++++++++++++++++++++++++++++
>>  tests/f2fs/009.out |   2 +
>>  2 files changed, 144 insertions(+)
>>  create mode 100755 tests/f2fs/009
>>  create mode 100644 tests/f2fs/009.out
>>
>> diff --git a/tests/f2fs/009 b/tests/f2fs/009
>> new file mode 100755
>> index 00000000..8f6a3e11
>> --- /dev/null
>> +++ b/tests/f2fs/009
>> @@ -0,0 +1,142 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2025 Chao Yu.  All Rights Reserved.
>> +#
>> +# FS QA Test No. f2fs/009
>> +#
>> +# This is a regression test to check whether fsck can handle corrupted
>> +# nlinks correctly, it uses inject.f2fs to inject nlinks w/ wrong value,
>> +# and expects fsck.f2fs can detect such corruption and do the repair.
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto quick
>> +
>> +_require_scratch
> 
> You should probably check for F2FS_INJECT_PROG and skip if not present.
> Is it dependent on CONFIG_F2FS_FAULT_INJECTION? If so it'd be nice if

It isn't dependent on CONFIG_F2FS_FAULT_INJECTION.

> you could check for that too.
> 
> Flag the fix for the regression via e.g.:
> _fixed_by_git_commit f2fs-tools 958cd6e
> 
>> +
>> +dir=$SCRATCH_MNT
> 
> I think it'd be easier to follow if you dropped this alias and just used
> $SCRATCH_MNT directly.
> 
>> +filename=$dir/foo
>> +hardlink=$dir/bar
>> +
>> +for ((i=0;i<14;i++)) do
>> +	echo "round: " $i >> $seqres.full
>> +
>> +	_scratch_mkfs "-f" >> $seqres.full
>> +	_scratch_mount >> $seqres.full
>> +
>> +	if [ $i == 0 ]; then
>> +		touch $filename
>> +		ino=`stat $filename | awk '/Inode:/ {print $4}'`
> 
> Use "stat -c '%i'" instead of piping into awk. Also, it looks like this
> is called in every round, so just move it after the elifs.
> 
>> +		nlink=0
>> +	elif [ $i == 1 ]; then
>> +		mkdir $filename
>> +		ino=`stat $filename | awk '/Inode:/ {print $4}'`
>> +		nlink=1
>> +	elif [ $i == 2 ]; then
>> +		mknod $filename c 9 0
>> +		ino=`stat $filename | awk '/Inode:/ {print $4}'`
>> +		nlink=0
>> +	elif [ $i == 3 ]; then
>> +		mknod $filename b 8 0
>> +		ino=`stat $filename | awk '/Inode:/ {print $4}'`
>> +		nlink=0
>> +	elif [ $i == 4 ]; then
>> +		mkfifo $filename
>> +		ino=`stat $filename | awk '/Inode:/ {print $4}'`
>> +		nlink=0
>> +	elif [ $i == 5 ]; then
>> +		socket -s $filename >> $seqres.full 2>&1 &
>> +		pid=$!
>> +		sleep 2
>> +		ino=`stat $filename | awk '/Inode:/ {print $4}'`
>> +		kill $pid >> $seqres.full 2>&1
>> +		nlink=0
>> +	elif [ $i == 6 ]; then
>> +		ln -s $dir/empty $filename
>> +		ino=`stat $filename | awk '/Inode:/ {print $4}'`
>> +		nlink=0
>> +	elif [ $i == 7 ]; then
>> +		# orphan inode
>> +		touch $filename
>> +		ino=`stat $filename | awk '/Inode:/ {print $4}'`
>> +		$F2FS_IO_PROG write 1 0 1 zero atomic_commit $filename 5000 >> $seqres.full 2>&1 &
>> +		stat $filename >> $seqres.full
>> +		rm $filename
>> +		$F2FS_IO_PROG shutdown 1 $dir/ >> $seqres.full
>> +		sleep 6
>> +		nlink=1
>> +	elif [ $i == 8 ]; then
>> +		# hardlink on file
>> +		touch $filename
>> +		ino=`stat $filename | awk '/Inode:/ {print $4}'`
>> +		ln $filename $hardlink
>> +		nlink=0
>> +	elif [ $i == 9 ]; then
>> +		# hardlink on charactor
>> +		mknod $filename c 9 0
>> +		ino=`stat $filename | awk '/Inode:/ {print $4}'`
>> +		ln $filename $hardlink
>> +		nlink=0
>> +	elif [ $i == 10 ]; then
>> +		# hardlink on blockdev
>> +		mknod $filename b 8 0
>> +		ino=`stat $filename | awk '/Inode:/ {print $4}'`
>> +		ln $filename $hardlink
>> +		nlink=0
>> +	elif [ $i == 11 ]; then
>> +		# hardlink on pipe
>> +		mkfifo $filename
>> +		ino=`stat $filename | awk '/Inode:/ {print $4}'`
>> +		ln $filename $hardlink
>> +		nlink=0
>> +	elif [ $i == 12 ]; then
>> +		# hardlink on socket
>> +		socket -s $filename >> $seqres.full 2>&1 &
>> +		pid=$!
>> +		sleep 2
>> +		ino=`stat $filename | awk '/Inode:/ {print $4}'`
>> +		kill $pid >> $seqres.full 2>&1
>> +		ln $filename $hardlink
>> +		nlink=0
>> +	elif [ $i == 13 ]; then
>> +		# hardlink on symlink
>> +		ln -s $dir/empty $filename
>> +		ino=`stat $filename | awk '/Inode:/ {print $4}'`
>> +		ln $filename $hardlink
>> +		nlink=0
>> +	fi
>> +
>> +	if [ $i != 7 ]; then
>> +		stat $dir/* >> $seqres.full
>> +	fi
>> +	echo "ino:"$ino >> $seqres.full
>> +	echo "nlink:"$nlink >> $seqres.full
>> +
>> +	_scratch_unmount
>> +
>> +	$F2FS_INJECT_PROG --node --mb i_links --nid $ino --val $nlink $SCRATCH_DEV >> $seqres.full
>> +	if [ $? != 0 ]; then
>> +		exit
>> +	fi
> 
> xfstests failures are normally triggered via golden output mismatch
> instead of explicit status checks or _fail calls... Can you filter the
> inject / repair output so that it ends up in the golden output for
> comparison?

I tried to avoid filting inject/repair outputs and compare the output w/
golden output in 009.out, since I'm not sure whether the output will change
or not later in f2fs-tools...

Will fix all others according to your comments, thanks a lot for the comments.

Thanks,

> 
>> +	export FSCK_OPTIONS="-f"
>> +	_repair_scratch_fs >> $seqres.full
>> +	if [ $? != 1 ]; then
>> +		_fail "fsck can not detect and repair zero nlink corruption "$i
>> +		exit
>> +	fi
>> +
>> +	export FSCK_OPTIONS=""
>> +	_check_scratch_fs >> $seqres.full
>> +	if [ $? != 0 ]; then
>> +		_fail "fsck hasn't fixed nlink corruption "$i
>> +		exit
>> +	fi
>> +
>> +	_scratch_mount >> $seqres.full
>> +	_scratch_unmount
>> +done
>> +
>> +echo "Silence is golden"
>> +
>> +status=0
>> +exit
>> diff --git a/tests/f2fs/009.out b/tests/f2fs/009.out
>> new file mode 100644
>> index 00000000..7e977155
>> --- /dev/null
>> +++ b/tests/f2fs/009.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 009
>> +Silence is golden
> 

