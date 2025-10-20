Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6EB33987
	for <fstests@vger.kernel.org>; Mon, 20 Oct 2025 02:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760929087; cv=none; b=k4Rot2xuC2XsIz6oODHeOY6+jzwAG4l/4k1buF31/iHNWDI0rFtopwlX0CrDbUyYGsYVaTwuR9w5pfznQbSmOtoQnvTduNnXl0p6yk5/u0R/yxNrzQmb7Ed2jkPDPttxCKEoPdyJ1CyBgoNXGs84/d3QnZ100WEulU3DGNLRWoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760929087; c=relaxed/simple;
	bh=cI3/ias/+4HcFAyVUAilSQLc+xhAr0wOuznULvflJg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JUCWv3Re383A0X1DHfMp0eUlktshGsSXFlGBO7kIqYDXLJbwqRf2Fu1hoJIo7pj9JHnQy0B8boh4WO4pwFEVUDMwNfHjlAzj4HE8H23cXU3PG+d2vyQx6NSvMXgzDa9BIn67+P+cUKvEVhReASstjRjfc4DiwVRpiUiBdaFMGVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3GC42CG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3GC42CG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99427C4CEF1;
	Mon, 20 Oct 2025 02:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760929086;
	bh=cI3/ias/+4HcFAyVUAilSQLc+xhAr0wOuznULvflJg8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=m3GC42CGW3UVJ/ZsGW2Gfbrqgm8gdw9RJ1cLY+1tkcDki4A0Z9FeRSn9ZP1Rj/3yA
	 KH8HU5hbJED3CgyBXtseRmC5UXy+OB9cG+ZbTs8sWNhFPf3p6Djsp1opKR/P6RY35k
	 QgwRb+RuoB6bagMg37FkGXRmROs/08f87PK2dqSGCCbKlLVN36hbmXtFpbV/FEV8V6
	 Yd9j39XewgGuO1bN15syMD2DGMW00n6MVi344VF7vZcFa7GHHYbyC+I5SwSf9G0pVu
	 wNcMIFCliiChZLs0Gl6PbwWsYKaQHYcdMfhqm/2AtLOen/g4fluZFyxpOOs0309FSY
	 YY5eZwEAdne4A==
Message-ID: <9e724171-eaec-4156-8a3c-210f292ad84d@kernel.org>
Date: Mon, 20 Oct 2025 02:57:24 +0000
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] f2fs/021: test quota mount option
To: Zorro Lang <zlang@redhat.com>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
 jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net, chao@kernel.org
References: <20251011084715.608562-1-chao@kernel.org>
 <20251017193013.ykrwjftkvhaug76z@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20251017193013.ykrwjftkvhaug76z@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/17/25 19:30, Zorro Lang wrote:
> On Sat, Oct 11, 2025 at 04:47:14PM +0800, Chao Yu wrote:
>> This testcase tries to check whether f2fs can handle "usrjquota="
>> during remount correctly, it expects kernel will encounter NULL
>> pointer dereference bug w/o the fix ("f2fs: fix to avoid NULL pointer
>> dereference in f2fs_check_quota_consistency()").
>>
>> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
>> Reviewed-by: Zorro Lang <zlang@redhat.com>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
> 
> Hi Chao,
> 
> This patchset has been merged, you can send a seperated patch to update the
> commit id of _fixed_by_kernel_commit :)

Hi Zorro,

I have sent a seperated patch to update commit id, please take a look, thanks. :)

Thanks,

> 
> Thanks,
> Zorro
> 
>> v3:
>> - update commit id in _fixed_by_kernel_commit line
>>   tests/f2fs/021     | 30 ++++++++++++++++++++++++++++++
>>   tests/f2fs/021.out |  2 ++
>>   2 files changed, 32 insertions(+)
>>   create mode 100755 tests/f2fs/021
>>   create mode 100644 tests/f2fs/021.out
>>
>> diff --git a/tests/f2fs/021 b/tests/f2fs/021
>> new file mode 100755
>> index 00000000..0cacb138
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
>> +_begin_fstest auto quick mount quota remount
>> +
>> +_fixed_by_kernel_commit 930a9a6ee8e7 \
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

