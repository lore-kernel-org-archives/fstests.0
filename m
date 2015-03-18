Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:60921 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754099AbbCRSBh convert rfc822-to-8bit (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 18 Mar 2015 14:01:37 -0400
Received: from zmail22.collab.prod.int.phx2.redhat.com (zmail22.collab.prod.int.phx2.redhat.com [10.5.83.26])
	by mx6-phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t2II1bpb020647
	for <fstests@vger.kernel.org>; Wed, 18 Mar 2015 14:01:37 -0400
Date: Wed, 18 Mar 2015 14:01:36 -0400 (EDT)
From: Jan Tulak <jtulak@redhat.com>
Message-ID: <773739465.18375222.1426701696973.JavaMail.zimbra@redhat.com>
In-Reply-To: <1425484517-7938-1-git-send-email-jtulak@redhat.com>
References: <1425484517-7938-1-git-send-email-jtulak@redhat.com>
Subject: Re: [PATCH] Tests can use any name now, not 3 digits only.
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

I got no reply on this patch, so bounce in case no one noticed it. :-)

Cheers,
Jan

----- Original Message -----
> From: "Jan Ťulák" <jtulak@redhat.com>
> To: fstests@vger.kernel.org
> Cc: "Jan Ťulák" <jtulak@redhat.com>
> Sent: Wednesday, 4 March, 2015 4:55:17 PM
> Subject: [PATCH] Tests can use any name now, not 3 digits only.
> 
> Tests can use any name now, not 3 digits only.
> (e.g. a test can be named "tests/generic/some-name")
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
> +        # this one is for tests not named by a number
> +        continue
>      fi
>      i=$((i+1))
>      id=`printf "%03d" $i`
> --
> 2.1.0
> 
> 
