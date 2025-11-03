Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66EA154BF5
	for <fstests@vger.kernel.org>; Mon,  3 Nov 2025 02:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762138302; cv=none; b=Y4W5IqTfzpGGit+/w6SLUunkymnhvKTIAqbNDK58wMoWCh+HGDAJ002kaml6mnfiDUEXCjiknntsr4EW9SxRbYd8pcFKLhRFWr/eHTwY32DSXICKqxBQtxrnHZl13W/tyw4M6WlGYAgTgOh6Y1DBwYIS+KRsjsAfiBitbwDGYNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762138302; c=relaxed/simple;
	bh=jDwsmy1ibnQ5xTuMCA0SpaJcHMYnkZi3RK21eJq1Ho0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=i5eaEgwnfyRO8hcMs8MNeVKu56BhptooNmKJY14sSX75t4BZam9nhmEyqUqOi/SGQwqXsB1h53kxyK/bJw4SguztRCgN1gUCI/5qMfjJo3Q0cqlrgsmmfkBpxCKiFSBO4GQc+WjDs9bEPl4ItA/bwuT5I8vBORe3nF4GyM2OIQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JyQCuJTl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JyQCuJTl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4166BC4CEF7;
	Mon,  3 Nov 2025 02:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762138302;
	bh=jDwsmy1ibnQ5xTuMCA0SpaJcHMYnkZi3RK21eJq1Ho0=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=JyQCuJTlWI0pRsk5/hEkkDuXBEvZVUcOjT4xRBGJgxF8aPa17aaeupOXIVRsg9nDV
	 Y43nHmrcEQYkPYoBJYBHg2E80aP0E4QIe6HgmyYT/0BQiCaLUaAufA0v2KwNvCCx6P
	 LKrlUVu9bjM2j+8sXxkhgogcSNJ3PHT7xj2W7ZnyHyewCOxK+OrV97J6D+XQ4skrJ8
	 w+vT1wWs9eomnI2JXrNDduNqE3/I3Ze/ekZABMejoPBlrM7wjWiS50JTQJhn3BeExM
	 sMcgiFZYHjVPg/7AsEGS0JSVJvvRHcj4pd/A/1Bl2XQkAq8gjG5AzTz9AgLGYBAR5B
	 CQGPipbexBQSQ==
Message-ID: <ac031bfd-efcc-4b75-b78e-74f80e7ee509@kernel.org>
Date: Mon, 3 Nov 2025 10:51:39 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
 jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH] f2fs/023: test sanity check condition w/ error injection
To: Zorro Lang <zlang@redhat.com>
References: <20251029115413.1085987-1-chao@kernel.org>
 <20251101152055.35zyuql6li2zzny7@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20251101152055.35zyuql6li2zzny7@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Zorro,

On 11/1/25 23:23, Zorro Lang wrote:
> On Wed, Oct 29, 2025 at 07:54:13PM +0800, Chao Yu wrote:
>> After commit 5c1768b67250 ("f2fs: fix to do sanity check correctly on
>> i_inline_xattr_size"), f2fs should handle corrupted i_inline_xattr_size
>> correctly, let's add this regression testcase to check that.
>>
>> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
> 
> Hi Chao,
> 
> Thanks for new test case for f2fs. Some review points as below :)
> 
>>  tests/f2fs/023     | 44 ++++++++++++++++++++++++++++++++++++++++++++
>>  tests/f2fs/023.out |  2 ++
>>  2 files changed, 46 insertions(+)
>>  create mode 100755 tests/f2fs/023
>>  create mode 100644 tests/f2fs/023.out
>>
>> diff --git a/tests/f2fs/023 b/tests/f2fs/023
>> new file mode 100755
>> index 00000000..d1b7df32
>> --- /dev/null
>> +++ b/tests/f2fs/023
>> @@ -0,0 +1,44 @@
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
>> +_begin_fstest auto quick rw
>> +
>> +_fixed_by_kernel_commit 5c1768b67250 \
>> +        "f2fs: fix to do sanity check correctly on i_inline_xattr_size"
>> +
>> +_require_scratch_nocheck
>> +_require_inject_f2fs_command node i_inline
>> +_require_inject_f2fs_command node i_inline_xattr_size
>> +
>> +testfile=$SCRATCH_MNT/testfile
>> +
>> +# remove all mkfs options to avoid layout change of on-disk inode
>> +export MKFS_OPTIONS=""
>> +
>> +_scratch_mkfs "-O extra_attr,flexible_inline_xattr" >> $seqres.full
> 
> As you use specific mkfs options, so better to _fail "..." if mkfs fails.
> 
>> +_scratch_mount "-o inline_xattr_size=512" >>$seqres.full 2>&1
>> +touch $testfile
>> +_scratch_unmount
>> +
>> +# inject .i_inline field: clear F2FS_EXTRA_ATTR bit
>> +$F2FS_INJECT_PROG --node --mb i_inline --nid 4 --val 0x1 $SCRATCH_DEV \
>> +		>>$seqres.full || _fail "failed to inject i_inline"
>> +
>> +# inject .i_inline_xattr_size field from 512 to 2048
>> +$F2FS_INJECT_PROG --node --mb i_inline_xattr_size --nid 4 --val 2048 $SCRATCH_DEV \
>> +		>>$seqres.full || _fail "failed to inject i_inline_xattr_size"
> 
> I found my system doesn't support i_inline_xattr_size,
> 
>   # inject.f2fs -V
>  inject.f2fs 1.16.0 (2025-08-12)
> 
> I tried to removed above "_require_inject_f2fs_command node i_inline_xattr_size",
> but I found this test didn't exit from above _fail. The .full file got:
> 
>   [inject_inode:833] unknown or unsupported member "i_inline_xattr_size"
> 
> So are you sure the $F2FS_INJECT_PROG return error if "failed to inject i_inline_xattr_size" :)

Oops, I found that inject.f2fs missed to return correct value for error case,
let me fix this.

In order to keep compatibility for old inject.f2fs tool, let me check output
instead of return value from inject.f2fs.

Let me know if you have any other concern.

> 
>> +
>> +_scratch_mount
>> +
>> +getfattr -n user.test "$testfile" 2>&1 | awk -F ': ' '/Structure needs cleaning/ { print $NF }'
> 
> As you need "user" attribute, so you need "_require_attrs" (. ./common/attr), also
> the test group should have "attr".
> 
> If you don't need _getfattr, please use $GETFATTR_PROG at least.
> 
> And how about replace the "awk" with "_filter_scratch" (. ./common/filter)

Thanks for all your comments, will fix them all in v2. :)

Thankss,

> 
> Thanks,
> Zorro
> 
>> +
>> +status=0
>> +exit
>> diff --git a/tests/f2fs/023.out b/tests/f2fs/023.out
>> new file mode 100644
>> index 00000000..7f16f33f
>> --- /dev/null
>> +++ b/tests/f2fs/023.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 023
>> +Structure needs cleaning
>> -- 
>> 2.49.0
>>
> 

