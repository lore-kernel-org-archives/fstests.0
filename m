Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58BA4C433EF
	for <linux-fstests@archiver.kernel.org>; Fri, 11 Mar 2022 07:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243350AbiCKHPN (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 11 Mar 2022 02:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239140AbiCKHPL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 11 Mar 2022 02:15:11 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDECC11861B
        for <fstests@vger.kernel.org>; Thu, 10 Mar 2022 23:14:07 -0800 (PST)
Received: from kwepemi500026.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KFH9Q3B3Dzcb4R;
        Fri, 11 Mar 2022 15:09:14 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 kwepemi500026.china.huawei.com (7.221.188.247) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 11 Mar 2022 15:14:05 +0800
Received: from [10.174.178.31] (10.174.178.31) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Mar 2022 15:14:05 +0800
Subject: Re: [f2fs-dev] [PATCH] generic/066: attr1 is still there after log
 replay on f2fs
To:     Chao Yu <chao@kernel.org>, Dave Chinner <david@fromorbit.com>
CC:     <jaegeuk@kernel.org>, <guan@eryu.me>, <fstests@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20220228035719.4102745-1-sunke32@huawei.com>
 <cd2a245e-b9d2-c09c-0f8c-a7ca9157ca9f@oppo.com>
 <20220309062223.GY3927073@dread.disaster.area>
 <0a5c5efd-597e-7d13-9008-195cf6cf83f1@kernel.org>
 <20220310014139.GZ3927073@dread.disaster.area>
 <99e07f53-0d37-7a7d-38af-6077ab5ba00e@kernel.org>
From:   Sun Ke <sunke32@huawei.com>
Message-ID: <ded07acc-23d8-7100-8838-099b64332a15@huawei.com>
Date:   Fri, 11 Mar 2022 15:14:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <99e07f53-0d37-7a7d-38af-6077ab5ba00e@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.31]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



在 2022/3/10 15:33, Chao Yu 写道:
> On 2022/3/10 9:41, Dave Chinner wrote:
>> On Wed, Mar 09, 2022 at 03:34:27PM +0800, Chao Yu wrote:
>>> On 2022/3/9 14:22, Dave Chinner wrote:
>>>> On Wed, Mar 09, 2022 at 12:31:17PM +0800, Chao Yu wrote:
>>>>> On 2022/2/28 11:57, Sun Ke via Linux-f2fs-devel wrote:
>>>>>> The test fail on f2fs:
>>>>>>         xattr names and values after second fsync log replay:
>>>>>>         # file: SCRATCH_MNT/foobar
>>>>>>        +user.attr1="val1"
>>>>>>         user.attr3="val3"
>>>>>>
>>>>>> attr1 is still there after log replay.
>>>>>> I guess it is f2fs's special feature to improve the performance.
>>>>>>
>>>>>> Signed-off-by: Sun Ke <sunke32@huawei.com>
>>>>>> ---
>>>>>>
>>>>>> Is it a BUG on f2fs?
>>>>>
>>>>> I don't think so, it fails due to f2fs doesn't follow recovery rule 
>>>>> which
>>>>> btrfs/ext4/xfs does, but it doesn't mean f2fs has break posix 
>>>>> semantics of
>>>>> fsync().
>>>>
>>>> I disagree.  A failure in this test is indicative of non-conformance
>>>> with the Linux definition of fsync() behaviour.
>>>>
>>>> You are right in that it does not break POSIX fsync semantics, but
>>>> POSIX allows "do nothing" as a valid implementation. However,
>>>> because of this loophole, the POSIX definition is complete garbage
>>>> and we do not use it.
>>>>
>>>> That behaviour that Linux filesytsems are supposed to implement is
>>>> defined in the Linux fsync() man page, and it goes way beyond what
>>>> POSIX requires:
>>>>
>>>> $ man fsync
>>>> ....
>>>> DESCRIPTION
>>>>       fsync() transfers ("flushes") all modified in-core data of
>>>>       (i.e., modified buffer cache pages for) the file referred to by
>>>>       the file descriptor fd to the disk device (or other permanent
>>>>       storage device) so that all changed information can be retrieved
>>>>       even if the  system  crashes  or  is rebooted.  This includes
>>>>       writing through or flushing a disk cache if present.  The call
>>>>       blocks until the device reports that the transfer has
>>>>       completed.
>>>>
>>>>       As well as flushing the file data, fsync() also flushes the
>>>>       metadata information associated with the file (see inode(7)).
>>>> ....
>>>>
>>>> IOWs, fsync() on Linux is supposed to persist all data and
>>>> metadata associated with the inode to stable storage such that it
>>>> can be retreived after a crash or reboot. "metadata information"
>>>> includes xattrs attached to the inode that is being fsync()d.
>>>
>>> Quoted from g/066:
>>>
>>> echo "hello world!" >> $SCRATCH_MNT/foobar
>>> $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/foobar
>>> $SETFATTR_PROG -x user.attr1 $SCRATCH_MNT/foobar
>>> ln $SCRATCH_MNT/foobar $SCRATCH_MNT/foobar_link
>>> touch $SCRATCH_MNT/qwerty
>>> $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/qwerty
>>>
>>> IIUC, to match what Linux fsync() manual restricts, if we want to 
>>> persist the
>>> xattr removal, we should call fsync() on $SCRATCH_MNT/foobar after
>>> "$SETFATTR_PROG -x user.attr1 $SCRATCH_MNT/foobar"? rather than 
>>> calling fsync()
>>> on unrelated $SCRATCH_MNT/qwerty.
>>
>> It might look that way, but it's not that straight forward: there's
>> a carefully constructed object dependency chain in this test that
>> defines what the correct behaviour should be here.
>>
>> What's the link count of $SCRATCH_MNT/foobar when
>> $SCRATCH_MNT/qwerty is present after recovery? Is it 1 or 2?  Does
>> $SCRATCH_MNT/foobar_link exist?  And if $SCRATCH_MNT/foobar_link
>> exists, and the link count is 2. The test doesn't even look at these
>> things, but if user.attr1 is not present, it means that foobar_link
>> and qwerty are present, $SCRATCH_MNT has a link count of 5 and
>> foobar has a link count of 2 because that's the dependency chain
>> that leads to the user.attr1 removal being recovered correctly.
>>
>> So what does SCRATCH_MNT actually contain when f2fs fails this test?
> 
> After f2fs recovery,
> 
> SCRATCH_MNT contains two files: foobar and qwerty, link count of both
> files is 1, and foobar has two xattr entries: user.attr1 and user.attr3.
> 
> So it means, f2fs only recover file/directory which has been fsync()ed 
> before
> SPO... since f2fs doesn't support fs-op level transaction functionality, 
> so it
> have no way to persist all metadata updates in one transaction.
> 
> There is one alternative method to pass this case, as I suggested, we can
> use "fastboot" mountoption for this case, so during last fsync on qwerty,
> f2fs can trigger a checkpoint which will persist all metadata updates 
> before
> fsync()...
> 
> Thanks,

The test can pass by using "fastboot" mountoption. I will send v2.

Thanks,
Sun Ke
> 
>>
>> These depedencies exist because we can't just randomly re-order
>> recovery of modifications to individual inodes and certain
>> operations create atomic change dependencies between inodes. It's
>> those atomic change dependencies that this test is actually
>> exercising.  i.e. the link count changes tie directory modifications
>> to inode modifications and this creates cross-object ordering
>> dependencies down the line that fsync then exposes. That's what the
>> second part of this test is actually exercising....
>>
>> Cheers,
>>
>> Dave.
> .
