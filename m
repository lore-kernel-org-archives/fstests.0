Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60292 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1030684AbeBNPDq (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 14 Feb 2018 10:03:46 -0500
Date: Wed, 14 Feb 2018 23:03:43 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v4] generic: add stress test for fanotify and inotify
Message-ID: <20180214150343.GN18267@eguan.usersys.redhat.com>
References: <20180212053822.whuqpncgddzm3l6n@XZHOUW.usersys.redhat.com>
 <1518414408-23149-1-git-send-email-xzhou@redhat.com>
 <20180214110331.ojgyabcta34lzo4s@quack2.suse.cz>
 <CAOQ4uxhUv0Wy+v_i8mzhx5y7NA88VyULxWniJ-HXCLg_Pq7bUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhUv0Wy+v_i8mzhx5y7NA88VyULxWniJ-HXCLg_Pq7bUw@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Xiong Zhou <xzhou@redhat.com>, fstests <fstests@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, Dave Chinner <david@fromorbit.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Feb 14, 2018 at 01:22:06PM +0200, Amir Goldstein wrote:
> On Wed, Feb 14, 2018 at 1:03 PM, Jan Kara <jack@suse.cz> wrote:
> > On Mon 12-02-18 13:46:48, Xiong Zhou wrote:
> >> Stress test for fanotify and inotify. Exercise fanotify and
> >> inotify user interfaces in loop while other stress tests going
> >> on in the watched test directory.
> >>
> >> Watching slab object inotify_inode_mark size, report fail
> >> it increases too fast. This may lead to a crash if OOM killer
> >> invoked.
> >>
> >> kernel commit related to the fixes in v4.15-rc1:
> >> 0d6ec07 fsnotify: pin both inode and vfsmount mark
> >>
> >> Signed-off-by: Xiong Zhou <xzhou@redhat.com>
> >
> > I'm sorry for chiming in so late but I was on vacation. Just one question:
> > Currently, all inotify and fanotify tests are part of LTP. Is there any
> > good reason for putting this particular test to fstests and not LTP?
> > Specifically I've refrained from putting notification framework tests to
> > fstests because there's practically no relation of it to implementation of
> > any particular filesystem. Also I'd prefer not to have fanotify / inotify
> > tests in two different frameworks...
> >
> 
> I second that.
> Also, Eryu did not chime in yet (and Dave probably did not look closely),
> but I think fstests in general try to refrain from single purpose test
> programs such as fsnotify_stress.

I have no problem with committing fsnotify tests in fstests, we do have
tests that exercise the vfs level infrastructure purely, e.g. the shared
subtree operations tests.

But if both fanotify subsystem maintainer and main reviewer suggest
putting this test to LTP, I have no problem with that too :)

Thanks,
Eryu
