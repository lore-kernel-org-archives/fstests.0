Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC1A1CAA85
	for <fstests@vger.kernel.org>; Sun, 27 Apr 2025 08:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745742055; cv=none; b=X39fHmn+dMreH+MVB9HelopvxBrhrjkB4RCH8hny0uPychnbIeuUIrMGkrYrbNu50c2qtfhfCuC/IVZCVoZpp50r4FZFx1dT1BDgEmNNiq9ExM7DgsnymTt1KKnHWGHfHZZSsxVucgP3FEaktq3NYyiTj9bHEHKin8GTcaS50Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745742055; c=relaxed/simple;
	bh=fyOAcxErM964eVJSIxAeMZVFc+VzMfbujPvLX1vy89c=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CaALw/JBSSC7gra9URNVqVqHP8ZFl8z8w6Ouy0Uq6oe1l0j5z6auBKBGcuZZ0ngTiW+sKPg4VtBYbEkwEOalxjs63aB1XFbwPxMG5URYkIuDwToT9qlIdfwTIro1Il9wBU0WRu+3lx6H0bK8oPm3yKm9WnPSYau3/5enGgMRWe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uduejj0U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uduejj0U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51DACC4CEE3;
	Sun, 27 Apr 2025 08:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745742054;
	bh=fyOAcxErM964eVJSIxAeMZVFc+VzMfbujPvLX1vy89c=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Uduejj0USms0iyuxE2gNsfO3zmU6gOmFoYqAwIBH4EMndLiWtPp7G5gi4k8a02UIL
	 H7oB3Uz5huu6LXRPyVrPN8yxj5aKkOC+FUEhowZVwh5iZSb29G9YVcaJiCMAcrmXdt
	 l+DryPVvs6D1+NDaGKeAoZH4gOPIyaNpKc0CaO4H0R7m6a+Y1jJBSXdnSW2FDZ+oUC
	 dIioKwicoKHM4gd22ZgP3aGP7T55mWI8umImVDf3kEwVyTWJi5fYt3WO7FcadEiKyU
	 PhXGTcQcK97+3LpSDtKUkgUt2jx3CGw5+JoZ9u8VID18XlZACjrEUVBYevenGsxXfI
	 nuzQ4FUSEG8eg==
Message-ID: <90d349b5-5866-4486-8d93-a73f11ae2f9e@kernel.org>
Date: Sun, 27 Apr 2025 16:20:50 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
 jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v2] f2fs/011: test to check out-of-space issue
To: Zorro Lang <zlang@redhat.com>
References: <20250327055051.3827735-1-chao@kernel.org>
 <20250425141311.kgwsazvt6r65yfod@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250425141311.kgwsazvt6r65yfod@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/25/25 22:13, Zorro Lang wrote:
> On Thu, Mar 27, 2025 at 01:50:51PM +0800, Chao Yu wrote:
>> This is a regression testcase to check whether we will handle
>> out-of-space case correctly during fallocate() on pinned file
>> once we disable checkpoint.
>>
>> Testcase:
>> 1. mount f2fs w/ checkpoint=disable option
>> 2. create fragmented file data
>> 3. set flag w/ pinned flag
>> 4. fallocate space for pinned file, expects panic due to running
>> out of space.
>>
>> We should apply both commit ("f2fs: fix to avoid panic once
>> fallocation fails for pinfile") and commit ("f2fs: fix to avoid
>> running out of free segments") to avoid system panic.
>> Note that w/ these two commit, we fixed such issue in both
>> convential and zoned block device.
>>
>> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>> v2:
>> - clean up codes suggested by Zorro
>> - change output to expect ENOSPC error if we have applied fixes
> 
> Sorry I missed this V2, this version looks good to me. As there's not
> more review points from f2fs list, so I'd like to merge it:

Thank you, Zorro.

Could you please take a look at this new testcase?

https://lore.kernel.org/fstests/20250415093822.1100476-1-chao@kernel.org

Thanks,

> 
> Reviewed-by: Zorro Lang <zlang@redhat.com>
> 
>>  tests/f2fs/011     | 53 ++++++++++++++++++++++++++++++++++++++++++++++
>>  tests/f2fs/011.out |  2 ++
>>  2 files changed, 55 insertions(+)
>>  create mode 100755 tests/f2fs/011
>>  create mode 100644 tests/f2fs/011.out
>>
>> diff --git a/tests/f2fs/011 b/tests/f2fs/011
>> new file mode 100755
>> index 00000000..ec3d39ec
>> --- /dev/null
>> +++ b/tests/f2fs/011
>> @@ -0,0 +1,53 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2025 Chao Yu.  All Rights Reserved.
>> +#
>> +# FS QA Test No. f2fs/011
>> +#
>> +# This is a regression testcase to check whether we will handle
>> +# out-of-space case correctly during fallocate() on pinned file
>> +# once we disable checkpoint.
>> +# 1. mount f2fs w/ checkpoint=disable option
>> +# 2. create fragmented file data
>> +# 3. set flag w/ pinned flag
>> +# 4. fallocate space for pinned file, expects panic due to running
>> +# out of space
>> +# We should apply both commit ("f2fs: fix to avoid panic once
>> +# fallocation fails for pinfile") and commit ("f2fs: fix to avoid
>> +# running out of free segments") to avoid system panic.
>> +# Note that w/ these two commit, we fixed such issue in both
>> +# convential and zoned block device.
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto quick
>> +
>> +_fixed_by_kernel_commit 48ea8b200414 \
>> +	"f2fs: fix to avoid panic once fallocation fails for pinfile"
>> +_fixed_by_kernel_commit xxxxxxxxxxxx \
>> +	"f2fs: fix to avoid running out of free segments"
>> +
>> +_require_scratch
>> +_require_command "$F2FS_IO_PROG" f2fs_io
>> +
>> +_scratch_mkfs_sized $((1*1024*1024*1024)) >> $seqres.full
>> +_scratch_mount -o checkpoint=disable:10%
>> +
>> +pinfile=$SCRATCH_MNT/file
>> +
>> +# simulate fragment status in f2fs
>> +for ((i=0;i<256;i++)) do
>> +	$XFS_IO_PROG -f -c "pwrite 0 1m" $SCRATCH_MNT/$i >>$seqres.full
>> +done
>> +sync
>> +
>> +for ((i=0;i<256;i+=2)) do
>> +	rm -f $SCRATCH_MNT/$i
>> +done
>> +sync
>> +
>> +touch $pinfile
>> +$F2FS_IO_PROG pinfile set $pinfile >> $seqres.full
>> +$XFS_IO_PROG -c "falloc 0 $((3*256*1024*1024))" $pinfile
>> +
>> +status=0
>> +exit
>> diff --git a/tests/f2fs/011.out b/tests/f2fs/011.out
>> new file mode 100644
>> index 00000000..559c3fdf
>> --- /dev/null
>> +++ b/tests/f2fs/011.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 011
>> +fallocate: No space left on device
>> -- 
>> 2.49.0
>>
> 

