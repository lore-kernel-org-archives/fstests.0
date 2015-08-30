Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:38648 "EHLO
	ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752171AbbH3XoK (ORCPT
	<rfc822;fstests@vger.kernel.org>); Sun, 30 Aug 2015 19:44:10 -0400
Date: Mon, 31 Aug 2015 09:43:33 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 1/2 v2] Add checks for hard links support.
Message-ID: <20150830234333.GM3902@dastard>
References: <1440757500.29614.26.camel@ari-macbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1440757500.29614.26.camel@ari-macbook>
Sender: fstests-owner@vger.kernel.org
To: Ari Sundholm <ari@tuxera.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Aug 28, 2015 at 01:25:00PM +0300, Ari Sundholm wrote:
> From: Ari Sundholm <ari@tuxera.com>
> 
> There are filesystems that do not support hard links that we want to run
> xfstests on. Add a function for checking for support and use it wherever
> hard links are used.

As I've already pointed out, all of the filesystems that xfstests
supports have working hardlinks, so this is a test that will never
fail for anyone running xfstests on supported filesystems.

Also, I'm left to wonder what kernel filesystem supports
journaling but does not support hardlinks (as noted by the number of
tests you change that have "_require_metadata_journaling"). Why
aren't you also posting the patches to support the filesystem that
requires this "don't use hardlinks" patch?

And FWIW:

> +_require_test_hardlinks()
> +{
> +	target=`mktemp -p $TEST_DIR`
> +	link=`mktemp -p $TEST_DIR -u`
> +	ln `basename $target` $link
> +	if [ "$?" -ne 0 ]; then
> +		rm -f $target
> +		_notrun "Require hardlinks support"
> +	fi
> +	rm -f $target $link
> +}

You check for support on the TEST_DEV, but ...

> diff --git a/tests/generic/039 b/tests/generic/039
> index 4bbfc50..367a6d0 100755
> --- a/tests/generic/039
> +++ b/tests/generic/039
> @@ -55,6 +55,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>  _supported_fs generic
>  _supported_os Linux
>  _need_to_be_root
> +_require_test_hardlinks
>  _require_scratch
>  _require_dm_flakey
>  _require_metadata_journaling $SCRATCH_DEV

All but two of the tests you've added this check to make hard links
on the SCRATCH_DEV, which can have a different configuration to the
TEST_DEV.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
