Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:6399 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751295AbcGQXbj (ORCPT
	<rfc822;fstests@vger.kernel.org>); Sun, 17 Jul 2016 19:31:39 -0400
Date: Mon, 18 Jul 2016 09:31:36 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] xfs: fix wrong seq order in group file
Message-ID: <20160717233136.GZ1922@dastard>
References: <1468558761-22665-1-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1468558761-22665-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Jul 15, 2016 at 12:59:21PM +0800, Eryu Guan wrote:
> 006 and 007 are in reverse order, and this breaks tools to find the
> next available seq number in group file (e.g. tools/nextid).
> 
> Signed-off-by: Eryu Guan <eguan@redhat.com>
> ---
> I made this mistake when merging xfs/006, sorry!
> 
>  tests/xfs/group | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/xfs/group b/tests/xfs/group
> index 9f8ca0f..59d2a85 100644
> --- a/tests/xfs/group
> +++ b/tests/xfs/group
> @@ -3,8 +3,8 @@
>  003 db auto quick
>  004 db auto quick
>  005 auto quick
> -007 auto quota quick
>  006 auto quick mount
> +007 auto quota quick
>  008 rw ioctl auto quick

Reviewed-by: Dave Chinner <dchinner@redhat.com>

-Dave
-- 
Dave Chinner
david@fromorbit.com
