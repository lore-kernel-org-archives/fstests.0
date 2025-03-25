Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4212C1891AB
	for <fstests@vger.kernel.org>; Tue, 25 Mar 2025 06:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742885659; cv=none; b=Pxd0nt/6P5s6LgDZ/4/hn9jIm1eQqfPyWqEJzqkVBXRqjCjhi+uhkbVuKF7QBePqEg6VrcVZYKMMk269tLrlWR4/aT+yJakSgeEvhWyVCv6pjbMktumNHysOAC7K7BuzQgbFcw606T1XEP+mGsa+UzJBlYz37Vz0mo/eROGYvoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742885659; c=relaxed/simple;
	bh=77DQRojoYWf5m2oCtXQuAg5HNyWuTE3SfSPulFwVz/w=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SZ1om4UnqX0qRVHxYwOA+loCQCiWkOrcHN6WeIDZqfDy7lLShia+XEqpnxtEaK47qAiYVo6kWjO+oX6+1fIS3Nl3Hi1NwBOUQnhImhWWNTvqbKmi3KGJHyaG42XuqiPVq30SvTzLaoa3OYn6EisD+a3CICL1LK8xsmM8APUgJGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFi3AUvs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFi3AUvs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 924CBC4CEE8;
	Tue, 25 Mar 2025 06:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742885658;
	bh=77DQRojoYWf5m2oCtXQuAg5HNyWuTE3SfSPulFwVz/w=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=JFi3AUvssyipf+pEiWE4L2ZEhYlWxHOe96kSxSL3rif7TtZu9CoAz+PUQT2x7IZ31
	 APzz9UPOT+wKXSlIBmbLwgAJYAkgvspvl5RM4Vcyq2+b/FTxWKK1Hvij8SLJocXn2O
	 /OjSAzpCwxH38CrxWUqmM1aiowQfOiVeFfw+K0I5bLwIEimMFrXZLkuRI9httWDy7v
	 pGe4f8WAFZhejN7Epfe/aC1kxPo+DbzTEWNyI3WzwGtuXa/q8n+Xy1DbQH+3L1BILw
	 mA9CYt8Z4ktGdnujBM0AN99acB3HDIIcNEYLZBf+pVPkOBQ9Ro6N2Su5mcVTeG3ptf
	 ZyeWLlZhV0yHA==
Message-ID: <597972b3-7327-422d-962c-a7843eb0c516@kernel.org>
Date: Tue, 25 Mar 2025 14:54:15 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
 jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v4 6/6] f2fs/009: detect and repair nlink corruption
To: Zorro Lang <zlang@redhat.com>
References: <20250312072309.3989074-1-chao@kernel.org>
 <20250312072309.3989074-6-chao@kernel.org>
 <20250325010701.pe3u2qryvjwl6dpf@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250325010701.pe3u2qryvjwl6dpf@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/25/25 09:07, Zorro Lang wrote:
> On Wed, Mar 12, 2025 at 03:23:09PM +0800, Chao Yu wrote:
>> This is a regression test to check whether fsck can handle corrupted
>> nlinks correctly, it uses inject.f2fs to inject nlinks w/ wrong value,
>> and expects fsck.f2fs can detect such corruption and do the repair.
>>
>> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>> v4:
>> - remove unnecessary "_require_command fsck.f2fs"
>> - clean up _fixed_by_git_commit line
>> - fix to clean all tmp files in _cleanup
>>  tests/f2fs/009     | 147 +++++++++++++++++++++++++++++++++++++++++++++
>>  tests/f2fs/009.out |   2 +
>>  2 files changed, 149 insertions(+)
>>  create mode 100755 tests/f2fs/009
>>  create mode 100644 tests/f2fs/009.out
>>
>> diff --git a/tests/f2fs/009 b/tests/f2fs/009
>> new file mode 100755
>> index 00000000..9120d8a5
>> --- /dev/null
>> +++ b/tests/f2fs/009
>> @@ -0,0 +1,147 @@
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
> 
> Hi Chao,
> 
> Which package provides this "socket" command? I tried to search it in Fedora, but
> got nothing:
> 
>   # yum search */socket
>   Updating and loading repositories:
>    Fedora - Rawhide - Developmental packages for the next Fedora release                                              100% |  19.1 KiB/s |  23.6 KiB |  00m01s
>    Fedora - Rawhide - Developmental packages for the next Fedora release                                              100% | 694.7 KiB/s |   6.9 MiB |  00m10s
>   Repositories loaded.
>   No matches found.
> 
> If it's a program by yourself, we might can put it in xfstests/src/socket.c?

Hi Zorro,

It's not a program from me, I just installed it w/ "sudo apt install socket", can
you try that?

Thanks,

> 
> Thanks,
> Zorro
> 
>> +	_notrun "Couldn't find socket"
>> +fi
>> +
>> +_require_scratch
>> +_require_command "$F2FS_INJECT_PROG" inject.f2fs
>> +
>> +_fixed_by_git_commit f2fs-tools 958cd6e \
>> +	"fsck.f2fs: support to repair corrupted i_links"
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
>> +	cd /
>> +	rm -r -f $tmp.*
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

