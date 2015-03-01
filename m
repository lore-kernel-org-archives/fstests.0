Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:33473 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751941AbbCAIa1 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Sun, 1 Mar 2015 03:30:27 -0500
Received: by wghb13 with SMTP id b13so27843187wgh.0
        for <fstests@vger.kernel.org>; Sun, 01 Mar 2015 00:30:26 -0800 (PST)
Message-ID: <54F2CE21.6080206@plexistor.com>
Date: Sun, 01 Mar 2015 10:30:25 +0200
From: Boaz Harrosh <boaz@plexistor.com>
MIME-Version: 1.0
Subject: Re: [PATCH] brd: Only request 4K sectors if DAX is enabled
References: <1424818479-10083-1-git-send-email-david@fromorbit.com> <1424818479-10083-2-git-send-email-david@fromorbit.com> <20150225161151.GC28053@bfoster.bfoster> <20150225223248.GH4251@dastard> <54EED5F6.2030804@plexistor.com> <54EEDC4A.8090000@plexistor.com> <20150227002302.GF18360@dastard>
In-Reply-To: <20150227002302.GF18360@dastard>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Jens Axboe <axboe@fb.com>, Brian Foster <bfoster@redhat.com>, fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 02/27/2015 02:23 AM, Dave Chinner wrote:
> On Thu, Feb 26, 2015 at 10:41:46AM +0200, Boaz Harrosh wrote:
>>
>> People systems have been using ramdisk with
>> smaller-than-page-size blocks in their mkfs.
>>
>> The 4K sectors is only important if we will be
>> using brd with a DAX filesystem.
>>
>> So only enable 4K sectors if DAX is configured
> 
> 4k sectors are not a problem - we should be handling them fine and
> because it makes the ramdisk look like a 512e drive, no applications
> should fail, either.
> 
> The main "unexpected" part about it was how much of xfstests didn't
> handle 4k sectors in mkfs output properly. This isn't a problem with
> the kernel change and so doesn't need fixing.
> 

Glad to be of service ;-)

Please tell me if there is anything I can help with

> Cheers,
> Dave.
> 

Thanks
Boaz

