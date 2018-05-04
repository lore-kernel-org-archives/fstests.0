Received: from sandeen.net ([63.231.237.45]:38898 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751262AbeEDDNH (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 3 May 2018 23:13:07 -0400
Subject: Re: [PATCH] check: run auto test group by default
References: <20180504000509.2498-1-david@fromorbit.com>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <656d33c0-a0ac-4a9a-9696-931cc750b914@sandeen.net>
Date: Thu, 3 May 2018 22:13:05 -0500
MIME-Version: 1.0
In-Reply-To: <20180504000509.2498-1-david@fromorbit.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
Cc: willy@infradead.org
List-ID: <fstests@vger.kernel.org>

On 5/3/18 7:05 PM, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Everyone who starts using fstests runs "check" without parameters,
> and then has problems with it running dangerous tests. most people
> just want fstests to act as a regression test suite, not a fuzzer or
> exercise known crash conditions. Hence make the default behaviour to
> be "run the auto group" rather than "run every test".
> 
> To enable people to run all tests easily (if they really want to)
> add a special group keyword named "all". This wildcard will trigger
> selecting all the tests in fstests as per the original "check
> without parameters" behaviour.
> 
> Signed-Off-By: Dave Chinner <dchinner@redhat.com>

I haven't tested but I assume you have ;) and this looks OK to me.

I agree that this makes things much more friendly to the new user,
thanks.

Reviewed-by: Eric Sandeen <sandeen@redhat.com>

> ---
>  check | 34 +++++++++++++++++++++-------------
>  1 file changed, 21 insertions(+), 13 deletions(-)
> 
> diff --git a/check b/check
> index 84a35e6724ab..170004d4b2a2 100755
> --- a/check
> +++ b/check
> @@ -102,6 +102,8 @@ a test file name match pattern (e.g. xfs/*).
>  group argument is either a name of a tests group to collect from all
>  the test dirs (e.g. quick) or a name of a tests group to collect from
>  a specific tests dir in the form of <test dir>/<group name> (e.g. xfs/quick).
> +If you want to run all the tests in teh test suite, use "-g all" to specify all
> +groups.
>  
>  exclude_file argument refers to a name of a file inside each test directory.
>  for every test dir where this file is found, the listed test names are
> @@ -220,22 +222,24 @@ _prepare_test_list()
>  	fi
>  
>  	# Specified groups to include
> -	for group in $GROUP_LIST; do
> -		list=$(get_group_list $group)
> -		if [ -z "$list" ]; then
> -			echo "Group \"$group\" is empty or not defined?"
> -			exit 1
> -		fi
> +	# Note that the CLI processing adds a leading space to the first group
> +	# parameter, so we have to catch that here checking for "all"
> +	if ! $have_test_arg && [ "$GROUP_LIST" == " all" ]; then
> +		# no test numbers, do everything
> +		get_all_tests
> +	else
> +		for group in $GROUP_LIST; do
> +			list=$(get_group_list $group)
> +			if [ -z "$list" ]; then
> +				echo "Group \"$group\" is empty or not defined?"
> +				exit 1
> +			fi
>  
> -		for t in $list; do
> -			grep -s "^$t\$" $tmp.list >/dev/null || \
> +			for t in $list; do
> +				grep -s "^$t\$" $tmp.list >/dev/null || \
>  							echo "$t" >>$tmp.list
> +			done
>  		done
> -	done
> -
> -	if ! $have_test_arg && [ -z "$GROUP_LIST" ]; then
> -		# no test numbers, do everything
> -		get_all_tests
>  	fi
>  
>  	# Specified groups to exclude
> @@ -364,6 +368,10 @@ if $have_test_arg; then
>  
>  		shift
>  	done
> +elif [ -z "$GROUP_LIST" ]; then
> +	# default group list is the auto group. If any other group or test is
> +	# specified, we use that instead.
> +	GROUP_LIST="auto"
>  fi
>  
>  # we need common/rc
> 
