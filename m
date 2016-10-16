Received: from mx1.redhat.com ([209.132.183.28]:50184 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755045AbcJPKSy (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 16 Oct 2016 06:18:54 -0400
From: "Benjamin Coddington" <bcodding@redhat.com>
Subject: Re: [PATCH] generic/285: discover allocation size for NFS
Date: Sun, 16 Oct 2016 06:18:13 -0400
Message-ID: <0A92328A-9E9C-4D8D-AADF-F995369A3E40@redhat.com>
In-Reply-To: <20161016071752.GC17675@infradead.org>
References: <883bff7d2f3123aeb461df1072f9930c3d0f063b.1476440892.git.bcodding@redhat.com>
 <20161016071752.GC17675@infradead.org>
MIME-Version: 1.0
Sender: fstests-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 16 Oct 2016, at 3:17, Christoph Hellwig wrote:

> On Fri, Oct 14, 2016 at 06:28:37AM -0400, Benjamin Coddington wrote:
>> On NFS, try to discover the allocation size for the exported filesystem.
>> NFS st_blksize is optimized for the network, and will usually be much
>> larger than the allocation size of the exported filesystem, which may
>> trigger preallocation strategies in the exported filesystem causing the
>> seek tests here to fail.
>
> Is there a reason not to use your new evidence-based check for all
> file systems?

Only that on the filesystems I've checked (ext4, xfs, btrfs, tmpfs)
st_blksize is correct, so trying to discover it is unnecessary.

Ben
