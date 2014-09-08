Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:63230 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753829AbaIHMVR (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 8 Sep 2014 08:21:17 -0400
Date: Mon, 8 Sep 2014 22:21:01 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 6/6] ext4/308: add new defrag compact test case
Message-ID: <20140908122101.GJ30012@dastard>
References: <1408194791-1797-1-git-send-email-dmonakhov@openvz.org>
 <1408194791-1797-6-git-send-email-dmonakhov@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1408194791-1797-6-git-send-email-dmonakhov@openvz.org>
Sender: fstests-owner@vger.kernel.org
To: Dmitry Monakhov <dmonakhov@openvz.org>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sat, Aug 16, 2014 at 05:13:11PM +0400, Dmitry Monakhov wrote:
> Check data integrity and layout stability during defrag compacting
> EXT4_IOC_MOVE_EXT swap extents between target and donor inode.
> If ioctl was performed twice then inode's layout should not change.
> 
> Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
....
> +	echo "Perform compacting"
> +	$XFS_IO_PROG -c "falloc 0 246M" -f $SCRATCH_MNT/donor | _filter_xfs_io
> +	ls $SCRATCH_MNT/test.* | run_check $here/src/e4compact \
> +		 -v -i -f $SCRATCH_MNT/donor  >> $seqres.full 2>&1
> +	md5sum $SCRATCH_MNT/test.*

Needs to _filter_scratch. I'll fix it up directly rather than
waiting for Dimitry to get back to these patches...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
