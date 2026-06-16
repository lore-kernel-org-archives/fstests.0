Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525911FC7FB
	for <fstests@vger.kernel.org>; Tue, 16 Jun 2026 06:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781592999; cv=none; b=Md+Mek0NNS6SZx2L0peU+Kj/dOr32RKMm8moRfbRdHswrhR1Di9ArHICPI1t8OzoOTWSVFnoHhBDroTWpAJ0meuzzAtU4lYwNhw6shuu4LE7LL2u+S+E6IXfwSByNdR+jCcP12eGmqk0ShumbmpklNllNWcu/glrbxF+7bx+LsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781592999; c=relaxed/simple;
	bh=oVXlLKEVSLP46nC/ngiTOEW4LRIZTqHsqTtmmu1fTRc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rWH6uI7ryLB3Ewq3q8uCMJZeGhTaqvSW+1cNnRT7WIFFimUQC9lByYhub83J6RjKZ+ECIkklclAnacOdCaaRFMaazYH7QJyoITAH0oSwFhMoKKGquB98OdJ4lXzqiFBtgRIkNHA5OApfHuNMYkUHpNRdjJ/HPM/hpIvAAyth1Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0/NEQpo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0/NEQpo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F9C31F000E9;
	Tue, 16 Jun 2026 06:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781592997;
	bh=GrSmd1lbBq9cbAevJlQdzffNBQ1YuG1P0l1g/pdj2Fw=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To;
	b=T0/NEQpoAHl0mIb8yOYvCcp/cXuL2sc/lmDp++IHSwEKUfbhZIrGmxRwEUbfxjKzq
	 k2DQdBD1MzoVNqxrzu43zmbOkPAWmRCLFWK+fL58G+h9l48KZtOQ4RSKUVId64DFGB
	 +lLF3MMCh80NQ5kfXhHMdc44Ih+m49dsXwMMVPBm8BXsunRJEmTzui7IufCQ7HVcgW
	 Bqs+OapMwoAnZ7ZUdIMLsNXlUK47Zkj/Nda/r1SWbyJley/m6Ock51eiVXab0qyDRF
	 YmzMIvhNAfKRzsN/zW/lODZYIwjE7dsCqowiQ2OetrLIdSDlYxxATiOXU1IiJFrpT5
	 H7ni5n88PIUYQ==
Message-ID: <45da686f-64f6-4597-ae9e-c6600b4bdb19@kernel.org>
Date: Tue, 16 Jun 2026 14:56:35 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org
Subject: Re: [PATCH] f2fs/025: test to do sanity check section type correctly
 in f2fs GC
To: fstests@vger.kernel.org, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20260612005802.3017709-1-chao@kernel.org>
 <ai7YFkAK8sBL4jXm@zlang-mailbox>
 <b32998c0-17e3-4b81-a474-4a408aa7fa32@kernel.org>
 <ajBZEtrLmRZt0AA1@zlang-mailbox>
 <e4a31590-e173-4f43-8d70-16e83bd52bed@kernel.org>
 <ajDbxFzRu9v-WBPC@zlang-mailbox>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <ajDbxFzRu9v-WBPC@zlang-mailbox>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/16/26 13:47, Zorro Lang wrote:
> On Tue, Jun 16, 2026 at 11:33:20AM +0800, Chao Yu wrote:
>> On 6/16/26 04:05, Zorro Lang wrote:
>>> On Mon, Jun 15, 2026 at 04:22:34PM +0800, Chao Yu wrote:
>>>> On 6/15/26 01:16, Zorro Lang wrote:
>>>>> On Fri, Jun 12, 2026 at 12:58:02AM +0000, Chao Yu wrote:
>>>>>> Without commit 520760b9f915 ("f2fs: optimize representative type determination
>>>>>> in GC"), f2fs GC will report inconsistent segment type in large section issue,
>>>>>> and then it will force to shutdown filesystem.
>>>>>>
>>>>>> [  768.190903] F2FS-fs (loop51): Inconsistent segment (3) type [1, 0] in SIT and SSA
>>>>>>
>>>>>> The reason is f2fs kernel will assume all segment type inside large section is
>>>>>> the same, during GC it loads type from one segment and compare it to other
>>>>>> segments' type, however due to recovery flow, the chosen segment may has zero
>>>>>> valid blocks w/ different segment type, since the segment is invalid(free) one,
>>>>>> it will never be migrated, so that we should not treat such state as abnormal
>>>>>> condition.
>>>>>>
>>>>>> This testcase is created to simulate above condition to see whether f2fs kernel
>>>>>> module can handle it correctly
>>>>>>
>>>>>> Signed-off-by: Chao Yu <chao@kernel.org>
>>>>>> ---
>>>>>> v2:
>>>>>> - clear MKFS_OPTIONS and MOUNT_OPTIONS to guarantee block allocation is as expected.
>>>>>
>>>>> Hi Chao,
>>>>>
>>>>> Sorry, I just noticed your reply to my review on the previous patch version.
>>>>> Due to some unexpected shake-ups recently, I’ve been bogged down with setting
>>>>> up and modifying various new system environments, and I accidentally marked
>>>>> some unread emails as read.
>>>>
>>>> No worries. :)
>>>>
>>>>>
>>>>> The patch looks good to me, with just a few picky review points below:
>>>>
>>>> Thanks Zorro for taking a look.
>>>>
>>>>>
>>>>>>  tests/f2fs/025     | 92 ++++++++++++++++++++++++++++++++++++++++++++++
>>>>>>  tests/f2fs/025.out |  2 +
>>>>>>  2 files changed, 94 insertions(+)
>>>>>>  create mode 100644 tests/f2fs/025
>>>>>>  create mode 100644 tests/f2fs/025.out
>>>>>>
>>>>>> diff --git a/tests/f2fs/025 b/tests/f2fs/025
>>>>>> new file mode 100644
>>>>>> index 000000000..397e5439a
>>>>>> --- /dev/null
>>>>>> +++ b/tests/f2fs/025
>>>>>> @@ -0,0 +1,92 @@
>>>>>> +#! /bin/bash
>>>>>> +# SPDX-License-Identifier: GPL-2.0
>>>>>> +# Copyright (c) 2026 Chao Yu <chao@kernel.org>
>>>>>> +#
>>>>>> +# FS QA Test No. f2fs/025
>>>>>> +#
>>>>>> +# Check whether f2fs will encounter cp_error (Inconsistent segment type)
>>>>>> +# when doing sanity check on type of segments inside large section during
>>>>>> +# garbage collection.
>>>>>> +#
>>>>>> +. ./common/preamble
>>>>>> +_begin_fstest auto quick
>>>>>> +
>>>>>> +_fixed_by_kernel_commit 520760b9f915 \
>>>>>> +	"f2fs: optimize representative type determination in GC"
>>>>>> +
>>>>>> +. ./common/filter
>>>>>> +
>>>>>> +_cleanup()
>>>>>> +{
>>>>>> +	cd /
>>>>>> +	rm -r -f $tmp.*
>>>>>> +}
>>>>>
>>>>> This _cleanup() function is same as default. It can be removed.
>>>>
>>>> Will remove.
>>>>
>>>>>
>>>>>> +
>>>>>> +_require_scratch
>>>>>> +_require_xfs_io_command "pwrite"
>>>>>> +_require_xfs_io_command "truncate"
>>>>>> +_require_command "$F2FS_IO_PROG" f2fs_io
>>>>>> +_require_check_dmesg
>>>>>> +
>>>>>> +# Clear options to avoid interference from external configurations
>>>>>> +export MKFS_OPTIONS=""
>>>>>> +export MOUNT_OPTIONS=""
>>>>>> +
>>>>>> +# Format with 96MB size and 2 segments per section
>>>>>> +_scratch_mkfs_sized $((96 * 1024 * 1024)) "" "-s 2" >> $seqres.full 2>&1
>>>>>> +
>>>>>> +# Mount with mode=lfs
>>>>>> +_scratch_mount -o mode=lfs >> $seqres.full 2>&1
>>>>>                               ^^^^^^^^^^^^^^^^^^^^
>>>>> It's helpless, due to if _scratch_mount fails, it exit() directly.
>>>>
>>>> Right, will fix.
>>>>
>>>>>
>>>>>> +
>>>>>> +# Create files to fill whole filesystem, then segment type will be changed to node type
>>>>>> +for ((i=0;i<5120;i++)) do
>>>>>> +	touch $SCRATCH_MNT/$i >> $seqres.full 2>&1
>>>>>> +done
>>>>>> +sync
>>>>>> +
>>>>>> +# Remove all files to create free(empty) node segments
>>>>>> +rm -f $SCRATCH_MNT/*
>>>>>> +sync
>>>>>> +
>>>>>> +# Allocate free space so that we have chance to reuse free(empty) node segments
>>>>>> +$XFS_IO_PROG -f -c "pwrite -b 4k 0 1928k" $SCRATCH_MNT/file >> $seqres.full 2>&1
>>>>>> +sync
>>>>>> +
>>>>>> +$XFS_IO_PROG -c "truncate 0" $SCRATCH_MNT/file >> $seqres.full 2>&1
>>>>>> +$XFS_IO_PROG -d -c "pwrite -b 4k 0 16M" $SCRATCH_MNT/file >> $seqres.full 2>&1
>>>>>> +$XFS_IO_PROG -c "truncate 0" $SCRATCH_MNT/file >> $seqres.full 2>&1
>>>>>> +$XFS_IO_PROG -d -c "pwrite -b 4k 0 16M" $SCRATCH_MNT/file >> $seqres.full 2>&1
>>>>>> +$XFS_IO_PROG -c "truncate 0" $SCRATCH_MNT/file >> $seqres.full 2>&1
>>>>>> +sync
>>>>>> +
>>>>>> +$XFS_IO_PROG -d -c "pwrite -b 4k 0 8M" $SCRATCH_MNT/file >> $seqres.full 2>&1
>>>>>> +$XFS_IO_PROG -c "truncate 0" $SCRATCH_MNT/file >> $seqres.full 2>&1
>>>>>> +$XFS_IO_PROG -d -c "pwrite -b 4k 0 32K" $SCRATCH_MNT/file >> $seqres.full 2>&1
>>>>>> +$XFS_IO_PROG -c "truncate 0" $SCRATCH_MNT/file >> $seqres.full 2>&1
>>>>>> +$XFS_IO_PROG -d -c "pwrite -b 4k 0 2M" -c "fsync" $SCRATCH_MNT/file >> $seqres.full 2>&1
>>>>>> +
>>>>>> +# Shutdown the filesystem without checkpoint
>>>>>> +$F2FS_IO_PROG shutdown 2 $SCRATCH_MNT >> $seqres.full 2>&1
>>>>>
>>>>> I'm wondering if we can have f2fs supporting in common _scratch_shutdown
>>>>> helper :)
>>>>
>>>> I think we can change f2fs testcase to use _scratch_shutdown because the definition of
>>>> nologflush shutdown interface is the same as xfs':
>>>>
>>>> /*
>>>>  * should be same as XFS_IOC_GOINGDOWN.
>>>>  * Flags for going down operation used by FS_IOC_GOINGDOWN
>>>>  */
>>>> #define F2FS_IOC_SHUTDOWN	_IOR('X', 125, __u32)	/* Shutdown */
>>>> #define F2FS_GOING_DOWN_NOSYNC		0x2	/* going down */
>>>>
>>>> #define XFS_IOC_GOINGDOWN	     _IOR ('X', 125, uint32_t)
>>>> #define XFS_FSOP_GOING_FLAGS_NOLOGFLUSH		0x2	/* don't flush log nor data */
>>>>
>>>>>
>>>>>> +
>>>>>> +_scratch_unmount >> $seqres.full 2>&1
>>>>>                     ^^^^^^^^^^^^^^^^^^^^
>>>>>
>>>>> If unmount fails, how about let it output the errors, to break the golden image?
>>>>
>>>> Yes, it's better.
>>>>
>>>>>
>>>>>> +
>>>>>> +_scratch_mount -o mode=lfs >> $seqres.full 2>&1
>>>>>                               ^^^^^^^^^^^^^^^^^^^^
>>>>>                               helpless
>>>>
>>>> Will fix.
>>>>
>>>>>
>>>>>> +
>>>>>> +# Run urgent_gc mode to trigger garbage collection
>>>>>> +dev_name=$(_short_dev $SCRATCH_DEV)
>>>>>> +if [ -f /sys/fs/f2fs/$dev_name/gc_urgent ]; then
>>>>>> +	echo 1 > /sys/fs/f2fs/$dev_name/gc_urgent
>>>>>> +fi
>>>>>
>>>>> Hmm... what if there's not /sys/fs/f2fs/$dev_name/gc_urgent? Does it
>>>>> affect the test result?
>>>>>
>>>>> If it does, this's a necessary requirement for this test, we shouldn't
>>>>> ignore it and keep running. Does $F2FS_IO_PROG provide a command to
>>>>> make a force GC? Or we need to check this file and _notrun if it's
>>>>> not existed.
>>>>
>>>> Ah, right, that's good point!
>>>>
>>>> We can use "$F2FS_IO_PROG gc_urgent <dev_name> run 5" instead, it will do below commands:
>>>
>>> Great, I just hope the *gc_urgent* isn't a new feature which needs something likes:
>>
>> I guess it's not a new subcommand for f2fs_io,
>>
>> commit 22d758e2e6af210dc9e6cdf99438f063383ba72f
>> Author: Jaegeuk Kim <jaegeuk@kernel.org>
>> Date:   Tue Feb 19 19:07:21 2019 -0800
>>
>>     f2fs_io: add gc_urgent
>>
>>     e.g.,
>>     f2fs_io gc_urgent dm-4 [start/end/run] [time in sec]
>>
>>     This controls sysfs/gc_urgent to run f2fs_gc urgently.
>>
>>     Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>
>>> `_require_f2fs_io gc_urgent` (there's not _require_f2fs_io:)
>>
>> Agreed, we need to introduce _require_f2fs_io(), let me work on this.
> 
> Oh, 2019 was 7 years ago. No one should be complaining about this unless
> they're on a super old downstream f2fs-tools. But anyway, having
> _require_f2fs_io is definitely good for future f2fs testing :)

Yeah, agreed.

> 
> Therefore, _require_f2fs_io is not strictly urgent for this patch. It's up to
> you whether to include it now or handle it in a later update.

Let me update a bit later.

> 
>>
>>>
>>>> 1. echo 1 > /sys/fs/f2fs/$dev_name/gc_urgent
>>>> 2. sleep 5 seconds
>>>> 3. echo 0 > /sys/fs/f2fs/$dev_name/gc_urgent
>>>
>>> It also depends on the /sys/fs/f2fs/$dev_name/gc_urgent too. So we have to face
>>> the same question:
>>>   If this file doesn't exist, should this test case _notrun?
>>
>> Oh, right, maybe we can introduce _require_f2fs_sysfs() to check whether f2fs kernel
>> module has supported target sysfs node?
> 
> There's a _require_fs_sysfs_attr, so...
> 
> if you don't care about $SCRATCH_DEV is mounted or not, you can:
>   _require_fs_sysfs_attr $TEST_DEV gc_urgent

gc_urgent is not a per-image feature, so above version looks fine.

> 
> or after _scratch_mount:
>   _require_fs_sysfs_attr $SCRATCH_DEV gc_urgent
> 
> Then I think you can either use `$F2FS_IO_PROG gc_urgent`, or if you're worried
> about its compatibility, you can:

I'm not worried about the compatibility.

>   _set_fs_sysfs_attr $SCRATCH_DEV gc_urgent 1
>   sleep 5

Thanks for the suggestion. :)

Let me update w/:

_require_fs_sysfs_attr $TEST_DEV gc_urgent
...
$F2FS_IO_PROG gc_urgent

Thanks,

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
>>>>
>>>>>
>>>>>> +
>>>>>> +# Wait background GC thread to wake up to run and potentially encounter the inconsistency
>>>>>> +sleep 5
>>>>>
>>>>> Does this sleep try to wait above "echo 1 > /sys/fs/f2fs/$dev_name/gc_urgent"?
>>>>> If so, it makes more sense to move it into the "if-then" logic.
>>>>>
>>>>>> +
>>>>>> +_scratch_unmount >> $seqres.full 2>&1
>>>>>                     ^^^^^^^^^^^^^^^^^^^^
>>>>> Same as above.
>>>>
>>>> Will fix.
>>>>
>>>>>
>>>>>> +
>>>>>> +# Check whether the dmesg has the warning indicating the bug
>>>>>> +_check_dmesg_for "F2FS-fs \($dev_name\): Inconsistent segment" && \
>>>>>> +	_fail "F2FS-fs ($dev_name): Inconsistent segment type detected in dmesg!"
>>>>>> +
>>>>>> +echo "Silence is golden"
>>>>>> +status=0
>>>>>> +exit
>>>>>
>>>>> We've replaced "status=0;exit;" with "_exit 0".
>>>>
>>>> Will fix.
>>>>
>>>> Thanks,
>>>>
>>>>>
>>>>> Thanks,
>>>>> Zorro
>>>>>
>>>>>> diff --git a/tests/f2fs/025.out b/tests/f2fs/025.out
>>>>>> new file mode 100644
>>>>>> index 000000000..3d70951ef
>>>>>> --- /dev/null
>>>>>> +++ b/tests/f2fs/025.out
>>>>>> @@ -0,0 +1,2 @@
>>>>>> +QA output created by 025
>>>>>> +Silence is golden
>>>>>> -- 
>>>>>> 2.49.0
>>>>>>
>>>>
>>>>
>>
>>

