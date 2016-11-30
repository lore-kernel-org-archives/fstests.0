Received: from bombadil.infradead.org ([198.137.202.9]:34788 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754476AbcK3QNz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 30 Nov 2016 11:13:55 -0500
Date: Wed, 30 Nov 2016 08:13:54 -0800
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] generic/095: add iomap_dio_rw() to the dmesg filter
Message-ID: <20161130161354.GA2996@infradead.org>
References: <20161130045908.15200-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161130045908.15200-1-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Nov 30, 2016 at 03:59:08PM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Oops, we did it again - we moved the XFS dio code warning to a new
> function with the iomap direct IO rework.  Update the filter to pick
> up the new warning location.

I had this in my tree all the time and was going to send it to you once
you applied the patch, but you're way too fast.. :)

Reviewed-by: Christoph Hellwig <hch@lst.de>
