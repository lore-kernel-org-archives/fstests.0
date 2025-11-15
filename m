Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C67F223705
	for <fstests@vger.kernel.org>; Sat, 15 Nov 2025 11:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763204717; cv=none; b=nD0PDQZ8VfzgoVatya4O6mxsuep3dmK21MzzRjAHXAlmfX4ZWCL1A4IdzAJLVULD6GpVWiQm+SS9QlXx/fXS1XU506bukVQ0IAKrk9beInwKUPCYPbYoO1cRSbDRidjAIZeS2/4WhOv6z6JMHHIhEYkxUD36KWnNWhJeBtyXW7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763204717; c=relaxed/simple;
	bh=wv6mgh+kzfj6wzOS0QnoBuZeGvhZ6vyvwt5HlFGQS38=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=A+cnqVWOAOawgRLJjaf7eEyVwZu2nEPUF0Uw3t1UcHZCkHhJ3XS6YQq01ybH1mL1AaUAZfHYcuIL/ZgXOxnoCKQfyjkeQEGvvMaKRulNc2hLXY3uYclBmKcmHPJcBgFT8GfoL1h7EzbWDnOVKyb1kSDrQCZHBF3BckMVbZvxukc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IkiEysFp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IkiEysFp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF7DC116B1;
	Sat, 15 Nov 2025 11:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763204716;
	bh=wv6mgh+kzfj6wzOS0QnoBuZeGvhZ6vyvwt5HlFGQS38=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=IkiEysFpCtXoG6TfUi0+AUts5cGO9IFGCoFRq9io1PYX1y7GtSVBQFV3CAMIwzEMQ
	 5XJBGjPppQF8Of4xrsUdwf7GNy4l6to6ZPq0hSzgXbaW5WmPRnLF8DXRoYRAzk1n1D
	 ZZHoALIdtGbv2pw8dZNzHWECI/MQRLNEZKV/tdzzKtLYZiygP0DcSpE33Hy561GS4/
	 TKybjvYdMLMuyjfozs6cqtJ8+xBAjfiwQKH6e0U8LMIQdfIAdvwTcbsQ8GtPkazCS/
	 udkgT5cFYHkrRj4Tlgebd8JNzWxmvqxXtmts6EW5uvXV4KFrttglIXjfKRfRYO9e0l
	 GhhwslCCibLgQ==
Message-ID: <b15d2439-4d4a-4522-906c-c3d9df716d92@kernel.org>
Date: Sat, 15 Nov 2025 19:05:14 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
 jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v2] f2fs/023: test sanity check condition w/ error
 injection
To: Zorro Lang <zlang@redhat.com>
References: <20251103062143.2657116-1-chao@kernel.org>
 <20251115081811.iebaqc2ubh7li3ux@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20251115081811.iebaqc2ubh7li3ux@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/15/2025 4:18 PM, Zorro Lang wrote:
> On Mon, Nov 03, 2025 at 02:21:43PM +0800, Chao Yu wrote:
>> After commit 5c1768b67250 ("f2fs: fix to do sanity check correctly on
>> i_inline_xattr_size"), f2fs should handle corrupted i_inline_xattr_size
>> correctly, let's add this regression testcase to check that.
>>
>> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>> v2:
>> - use _filter_scratch to filter scratch mountpoint
>> - check output message of inject.f2fs rather than return value
>> - add _require_attrs
>> - add f2fs/023 to attr group
>> - fail testcase if mkfs failed
>>   tests/f2fs/023     | 49 ++++++++++++++++++++++++++++++++++++++++++++++
>>   tests/f2fs/023.out |  2 ++
>>   2 files changed, 51 insertions(+)
>>   create mode 100755 tests/f2fs/023
>>   create mode 100644 tests/f2fs/023.out
>>
>> diff --git a/tests/f2fs/023 b/tests/f2fs/023
>> new file mode 100755
>> index 00000000..33108421
>> --- /dev/null
>> +++ b/tests/f2fs/023
>> @@ -0,0 +1,49 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2025 Chao Yu <chao@kernel.org>
>> +#
>> +# FS QA Test No. f2fs/023
>> +#
>> +# This testcase tries to inject fault into inode.i_inline_xattr_size,
>> +# and check whether sanity check of f2fs can handle fault correctly.
>> +#
>> +
>> +. ./common/preamble
>> +. ./common/attr
>> +. ./common/filter
>> +_begin_fstest auto quick rw attr
>> +
>> +_fixed_by_kernel_commit 5c1768b67250 \
>> +        "f2fs: fix to do sanity check correctly on i_inline_xattr_size"
>> +
>> +_require_attrs
>> +_require_scratch_nocheck
>> +_require_inject_f2fs_command node i_inline
>> +_require_inject_f2fs_command node i_inline_xattr_size
>> +
>> +testfile=$SCRATCH_MNT/testfile
>> +
>> +# remove all mkfs options to avoid layout change of on-disk inode
>> +export MKFS_OPTIONS=""
>> +
>> +_scratch_mkfs "-O extra_attr,flexible_inline_xattr" >> $seqres.full || _fail "mkfs failed"
>> +_scratch_mount "-o inline_xattr_size=512" >>$seqres.full 2>&1
>> +touch $testfile
>> +_scratch_unmount
>> +
>> +# inject .i_inline field: clear F2FS_EXTRA_ATTR bit
>> +output=`$F2FS_INJECT_PROG --node --mb i_inline --nid 4 --val 0x1 $SCRATCH_DEV`
>> +echo "$output" >> $seqres.full
>> +echo "$output" | grep "unknown or unsupported member" && _fail "i_inline is unsupported"
>> +
>> +# inject .i_inline_xattr_size field from 512 to 2048
>> +output=`$F2FS_INJECT_PROG --node --mb i_inline_xattr_size --nid 4 --val 2048 $SCRATCH_DEV`
>> +echo "$output" >> $seqres.full
>> +echo "$output" | grep "unknown or unsupported member" && _fail "i_inline_xattr_size is unsupported"
> 
> I think we might need a common helper to do f2fs injection and return
> error if injection fails, if F2FS_INJECT_PROG always can't return error

Yes, let me find free slot to clean up, thanks for the suggestion and
review. :)

Thanks.

> properly. Anyway, that's another story. For this patch:
> 
> Reviewed-by: Zorro Lang <zlang@redhat.com>
> 
>> +
>> +_scratch_mount
>> +
>> +$GETFATTR_PROG -n user.test "$testfile" 2>&1 | _filter_scratch
>> +
>> +status=0
>> +exit
>> diff --git a/tests/f2fs/023.out b/tests/f2fs/023.out
>> new file mode 100644
>> index 00000000..f9635d38
>> --- /dev/null
>> +++ b/tests/f2fs/023.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 023
>> +getfattr: SCRATCH_MNT/testfile: Structure needs cleaning
>> -- 
>> 2.49.0
>>
> 

