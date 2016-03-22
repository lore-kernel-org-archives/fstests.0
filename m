Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:47250 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752265AbcCVW4q (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 22 Mar 2016 18:56:46 -0400
Date: Wed, 23 Mar 2016 09:56:14 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] fstests: xfs: add necessary version check for xfs/122
Message-ID: <20160322225614.GW11812@dastard>
References: <1458549088-468-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1458549088-468-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Mar 21, 2016 at 04:31:28PM +0800, Xiaoguang Wang wrote:
> From: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
> 
> Since commit c0cfa5651f2d ("xfs/122: update against xfsprogs 4.3"), xfs/122
> has been updated against xfsprogs 4.3, so add necessary version check.
> 
> Signed-off-by: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>

This sort of version test belongs in autoconf, not the tests
themselves.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
