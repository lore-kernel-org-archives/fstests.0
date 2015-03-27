Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60795 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753341AbbC0HZo (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 27 Mar 2015 03:25:44 -0400
Date: Fri, 27 Mar 2015 15:25:39 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v6] fstests: Tests can use any name now, not 3 digits
 only.
Message-ID: <20150327072539.GB4810@dhcp-13-216.nay.redhat.com>
References: <20150321131159.GA4810@dhcp-13-216.nay.redhat.com>
 <1427383991-14789-1-git-send-email-jtulak@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1427383991-14789-1-git-send-email-jtulak@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Jan =?utf-8?B?xaR1bMOhaw==?= <jtulak@redhat.com>
Cc: fstests@vger.kernel.org, lczerner@redhat.com, dsterba@suse.cz
List-ID: <fstests@vger.kernel.org>

On Thu, Mar 26, 2015 at 04:33:11PM +0100, Jan Ťulák wrote:
> Tests can use any name now, not 3 digits only.
> (e.g. a test can be named "tests/generic/001-some-name")
> 
> Names are limited to alphanumeric characters and dash and are always prefixed
> with an unique id for easier identification of a specific test.
> 
> Signed-off-by: Jan Ťulák <jtulak@redhat.com>
> ---

Besides the version number in summary, it's better to put changelog
under the "---", so it's clear what has been changed from last version

>  README |  7 ++++++-
>  check  | 11 ++++++-----
>  new    | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++------
>  3 files changed, 65 insertions(+), 12 deletions(-)
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
> index 0830e0c..2730284 100755
> --- a/check
> +++ b/check
> @@ -58,7 +58,7 @@ then
>      exit 1
>  fi
>  
> -SUPPORTED_TESTS="[0-9][0-9][0-9] [0-9][0-9][0-9][0-9]"
> +SUPPORTED_TESTS="[a-zA-Z0-9-]\+"

I see this is used in both check and new, is it possible to put it in
common/rc, then define it once there?

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
> index d1f8939..4ff71d3 100755
> --- a/new
> +++ b/new
> @@ -25,6 +25,9 @@
>  iam=new
>  . ./common/rc
>  
> +SUPPORTED_TESTS="^[a-zA-Z0-9-]\+$"
> +
> +
>  trap "rm -f /tmp/$$.; exit" 0 1 2 3 15
>  
>  _cleanup()
> @@ -81,11 +84,14 @@ line=0
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
> @@ -99,8 +105,49 @@ if [ $eof -eq 1 ]; then
>     i=$((i+1))
>     id=`printf "%03d" $i`
>  fi
> -
> -echo "Next test is $id"
> +auto_id=$id

Seems auto_id is not used anywhere.

> +
> +echo "Next test id is $id"
> +
> +read -p "Do you want to give a name to the test? y,[n]: " -r
> +if [[ $REPLY = [Yy] ]]; then
> +	# get the new name from user
> +	name=""
> +	while [ "$name" = "" ]; do
> +		read -p "Enter the new name: "

This prompt is kind of misleading now, because it's appending test name
to the current id.

> +		if [ "$REPLY" = "" ]; then
> +			echo "For canceling, use ctrl+c."
> +		elif [ -e "$tdir/$REPLY" ]; then

test "$tdir/$id-$REPLY"?

> +			echo "File '$REPLY' already exists, use another one."
> +			echo #
> +		elif echo "$REPLY" | grep -q "$SUPPORTED_TESTS"; then
> +			name="$REPLY"
> +		else
> +			echo "Filename must contain only alphanumeric symbols and dash!"
> +			echo "(Used regex: $SUPPORTED_TESTS)"
> +			echo
> +		fi
> +	done
> +
> +	# now find where to insert this name
> +	eof=1
> +	for found in `tail -n +$line $tdir/group | $AWK_PROG '{ print $1 }'`; do
> +		foundId=$(echo "$found" | tr - ' ' | $AWK_PROG '{ print $1 }')

foundid? there's no other var name in camel-case style

> +		line=$((line+1))
> +		if [ -z "$found" ] || [ "$found" == "#" ]; then
> +			continue
> +		elif [[ $found > $name ]] || (( 10#$foundId > 10#$id )); then

(( 10#$foundId > 10#$id )) part is tricky, I have to lookup the bash
manpage to understand it :)

10 is the default base, the "10#" part can be omitted.

But I think simple [ $foundId -gt $id ] is better, and David Sterba is
OK with it too now (in another reply) :-)


Thank you so much for continuous improvements!

Eryu
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
> @@ -115,7 +162,7 @@ year=`date +%Y`
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
