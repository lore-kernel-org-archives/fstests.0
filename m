Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:38664 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727007AbfAUXJX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 21 Jan 2019 18:09:23 -0500
Date: Tue, 22 Jan 2019 10:09:19 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 7/7] check: move test exclusion handling to
 _prepare_test_list
Message-ID: <20190121230919.GI4205@dastard>
References: <20190121163316.20616-1-jeffm@suse.com>
 <20190121163316.20616-7-jeffm@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121163316.20616-7-jeffm@suse.com>
Sender: fstests-owner@vger.kernel.org
To: jeffm@suse.com
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Jan 21, 2019 at 11:33:16AM -0500, jeffm@suse.com wrote:
> From: Jeff Mahoney <jeffm@suse.com>
> 
> In order to simplify combining excluded tests specified on the command
> line vs specified via config files,

You mean defining excludes in configs/<hostname>.config files,
right? i.e. in config sections?

But the section code only calls _prepare_test_list if the test dev
is recreated by each section, right? So you can't really change the
expunge list from the config files without forcing a test dev
reformat, right?

> it makes sense to push the handling
> into _prepare_test_list.  This means we start with a fresh $tmp.xlist
> and rebuild it each time _prepare_test_list is called.

The patch does more than that, right?

> Signed-off-by: Jeff Mahoney <jeffm@suse.com>
> ---
>  check | 41 ++++++++++++++++++++++++-----------------
>  1 file changed, 24 insertions(+), 17 deletions(-)
> 
> diff --git a/check b/check
> index 77a06b00..17073c4e 100755
> --- a/check
> +++ b/check
> @@ -230,7 +230,28 @@ _prepare_test_list()
>  		done
>  	fi
>  
> -	# Specified groups to exclude
> +	:> $tmp.xlist
> +
> +	# Per-fstype/generic/shared file of tests to exclude (-X)
> +	for xfile in $XGROUP_FILES; do

That adds support for multiple group exclude files (i.e. multiple -X
options), right?

> +		for d in $SRC_GROUPS $FSTYP; do
> +			[ -f $SRC_DIR/$d/$xfile ] || continue
> +			for f in `sed "s/#.*$//" $SRC_DIR/$d/$xfile`; do
> +				echo "$d/$f command line" >> $tmp.xlist
> +			done
> +		done
> +	done
> +
> +	# External file of tests to exclude (-E)
> +	for xfile in $EXCLUDE_FILES; do
> +		if [ -f $xfile ]; then
> +			sed -e "s/#.*$//" \
> +			    -e "s;$; file $xfile;" "$xfile" \

And I have no idea what problem this second expression is solving -
it wasn't in the original code that got copied here.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
