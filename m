Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:5530 "EHLO
	ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751348AbbHQAE3 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Sun, 16 Aug 2015 20:04:29 -0400
Date: Mon, 17 Aug 2015 10:03:36 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] generic/084: check inotify limit before tail many files
Message-ID: <20150817000336.GE20596@dastard>
References: <1439482592-29611-1-git-send-email-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1439482592-29611-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, eguan@redhat.com
List-ID: <fstests@vger.kernel.org>

On Fri, Aug 14, 2015 at 12:16:32AM +0800, Zorro Lang wrote:
> generic/084 try to run 'tail' command, tail will use
> inotify, and there're some limit about inotify. I think
> the most important is fs.inotify.max_user_instances, then
> fs.inotify.max_user_watches is importand too.
>
> When I test on a machine with 154 cpu cores, this case
> run failed, and hit many warning likes:
> 
>     tail: inotify cannot be used, reverting to polling: Too many
>     open files
> 
> Because the fs.inotify.max_user_instances is 128, so if
> we try to tail 154 files, it will be failed.

We use 'tail' all over the place in xfstests, so why is only
generic/084 affected?

And really, this seems more like a distro/environment bug and
doesn't need xfstests help to work around. i.e. changing the
sysctl before starting xfstests seems much more appropriate than
hacking it a random test. Especially as there may be more than one
test that is affected by this, and when run in a random order this
would cause those other tests to pass/fail depending on whether
generic/084 had already been run on that machine....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
