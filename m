Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:55319 "EHLO
        ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752627AbcLIFlN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 9 Dec 2016 00:41:13 -0500
Date: Fri, 9 Dec 2016 16:40:55 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] common: fix excluding test groups
Message-ID: <20161209054055.GO4326@dastard>
References: <1481204070-10881-1-git-send-email-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1481204070-10881-1-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: Eryu Guan <eguan@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Dec 08, 2016 at 03:34:30PM +0200, Amir Goldstein wrote:
> The -x flag is used to exclude tests that belong to
> certain groups from the test args list.
> 
> When the test args list is expressed as a match pattern,
> -x fails to exclude the tests that match the pattern
> and belong to excluded groups.
> 
> For example:
> $ ./check -n -x xfs/??? | wc -l
> 341
> $ ./check -n -x fuzzers,dangerous_fuzzers xfs/??? | wc -l
> 341
> 
> After the fix:
> $ ./check -n -x fuzzers,dangerous_fuzzers xfs/??? | wc -l
> 315
> 
> This bug seems to date back to this git repo epoc.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  check | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/check b/check
> index 8f2a1bb..9732460 100755
> --- a/check
> +++ b/check
> @@ -158,11 +158,14 @@ _timestamp()
>  _prepare_test_list()
>  {
>  	unset list
> +	touch $tmp.list
>  	# Tests specified on the command line
>  	if [ -s $tmp.arglist ]; then
> -		cat $tmp.arglist > $tmp.list
> -	else
> -		touch $tmp.list
> +		# flatten multi tests line (tests/$fs/???) to 1 test per line
> +		list=$(cat $tmp.arglist)
> +		for t in $list; do
> +			echo "$t" >> $tmp.list
> +		done

Shouldn't the wildcard be evaluated when the CLI argument is being
processed and cheked against the group file contents, not hidden in
this code? i.e. in the CLI argument processing section starting
here:

# Process tests from command line now.
if $have_test_arg; then
....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
