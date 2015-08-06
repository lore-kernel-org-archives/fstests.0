Received: from mx1.redhat.com ([209.132.183.28]:44376 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750758AbbHFOR0 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 6 Aug 2015 10:17:26 -0400
Date: Thu, 6 Aug 2015 22:17:22 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] generic/038: speed up file creation
Message-ID: <20150806141722.GF17933@dhcp-13-216.nay.redhat.com>
References: <1438820848-13325-1-git-send-email-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1438820848-13325-1-git-send-email-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Aug 06, 2015 at 10:27:28AM +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Now that generic/038 is running on my test machine, I notice how
> slow it is:
> 
> generic/038      692s
> 
> 11-12 minutes for a single test is way too long.
> The test is creating
> 400,000 single block files, which can be easily parallelised and
> hence run much faster than the test is currently doing.
> 
> Split the file creation up into 4 threads that create 100,000 files
> each. 4 is chosen because XFS defaults to 4AGs, ext4 still has decent
> speedups at 4 concurrent creates, and other filesystems aren't hurt
> by excessive concurrency. The result:
> 
> generic/038      237s
> 
> on the same machine, which is roughly 3x faster and so it (just)
> fast enough to to be considered acceptible.

I got a speedup from 5663s to 639s, and confirmed the test could
fail the test on unpatched btrfs (btrfsck failed, not every time).

Reviewed-by: Eryu Guan <eguan@redhat.com>
