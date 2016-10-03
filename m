Received: from mx1.redhat.com ([209.132.183.28]:39178 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753303AbcJCQpp (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 3 Oct 2016 12:45:45 -0400
Date: Mon, 3 Oct 2016 18:44:35 +0200
From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH V2 2/2] fs/super.c: don't fool lockdep in
        freeze_super() and thaw_super() paths
Message-ID: <20161003164435.GB6634@redhat.com>
References: <20160926160724.GA6739@redhat.com> <20160926160806.GB6748@redhat.com> <20160926161856.GB32458@quack2.suse.cz> <20160926165525.GA9338@redhat.com> <20160927065135.GA1139@quack2.suse.cz> <20160927172901.GA11879@redhat.com> <20160930171434.GA2373@redhat.com> <20161002214225.GS9806@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161002214225.GS9806@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>, Nikolay Borisov <kernel@kyup.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 10/03, Dave Chinner wrote:
>
> On Fri, Sep 30, 2016 at 07:14:34PM +0200, Oleg Nesterov wrote:
> > On 09/27, Oleg Nesterov wrote:
> > >
> > >
> > > It seems that generic/001 just hangs on my laptop. With or without this change.
> > > Or perhaps I didn't wait enough...
> >
> > /usr/bin/awk spins in user-mode forever, according to strace it doesn't do
> > any syscalls. I didn't even try to investigate.
>
> Are you using gawk, or some other version of awk? gawk doesn't have
> any problems

gawk, awk is symlink. And somehow this depends on userspace environment,
it doesn't hang on the full-blown Fedora 23.

> > Jan, I gave up.
> >
> > Whatever I did xfstests-dev/check reports a lot of failures, kernel bugs,
> > and finally either crashes the kernel or hangs.
>
> Did you run the auto group like I suggested? That's the set of tests
> that should complete successfully with minimal failures and without
> crashing the machine.

OK, I'll reserve a testing machine again.

Oleg.

