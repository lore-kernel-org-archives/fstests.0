Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:27453 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750880AbcBUVwo (ORCPT
	<rfc822;fstests@vger.kernel.org>); Sun, 21 Feb 2016 16:52:44 -0500
Date: Mon, 22 Feb 2016 08:52:30 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 05/16] generic: remove the generic/125 test
Message-ID: <20160221215230.GD14668@dastard>
References: <1455385269-26319-1-git-send-email-tytso@mit.edu>
 <1455385269-26319-6-git-send-email-tytso@mit.edu>
 <20160217100333.GH21482@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160217100333.GH21482@infradead.org>
Sender: fstests-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Theodore Ts'o <tytso@mit.edu>, fstests@vger.kernel.org, hughd@google.com
List-ID: <fstests@vger.kernel.org>

On Wed, Feb 17, 2016 at 02:03:33AM -0800, Christoph Hellwig wrote:
> The pNFS block layout driver works the same way as CXFS here.  I
> don't think I ever triggered this test during the development, though.
> 
> I'm indifferent on whether we should keep this test or not, but it
> defintively makes sense to remove it from the auto group.

Ok, if there's some value to using it for pNFS testing, then lets
leave it in place, remove the auto group but also add a "pnfs" group
tag to it to document what it's useful for.

Sorry to give you the run-around on this one, Ted. Can you resend
it?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
