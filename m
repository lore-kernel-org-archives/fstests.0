Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:5395 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750714AbcJSEns (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 19 Oct 2016 00:43:48 -0400
Date: Wed, 19 Oct 2016 15:42:41 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] xfs: fix __populate_check_xfs_dir
Message-ID: <20161019044241.GJ14023@dastard>
References: <1476759584-4150-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1476759584-4150-1-git-send-email-yangx.jy@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: fstests@vger.kernel.org, darrick.wong@oracle.com
List-ID: <fstests@vger.kernel.org>

On Tue, Oct 18, 2016 at 10:59:44AM +0800, Xiao Yang wrote:
> We need to remove unused ${SCRATCH_DEV} when calling __populate_check_xfs_dir
> because __populate_check_xfs_dir function has been rewritten by Darrick.

Can you reference the commit that the relevant change was contained
in, please? Darrick has made lots of changes - saying "fix
something after Darrick changed something else" isn't very
meaningful, especially when someone looks at the commit in a few
years time. Instead, try something like this:

----
[PATCH] xfstests: remove the device parameter from __populate_check_xfs_dir

In commit abcdef1234 ("rewrite the frobnozzle"), the need for
callers to pass the device to populate into
__populate_check_xfs_dir() was removed. We can now clean up all the
callers by removing the device parameter."
----

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
