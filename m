Received: from mx2.suse.de ([195.135.220.15]:38509 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932677AbeBPJwX (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 16 Feb 2018 04:52:23 -0500
Date: Fri, 16 Feb 2018 10:52:20 +0100
From: Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v4] generic: add stress test for fanotify and inotify
Message-ID: <20180216095220.2u3nddyqlnck3gom@quack2.suse.cz>
References: <20180212053822.whuqpncgddzm3l6n@XZHOUW.usersys.redhat.com>
 <1518414408-23149-1-git-send-email-xzhou@redhat.com>
 <20180214110331.ojgyabcta34lzo4s@quack2.suse.cz>
 <20180215004940.k7e4z5jpsbhin66n@XZHOUW.usersys.redhat.com>
 <20180215092343.od4to3x7loklzqu6@quack2.suse.cz>
 <20180216003823.tzsjpmhsu42mj3tu@XZHOUW.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216003823.tzsjpmhsu42mj3tu@XZHOUW.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Xiong Zhou <xzhou@redhat.com>
Cc: Jan Kara <jack@suse.cz>, amir73il@gmail.com, fstests@vger.kernel.org, miklos@szeredi.hu, david@fromorbit.com
List-ID: <fstests@vger.kernel.org>

On Fri 16-02-18 08:38:23, Xiong Zhou wrote:
> On Thu, Feb 15, 2018 at 10:23:43AM +0100, Jan Kara wrote:
> > On Thu 15-02-18 08:49:40, Xiong Zhou wrote:
> > > On Wed, Feb 14, 2018 at 12:03:31PM +0100, Jan Kara wrote:
> > > > On Mon 12-02-18 13:46:48, Xiong Zhou wrote:
> > > > > Stress test for fanotify and inotify. Exercise fanotify and
> > > > > inotify user interfaces in loop while other stress tests going
> > > > > on in the watched test directory.
> > > > > 
> > > > > Watching slab object inotify_inode_mark size, report fail
> > > > > it increases too fast. This may lead to a crash if OOM killer
> > > > > invoked.
> > > > > 
> > > > > kernel commit related to the fixes in v4.15-rc1:
> > > > > 0d6ec07 fsnotify: pin both inode and vfsmount mark
> > > > > 
> > > > > Signed-off-by: Xiong Zhou <xzhou@redhat.com>
> > > > 
> > > > I'm sorry for chiming in so late but I was on vacation. Just one question:
> > > > Currently, all inotify and fanotify tests are part of LTP. Is there any
> > > > good reason for putting this particular test to fstests and not LTP?
> > > 
> > > It's handy to test with bash and c. fstests is more convenient to do that.
> > 
> > Hum, I don't understand. You can just run the executables created by LTP.
> 
> Like *_files functions and run fsstress in this patch. It's doable by c,
> just with more code.

I see thanks for explanation. That's a fair point but LTP also has support
for testcases in shell. So you could do basically what you did for fstests
in LTP as well. See e.g. how testcases/network/nfs/nfs_stress/nfs06 uses
fsstress.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
