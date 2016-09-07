Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:23384 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750977AbcIGWnL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 7 Sep 2016 18:43:11 -0400
Date: Thu, 8 Sep 2016 08:43:09 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v3 1/2] common/rc: introduce _overlay_mount_dirs helper
Message-ID: <20160907224308.GE22388@dastard>
References: <1472706384-12262-1-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1472706384-12262-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Sep 01, 2016 at 01:06:23PM +0800, Eryu Guan wrote:
> Introduce a new _overlay_mount_dirs() helper to do the actual
> overlay mount operation and factor _overlay_scratch_mount and
> _overlay_mount code to use a single implemention of
> _overlay_mount_dirs(). Also convert all bare mount of overlay in
> tests to use it.
> 
> Suggested-by: Dave Chinner <dchinner@redhat.com>
> Signed-off-by: Eryu Guan <eguan@redhat.com>

Reviewed-by: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
david@fromorbit.com
