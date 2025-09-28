Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88ED225D6
	for <fstests@vger.kernel.org>; Sun, 28 Sep 2025 06:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759041785; cv=none; b=ohutvSouXWKsU+GvdMFf1fTQWoddJvfQWUISMqSHi/stg8ooR6RSsKFVLiDGrcKP2HmUy27yYjG+LOwj1xeT1j3pBAKabt8Y73TyDh1TvlKyzI2yGXBB4czLr0ZJXbaL9zqnTqJTaKl8Tq3+gm1Ch/vddDldfwfw6abQ69dObJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759041785; c=relaxed/simple;
	bh=Tl8ROPs/arXOX/q8RYDXUWSsffcYNUUhFGdZRgdFXv0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uChDBL6UaYM9N4d5S9+8LSdcm4rkwgmcApvZEpopmgzd9vgIFCafqN43OPQA/PfjMweToBw7UMZhM1TlYBQhXumeoY575FSIVYdgAdwWgSPhMk9PLOVCfYwas7ozN3niDyRgjP2DHe2BuXycB/gHhhGnKgKb+56ddcyk1h+N+fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TuQmEgaW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TuQmEgaW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32FDAC4CEF0;
	Sun, 28 Sep 2025 06:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759041785;
	bh=Tl8ROPs/arXOX/q8RYDXUWSsffcYNUUhFGdZRgdFXv0=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=TuQmEgaWRXe1xIuBYKXpzHpM8ZcbWskl2cCSbSY9Ih9hkgO4sR79clKnt8bZOJkEV
	 LbwWyMx/tOW0jH+ljupzmuqPmTeupuQanp+O7KmxRLGhgaZy8605AEUmrHqBIqnrhB
	 w++7AYSsm57i/gclWouSARcbrj4JxLIsJ9wAbiJOJLbssL5+cjQUn1rgwHpCMFPcVT
	 pzbIb9YbQwc6GZAIGf8OmFaDCB07AvQ4eRIAJM9WPEUViZeZr2ElWyf5RmgqLiuR17
	 tnTqZtc7N19iQbEhMPqsmnzOGGsdehcwzVBM/5qDco2MzaVhHMdW3sYwRmiVD0VAtI
	 Cg3QM2+HGQxbQ==
Message-ID: <bdba3cf9-4c67-4b7d-bfa7-8dc8a3580bb2@kernel.org>
Date: Sun, 28 Sep 2025 14:43:01 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
 jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/2] f2fs/021: test quota mount option
To: Zorro Lang <zlang@redhat.com>
References: <20250901020331.2171502-1-chao@kernel.org>
 <20250926181847.rebyuxqba7hy225r@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250926181847.rebyuxqba7hy225r@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/27/2025 2:18 AM, Zorro Lang wrote:
> On Mon, Sep 01, 2025 at 10:03:30AM +0800, Chao Yu wrote:
>> This testcase tries to check whether f2fs can handle "usrjquota="
>> during remount correctly, it expects kernel will encounter NULL
>> pointer dereference bug w/o the fix ("f2fs: fix to avoid NULL pointer
>> dereference in f2fs_check_quota_consistency()").
>>
>> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>   tests/f2fs/021     | 30 ++++++++++++++++++++++++++++++
>>   tests/f2fs/021.out |  2 ++
>>   2 files changed, 32 insertions(+)
>>   create mode 100755 tests/f2fs/021
>>   create mode 100644 tests/f2fs/021.out
>>
>> diff --git a/tests/f2fs/021 b/tests/f2fs/021
>> new file mode 100755
>> index 00000000..c41760fc
>> --- /dev/null
>> +++ b/tests/f2fs/021
>> @@ -0,0 +1,30 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2025 Chao Yu.  All Rights Reserved.
>> +#
>> +# FS QA Test No. f2fs/021
>> +#
>> +# This testcase tries to check whether f2fs can handle "usrjquota="
>> +# during remount correctly
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto quick mount
>                                    ^^^^^^^^^^^^^
>                                    quota remount
> 
> I'll help to add these two tags when I merge it. Others look good to me,
> if you've maken sure it can trigger the bug you want to uncover.
> 
> Reviewed-by: Zorro Lang <zlang@redhat.com>

Thanks for the fix.

Thanks,

> 
>> +
>> +_fixed_by_kernel_commit xxxxxxxxxxxx \
>> +	"f2fs: fix to avoid NULL pointer dereference in f2fs_check_quota_consistency()"
>> +
>> +_require_scratch
>> +
>> +_scratch_mkfs >> $seqres.full
>> +_scratch_mount "-o usrquota"
>> +quotacheck -uc $SCRATCH_MNT
>> +_scratch_unmount
>> +
>> +_scratch_mount "-o usrjquota=aquota.user,jqfmt=vfsold"
>> +_scratch_mount "-o remount,usrjquota=,jqfmt=vfsold"
>> +_scratch_unmount
>> +
>> +echo "Silence is golden"
>> +
>> +status=0
>> +exit
>> diff --git a/tests/f2fs/021.out b/tests/f2fs/021.out
>> new file mode 100644
>> index 00000000..09f4062d
>> --- /dev/null
>> +++ b/tests/f2fs/021.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 021
>> +Silence is golden
>> -- 
>> 2.49.0
>>
> 

