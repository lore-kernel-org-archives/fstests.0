Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:20586 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750866AbbJBAqA (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 1 Oct 2015 20:46:00 -0400
Date: Fri, 2 Oct 2015 10:38:34 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: help on xfs test results
Message-ID: <20151002003834.GI3902@dastard>
References: <560C69D9.6020807@sysam.it>
 <560CF355.7050200@sysam.it>
 <20151001235653.GH3902@dastard>
 <560DD051.4080407@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <560DD051.4080407@sandeen.net>
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Angelo Dureghello <angelo@sysam.it>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Thu, Oct 01, 2015 at 07:31:13PM -0500, Eric Sandeen wrote:
> 
> 
> On 10/1/15 6:56 PM, Dave Chinner wrote:
> > Are you testing with something like selinux or some other security
> > subsystem enabled that creates attributes at inode creation time?
> 
> In theory, xfstests detects this and mounts with an fs-wide context
> to avoid that...

For selinux, yes. i don't think it's aware of anything else,
though...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
