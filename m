Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33890 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754051AbbCYRJk (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 25 Mar 2015 13:09:40 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id 6F7EC8E6E6
	for <fstests@vger.kernel.org>; Wed, 25 Mar 2015 17:09:40 +0000 (UTC)
Date: Thu, 26 Mar 2015 01:09:38 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] fstests: Tests can use any name now, not 3 digits only.
Message-ID: <20150325170938.GX4810@dhcp-13-216.nay.redhat.com>
References: <20150321131159.GA4810@dhcp-13-216.nay.redhat.com>
 <1427290055-32647-1-git-send-email-jtulak@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1427290055-32647-1-git-send-email-jtulak@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Jan =?utf-8?B?xaR1bMOhaw==?= <jtulak@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Mar 25, 2015 at 02:27:35PM +0100, Jan Ťulák wrote:
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
> -# find all tests, excluding files that are test metadata such as group files.
> -# This assumes that tests are defined purely by alphanumeric filenames with no
> -# ".xyz" extensions in the name.
> +# Find all tests, excluding files that are test metadata such as group files.
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

seems basic regular expression of grep doesn't support \s, I entered
"some-test-001" as test name and it always tells me it's containing
whitespace/dot.

I changed the regex to [:space:] (found in grep manpage) and it works.

	elif echo "$REPLY" | grep -q "^[^[:space:].]\+$"; then

If so, you may want to double check SUPPORTED_TESTS, as it's used by
grep in function get_all_tests()

I found tests are not properly found by group. e.g. I added three new
tests called "001-hello-test" "a-first-test" "some-test-001", and added
them to "testgroup", but ./check -n -g testgroup listed wrong test names
(the names are truncated and didn't find some-test-001)

[root@hp-dl388eg8-01 xfstests]# ./check -n -g testgroup
FSTYP         -- xfs (non-debug)
PLATFORM      -- Linux/x86_64 hp-dl388eg8-01 4.0.0-rc4+
MKFS_OPTIONS  -- -f -bsize=4096 /dev/mapper/rhel_hp--dl388eg8--01-testlv2
MOUNT_OPTIONS -- -o context=system_u:object_r:nfs_t:s0 /dev/mapper/rhel_hp--dl388eg8--01-testlv2 /mnt/testarea/scratch

generic/001-hello-te
generic/a-fir

This is the diff of my generic/group file

diff --git a/tests/generic/group b/tests/generic/group
index b2f0680..49a8eed 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -4,6 +4,7 @@
 # - comment line before each group is "new" description
 #
 001 rw dir udf auto quick
+001-hello-test other testgroup
 002 metadata udf auto quick
 003 atime auto quick
 004 auto quick
@@ -74,6 +75,8 @@
 069 rw udf auto quick
 070 attr udf auto quick stress
 071 auto quick prealloc
+072 other
+073 other
 074 rw udf auto
 075 rw udf auto quick
 076 metadata rw udf auto quick stress
@@ -184,3 +187,6 @@
 323 auto aio stress
 324 auto fsr quick
 325 auto quick data log
+a-first-test other testgroup
+hello-world-002 other
+some-test-001 other testgroup

> +        else
> +            echo "Filename must not contain whitespaces and dots!"
> +            echo 

trailing whitespace in above line

> +        fi
> +    done
> +
> +    # now find where to insert this name
> +    eof=1
> +    line=0
> +    for found in `cat $tdir/group | $AWK_PROG '{ print $1 }'`
> +    do

this for loop has different code style, use

	for xxx; do
	done

too, as other places you write

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

As above is a new code block(about reading in test name and finding the
right place to insert the new test), you can use tab to indent, not 4
spaces.

Thanks for your work!

Eryu
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
