Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E8031986D
	for <fstests@vger.kernel.org>; Fri, 15 Aug 2025 08:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755244939; cv=none; b=AzppHXhBG+lydEtqfiMart/WSImJ5BXY0s1Kd5ccorjDcm1KWVBzDhR24b6nC3bdh0I6mh7OxLPtph78um7mApja8+TRVAGUGqrZzD7l2LS+Q0FmrblUAGgnQ7AoI6zdAs3odJDIOJeyRJ0WMGqzQ5nGD6vQq2E/wtZ7zzphA74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755244939; c=relaxed/simple;
	bh=UqMlmB6aIlDbiFKHI3lMYWxu0bnYqjVX62W5hnkci3M=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RbwONhSBcq1Wkk4SIcpZ/gWhDTnp7xU26SkFEAquA9F0QRouh38fGD7zyaiRMVwNAs06QjA2lyKztzhwRu8FDmDqONxu+BAwHwlpmYDPrCAtQVXYr/qrRTNrorfahjbBrlaOkl1puYXEDFs3Z65CwYj633ObsuCUymGJVCujuEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Is2lKH6r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Is2lKH6r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88187C4CEEB;
	Fri, 15 Aug 2025 08:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755244935;
	bh=UqMlmB6aIlDbiFKHI3lMYWxu0bnYqjVX62W5hnkci3M=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Is2lKH6rISoJW5rHQ3qyMjwO+boP8zmQwf5O66nHIuxwy9fHzjoHKm2Gs460xCwaQ
	 iBCXvmgXqauAWcx+AqiXMTL2RHULBulqRcdYvWIg6nnHYk3os82XVqmoY9pkO28U5S
	 LfTSNe/XlSpz4o81a7aoE1B3jxMTBSHHH/CqPTjZQfDE2dezKb5Ov3tt3DfqFIdzEy
	 +r2lUwyqQ4htEj20WBW+l8rPC/EzOXXeMXo5eZAJONDQgTf7KA7UFh9QvI/lOPPm33
	 Ig8xZw8raE4e3PT7GEYDT7aOwood21FnGFCvuYLHfQqJpry3cundVc0KTWdw6LUpMK
	 LQREPeZO7goRA==
Message-ID: <40587d4a-44a2-4d82-9f9f-2934c52aba87@kernel.org>
Date: Fri, 15 Aug 2025 16:02:12 +0800
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
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250814211838.64o3q3jurbxvwp3a@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/15/25 05:18, Zorro Lang wrote:
> On Thu, Aug 14, 2025 at 05:07:12PM +0800, Chao Yu wrote:
>> This is a regression test:
>> 1. create directory
>> 2. add a new xattr entry to create xattr node
>> 3. use inject.f2fs to inject nid of xattr node w/ ino in a file
>> 4. check whether f2fs kernel module will detect and report such
>>    corruption in the file
>>
>> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>> v3:
>> - use _require_scratch_nocheck instead of _require_scratch
>> - add missing _require_attrs user
>> - add comments for why exporting MKFS_OPTIONS=""
>>  tests/f2fs/020     | 51 ++++++++++++++++++++++++++++++++++++++++++++++
>>  tests/f2fs/020.out |  2 ++
>>  2 files changed, 53 insertions(+)
>>  create mode 100755 tests/f2fs/020
>>  create mode 100644 tests/f2fs/020.out
>>
>> diff --git a/tests/f2fs/020 b/tests/f2fs/020
>> new file mode 100755
>> index 00000000..7ce1f92f
>> --- /dev/null
>> +++ b/tests/f2fs/020
>> @@ -0,0 +1,51 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2025 Chao Yu.  All Rights Reserved.
>> +#
>> +# FS QA Test No. f2fs/020
>> +#
>> +# This is a regression test:
>> +# 1. create directory
>> +# 2. add a new xattr entry to create xattr node
>> +# 3. use inject.f2fs to inject nid of xattr node w/ ino in a file
>> +# 4. check whether f2fs kernel module will detect and report such
>> +#    corruption in the file
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto quick rw
>> +
>> +. ./common/attr
>> +
>> +_fixed_by_kernel_commit 061cf3a84bde \
>> +	"f2fs: fix to do sanity check on ino and xnid"
>> +
>> +_require_scratch_nocheck
>> +_require_command "$F2FS_INJECT_PROG" inject.f2fs
>> +_require_attrs user
>> +
>> +# remove all mkfs options to avoid layout change of on-disk inode
>> +export MKFS_OPTIONS=""
>> +
>> +testdir=$SCRATCH_MNT/testdir
>> +
>> +_scratch_mkfs >> $seqres.full
>> +_scratch_mount "-o user_xattr,noinline_xattr"
>> +
>> +mkdir $testdir
>> +# add a new xattr entry to create xattr node
>> +$SETFATTR_PROG -n user.abc -v 123 $testdir
>> +
>> +_scratch_unmount
>> +
>> +# inject i_xattr_nid w/ nid of inode node
>> +$F2FS_INJECT_PROG --node --mb i_xattr_nid --nid 4 --val 4 $SCRATCH_DEV >> $seqres.full

Zorro, I missed one thing, this testcase relies on a f2fs-tools patch, please apply
this before running the testcase.

https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-tools.git/commit/?h=dev-test&id=2174461cdd0a22edc5e7d172605bff4740582438

Do I need to create a _require_* function for f2fs to verify whether f2fs-tools
support the required feature or not?

>> +
>> +_scratch_mount

Oh, I may missed to add "-o acl,user_xattr" here.

>> +# may potentially trigger a deadlock w/ double inode_lock on parent's inode
>> +mkdir $testdir/dir >> $seqres.full 2>&1
>> +_scratch_unmount
> 
> Can you provide a test result to prove this test case trigger a failure
> on general kernel (not debug kernel). If it can, then this version is good
> to me :)

Well, expectation is it will hang kernel, so that the f2fs/020 will stop here
once we encounter the issue.

Thanks,

> 
> Thanks,
> Zorro
> 
>> +
>> +echo "Silence is golden"
>> +
>> +status=0
>> +exit
>> diff --git a/tests/f2fs/020.out b/tests/f2fs/020.out
>> new file mode 100644
>> index 00000000..20d7944e
>> --- /dev/null
>> +++ b/tests/f2fs/020.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 020
>> +Silence is golden
>> -- 
>> 2.49.0
>>
> 

