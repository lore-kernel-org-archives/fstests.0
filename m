Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:55115 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754094AbaFRAn6 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 17 Jun 2014 20:43:58 -0400
Date: Wed, 18 Jun 2014 10:43:55 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v3] xfstests: test speculative preallocation reclaim on
 ENOSPC/EDQUOT
Message-ID: <20140618004355.GZ4453@dastard>
References: <1402508170-61125-1-git-send-email-bfoster@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1402508170-61125-1-git-send-email-bfoster@redhat.com>
Sender: xfstests-owner@vger.kernel.org
To: Brian Foster <bfoster@redhat.com>
Cc: fstests@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

On Wed, Jun 11, 2014 at 01:36:10PM -0400, Brian Foster wrote:
> XFS can allocate significant amounts of space to files via speculative
> preallocation. Such preallocation may not be reclaimed automatically on
> file close() if a file is repeatedly opened and extended. For smaller
> filesystems with relatively large and slow growing files, this
> preallocation can linger for some time, including contributing to out of
> space conditions.
> 
> Create a situation where an fs is near out of space while several files
> still have lingering, significant preallocations. Verify that new
> writers reclaim the preallocated space rather than return ENOSPC. Repeat
> a similar test for quota limits and EDQUOT.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>

Hi Brian,

My test machines all fail this test with output like this:

xfs/014  - output mismatch (see /home/dave/src/xfstests-dev/results//xfs/014.out.bad)
    --- tests/xfs/014.out       2014-06-18 09:32:59.000000000 +1000
    +++ /home/dave/src/xfstests-dev/results//xfs/014.out.bad    2014-06-18 10:27:10.000000000 +1000
    @@ -1,2 +1,7 @@
     QA output created by 014
     Silence is golden.
    +/mnt/scratch/014.mnt/file.0: No space left on device
    +pwrite64: No space left on device
    +/mnt/scratch/014.mnt/file.2: No space left on device
    +pwrite64: No space left on device
    +pwrite64: Disk quota exceeded
.....

or this from a 1k block size filesystem:

xfs/014  - output mismatch (see /home/dave/src/xfstests-dev/results//xfs/014.out.bad)
    --- tests/xfs/014.out       2014-06-18 09:32:59.000000000 +1000
    +++ /home/dave/src/xfstests-dev/results//xfs/014.out.bad    2014-06-18 10:29:15.000000000 +1000
    @@ -1,2 +1,7 @@
     QA output created by 014
     Silence is golden.
    +pwrite64: No space left on device
    +pwrite64: No space left on device
    +pwrite64: No space left on device
    +pwrite64: No space left on device
    +pwrite64: Disk quota exceeded
.....

I'm still going to commit the test as it stands, but could you see
if you can reproduce this or suggest hints as to where it might be
going wrong?

FWIW, patches to tee the stderr output to both the golden output and
the $seqres.full file will make it much easier to determine what
write is failing....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
