Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:63383 "EHLO
	ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752316AbcHBXPE (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 2 Aug 2016 19:15:04 -0400
Date: Wed, 3 Aug 2016 09:15:01 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] xfs/006: add EIO error handling test
Message-ID: <20160802231501.GO12670@dastard>
References: <1469976234-15121-1-git-send-email-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1469976234-15121-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, sandeen@redhat.com, eguan@redhat.com, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

On Sun, Jul 31, 2016 at 10:43:54PM +0800, Zorro Lang wrote:
> Except fail_at_unmount, all EIO error handling can stop umount hanging
> on IO error too. This case only tested fail_at_unmount before, so add
> EIO/max_retries and EIO/retry_timeout_seconds test.
> 
> Now this case test three situation when unmount hit EIO:
> 1) fail_at_unmount=1 && \
>    EIO/max_retries=-1 && \
>    EIO/retry_timeout_seconds=0
> 
> 2) fail_at_unmount=0 && \
>    EIO/max_retries=1 && \
>    EIO/retry_timeout_seconds=0
> 
> 3) fail_at_unmount=0 && \
>    EIO/max_retries=-1 && \
>    EIO/retry_timeout_seconds=1
> 
> Signed-off-by: Zorro Lang <zlang@redhat.com>
> ---
> 
> Hi,
> 
> There're three patches from Eric fix XFS error handling bugs:
>   5539d36 xfs: don't reset b_retries to 0 on every failure
>   0b4db5d xfs: remove extraneous buffer flag changes
>   e97f6c5 xfs: fix xfs_error_get_cfg for negative errnos
> 
> Without these patches, configurable error handling cannot be properly
> set, and once set is not honored.
> 
> For test part of this bug, add EIO error handling test into xfs/006.
> The kernel with above 3 patches shouldn't hang on xfs/006.
> 
> I haven't got an idea about how to test ENOSPC and default error
> handling. So use EIO test to prove above patches can work well
> on EIO handling at least.

Can you put this into a new test? We don't tend to extend tests to
add new cases, we add new tests instead. Factor the common parts of
the tests into generic functions in common/ somewhere and call them
from each test.

This way adding new test cases doesn't cause tests that previously
passed to fail and hence signal false regressions.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
