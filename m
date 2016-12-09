Received: from mx1.redhat.com ([209.132.183.28]:36478 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932170AbcLIEQn (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 8 Dec 2016 23:16:43 -0500
Date: Fri, 9 Dec 2016 12:16:41 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] common: fix excluding test groups
Message-ID: <20161209041641.GL29149@eguan.usersys.redhat.com>
References: <1481204070-10881-1-git-send-email-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1481204070-10881-1-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
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

You mean "./check -n -x fuzzers,dangerous_fuzzers | wc -l" here?

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

Perhaps a sed is more efficient? e.g.

-		cat $tmp.arglist > $tmp.list
+		sed 's/ \+/\n/g' $tmp.arglist > $tmp.list

Thanks,
Eryu
