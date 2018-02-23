Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56284 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751340AbeBWEea (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 22 Feb 2018 23:34:30 -0500
Date: Fri, 23 Feb 2018 12:34:27 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] check: fail tests if check/dmesg are not clean
Message-ID: <20180223043427.GW18267@eguan.usersys.redhat.com>
References: <20180223011632.28893-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180223011632.28893-1-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Feb 23, 2018 at 12:16:32PM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Currently a test passes even if it leaves a corrupt filesystem
> behind, or a splat in the system logs that should not be there.
> Rework the check code to consider these as test failures so they can
> be accounted and tracked correctly. This also allows us to include
> the post-test filesystem checking in the test runtime - that is
> currently not accounted to the test, either, so the real runtime of
> each test is not accurately reflected in the time stats being
> reported.
> 
> This requires a complete reworking of the main test check loop. It's
> a bunch of spaghetti at the moment because it has post test
> reporting code preventing use from using continue when a test is
> done. Move that post test reporting to the start of the next loop
> iteration and clean up the code to use continues where appropriate.
> 
> Also, for cases where we haven't run the test or it's already been
> marked as failed, don't bother running the filesystem/dmesg checks
> for failure as we're already going to report the test as failed.
> 
> This touches almost all of the loop, so get rid of the remaining
> 4 space indents inside the loop while moving all this code around.
> 
> Signed-Off-By: Dave Chinner <dchinner@redhat.com>

Thanks for the rework! It needs careful testing and most probably won't
catch this week's update. I'll take it in next week if I see no problems
in testing.

Thanks,
Eryu
