Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51134 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932108AbeBLAla (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 11 Feb 2018 19:41:30 -0500
Date: Mon, 12 Feb 2018 08:41:26 +0800
From: Xiong Zhou <xzhou@redhat.com>
Subject: Re: [PATCH v3] generic: add stress test for fanotify and inotify
Message-ID: <20180212004126.w6tg2ohcrbt7qhdv@XZHOUW.usersys.redhat.com>
References: <CCAOQ4uxh2ZmEJi8gbiDRsYefV+XC20TNLjW9OFOZM0=j0_0yf+Q@mail.gmail.com>
 <1518332344-4772-1-git-send-email-xzhou@redhat.com>
 <CAOQ4uxj7AWbDm78k23bnekcSTZm17RkWh44aE0mhAQ7wyguixg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxj7AWbDm78k23bnekcSTZm17RkWh44aE0mhAQ7wyguixg@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: Xiong Zhou <xzhou@redhat.com>, fstests <fstests@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>
List-ID: <fstests@vger.kernel.org>

On Sun, Feb 11, 2018 at 10:03:17PM +0200, Amir Goldstein wrote:
> On Sun, Feb 11, 2018 at 8:59 AM, Xiong Zhou <xzhou@redhat.com> wrote:
> > Stress test for fanotify and inotify. Exercise fanotify and
> > inotify user interfaces in loop while other stress tests going
> > on in the watched test directory.
> >
> > Watching slab object inotify_inode_mark size, report fail
> > it increases too fast. This may lead to a crash if OOM killer
> > invoked. Fixed by this series:
> >
> > ab97f87 fsnotify: convert fsnotify_mark.refcnt from atomic_t to ref..
> > 6685df3 fanotify: clean up CONFIG_FANOTIFY_ACCESS_PERMISSIONS ifdefs
> > 3427ce7 fsnotify: clean up fsnotify()
> > f37650f fanotify: fix fsnotify_prepare_user_wait() failure
> > 9a31d7a fsnotify: fix pinning group in fsnotify_prepare_user_wait()
> 
> That's a bit much. This commit below is the actual fix.
> The rest are cleanups and other bug fixes.

Cleanups are preparing for the fix. I believe it's better to list
the whole series. They are a patchset for some reason.

> It could also help testers to know the upstream kernel version
> where the fix landed:

There is no such info in other cases listing kernel commits. If
people want to know, they will find it out.

Thanks,
Xiong

> 
> 0d6ec07 fsnotify: pin both inode and vfsmount mark
> 
> Otherwise, looks good.
> 
> Amir.
