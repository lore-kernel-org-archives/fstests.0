Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56818 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932504AbeBLIe5 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 12 Feb 2018 03:34:57 -0500
Date: Mon, 12 Feb 2018 16:34:54 +0800
From: Xiong Zhou <xzhou@redhat.com>
Subject: Re: [PATCH v4] generic: add stress test for fanotify and inotify
Message-ID: <20180212083454.3eblcrw3tdnmjtts@XZHOUW.usersys.redhat.com>
References: <20180212053822.whuqpncgddzm3l6n@XZHOUW.usersys.redhat.com>
 <1518414408-23149-1-git-send-email-xzhou@redhat.com>
 <20180212070255.GD7000@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180212070255.GD7000@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Xiong Zhou <xzhou@redhat.com>, amir73il@gmail.com, fstests@vger.kernel.org, miklos@szeredi.hu, jack@suse.cz
List-ID: <fstests@vger.kernel.org>

On Mon, Feb 12, 2018 at 06:02:55PM +1100, Dave Chinner wrote:
> On Mon, Feb 12, 2018 at 01:46:48PM +0800, Xiong Zhou wrote:
> > Stress test for fanotify and inotify. Exercise fanotify and
> > inotify user interfaces in loop while other stress tests going
> > on in the watched test directory.
> > 
> > Watching slab object inotify_inode_mark size, report fail
> > it increases too fast. This may lead to a crash if OOM killer
> > invoked.
> > 
> > kernel commit related to the fixes in v4.15-rc1:
> > 0d6ec07 fsnotify: pin both inode and vfsmount mark
> 
> Nice and concise!
> 
> Thanks for updating the fix reference.

Thanks all for reviewing!

Xiong

> 
> -Dave.
> 
> -- 
> Dave Chinner
> david@fromorbit.com
