Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:9239 "EHLO
        ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751756AbcJPVse (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 16 Oct 2016 17:48:34 -0400
Date: Mon, 17 Oct 2016 08:15:45 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] generic/285: discover allocation size for NFS
Message-ID: <20161016211545.GA14023@dastard>
References: <883bff7d2f3123aeb461df1072f9930c3d0f063b.1476440892.git.bcodding@redhat.com>
 <20161016071752.GC17675@infradead.org>
 <0A92328A-9E9C-4D8D-AADF-F995369A3E40@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0A92328A-9E9C-4D8D-AADF-F995369A3E40@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Benjamin Coddington <bcodding@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sun, Oct 16, 2016 at 06:18:13AM -0400, Benjamin Coddington wrote:
> On 16 Oct 2016, at 3:17, Christoph Hellwig wrote:
> 
> > On Fri, Oct 14, 2016 at 06:28:37AM -0400, Benjamin Coddington wrote:
> >> On NFS, try to discover the allocation size for the exported filesystem.
> >> NFS st_blksize is optimized for the network, and will usually be much
> >> larger than the allocation size of the exported filesystem, which may
> >> trigger preallocation strategies in the exported filesystem causing the
> >> seek tests here to fail.
> >
> > Is there a reason not to use your new evidence-based check for all
> > file systems?
> 
> Only that on the filesystems I've checked (ext4, xfs, btrfs, tmpfs)
> st_blksize is correct, so trying to discover it is unnecessary.

As I've said previously, mount options (e.g. -o largeio) can change
what XFS reports in st_blksize such that it behaves like the NFS
client...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
