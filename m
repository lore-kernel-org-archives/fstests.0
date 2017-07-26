Received: from mx2.suse.de ([195.135.220.15]:60208 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750816AbdGZIWP (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 26 Jul 2017 04:22:15 -0400
Date: Wed, 26 Jul 2017 10:22:13 +0200
From: Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] Ignore "yes: standard output: Broken pipe" errors
Message-ID: <20170726082213.GA13488@quack2.suse.cz>
References: <20170725143320.10882-1-jack@suse.cz>
 <20170726074719.GW9167@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170726074719.GW9167@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Jan Kara <jack@suse.cz>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed 26-07-17 15:47:19, Eryu Guan wrote:
> On Tue, Jul 25, 2017 at 04:33:20PM +0200, Jan Kara wrote:
> > Recently, some tests started failing because they had
> > 
> > yes: standard output: Broken pipe
> > 
> > in their output. Fix the problem by discarding errors from yes(1)
> > program.
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  common/rc         | 12 ++++++------
> >  tests/generic/081 |  2 +-
> >  tests/generic/108 |  2 +-
> >  3 files changed, 8 insertions(+), 8 deletions(-)
> 
> I'm wondering which case failed for you and what's the diff output and
> .full file? And what change caused the failure for you? Because I didn't
> see any failure on my RHEL7 box nor Fedora rawhide box. I compiled
> latest yes from coreutils git repo and didn't hit the error either.
> 
> So I suspect that it might be other commands in the pipeline that failed
> and caused the broken pipe.

I've started seeing failures after I've updated the testing VM to openSUSE
Leap 42.2. And yes(1) failing with this error is "normal" if SIGPIPE is
ignored - just try ( trap "" PIPE; yes | exit; ) and observe the error.
So it is just that in the new VM something makes yes(1) ignore SIGPIPE and
honestly I'm not sure what that is even though I've looked for a while. But
regardless of that, ignoring stderr from yes(1) seems like a safe thing to
do.

Regarding your question about failed tests: Tests generic/081, generic/347,
generic/361, shared/298, xfs/074 failed due to this and they all just had
this additional line in the output.

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
