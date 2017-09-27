Received: from ipmail01.adl2.internode.on.net ([150.101.137.133]:50430 "EHLO
        ipmail01.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751905AbdI0Vvm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 27 Sep 2017 17:51:42 -0400
Date: Thu, 28 Sep 2017 07:51:39 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 1/2] generic/461: Test RWF_NOWAIT
Message-ID: <20170927215139.GE3666@dastard>
References: <20170927191003.10099-1-rgoldwyn@suse.de>
 <20170927213454.GD3666@dastard>
 <2292b367-9880-8e03-fe59-84dc1f2b13da@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2292b367-9880-8e03-fe59-84dc1f2b13da@suse.de>
Sender: fstests-owner@vger.kernel.org
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: fstests@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Sep 27, 2017 at 04:39:20PM -0500, Goldwyn Rodrigues wrote:
> 
> 
> On 09/27/2017 04:34 PM, Dave Chinner wrote:
> > On Wed, Sep 27, 2017 at 02:10:02PM -0500, Goldwyn Rodrigues wrote:
> >> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> >>
> >> Tests the RWF_NOWAIT flag so the I/O returns immediately on
> >> a new file, without any block allocations.
> >>
> >> A new program which includes the pwritev2() call is used. This allows
> >> passing flags for the I/O to be performed.
> > 
> > Rather than write a one-off test program for this that effectively
> > replicates xfs_io pread/pwrite functionality, please add RWF_NOWAIT
> > flag support to xfs_io.
> > 
> 
> This one off program is required because xfs_io does not support partial
> writes. It tries to do that within the loop and does not return the
> number of bytes written. This is required for test generic/462.

Then please also extend xfs_io to support partial reads and writes
in the manner you need.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
