Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:17014 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932947AbcITVmq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 20 Sep 2016 17:42:46 -0400
Date: Wed, 21 Sep 2016 07:42:43 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] dm flakey: add DAX support
Message-ID: <20160920214243.GA10454@dastard>
References: <147440445480.62486.9559239844115396323.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <147440445480.62486.9559239844115396323.stgit@djiang5-desk3.ch.intel.com>
Sender: fstests-owner@vger.kernel.org
To: Dave Jiang <dave.jiang@intel.com>
Cc: snitzer@redhat.com, agk@redhat.com, dm-devel@redhat.com, ross.zwisler@linux.intel.com, dan.j.williams@intel.com, fstests@vger.kernel.org, linux-nvdimm@ml01.01.org
List-ID: <fstests@vger.kernel.org>

On Tue, Sep 20, 2016 at 01:47:34PM -0700, Dave Jiang wrote:
> Change dm-flakey to implement direct_access function,
> flakey_direct_access(), which maps sector and calls direct_access
> function of its physical target device. This pretty much is a copy
> from DM Linear.
> 
> This allows fs with DAX to pass in xfstests.

They don't fail. They simply don't run like this:

generic/321 1s ... [not run] Cannot run tests with DAX on dmflakey devices
generic/322 0s ... [not run] Cannot run tests with DAX on dmflakey devices

> It does not actually introduce
> data corruption and dropping writes unlike the non-DAX path. The main
> reason is due to the I/O path being out of dmflakey's control once
> direct_access() has been called. The the existing implementation cannot
> be adapted to DAX I/O path. The error injection will be introduced at a
> later date with more thought.

Then introduce dmflakey DAX support at that time. Running tests that
are supposed to exercise failure paths when those failure paths
cannot be triggered is fundamentally useless. It leads a false
indication that we are actually testing failures, when in fact we
are doing nothing of the sort.

Right now the test harness execution clearly documents that there is
no failure testing being run on DAX devices, and that's the way it
should remain until dmflakey, dmerror, etc can inject the required
errors into the DAX paths....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
