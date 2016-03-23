Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:62727 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750921AbcCWCx5 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 22 Mar 2016 22:53:57 -0400
Date: Wed, 23 Mar 2016 13:53:27 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v2] generic: test I/O on dm error device
Message-ID: <20160323025327.GZ11812@dastard>
References: <1457710822-30532-2-git-send-email-eguan@redhat.com>
 <1458029534-17578-1-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1458029534-17578-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Mar 15, 2016 at 04:12:14PM +0800, Eryu Guan wrote:
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

Fails with:

@@ -1,2 +1,6 @@
 QA output created by 338
  Silence is golden
  +specified blocksize 1024 is less than device physical sector size 4096
  +switching to logical sector size 512
  +mkfs.xfs: /dev/mapper/error-test appears to contain an existing filesystem (xfs).
  +mkfs.xfs: Use the -f option to force overwrite.

And then it failed to clean up properly and caused all sorts of
subsequent problems.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
