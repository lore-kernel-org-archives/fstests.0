Received: from ipmail01.adl6.internode.on.net ([150.101.137.136]:8451 "EHLO
        ipmail01.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751370AbeEKXcl (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 11 May 2018 19:32:41 -0400
Date: Sat, 12 May 2018 09:32:39 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v2] xfs: test inode allocation state missmatch corruption
Message-ID: <20180511233239.GZ23861@dastard>
References: <20180511161127.15158-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180511161127.15158-1-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sat, May 12, 2018 at 12:11:27AM +0800, Zorro Lang wrote:
> There's a situation where the directory structure and the inobt
> thinks the inode is free, but the inode on disk thinks it is still
> in use. XFS should detect it and prevent the kernel from oopsing
> on lookup.

Isn't this testing the same thing that I recently posted "xfs: test
inobt/on disk free state mismatches" for?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
