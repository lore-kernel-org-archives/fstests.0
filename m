Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:23741 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751404AbaIHKsE (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 8 Sep 2014 06:48:04 -0400
Date: Mon, 8 Sep 2014 20:47:49 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 2/2] xfs/051: test buffer use after free race on I/O
 failure in XFS log recovery
Message-ID: <20140908104749.GI30012@dastard>
References: <1409667761-50248-1-git-send-email-bfoster@redhat.com>
 <1409667761-50248-3-git-send-email-bfoster@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1409667761-50248-3-git-send-email-bfoster@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Brian Foster <bfoster@redhat.com>
Cc: fstests@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

On Tue, Sep 02, 2014 at 10:22:41AM -0400, Brian Foster wrote:
> A buffer use after free race was discovered in the XFS log recovery
> codepath if I/O failures occur during recovery. The I/O submission path
> can abort the mount and release the only reference held on some buffers
> before I/O completion processing (e.g., async workqueue processing)
> might have completed. Badness ensues if the I/O completion path
> subsequently attempts to access said buffers.
.....
> 
> case goes to Alex Lyakas.
> index 4d35df5..9784dea 100644
> --- a/tests/xfs/group
> +++ b/tests/xfs/group
> @@ -47,6 +47,7 @@
>  048 other auto quick
>  049 rw auto quick
>  050 quota auto quick
> +051 dangerous

I'm going to consider this auto/log/metadata rather than dangerous.
Once the bug is fixed, we want to continue running this test as a
regression test, and nobody does that with the dangerous group....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
