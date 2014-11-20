Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:19989 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756352AbaKTAFY (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 19 Nov 2014 19:05:24 -0500
Received: from dave by dastard with local (Exim 4.80)
	(envelope-from <david@fromorbit.com>)
	id 1XrFEW-00023l-F5
	for fstests@vger.kernel.org; Thu, 20 Nov 2014 11:04:24 +1100
Date: Thu, 20 Nov 2014 11:04:24 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] xfs/096: strip log stripe warnings from mkfs.xfs
Message-ID: <20141120000424.GB27262@dastard>
References: <1416441678-13445-1-git-send-email-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1416441678-13445-1-git-send-email-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Nov 20, 2014 at 11:01:18AM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> The warnings have been removed when stripe unit/width are too big
> for the log stripe unit to be set. Hence add them to the mkfs.xfs
> filter and strip them from golden output file so the test succeeds
> on both new and old mfks binaries.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>

Ugh, ignore this patch - it's an old version. Updated patch to
follow shortly.

-Dave
-- 
Dave Chinner
david@fromorbit.com
