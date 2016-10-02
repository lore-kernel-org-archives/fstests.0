Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:64925 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751227AbcJBVmb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 2 Oct 2016 17:42:31 -0400
Date: Mon, 3 Oct 2016 08:42:26 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH V2 2/2] fs/super.c: don't fool lockdep in freeze_super()
 and thaw_super() paths
Message-ID: <20161002214225.GS9806@dastard>
References: <20160926160724.GA6739@redhat.com>
 <20160926160806.GB6748@redhat.com>
 <20160926161856.GB32458@quack2.suse.cz>
 <20160926165525.GA9338@redhat.com>
 <20160927065135.GA1139@quack2.suse.cz>
 <20160927172901.GA11879@redhat.com>
 <20160930171434.GA2373@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160930171434.GA2373@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>, Nikolay Borisov <kernel@kyup.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Sep 30, 2016 at 07:14:34PM +0200, Oleg Nesterov wrote:
> On 09/27, Oleg Nesterov wrote:
> >
> > On 09/27, Jan Kara wrote:
> > >
> > > You can run either:
> > >
> > > 	./check -g freeze
> >
> > passed all 6 tests.
> >
> > > to check just the freezing tests or
> > >
> > > 	./check
> > >
> > > to run all sensible tests which is what I'd do (but it will take couple of
> > > hours to pass). If that passes, chances are good there are no easy false
> > > positives.
> >
> > It seems that generic/001 just hangs on my laptop. With or without this change.
> > Or perhaps I didn't wait enough...
> 
> /usr/bin/awk spins in user-mode forever, according to strace it doesn't do
> any syscalls. I didn't even try to investigate.

Are you using gawk, or some other version of awk? gawk doesn't have
any problems (it is listed as a prereq package in the README file)
that anyone has reported, and there are a lot of people using it...

> > Or perhaps something is wrong with my very
> > limited testing environment. I'll reserve a testing machine tomorrow.
> 
> Jan, I gave up.
> 
> Whatever I did xfstests-dev/check reports a lot of failures, kernel bugs,
> and finally either crashes the kernel or hangs.

Did you run the auto group like I suggested? That's the set of tests
that should complete successfully with minimal failures and without
crashing the machine. If you're running this group and there's
failures, hangs and crashes all over the place, then you need to
start reporting bugs because that should not be happening on any
kernel....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
