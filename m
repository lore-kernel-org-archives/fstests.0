Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE62F1D5CEE
	for <fstests@vger.kernel.org>; Thu, 26 Dec 2024 13:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735219111; cv=none; b=RNehl8tml9VXvVJYsauaAIvLwwaGEuh+UDRTR4okFTf1GtLqMX7kLIsByyB9GWYd4/oe4zjMDgvWce9w7s3+6HONuUfJZJBD60t5O9iahOfKEM6TOFRkpm6EnjBBqOMLgmL0XaGJOKSFDYh0zc9KfPDdIB69wnLfeiUj/UoyqVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735219111; c=relaxed/simple;
	bh=BEADzvU1Q7JbDiV1KLuhdTb1ySVauWyE3gOJTCLz5Hw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DoH+zv+l1uOQCZjSy2oQL8nYUipPyJyB8scbN+/bExwI1r4z2Lj2Z/zYFZUaGn07ymGBZkkkklCxCMoMgmiaXg2LT9H909QjFT7ppXL77sPB6c+hBEY3Ra9YxUobrL2iLAIlmUNkj6Ox4RMxxC0sVNscSdQi3+HWuWn0cZU8s90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bC2qHeIm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bC2qHeIm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C649C4CEDC;
	Thu, 26 Dec 2024 13:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735219110;
	bh=BEADzvU1Q7JbDiV1KLuhdTb1ySVauWyE3gOJTCLz5Hw=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=bC2qHeIm2xdCYhZJcMP6xlzKejOGmSaNlfupiAX2MWoBxuxqqmy7cUx7XuHJG/LTb
	 zlSv+PCRbSNUOmGazRc8g/woke1rRwcuHqw/Sroe5FILEEP6DjpXMcqQ5UZ0Tww4Ig
	 GVhjcLl/0Agu09VnJn8VrW5B5CQFkQxUuYJh0IWlJobjQry2eAjT/DSH6JykWyFDhD
	 SuRfNxYZMiSdmslCBqon/YCThFFLnDmP7Y5KaQtOnnxI5yY2Y6aOdRu+HsB8CRDGDg
	 42a103IOuJlx/BvUuwf+Q0a/769ljYN1f+SKej71QAnTY25/gSuZ1NNmmY929HXJeF
	 sPCkUtrIYha3A==
Message-ID: <38a448c9-5cd4-482e-8411-a801995199c3@kernel.org>
Date: Thu, 26 Dec 2024 21:18:36 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, Zorro Lang <zlang@kernel.org>,
 fstests@vger.kernel.org, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v3 2/2] f2fs/008: test snapshot creation/deletion on lvm
 device
To: Zorro Lang <zlang@redhat.com>
References: <20241221082345.196029-1-chao@kernel.org>
 <20241221082345.196029-2-chao@kernel.org>
 <20241224095821.ylfv622fifsk3tsv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
Autocrypt: addr=chao@kernel.org; keydata=
 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
In-Reply-To: <20241224095821.ylfv622fifsk3tsv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/12/24 17:58, Zorro Lang wrote:
> On Sat, Dec 21, 2024 at 04:23:45PM +0800, Chao Yu wrote:
>> This patch introduce a regression testcase to check whether
>> f2fs can handle discard correctly once underlying lvm device
>> changes to not support discard after user creates snapshot
>> on it.
>>
>> Related bug was fixed by commit bc8aeb04fd80 ("f2fs: fix to
>> drop all discards after creating snapshot on lvm device")
>>
>> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>> v3:
>> - rebase to last for-next branch
>> - update according to Zorro's comments.
>>   tests/f2fs/008     | 57 ++++++++++++++++++++++++++++++++++++++++++++++
>>   tests/f2fs/008.out |  2 ++
>>   2 files changed, 59 insertions(+)
>>   create mode 100755 tests/f2fs/008
>>   create mode 100644 tests/f2fs/008.out
>>
>> diff --git a/tests/f2fs/008 b/tests/f2fs/008
>> new file mode 100755
>> index 00000000..b85e321c
>> --- /dev/null
>> +++ b/tests/f2fs/008
>> @@ -0,0 +1,57 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2024 Oppo.  All Rights Reserved.
>> +#
>> +# FS QA Test No. f2fs/008
>> +#
>> +# This is a regression test to check whether f2fs can handle
>> +# discard correctly once underlying lvm device changes to not
>> +# support discard after user creates snapshot on it.
>> +#
>> +
>> +. ./common/preamble
>> +_begin_fstest auto quick rw
>> +
>> +_fixed_by_kernel_commit bc8aeb04fd80 \
>> +        "f2fs: fix to drop all discards after creating snapshot on lvm device"
>> +
>> +_require_scratch_nolvm
>> +_require_block_device $SCRATCH_DEV
>> +_require_command "$LVM_PROG" lvm
>> +
>> +lvname=lv_$seq
>> +vgname=vg_$seq
>> +testfile=$SCRATCH_MNT/testfile
>> +
>> +_cleanup()
>> +{
>> +	_unmount $SCRATCH_MNT >>$seqres.full 2>&1
>> +	$LVM_PROG lvremove -ff /dev/mapper/$lvname-snapshot $vgname >>$seqres.full 2>&1
>> +	$LVM_PROG lvremove -ff /dev/mapper/$vgname-$lvname >>$seqres.full 2>&1
>> +	$LVM_PROG vgremove -ff $vgname >>$seqres.full 2>&1
>> +	$LVM_PROG pvremove -ff $SCRATCH_DEV >>$seqres.full 2>&1
>> +	_udev_wait --removed /dev/mapper/$vgname-$lvname
>> +	cd /
>> +	rm -f $tmp.*
>> +}
>> +
>> +$LVM_PROG pvcreate -f $SCRATCH_DEV >>$seqres.full 2>&1
>> +$LVM_PROG vgcreate -f $vgname $SCRATCH_DEV >>$seqres.full 2>&1
>> +$LVM_PROG lvcreate -L 1024m -n $lvname $vgname >>$seqres.full 2>&1
> 
> The lvcreate might be blocked by:
>    "WARNING: f2fs signature detected on /dev/vg_008/lv_008 at offset 1024. Wipe it? [y/n]:"

Oh, I didn't encounter this... is it due to I use low version lvm tool?

lvm version
   LVM version:     2.03.11(2) (2021-01-08)
   Library version: 1.02.175 (2021-01-08)
   Driver version:  4.48.0

> 
> So better to use "lvcreate -y" or "yes | ...".

Sure.

Thanks,

> 
> Thanks,
> Zorro
> 
>> +_udev_wait /dev/mapper/$vgname-$lvname
>> +
>> +_mkfs_dev /dev/mapper/$vgname-$lvname >>$seqres.full 2>&1
>> +_mount -o discard /dev/mapper/$vgname-$lvname $SCRATCH_MNT >>$seqres.full 2>&1
>> +
>> +dd if=/dev/zero of=$testfile bs=1M count=20 >>$seqres.full 2>&1
>> +sync
>> +rm -f $testfile
>> +sync
>> +
>> +# create a snapshot on lvm device
>> +$LVM_PROG lvcreate -L 1024m -s -n $lvname-snapshot /dev/mapper/$vgname-$lvname >>$seqres.full 2>&1
>> +
>> +echo "Silence is golden"
>> +
>> +status=0
>> +exit
>> diff --git a/tests/f2fs/008.out b/tests/f2fs/008.out
>> new file mode 100644
>> index 00000000..dd68d5a4
>> --- /dev/null
>> +++ b/tests/f2fs/008.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 008
>> +Silence is golden
>> -- 
>> 2.40.1
>>
> 

