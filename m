Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE576A59
	for <fstests@vger.kernel.org>; Mon, 28 Oct 2024 09:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730108830; cv=none; b=OEwOV7hPsc7DRNxKe6IFTB8LHEdIRgcOmVtWE47w7WY6Jgnl7oeXYdbwcJtZ2eDw2VeDDw4Fp2k21zQTGCbNDv7gK648DrFZkGs5JPSw0Wcy3yksmGtv4JjWzDD1CB0nRsPCRfK4yn9pBoSl1KNhxXkqswevoO5avbPfkqxNrNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730108830; c=relaxed/simple;
	bh=kwJTSKGVyruOkdDlspu/YLGyPpmGn9rmrK+Eg8Xn3aM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=on7VfDYUOUc+Cc9gA6lkv4uhF5IKdGip2MTH4iWU1PKvZjQt3VuKiPEUawInaUNoyBOizwYnGgAozMXdW8ECAjhMU/QG85CVRf7COTR9Znj3IWHWlLE1+knSYjuIDE56FYkhFB3y1x7IDjdmfq56HG4mkSxggJiQHGLjZBsCWn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QtrSsrtT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QtrSsrtT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F014AC4CEC3;
	Mon, 28 Oct 2024 09:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730108830;
	bh=kwJTSKGVyruOkdDlspu/YLGyPpmGn9rmrK+Eg8Xn3aM=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=QtrSsrtTIVq6Yz/DFOpvXZuqOY9CBjgyNLpkgXhMhL1MNMAkvwUtvHCaUhfHO72zo
	 iv6kKOhw+DK4sxswV2uqfXGS1jnqjHKTl3Q5lIXAeQUi+Bd6NlS0mjo2oyImesv3pn
	 bELkzeExEDnUGSK++tr0zybvjozX/J6P52ZNGaj6VJ7lc/ncFmuEOglsVyCdh2p1zP
	 MgqRh7xXEb4SY1+NqzmDoJTLRxk76zO3yJOT3qZ4bGg8zHdLhAxHrnfHogk+vcsIQH
	 MB7C8FOs1tkqv+r7WjUFw/U8SY2RX9Q6gr9lr/xZPuwjPF0ZBR7cFwgE6kJNiymquf
	 HZjVCA14p49VA==
Message-ID: <53cb9bde-d845-49d6-858e-147b0870fbbf@kernel.org>
Date: Mon, 28 Oct 2024 17:47:06 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, fstests@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v2 1/2] f2fs/006: add testcase to check out-of-space case
To: Zorro Lang <zlang@redhat.com>
References: <20241023081602.3806579-1-chao@kernel.org>
 <20241025034413.5s6ecilfgqcoeudt@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20241025034413.5s6ecilfgqcoeudt@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/25 11:44, Zorro Lang wrote:
> On Wed, Oct 23, 2024 at 04:16:01PM +0800, Chao Yu wrote:
>> This is a regression test to check whether f2fs handles dirty
>> data correctly when checkpoint is disabled, if lfs mode is on,
>> it will trigger OPU for all overwritten data, this will cost
>> free segments, so f2fs must account overwritten data as OPU
>> data when calculating free space, otherwise, it may run out
>> of free segments in f2fs' allocation function, resulting in
>> panic.
>>
>> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>> v2:
>> - add _fixed_by_kernel_commit()
>> - use _scratch_mkfs_sized() rather than formating size-specified
>> loop device
>> - code cleanup
>>   tests/f2fs/006     | 38 ++++++++++++++++++++++++++++++++++++++
>>   tests/f2fs/006.out |  6 ++++++
>>   2 files changed, 44 insertions(+)
>>   create mode 100755 tests/f2fs/006
>>   create mode 100644 tests/f2fs/006.out
>>
>> diff --git a/tests/f2fs/006 b/tests/f2fs/006
>> new file mode 100755
>> index 00000000..63d00018
>> --- /dev/null
>> +++ b/tests/f2fs/006
>> @@ -0,0 +1,38 @@
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
>> +# of free segments in f2fs' allocation function, resulting in
>> +# panic.
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto quick
>> +
>> +_fixed_by_kernel_commit xxxxxxxxxxxx \
>> +	"f2fs: fix to account dirty data in __get_secs_required()"
>> +
>> +testfile=$SCRATCH_MNT/testfile
>> +
>> +_require_scratch
>> +_scratch_mkfs_sized $((1024*1024*100)) >> $seqres.full
>> +
>> +# use mode=lfs to let f2fs always triggers OPU
>> +_scratch_mount -o mode=lfs,checkpoint=disable:10%,noinline_dentry >> $seqres.full
>> +
>> +dd if=/dev/zero of=$testfile bs=1M count=50 2>/dev/null
>> +
>> +# it may run out of free space of f2fs and hang kernel
>> +dd if=/dev/zero of=$testfile bs=1M count=50 conv=notrunc conv=fsync
>> +dd if=/dev/zero of=$testfile bs=1M count=50 conv=notrunc conv=fsync
> 
> What kind of failure should be printed at here if test on unfixed kernel?

It will panic kernel w/o fix, can you please check dmesg?

> I got:
> 
> # diff -u /root/git/xfstests/tests/f2fs/006.out /root/git/xfstests/results//default/f2fs/006.out.bad|less
> --- /root/git/xfstests/tests/f2fs/006.out       2024-10-25 11:33:54.693883281 +0800
> +++ /root/git/xfstests/results//default/f2fs/006.out.bad        2024-10-25 11:34:55.907252401 +0800
> @@ -1,6 +1,6 @@
>   QA output created by 006
>   50+0 records in
>   50+0 records out
> -dd: error writing '/mnt/scratch_f2fs/testfile': No space left on device
> -3+0 records in
> -2+0 records out
> +dd: fsync failed for '/mnt/scratch/testfile': Input/output error
> +50+0 records in
> +50+0 records out
> 
> Does that mean the bug is reproduced?
 > >> +
>> +_scratch_remount checkpoint=enable
>> +
>> +status=0
>> +exit
>> diff --git a/tests/f2fs/006.out b/tests/f2fs/006.out
>> new file mode 100644
>> index 00000000..0d7b3910
>> --- /dev/null
>> +++ b/tests/f2fs/006.out
>> @@ -0,0 +1,6 @@
>> +QA output created by 006
>> +50+0 records in
>> +50+0 records out
>> +dd: error writing '/mnt/scratch_f2fs/testfile': No space left on device
> 
> The "/mnt/scratch_f2fs" should be SCRATCH_MNT, please use _filter_scratch()
> by importing common/filter.

Correct, let me fix this.

Thanks,

> 
>> +3+0 records in
>> +2+0 records out
>> -- 
>> 2.40.1
>>
> 

