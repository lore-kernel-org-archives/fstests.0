Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804BBC433F5
	for <linux-fstests@archiver.kernel.org>; Tue, 26 Oct 2021 23:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60E40610CA
	for <linux-fstests@archiver.kernel.org>; Tue, 26 Oct 2021 23:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237313AbhJZXx0 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 26 Oct 2021 19:53:26 -0400
Received: from mail110.syd.optusnet.com.au ([211.29.132.97]:36031 "EHLO
        mail110.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240358AbhJZXx0 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 26 Oct 2021 19:53:26 -0400
Received: from dread.disaster.area (pa49-180-20-157.pa.nsw.optusnet.com.au [49.180.20.157])
        by mail110.syd.optusnet.com.au (Postfix) with ESMTPS id 0DFD81091B3;
        Wed, 27 Oct 2021 10:50:59 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mfWDa-001PvB-Mr; Wed, 27 Oct 2021 10:50:58 +1100
Date:   Wed, 27 Oct 2021 10:50:58 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: _require_dm_target should not always skip DAX
 capable devices
Message-ID: <20211026235058.GB4821@dread.disaster.area>
References: <20211026023622.914273-1-david@fromorbit.com>
 <20211026154240.GN24282@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211026154240.GN24282@magnolia>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=61789464
        a=t5ERiztT/VoIE8AqcczM6g==:117 a=t5ERiztT/VoIE8AqcczM6g==:17
        a=kj9zAlcOel0A:10 a=8gfv0ekSlNoA:10 a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8
        a=xYYeyFSKwj0hdMXAC10A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Oct 26, 2021 at 08:42:40AM -0700, Darrick J. Wong wrote:
> On Tue, Oct 26, 2021 at 01:36:22PM +1100, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > Recent changes have turned off all dm-error, dm-thin and dm-flakey
> > tests on pmem devices even when we are not explicitly testing DAX.
> > This is a regression resulting in a large number of log recovery
> > tests no longer running on my pmem-based test VMs. I added the "-o
> > dax=never" mount options to these test configs, only to find it
> > still would not run the dm tests even though the filesystem will
> > never use DAX.
> > 
> > Fix this so that the dm target DAX test explicitly ignores the
> > the block device DAX capability when the filesystem is mounted with
> > dax=never and hence we can use all the dm targets when the tests are
> > being run with FSDAX disabled.
> > 
> > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > ---
> >  common/rc | 21 +++++++++++++++------
> >  1 file changed, 15 insertions(+), 6 deletions(-)
> > 
> > diff --git a/common/rc b/common/rc
> > index 7f693d39..0cbe8a7d 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -1965,12 +1965,19 @@ _require_sane_bdev_flush()
> >  }
> >  
> >  # Decide if the scratch filesystem is likely to be mounted in fsdax mode.
> > -# If there's a dax clause in the mount options we assume the test runner
> > -# wants us to test DAX; or if the scratch device itself advertises dax mode
> > -# in sysfs.
> > -__detect_scratch_fsdax()
> > +# It goes 3 ways based on mount options::
> > +#	1. "dax" or "dax=always" means always test using DAX
> > +#	2. "dax=never" means we'll never use DAX
> > +#	3. "dax=inode" or nothing means "use scratch dev capability" to
> > +#	    determine whether DAX is going to be used.
> > +#
> > +# Returns 0 if DAX will be used, 1 if DAX is not going to be used.
> > +__scratch_uses_fsdax()
> >  {
> > -	_normalize_mount_options | egrep -q "dax(=always| |$)" && return 0
> > +	local ops=$(_normalize_mount_options)
> > +
> > +	echo $ops | egrep -q "dax(=always| |$)" && return 0
> > +	echo $ops | grep -q "dax=never" && return 1
> 
> Question: Do you want grep -w here so that grep won't match on anything
> that isn't a whole "word"?
> 
> e.g. MOUNT_OPTIONS="-o ihatedax=alwaysp*****gmeoff" shouldn't be a
> match, right?

At which point fstests will be useless because the scratch device
won't mount.... :/

But, sure, if we care about people fuzzing fstests mount options
that much we can make it "grep -qw"....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
