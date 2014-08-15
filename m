Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:40806 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752459AbaHOKab (ORCPT
	<rfc822;fstests@vger.kernel.org>); Fri, 15 Aug 2014 06:30:31 -0400
Received: by mail-lb0-f181.google.com with SMTP id 10so1766642lbg.40
        for <fstests@vger.kernel.org>; Fri, 15 Aug 2014 03:30:30 -0700 (PDT)
From: Dmitry Monakhov <dmonakhov@openvz.org>
Subject: Re: [PATCH 1/2] xfstest: shared/298 fixup mkfs options
In-Reply-To: <20140815004420.GI20518@dastard>
References: <1407944188-4099-1-git-send-email-dmonakhov@openvz.org> <20140815004420.GI20518@dastard>
Date: Fri, 15 Aug 2014 14:30:27 +0400
Message-ID: <87sikycaf0.fsf@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, 15 Aug 2014 10:44:20 +1000, Dave Chinner <david@fromorbit.com> wrote:
> On Wed, Aug 13, 2014 at 07:36:27PM +0400, Dmitry Monakhov wrote:
> > Currently mkfs faile due to incorrect options
> > 
> > Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
> > ---
> >  tests/shared/298 |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tests/shared/298 b/tests/shared/298
> > index 372fd02..685ba27 100755
> > --- a/tests/shared/298
> > +++ b/tests/shared/298
> > @@ -134,8 +134,8 @@ mkdir $loop_mnt
> >  
> >  [ "$FSTYP" = "xfs" ] && MKFS_OPTIONS="-f $MKFS_OPTIONS"
> >  
> > -$MKFS_PROG -t $FSTYP $MKFS_OPTIONS $loop_dev &> /dev/null
> > -$MOUNT_PROG $loop_dev $loop_mnt
> > +run_check $MKFS_PROG -t $FSTYP -- $MKFS_OPTIONS $loop_dev
> > +run_check $MOUNT_PROG $loop_dev $loop_mnt
> 
> Urk. Please don't propagate run_check into code that doesn't need
> it.
Ok. My idea was to check result before starting any IO activity
> 
> What we should do here is write a generic wrapper - _mkfs_dev -
> which allows you to pass in a device to run mkfs on.  This can then
> be implemented similar to _scratch_mkfs, and so avoid the need for
> everyone to re-invent the wheel slightly differently to support
> different filesystems on loop devices in generic/shared tests.
Agree, this is the only way to make things right. Will send new
version soon.
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
