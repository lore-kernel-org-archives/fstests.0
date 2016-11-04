Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:22660 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752404AbcKDApS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 3 Nov 2016 20:45:18 -0400
Date: Fri, 4 Nov 2016 11:44:46 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v2] common: add CephFS support
Message-ID: <20161104004446.GE28177@dastard>
References: <20161103123613.28973-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161103123613.28973-1-ddiss@suse.de>
Sender: fstests-owner@vger.kernel.org
To: David Disseldorp <ddiss@suse.de>
Cc: fstests@vger.kernel.org, Joao Eduardo Luis <joao@suse.de>
List-ID: <fstests@vger.kernel.org>

On Thu, Nov 03, 2016 at 01:36:13PM +0100, David Disseldorp wrote:
> From: Joao Eduardo Luis <joao@suse.de>
> 
> Add basic CephFS support. No new CephFS specific tests are included,
> just basic enablement, with ./check now accepting a -ceph parameter.
> 
> Signed-off-by: Joao Eduardo Luis <joao@suse.de>
> Reviewed-by: David Disseldorp <ddiss@suse.de>

Looks good!

Reviewed-by: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
david@fromorbit.com
