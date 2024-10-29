Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F061F4283
	for <fstests@vger.kernel.org>; Tue, 29 Oct 2024 07:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730187988; cv=none; b=lGXNejoXfqx7HzQR4hljt8/nFi5uB+Qtbf/SGKMI/ynwKIbsd8O6mNsgR2kI7whXiw6u+iiDYqowfBkbLajTc+bcnoOuW0hpDMbtTIc3If8bPQGO37u/V9QANHh6dxO86AfWhSxVqKPd1XZcrQjsNJ9xl3CG+hSithslnAQDSdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730187988; c=relaxed/simple;
	bh=zQtVqG+vUkM4/CWYayjQrQhLYYn7E++L0ZgAR1wc8pI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dbUkiMMmeq6PNGQnPrfD16XJgbuHPwjlLW2xBSR7DXeOHcJ5URksTHSTSaqtnRze2xnWebA3xuIqy+r3sDKTz1dG9RwtrUXi5F/kYZmTrHidk1Yh2RnbPYTbGuBNrcaY6v4AOFAZQYgLxgDaF4c3EzK+kCJJbD3W6cKywItVeOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0xeCrrQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0xeCrrQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F8D6C4CECD;
	Tue, 29 Oct 2024 07:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730187987;
	bh=zQtVqG+vUkM4/CWYayjQrQhLYYn7E++L0ZgAR1wc8pI=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=J0xeCrrQvz6Dj2/Nhp4X+yLfZTg9a6VYXCezOTrJJmtUCdAuQi0LzEv0sSlfAajR4
	 07BJ3joQwDFkdgzBv8H0jf45Z/5E68mD93dJnMIBEPeAVVjHz3BlcELtDacUD5zYvn
	 aQ79su9k94TXdWQ5yF3nRfkt4BtuEYfqI6PxJgvyeKNCjb0bh50yjh+cLly7GCTE7j
	 Q8h7PrA8GhRlXF4eU9M2ZIBLX5Qpmsytn4OhLNc2tCD/U5TipAVI2YDpT3OncMFZAd
	 5LVAGYoVeleVSBjGehb8yHBketzRlaERdU9axr6gQE1nVssBFUY0DBqSwIivyCqQkd
	 0pKhjcJyZ+qkA==
Message-ID: <324c9b1a-ca86-43a4-8c3a-990199c714bc@kernel.org>
Date: Tue, 29 Oct 2024 15:46:21 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, fstests@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v3 1/2] f2fs/006: add testcase to check out-of-space case
To: Zorro Lang <zlang@redhat.com>
References: <20241028141800.1788356-1-chao@kernel.org>
 <20241029060919.gxyywjp3gykaqnuc@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20241029060919.gxyywjp3gykaqnuc@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/29 14:09, Zorro Lang wrote:
> On Mon, Oct 28, 2024 at 10:17:59PM +0800, Chao Yu wrote:
>> This is a regression test to check whether f2fs handles dirty
>> data correctly when checkpoint is disabled, if lfs mode is on,
>> it will trigger OPU for all overwritten data, this will cost
>> free segments, so f2fs must account overwritten data as OPU
>> data when calculating free space, otherwise, it may run out
>> of free segments in f2fs' allocation function. If kernel config
>> CONFIG_F2FS_CHECK_FS is on, it will cause system panic, otherwise,
>> dd may encounter I/O error.
>>
>> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>> v3:
>> - explain more about behavior on kernel w/ different config
>> - use _filter_scratch to filter $SCRATCH_MNT
>>   tests/f2fs/006     | 42 ++++++++++++++++++++++++++++++++++++++++++
>>   tests/f2fs/006.out |  6 ++++++
>>   2 files changed, 48 insertions(+)
>>   create mode 100755 tests/f2fs/006
>>   create mode 100644 tests/f2fs/006.out
>>
>> diff --git a/tests/f2fs/006 b/tests/f2fs/006
>> new file mode 100755
>> index 00000000..f9560b2b
>> --- /dev/null
>> +++ b/tests/f2fs/006
>> @@ -0,0 +1,42 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2024 Oppo.  All Rights Reserved.
>> +#
>> +# FS QA Test No. f2fs/006
>> +#
>> +# This is a regression test to check whether f2fs handles dirty
>> +# data correctly when checkpoint is disabled, if lfs mode is on,
>> +# it will trigger OPU for all overwritten data, this will cost
>> +# free segments, so f2fs must account overwritten data as OPU
>> +# data when calculating free space, otherwise, it may run out
>> +# of free segments in f2fs' allocation function. If kernel config
>> +# CONFIG_F2FS_CHECK_FS is on, it will cause system panic, otherwise,
>> +# dd may encounter I/O error.
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto quick
>> +
>> +_fixed_by_kernel_commit xxxxxxxxxxxx \
>> +	"f2fs: fix to account dirty data in __get_secs_required()"
>> +
>> +# Import common functions.
>> +. ./common/filter
>> +
>> +_require_scratch
>> +_scratch_mkfs_sized $((1024*1024*100)) >> $seqres.full
>> +
>> +# use mode=lfs to let f2fs always triggers OPU
>> +_scratch_mount -o mode=lfs,checkpoint=disable:10%,noinline_dentry >> $seqres.full
>> +
>> +testfile=$SCRATCH_MNT/testfile
>> +
>> +dd if=/dev/zero of=$testfile bs=1M count=50 2>/dev/null
>> +
>> +# it may run out of free space of f2fs and hang kernel
>> +dd if=/dev/zero of=$testfile bs=1M count=50 conv=notrunc conv=fsync
>> +dd if=/dev/zero of=$testfile bs=1M count=50 conv=notrunc conv=fsync 2>&1 | _filter_scratch
>> +
>> +_scratch_remount checkpoint=enable
>> +
>> +status=0
>> +exit
>> diff --git a/tests/f2fs/006.out b/tests/f2fs/006.out
>> new file mode 100644
>> index 00000000..2dc9efda
>> --- /dev/null
>> +++ b/tests/f2fs/006.out
>> @@ -0,0 +1,6 @@
>> +QA output created by 006
>> +50+0 records in
>> +50+0 records out
>> +dd: error writing 'SCRATCH_MNT/testfile': No space left on device
>> +3+0 records in
>> +2+0 records out
> 
> Hi Chao,
> 
> One more question about this patch.
> 
> I'm wondering can this output always be matched? If the test doesn't care the dd output,
> you can filter out them, to avoid it break golden image. Especially the second one, can
> you be sure it always "3 in and 2 out" before returning ENOSPC?

Zorro,

I got your concern, how about using _check_dmesg to catch the kernel
bug instead? since once the bug was triggered, f2fs will call BUG_ON
or WARN_ON optionally anyway.

Thanks,

> 
> Thanks,
> Zorro
> 
>> -- 
>> 2.40.1
>>
> 

