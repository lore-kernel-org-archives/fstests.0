Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:40140 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984AbbCAI1w (ORCPT
	<rfc822;fstests@vger.kernel.org>); Sun, 1 Mar 2015 03:27:52 -0500
Received: by wghl18 with SMTP id l18so27805917wgh.7
        for <fstests@vger.kernel.org>; Sun, 01 Mar 2015 00:27:51 -0800 (PST)
Message-ID: <54F2CD85.3060303@plexistor.com>
Date: Sun, 01 Mar 2015 10:27:49 +0200
From: Boaz Harrosh <boaz@plexistor.com>
MIME-Version: 1.0
Subject: Re: ramdisk problems in 4.0-rc1? (was Re: [PATCH 1/4] xfs/104: log
 size too small for 4k sector drives)
References: <1424818479-10083-1-git-send-email-david@fromorbit.com> <1424818479-10083-2-git-send-email-david@fromorbit.com> <20150225161151.GC28053@bfoster.bfoster> <20150225223248.GH4251@dastard> <20150225233115.GA1009@bfoster.bfoster> <20150225234343.GI4251@dastard> <54EECF53.8010207@plexistor.com> <20150227005837.GG18360@dastard>
In-Reply-To: <20150227005837.GG18360@dastard>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Brian Foster <bfoster@redhat.com>, fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org, axboe@fb.com
List-ID: <fstests@vger.kernel.org>

On 02/27/2015 02:58 AM, Dave Chinner wrote:
<>
>>
>> Sigh, thanks Dave. Yes you are correct my patch enabled the
>> udev events, as part of fixing ramdisk with partitions.
>> This is because if you do not enable them then mount by UUID
>> and all sort of lsblk and friends do not work.
> 
> Sure, that's what the gendisk abstraction just you. But why am I
> seeing random partition probes on a ramdisk that *isn't using
> partitions*?
> 

Yes, There should be the one new event on create (modprobe or
mknod) which was not there before. Perhaps it triggers a systemd
process that never used to run before. (And is now sitting there
and making a mess)

<>
>> It looks like the system anticipates that ramdisk "should
>> not have these events"
> 
> Right, but not because it's a ramdisk. Those events should not be
> occurring because I'm not creating or destroying devices, I'm not
> changing partition tables, I'm not resizing ramdisks or partitions,
> and so on. I'm simply mkfs'ing, mounting and unmounting filesystems
> on the ramdisks - nothing should be generating device based udev
> events...
> 
> Finding the trigger that is causing these events will tell us what
> the bug is - 

> restricting the config won't help, especially as DAX
> will *always* be enabled on my test machines as it's something
> needed in my test matrix.

No the "if DAX" is for the 4k thing. The enablement of the uevents is
with a new "part_show" module parameter (See patch-1).

> I'm not sure how to go about finding that
> trigger right now and as such I won't really have time to look at it
> until after lsfmm/vault...
> 

I'll try to reproduce this here. What Fedora version do I need?

> Cheers,
> Dave.
> 

Thanks
Boaz

