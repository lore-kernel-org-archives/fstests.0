Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:42312 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030AbbDAMJh convert rfc822-to-8bit (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 1 Apr 2015 08:09:37 -0400
Date: Wed, 1 Apr 2015 08:09:34 -0400 (EDT)
From: Jan Tulak <jtulak@redhat.com>
Message-ID: <1003463620.6015995.1427890174467.JavaMail.zimbra@redhat.com>
In-Reply-To: <20150401043542.GD8465@dastard>
References: <20150327072539.GB4810@dhcp-13-216.nay.redhat.com> <1427456966-21130-1-git-send-email-jtulak@redhat.com> <20150401043542.GD8465@dastard>
Subject: Re: [PATCH v9] fstests: Tests can use any name now, not 3 digits
 only.
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, eguan@redhat.com
List-ID: <fstests@vger.kernel.org>



----- Original Message -----
> From: "Dave Chinner" <david@fromorbit.com>
> To: "Jan Ťulák" <jtulak@redhat.com>
> Cc: fstests@vger.kernel.org, eguan@redhat.com
> Sent: Wednesday, 1 April, 2015 6:35:42 AM
> Subject: Re: [PATCH v9] fstests: Tests can use any name now, not 3 digits only.
> 
> On Fri, Mar 27, 2015 at 12:49:26PM +0100, Jan Ťulák wrote:
> > Tests can use any name now, not 3 digits only.
> > (e.g. a test can be named "tests/generic/001-some-name")
> > 
> > Names are limited to alphanumeric characters and dash and are always
> > prefixed
> > with an unique id for easier identification of a specific test.
> > 
> > Signed-off-by: Jan Ťulák <jtulak@redhat.com>
> > ---
> >  Just a small fix in comment to reflect $SUPPORTED_TESTS is in common/rc.
> 
> Which I have a couple of nits about, seeing we've settled on an
> acceptible convention. :)
> 
> > 
> >  README    |  7 ++++++-
> >  check     |  9 ++++-----
> >  common/rc |  1 +
> >  new       | 53 ++++++++++++++++++++++++++++++++++++++++++++++++-----
> >  4 files changed, 59 insertions(+), 11 deletions(-)
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
> 
> We have a defined format for the test names, yet it does not have
> the clear explanation of what constitutes a valid name i.e. from an
> error message below:
> 
> > +	echo "Filename must contain only alphanumeric symbols and dash!"

Thanks, I'm adding a note into the readme.

> 
> If we have a defined format for the test names, we should enforce
> it strictly and code directly to it. The description here needs to
> spell this out directly.
> 
> > @@ -96,21 +95,21 @@ get_group_list()
> >  		l=$(sed -n < $SRC_DIR/$d/group \
> >  			-e 's/#.*//' \
> >  			-e 's/$/ /' \
> > -			-e "s;\(^[0-9][0-9][0-9]\).* $grp .*;$SRC_DIR/$d/\1;p")
> > +			-e "s;^\($SUPPORTED_TESTS\).* $grp .*;$SRC_DIR/$d/\1;p")
> 
> Here we filter by $SUPPORTED_TESTS for valid tests, but....
> 
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -21,6 +21,7 @@
> >  #-----------------------------------------------------------------------
> >  
> >  BC=$(which bc 2> /dev/null) || BC=
> > +SUPPORTED_TESTS="[a-zA-Z0-9-]\+"
> 
> but $SUPPORTED_TESTS doesn't define the correct format for the test
> names. It defines valid characters, but does not enforce the fact
> that the first 3 characters must match [0-9] (i.e. the NNN bit), and
> then the rest is optional but must be alphanumeric symbols and dash.
> i.e it should be matching against:
> 

I did it to be "generous on input, strict on output" - the ./new script always put 3 numbers at the beginning, but if someone for some reason needs to avoid it, it will still work. Enforcing it is easy, but is it needed?


> # Valid test names start with 3 digits "NNN":
> #  "[0-9]\{3\}"
> # followed by an optional "-":
> #  "-\?"
> # followed by an optional combination of alphanumeric and "-" chars:
> #  "[[:alnum:]-]*"
> # e.g. 999-the-mark-of-fstests
> #
> VALID_TEST_NAME="[0-9]\{3\}-\?[[:alnum:]-]*"
> 
> >  _require_math()
> >  {
> > diff --git a/new b/new
> > index d1f8939..7e9ce2c 100755
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
> 
> This should check for "$VALID_TEST_NAME$", too, as it will match
> [0-9]{3}$ test names just fine.
> 
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
> > +read -p "Append a name to the ID? Test name will be $id-\$name. y,[n]: "
> > -r
> > +if [[ $REPLY = [Yy] ]]; then
> > +	# get the new name from user
> > +	name=""
> > +	while [ "$name" = "" ]; do
> > +		read -p "Enter the name: "
> > +		if [ "$REPLY" = "" ]; then
> > +			echo "For canceling, use ctrl+c."
> > +		elif [ -e "$tdir/$id-$REPLY" ]; then
> > +			echo "File '$id-$REPLY' already exists, use another one."
> > +			echo #
> 
> This check should happen *after* input validation, though it should
> never be true because we have selected a unique, unused $id....

This check can be true - ID check is done in a group file, it does not reflects existence of files with such ID and name. So if you for example interrupt the ./new script after creating the file, but before editing groups, the file can exist without an entry in groups and the ID is used again.

I agree with validating the input first.

> 
> > +		elif echo "$REPLY" | grep -q "^$SUPPORTED_TESTS$"; then
> > +			name="$REPLY"
> 
> i.e. this should be first, and given that we have a well defined
> input validation, we should make that as clear as possible. e.g.
> 
> 		elif echo $REPLY | grep -q "^[[:alnum:]-]$"; then
> 

You mean to put the regex directly into the condition? I prefer to keep in the variable defined in common/rc. 

> > +		else
> > +			echo "Filename must contain only alphanumeric symbols and dash!"
> > +			echo "(Used regex: ^$SUPPORTED_TESTS$)"
> 
> Don't confuse the poor users with a regex - make it clear what the
> format is in the documentation.
>

Well, I think any user who will write tests for a filesystem knows what regex is. ;-)
But I take the point, removed.


> 
> > +			echo
> > +		fi
> > +	done
> > +
> > +	# now find where to insert this name
> > +	eof=1
> > +	for found in `tail -n +$line $tdir/group | $AWK_PROG '{ print $1 }'`; do
> > +		found_id=$(echo "$found" | tr - ' ' | $AWK_PROG '{ print $1 }')
> 
> That's an interesting way of cutting up a string.
> 
> 		found_id=$(echo "$found" | cut -d "-" -f 1 -)

:-)

> 
> > +		line=$((line+1))
> > +		if [ -z "$found" ] || [ "$found" == "#" ]; then
> > +			continue
> > +		elif [[ $found > $name ]] || [ $found_id -gt $id ]; then
> 
> This doesn't work. $found will be "298-I-want-a-spoon" or just
> "298", but $name has no number prefix i.e. "but-I-like-sporks". We
> will always have number prefixes, and tests should always have unique
> numbers, so there is no reason to check anything but $id against
> $found_id.  Which means:
> 
> 	for found_id in `tail -n +$line $tdir/group | cut -d "-" -f 1" -`; do
> 		line=$((line+1))
> 		if [ -z "$found" ] || [ "$found" == "#" ]; then
> 			continue
> 		elif [ $found_id -gt $id ]; then
> 			eof=0
> 			break
> 		fi
> 	done
> 

I see. Most probably, it is a relict from before unique IDs. 
Fixed, thank you.

Jan


> And once we've done all this and decided on a test name, we should
> finally validate it again against $VALID_TEST_NAME....
> 
> Cheers,
> 
> Dave.
> 
> 
> 
> --
> Dave Chinner
> david@fromorbit.com
> 
