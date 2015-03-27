Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:57030 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932104AbbC0JsZ convert rfc822-to-8bit (ORCPT
	<rfc822;fstests@vger.kernel.org>); Fri, 27 Mar 2015 05:48:25 -0400
Date: Fri, 27 Mar 2015 05:48:23 -0400 (EDT)
From: Jan Tulak <jtulak@redhat.com>
Message-ID: <1503828376.3632362.1427449703440.JavaMail.zimbra@redhat.com>
In-Reply-To: <20150327093940.GG4810@dhcp-13-216.nay.redhat.com>
References: <20150327072539.GB4810@dhcp-13-216.nay.redhat.com> <1427447748-14598-1-git-send-email-jtulak@redhat.com> <20150327093940.GG4810@dhcp-13-216.nay.redhat.com>
Subject: Re: [PATCH v7] fstests: Tests can use any name now, not 3 digits
 only.
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org, lczerner@redhat.com, dsterba@suse.cz
List-ID: <fstests@vger.kernel.org>



----- Original Message -----
> From: "Eryu Guan" <eguan@redhat.com>
> To: "Jan Ťulák" <jtulak@redhat.com>
> Cc: fstests@vger.kernel.org, lczerner@redhat.com, dsterba@suse.cz
> Sent: Friday, 27 March, 2015 10:39:40 AM
> Subject: Re: [PATCH v7] fstests: Tests can use any name now, not 3 digits only.
> 
> On Fri, Mar 27, 2015 at 10:15:48AM +0100, Jan Ťulák wrote:
> > Tests can use any name now, not 3 digits only.
> > (e.g. a test can be named "tests/generic/001-some-name")
> > 
> > Names are limited to alphanumeric characters and dash and are always
> > prefixed
> > with an unique id for easier identification of a specific test.
> > 
> > Signed-off-by: Jan Ťulák <jtulak@redhat.com>
> > ---
> > 
> >  Changes in this patch version:
> > 
> >  SUPPORTED_TESTS regex moved into common/rc
> >  removed unused variable auto_id
> >  prompt for name changed to be less confusing
> >  fixed test for existing file
> >  foundId -> found_id
> >  (( expression )) -> [ expression ]
> > 
> > 
> >  README    |  7 ++++++-
> >  check     | 10 +++++-----
> >  common/rc |  1 +
> >  new       | 53 ++++++++++++++++++++++++++++++++++++++++++++++++-----
> >  4 files changed, 60 insertions(+), 11 deletions(-)
> > 
> > diff --git a/README b/README
> > index 0c9449a..1841052 100644
> > --- a/README
> > +++ b/README
> > @@ -202,10 +202,15 @@ Test script environment:
> >  	- When calling getfacl in a test, pass the "-n" argument so
> >  	  that numeric rather than symbolic identifiers are used in
> >  	  the output.
> > +	- When creating a new test, it is possible to enter a custom name
> > +	  for the file. Filenames are in form NNN-custom-name, where NNN
> > +	  is automatically added by the ./new script as an unique ID,
> > +	  and "custom-name" is the optional string entered into a prompt
> > +	  in the ./new script. Note the "NNN-" part is added automatically.
> >  
> >  Verified output:
> >  
> > -    Each test script has a numerical name, e.g. 007, and an associated
> > +    Each test script has a name, e.g. 007, and an associated
> >      verified output, e.g. 007.out.
> >  
> >      It is important that the verified output is deterministic, and
> > diff --git a/check b/check
> > index 0830e0c..b905259 100755
> > --- a/check
> > +++ b/check
> > @@ -58,7 +58,6 @@ then
> >      exit 1
> >  fi
> >  
> > -SUPPORTED_TESTS="[0-9][0-9][0-9] [0-9][0-9][0-9][0-9]"
> >  SRC_GROUPS="generic shared"
> >  export SRC_DIR="tests"
> >  
> > @@ -96,21 +95,22 @@ get_group_list()
> >  		l=$(sed -n < $SRC_DIR/$d/group \
> >  			-e 's/#.*//' \
> >  			-e 's/$/ /' \
> > -			-e "s;\(^[0-9][0-9][0-9]\).* $grp .*;$SRC_DIR/$d/\1;p")
> > +			-e "s;^\($SUPPORTED_TESTS\).* $grp .*;$SRC_DIR/$d/\1;p")
> >  		grpl="$grpl $l"
> >  	done
> >  	echo $grpl
> >  }
> >  
> > -# find all tests, excluding files that are test metadata such as group
> > files.
> > -# This assumes that tests are defined purely by alphanumeric filenames
> > with no
> > -# ".xyz" extensions in the name.
> > +# Find all tests, excluding files that are test metadata such as group
> > files.
> > +# It matches test names against $SUPPORTED_TESTS defined at the top of
> > this
> > +# file.
> >  get_all_tests()
> >  {
> >  	touch $tmp.list
> >  	for d in $SRC_GROUPS $FSTYP; do
> >  		ls $SRC_DIR/$d/* | \
> >  			grep -v "\..*" | \
> > +			grep "^$SRC_DIR/$d/$SUPPORTED_TESTS"| \
> >  			grep -v "group\|Makefile" >> $tmp.list 2>/dev/null
> >  	done
> >  }
> > diff --git a/common/rc b/common/rc
> > index 857308a..cc9a894 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -21,6 +21,7 @@
> >  #-----------------------------------------------------------------------
> >  
> >  BC=$(which bc 2> /dev/null) || BC=
> > +SUPPORTED_TESTS="[a-zA-Z0-9-]\+"
> >  
> >  _require_math()
> >  {
> > diff --git a/new b/new
> > index d1f8939..4257e00 100755
> > --- a/new
> > +++ b/new
> > @@ -81,11 +81,14 @@ line=0
> >  eof=1
> >  [ -f "$tdir/group" ] || usage
> >  
> > -for found in `cat $tdir/group | $AWK_PROG '{ print $1 }'`
> > +for found in `cat $tdir/group | tr - ' ' | $AWK_PROG '{ print $1 }'`
> >  do
> >      line=$((line+1))
> > -    if [ -z "$found" ] || [ "$found" == "#" ];then
> > -	continue
> > +    if [ -z "$found" ] || [ "$found" == "#" ]; then
> > +        continue
> > +    elif ! echo "$found" | grep -q "^[0-9][0-9][0-9]$"; then
> > +        # this one is for tests not named by a number
> > +        continue
> >      fi
> >      i=$((i+1))
> >      id=`printf "%03d" $i`
> > @@ -100,7 +103,47 @@ if [ $eof -eq 1 ]; then
> >     id=`printf "%03d" $i`
> >  fi
> >  
> > -echo "Next test is $id"
> > +echo "Next test id is $id"
> > +
> > +read -p "Do you want to append a name to the ID? y,[n]: " -r
> > +if [[ $REPLY = [Yy] ]]; then
> > +	# get the new name from user
> > +	name=""
> > +	while [ "$name" = "" ]; do
> > +		read -p "Enter the new name: "
> 
> "new name" here still seems confusing to me. Otherwise look good to me.
> 
> Reviewed-by: Eryu Guan <eguan@redhat.com>
> 
> Thank you!
> 
> Eryu

So perhaps just remove the "new" and leave only the "name"?
Should I send one more patch for it?

Jan

> > +		if [ "$REPLY" = "" ]; then
> > +			echo "For canceling, use ctrl+c."
> > +		elif [ -e "$tdir/$id-$REPLY" ]; then
> > +			echo "File '$id-$REPLY' already exists, use another one."
> > +			echo #
> > +		elif echo "$REPLY" | grep -q "^$SUPPORTED_TESTS$"; then
> > +			name="$REPLY"
> > +		else
> > +			echo "Filename must contain only alphanumeric symbols and dash!"
> > +			echo "(Used regex: ^$SUPPORTED_TESTS$)"
> > +			echo
> > +		fi
> > +	done
> > +
> > +	# now find where to insert this name
> > +	eof=1
> > +	for found in `tail -n +$line $tdir/group | $AWK_PROG '{ print $1 }'`; do
> > +		found_id=$(echo "$found" | tr - ' ' | $AWK_PROG '{ print $1 }')
> > +		line=$((line+1))
> > +		if [ -z "$found" ] || [ "$found" == "#" ]; then
> > +			continue
> > +		elif [[ $found > $name ]] || [ $found_id -gt $id ]; then
> > +			eof=0
> > +			break
> > +		fi
> > +	done
> > +	if [ $eof -eq 0 ]; then
> > +		# If place wasn't found, let $line be the end of the file
> > +		line=$((line-1))
> > +	fi
> > +	id="$id-$name"
> > +fi
> > +echo "Creating test file '$id'"
> >  
> >  if [ -f $tdir/$id ]
> >  then
> > @@ -115,7 +158,7 @@ year=`date +%Y`
> >  
> >  cat <<End-of-File >$tdir/$id
> >  #! /bin/bash
> > -# FS QA Test No. $id
> > +# FS QA Test $id
> >  #
> >  # what am I here for?
> >  #
> > --
> > 2.1.0
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
