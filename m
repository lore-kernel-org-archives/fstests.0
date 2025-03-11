Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860D5224AE1
	for <fstests@vger.kernel.org>; Tue, 11 Mar 2025 08:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741680406; cv=none; b=qkEY6gCLp/10Qy5VJPPldk7xyyHX334HyCLBjEBdz8EyaREAAxm9mEaPTvhGFz7CrHtzPl3FUmmN8F2BxurmeLDdRxNyeJnXE0oeO/60xzsTEgZxjKbBhXG+RqYZOCRrQkNd0yJ9geewSQvcS+QwlkYqpZMtvR4M4Cc34zF6FXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741680406; c=relaxed/simple;
	bh=BKPu9ryzQf2xBUqVUEiTvQVT9BrE/DJsubTZEEbhihg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FdCund6EeZOjfLk7vRq02/FGuH7yMaZceBItiJSHZwiFnDWcdJldm7rxUOnMr0hbtUtkJ5rjiRUAMH3WtYcfRl7qXoLfPQfdSlwWRjeqPBtDEVyw1QDpemMKMAY0Zl5TU0Db/TEbZMxy9ZyWcHRxbVIyNUPWpeP4hY5PAcSDkq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AVzW5jRF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVzW5jRF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A3A1C4CEEF;
	Tue, 11 Mar 2025 08:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741680405;
	bh=BKPu9ryzQf2xBUqVUEiTvQVT9BrE/DJsubTZEEbhihg=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=AVzW5jRFQOtPIsdMMYo6VHIPEbtoHn1wfbpA0D4NQ0tTx0I4PWhLT0TVdWDVXkfCs
	 5TkUviscKCVpV1TT2+xgQDRtKjCtbiCZPB7B2I6XuDMyakmR6To4dmZRg0a78E1ysk
	 CeXRV0ncHm8TwVDcxqnPThaiWPTG1OgYb2ZBMPxUTL8WtlEqpUgvGfscKkmtcg9yiT
	 kFn1hCLhsdLFbozOOShBFfyaF/VXYo00mhB/KALLR4EGpifX7sK7r6aaqAbBVLfl/k
	 6ib3g/G7v2Y9LU2CMKAn490wfFQCiEjcR2td06XIl1qSLGq6Vi6nyoxtp+FTZX0hpc
	 wSlGJvP5tQVQw==
Message-ID: <8480a7fd-1357-4032-9e30-8259ee34976a@kernel.org>
Date: Tue, 11 Mar 2025 16:06:40 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
 jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v2 4/4] f2fs/009: detect and repair nlink corruption
To: Zorro Lang <zlang@redhat.com>
References: <20250310115621.3441518-1-chao@kernel.org>
 <20250310115621.3441518-4-chao@kernel.org>
 <20250310202531.kpbloh4c6lopyvw7@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250310202531.kpbloh4c6lopyvw7@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/11/25 04:25, Zorro Lang wrote:
> On Mon, Mar 10, 2025 at 07:56:21PM +0800, Chao Yu wrote:
>> This is a regression test to check whether fsck can handle corrupted
>> nlinks correctly, it uses inject.f2fs to inject nlinks w/ wrong value,
>> and expects fsck.f2fs can detect such corruption and do the repair.
>>
>> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>> v2:
>> - make _scratch_mkfs() to format f2fs image forcely
>> - adjust _check_scratch_fs() to allow specified parameter of f2fs
>> - add _fixed_by_git_commit
>> - add _require_command inject.f2fs
>> - simply return value handling
>>  common/rc          |   9 ++-
>>  tests/f2fs/009     | 133 +++++++++++++++++++++++++++++++++++++++++++++
>>  tests/f2fs/009.out |   2 +
>>  3 files changed, 143 insertions(+), 1 deletion(-)
>>  create mode 100755 tests/f2fs/009
>>  create mode 100644 tests/f2fs/009.out
>>
>> diff --git a/common/rc b/common/rc
>> index bf24da4e..e156f3af 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -993,7 +993,7 @@ _scratch_mkfs()
>>  		mkfs_filter="grep -v -e ^Warning: -e \"^mke2fs \""
>>  		;;
>>  	f2fs)
>> -		mkfs_cmd="$MKFS_F2FS_PROG"
>> +		mkfs_cmd="$MKFS_F2FS_PROG -f"
>>  		mkfs_filter="cat"
>>  		;;
>>  	ocfs2)
>> @@ -3682,6 +3682,13 @@ _check_scratch_fs()
>>      ubifs)
>>  	# there is no fsck program for ubifs yet
>>  	;;
>> +    f2fs)
>> +        if [ "$FSCK_OPTIONS" == "--dry-run" ]; then
>> +            fsck -t $FSTYP $device -- $FSCK_OPTIONS >> $seqres.full 2>&1
>> +        else
>> +            _check_generic_filesystem $device
>> +        fi
>> +        ;;
>>      *)
>>  	_check_generic_filesystem $device
>>  	;;
>> diff --git a/tests/f2fs/009 b/tests/f2fs/009
>> new file mode 100755
>> index 00000000..d14df968
>> --- /dev/null
>> +++ b/tests/f2fs/009
>> @@ -0,0 +1,133 @@
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
>> +_require_command "$F2FS_INJECT_PROG" inject.f2fs
>> +
>> +_fixed_by_git_commit f2fs-tools 958cd6e
>                                            ^^^^^^^^
>                                            commit subject?
> 
>> +
>> +filename=$SCRATCH_MNT/foo
>> +hardlink=$SCRATCH_MNT/bar
>> +
>> +for ((i=0;i<14;i++)) do
>> +	echo "round: " $i >> $seqres.full
>> +
>> +	_scratch_mkfs "-f" >> $seqres.full
> 
> As you've add "-f" in _scratch_mkfs, so this "-f" can be removed.
> 
>> +	_scratch_mount >> $seqres.full
>                           ^^^^^^
>                           I think it's useless
> 
>> +
>> +	if [ $i == 0 ]; then
>> +		touch $filename
>> +		ino=`stat -c '%i' $filename`
>> +		nlink=0
>> +	elif [ $i == 1 ]; then
>> +		mkdir $filename
>> +		ino=`stat -c '%i' $filename`
>> +		nlink=1
>> +	elif [ $i == 2 ]; then
>> +		mknod $filename c 9 0
>> +		ino=`stat -c '%i' $filename`
>> +		nlink=0
>> +	elif [ $i == 3 ]; then
>> +		mknod $filename b 8 0
>> +		ino=`stat -c '%i' $filename`
>> +		nlink=0
>> +	elif [ $i == 4 ]; then
>> +		mkfifo $filename
>> +		ino=`stat -c '%i' $filename`
>> +		nlink=0
>> +	elif [ $i == 5 ]; then
>> +		socket -s $filename >> $seqres.full 2>&1 &
>                 ^^^^^^
> 
> Where's the "socket" command from? I think it's not always installed on any
> Linux system. fstests never use this command in any test case. If you
> need this command, you might need to check that, and _notrun if it's
> not installed.
> 
>> +		pid=$!
> 
> As you have background processes in this test case, you need to make sure
> these processes are killed properly in _cleanup, especially if the test
> is killed suddently, refer to generic/019.

Zorro, I've updated the patchset, could you please help to check that?

Thanks,

> 
> Thanks,
> Zorro
> 
>> +		sleep 2
>> +		ino=`stat -c '%i' $filename`
>> +		kill $pid >> $seqres.full 2>&1
>> +		nlink=0
>> +	elif [ $i == 6 ]; then
>> +		ln -s $SCRATCH_MNT/empty $filename
>> +		ino=`stat -c '%i' $filename`
>> +		nlink=0
>> +	elif [ $i == 7 ]; then
>> +		# orphan inode
>> +		touch $filename
>> +		ino=`stat -c '%i' $filename`
>> +		$F2FS_IO_PROG write 1 0 1 zero atomic_commit $filename 5000 >> $seqres.full 2>&1 &
>> +		stat $filename >> $seqres.full
>> +		rm $filename
>> +		$F2FS_IO_PROG shutdown 1 $SCRATCH_MNT/ >> $seqres.full
>> +		sleep 6
>> +		nlink=1
>> +	elif [ $i == 8 ]; then
>> +		# hardlink on file
>> +		touch $filename
>> +		ino=`stat -c '%i' $filename`
>> +		ln $filename $hardlink
>> +		nlink=0
>> +	elif [ $i == 9 ]; then
>> +		# hardlink on charactor
>> +		mknod $filename c 9 0
>> +		ino=`stat -c '%i' $filename`
>> +		ln $filename $hardlink
>> +		nlink=0
>> +	elif [ $i == 10 ]; then
>> +		# hardlink on blockdev
>> +		mknod $filename b 8 0
>> +		ino=`stat -c '%i' $filename`
>> +		ln $filename $hardlink
>> +		nlink=0
>> +	elif [ $i == 11 ]; then
>> +		# hardlink on pipe
>> +		mkfifo $filename
>> +		ino=`stat -c '%i' $filename`
>> +		ln $filename $hardlink
>> +		nlink=0
>> +	elif [ $i == 12 ]; then
>> +		# hardlink on socket
>> +		socket -s $filename >> $seqres.full 2>&1 &
>> +		pid=$!
>> +		sleep 2
>> +		ino=`stat -c '%i' $filename`
>> +		kill $pid >> $seqres.full 2>&1
>> +		ln $filename $hardlink
>> +		nlink=0
>> +	elif [ $i == 13 ]; then
>> +		# hardlink on symlink
>> +		ln -s $SCRATCH_MNT/empty $filename
>> +		ino=`stat -c '%i' $filename`
>> +		ln $filename $hardlink
>> +		nlink=0
>> +	fi
>> +
>> +	if [ $i != 7 ]; then
>> +		stat $SCRATCH_MNT/* >> $seqres.full
>> +	fi
>> +	echo "ino:"$ino >> $seqres.full
>> +	echo "nlink:"$nlink >> $seqres.full
>> +
>> +	_scratch_unmount
>> +
>> +	$F2FS_INJECT_PROG --node --mb i_links --nid $ino --val $nlink $SCRATCH_DEV \
>> +		>> $seqres.full || _fail "fail to inject"
>> +
>> +	export FSCK_OPTIONS="--dry-run"
>> +	_check_scratch_fs >>$seqres.full 2>&1 && _fail "can't find corruption"
>> +	_repair_scratch_fs >> $seqres.full
>> +	_check_scratch_fs
>> +
>> +	_scratch_mount
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
>> -- 
>> 2.48.1
>>
> 

