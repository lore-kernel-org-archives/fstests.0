Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:14573 "EHLO
	ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753429AbbFQVuT (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 17 Jun 2015 17:50:19 -0400
Date: Thu, 18 Jun 2015 07:49:58 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] common/punch, generic/273: Minor things for busybox
 support.
Message-ID: <20150617214958.GI10224@dastard>
References: <1433788464.28321.9.camel@ari-macbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1433788464.28321.9.camel@ari-macbook>
Sender: fstests-owner@vger.kernel.org
To: Ari Sundholm <ari@tuxera.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Jun 08, 2015 at 09:34:24PM +0300, Ari Sundholm wrote:
> From: Ari Sundholm <ari@tuxera.com>
> 
> These changes make it possible to run more of the tests on busybox.
> 
> Signed-off-by: Ari Sundholm <ari@tuxera.com>
> ---
>  common/punch      | 4 ++--
>  tests/generic/273 | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/common/punch b/common/punch
> index a75f4cf..7f268cd 100644
> --- a/common/punch
> +++ b/common/punch
> @@ -203,7 +203,7 @@ _coalesce_extents()
>  
>  _filter_fiemap()
>  {
> -	awk --posix '
> +	awk '

Should be using $AWK_PROG.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
