Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:60806 "EHLO
	ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751285AbcGNX4I (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 14 Jul 2016 19:56:08 -0400
Date: Fri, 15 Jul 2016 09:56:04 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] generic: add _require_block_device to more tests
Message-ID: <20160714235603.GS12670@dastard>
References: <1467343112-26227-1-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1467343112-26227-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Jul 01, 2016 at 11:18:32AM +0800, Eryu Guan wrote:
> generic/067 mounts $SCRATCH_DEV directly in the test, assuming it's
> a block device. generic/299 and generic/300 query the size of
> $SCRATCH_DEV by running 'blockdev --getsz $SCRATCH_DEV'.
> 
> So add the check to make sure $SCRATCH_DEV is a real block device in
> these tests.
> 
> Signed-off-by: Eryu Guan <eguan@redhat.com>

Looks fine.

Reviewed-by: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
david@fromorbit.com
