Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:17947 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752086AbbHCFwF (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 3 Aug 2015 01:52:05 -0400
Date: Mon, 3 Aug 2015 15:51:49 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 1/5] xfstest: add ubifs support
Message-ID: <20150803055149.GR3902@dastard>
References: <1438236417-24612-1-git-send-email-yangds.fnst@cn.fujitsu.com>
 <1438236417-24612-2-git-send-email-yangds.fnst@cn.fujitsu.com>
 <20150803041229.GQ3902@dastard>
 <55BEF1A3.9060103@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55BEF1A3.9060103@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Dongsheng Yang <yangds.fnst@cn.fujitsu.com>
Cc: eguan@redhat.com, fstests@vger.kernel.org, dedekind1@gmail.com, richard.weinberger@gmail.com, linux-mtd@lists.infradead.org
List-ID: <fstests@vger.kernel.org>

On Mon, Aug 03, 2015 at 12:44:19PM +0800, Dongsheng Yang wrote:
> On 08/03/2015 12:12 PM, Dave Chinner wrote:
> >On Thu, Jul 30, 2015 at 02:06:53PM +0800, Dongsheng Yang wrote:
> >>-	echo $TEST_DEV | grep -qE ":|//" > /dev/null 2>&1
> >>+	echo $TEST_DEV | grep -qE ":|//|ubi" > /dev/null 2>&1
> >>  	if [ ! -b "$TEST_DEV" -a "$?" != "0" ]; then
> >>-		echo "common/config: Error: \$TEST_DEV ($TEST_DEV) is not a block device or a network filesystem"
> >>+		echo "common/config: Error: \$TEST_DEV ($TEST_DEV) is not a block device or a network filesystem or ubi device"
> >>  		exit 1
> >>  	fi
> >>
> >>@@ -488,9 +489,9 @@ get_next_config() {
> >>  		export SCRATCH_DEV_NOT_SET=true
> >>  	fi
> >>
> >>-	echo $SCRATCH_DEV | grep -qE ":|//" > /dev/null 2>&1
> >>+	echo $SCRATCH_DEV | grep -qE ":|//|ubi" > /dev/null 2>&1
> >>  	if [ ! -z "$SCRATCH_DEV" -a ! -b "$SCRATCH_DEV" -a "$?" != "0" ]; then
> >>-		echo "common/config: Error: \$SCRATCH_DEV ($SCRATCH_DEV) is not a block device or a network filesystem"
> >>+		echo "common/config: Error: \$SCRATCH_DEV ($SCRATCH_DEV) is not a block device or a network filesystem or ubi device"
> >>  		exit 1
> >>  	fi
> >
> >Hmmm - how do we validate that we were passed a valid ubi device in
> >TEST_DEV/SCRATCH_DEV? (goes back to the probing question above...)
> 
> I am using the following config for my testing. So if we want to
> test ubifs, we have to pass a ubi volume to it. the name of it
> looks as ubiX_X.
> 
> # cat local.config
> # Ideally define at least these 4 to match your environment
> # The first 2 are required.
> # See README for other variables which can be set.
> #
> # Note: SCRATCH_DEV >will< get overwritten!
> 
> export TEST_DEV=/dev/ubi0_0
> export TEST_DIR=/mnt/test
> export SCRATCH_DEV=/dev/ubi0_1
> export SCRATCH_MNT=/mnt/scratch

So if we see /dev/ubi???? then we should check that it's a char
device to confirm it is what we think it should be?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
