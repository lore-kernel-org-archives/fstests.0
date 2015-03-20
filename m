Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59810 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751157AbbCTLNW (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 20 Mar 2015 07:13:22 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t2KBDMKf020627
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Fri, 20 Mar 2015 07:13:22 -0400
Date: Fri, 20 Mar 2015 19:13:20 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] Tests can use any name now, not 3 digits only.
Message-ID: <20150320111320.GW4810@dhcp-13-216.nay.redhat.com>
References: <1425484517-7938-1-git-send-email-jtulak@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1425484517-7938-1-git-send-email-jtulak@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Jan =?utf-8?B?xaR1bMOhaw==?= <jtulak@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Mar 04, 2015 at 04:55:17PM +0100, Jan Ťulák wrote:
> Tests can use any name now, not 3 digits only.
> (e.g. a test can be named "tests/generic/some-name")

I think you can add "fstests: " prefix to summary

fstests: tests can use any name not 3 digits only

And it looks good to me overall. I tested with the name "some-test"
"some-test-001" "some_test" "some-test-001.test", all worked fine. Also
tested with ./check -g testgroup (added testgroup to some random tests),
it worked too.

Some comments inline.

> 
> Signed-off-by: Jan Ťulák <jtulak@redhat.com>
> ---
>  README | 2 +-
>  check  | 6 +++---
>  new    | 7 +++++--
>  3 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/README b/README
> index 0c9449a..2376674 100644
> --- a/README
> +++ b/README
> @@ -205,7 +205,7 @@ Test script environment:
>  
>  Verified output:
>  
> -    Each test script has a numerical name, e.g. 007, and an associated
> +    Each test script has a name, e.g. 007, and an associated
>      verified output, e.g. 007.out.
>  
>      It is important that the verified output is deterministic, and
> diff --git a/check b/check
> index 0830e0c..d7814a8 100755
> --- a/check
> +++ b/check
> @@ -58,7 +58,7 @@ then
>      exit 1
>  fi
>  
> -SUPPORTED_TESTS="[0-9][0-9][0-9] [0-9][0-9][0-9][0-9]"
> +SUPPORTED_TESTS="\S\+"
>  SRC_GROUPS="generic shared"
>  export SRC_DIR="tests"
>  
> @@ -96,7 +96,7 @@ get_group_list()
>  		l=$(sed -n < $SRC_DIR/$d/group \
>  			-e 's/#.*//' \
>  			-e 's/$/ /' \
> -			-e "s;\(^[0-9][0-9][0-9]\).* $grp .*;$SRC_DIR/$d/\1;p")
> +			-e "s;^\($SUPPORTED_TESTS\).* $grp .*;$SRC_DIR/$d/\1;p")
>  		grpl="$grpl $l"
>  	done
>  	echo $grpl
> @@ -111,6 +111,7 @@ get_all_tests()

The comments before get_all_tests() should be updated too, which says

"
# This assumes that tests are defined purely by alphanumeric filenames with no
# ".xyz" extensions in the name.
"

>  	for d in $SRC_GROUPS $FSTYP; do
>  		ls $SRC_DIR/$d/* | \
>  			grep -v "\..*" | \
> +			grep "^$SRC_DIR/$d/$SUPPORTED_TESTS"| \
>  			grep -v "group\|Makefile" >> $tmp.list 2>/dev/null
>  	done
>  }
> @@ -178,7 +179,6 @@ _prepare_test_list()
>  		# no test numbers, do everything
>  		get_all_tests
>  	fi
> -

Leave this line not removed.

>  	# Specified groups to exclude
>  	for xgroup in $XGROUP_LIST; do
>  		list=$(get_group_list $xgroup)
> diff --git a/new b/new
> index 86f9075..f755da3 100755
> --- a/new
> +++ b/new
> @@ -84,8 +84,11 @@ eof=1
>  for found in `cat $tdir/group | $AWK_PROG '{ print $1 }'`
>  do
>      line=$((line+1))
> -    if [ -z "$found" ] || [ "$found" == "#" ];then
> -	continue
> +    if [ -z "$found" ] || [ "$found" == "#" ] ;then
> +        continue
> +    elif ! echo "$found"|grep "[0-9][0-9][0-9]";then

I'm being picky here :)

put space around pipe, echo "$found" | grep

and add space between ";" and "then", no space before ";"

if [ condition ]; then
fi

> +        # this one is for tests not named by a number
> +        continue

If I have a test name like "some-test-001" which has three digits too,
"new" script is not working well

[root@hp-dl388eg8-01 xfstests]# ./new generic
Building include
Building lib
Building ltp
Building src
Building aio-dio-regress
Building m4
Building common
Building tests
001
002
003
some-test-001
Next test is 004
Error: test 004 already exists!

And do we need a prompt in "new" to give user a change to create user
defined test name? It's still defaulting to three digits.

Thanks,
Eryu
>      fi
>      i=$((i+1))
>      id=`printf "%03d" $i`
> -- 
> 2.1.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
