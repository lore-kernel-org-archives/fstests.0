Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E1ECA5A
	for <fstests@vger.kernel.org>; Mon, 28 Oct 2024 13:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730123195; cv=none; b=ouv4sx5G+J9ILOE3WO/O+s5cREXyqyku1+LSqHlWCgZVBBDP31tE58T7Ryn7bY3EcibuAAvdvE1jHKhtC1Kw9/wGZHoZ7zN7EB+QhpyDW1zwoYMve94ycxSTyfsBOAjaL8/T8j5Em9D7ZxHTUyKnKyCiFpxPVQhP8iblCnUd5BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730123195; c=relaxed/simple;
	bh=nry+gNH1QKnuFPQC+0UEBGG0WSi8qsv9vjSD2K03t0Q=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=U9hd9jcTU648WEYJbuJFDzYq+Q/DOvYmjUvDkAznOt+6BSdko6yv4JL5CAj7iwYpFt7kF0TIzJFbR56SxvHyNfB4T7uL1akuxNiYd0BXhoDZy8oKuueuyRSzGcUoQndPG32XZO2Pc1WrI0gfUXBT7SUM7+X5vXC+w/UPEdqwaII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6Oohx65; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6Oohx65"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 202C0C4CEC3;
	Mon, 28 Oct 2024 13:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730123195;
	bh=nry+gNH1QKnuFPQC+0UEBGG0WSi8qsv9vjSD2K03t0Q=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=L6Oohx65HC9VznjV6wcBQIa0A3T+rSZZONfIj4lFmE85YaAKt1sYlCs+XYWwZjaRS
	 z4JtOJhNY6oTHrbRSK4lfqpPye9f5ILHNB4iMRvKyJrfIkW797H1cxJFJsuq7tXA6X
	 lWm7EKN98w2qOL11GrdV8lckd89JMm1s9KxFY4WVtzND15Zi91USxiChqpibibJfOe
	 2STRopyxc220w2F//rO4YiJ7OnE9yA069eea64q+mEqDyWzLFz1JGLjfKe1G94KCiU
	 hk+zBb+NMYAE+hZChIi0QDRj9sM390w4+/djJhd0Or92p9zKBxwdRgP+etPFbuFs8B
	 FC8VbSAEC75UA==
Message-ID: <0274ac17-246e-4a29-bf24-1d0123dce8e7@kernel.org>
Date: Mon, 28 Oct 2024 21:46:31 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, fstests@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Qi Han <hanqi@vivo.com>
Subject: Re: [PATCH] f2fs/005: add testcase to check checkpoint disabling
 functionality
To: Zorro Lang <zlang@redhat.com>
References: <20241012101501.377899-1-chao@kernel.org>
 <20241025041115.fmv2wt7qy6s55hip@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20241025041115.fmv2wt7qy6s55hip@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/25 12:11, Zorro Lang wrote:
> On Sat, Oct 12, 2024 at 06:15:01PM +0800, Chao Yu wrote:
>> This patch introduce a regression test to check whether f2fs handles
>> dirty inode correctly when checkpoint is disabled in a corner case,
>> it may hang umount before the bug is fixed.
>>
>> Cc: Qi Han <hanqi@vivo.com>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>   tests/f2fs/005     | 59 ++++++++++++++++++++++++++++++++++++++++++++++
>>   tests/f2fs/005.out |  1 +
>>   2 files changed, 60 insertions(+)
>>   create mode 100755 tests/f2fs/005
>>   create mode 100644 tests/f2fs/005.out
>>
>> diff --git a/tests/f2fs/005 b/tests/f2fs/005
>> new file mode 100755
>> index 00000000..4faf1bb9
>> --- /dev/null
>> +++ b/tests/f2fs/005
>> @@ -0,0 +1,59 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2024 Oppo.  All Rights Reserved.
>> +#
>> +# FS QA Test No. f2fs/005
>> +#
>> +# This is a regression test to check whether f2fs handles dirty
>> +# inode correctly when checkpoint is disabled, it may hang umount
>> +# before the bug is fixed.
> 
> Is this a duplicated test of another patch from you?
> 
> https://lore.kernel.org/fstests/20241025034413.5s6ecilfgqcoeudt@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/T/#t
> 
> Or just similar?
> 
> If this's a different test ...(see below)

It's a different one.

> 
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto quick
>> +
>> +_cleanup()
>> +{
>> +	rm -f $img
>> +	rmdir $mnt
>> +	_scratch_unmount >> $seqres.full
>> +	cd /
>> +	rm -r -f $tmp.*
>> +}
>> +
>> +_require_scratch
>> +_scratch_mkfs >> $seqres.full
>> +_scratch_mount >> $seqres.full
>> +
>> +img=$SCRATCH_MNT/f2fs.img
>> +mnt=$SCRATCH_MNT/f2fs.mnt
>> +testfile=$mnt/testfile
>> +tmpfile=$mnt/tmpfile
>> +tmpdir=$mnt/tmpdir
>> +
>> +mkdir $mnt
>> +dd if=/dev/zero of=$img bs=1M count=50 2>/dev/null
>> +$MKFS_F2FS_PROG -f $img >/dev/null 2>&1
>> +sync
>> +
>> +# use mode=lfs to let f2fs always triggers OPU
>> +mount -t $FSTYP -o loop,mode=lfs,checkpoint=disable:10%,noinline_dentry $img $mnt
> 
> You can use _scratch_mkfs_sized, don't need a loop device.
> And without the loop device, above _cleanup is not needed either.
> 
>> +
>> +dd if=/dev/zero of=$testfile bs=1M count=5 2>/dev/null
>> +mkdir $tmpdir
>> +touch $tmpfile
>> +sync
>> +
>> +# it dirties tmpdir inode by updating ctime,
>> +# but it doesn't moving the inode to gdirty_list.
>> +mv $tmpfile $tmpdir
>> +
>> +# it runs out of free segment
>> +dd if=/dev/zero of=$testfile bs=1M count=5 conv=notrunc conv=fsync 2>/dev/null
>> +
>> +mount -o remount,checkpoint=enable $mnt
>> +
>> +# it may hang umount if tmpdir is still dirty during evict()
>> +umount $mnt
>> +
>> +status=0
>> +exit
>> diff --git a/tests/f2fs/005.out b/tests/f2fs/005.out
>> new file mode 100644
>> index 00000000..caa3c880
>> --- /dev/null
>> +++ b/tests/f2fs/005.out
>> @@ -0,0 +1 @@
>> +QA output created by 005
> 
> If nothing output, please:
> 
> echo "Silence is golden"

Will update this patch according to your comments, thank you!

Thanks,

> 
> Thanks,
> Zorro
> 
>> -- 
>> 2.40.1
>>
> 

