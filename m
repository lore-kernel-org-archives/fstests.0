Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:33534 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064AbbCAItT (ORCPT
	<rfc822;fstests@vger.kernel.org>); Sun, 1 Mar 2015 03:49:19 -0500
Received: by widem10 with SMTP id em10so8091983wid.0
        for <fstests@vger.kernel.org>; Sun, 01 Mar 2015 00:49:18 -0800 (PST)
Message-ID: <54F2D28C.8070903@plexistor.com>
Date: Sun, 01 Mar 2015 10:49:16 +0200
From: Boaz Harrosh <boaz@plexistor.com>
MIME-Version: 1.0
Subject: Re: ramdisk problems in 4.0-rc1? (was Re: [PATCH 1/4] xfs/104: log
 size too small for 4k sector drives)
References: <1424818479-10083-1-git-send-email-david@fromorbit.com> <1424818479-10083-2-git-send-email-david@fromorbit.com> <20150225161151.GC28053@bfoster.bfoster> <20150225223248.GH4251@dastard> <20150225233115.GA1009@bfoster.bfoster> <20150225234343.GI4251@dastard> <54EECF53.8010207@plexistor.com> <20150226172313.GA2520@laptop.bfoster>
In-Reply-To: <20150226172313.GA2520@laptop.bfoster>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Brian Foster <bfoster@redhat.com>, Jens Axboe <axboe@fb.com>
Cc: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 02/26/2015 07:23 PM, Brian Foster wrote:
<>
> 
> Thanks Boaz, but I still see the same behavior with the part_show patch.
> It seems to be something that broke in systemd on Fedora between
> versions systemd-218 and systemd-219. The latter is broken on a 3.19
> kernel as well.
> 
> I've filed a systemd bug so we'll see what comes of it from that end:
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=1196452
> 
> Brian
> 

Hi Brian

It says in bugzilla (link above) that this issue is "fixed in git" so
I guess we should be fine ?

Jens does *not* need to take
	[PATCH] brd: Re-instate ram disk visibility option (part_show)

Please confirm.

Please tell me if there is anything I can help with?

Thanks
Boaz

