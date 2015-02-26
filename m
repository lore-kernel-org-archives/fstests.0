Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59982 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932124AbbBZNgg (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 26 Feb 2015 08:36:36 -0500
Date: Thu, 26 Feb 2015 14:36:28 +0100 (CET)
From: =?ISO-8859-15?Q?Luk=E1=A8_Czerner?= <lczerner@redhat.com>
Subject: RE: [PATCH v3 2/2] Fix warning of "Usage: _is_block_dev dev"
In-Reply-To: <00c501d051bf$7a6c84c0$6f458e40$@cn.fujitsu.com>
Message-ID: <alpine.LFD.2.00.1502261430120.25704@localhost.localdomain>
References: <196cc72cb39e1a338339fa09c73f6334af63a2d6.1424946979.git.zhaolei@cn.fujitsu.com> <477b0e94819bea20d920822f0b88099ce19532a8.1424946979.git.zhaolei@cn.fujitsu.com> <alpine.LFD.2.00.1502261223250.25704@localhost.localdomain>
 <00c501d051bf$7a6c84c0$6f458e40$@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-319515863-1424957791=:25704"
Sender: fstests-owner@vger.kernel.org
To: Zhao Lei <zhaolei@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-319515863-1424957791=:25704
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 26 Feb 2015, Zhao Lei wrote:

> Date: Thu, 26 Feb 2015 20:26:42 +0800
> From: Zhao Lei <zhaolei@cn.fujitsu.com>
> To: 'Lukáš Czerner' <lczerner@redhat.com>
> Cc: fstests@vger.kernel.org
> Subject: RE: [PATCH v3 2/2] Fix warning of "Usage: _is_block_dev dev"
> 
> Hi, Lukas
> 
> Thanks for review.
> 
> * From: Lukáš Czerner [mailto:lczerner@redhat.com]
> > Sent: Thursday, February 26, 2015 7:30 PM
> > To: Zhaolei
> > Cc: fstests@vger.kernel.org
> > Subject: Re: [PATCH v3 2/2] Fix warning of "Usage: _is_block_dev dev"
> > 
> > On Thu, 26 Feb 2015, Zhaolei wrote:
> > 
> > > Date: Thu, 26 Feb 2015 18:38:59 +0800
> > > From: Zhaolei <zhaolei@cn.fujitsu.com>
> > > To: fstests@vger.kernel.org
> > > Cc: Zhao Lei <zhaolei@cn.fujitsu.com>
> > > Subject: [PATCH v3 2/2] Fix warning of "Usage: _is_block_dev dev"
> > >
> > > From: Zhao Lei <zhaolei@cn.fujitsu.com>
> > >
> > > _is_block_dev() will show above warning when "$dev" is not exist.
> > > It happened when the program check $TEST_DEV with blank $SCRATCH_DEV
> > > which is optional.
> > >
> > > Changelog v2->v3:
> > >  Separate __same_block_dev() from _is_block_dev() to make code  self
> > > documenting.
> > >  Suggested by: Dave Chinner <david@fromorbit.com>
> > >
> > > Changelog v1->v2:
> > >  Rewrite _is_block_dev() to make caller code simple.
> > >  Suggested by: Dave Chinner <david@fromorbit.com>
> > 
> > This is all very confusing. Sometimes you consider links, sometimes you do not.
> 
> I always consider symbol links.
> 
> [-b ...] in _is_block_dev() can work well even if "$1" is link, so we need not call
> use readlink before.
> 
> But "stat" command in __same_block_dev() will not return block id if "$1" is link,
> so we need convert it using readlink.
> 
> > Error messages are missing completely _is_block_dev() does not return device
> > numbers anymore which might be useful.
> > 
> In current code, device number is only used to compare is same device,
> and function named _is_same_device() seems more suitable.
> 
> And if we really need to get dev_id in future, maybe add a function
> named _get_dev_id() that time can make code more readable.
> 
> > What about just using the original _is_block_dev() as it was intended ? Like
> > this:
> > 
> > 	if [ "`_is_block_dev "$SCRATCH_DEV"`" = "`_is_block_dev "$TEST_DEV"`" ]
> > 
> > Simply use quotes around the function argument so that the function always
> > receives an argument even though it might be empty, but in this case you'll not
> > get the error message and the _is_block_dev() will just return nothing -
> > problem solved ?
> > 
> This way can solve titled problem, this patch changed more code because most
> of them are restructure around discussion with patch v1.

But it still seems to me that using proper quoting fixes the problem
without rewriting bunch of code unnecessarily. I've read the
discussion and I think you're talking about:

"is_block_dev() is used in many places to check whether the block
device exists.  i.e. I'd suggest that _is_block_dev() should return
an empty string to indicate it's not a block device rather than exit
if a null."

But the function already works this way, you just need to make sure
that the argument is passed to the function even if that argument is
empty - so you need to use quotes like _is_block_dev "$TEST_DEV".
Its the unfortunate way bash works.

Simply said

_is_block_dev "$TEST_DEV"

will return empty string if $TEST_DEV either does not exist or
$TEST_DEV itself is empty string. However if someone calls

_is_block_dev

he'll get an error so he knows that he needs to fix his code.

-Lukas
Thanks!

> 
> Thanks
> Zhaolei
> 
> > -Lukas
> > 
> > 
> > >
> > > Signed-off-by: Zhao Lei <zhaolei@cn.fujitsu.com>
> > > ---
> > >  common/rc | 101
> > > +++++++++++++++++++++++++++++++++++++-------------------------
> > >  1 file changed, 61 insertions(+), 40 deletions(-)
> > >
> > > diff --git a/common/rc b/common/rc
> > > index 5a8c74d..f528c25 100644
> > > --- a/common/rc
> > > +++ b/common/rc
> > > @@ -945,24 +945,51 @@ _fs_options()
> > >      ' </proc/mounts
> > >  }
> > >
> > > -# returns device number if a file is a block device
> > > +# Returns:
> > > +# 0: if filename is a block device
> > > +# 1: if filename is not a block device # -1 if argument wrong
> > >  #
> > >  _is_block_dev()
> > >  {
> > > -    if [ $# -ne 1 ]
> > > -    then
> > > -	echo "Usage: _is_block_dev dev" 1>&2
> > > -	exit 1
> > > -    fi
> > > +	if [ $# -ne 1 ]; then
> > > +		return -1
> > > +	fi
> > > +	if [ -b "$1" ]; then
> > > +		return 0
> > > +	fi
> > > +	return 1;
> > > +}
> > >
> > > -    _dev=$1
> > > -    if [ -L "${_dev}" ]; then
> > > -        _dev=`readlink -f ${_dev}`
> > > -    fi
> > > +# Returns:
> > > +# 0: if the devices are same
> > > +# 1: if the devices are not same
> > > +#
> > > +__same_block_dev()
> > > +{
> > > +	if [ $# -ne 2 ]; then
> > > +		return 1
> > > +	fi
> > >
> > > -    if [ -b "${_dev}" ]; then
> > > -        src/lstat64 ${_dev} | $AWK_PROG '/Device type:/ { print $9 }'
> > > -    fi
> > > +	_dev1="$1"
> > > +	_dev2="$2"
> > > +
> > > +	if [ ! -b "$_dev1" -o ! -b "$_dev2" ]; then
> > > +		return 1
> > > +	fi
> > > +
> > > +	if [ -L "${_dev1}" ]; then
> > > +		_dev1=`readlink -f "$_dev1"`
> > > +	fi
> > > +	if [ -L "${_dev2}" ]; then
> > > +		_dev2=`readlink -f "$_dev2"`
> > > +	fi
> > > +
> > > +	if [ `stat -c %t,%T "$_dev1"` != `stat -c %t,%T "$_dev2"` ]; then
> > > +		return 1
> > > +	fi
> > > +
> > > +	return 0;
> > >  }
> > >
> > >  # Do a command, log it to $seqres.full, optionally test return status
> > > @@ -1095,19 +1122,16 @@ _require_scratch_nocheck()
> > >  		fi
> > >  		;;
> > >  	*)
> > > -		 if [ -z "$SCRATCH_DEV" -o "`_is_block_dev $SCRATCH_DEV`" = "" ]
> > > -		 then
> > > -		     _notrun "this test requires a valid \$SCRATCH_DEV"
> > > -		 fi
> > > -		 if [ "`_is_block_dev $SCRATCH_DEV`" = "`_is_block_dev
> > $TEST_DEV`" ]
> > > -		 then
> > > -		     _notrun "this test requires a valid \$SCRATCH_DEV"
> > > -		 fi
> > > -		if [ ! -d "$SCRATCH_MNT" ]
> > > -		then
> > > -		     _notrun "this test requires a valid \$SCRATCH_MNT"
> > > +		if ! _is_block_dev "$SCRATCH_DEV"; then
> > > +			_notrun "this test requires a valid \$SCRATCH_DEV"
> > > +		fi
> > > +		if __same_block_dev "$SCRATCH_DEV" "$TEST_DEV"; then
> > > +			_notrun "\$SCRATCH_DEV and \$TEST_DEV are same device"
> > > +		fi
> > > +		if [ ! -d "$SCRATCH_MNT" ]; then
> > > +			_notrun "this test requires a valid \$SCRATCH_MNT"
> > >  		fi
> > > -		 ;;
> > > +		;;
> > >      esac
> > >
> > >      # mounted?
> > > @@ -1167,19 +1191,16 @@ _require_test()
> > >  		fi
> > >  		;;
> > >  	*)
> > > -		 if [ -z "$TEST_DEV" -o "`_is_block_dev $TEST_DEV`" = "" ]
> > > -		 then
> > > -		     _notrun "this test requires a valid \$TEST_DEV"
> > > -		 fi
> > > -		 if [ "`_is_block_dev $SCRATCH_DEV`" = "`_is_block_dev
> > $TEST_DEV`" ]
> > > -		 then
> > > -		     _notrun "this test requires a valid \$TEST_DEV"
> > > -		 fi
> > > -		if [ ! -d "$TEST_DIR" ]
> > > -		then
> > > -		     _notrun "this test requires a valid \$TEST_DIR"
> > > +		if ! _is_block_dev "$TEST_DEV"; then
> > > +			_notrun "this test requires a valid \$TEST_DEV"
> > > +		fi
> > > +		if __same_block_dev "$TEST_DEV" "$SCRATCH_DEV"; then
> > > +			_notrun "\$TEST_DEV and \$SCRATCH_DEV are same device"
> > >  		fi
> > > -		 ;;
> > > +		if [ ! -d "$TEST_DIR" ]; then
> > > +			_notrun "this test requires a valid \$TEST_DIR"
> > > +		fi
> > > +		;;
> > >      esac
> > >
> > >      # mounted?
> > > @@ -1288,7 +1309,7 @@ _require_block_device()
> > >  		echo "Usage: _require_block_device <dev>" 1>&2
> > >  		exit 1
> > >  	fi
> > > -	if [ "`_is_block_dev $1`" == "" ]; then
> > > +	if ! _is_block_dev "$1"; then
> > >  		_notrun "require $1 to be valid block disk"
> > >  	fi
> > >  }
> > > @@ -2236,10 +2257,10 @@ _require_scratch_dev_pool()
> > >  	esac
> > >
> > >  	for i in $SCRATCH_DEV_POOL; do
> > > -		if [ "`_is_block_dev $i`" = "" ]; then
> > > +		if ! _is_block_dev "$i"; then
> > >  			_notrun "this test requires valid block disk $i"
> > >  		fi
> > > -		if [ "`_is_block_dev $i`" = "`_is_block_dev $TEST_DEV`" ]; then
> > > +		if __same_block_dev "$i" "$TEST_DEV"; then
> > >  			_notrun "$i is part of TEST_DEV, this test requires unique disks"
> > >  		fi
> > >  		if _mount | grep -q $i; then
> > >
> 
> 
> 
--8323328-319515863-1424957791=:25704--
