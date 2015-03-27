Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38127 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751850AbbC0Odv (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 27 Mar 2015 10:33:51 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t2REXopZ008801
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Fri, 27 Mar 2015 10:33:50 -0400
Date: Fri, 27 Mar 2015 22:33:46 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v9] fstests: Tests can use any name now, not 3 digits
 only.
Message-ID: <20150327143346.GK4810@dhcp-13-216.nay.redhat.com>
References: <20150327072539.GB4810@dhcp-13-216.nay.redhat.com>
 <1427456966-21130-1-git-send-email-jtulak@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1427456966-21130-1-git-send-email-jtulak@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Jan =?utf-8?B?xaR1bMOhaw==?= <jtulak@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Mar 27, 2015 at 12:49:26PM +0100, Jan Ťulák wrote:
> Tests can use any name now, not 3 digits only.
> (e.g. a test can be named "tests/generic/001-some-name")
> 
> Names are limited to alphanumeric characters and dash and are always prefixed
> with an unique id for easier identification of a specific test.
> 
> Signed-off-by: Jan Ťulák <jtulak@redhat.com>

Reviewed-by: Eryu Guan <eguan@redhat.com>

Thanks!

> ---
>  Just a small fix in comment to reflect $SUPPORTED_TESTS is in common/rc.
> 
>  README    |  7 ++++++-
>  check     |  9 ++++-----
>  common/rc |  1 +
>  new       | 53 ++++++++++++++++++++++++++++++++++++++++++++++++-----
>  4 files changed, 59 insertions(+), 11 deletions(-)
> 
> diff --git a/README b/README
> index 0c9449a..1841052 100644
> --- a/README
> +++ b/README
> @@ -202,10 +202,15 @@ Test script environment:
>  	- When calling getfacl in a test, pass the "-n" argument so
>  	  that numeric rather than symbolic identifiers are used in
>  	  the output.
> +	- When creating a new test, it is possible to enter a custom name
> +	  for the file. Filenames are in form NNN-custom-name, where NNN
> +	  is automatically added by the ./new script as an unique ID,
> +	  and "custom-name" is the optional string entered into a prompt
> +	  in the ./new script. Note the "NNN-" part is added automatically.
>  
>  Verified output:
>  
> -    Each test script has a numerical name, e.g. 007, and an associated
> +    Each test script has a name, e.g. 007, and an associated
>      verified output, e.g. 007.out.
>  
>      It is important that the verified output is deterministic, and
> diff --git a/check b/check
> index 0830e0c..df9a5be 100755
> --- a/check
> +++ b/check
> @@ -58,7 +58,6 @@ then
>      exit 1
>  fi
>  
> -SUPPORTED_TESTS="[0-9][0-9][0-9] [0-9][0-9][0-9][0-9]"
>  SRC_GROUPS="generic shared"
>  export SRC_DIR="tests"
>  
> @@ -96,21 +95,21 @@ get_group_list()
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
> +# It matches test names against $SUPPORTED_TESTS defined in common/rc
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
> diff --git a/common/rc b/common/rc
> index 857308a..cc9a894 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -21,6 +21,7 @@
>  #-----------------------------------------------------------------------
>  
>  BC=$(which bc 2> /dev/null) || BC=
> +SUPPORTED_TESTS="[a-zA-Z0-9-]\+"
>  
>  _require_math()
>  {
> diff --git a/new b/new
> index d1f8939..7e9ce2c 100755
> --- a/new
> +++ b/new
> @@ -81,11 +81,14 @@ line=0
>  eof=1
>  [ -f "$tdir/group" ] || usage
>  
> -for found in `cat $tdir/group | $AWK_PROG '{ print $1 }'`
> +for found in `cat $tdir/group | tr - ' ' | $AWK_PROG '{ print $1 }'`
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
> @@ -100,7 +103,47 @@ if [ $eof -eq 1 ]; then
>     id=`printf "%03d" $i`
>  fi
>  
> -echo "Next test is $id"
> +echo "Next test id is $id"
> +
> +read -p "Append a name to the ID? Test name will be $id-\$name. y,[n]: " -r
> +if [[ $REPLY = [Yy] ]]; then
> +	# get the new name from user
> +	name=""
> +	while [ "$name" = "" ]; do
> +		read -p "Enter the name: "
> +		if [ "$REPLY" = "" ]; then
> +			echo "For canceling, use ctrl+c."
> +		elif [ -e "$tdir/$id-$REPLY" ]; then
> +			echo "File '$id-$REPLY' already exists, use another one."
> +			echo #
> +		elif echo "$REPLY" | grep -q "^$SUPPORTED_TESTS$"; then
> +			name="$REPLY"
> +		else
> +			echo "Filename must contain only alphanumeric symbols and dash!"
> +			echo "(Used regex: ^$SUPPORTED_TESTS$)"
> +			echo
> +		fi
> +	done
> +
> +	# now find where to insert this name
> +	eof=1
> +	for found in `tail -n +$line $tdir/group | $AWK_PROG '{ print $1 }'`; do
> +		found_id=$(echo "$found" | tr - ' ' | $AWK_PROG '{ print $1 }')
> +		line=$((line+1))
> +		if [ -z "$found" ] || [ "$found" == "#" ]; then
> +			continue
> +		elif [[ $found > $name ]] || [ $found_id -gt $id ]; then
> +			eof=0
> +			break
> +		fi
> +	done
> +	if [ $eof -eq 0 ]; then
> +		# If place wasn't found, let $line be the end of the file
> +		line=$((line-1))
> +	fi
> +	id="$id-$name"
> +fi
> +echo "Creating test file '$id'"
>  
>  if [ -f $tdir/$id ]
>  then
> @@ -115,7 +158,7 @@ year=`date +%Y`
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
