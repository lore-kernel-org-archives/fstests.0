Received: from mx1.redhat.com ([209.132.183.28]:41735 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751320AbcGMMfV (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 13 Jul 2016 08:35:21 -0400
Date: Wed, 13 Jul 2016 20:34:54 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 2/4] fstests: filename handling for extended names in
 ./check was on a wrong place
Message-ID: <20160713123454.GW2432@eguan.usersys.redhat.com>
References: <1468229169-24045-1-git-send-email-jtulak@redhat.com>
 <1468229169-24045-3-git-send-email-jtulak@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1468229169-24045-3-git-send-email-jtulak@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Jan Tulak <jtulak@redhat.com>
Cc: fstests@vger.kernel.org, david@fromorbit.com
List-ID: <fstests@vger.kernel.org>

On Mon, Jul 11, 2016 at 11:26:07AM +0200, Jan Tulak wrote:
> The code handling "./check foo/123", when the real test is "foo/123-bar-baz"
> was moved at the earliest position, so everything working with the test name or
> path will know the full name. Thus, no "123" and "123-bar-baz" mix is possible.
> 
> Signed-off-by: Jan Tulak <jtulak@redhat.com>

Can you please include more details in the description? It seems not so
clear to me what the problem is from the description.

If I understand it correctly (after playing around), prior to the patch:
[root@dhcp-66-86-11 xfstests]# ./check xfs/999
...
xfs/999 0s ... 0s
Ran: xfs/999-test-case
Passed all 1 tests

After applying the patch:
[root@dhcp-66-86-11 xfstests]# ./check xfs/999
...
xfs/999-test-case 0s ... 0s
Ran: xfs/999-test-case
Passed all 1 tests

So the test name is always correct, right?

Thanks,
Eryu

> ---
>  check | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/check b/check
> index 5be183f..ef6bd47 100755
> --- a/check
> +++ b/check
> @@ -543,6 +543,20 @@ for section in $HOST_OPTIONS_SECTIONS; do
>  	for seq in $list
>  	do
>  	    err=false
> +	    if [ ! -f $seq ]; then
> +	        # Try to get full name in case the user supplied only seq id
> +	        # and the test has a name. A bit of hassle to find really
> +	        # the test and not its sample output or helping files.
> +	        bname=$(basename $seq)
> +	        full_seq=$(find $(dirname $seq) -name $bname* -executable |
> +	            awk '(NR == 1 || length < length(shortest)) { shortest = $0 }\
> +	            	END { print shortest }')
> +	        if [ -f $full_seq ] \
> +	            && [ x$(echo $bname | grep -o "^$VALID_TEST_ID") != x ]; then
> +	            seq=$full_seq
> +	            seqnum=${full_seq#*/}
> +	        fi
> +	    fi
>  
>  	    # the filename for the test and the name output are different.
>  	    # we don't include the tests/ directory in the name output.
> @@ -566,19 +580,6 @@ for section in $HOST_OPTIONS_SECTIONS; do
>  		if $showme; then
>  			echo
>  			continue
> -		elif [ ! -f $seq ]; then
> -			# Try to get full name in case the user supplied only seq id
> -			# and the test has a name. A bit of hassle to find really
> -			# the test and not its sample output or helping files.
> -			bname=$(basename $seq)
> -			full_seq=$(find $(dirname $seq) -name $bname* -executable |
> -				awk '(NR == 1 || length < length(shortest)) { shortest = $0 }\
> -					END { print shortest }')
> -			if [ -f $full_seq ] \
> -				&& [ x$(echo $bname | grep -o "^$VALID_TEST_ID") != x ]; then
> -				seq=$full_seq
> -				seqnum=${full_seq#*/}
> -			fi
>  		fi
>  
>  		if [ ! -f $seq ]; then
> -- 
> 2.5.5
> 
