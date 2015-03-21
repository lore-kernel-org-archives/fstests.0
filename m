Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34021 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751190AbbCUEtf (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sat, 21 Mar 2015 00:49:35 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t2L4nYPD010626
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Sat, 21 Mar 2015 00:49:35 -0400
Date: Sat, 21 Mar 2015 12:49:32 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] fstests: tests can use any name now, not 3 digits only.
Message-ID: <20150321044932.GZ4810@dhcp-13-216.nay.redhat.com>
References: <20150320111320.GW4810@dhcp-13-216.nay.redhat.com>
 <1426863805-959-1-git-send-email-jtulak@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1426863805-959-1-git-send-email-jtulak@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Jan =?utf-8?B?xaR1bMOhaw==?= <jtulak@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Mar 20, 2015 at 04:03:25PM +0100, Jan Ťulák wrote:
> Tests can use any name now, not 3 digits only.
> (e.g. a test can be named "tests/generic/some-name")
> 
> Signed-off-by: Jan Ťulák <jtulak@redhat.com>
> ---
>  README |  2 +-
>  check  | 11 ++++++-----
>  new    | 27 +++++++++++++++++++++++++--
>  3 files changed, 32 insertions(+), 8 deletions(-)
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
> index 0830e0c..394fae4 100755
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
> -# find all tests, excluding files that are test metadata such as group files.
> -# This assumes that tests are defined purely by alphanumeric filenames with no
> -# ".xyz" extensions in the name.
> +# Find all tests, excluding files that are test metadata such as group files.
> +# It matches test names against $SUPPORTED_TESTS defined at the top of this 

Trailing whitespace in above line

> +# file.
>  get_all_tests()
>  {
>  	touch $tmp.list
>  	for d in $SRC_GROUPS $FSTYP; do
>  		ls $SRC_DIR/$d/* | \
>  			grep -v "\..*" | \
> +			grep "^$SRC_DIR/$d/$SUPPORTED_TESTS"| \

I just found that this will skip all tests with dot in the name, if
there's a test has dot in the name(e.g. some-name.test) it won't be run
when ./check with no other arguments. "./check -n" could show all tests
to be run, and "some-name.test" is not in the list.

Or "." should not be allowed in test name?

>  			grep -v "group\|Makefile" >> $tmp.list 2>/dev/null
>  	done
>  }
> diff --git a/new b/new
> index d1f8939..60b898a 100755
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
> +    elif ! echo "$found" | grep "^[0-9][0-9][0-9]$" > /dev/null; then

grep -q to be quiet

> +        # this one is for tests not named by a number
> +        continue
>      fi
>      i=$((i+1))
>      id=`printf "%03d" $i`
> @@ -102,6 +105,26 @@ fi
>  
>  echo "Next test is $id"
>  
> +read -p "Do you want to use ANOTHER name? y,[n]: " -r
> +if [[ "$REPLY" =~ ^[Yy]$ ]]; then
> +    id=""
> +    while [ "$id" = "" ]; do
> +        read -p "Enter the new name: "
> +        if [ "$REPLY" = "" ]; then
> +            echo "Can't use empty name. For canceling, use ctrl+c."
> +        elif [ -e "$tdir/$REPLY" ]; then
> +            echo "File '$REPLY' already exists, use another one."
> +            echo #
> +        elif echo "$REPLY" | grep "^\\S\+$" > /dev/null; then

here too, grep -q

> +            id="$REPLY"
> +        else
> +            echo "Filename must not contain whitespaces!"
> +            echo
> +        fi
> +    done
> +fi
> +echo "Using '$id'."
> +

Now new case with customized name is inserted in numbered tests, as

eguan@dhcp-13-216:~/workspace/src/xfstests$ git diff
diff --git a/tests/generic/group b/tests/generic/group
index 8154401..e409035 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -69,6 +69,10 @@
 064 auto quick prealloc
 065 metadata auto quick
 066 metadata auto quick
+some-test.001 other
+some-test-002 other
+some-test-003 other
+hello! other
 068 other auto freeze dangerous stress
 069 rw udf auto quick
 070 attr udf auto quick stress

I'd like to see all customized test names are at the end(or beginning)
of group file, sorted if possible.

Maybe I'm asking too much, but this is what I'd like to see :)

And the test case template in "new" can be updated too, I think, we
don't need "No." anymore

	# FS QA Test No. $id

Thanks,
Eryu
>  if [ -f $tdir/$id ]
>  then
>      echo "Error: test $id already exists!"
> -- 
> 2.1.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
