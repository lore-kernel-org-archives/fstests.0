Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40848 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932433AbeBLEeA (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 11 Feb 2018 23:34:00 -0500
Date: Mon, 12 Feb 2018 12:33:57 +0800
From: Xiong Zhou <xzhou@redhat.com>
Subject: Re: [PATCH v3] generic: add stress test for fanotify and inotify
Message-ID: <20180212043357.x6dhq67wghzgafrw@XZHOUW.usersys.redhat.com>
References: <CCAOQ4uxh2ZmEJi8gbiDRsYefV+XC20TNLjW9OFOZM0=j0_0yf+Q@mail.gmail.com>
 <1518332344-4772-1-git-send-email-xzhou@redhat.com>
 <CAOQ4uxj7AWbDm78k23bnekcSTZm17RkWh44aE0mhAQ7wyguixg@mail.gmail.com>
 <20180212004126.w6tg2ohcrbt7qhdv@XZHOUW.usersys.redhat.com>
 <CAOQ4uxht-TkTiH+=9gp29XtCPv9=QR0v5FGFFvL+Ag9Nvshaww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxht-TkTiH+=9gp29XtCPv9=QR0v5FGFFvL+Ag9Nvshaww@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: Xiong Zhou <xzhou@redhat.com>, fstests <fstests@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>
List-ID: <fstests@vger.kernel.org>

On Mon, Feb 12, 2018 at 05:50:21AM +0200, Amir Goldstein wrote:
> On Mon, Feb 12, 2018 at 2:41 AM, Xiong Zhou <xzhou@redhat.com> wrote:
> > On Sun, Feb 11, 2018 at 10:03:17PM +0200, Amir Goldstein wrote:
> >> On Sun, Feb 11, 2018 at 8:59 AM, Xiong Zhou <xzhou@redhat.com> wrote:
> >> > Stress test for fanotify and inotify. Exercise fanotify and
> >> > inotify user interfaces in loop while other stress tests going
> >> > on in the watched test directory.
> >> >
> >> > Watching slab object inotify_inode_mark size, report fail
> >> > it increases too fast. This may lead to a crash if OOM killer
> >> > invoked. Fixed by this series:
> >> >
> >> > ab97f87 fsnotify: convert fsnotify_mark.refcnt from atomic_t to ref..
> >> > 6685df3 fanotify: clean up CONFIG_FANOTIFY_ACCESS_PERMISSIONS ifdefs
> >> > 3427ce7 fsnotify: clean up fsnotify()
> >> > f37650f fanotify: fix fsnotify_prepare_user_wait() failure
> >> > 9a31d7a fsnotify: fix pinning group in fsnotify_prepare_user_wait()
> >>
> >> That's a bit much. This commit below is the actual fix.
> >> The rest are cleanups and other bug fixes.
> >
> > Cleanups are preparing for the fix.
> 
> No they are not. They are general cleanups and other bug fixed *after*
> the fix. heck, 3 of the patches you listed are not from Miklos' patchset
> at all.

Ya. I messed up, I did not check all the details well enough, just
confirmed there was dependency.

> 
> If you wanted to include also prep patches that would only be:
> 
> 24c2030 fsnotify: clean up fsnotify_prepare/finish_user_wait()
> 
> But I personally find that information to be irrelevant in test context.
> 
> > I believe it's better to list
> > the whole series. They are a patchset for some reason.
> 
> You gotta know who your audience are.

Yes, I know.

> Patchset is for a reason - the reason is that all patches should be
> reviewed and merged together. But that's got nothing to do with the
> reason you should list the fix commit in test description.
> The reason for that is that testers needs to know if test is expected to
> fail or pass on the kernel they are using.

AFAIK, known issue tracking is not handled by fstests. Listing them
is helping make things more clear, not for telling people expected
results. If I post this case before any fix commits available, not
listing any commits does make sense.

> 
> Listing the cleanup patches does not serve this purpose.
> In fact, it may confuse people testing stable kernels, because stable
> kernel could have fix patches applied but not all cleanup patches.

Interesting, I'm listing all of them and I'm saying "fixed by this series"
not "fixed by this commit".

THanks,
Xiong
> 
> 
> >
> >> It could also help testers to know the upstream kernel version
> >> where the fix landed:
> >
> > There is no such info in other cases listing kernel commits. If
> > people want to know, they will find it out.
> >
> 
> Fair enough. Looking at other tests for common practices is a good
> idea - the practice is to list only the fix commits. There are a few tests
> that list more than a single commit, but in those cases the bug fix itself
> is probably spread over few commits.
> 
> Cheers,
> Amir.
