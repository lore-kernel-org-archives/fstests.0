Received: from mx2.suse.de ([195.135.220.15]:49767 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933484AbeE1QNt (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 28 May 2018 12:13:49 -0400
Date: Mon, 28 May 2018 11:37:58 +0200
From: Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] Make ./new work for non-root user
Message-ID: <20180528093758.va5pnwchjrgmb3sf@quack2.suse.cz>
References: <20180524183055.16031-1-jack@suse.cz>
 <20180525013034.GD10363@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180525013034.GD10363@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Jan Kara <jack@suse.cz>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri 25-05-18 11:30:34, Dave Chinner wrote:
> On Thu, May 24, 2018 at 08:30:55PM +0200, Jan Kara wrote:
> > Currently 'new' script sources common/config which tries to find mkfs
> > and fails if not found (which is likely for non-root user). This is
> > inconvenient as development usually does not happen as root. In fact the
> > vast majority of setup in common/config and common/rc is not necessary
> > for 'new'. Split out the necessary bits into new common/config-base and
> > use it in 'new'. Cleanup common/rc and common/config now that it's only
> > used from 'check'.
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> ....
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -20,18 +20,9 @@
> >  #  Mountain View, CA 94043, USA, or: http://www.sgi.com
> >  #-----------------------------------------------------------------------
> >  
> > -BC=$(which bc 2> /dev/null) || BC=
> > +. common/config
> 
> Doesn't this means we now include common/config in every test setup
> routine, even though the environment it sets up is inherited from
> the check function.

What you describe was happening already in the past AFAICT. The test gets
executed as "./$seq" so only exported variables are inherited.  Thus 'iam'
variable is not set when executing the test and therefore common/rc was
already including common/config. Also including common/config in each test
is even required to get functions declared there. Am I missing something?

> If so, that's going to add significantly to the individual test
> startup time (which already takes a significant fraction of a
> second) and this happens hundreds of times over an auto run instead
> of only once when we start the test run. It seems wrong to be doing
> this over and over again unecessarily....

I agree but it's not a new problem introduced by my patch. I've just kept
the current status and tried to make the initialization less confusing.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
