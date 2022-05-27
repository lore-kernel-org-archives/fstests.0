Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6821DC433EF
	for <linux-fstests@archiver.kernel.org>; Fri, 27 May 2022 09:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350484AbiE0JOO (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 27 May 2022 05:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350504AbiE0JNl (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 27 May 2022 05:13:41 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 90884F6880
        for <fstests@vger.kernel.org>; Fri, 27 May 2022 02:13:32 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id BD96210E6B79;
        Fri, 27 May 2022 19:13:31 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nuW2E-00Gxwx-IH; Fri, 27 May 2022 19:13:30 +1000
Date:   Fri, 27 May 2022 19:13:30 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] common/rc: filter out extra mount error
Message-ID: <20220527091330.GE3923443@dread.disaster.area>
References: <20220526095704.3772355-1-zlang@kernel.org>
 <20220526234506.GC3923443@dread.disaster.area>
 <20220527042129.n3lmqzxzeghuulxp@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527042129.n3lmqzxzeghuulxp@zlang-mailbox>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=6290963c
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=oZkIemNP1mAA:10 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8
        a=Ixf5BKOTa5h3wiDJLkoA:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, May 27, 2022 at 12:21:29PM +0800, Zorro Lang wrote:
> On Fri, May 27, 2022 at 09:45:06AM +1000, Dave Chinner wrote:
> > On Thu, May 26, 2022 at 05:57:04PM +0800, Zorro Lang wrote:
> > > The lastest mount command (from util-linux) merged below commit:
> > >   79534c0d7e0f ("mount: add hint about dmesg(8) to error messages")
> > > which brought in a new error output when mount fails.
> > > 
> > > That cause some cases (e.g. xfs/005) fail as:
> > >   mount: Structure needs cleaning
> > >          dmesg(1) may have more information after failed mount system call
> > > 
> > > More failed cases like generic/050, ext4/002, xfs/154, etc ...
> > > 
> > > Signed-off-by: Zorro Lang <zlang@kernel.org>
> > > ---
> > > 
> > > Due to _try_scratch_mount is call in many places, so I'm not sure if it's good
> > > to filter this message in _try_scratch_mount. Maybe better to filter it in each
> > > failed cases? Or write another function (e.g. _try_scratch_mount_fail) ?
> > > Welcome review points.
> > > 
> > > Thanks,
> > > Zorro
> > > 
> > >  common/rc | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/common/rc b/common/rc
> > > index 70a15f9c..67342760 100644
> > > --- a/common/rc
> > > +++ b/common/rc
> > > @@ -335,7 +335,8 @@ _try_scratch_mount()
> > >  		_overlay_scratch_mount $*
> > >  		return $?
> > >  	fi
> > > -	_mount -t $FSTYP `_scratch_mount_options $*`
> > > +	_mount -t $FSTYP `_scratch_mount_options $*`  2> \
> > > +		>(grep -v "dmesg(1) may have more information after failed mount" >&2)
> > 
> > _filter_error_mount()?
> 
> OK, how about this change [1] ?
> 
> Do you think doing this "filter out" in _try_scratch_mount is better, or in
> each case which expects mount failures in .out file (e.g. xfs/005) ? Or a new
> _try_scratch_mount_fail() ?

I think you missed my point entirely. We already have a filter for this in
common/filter because util-linux has changed it's failure message for
EFSCORRUPTED several times:

# Filter a failed mount output due to EUCLEAN and USTALE, util-linux changed
# the message several times.
#
# prior to v2.21:
# mount: Structure needs cleaning
# v2.21 to v2.29:
# mount: mount <device> on <mountpoint> failed: Structure needs cleaning
# v2.30 and later:
# mount: <mountpoint>: mount(2) system call failed: Structure needs cleaning.
#
# This is also true for ESTALE error. So let's remove all the changing parts
# and keep the 'prior to v2.21' format:
# mount: Structure needs cleaning
# mount: Stale file handle
_filter_error_mount()
{
        sed -e "s/mount:\(.*failed:\)/mount:/" | _filter_ending_dot
}


So, capture and supress the new output via _filter_error_mount() and
use that in the specific tests that are trying to mount a corrupt
filesystem and capture that specific error message in their golden
output....

Cheers,

Dave.


-- 
Dave Chinner
david@fromorbit.com
