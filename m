Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF511DE3C5
	for <fstests@vger.kernel.org>; Tue, 29 Oct 2024 10:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730196703; cv=none; b=ItMLEzUX3+3axhd/j3QGx1D06XrwjgSc1GDja534oslz1Sjxle8NOqpvGnNGonytQ4vin4g+9oew5OJZLecTYl7aBkkZxzLaPmoPuBPIIQKLQAJUNfZlTrtyCkHgoJvq5B9CQy58Hq3v4xJc0xwQjQegSHFwqwTi+nANIrhR1Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730196703; c=relaxed/simple;
	bh=BiaZqmDA5y1KrLYd+F5y0v/44itfzJjo5P3eIpyDVVA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iG3piBcsNf0jUArvuqq1WdnscZ15vNRVHFXZvkOUd6uzs9Rgd8i9Q7KHiDX93gytI+Yo+6Jitp+DvOrbpIVZRG51wugUhmmn+KyMxaFHtu3vqehXhFtv6fyKbTIta2dHlino0LpfQN7QZ5ryJLmhiePD/Pkx/xu+mSH4k56x+ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gbm8e0bX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gbm8e0bX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20141C4CECD;
	Tue, 29 Oct 2024 10:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730196703;
	bh=BiaZqmDA5y1KrLYd+F5y0v/44itfzJjo5P3eIpyDVVA=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Gbm8e0bXg+uXXdYKpK608ovcsotSM/oPYjnDzLQTnc3YKuerIboL6rqmIGoSACSpP
	 Q31oXbMzMQs23zh4tJtMQ46jsd2wSIrrqyedYZPM9gEwYe8co3pQ/xw/toyjkz/q4O
	 EvfB89TMm1H6QJa1sYCPv3rysXyHblDvRy4h0eX42I4Hnzua2Thlpj9CUtwM1wdTpN
	 cfj8vkiQ5jdPkdbD53+RqiCrUBURwYktHO+t/N8ClfNuJrX6gsEJlbzaPieTdYoVNb
	 8/S0EvI1ltDU9A38gG/DEUlvWhwaXWQQHgRlDRq6IDkEJtE5okanLqdHDXW9if/5ai
	 BWbG3D8+GV4Nw==
Message-ID: <f45acc4f-cf79-4063-9e9c-2f08441ba023@kernel.org>
Date: Tue, 29 Oct 2024 18:11:38 +0800
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
 <324c9b1a-ca86-43a4-8c3a-990199c714bc@kernel.org>
 <20241029085735.equs7ce55lcelgff@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20241029085735.equs7ce55lcelgff@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/29 16:57, Zorro Lang wrote:
> On Tue, Oct 29, 2024 at 03:46:21PM +0800, Chao Yu wrote:
>> On 2024/10/29 14:09, Zorro Lang wrote:
>>> On Mon, Oct 28, 2024 at 10:17:59PM +0800, Chao Yu wrote:
>>>> This is a regression test to check whether f2fs handles dirty
>>>> data correctly when checkpoint is disabled, if lfs mode is on,
>>>> it will trigger OPU for all overwritten data, this will cost
>>>> free segments, so f2fs must account overwritten data as OPU
>>>> data when calculating free space, otherwise, it may run out
>>>> of free segments in f2fs' allocation function. If kernel config
>>>> CONFIG_F2FS_CHECK_FS is on, it will cause system panic, otherwise,
>>>> dd may encounter I/O error.
>>>>
>>>> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
>>>> Signed-off-by: Chao Yu <chao@kernel.org>
>>>> ---
>>>> v3:
>>>> - explain more about behavior on kernel w/ different config
>>>> - use _filter_scratch to filter $SCRATCH_MNT
>>>>    tests/f2fs/006     | 42 ++++++++++++++++++++++++++++++++++++++++++
>>>>    tests/f2fs/006.out |  6 ++++++
>>>>    2 files changed, 48 insertions(+)
>>>>    create mode 100755 tests/f2fs/006
>>>>    create mode 100644 tests/f2fs/006.out
>>>>
>>>> diff --git a/tests/f2fs/006 b/tests/f2fs/006
>>>> new file mode 100755
>>>> index 00000000..f9560b2b
>>>> --- /dev/null
>>>> +++ b/tests/f2fs/006
>>>> @@ -0,0 +1,42 @@
>>>> +#! /bin/bash
>>>> +# SPDX-License-Identifier: GPL-2.0
>>>> +# Copyright (c) 2024 Oppo.  All Rights Reserved.
>>>> +#
>>>> +# FS QA Test No. f2fs/006
>>>> +#
>>>> +# This is a regression test to check whether f2fs handles dirty
>>>> +# data correctly when checkpoint is disabled, if lfs mode is on,
>>>> +# it will trigger OPU for all overwritten data, this will cost
>>>> +# free segments, so f2fs must account overwritten data as OPU
>>>> +# data when calculating free space, otherwise, it may run out
>>>> +# of free segments in f2fs' allocation function. If kernel config
>>>> +# CONFIG_F2FS_CHECK_FS is on, it will cause system panic, otherwise,
>>>> +# dd may encounter I/O error.
>>>> +#
>>>> +. ./common/preamble
>>>> +_begin_fstest auto quick
>>>> +
>>>> +_fixed_by_kernel_commit xxxxxxxxxxxx \
>>>> +	"f2fs: fix to account dirty data in __get_secs_required()"
>>>> +
>>>> +# Import common functions.
>>>> +. ./common/filter
>>>> +
>>>> +_require_scratch
>>>> +_scratch_mkfs_sized $((1024*1024*100)) >> $seqres.full
>>>> +
>>>> +# use mode=lfs to let f2fs always triggers OPU
>>>> +_scratch_mount -o mode=lfs,checkpoint=disable:10%,noinline_dentry >> $seqres.full
>>>> +
>>>> +testfile=$SCRATCH_MNT/testfile
>>>> +
>>>> +dd if=/dev/zero of=$testfile bs=1M count=50 2>/dev/null
>>>> +
>>>> +# it may run out of free space of f2fs and hang kernel
>>>> +dd if=/dev/zero of=$testfile bs=1M count=50 conv=notrunc conv=fsync
>>>> +dd if=/dev/zero of=$testfile bs=1M count=50 conv=notrunc conv=fsync 2>&1 | _filter_scratch
>>>> +
>>>> +_scratch_remount checkpoint=enable
>>>> +
>>>> +status=0
>>>> +exit
>>>> diff --git a/tests/f2fs/006.out b/tests/f2fs/006.out
>>>> new file mode 100644
>>>> index 00000000..2dc9efda
>>>> --- /dev/null
>>>> +++ b/tests/f2fs/006.out
>>>> @@ -0,0 +1,6 @@
>>>> +QA output created by 006
>>>> +50+0 records in
>>>> +50+0 records out
>>>> +dd: error writing 'SCRATCH_MNT/testfile': No space left on device
>>>> +3+0 records in
>>>> +2+0 records out
>>>
>>> Hi Chao,
>>>
>>> One more question about this patch.
>>>
>>> I'm wondering can this output always be matched? If the test doesn't care the dd output,
>>> you can filter out them, to avoid it break golden image. Especially the second one, can
>>> you be sure it always "3 in and 2 out" before returning ENOSPC?
>>
>> Zorro,
>>
>> I got your concern, how about using _check_dmesg to catch the kernel
>> bug instead? since once the bug was triggered, f2fs will call BUG_ON
>> or WARN_ON optionally anyway.
> 
> Hi Chao,
> 
> The _check_dmesg is always called at the end of each test. Except you
> need a dmesg filter, or you don't need to call it manually.

Zorro,

Oh, alright.

> 
> My concern is "unstable output cause unexpected failure on fixed kernel".
> If you think the last "dd" output is unstable and useless on fixed kernel,
> you can filter it out, just let the dmesg/hang break the test.

I just confirmed that the output may change according to mkfs.f2fs option,
so I guess we'd better ignore output of dd, and check dmesg instead.

> 
> e.g.
> 
>    # The 2nd dd might run out of space, and trigger a kernel warning or hang on
>    # unfixed kernel
>    dd if=/dev/zero of=$testfile bs=1M count=50 conv=notrunc conv=fsync >/dev/null
>    dd if=/dev/zero of=$testfile bs=1M count=50 conv=notrunc conv=fsync 2>&1 >/dev/null | _filter_scratch
> 
> or if you feel the error output isn't stable either, you can:
> 
>    # The 2nd dd might run out of space, and trigger a kernel warning or hang on
>    # unfixed kernel
>    dd if=/dev/zero of=$testfile bs=1M count=50 conv=notrunc conv=fsync >>$seqres.full
>    dd if=/dev/zero of=$testfile bs=1M count=50 conv=notrunc conv=fsync >>$seqres.full 2>&1
>    ...
>    echo "Silence is golden"

I think we can use above code to make output stable, thanks for your suggestion. :)

Thanks,

> 
> Or if you need those output, please make sure it's a stable output on any fixed
> system :)
> 
> Thanks,
> Zorro
> 
>>
>> Thanks,
>>
>>>
>>> Thanks,
>>> Zorro
>>>
>>>> -- 
>>>> 2.40.1
>>>>
>>>
>>
> 

