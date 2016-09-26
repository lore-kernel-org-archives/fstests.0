Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:19188 "EHLO
        ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S936146AbcIZWLD (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 26 Sep 2016 18:11:03 -0400
Date: Tue, 27 Sep 2016 08:10:58 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] check: check SCRATCH_MNT before calling _scratch_mkfs
Message-ID: <20160926221058.GB2532@dastard>
References: <81e70e43-b337-acca-1c29-69db4f3a3cfa@jeffm.io>
 <20160926044443.GA2532@dastard>
 <20fd4981-a27f-ebba-705f-f479e79b6143@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20fd4981-a27f-ebba-705f-f479e79b6143@suse.com>
Sender: fstests-owner@vger.kernel.org
To: Jeff Mahoney <jeffm@suse.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Sep 26, 2016 at 09:13:37AM -0400, Jeff Mahoney wrote:
> On 9/26/16 12:44 AM, Dave Chinner wrote:
> > On Sun, Sep 25, 2016 at 09:44:13PM -0400, Jeff Mahoney wrote:
> >> On NFS or Overlayfs, "mkfs" turns into rm -rf $SCRATCH_MNT/*
> >>
> >> There is no warning/error in check if SCRATCH_MNT is unset.
> >>
> >> Also add the checks to _scratch_cleanup_files.
> >>
> >> Signed-off-by: Jeff Mahoney <jeffm@suse.com>
> >> ---
> >>  check     | 12 ++++++++++++
> >>  common/rc |  8 ++++++++
> >>  2 files changed, 20 insertions(+)
> >>
> >> diff --git a/check b/check
> >> index 69341d8..b22d2df 100755
> >> --- a/check
> >> +++ b/check
> >> @@ -512,6 +512,18 @@ for section in $HOST_OPTIONS_SECTIONS; do
> >>  	needwrap=true
> >>  
> >>  	if [ ! -z "$SCRATCH_DEV" ]; then
> >> +	   if [ -z "$SCRATCH_MNT" ]
> >> +	    then
> >> +		echo "\$SCRATCH_MNT is unset"
> >> +		status=1
> >> +		exit
> >> +	    fi
> >> +	   if [ ! -d "$SCRATCH_MNT" ]
> >> +	    then
> >> +		echo "\$SCRATCH_MNT is not a dir"
> >> +		status=1
> >> +		exit
> >> +	    fi
> > 
> > That is supposed to be checked in get_next_config() at the start of
> > the loop. It runs these checks on the scratch config:
> > 
> > 	_check_device SCRATCH_DEV optional $SCRATCH_DEV
> > 	if [ ! -z "$SCRATCH_MNT" -a ! -d "$SCRATCH_MNT" ]; then
> > 		echo "common/config: Error: \$SCRATCH_MNT ($SCRATCH_MNT) is not a directory"
> > 		exit 1
> > 	fi
> 
> But that only presents an error if SCRATCH_MNT isn't empty.  If it is,
> we skip happily past.
> 
> > If SCRATCH_DEV/SCRATCH_MNT is not set - which is a valid config -
> 
> SCRATCH_DEV without SCRATCH_MNT isn't a valid config, though.  That
> ./check assumes that SCRATCH_DEV being valid means SCRATCH_MNT is too is
> the source of the problem.  The test in get_next_config would prevent
> the problem if we replaced the ! -z "$SCRATCH_MNT" with ! -z "$SCRATCH_DEV"

Because SCRATCH_DEV is optional, the check for SCRATCH_MNT in
get_next_config() needs to take that into account. i.e. if
SCRATCH_DEV is set, then SCRATCH_MNT must be set, too.

> > the all that is supposed to happen is that tests which call
> > _require_scratch() should not run. This, in turn should prevent
> 
> ... but _require_scratch doesn't run in ./check.  The individual test
> cases are safe because _require_scratch runs there and does check.
> ./check just checks to see if $SCRATCH_DEV is set and then calls
> _scratch_mkfs without checking $SCRATCH_MNT.  Since _scratch_mkfs
> doesn't check either, boom.

Yes, I know. That's why it should be checked in get_next_config() -
it is supposed to catch any config errors before they get used
anywhere.

It makes no sense to sprinkle random "is the config valid" checks
throughout the code. We should validate the config once - and once
only - before we run anything. Then we can assume (correctly) the
config is valid everywhere else.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
