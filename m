Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:62067 "EHLO
	ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1422831AbcBQMWy (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 17 Feb 2016 07:22:54 -0500
Date: Wed, 17 Feb 2016 23:22:51 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 16/16] xfstests: remove _need_to_be_root
Message-ID: <20160217122251.GR14668@dastard>
References: <1455385269-26319-1-git-send-email-tytso@mit.edu>
 <1455385269-26319-17-git-send-email-tytso@mit.edu>
 <20160217100923.GO21482@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160217100923.GO21482@infradead.org>
Sender: fstests-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Theodore Ts'o <tytso@mit.edu>, fstests@vger.kernel.org, hughd@google.com
List-ID: <fstests@vger.kernel.org>

On Wed, Feb 17, 2016 at 02:09:23AM -0800, Christoph Hellwig wrote:
> Looks good,
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> While you're at it it would be nice to also remove the odd instruction
> of adding the '123456-fsgqa' test user in README.

I think that user is actually used for quota testing? Yeah, see
xfs/138.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
