Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:16303 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750977AbcIGWnc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 7 Sep 2016 18:43:32 -0400
Date: Thu, 8 Sep 2016 08:43:30 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v3 2/2] overlay: copy-up lowerdir which has opaque xattr
 set
Message-ID: <20160907224330.GF22388@dastard>
References: <1472706384-12262-1-git-send-email-eguan@redhat.com>
 <1472706384-12262-2-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1472706384-12262-2-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Sep 01, 2016 at 01:06:24PM +0800, Eryu Guan wrote:
> When copying up a directory with opaque xattr set, the xattr was
> copied up as well, after a remount the opaque flag is honored so the
> copied-up directory is treated as opaque, which causes files created
> in the lowerdir to be hidden when using multiple lower directories.
> 
> This is fixed by "ovl: don't copy up opaqueness".
> 
> Signed-off-by: Eryu Guan <eguan@redhat.com>

Reviewed-by: Dave Chinner <dchinner@redhat.com>
-- 
Dave Chinner
david@fromorbit.com
