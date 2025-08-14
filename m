Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8625C26E153
	for <fstests@vger.kernel.org>; Thu, 14 Aug 2025 07:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755157906; cv=none; b=pAqC50Vv9w+11eIDGrigilrEM5nDQU12UHij9tEVm0R5ZsUVwrnLXsYKa185BYr2dSz4CtH7brZLgX5EgpOqTr4ck6YDd20RkyWF99HZ/06oI9d7PcZLtaLHPyw9LLOfPj1yV0iicoXeu568yXRPP7qokAi/j4cnueJL4hU9nWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755157906; c=relaxed/simple;
	bh=5Ln9MzxQ3Dg1i3OIeQqZz8tEG6e+pOB2zjXzxmJHeDk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=g1COFOh4GU7SjSvX4QgFlbEzDpG4A3mI9fSa6qTsEgg9c751wZAqijFLtCAOyjJtJCNny4f+rGt43kHUg5HIhaDPy5FFKrs2RypZcvfm7ArlMA250xHH3SkhZoKkQP3lOVWTUTswW/vmew7FHWzr4j+hBR8GR2U8gbgKMX60Ffo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uBAw4MiJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uBAw4MiJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70519C4CEEF;
	Thu, 14 Aug 2025 07:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755157906;
	bh=5Ln9MzxQ3Dg1i3OIeQqZz8tEG6e+pOB2zjXzxmJHeDk=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=uBAw4MiJomHxJT/BDb5ICnFzpzoBypghNR0CLRdkxmfCBNDe0UY5ZCns0io8XGJK6
	 HP0Wlm91rfpo31byumU04O3VpcXVz03fb3DWs654GmcUuAsYtSNnkjBNbKu0Paf6vA
	 NkBX38iQGS43Y4DJ1dlVsltgyYirac2FVHeHAPe5KKjoAFkTqzLJab0WWK/CnyVTf6
	 hxBQU/eivZJqZ+22MgOm9yfM/Y1nRNWjHX7CT9z+mAE6YGAkXIM4CKhcponE1mTQkE
	 m3xxuph9d3XhEm3gUznvNh9awELBWuULVcKk/CslQ5zR6lRzn0LtxeHqM20Xpmcp26
	 XGNInnsu22jCQ==
Message-ID: <21c96ae0-44ee-4cc8-88f3-7d51cefb8f94@kernel.org>
Date: Thu, 14 Aug 2025 15:51:42 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
 jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 2/3] f2fs/019: do sanity check on mapping table
To: Zorro Lang <zlang@redhat.com>
References: <20250811094415.1053545-1-chao@kernel.org>
 <20250811094415.1053545-2-chao@kernel.org>
 <20250813152144.usxshpwpy2pqlovi@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250813152144.usxshpwpy2pqlovi@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/13/25 23:21, Zorro Lang wrote:
> On Mon, Aug 11, 2025 at 05:44:14PM +0800, Chao Yu wrote:
>> This is a regression test:
>> 1. create a file
>> 2. write file to create a direct node at special offset
>> 3. use inject.f2fs to inject nid of direct node w/ ino of the inode
>> 4. check whether f2fs kernel module will detect and report such
>>    corruption in the fil
>>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>  tests/f2fs/019     | 45 +++++++++++++++++++++++++++++++++++++++++++++
>>  tests/f2fs/019.out |  2 ++
>>  2 files changed, 47 insertions(+)
>>  create mode 100755 tests/f2fs/019
>>  create mode 100644 tests/f2fs/019.out
>>
>> diff --git a/tests/f2fs/019 b/tests/f2fs/019
>> new file mode 100755
>> index 00000000..0a02eb2f
>> --- /dev/null
>> +++ b/tests/f2fs/019
>> @@ -0,0 +1,45 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2025 Chao Yu.  All Rights Reserved.
>> +#
>> +# FS QA Test No. f2fs/019
>> +#
>> +# This is a regression test:
>> +# 1. create a file
>> +# 2. write file to create a direct node at special offset
>> +# 3. use inject.f2fs to inject nid of direct node w/ ino of the inode
>> +# 4. check whether f2fs kernel module will detect and report such
>> +#    corruption in the file
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto quick rw compress
>> +
>> +_cleanup()
>> +{
>> +	_scratch_mkfs >> $seqres.full
> 
> Why mkfs SCRATCH_DEV in _cleanup ?

Because SCRATCH_DEV will be corrupted after injection.

> 
>> +}
>> +
>> +_fixed_by_kernel_commit 77de19b6867f \
>> +	"f2fs: fix to avoid out-of-boundary access in dnode page"
>> +
>> +export MKFS_OPTIONS=""
> 
> Can you give it a comment about why we need to clean mkfs option at here?

Sure.

> 
>> +_require_scratch
> 
> Oh, if this case tends to have a corrupted SCRATCH_DEV, you can use
> _require_scratch_nocheck at here, don't need to mkfs in _cleanup.

Oh, my bad, you've mentioned the function on f2fs/012 once, but I forget to
use it in this testcase.

> 
>> +_require_command "$F2FS_INJECT_PROG" inject.f2fs
>> +
>> +testfile=$SCRATCH_MNT/testfile
>> +
>> +_scratch_mkfs >> $seqres.full
>> +_scratch_mount
>> +
>> +xfs_io -f -c "pwrite 3738M 1M" -c "fsync" $testfile >> $seqres.full
>    ^^^^^^
> $XFS_IO_PROG
> 
>> +
>> +_scratch_unmount
>> +
>> +$F2FS_INJECT_PROG --node --mb addr --nid 5 --idx 937 --val 4 $SCRATCH_DEV >> $seqres.full
>> +
>> +_scratch_mount
>> +xfs_io -c "pread 3700M 40M" $testfile
>    ^^^^^^
> $XFS_IO_PROG

Will update them in v2.

Thanks,

> 
>> +_scratch_unmount
>> +
>> +status=0
>> +exit
>> diff --git a/tests/f2fs/019.out b/tests/f2fs/019.out
>> new file mode 100644
>> index 00000000..2f7469e2
>> --- /dev/null
>> +++ b/tests/f2fs/019.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 019
>> +pread: Structure needs cleaning
>> -- 
>> 2.49.0
>>
> 

