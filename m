Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2F122576A
	for <fstests@vger.kernel.org>; Mon, 10 Mar 2025 09:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741600768; cv=none; b=BVvJCf9mSF4+OVyXH6+rmLft5J+8ujDPuLcRfH+SDnHTnhun5EM5WpIjFEfmGXfoYwVOr6ubrcp4FSa2KudDxNcl0HS1kebTPEFMhZGqjMCxCvJbtjX4VaTBa5Ff261xuaTeFZrB/3/2uaLITWS5YTtPq1MHiU5dhwYj2SM0RgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741600768; c=relaxed/simple;
	bh=Z3q0VNDQQJqiKLtoo0JN0jgPsoXgNcXUyw1rKUaKMO4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MQ/z9eMfW/Avgo27zXuNlC47bN795N7d4X/sq3xlmb/uNxvkzJ18ZyHwoAVjFdFVEkNV2u+11Cqq9MwfJd12PpkKJh2ftL94ax9JXuKAIyfrRXX854DmW7mm/HIeHH/6erxnhDF4rLgWpBBJb8NgY6SNOQX2yNcxAMxsByXFpHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YmnZSVQA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YmnZSVQA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A0C7C4CEE5;
	Mon, 10 Mar 2025 09:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741600767;
	bh=Z3q0VNDQQJqiKLtoo0JN0jgPsoXgNcXUyw1rKUaKMO4=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=YmnZSVQA9+m0LIV4kJ4RJlWP199iAdJ29LWn4mMZU80vyrh4dBTs+NwYLRg84IdT9
	 J/SFMLp2IQ7/TW7ikW2fS8wK8dMHZQxUvq/gTM4uN6AKo+HOUpF/lDqAvWPdGyuZga
	 ypLQibmyQYkJp+WlKQiF7GAMXRae1yM8vV71wBiu4FK9l7Y3QY0wOiVGQMxfCyKmCR
	 4uUtnQR1Wnz9fDm69rK3II3FWIsBy/c+m6hdU/yTPMaQCT1Tm2qoKIBGH9N2DOgwTM
	 4/9fOU/VOqW0M/Y92hQNlCPDRCABondjuNLxPeZ0OYYffccnqfYCPkN24o8+tg4cdE
	 NzZobEs+OaitA==
Message-ID: <c62943db-6169-462a-95a0-15fb2d5bc079@kernel.org>
Date: Mon, 10 Mar 2025 17:59:23 +0800
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
To: Zorro Lang <zlang@redhat.com>
References: <20250306081809.2397527-1-chao@kernel.org>
 <20250306081809.2397527-4-chao@kernel.org>
 <20250310080006.rkvoxu55fe3qlxmd@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250310080006.rkvoxu55fe3qlxmd@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/10/25 16:00, Zorro Lang wrote:
> On Thu, Mar 06, 2025 at 04:18:09PM +0800, Chao Yu wrote:
>> This is a regression test to check whether fsck can handle corrupted
>> nlinks correctly, it uses inject.f2fs to inject nlinks w/ wrong value,
>> and expects fsck.f2fs can detect such corruption and do the repair.
>>
>> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
> 
> Hi Chao,
> 
> I planned to merge patch 1~3 at first. But as you need to change this
> patch more, and might need to change other patches, so how about you
> send v2 with all this patchset. I'll wait your v2 :)
> 
> Some review points as below...
> 
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
>> +
>> +dir=$SCRATCH_MNT
>> +filename=$dir/foo
>> +hardlink=$dir/bar
>> +
>> +for ((i=0;i<14;i++)) do
>> +	echo "round: " $i >> $seqres.full
>> +
>> +	_scratch_mkfs "-f" >> $seqres.full
> 
> Can we give "-f" to _scratch_mkfs "f2fs" part? Likes:

Looks better,

> 
>   diff --git a/common/rc b/common/rc
>   index bf24da4eb..cafe2f3dd 100644
>   --- a/common/rc
>   +++ b/common/rc
>   @@ -993,7 +993,7 @@ _scratch_mkfs()
>                   mkfs_filter="grep -v -e ^Warning: -e \"^mke2fs \""
>                   ;;
>           f2fs)
>   -               mkfs_cmd="$MKFS_F2FS_PROG"
>   +               mkfs_cmd="$MKFS_F2FS_PROG -f"
>                   mkfs_filter="cat"
>                   ;;
> 
> 
> 
>> +	_scratch_mount >> $seqres.full
>> +
>> +	if [ $i == 0 ]; then
>> +		touch $filename
>> +		ino=`stat $filename | awk '/Inode:/ {print $4}'`
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
>> +
>> +	export FSCK_OPTIONS="-f"
> 
> You've set below code in _repair_scratch_fs():
> 
>     f2fs)
>         fsck -t $FSTYP -f $SCRATCH_DEV
>         ;;
> 
> The FSCK_OPTIONS="-f" is useless.
> 
>> +	_repair_scratch_fs >> $seqres.full
>> +	if [ $? != 1 ]; then
> 
> What does $?=1 mean? Does $?=1 mean finding corruption and fixed, $?=0 mean no corruption?

That's correct.

> 
> If you want to detect there's a corruption, then fix it, then check if it's fixed. How about
> calling _check_scratch_fs at first to get the corruption error you expect, then call
> _repair_scratch_fs to fix it. Then call _check_scratch_fs to make sure the corruption is
> fixed?
> 
> Something likes (just a rough example)
> 
> _check_scratch_fs >>$seqres.full 2>&1 && _fail "can't find corruption"

You mean this?

export FSCK_OPTIONS="--dry-run"
_check_scratch_fs >>$seqres.full 2>&1 || _fail "can't find corruption"

We need to export FSCK_OPTIONS w/ "--dry-run", otherwise _check_scratch_fs
will be stuck once it detects corruption.

> _repair_scratch_fs >> $seqres.full
> _check_scratch_fs
> 
>> +		_fail "fsck can not detect and repair zero nlink corruption "$i
>> +		exit
>> +	fi
>> +
>> +	export FSCK_OPTIONS=""
>> +	_check_scratch_fs >> $seqres.full
> 
> I think _check_scratch_fs outputs nothing if run passed, right?
> 
> _check_scratch_fs calls _check_generic_filesystem for f2fs, the FSCK_OPTIONS
> is "null" by default, so above FSCK_OPTIONS="" is useless too.
> 
>> +	if [ $? != 0 ]; then
>> +		_fail "fsck hasn't fixed nlink corruption "$i
>> +		exit
>> +	fi
>> +
>> +	_scratch_mount >> $seqres.full
> 
> ">> $seqres.full" isn't necessary.

Will update according to you comments, thanks a lot.

Thanks,

> 
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
>>
> 

