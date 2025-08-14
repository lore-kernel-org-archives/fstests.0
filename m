Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB51E2DF68
	for <fstests@vger.kernel.org>; Thu, 14 Aug 2025 07:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755158103; cv=none; b=QfoleeEPf3+4EzzT/B9QBmBDw+bNZTVlyYgKzX29BepKIQhmHRr0Wl4Ign6jkcsXchGPtU1LJE8Dh2fZOd+o96ooOTy/j2egHxjHSiv3rOCmTT0kVH4s9CNYSb5WkKDrdGejezvbNV3ZhZTXPZeDe825huKq617I+s/+qBKGBBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755158103; c=relaxed/simple;
	bh=+R5ii5QtDku8/p59rjrXRuQgAiYtx7BSX6EsEoxOyEs=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dHSxYPqPyWvrcOx3NCV6tSqajLtr8jmUkUJcuzDr582XCjdOTDgJGIbjuDqaYpHFVx+dkUgMkKo4Ew1NbogSORaepSsSzzx9BLWo9FaspTEwWKlcWj2OX9lKuyLIBxv38qozwHNF1WqM5HGw2h0IZEFSiTGMzYtPPMmAeIN8N24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhKXVrD8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhKXVrD8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F0AC4CEEF;
	Thu, 14 Aug 2025 07:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755158103;
	bh=+R5ii5QtDku8/p59rjrXRuQgAiYtx7BSX6EsEoxOyEs=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=FhKXVrD8HjRcyGyELP+W5eZDAHWFzYF4Jciyo4mZ1FYtoSuLzO7geuFPAXwoHvh9f
	 g9TDKMaGjJt7gCk0ESMNNGoAmPwTGZmQMovTldCp5AERzC9sYVGNuprE9k+dVcJEiQ
	 mn4KvJqY3OaZLF6IMkaDcKRAOgHW6efIpCm9MfcJ6asD+XODWc2uNxBVJ8ysp6CjXS
	 3MO+DNrbWxNzlg90vAChnWgmFWOV/UY4zDQFWTXDflj7qocgBkEkS8lup6TMvl3VUd
	 utjpOYa/KANxO3x5o1d2zXOHBjQhdw38jvyHhnHszpP1xQ3oPZ7sfa+4Jf585xUesh
	 u7a+8eRVaktHQ==
Message-ID: <580b6314-4c79-404c-b8cc-c3d416bc09e8@kernel.org>
Date: Thu, 14 Aug 2025 15:54:59 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
 jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 3/3] f2fs/020: do sanity check on i_xattr_nid
To: Zorro Lang <zlang@redhat.com>
References: <20250811094415.1053545-1-chao@kernel.org>
 <20250811094415.1053545-3-chao@kernel.org>
 <20250813153407.b2ldb3u3zuw4ckbs@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250813153407.b2ldb3u3zuw4ckbs@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/13/25 23:34, Zorro Lang wrote:
> On Mon, Aug 11, 2025 at 05:44:15PM +0800, Chao Yu wrote:
>> This is a regression test:
>> 1. create directory
>> 2. add a new xattr entry to create xattr node
>> 3. use inject.f2fs to inject nid of xattr node w/ ino in a file
>> 4. check whether f2fs kernel module will detect and report such
>>    corruption in the file
>>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>  tests/f2fs/020     | 50 ++++++++++++++++++++++++++++++++++++++++++++++
>>  tests/f2fs/020.out |  2 ++
>>  2 files changed, 52 insertions(+)
>>  create mode 100755 tests/f2fs/020
>>  create mode 100644 tests/f2fs/020.out
>>
>> diff --git a/tests/f2fs/020 b/tests/f2fs/020
>> new file mode 100755
>> index 00000000..a6a08c8f
>> --- /dev/null
>> +++ b/tests/f2fs/020
>> @@ -0,0 +1,50 @@
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
>> +_cleanup()
>> +{
>> +	_scratch_mkfs >> $seqres.full
>> +}
>> +
>> +_fixed_by_kernel_commit 061cf3a84bde \
>> +	"f2fs: fix to do sanity check on ino and xnid"
>> +
>> +export MKFS_OPTIONS=""
>> +_require_scratch
> 
> Same review points with patch 2/3, 
> 
>> +_require_command "$F2FS_INJECT_PROG" inject.f2fs
>> +
>> +testdir=$SCRATCH_MNT/testdir
>> +
>> +_scratch_mkfs >> $seqres.full
>> +_scratch_mount "-o user_xattr,noinline_xattr"
>> +
>> +mkdir $testdir
>> +# add a new xattr entry to create xattr node
>> +setfattr -n user.abc -v 123 $testdir
> 
> You can call `_require_attrs user` at first, then use "$SETFATTR_PROG"

Okay, will update them in v2.

> 
>> +
>> +_scratch_unmount
>> +
>> +# inject i_xattr_nid w/ nid of inode node
>> +$F2FS_INJECT_PROG --node --mb i_xattr_nid --nid 4 --val 4 $SCRATCH_DEV >> $seqres.full
>> +
>> +_scratch_mount
>> +mkdir $testdir/dir >> $seqres.full 2>&1
> 
> May I ask what kind of failure will this case hit, if there's the bug?

Bug like syzbot reported, you can check the details in below commit:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=061cf3a84bde

Thanks,

> 
> Thanks,
> Zorro
> 
>> +_scratch_unmount
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

