Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:58203 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755909AbaFRBW0 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 17 Jun 2014 21:22:26 -0400
Date: Wed, 18 Jun 2014 11:22:23 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] xfs/013: allow non-write fsstress operations in
 background workload
Message-ID: <20140618012223.GB4453@dastard>
References: <1401820129-6543-1-git-send-email-bfoster@redhat.com>
 <20140617235546.GY4453@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140617235546.GY4453@dastard>
Sender: xfstests-owner@vger.kernel.org
To: Brian Foster <bfoster@redhat.com>
Cc: fstests@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

On Wed, Jun 18, 2014 at 09:55:46AM +1000, Dave Chinner wrote:
> On Tue, Jun 03, 2014 at 02:28:49PM -0400, Brian Foster wrote:
> > It has been reported that test xfs/013 probably uses more space than
> > necessary, exhausting space if run against a several GB sized ramdisk.
> > xfs/013 primarily creates, links and removes inodes. Most of the space
> > consumption occurs via the background fsstress workload.
> > 
> > Remove the fsstress -w option that suppresses non-write operations. This
> > slightly reduces the storage footprint while still providing a
> > background workload for the test.
> > 
> > Signed-off-by: Brian Foster <bfoster@redhat.com>
> 
> This change makes the runtime blow out on a ramdisk from 4s to over
> ten minutes on my test machine. Non-ramdisk machines seem to be
> completely unaffected.
> 
> I was going to say "no, bad change", but I noticed that my
> spinning disk VMs weren't affected at all. Looking more closely,
> xfs/013 is now pegging all 16 CPUs on the VM. The profile:
> 
> -  60.73%  [kernel]  [k] do_raw_spin_lock
>    - do_raw_spin_lock
>       - 99.98% _raw_spin_lock
>          - 99.83% sync_inodes_sb
>               sync_inodes_one_sb
>               iterate_supers
>               sys_sync
>               tracesys
>               sync
> -  32.76%  [kernel]  [k] delay_tsc
>    - delay_tsc
>       - 98.43% __delay
>            do_raw_spin_lock
>          - _raw_spin_lock
>             - 99.99% sync_inodes_sb
>                  sync_inodes_one_sb
>                  iterate_supers
>                  sys_sync
>                  tracesys
>                  sync
> 
> OK, that's a kernel problem, not a problem with the change in the
> test...
> 
> /me goes and dusts off his "concurrent sync scalability" patches.

Turns out the reason for this problem suddenly showing up was that I
had another (500TB) XFS filesystem mounted that had several million
clean cached inodes on it from other testing I was doing before the
xfstests run. Even so, having sync go off the deep end when there's
lots of clean cached inodes seems like a Bad Thing to me. :/

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
