Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:1573 "EHLO
	ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932319AbcGDBqU (ORCPT
	<rfc822;fstests@vger.kernel.org>); Sun, 3 Jul 2016 21:46:20 -0400
Date: Mon, 4 Jul 2016 11:46:17 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 2/2] xfstests: filename handling for extended names in
 ./check was on a wrong place
Message-ID: <20160704014617.GB27480@dastard>
References: <1467389347-2055-1-git-send-email-jtulak@redhat.com>
 <1467389347-2055-3-git-send-email-jtulak@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1467389347-2055-3-git-send-email-jtulak@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Jan Tulak <jtulak@redhat.com>
Cc: fstests@vger.kernel.org, eguan@redhat.com
List-ID: <fstests@vger.kernel.org>

On Fri, Jul 01, 2016 at 06:09:07PM +0200, Jan Tulak wrote:
> The code handling "./check foo/123", when the real test is "foo/123-bar-baz"
> was moved at the earliest position, so everything working with the test
> name/path will know the full name, and no 123/123-bar-baz mix is possible.
> 
> When moving the code, put qutation marks around a wildcard name to prevent
> early expansion

Can you put this in a separate patch so it's easy to see and review?
i.e. move the code in one patch, change the code in a second?

> Signed-off-by: Jan Tulak <jtulak@redhat.com>
> ---
>  check | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/check b/check
> index 5be183f..10ae375 100755
> --- a/check
> +++ b/check
> @@ -543,6 +543,20 @@ for section in $HOST_OPTIONS_SECTIONS; do
>  	for seq in $list
>  	do
>  	    err=false
> +		if [ ! -f $seq ]; then
> +			# Try to get full name in case the user supplied only seq id
> +			# and the test has a name. A bit of hassle to find really
> +			# the test and not its sample output or helping files.
> +			bname=$(basename $seq)
> +
> +			full_seq=$(find $(dirname $seq) -name "$bname*" -executable |
> +				awk '(NR == 1 || length < length(shortest)) { shortest = $0 }\
> +					END { print shortest }')
> +			if [ -f $full_seq ] \
> +				&& [ x$(echo $bname | grep -o "^$VALID_TEST_ID") != x ]; then
> +				seq=$full_seq
> +			fi
> +		fi
>  
>  	    # the filename for the test and the name output are different.
>  	    # we don't include the tests/ directory in the name output.

This now has whitespace issues - the indentation does not match the
surrounding context.

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com
