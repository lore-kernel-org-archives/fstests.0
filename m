Return-Path: <fstests-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:18993 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752193AbbBZJbH convert rfc822-to-8bit (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 26 Feb 2015 04:31:07 -0500
From: Zhao Lei <zhaolei@cn.fujitsu.com>
References: <1424069440-14957-1-git-send-email-zhaolei@cn.fujitsu.com> <1424069440-14957-2-git-send-email-zhaolei@cn.fujitsu.com> <20150218053749.GP4251@dastard>
In-Reply-To: <20150218053749.GP4251@dastard>
Subject: RE: [PATCH 2/2] Fix warning of "Usage: _is_block_dev dev"
Date: Thu, 26 Feb 2015 17:30:55 +0800
Message-ID: <00c301d051a6$ec2df440$c489dcc0$@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Content-Language: zh-cn
Sender: fstests-owner@vger.kernel.org
To: 'Dave Chinner' <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi, Dave Chinner

> From: Dave Chinner [mailto:david@fromorbit.com]
> Subject: Re: [PATCH 2/2] Fix warning of "Usage: _is_block_dev dev"
> 
> On Mon, Feb 16, 2015 at 02:50:40PM +0800, Zhaolei wrote:
> > From: Zhao Lei <zhaolei@cn.fujitsu.com>
> >
> > _is_block_dev() will show above warning when "$dev" is not exist.
> > It happened when the program check $TEST_DEV with blank $SCRATCH_DEV
> > which is optional.
> >
> > Changelog v1->v2:
> >  Rewrite _is_block_dev() to make caller code simple.
> >  Suggested by: Dave Chinner <david@fromorbit.com>
> 
> You haven't implemented what I suggested.
> 
> > Signed-off-by: Zhao Lei <zhaolei@cn.fujitsu.com>
> > ---
> >  common/rc | 63
> > ++++++++++++++++++++++++++++++++++-----------------------------
> >  1 file changed, 34 insertions(+), 29 deletions(-)
> >
> > diff --git a/common/rc b/common/rc
> > index 76522d4..c5f6953 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -947,12 +947,11 @@ _fs_options()
> >
> >  # returns device number if a file is a block device  #
> > -_is_block_dev()
> > +_dev_type()
> >  {
> >      if [ $# -ne 1 ]
> >      then
> > -	echo "Usage: _is_block_dev dev" 1>&2
> > -	exit 1
> > +        return
> >      fi
> >
> >      _dev=$1
> 
> This will only output something if the device is a block device.
> It's not a generic function. it still only returns a major:minor device number if
> the device is a block device. Most callers do not use this value.
> 
> # Returns:
> #	-1 if no argument passed
> #	0 if filename is not a block device
> #	1 if filename is a block device.
> _is_block_dev()
> {
> 	if [ $# -ne 1 ]; then
> 		return -1;
> 	fi
> 
> 	if [ -b $1 ]; then
> 		return 1;
> 	fi
> 	return 0;
> }
> 
> 
> > @@ -965,6 +964,25 @@ _is_block_dev()
> >      fi
> >  }
> >
> > +_is_block_dev()
> > +{
> > +    _dev_type=`_dev_type "$1"`
> > +    if [ -z "$_dev_type" ]; then
> > +	return 1
> > +    fi
> > +
> > +    _not_same_dev_type=`_dev_type "$2"`
> > +    if [ -z "$_not_same_dev_type" ]; then
> > +	return 0
> > +    fi
> > +
> > +    if [ "$_dev_type" = "$_not_same_dev_type" ]; then
> > +	return 1
> > +    fi
> > +
> > +    return 0
> > +}
> 
> This function is testing if two devices are the same device.
> 
> # Returns:
> # 	0 if the devices are not the same
> # 	1 if the devices are the same.
> __same_block_dev()
> {
> 	if [ $# -ne 2 ]; then
> 		return 0;
> 	fi
> 
> 	if [ ! -b $1 -o ! -b $2 ]; then
> 		return 0;
> 	fi
> 
> 	if [ `stat -c %t,%T $1` != `stat -c %t,%T $2` ]; then
> 		return 0;
> 	fi
> 	return 1;
> }
> 
> > +
> >  # Do a command, log it to $seqres.full, optionally test return status
> > # and die if command fails. If called with one argument _do executes
> > the  # command, logs it, and returns its exit status. With two
> > arguments _do @@ -1095,19 +1113,14 @@ _require_scratch_nocheck()
> >  		fi
> >  		;;
> >  	*)
> > -		 if [ -z "$SCRATCH_DEV" -o "`_is_block_dev $SCRATCH_DEV`" = "" ]
> > -		 then
> > -		     _notrun "this test requires a valid \$SCRATCH_DEV"
> > -		 fi
> > -		 if [ "`_is_block_dev $SCRATCH_DEV`" = "`_is_block_dev
> $TEST_DEV`" ]
> > -		 then
> > -		     _notrun "this test requires a valid \$SCRATCH_DEV"
> > -		 fi
> > +		if ! _is_block_dev "$SCRATCH_DEV" "$TEST_DEV"; then
> > +		    _notrun "this test requires a valid \$SCRATCH_DEV"
> > +		fi
> 
> This doesn't make sense when you read it - the two checks are logically
> separate, self documenting checks and should stay that way. i.e.  the two
> checks are "if (!_is_block_dev $SCRATCH_DEV) _notrun..." and "if
> (_same_block_dev $TEST_DEV $SCRATCH_DEV) _notrun ...."

ok.

> 
> >  		if [ ! -d "$SCRATCH_MNT" ]
> >  		then
> > -		     _notrun "this test requires a valid \$SCRATCH_MNT"
> > +		    _notrun "this test requires a valid \$SCRATCH_MNT"
> >  		fi
> > -		 ;;
> > +		;;
> >      esac
> >
> >      # mounted?
> > @@ -1167,19 +1180,14 @@ _require_test()
> >  		fi
> >  		;;
> >  	*)
> > -		 if [ -z "$TEST_DEV" -o "`_is_block_dev $TEST_DEV`" = "" ]
> > -		 then
> > -		     _notrun "this test requires a valid \$TEST_DEV"
> > -		 fi
> > -		 if [ "`_is_block_dev $SCRATCH_DEV`" = "`_is_block_dev
> $TEST_DEV`" ]
> > -		 then
> > -		     _notrun "this test requires a valid \$TEST_DEV"
> > -		 fi
> > +		if ! _is_block_dev "$TEST_DEV" "$SCRATCH_DEV"; then
> > +		    _notrun "this test requires a valid \$TEST_DEV"
> > +		fi
> 
> Same, but this time for $TEST_DEV
> 
> >  		if [ ! -d "$TEST_DIR" ]
> >  		then
> > -		     _notrun "this test requires a valid \$TEST_DIR"
> > +		    _notrun "this test requires a valid \$TEST_DIR"
> >  		fi
> > -		 ;;
> > +		;;
> >      esac
> >
> >      # mounted?
> > @@ -1288,7 +1296,7 @@ _require_block_device()
> >  	echo "Usage: _require_block_device <dev>" 1>&2
> >  	exit 1
> >      fi
> > -    if [ "`_is_block_dev $1`" == "" ]; then
> > +    if ! _is_block_dev "$1"; then
> >  	_notrun "require $1 to be valid block disk"
> 
> Please keep the code using the if [ ]; then syntax.

It is hard to check return value in if [] format, unless we change function to
echo result into stdout and run function in a subshell.
We had discussed it in last mail, using return value is simple and stable than
function stdout, for example, a function will output unwanted content when
it call a failed command or changed-version command.


> >      fi
> >  }
> > @@ -2236,11 +2244,8 @@ _require_scratch_dev_pool()
> >  	esac
> >
> >  	for i in $SCRATCH_DEV_POOL; do
> > -		if [ "`_is_block_dev $i`" = "" ]; then
> > -			_notrun "this test requires valid block disk $i"
> > -		fi
> > -		if [ "`_is_block_dev $i`" = "`_is_block_dev $TEST_DEV`" ]; then
> > -			_notrun "$i is part of TEST_DEV, this test requires unique disks"
> > +		if ! _is_block_dev "$i" "$TEST_DEV"; then
> > +			_notrun "$i is not valid valid block disk, or part of TEST_DEV, this
> test requires unique valid disks"
> 
> And that error message is too long. Seperate tests tell us exactly what the
> error is, not make us guess which of many errors it could have been.

Agree.

Thanks
Zhaolei

> 
> Cheers,
> 
> Dave.
> --
> Dave Chinner
> david@fromorbit.com


