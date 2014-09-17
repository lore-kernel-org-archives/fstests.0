Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:6826 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750900AbaIQErk (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 17 Sep 2014 00:47:40 -0400
Date: Wed, 17 Sep 2014 14:47:23 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] Add UBIFS support
Message-ID: <20140917044723.GH4267@dastard>
References: <1410772280-9771-1-git-send-email-richard@nod.at>
 <20140915215218.GH4322@dastard>
 <5418403A.8020004@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5418403A.8020004@nod.at>
Sender: fstests-owner@vger.kernel.org
To: Richard Weinberger <richard@nod.at>
Cc: fstests@vger.kernel.org, linux-mtd@lists.infradead.org
List-ID: <fstests@vger.kernel.org>

On Tue, Sep 16, 2014 at 03:50:50PM +0200, Richard Weinberger wrote:
> Am 15.09.2014 23:52, schrieb Dave Chinner:
> > On Mon, Sep 15, 2014 at 11:11:20AM +0200, Richard Weinberger wrote:
> >> UBIFS needs some extra care, the device node is of type character and
> >> it has no fsck tool.
> > 
> > Not being familiar with UBIFS, the explaination is rather brief and
> > doesn't explain anything to me. Can you document how where supposed
> > to treat a filesystem that doesn't exist on a block device for all
> > the tests that assume that the local fileystem is on a block device?
> > e.g. how do all the generic tests that use loopback devices work?
> > What about dm-flakey?
> 
> UBIFS is a filesystem designed for MTD devices.
> It works on top of UBI which is kind of a LVM for NAND and NOR flashes.
> On Linux MTD devices are represented as character devices, this is why
> the UBI device nodes are of type character.

Ok, so that needs to be in the commit message, and a comment
where we validate the device config on startup.  ;)

> For more details please see:
> http://www.linux-mtd.infradead.org/doc/ubi.html
> http://www.linux-mtd.infradead.org/doc/ubifs.html
> 
> Of course UBIFS will not work on top of loop or dm-flakey.
> AFAIK the generic tests don't use them anyway.

Generic tests do use dm-flakey:

$ git grep _require_dm_flakey tests/generic
tests/generic/311:_require_dm_flakey
tests/generic/321:_require_dm_flakey
tests/generic/322:_require_dm_flakey
tests/generic/325:_require_dm_flakey
$

There's no reason why generic tests can't use the loop device,
either. Indeed, 10 days ago we added an abstraction to allow generic
tests to easily use the loop device (i.e. added _mkfs_dev).

> I'd like to have UBIFS tested with xfstests because xfstests has a very
> good set of generic fs tests.

Understood - all I'm trying to do is work out what exactly what the
impact of TEST_DEV/SCRATCH_DEV not being block devices on a local
filesystem. Network filesystems are sufficiently different that this
isn't an issue, but char vs block local devices is a little more
subtle.

> Currently UBIFS fails 20 out of 76 generic tests.

Hmmm - there's ~140 generic tests in the auto group - I would have
expected a lot more of them to run than 76....

> At least one issue is real. As soon I have the time I'll
> inspect all other failures in detail.

... and what I'm particularly interested in is how many of those
are a result of tests assumes that they are running on a block or
network device.

> >> diff --git a/check b/check
> >> index 42a1ac2..57ec612 100755
> >> --- a/check
> >> +++ b/check
> >> @@ -70,6 +70,7 @@ check options
> >>      -nfs                test NFS
> >>      -cifs               test CIFS
> >>      -tmpfs              test TMPFS
> >> +    -ubifs              test UBIFS
> >>      -l			line mode diff
> >>      -udiff		show unified diff (default)
> >>      -n			show me, do not run tests
> > 
> > I'd like to avoid adding command line switches for random filesystem
> > types if at all possible. I'd much prefer that it be derived from
> > the current TEST_DEV if at all possible. Can you probe for UBIFS
> > similar to using blkid for local filesystems?
> 
> I fear blkid does not detect UBIFS, but we can match it from the device node name.
> UBIFS can only work on top of an UBI volume. UBI volumes have names like /dev/ubiX_Y.
> Where X is the UBI image number and Y the volume number.

Ok, so that probing can be done fairly easily. Right at the end of
common/config there's a blkid command run to grab the FSTYP value
from the $TEST_DEV. If returns a null, then we can check for it
being a UBI volume and set FSTYP automatically.

> >> diff --git a/common/config b/common/config
> >> index fc21b37..af082ea 100644
> >> --- a/common/config
> >> +++ b/common/config
> >> @@ -430,7 +430,7 @@ get_next_config() {
> >>  		exit 1
> >>  	fi
> >>  
> >> -	echo $TEST_DEV | grep -qE ":|//" > /dev/null 2>&1
> >> +	echo $TEST_DEV | grep -qE ":|//|ubi" > /dev/null 2>&1
> >>  	if [ ! -b "$TEST_DEV" -a "$?" != "0" ]; then
> >>  		echo "common/config: Error: \$TEST_DEV ($TEST_DEV) is not a block device or a network filesystem"
> >>  		exit 1
> > 
> > Needs a comment explaining what format we are searching for there?
> 
> See above. I match the string "ubi" in /dev/ubiX_Y.

Ok, I can see the match, but you're not validating that it is a char
device once you have a match, and so that will accept anything with
"/ubi" in it....

> >> @@ -453,7 +453,7 @@ get_next_config() {
> >>  		export SCRATCH_DEV_NOT_SET=true
> >>  	fi
> >>  
> >> -	echo $SCRATCH_DEV | grep -qE ":|//" > /dev/null 2>&1
> >> +	echo $SCRATCH_DEV | grep -qE ":|//|ubi" > /dev/null 2>&1
> >>  	if [ ! -z "$SCRATCH_DEV" -a ! -b "$SCRATCH_DEV" -a "$?" != "0" ]; then
> >>  		echo "common/config: Error: \$SCRATCH_DEV ($SCRATCH_DEV) is not a block device or a network filesystem"
> >>  		exit 1
> >> diff --git a/common/rc b/common/rc
> >> index b8f711a..064b987 100644
> >> --- a/common/rc
> >> +++ b/common/rc
> >> @@ -1034,6 +1034,12 @@ _require_scratch_nocheck()
> >>  		    _notrun "this test requires a valid \$SCRATCH_MNT and unique $SCRATCH_DEV"
> >>  		fi
> >>  		;;
> >> +	ubifs)
> >> +		if [ -z "$SCRATCH_DEV" -o ! -c "$SCRATCH_DEV" -o ! -d "$SCRATCH_MNT" ];
> >> +		then
> >> +		    _notrun "this test requires a valid \$SCRATCH_MNT and unique $SCRATCH_DEV"
> >> +		fi
> >> +		;;

Hmmm, now I see you check for char device here - it shouldn't be
necessary as we shouldn't even have got to this statement if the
SCRATCH_DEV is not a char device. i.e. validate it when pulling in
the config, then it can simply be assumed valid everywhere else if
it is set.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
