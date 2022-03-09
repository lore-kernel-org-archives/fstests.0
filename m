Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF89EC433F5
	for <linux-fstests@archiver.kernel.org>; Wed,  9 Mar 2022 07:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbiCIHfb (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 9 Mar 2022 02:35:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiCIHfa (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 9 Mar 2022 02:35:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBD9162023
        for <fstests@vger.kernel.org>; Tue,  8 Mar 2022 23:34:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 666F761999
        for <fstests@vger.kernel.org>; Wed,  9 Mar 2022 07:34:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B503C340E8;
        Wed,  9 Mar 2022 07:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646811271;
        bh=rTKxb57bycgvdehhRlTtdgsGDA+8TkLS2+mydnbohzg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZC0rCB5Zwq4ufyfjNyN3cVotqBvcP7x698vFuQy88bEwhwPT0aKWOojTkzTMmLi1q
         r3jJ+Hr5fHwXTTXt6cFIrCR+czfJTnkfaXoHmQfRMdzLw7Eqyz6urAAaf9WSGgxvDY
         poMzWHDVYzYMwP2fVFMam8JWqV29ug2bKu3Mx+dj3r8zcXdYRRjBmR4jazKAX17HxZ
         owcJubQRqNSfGbZ7t6M1bvn6U53BNYgQxNhTzlK7RUP4bIiYEpXc3SVAFJ+xaoc79O
         2HtSvxSEsRxgO4kIamVM7TAdhJAe1xoMh4QXkzJQrlCKuDF+w6A8oK5klzZ8EI9+tt
         YK8pG6/PTAAHg==
Message-ID: <0a5c5efd-597e-7d13-9008-195cf6cf83f1@kernel.org>
Date:   Wed, 9 Mar 2022 15:34:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [f2fs-dev] [PATCH] generic/066: attr1 is still there after log
 replay on f2fs
Content-Language: en-US
To:     Dave Chinner <david@fromorbit.com>
Cc:     jaegeuk@kernel.org, Sun Ke <sunke32@huawei.com>, guan@eryu.me,
        fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
References: <20220228035719.4102745-1-sunke32@huawei.com>
 <cd2a245e-b9d2-c09c-0f8c-a7ca9157ca9f@oppo.com>
 <20220309062223.GY3927073@dread.disaster.area>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220309062223.GY3927073@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 2022/3/9 14:22, Dave Chinner wrote:
> On Wed, Mar 09, 2022 at 12:31:17PM +0800, Chao Yu wrote:
>> On 2022/2/28 11:57, Sun Ke via Linux-f2fs-devel wrote:
>>> The test fail on f2fs:
>>>        xattr names and values after second fsync log replay:
>>>        # file: SCRATCH_MNT/foobar
>>>       +user.attr1="val1"
>>>        user.attr3="val3"
>>>
>>> attr1 is still there after log replay.
>>> I guess it is f2fs's special feature to improve the performance.
>>>
>>> Signed-off-by: Sun Ke <sunke32@huawei.com>
>>> ---
>>>
>>> Is it a BUG on f2fs?
>>
>> I don't think so, it fails due to f2fs doesn't follow recovery rule which
>> btrfs/ext4/xfs does, but it doesn't mean f2fs has break posix semantics of
>> fsync().
> 
> I disagree.  A failure in this test is indicative of non-conformance
> with the Linux definition of fsync() behaviour.
> 
> You are right in that it does not break POSIX fsync semantics, but
> POSIX allows "do nothing" as a valid implementation. However,
> because of this loophole, the POSIX definition is complete garbage
> and we do not use it.
> 
> That behaviour that Linux filesytsems are supposed to implement is
> defined in the Linux fsync() man page, and it goes way beyond what
> POSIX requires:
> 
> $ man fsync
> ....
> DESCRIPTION
>      fsync() transfers ("flushes") all modified in-core data of
>      (i.e., modified buffer cache pages for) the file referred to by
>      the file descriptor fd to the disk device (or other permanent
>      storage device) so that all changed information can be retrieved
>      even if the  system  crashes  or  is rebooted.  This includes
>      writing through or flushing a disk cache if present.  The call
>      blocks until the device reports that the transfer has
>      completed.
> 
>      As well as flushing the file data, fsync() also flushes the
>      metadata information associated with the file (see inode(7)).
> ....
> 
> IOWs, fsync() on Linux is supposed to persist all data and
> metadata associated with the inode to stable storage such that it
> can be retreived after a crash or reboot. "metadata information"
> includes xattrs attached to the inode that is being fsync()d.

Quoted from g/066:

echo "hello world!" >> $SCRATCH_MNT/foobar
$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/foobar
$SETFATTR_PROG -x user.attr1 $SCRATCH_MNT/foobar
ln $SCRATCH_MNT/foobar $SCRATCH_MNT/foobar_link
touch $SCRATCH_MNT/qwerty
$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/qwerty

IIUC, to match what Linux fsync() manual restricts, if we want to persist the
xattr removal, we should call fsync() on $SCRATCH_MNT/foobar after
"$SETFATTR_PROG -x user.attr1 $SCRATCH_MNT/foobar"? rather than calling fsync()
on unrelated $SCRATCH_MNT/qwerty.

Thanks,

> 
> *fdatasync()* does not require xattrs to be persisted unless
> they are needed to retreive data, but that's not what g/066 is
> exercising.
> 
> Cheers,
> 
> Dave.
