Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153EA18C03F
	for <fstests@vger.kernel.org>; Sun, 28 Sep 2025 06:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759042107; cv=none; b=Xg+FU9ldP2k8c/nIepMWi+mbJv2fls/oNw17tniv/eX0Qy4jGS1EGoHT7AR1Gi/E1VYxpUuFadvt4to3ZUCTlDkZ0cfQnB1Y7EUef0OlG4TkkIa7MCOFokfHl8KMX6NuAmWlgu1yUEgXozfEhdgw3gaA3n+ghayOCrZcpM+9KIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759042107; c=relaxed/simple;
	bh=ZPHK11UTbeoEs3cjkCK1x1gPX6PKfNqW0+dJBxaM8P0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZLKQ2skFitDd873Y3l64x3IqRTA8r3fsvZ/9Ko8DJUPKQwPiIUS5zj2Vtm8xVLZOCOokv07lVMZVM+nqYa4bX4xSzSme9G+sw2r9dUVcWRvb3Jtp4j9cfe8QrlHivk2uneYajOqRiDTJaRderUVyJWyoe9DpPDDDt2ez8iw6qFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uxvlmK4O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uxvlmK4O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63054C4CEF0;
	Sun, 28 Sep 2025 06:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759042106;
	bh=ZPHK11UTbeoEs3cjkCK1x1gPX6PKfNqW0+dJBxaM8P0=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=uxvlmK4Ogk8+LMpzkXhbK34ptqa/XzxjivU1y3xalsUJrz1NMM1qCK52Wal2dBMFa
	 3qekicLMrdu+/0EwkPxEdYSku9cUOt5Nw+j6KRXM12hZzZ1Lpo+hD952dbt0YlaRJK
	 J76ninDxeEBoa+xxWSF+EXsm2nTKO7/3NVaTLX41pDq6yuBFV4xgG52cUw8lGCzvy3
	 dREK58GWCtulmA2u9XOtQow3073Wyh/NnSgL0G7+blFd3YyJ7MFSyHtoGVm+T8Dvsi
	 cGzW6OAPhMmgH9ZKflLjhanNr43nDtdAsjRpRHsguQoba7cEz9wt0oG478l1c6iado
	 F5d918FLzUpvg==
Message-ID: <802f7ad9-11e8-4b91-81b5-7579b7e8a255@kernel.org>
Date: Sun, 28 Sep 2025 14:48:23 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
 jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 2/2] f2fs/022: do sanity check on footer of non inode
 dnode
To: Zorro Lang <zlang@redhat.com>
References: <20250901020331.2171502-1-chao@kernel.org>
 <20250901020331.2171502-2-chao@kernel.org>
 <20250926192254.djrwx55itz422yft@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250926192254.djrwx55itz422yft@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/27/2025 3:22 AM, Zorro Lang wrote:
> On Mon, Sep 01, 2025 at 10:03:31AM +0800, Chao Yu wrote:
>> This is a regression test:
>> 1. create foo & bar
>> 2. write 8M data to foo
>> 3. use inject.f2fs to inject i_nid[0] of foo w/ ino of bar
>> 4. fpunch in foo w/ specified range
>>
>> If we haven't applied kernel patch ("f2fs: fix to do sanity check on
>> node footer for non inode dnode"), f2fs may missed to do sanity check
>> on corrupted dnode, result in panic in step 4).
>>
>> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>   tests/f2fs/022     | 52 ++++++++++++++++++++++++++++++++++++++++++++++
>>   tests/f2fs/022.out |  2 ++
>>   2 files changed, 54 insertions(+)
>>   create mode 100755 tests/f2fs/022
>>   create mode 100644 tests/f2fs/022.out
>>
>> diff --git a/tests/f2fs/022 b/tests/f2fs/022
>> new file mode 100755
>> index 00000000..a5e19a71
>> --- /dev/null
>> +++ b/tests/f2fs/022
>> @@ -0,0 +1,52 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2025 Chao Yu.  All Rights Reserved.
>> +#
>> +# FS QA Test No. f2fs/022
>> +#
>> +# This is a regression test:
>> +# 1. create foo & bar
>> +# 2. write 8M data to foo
>> +# 3. use inject.f2fs to inject i_nid[0] of foo w/ ino of bar
>> +# 4. fpunch in foo w/ specified range
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto quick rw
>> +
>> +. ./common/attr
>> +
>> +_fixed_by_kernel_commit xxxxxxxxxxxx \
>> +	"f2fs: fix to do sanity check on node footer for non inode dnode"
>> +
>> +_require_scratch_nocheck
>> +_require_command "$F2FS_INJECT_PROG" inject.f2fs
>> +_require_xfs_io_command "fpunch"
>> +_require_kernel_config CONFIG_F2FS_CHECK_FS
> 
> Looks like the CONFIG_F2FS_CHECK_FS is a necessary condition to reproduce
> that bug, right? I'm wondering is there a better way to check if CONFIG_F2FS_CHECK_FS
> is enabled, likes reading someone file in /sys or what ever else? Checking kernel config

No, I don't see any sysfs entry for checing if CONFIG_F2FS_CHECK_FS is
enabled.

I checked the testcase w/ image which has CONFIG_F2FS_CHECK_FS=off, the
testcase falls into a deadloop inside kernel, so it's fine to get rid of
the CONFIG_F2FS_CHECK_FS requirement? Thoughts?

Thanks,

> isn't always a recommended way, except no better idea :)
> 
>> +
>> +# remove all mkfs options to avoid layout change of on-disk inode
>> +export MKFS_OPTIONS=""
>> +
>> +foo_path=$SCRATCH_MNT/foo
>> +bar_path=$SCRATCH_MNT/bar
>> +
>> +_scratch_mkfs >> $seqres.full
>> +_scratch_mount
>> +
>> +touch $foo_path
>> +touch $bar_path
>> +$XFS_IO_PROG $foo_path -c "pwrite 0 8M" >> $seqres.full
>> +sync
>> +foo_ino=`stat -c '%i' $foo_path`
>> +bar_ino=`stat -c '%i' $bar_path`
>> +_scratch_unmount
>> +
>> +# inject foo inode to replace i_nid[0] w/ to bar ino
>> +$F2FS_INJECT_PROG --node --mb i_nid --nid $foo_ino --idx 0 --val $bar_ino $SCRATCH_DEV >> $seqres.full || _fail "failed to inject"
>> +
>> +_scratch_mount
>> +# expect to trigger panic
>> +$XFS_IO_PROG $foo_path -c "fpunch 6984k 4k"
>> +_scratch_unmount
>> +
>> +status=0
>> +exit
>> diff --git a/tests/f2fs/022.out b/tests/f2fs/022.out
>> new file mode 100644
>> index 00000000..5307e3d7
>> --- /dev/null
>> +++ b/tests/f2fs/022.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 022
>> +fallocate: Structure needs cleaning
>> -- 
>> 2.49.0
>>
> 

