Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:51065 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751443AbeBLHDb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 12 Feb 2018 02:03:31 -0500
Date: Mon, 12 Feb 2018 18:02:55 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v4] generic: add stress test for fanotify and inotify
Message-ID: <20180212070255.GD7000@dastard>
References: <20180212053822.whuqpncgddzm3l6n@XZHOUW.usersys.redhat.com>
 <1518414408-23149-1-git-send-email-xzhou@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518414408-23149-1-git-send-email-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Xiong Zhou <xzhou@redhat.com>
Cc: amir73il@gmail.com, fstests@vger.kernel.org, miklos@szeredi.hu, jack@suse.cz
List-ID: <fstests@vger.kernel.org>

On Mon, Feb 12, 2018 at 01:46:48PM +0800, Xiong Zhou wrote:
> Stress test for fanotify and inotify. Exercise fanotify and
> inotify user interfaces in loop while other stress tests going
> on in the watched test directory.
> 
> Watching slab object inotify_inode_mark size, report fail
> it increases too fast. This may lead to a crash if OOM killer
> invoked.
> 
> kernel commit related to the fixes in v4.15-rc1:
> 0d6ec07 fsnotify: pin both inode and vfsmount mark

Nice and concise!

Thanks for updating the fix reference.

-Dave.

-- 
Dave Chinner
david@fromorbit.com
