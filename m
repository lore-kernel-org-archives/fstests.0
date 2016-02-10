Received: from imap.thunk.org ([74.207.234.97]:57298 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751201AbcBJQHe (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 10 Feb 2016 11:07:34 -0500
Date: Wed, 10 Feb 2016 11:07:32 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH 05/12] xfstests: do not unmount tmpfs during remount
Message-ID: <20160210160732.GE26922@thunk.org>
References: <1455069001-17846-1-git-send-email-tytso@mit.edu>
 <1455069001-17846-6-git-send-email-tytso@mit.edu>
 <20160210060716.GV19486@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160210060716.GV19486@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, hughd@google.com, Junho Ryu <jayr@google.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Feb 10, 2016 at 05:07:16PM +1100, Dave Chinner wrote:
> >  # Remounting with nodiratime option
> > -_scratch_unmount
> > -_scratch_mount "-o nodiratime"
> > +_scratch_remount "-o nodiratime"
> 
> This makes me go "no, that can't work, nodiratime is not an option
> that we allow on remount."

Hmm, yes, we're not consistent here.  xfs doesn't allow nodiratime on
remounts.  ext4 allows nodiratime on remount, but not diratime, so
there's no way to clear nodiratime once its set.  tmpfs allows
diratime and nodiratime on remount.

I wonder if it's worth it make things more consistent across the
various file systems.  What do you think?

> So, at minimum, the name of the helper needs to get changed so that
> it doesn't imply that a "-o remount" with new options is being
> done...

Hmm, how about having two helper functions: _scratch_remount that
doesn't take any arguments, and a _scratch_change_mount_opts which
does?

> > -_umount_mount
> > +_scratch_mkfs >/dev/null 2>&1 || _fail "mkfs failed"
> > +_scratch_mount > /dev/null 2>&1 || _fail "mount failed"
> 
> Please don't add _fail to mkfs/mount like this, especially where the
> test doesn't already have them.

Could you say more about why?  We do have tests that do use _fail if
the mkfs or mount fails.  Should we be changing them to remove it?
But if we do that, and the mount fails for some reason, then won't
things stagger on and perhaps make life harder to debug.

Cheers,

						- Ted

