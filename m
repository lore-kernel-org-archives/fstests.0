Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:63680 "EHLO
	ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1948079AbcBSBdp (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 18 Feb 2016 20:33:45 -0500
Date: Fri, 19 Feb 2016 12:33:16 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] xfs: change return value check to golden image check
Message-ID: <20160219013316.GW14668@dastard>
References: <1455208656-16637-1-git-send-email-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1455208656-16637-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, eguan@redhat.com
List-ID: <fstests@vger.kernel.org>

On Fri, Feb 12, 2016 at 12:37:36AM +0800, Zorro Lang wrote:
> xfs/133 and xfs/138 use too much code to do "return value" check,
> it's not necessary. For the code can be more readable and clear,
> I change "return value" check to golden image check.
> 
> Signed-off-by: Zorro Lang <zlang@redhat.com>
> ---
>  tests/xfs/133     | 20 +++++++-------------
>  tests/xfs/133.out |  7 +++++++
>  tests/xfs/138     | 26 ++++++++++++--------------
>  tests/xfs/138.out | 12 ++++++++++++
>  4 files changed, 38 insertions(+), 27 deletions(-)

This cause a xfs/133 failure like this on my systems:

--- tests/xfs/133.out   2016-02-19 10:40:57.043131919 +1100
+++ /home/dave/src/xfstests-dev/results//xfs/xfs/133.out.bad    2016-02-19 12:24:53.173589432 +1100
@@ -4,5 +4,6 @@
 Filesystem Blocks Quota Limit Warn/Time Mounted on
 SCRATCH_DEV 0 102400 204800 00 [--------] SCRATCH_MNT
 === report command output ===
+(null) 0 0 0 00 [--------]
 123456-project 0 102400 204800 00 [--------]
 

Can you see if you can reproduce it?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
