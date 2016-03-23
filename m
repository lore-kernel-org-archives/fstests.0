Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:24045 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750804AbcCWGC1 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 23 Mar 2016 02:02:27 -0400
Date: Wed, 23 Mar 2016 17:01:51 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v3] generic: test I/O on dm error device
Message-ID: <20160323060151.GB11812@dastard>
References: <1457710822-30532-2-git-send-email-eguan@redhat.com>
 <1458706714-4282-1-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1458706714-4282-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Mar 23, 2016 at 12:18:34PM +0800, Eryu Guan wrote:
> This is a test that performs simple I/O on dm error device, which
> returns EIO on all I/O request.
> 
> This is motivated by an ext4 bug that crashes kernel on error path when
> trying to update atime. Following kernel patch should fix the issue
> 
>   ext4: fix NULL pointer dereference in ext4_mark_inode_dirty()
> 
> Signed-off-by: Eryu Guan <eguan@redhat.com>
> ---
> 
> v3:
> - mkfs on SCRATCH_DEV by calling _scratch_mkfs, instead of _mkfs_dev on
>   DMERROR_DEV, which fails on XFS without "-f" option

Thanks, works fine now!

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
