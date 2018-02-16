Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35520 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752984AbeBPAi0 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 15 Feb 2018 19:38:26 -0500
Date: Fri, 16 Feb 2018 08:38:23 +0800
From: Xiong Zhou <xzhou@redhat.com>
Subject: Re: [PATCH v4] generic: add stress test for fanotify and inotify
Message-ID: <20180216003823.tzsjpmhsu42mj3tu@XZHOUW.usersys.redhat.com>
References: <20180212053822.whuqpncgddzm3l6n@XZHOUW.usersys.redhat.com>
 <1518414408-23149-1-git-send-email-xzhou@redhat.com>
 <20180214110331.ojgyabcta34lzo4s@quack2.suse.cz>
 <20180215004940.k7e4z5jpsbhin66n@XZHOUW.usersys.redhat.com>
 <20180215092343.od4to3x7loklzqu6@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215092343.od4to3x7loklzqu6@quack2.suse.cz>
Sender: fstests-owner@vger.kernel.org
To: Jan Kara <jack@suse.cz>
Cc: Xiong Zhou <xzhou@redhat.com>, amir73il@gmail.com, fstests@vger.kernel.org, miklos@szeredi.hu, david@fromorbit.com
List-ID: <fstests@vger.kernel.org>

On Thu, Feb 15, 2018 at 10:23:43AM +0100, Jan Kara wrote:
> On Thu 15-02-18 08:49:40, Xiong Zhou wrote:
> > On Wed, Feb 14, 2018 at 12:03:31PM +0100, Jan Kara wrote:
> > > On Mon 12-02-18 13:46:48, Xiong Zhou wrote:
> > > > Stress test for fanotify and inotify. Exercise fanotify and
> > > > inotify user interfaces in loop while other stress tests going
> > > > on in the watched test directory.
> > > > 
> > > > Watching slab object inotify_inode_mark size, report fail
> > > > it increases too fast. This may lead to a crash if OOM killer
> > > > invoked.
> > > > 
> > > > kernel commit related to the fixes in v4.15-rc1:
> > > > 0d6ec07 fsnotify: pin both inode and vfsmount mark
> > > > 
> > > > Signed-off-by: Xiong Zhou <xzhou@redhat.com>
> > > 
> > > I'm sorry for chiming in so late but I was on vacation. Just one question:
> > > Currently, all inotify and fanotify tests are part of LTP. Is there any
> > > good reason for putting this particular test to fstests and not LTP?
> > 
> > It's handy to test with bash and c. fstests is more convenient to do that.
> 
> Hum, I don't understand. You can just run the executables created by LTP.

Like *_files functions and run fsstress in this patch. It's doable by c,
just with more code.

Thanks,
Xiong

> E.g.:
> 
> jack@quack2:~/source/ltp> testcases/kernel/syscalls/inotify/inotify01 
> inotify01    1  TPASS  :  get event: wd=1 mask=4 cookie=0 len=0
> inotify01    2  TPASS  :  get event: wd=1 mask=20 cookie=0 len=0
> inotify01    3  TPASS  :  get event: wd=1 mask=1 cookie=0 len=0
> inotify01    4  TPASS  :  get event: wd=1 mask=10 cookie=0 len=0
> inotify01    5  TPASS  :  get event: wd=1 mask=20 cookie=0 len=0
> inotify01    6  TPASS  :  get event: wd=1 mask=2 cookie=0 len=0
> inotify01    7  TPASS  :  get event: wd=1 mask=8 cookie=0 len=0
> jack@quack2:~/source/ltp>
> 
> I don't see anything less handy than in fstests. I do agree that LTP is huge
> so the initial step of downloading it and compiling takes longer than for
> fstests but that's about it.
> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
