Received: from mx0.herbolt.com (mx0.herbolt.com [5.59.97.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FAA271443
	for <fstests@vger.kernel.org>; Thu, 14 May 2026 08:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.59.97.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778746618; cv=none; b=Ca3hIkLc1hzDfz7iijMKiZ1MrRL8fVfMVhKVH5jOLTg8dJXgQHlBJnWZeujhBfh6TsBrZWmDjc84U24DYfx0VvmhiD6tbvocSe9/6OmEThXz5h/rIl2q6Jz+8DkmnFWjHxmK7hP3LJ8TpS/2+S+kjTmoPXFjc/zWXDeGT3AFF8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778746618; c=relaxed/simple;
	bh=h2g457N1zmNrCvzex5mROjyH2sRjkzfN9bugTUvnZIc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=ek2+azbc+V1AJTSPR5F1mWNwqD8x9pk72SpNO7wQ+BHP5oIAaQbX1/+Bp14/rZ6AW42eByWClnTx0hqIdS6TAJzLwh4SV4l/JxWDZk1syEDCDAA4hvZzFpPzz/pcWaYkYwWkNJU4lGKiDZmQ49FDQj+8ABEZ42sTjV+ogWjX3SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herbolt.com; spf=pass smtp.mailfrom=herbolt.com; arc=none smtp.client-ip=5.59.97.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herbolt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbolt.com
Received: from mx0.herbolt.com (localhost [127.0.0.1])
	by mx0.herbolt.com (Postfix) with ESMTP id 6EBC3180F2D5;
	Thu, 14 May 2026 10:11:08 +0200 (CEST)
Received: from mail.herbolt.com ([172.168.31.10])
	by mx0.herbolt.com with ESMTPSA
	id MwJGE5yDBWq5XCoAKEJqOA
	(envelope-from <lukas@herbolt.com>); Thu, 14 May 2026 10:11:08 +0200
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 14 May 2026 10:11:08 +0200
From: Lukas Herbolt <lukas@herbolt.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 4/4] xfs/216 xfs/217 Use default -l conccurency=0 on
 mkfs.xfs that supports it
In-Reply-To: <20260430163635.GS7739@frogsfrogsfrogs>
References: <20260430131317.693845-2-lukas@herbolt.com>
 <20260430131317.693845-10-lukas@herbolt.com>
 <20260430163635.GS7739@frogsfrogsfrogs>
Message-ID: <fdd0ad038e8fd68a0d4fc2af3d3e04e6@herbolt.com>
X-Sender: lukas@herbolt.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

On 2026-04-30 18:36, Darrick J. Wong wrote:
> On Thu, Apr 30, 2026 at 03:13:22PM +0200, Lukas Herbolt wrote:
>> The XFS conccurency optimalization breaks the log sizing check on
> 
> "concurrency optimization"
> 
>> systems with non-rotational disks and high amount of CPUs. Default to
>> the old behavior with -l conccurency=0 and with -d concurrency=0.
> 
> "-l concurrency=0"
> 
>> Signed-off-by: Lukas Herbolt <lukas@herbolt.com>
>> ---
>>  tests/xfs/216 |  9 +++++++--
>>  tests/xfs/217 | 17 +++++++++++++++--
>>  2 files changed, 22 insertions(+), 4 deletions(-)
>> 
>> diff --git a/tests/xfs/216 b/tests/xfs/216
>> index 091c11d08642..8b4610d5a0a6 100755
>> --- a/tests/xfs/216
>> +++ b/tests/xfs/216
>> @@ -21,14 +21,19 @@ _cleanup()
>>  }
>> 
>>  _require_scratch
>> -_scratch_mkfs_xfs >/dev/null 2>&1
>> +if _scratch_mkfs_supports_concurrency -l >> $seqres.full 2>&1; then
>> +	_scratch_mkfs_xfs -l concurrency=0 >/dev/null 2>&1
>> +	loop_mkfs_opts="-l concurrency=0"
>> +else
>> +	_scratch_mkfs_xfs >/dev/null 2>&1
>> +	loop_mkfs_opts=
>> +fi
>>  _scratch_mount
>> 
>>  _require_loop
>>  LOOP_IMG=$SCRATCH_MNT/test_fs
>>  LOOP_MNT=$SCRATCH_MNT/test_fs_dir
>> 
>> -loop_mkfs_opts=
>>  $MKFS_XFS_PROG 2>&1 | grep -q rmapbt && \
>>  	loop_mkfs_opts="$loop_mkfs_opts -m rmapbt=0"
>>  $MKFS_XFS_PROG 2>&1 | grep -q reflink && \
>> diff --git a/tests/xfs/217 b/tests/xfs/217
>> index dae6ce55f475..7c7b33b1ccf7 100755
>> --- a/tests/xfs/217
>> +++ b/tests/xfs/217
>> @@ -20,7 +20,20 @@ _cleanup()
>>  }
>> 
>>  _require_scratch
>> -_scratch_mkfs_xfs >/dev/null 2>&1
>> +if _scratch_mkfs_supports_concurrency -l >> $seqres.full 2>&1; then
>> +	_scratch_mkfs_xfs -l concurrency=0 >/dev/null 2>&1
> 
> Why does the scratch fs need a -lconcurrency option?
Yeah right it does not need it. Wanted to be sure we do not run into
-ENOSPC but on recommended 10G SCRATCH_DEV we should not.

> 
>> +	loop_mkfs_opts="-l concurrency=0"
>> +		if _scratch_mkfs_supports_concurrency -d >> $seqres.full 2>&1; then
>> +			# We could go just with -l concurency but then on 512CPUs
>> +			# it gives log size off by one block so better to set
>> +			# -d concurrency to 0.
>> +			loop_mkfs_opts="$loop_mkfs_opts -d concurrency=0"
> 
> concurrency= was added for -d and -l in the same release (6.7) so you
> don't have to test them separately.
Just wanted to be sure as those still came in different commits.
> 
> --D
> 
>> +
>> +		fi
>> +else
>> +	_scratch_mkfs_xfs >/dev/null 2>&1
>> +	loop_mkfs_opts=
>> +fi
>>  _scratch_mount
>>  # 16T mkfs requires a bit over 2G free
>>  _require_fs_space $SCRATCH_MNT 2202000
>> @@ -34,7 +47,7 @@ _do_mkfs()
>>  	for i in $*; do
>>  		echo -n "fssize=${i}g "
>>  		$MKFS_XFS_PROG -f -b size=4096 -l version=2 \
>> -			-d size=${i}g $loop_dev |grep log
>> +			-d size=${i}g $loop_dev $loop_mkfs_opts |grep log
>>  		_mount $loop_dev $LOOP_MNT
>>  		echo "test write" > $LOOP_MNT/test
>>  		_unmount $LOOP_MNT > /dev/null 2>&1
>> --
>> 2.53.0
>> 
>> 

-- 
-lhe
