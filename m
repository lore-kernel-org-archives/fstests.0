Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:8066 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750941AbcEIGFf (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 9 May 2016 02:05:35 -0400
Date: Mon, 9 May 2016 16:05:30 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] fstests: fix various $seqres.full issues
Message-ID: <20160509060530.GT18496@dastard>
References: <1462358277-27766-1-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1462358277-27766-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, May 04, 2016 at 06:37:57PM +0800, Eryu Guan wrote:
> There're many tests don't remove $seqres.full before writing to it, and
> accumulating logs there, then the logs are always growing over time.
> Let's fix them once.
> 
> generic/16[1-8] generic/170 and generic/33[34] truncate $seqres.full in
> the middle of the test, which results in partial logs. Fix them as well.
> 
> xfs/227 has duplicated lines to remove $seqres.full, remove the extra
> line.
.....
> diff --git a/tests/xfs/261 b/tests/xfs/261
> index 950c539..962f6fc 100755
> --- a/tests/xfs/261
> +++ b/tests/xfs/261
> @@ -51,6 +51,7 @@ _cleanup()
>  . ./common/quota
>  
>  echo "Silence is golden."
> +rm -r $seqres.full
      ^^

I think you meant rm -f. Test fails when $seqres.full doesn't
exist...

I've fixed it up.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
