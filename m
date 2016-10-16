Received: from bombadil.infradead.org ([198.137.202.9]:42684 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752668AbcJPHRw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 16 Oct 2016 03:17:52 -0400
Date: Sun, 16 Oct 2016 00:17:52 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] generic/285: discover allocation size for NFS
Message-ID: <20161016071752.GC17675@infradead.org>
References: <883bff7d2f3123aeb461df1072f9930c3d0f063b.1476440892.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <883bff7d2f3123aeb461df1072f9930c3d0f063b.1476440892.git.bcodding@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Benjamin Coddington <bcodding@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Oct 14, 2016 at 06:28:37AM -0400, Benjamin Coddington wrote:
> On NFS, try to discover the allocation size for the exported filesystem.
> NFS st_blksize is optimized for the network, and will usually be much
> larger than the allocation size of the exported filesystem, which may
> trigger preallocation strategies in the exported filesystem causing the
> seek tests here to fail.

Is there a reason not to use your new evidence-based check for all
file systems?
