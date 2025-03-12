Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01281E9B03
	for <fstests@vger.kernel.org>; Wed, 12 Mar 2025 07:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741763654; cv=none; b=Cogf7ekHEm5FNUrIF8IOyfGHRKjsle8LweJNM5JHpxBdjErFSmIVCJtQNTGmebobMzcTTyLuc7tVZS2xGDGWP2lcQ7PfdfY0QyAIfyJFaJ2QUdzKW0Fx8Ro/7ASbX+cBmx0uG+LbISmb0DT//AutQQ4RyfS5cgpg01hrTdVHU48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741763654; c=relaxed/simple;
	bh=GKueyk+4/bDpJKO28wkD9UiqQi2v+xzj2KG3kFXjdes=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qTI13IZtduUcsX03TqKBnPAv6kMX18vZ5U1DzUdNI343rlPYf7O93pZT7GJ7YBKLMTp/I+wRe5h1yo1GFhPuoO49fx6UWfruyd92zudKbxZd/3h+XfINb480LXIqyK+4dNHwzHJcczFoTDa9cwI0bXPkQEHv7L0RPPiZQr0cC8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKEYu46k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKEYu46k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FDF9C4CEE3;
	Wed, 12 Mar 2025 07:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741763653;
	bh=GKueyk+4/bDpJKO28wkD9UiqQi2v+xzj2KG3kFXjdes=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=dKEYu46k+Lyx0C+2VTalv2VUX8+XoHem23oCxJxbaoqCjBK+Ex8YZg14n0ppc76ev
	 304m7rOz36Phi2rma59O00l2iXdXqVlYuGFNmH5/BQZaCe2QoMG3MRHgBJvWB3ymCJ
	 8VDDzx3lufV9ftvydAUeT+NxEmpUkWHMfydXgWngZS26GzEJytDuMxRPQ2y9ReErqA
	 YLOAV4oSP3iwSLU+7HHHAqpaqi24phowapbs8CR5N0daXhne6Sfd5KrVaa0tK64eqB
	 cfRXQuDGfU+19DcgMKQD55IREmOF5l6VFqo3VtZKiIGsZAiFrQvkL19GcGeoNamIkV
	 cB4dkAwieCK3Q==
Message-ID: <31242101-efdd-41ca-8eb9-3f393e63f92c@kernel.org>
Date: Wed, 12 Mar 2025 15:14:09 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
 jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v3 6/6] f2fs/009: detect and repair nlink corruption
To: Zorro Lang <zlang@redhat.com>
References: <20250311080430.3696582-1-chao@kernel.org>
 <20250311080430.3696582-6-chao@kernel.org>
 <20250311140629.acdx54w4t3pitl22@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250311140629.acdx54w4t3pitl22@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/11/25 22:06, Zorro Lang wrote:
> On Tue, Mar 11, 2025 at 04:04:30PM +0800, Chao Yu wrote:
>> This is a regression test to check whether fsck can handle corrupted
>> nlinks correctly, it uses inject.f2fs to inject nlinks w/ wrong value,
>> and expects fsck.f2fs can detect such corruption and do the repair.
>>
>> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>> v3:
>> - check socket command
>> - add _cleanup to kill & wait background thread
>> - add commit title in _fixed_by_git_commit line
>> - clean up codes
>>  tests/f2fs/009     | 145 +++++++++++++++++++++++++++++++++++++++++++++
>>  tests/f2fs/009.out |   2 +
>>  2 files changed, 147 insertions(+)
>>  create mode 100755 tests/f2fs/009
>>  create mode 100644 tests/f2fs/009.out
>>
>> diff --git a/tests/f2fs/009 b/tests/f2fs/009
>> new file mode 100755
>> index 00000000..4f8b2079
>> --- /dev/null
>> +++ b/tests/f2fs/009
>> @@ -0,0 +1,145 @@
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
>> +if [ ! -x "$(type -P socket)" ]; then
>> +	_notrun "Couldn't find socket"
>> +fi
>> +
>> +_require_scratch
>> +_require_command "$F2FS_INJECT_PROG" inject.f2fs
>> +_require_command "$F2FS_FSCK_PROG" fsck.f2fs
>> +
>> +_fixed_by_git_commit f2fs-tools 958cd6e "fsck.f2fs: support to repair corrupted i_links"
> 
> _fixed_by_git_commit f2fs-tools 958cd6e \
> 	"fsck.f2fs: support to repair corrupted i_links"
> 
>> +
>> +filename=$SCRATCH_MNT/foo
>> +hardlink=$SCRATCH_MNT/bar
>> +
>> +_cleanup()
>> +{
>> +	if [ -n "$pid" ]; then
>> +		kill $pid &> /dev/null
>> +		wait
>> +	fi
> 
> 	cd /
> 	rm -r -f $tmp.*
> 
> I don't have more review points on this test case now, f2fs list might give it
> more reviewing :)

Thanks a lot for the review. :)

Thanks,

> 
> Thanks,
> Zorro
> 
>> +}
>> +
>> +for ((i=0;i<14;i++)) do
>> +	echo "round: " $i >> $seqres.full
>> +
>> +	_scratch_mkfs >> $seqres.full
>> +	_scratch_mount
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
>> +		pid=$!
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
>> +	_check_scratch_fs >> $seqres.full 2>&1 && _fail "can't find corruption"
>> +	_repair_scratch_fs >> $seqres.full
>> +	_check_scratch_fs >> $seqres.full 2>&1 || _fail "fsck can't fix corruption"
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

