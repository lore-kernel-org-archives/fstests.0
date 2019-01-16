Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:55894 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730124AbfAPD5t (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 15 Jan 2019 22:57:49 -0500
Date: Wed, 16 Jan 2019 14:57:45 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: Any way to detect performance in a test case?
Message-ID: <20190116035745.GO4205@dastard>
References: <f5404232-3b9a-6bb6-9841-a2a56f314e51@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5404232-3b9a-6bb6-9841-a2a56f314e51@gmx.com>
Sender: fstests-owner@vger.kernel.org
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Wed, Jan 16, 2019 at 09:59:40AM +0800, Qu Wenruo wrote:
> Hi,
> 
> Is there any way to detect (huge) performance regression in a test case?
> 
> By huge performance regression, I mean some operation takes from less
> than 10s to around 400s.
> 
> There is existing runtime accounting, but we can't do it inside a test
> case (or can we?)
> 
> So is there any way to detect huge performance regression in a test case?

Just run your normal performance monitoring tools while the test is
running to see what has changed. Is it IO, memory, CPU, lock
contention or somethign else that is the problem?  pcp, strace, top,
iostat, perf, etc all work just fine for finding perf regressions
reported by test cases...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
