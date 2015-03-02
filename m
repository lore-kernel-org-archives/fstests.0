Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:35287 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753364AbbCBJkj (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 2 Mar 2015 04:40:39 -0500
Received: by wibbs8 with SMTP id bs8so13344775wib.0
        for <fstests@vger.kernel.org>; Mon, 02 Mar 2015 01:40:37 -0800 (PST)
Message-ID: <54F43013.10305@plexistor.com>
Date: Mon, 02 Mar 2015 11:40:35 +0200
From: Boaz Harrosh <boaz@plexistor.com>
MIME-Version: 1.0
Subject: Re: ramdisk problems in 4.0-rc1? (was Re: [PATCH 1/4] xfs/104: log
 size too small for 4k sector drives)
References: <1424818479-10083-1-git-send-email-david@fromorbit.com> <1424818479-10083-2-git-send-email-david@fromorbit.com> <20150225161151.GC28053@bfoster.bfoster> <20150225223248.GH4251@dastard> <20150225233115.GA1009@bfoster.bfoster> <20150225234343.GI4251@dastard> <54EECF53.8010207@plexistor.com> <20150227005837.GG18360@dastard> <54F2CD85.3060303@plexistor.com> <20150302010924.GQ4251@dastard>
In-Reply-To: <20150302010924.GQ4251@dastard>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>, Boaz Harrosh <boaz@plexistor.com>
Cc: Brian Foster <bfoster@redhat.com>, fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org, axboe@fb.com
List-ID: <fstests@vger.kernel.org>

On 03/02/2015 03:09 AM, Dave Chinner wrote:
> On Sun, Mar 01, 2015 at 10:27:49AM +0200, Boaz Harrosh wrote:
>> On 02/27/2015 02:58 AM, Dave Chinner wrote:
<>
>> No the "if DAX" is for the 4k thing. The enablement of the uevents is
>> with a new "part_show" module parameter (See patch-1).
> 
> Sure, but that doesn't answer my question: what is generating device
> level uevents when all I'm doing is mkfs/mount/umount on the device?
> 

I was suspecting it is this systemd bug which keeps trying to tier-down
the devices.

>>> I'm not sure how to go about finding that
>>> trigger right now and as such I won't really have time to look at it
>>> until after lsfmm/vault...
>>>
>>
>> I'll try to reproduce this here. What Fedora version do I need?
> 
> I'm running debian unstable w/ systemd-215 on the particular test
> machine that is hitting this problem.
> 

Oooff, On my fedora 20 I'm at systemd 208. I'll see if I have time to
install an fc21 vm or maybe upgrade from source. (Any easy way?)

I have setup my xfs rig and ran "./check -g auto" by now. I tried both
part_show=1/0 and both look working as expected.
(Do I need any special $MKFS_OPTIONS or anything else)

I'll probably be giving up soon, and will just wait for more reports.

With the patch-1 I sent I am reverting to old behavior so I need a
reproducer to try and run with patch-1 and part_show=1 should show
the problem and part_show=0 should not. Else this is something else

> Cheers,
> Dave.
> 

Thanks Dave, sorry for trapping you in this boring mess, life
at Kernel the one reproducing the problem needs to help fix it ;-)

Have an enjoyable and productive LSF
Thanks
Boaz

