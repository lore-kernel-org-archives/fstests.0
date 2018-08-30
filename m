Received: from ipmail03.adl6.internode.on.net ([150.101.137.143]:55101 "EHLO
        ipmail03.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726457AbeH3Ifr (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 30 Aug 2018 04:35:47 -0400
Date: Thu, 30 Aug 2018 14:34:46 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] misc large filesystem fixes
Message-ID: <20180830043446.GE5631@dastard>
References: <b647246c-c206-229a-f801-60f20dfa9f28@redhat.com>
 <20180830031902.GC3651@desktop>
 <7869cd0a-ddb6-4972-1a36-446549d59a62@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7869cd0a-ddb6-4972-1a36-446549d59a62@sandeen.net>
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Eryu Guan <guaneryu@gmail.com>, Eric Sandeen <sandeen@redhat.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Wed, Aug 29, 2018 at 10:30:29PM -0500, Eric Sandeen wrote:
> On 8/29/18 10:19 PM, Eryu Guan wrote:
> > On Wed, Aug 29, 2018 at 04:43:38PM -0500, Eric Sandeen wrote:
> >> There are a few tests which fail on large filesytems because
> >> we run into mkfs limits.
> >>
> >> xfs/010 and xfs/013 hardcode 2 AGs, but if the device is larger
> >> than 2T this will fail.  Check the device size and restrict it
> >> to just under 2T so that a 2-AG mkfs is possible.

....
> > I'm thinking to introduce a new helper to require a given agcount will
> > fit the device size, and if the device is bigger than ($agcount * 1T)
> > then _notrun the test, something like (may need a better helper name):
> > 
> > _require_xfs_support_agcount()
> > {
> > 	local dev=$1
> > 	local agcount=$2
> > 	local max_sz=$((agcount*(2**40)))
> > 	local dev_sz=$(blockdev --getsize64 $dev)
> > 
> > 	if [ $dev_sz -gt $max_sz ]; then
> > 		_notrun "agcount $agcount is too small to hold $dev_sz device"
> > 	fi
> > }
> 
> I'm not sure we should _notrun, though - if what we really want to check
> is a 2-AG filesystem on the scratch dev, there are times when we may simply
> want to make a smaller filesystem and proceed.  For the cases I sent
> in my patch this should be perfectly fine...
> 
> > Then add this _require rule to all tests that only specify a custom
> > agsize, e.g. for xfs/010 we could do
> > 
> > _require_xfs_support_agcount $SCRATCH_DEV 2
> > 
> > I roughly went through all xfs tests and found that the following ones
> > may need this new _require rule
> > 
> > xfs/010
> > xfs/013
> > xfs/062
> > xfs/178
> > xfs/179
> > xfs/310
> > 
> > Perhaps there're better ways to solve the problem, any suggestions are
> > welcomed! 
> 
> Rather than a _require and a _notrun, what about a mkfs_scratch_agcount()
> that does something like
> 
> mkfs_scratch_agcount()
> {
>  agcount=$1
>  opts=$2
> 
>  # If $agcount AGs would result in too-large AG size, restrict the size
>  # to create $agcount roughly 1T AGs.
>  dsizeopt=""
>  dev_sz=$(blockdev --getsize64 $SCRATCH_DEV)
>  if [ "$dev_sz" -ge "$(($agcount*(2**40)))" ]; then
>    dsizeopt="-d size=$(($agcount*((2**40)-1)))"
>  fi
>  _scratch_mkfs_xfs "$opts -d agcount=$agcount $dsizeopt" | _filter_mkfs 2>$seqres.full
> }
> 
> or something like that?

Or, simpler options:

	- scratch_mkfs_sized with a size appropriate for the test
	  (works for every configuration)
	- _require_no_large_scratch_device (or whatever it's name
	  is) to skip the test on large devices
	- SCRATCH_MKFS_OPTIONS="-d agcount=500" on a 10GB scratch
	  device (i.e. 500x20MB AGs) will exercise most of the dusty
	  code corners cases that a 500TB filesystem with 1TB AGs
	  and 49.95TB preallocated by --largefs.

Remember, we don't have to test /everything/ with large filesystems
- most of the filesystem functionality behaves exactly the same on
small and large filesytsems. i.e. the largefs option is to be able
run smoke, stress and ENOSPC tests on unreasonably large
filesystems with a very small sparse backing store space
requirements, not run our entire suite of pin-point correctness and
regression tests that mostly only require a few megabytes of space
to run.... 

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
