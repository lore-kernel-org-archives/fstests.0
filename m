Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118EA27453
	for <fstests@vger.kernel.org>; Sat, 16 Aug 2025 07:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755328089; cv=none; b=eiR4t5PI5RDdi2AQ7i0mYQ4xv//deO6WDcCX3bO77sH8rROP6dwlMA83chTzUbTqx/ivHXuVfHxdJuRsigwXPWS/7NVLsqKxgi4I9RD7wxsBKu6vDFLdv49+jLhjOKKjPEyo1jF7yp26ZYU2zMzzyPvPeMywLdvBON43MmtE2JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755328089; c=relaxed/simple;
	bh=oB/06TCALlLhR3Djel57KDCw7IXYRM/va8rb6sfQzRY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aCK2RcrrFQXWwDWJj7JKsQrwdfFlOyO+8QJ5vYKOVibrmPdU2K15NOUhxNm8yWfWI8WTkGsx21pJZHGyhnCc6WVvcrBr83n+7UbtwENFDIckFselC+hpEIKc5sbpdStYu1u8l0eMAECTU2V1lEGmXVUpcQ+22MEwj5BPfYZ2VIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxRZOmCC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxRZOmCC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A2CFC4CEEF;
	Sat, 16 Aug 2025 07:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755328088;
	bh=oB/06TCALlLhR3Djel57KDCw7IXYRM/va8rb6sfQzRY=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=oxRZOmCCrhap1jYYMcHfYCsI9Ff01JWqD+cRI4JfHQOcFHvKBh2OcjP3WnmzNIorl
	 BjP7IOgBr0BdXjUIQaoVyCl5QewUgNaMIIa4B0FNx4pm/jAYdWxkrIojaEilyUsNf9
	 ULQtB839OfXNurmNlWf1j6m3Th1ip+UCOBfef2NDIwJumzIj4ALachwD51hkt593ay
	 lyOlWOHLLEzSgUe2rgVV/8rXNzowixtOxipMVJ6Ez3TGpVabEzJi7ui5H0/rdOX/ZX
	 lGw/fNJU7b2vQbCzMgPfRmQ6t3OfSlfMjlhEljcAZhCWp5itfkZMTuQ0J9rkx6LH1+
	 rQVq/0dPTtyKg==
Message-ID: <89f49625-467b-4871-b8db-cceeeba9bf76@kernel.org>
Date: Sat, 16 Aug 2025 15:08:03 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
 jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v2 3/3] f2fs/020: do sanity check on i_xattr_nid
To: Zorro Lang <zlang@redhat.com>
References: <20250814090712.2119455-1-chao@kernel.org>
 <20250814090712.2119455-3-chao@kernel.org>
 <20250814211838.64o3q3jurbxvwp3a@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <40587d4a-44a2-4d82-9f9f-2934c52aba87@kernel.org>
 <20250815151240.aie4fcudoglxvlh5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250815151240.aie4fcudoglxvlh5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/8/15 23:12, Zorro Lang wrote:
> On Fri, Aug 15, 2025 at 04:02:12PM +0800, Chao Yu wrote:
>> On 8/15/25 05:18, Zorro Lang wrote:
>>> On Thu, Aug 14, 2025 at 05:07:12PM +0800, Chao Yu wrote:
>>>> This is a regression test:
>>>> 1. create directory
>>>> 2. add a new xattr entry to create xattr node
>>>> 3. use inject.f2fs to inject nid of xattr node w/ ino in a file
>>>> 4. check whether f2fs kernel module will detect and report such
>>>>     corruption in the file
>>>>
>>>> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
>>>> Signed-off-by: Chao Yu <chao@kernel.org>
>>>> ---
>>>> v3:
>>>> - use _require_scratch_nocheck instead of _require_scratch
>>>> - add missing _require_attrs user
>>>> - add comments for why exporting MKFS_OPTIONS=""
>>>>   tests/f2fs/020     | 51 ++++++++++++++++++++++++++++++++++++++++++++++
>>>>   tests/f2fs/020.out |  2 ++
>>>>   2 files changed, 53 insertions(+)
>>>>   create mode 100755 tests/f2fs/020
>>>>   create mode 100644 tests/f2fs/020.out
>>>>
>>>> diff --git a/tests/f2fs/020 b/tests/f2fs/020
>>>> new file mode 100755
>>>> index 00000000..7ce1f92f
>>>> --- /dev/null
>>>> +++ b/tests/f2fs/020
>>>> @@ -0,0 +1,51 @@
>>>> +#! /bin/bash
>>>> +# SPDX-License-Identifier: GPL-2.0
>>>> +# Copyright (c) 2025 Chao Yu.  All Rights Reserved.
>>>> +#
>>>> +# FS QA Test No. f2fs/020
>>>> +#
>>>> +# This is a regression test:
>>>> +# 1. create directory
>>>> +# 2. add a new xattr entry to create xattr node
>>>> +# 3. use inject.f2fs to inject nid of xattr node w/ ino in a file
>>>> +# 4. check whether f2fs kernel module will detect and report such
>>>> +#    corruption in the file
>>>> +#
>>>> +. ./common/preamble
>>>> +_begin_fstest auto quick rw
>>>> +
>>>> +. ./common/attr
>>>> +
>>>> +_fixed_by_kernel_commit 061cf3a84bde \
>>>> +	"f2fs: fix to do sanity check on ino and xnid"
>>>> +
>>>> +_require_scratch_nocheck
>>>> +_require_command "$F2FS_INJECT_PROG" inject.f2fs
>>>> +_require_attrs user
>>>> +
>>>> +# remove all mkfs options to avoid layout change of on-disk inode
>>>> +export MKFS_OPTIONS=""
>>>> +
>>>> +testdir=$SCRATCH_MNT/testdir
>>>> +
>>>> +_scratch_mkfs >> $seqres.full
>>>> +_scratch_mount "-o user_xattr,noinline_xattr"
>>>> +
>>>> +mkdir $testdir
>>>> +# add a new xattr entry to create xattr node
>>>> +$SETFATTR_PROG -n user.abc -v 123 $testdir
>>>> +
>>>> +_scratch_unmount
>>>> +
>>>> +# inject i_xattr_nid w/ nid of inode node
>>>> +$F2FS_INJECT_PROG --node --mb i_xattr_nid --nid 4 --val 4 $SCRATCH_DEV >> $seqres.full
>>
>> Zorro, I missed one thing, this testcase relies on a f2fs-tools patch, please apply
>> this before running the testcase.
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-tools.git/commit/?h=dev-test&id=2174461cdd0a22edc5e7d172605bff4740582438
>>
>> Do I need to create a _require_* function for f2fs to verify whether f2fs-tools
>> support the required feature or not?
> 
> Actually for further f2fs testing (depends on injection), we'd better to have related
> functions, you can refer to:
> 
> _require_xfs_db_command
> 
> Or more xfs_db related functions in common/xfs if you need.

Thanks for the information.

> 
> If you don't want to add this _require_ function in this patch (this's not the only
> one f2fs case uses inject.f2fs), I think you can send another patchset to do that
> later (just let this case fails on old f2fs temporarily :).

Okay, will introduce _require_ function in separated patch. :)

Thanks,

> 
> Thanks,
> Zorro
> 
>>
>>>> +
>>>> +_scratch_mount
>>
>> Oh, I may missed to add "-o acl,user_xattr" here.
>>
>>>> +# may potentially trigger a deadlock w/ double inode_lock on parent's inode
>>>> +mkdir $testdir/dir >> $seqres.full 2>&1
>>>> +_scratch_unmount
>>>
>>> Can you provide a test result to prove this test case trigger a failure
>>> on general kernel (not debug kernel). If it can, then this version is good
>>> to me :)
>>
>> Well, expectation is it will hang kernel, so that the f2fs/020 will stop here
>> once we encounter the issue.
>>
>> Thanks,
>>
>>>
>>> Thanks,
>>> Zorro
>>>
>>>> +
>>>> +echo "Silence is golden"
>>>> +
>>>> +status=0
>>>> +exit
>>>> diff --git a/tests/f2fs/020.out b/tests/f2fs/020.out
>>>> new file mode 100644
>>>> index 00000000..20d7944e
>>>> --- /dev/null
>>>> +++ b/tests/f2fs/020.out
>>>> @@ -0,0 +1,2 @@
>>>> +QA output created by 020
>>>> +Silence is golden
>>>> -- 
>>>> 2.49.0
>>>>
>>>
>>
> 

