Received: from mx2.suse.de ([195.135.220.15]:35091 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755126AbeBOJXp (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 15 Feb 2018 04:23:45 -0500
Date: Thu, 15 Feb 2018 10:23:43 +0100
From: Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v4] generic: add stress test for fanotify and inotify
Message-ID: <20180215092343.od4to3x7loklzqu6@quack2.suse.cz>
References: <20180212053822.whuqpncgddzm3l6n@XZHOUW.usersys.redhat.com>
 <1518414408-23149-1-git-send-email-xzhou@redhat.com>
 <20180214110331.ojgyabcta34lzo4s@quack2.suse.cz>
 <20180215004940.k7e4z5jpsbhin66n@XZHOUW.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215004940.k7e4z5jpsbhin66n@XZHOUW.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Xiong Zhou <xzhou@redhat.com>
Cc: Jan Kara <jack@suse.cz>, amir73il@gmail.com, fstests@vger.kernel.org, miklos@szeredi.hu, david@fromorbit.com
List-ID: <fstests@vger.kernel.org>

On Thu 15-02-18 08:49:40, Xiong Zhou wrote:
> On Wed, Feb 14, 2018 at 12:03:31PM +0100, Jan Kara wrote:
> > On Mon 12-02-18 13:46:48, Xiong Zhou wrote:
> > > Stress test for fanotify and inotify. Exercise fanotify and
> > > inotify user interfaces in loop while other stress tests going
> > > on in the watched test directory.
> > > 
> > > Watching slab object inotify_inode_mark size, report fail
> > > it increases too fast. This may lead to a crash if OOM killer
> > > invoked.
> > > 
> > > kernel commit related to the fixes in v4.15-rc1:
> > > 0d6ec07 fsnotify: pin both inode and vfsmount mark
> > > 
> > > Signed-off-by: Xiong Zhou <xzhou@redhat.com>
> > 
> > I'm sorry for chiming in so late but I was on vacation. Just one question:
> > Currently, all inotify and fanotify tests are part of LTP. Is there any
> > good reason for putting this particular test to fstests and not LTP?
> 
> It's handy to test with bash and c. fstests is more convenient to do that.

Hum, I don't understand. You can just run the executables created by LTP.
E.g.:

jack@quack2:~/source/ltp> testcases/kernel/syscalls/inotify/inotify01 
inotify01    1  TPASS  :  get event: wd=1 mask=4 cookie=0 len=0
inotify01    2  TPASS  :  get event: wd=1 mask=20 cookie=0 len=0
inotify01    3  TPASS  :  get event: wd=1 mask=1 cookie=0 len=0
inotify01    4  TPASS  :  get event: wd=1 mask=10 cookie=0 len=0
inotify01    5  TPASS  :  get event: wd=1 mask=20 cookie=0 len=0
inotify01    6  TPASS  :  get event: wd=1 mask=2 cookie=0 len=0
inotify01    7  TPASS  :  get event: wd=1 mask=8 cookie=0 len=0
jack@quack2:~/source/ltp>

I don't see anything less handy than in fstests. I do agree that LTP is huge
so the initial step of downloading it and compiling takes longer than for
fstests but that's about it.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
