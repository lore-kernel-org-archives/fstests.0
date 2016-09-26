Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:50168 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750761AbcIZEos (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 26 Sep 2016 00:44:48 -0400
Date: Mon, 26 Sep 2016 14:44:43 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] check: check SCRATCH_MNT before calling _scratch_mkfs
Message-ID: <20160926044443.GA2532@dastard>
References: <81e70e43-b337-acca-1c29-69db4f3a3cfa@jeffm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81e70e43-b337-acca-1c29-69db4f3a3cfa@jeffm.io>
Sender: fstests-owner@vger.kernel.org
To: Jeff Mahoney <jeffm@jeffm.io>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sun, Sep 25, 2016 at 09:44:13PM -0400, Jeff Mahoney wrote:
> On NFS or Overlayfs, "mkfs" turns into rm -rf $SCRATCH_MNT/*
> 
> There is no warning/error in check if SCRATCH_MNT is unset.
> 
> Also add the checks to _scratch_cleanup_files.
> 
> Signed-off-by: Jeff Mahoney <jeffm@suse.com>
> ---
>  check     | 12 ++++++++++++
>  common/rc |  8 ++++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/check b/check
> index 69341d8..b22d2df 100755
> --- a/check
> +++ b/check
> @@ -512,6 +512,18 @@ for section in $HOST_OPTIONS_SECTIONS; do
>  	needwrap=true
>  
>  	if [ ! -z "$SCRATCH_DEV" ]; then
> +	   if [ -z "$SCRATCH_MNT" ]
> +	    then
> +		echo "\$SCRATCH_MNT is unset"
> +		status=1
> +		exit
> +	    fi
> +	   if [ ! -d "$SCRATCH_MNT" ]
> +	    then
> +		echo "\$SCRATCH_MNT is not a dir"
> +		status=1
> +		exit
> +	    fi

That is supposed to be checked in get_next_config() at the start of
the loop. It runs these checks on the scratch config:

	_check_device SCRATCH_DEV optional $SCRATCH_DEV
	if [ ! -z "$SCRATCH_MNT" -a ! -d "$SCRATCH_MNT" ]; then
		echo "common/config: Error: \$SCRATCH_MNT ($SCRATCH_MNT) is not a directory"
		exit 1
	fi

If SCRATCH_DEV/SCRATCH_MNT is not set - which is a valid config -
the all that is supposed to happen is that tests which call
_require_scratch() should not run. This, in turn should prevent
the mkfs->rm problem you mention. The above code in
get_next_config() is what needs fixing, not the check code...

How did you actually trip over this?  I'm guessing you have a config
problem where you are defining SCRATCH_DEV but not SCRATCH_MNT?
Or you didn't set SCRATCH_DEV_NOT_USED?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
