Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:52866 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750801AbbH0Bsg (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 26 Aug 2015 21:48:36 -0400
Date: Thu, 27 Aug 2015 11:48:22 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 2/2] Add some missing symlinks and hardlinks requirements.
Message-ID: <20150827014822.GJ3902@dastard>
References: <1440580548.29614.6.camel@ari-macbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1440580548.29614.6.camel@ari-macbook>
Sender: fstests-owner@vger.kernel.org
To: Ari Sundholm <ari@tuxera.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Aug 26, 2015 at 12:15:48PM +0300, Ari Sundholm wrote:
> From: Ari Sundholm <ari@tuxera.com>
> 
> Signed-off-by: Ari Sundholm <ari@tuxera.com>
> ---
>  tests/generic/067 |    1 +
>  tests/generic/236 |    1 +
>  tests/generic/294 |    1 +
>  3 files changed, 3 insertions(+)
> 
> diff --git a/tests/generic/067 b/tests/generic/067
> index 7a4840b..8322ef8 100755
> --- a/tests/generic/067
> +++ b/tests/generic/067
> @@ -52,6 +52,7 @@ _cleanup()
>  # Modify as appropriate.
>  _supported_fs generic
>  _supported_os Linux
> +_require_test_symlinks
>  _require_test
>  _require_scratch
>  _require_loop
> diff --git a/tests/generic/236 b/tests/generic/236
> index 12ea0bc..df0250f 100755
> --- a/tests/generic/236
> +++ b/tests/generic/236
> @@ -43,6 +43,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>  _supported_fs generic
>  # only Linux supports fallocate
>  _supported_os Linux
> +_require_test_hardlinks
>  _require_test

This belongs in the previous patch that introduced the check.

Cheers,

DAve.
-- 
Dave Chinner
david@fromorbit.com
