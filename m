Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:41180 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935048AbcKMXOK (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 13 Nov 2016 18:14:10 -0500
Date: Mon, 14 Nov 2016 10:13:59 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: fstests: fix fsx fallocate error messages
Message-ID: <20161113231359.GK28922@dastard>
References: <20161112164849.GB18127@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161112164849.GB18127@infradead.org>
Sender: fstests-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sat, Nov 12, 2016 at 08:48:49AM -0800, Christoph Hellwig wrote:
> Many of the commands using fallocate had an extra % at the beggining
> of the error messages, missed the 0x prefix for hex output and printed
> the length where it should print the end of the region.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

looks fine.

Reviewed-by: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
david@fromorbit.com
