Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:43665 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752293AbbCYNcf convert rfc822-to-8bit (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 25 Mar 2015 09:32:35 -0400
Date: Wed, 25 Mar 2015 09:32:35 -0400 (EDT)
From: Jan Tulak <jtulak@redhat.com>
Message-ID: <379097928.2563673.1427290355063.JavaMail.zimbra@redhat.com>
In-Reply-To: <1427290055-32647-1-git-send-email-jtulak@redhat.com>
References: <20150321131159.GA4810@dhcp-13-216.nay.redhat.com> <1427290055-32647-1-git-send-email-jtulak@redhat.com>
Subject: Re: [PATCH] fstests: Tests can use any name now, not 3 digits only.
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: fstests-owner@vger.kernel.org
To: eguan@redhat.com
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Eryu,
the sorting now puts the named tests at the end of group file and dots can't be in test names any more.

I hope this version looks finally ok.
Anyway, thank you for the feedback. :-)

Cheers,
Jan

----- Original Message -----
> From: "Jan Ťulák" <jtulak@redhat.com>
> To: eguan@redhat.com
> Cc: fstests@vger.kernel.org
> Sent: Wednesday, 25 March, 2015 2:27:35 PM
> Subject: [PATCH] fstests: Tests can use any name now, not 3 digits only.
> 
> Tests can use any name now, not 3 digits only.
> (e.g. a test can be named "tests/generic/some-name")
> 
> The only limitation on a test name is no whitespace and no dot.
> 
> Signed-off-by: Jan Ťulák <jtulak@redhat.com>
> ---
>  README |  2 +-
>  check  | 11 ++++++-----
>  new    | 50 +++++++++++++++++++++++++++++++++++++++++++++++---
>  3 files changed, 54 insertions(+), 9 deletions(-)
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
> index 0830e0c..da0bc31 100755
> --- a/check
> +++ b/check
> @@ -58,7 +58,7 @@ then
>      exit 1
>  fi
>  
> -SUPPORTED_TESTS="[0-9][0-9][0-9] [0-9][0-9][0-9][0-9]"
> +SUPPORTED_TESTS="[^\s.]\+"
>  SRC_GROUPS="generic shared"
>  export SRC_DIR="tests"
>  
> @@ -96,21 +96,22 @@ get_group_list()
>  		l=$(sed -n < $SRC_DIR/$d/group \
>  			-e 's/#.*//' \
>  			-e 's/$/ /' \
> -			-e "s;\(^[0-9][0-9][0-9]\).* $grp .*;$SRC_DIR/$d/\1;p")
> +			-e "s;^\($SUPPORTED_TESTS\).* $grp .*;$SRC_DIR/$d/\1;p")
>  		grpl="$grpl $l"
>  	done
>  	echo $grpl
>  }
>  
> -# find all tests, excluding files that are test metadata such as group
> files.
> -# This assumes that tests are defined purely by alphanumeric filenames with
> no
> -# ".xyz" extensions in the name.
> +# Find all tests, excluding files that are test metadata such as group
> files.
> +# It matches test names against $SUPPORTED_TESTS defined at the top of this
> +# file.
>  get_all_tests()
>  {
>  	touch $tmp.list
>  	for d in $SRC_GROUPS $FSTYP; do
>  		ls $SRC_DIR/$d/* | \
>  			grep -v "\..*" | \
> +			grep "^$SRC_DIR/$d/$SUPPORTED_TESTS"| \
>  			grep -v "group\|Makefile" >> $tmp.list 2>/dev/null
>  	done
>  }
> diff --git a/new b/new
> index d1f8939..6cf67a7 100755
> --- a/new
> +++ b/new
> @@ -84,8 +84,11 @@ eof=1
>  for found in `cat $tdir/group | $AWK_PROG '{ print $1 }'`
>  do
>      line=$((line+1))
> -    if [ -z "$found" ] || [ "$found" == "#" ];then
> -	continue
> +    if [ -z "$found" ] || [ "$found" == "#" ]; then
> +        continue
> +    elif ! echo "$found" | grep -q "^[0-9][0-9][0-9]$"; then
> +        # this one is for tests not named by a number
> +        continue
>      fi
>      i=$((i+1))
>      id=`printf "%03d" $i`
> @@ -99,9 +102,50 @@ if [ $eof -eq 1 ]; then
>     i=$((i+1))
>     id=`printf "%03d" $i`
>  fi
> +auto_id=$id
>  
>  echo "Next test is $id"
>  
> +read -p "Do you want to use ANOTHER name? y,[n]: " -r
> +if [[ "$REPLY" =~ ^[Yy]$ ]]; then
> +    # get the new name from user
> +    id=""
> +    while [ "$id" = "" ]; do
> +        read -p "Enter the new name: "
> +        if [ "$REPLY" = "" ]; then
> +            echo "Can't use empty name. For canceling, use ctrl+c."
> +        elif [ -e "$tdir/$REPLY" ]; then
> +            echo "File '$REPLY' already exists, use another one."
> +            echo #
> +        elif echo "$REPLY" | grep -q "^[^\\s.]\+$"; then
> +            id="$REPLY"
> +        else
> +            echo "Filename must not contain whitespaces and dots!"
> +            echo
> +        fi
> +    done
> +
> +    # now find where to insert this name
> +    eof=1
> +    line=0
> +    for found in `cat $tdir/group | $AWK_PROG '{ print $1 }'`
> +    do
> +        line=$((line+1))
> +        if [ -z "$found" ] || [ "$found" == "#" ]; then
> +            continue
> +        elif [[ "$found" > "$id" ]]; then
> +            eof=0
> +            break
> +        fi
> +    done
> +    if [ $eof -eq 1 ]; then
> +        # If place wasn't found, let $line be the end of the file
> +        line=$((line+1))
> +    fi
> +
> +fi
> +echo "Using '$id'."
> +
>  if [ -f $tdir/$id ]
>  then
>      echo "Error: test $id already exists!"
> @@ -115,7 +159,7 @@ year=`date +%Y`
>  
>  cat <<End-of-File >$tdir/$id
>  #! /bin/bash
> -# FS QA Test No. $id
> +# FS QA Test $id
>  #
>  # what am I here for?
>  #
> --
> 2.1.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
