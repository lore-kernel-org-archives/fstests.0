Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:31299 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731055AbeKGJHl (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 7 Nov 2018 04:07:41 -0500
Date: Wed, 7 Nov 2018 10:39:56 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] fstest: CrashMonkey tests ported to xfstest
Message-ID: <20181106233956.GX6311@dastard>
References: <CA+EzBbB5t5bSZ0hB6Y1jkxTgOLOv809Jbbcx7w5eK_XS_FPG7w@mail.gmail.com>
 <20181104163826.GH12788@desktop>
 <1B22AFA2-FAF3-45AA-9910-CDBE4AEBFB09@gmail.com>
 <20181105052217.GT6311@dastard>
 <46630C6B-77FA-4D15-92E7-43B89AD889A0@gmail.com>
 <20181106231536.GB8691@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106231536.GB8691@thunk.org>
Sender: fstests-owner@vger.kernel.org
To: "Theodore Y. Ts'o" <tytso@mit.edu>
Cc: Jayashree Mohan <jayashree2912@gmail.com>, Eryu Guan <guaneryu@gmail.com>, fstests <fstests@vger.kernel.org>, Vijaychidambaram Velayudhan Pillai <vijay@cs.utexas.edu>, Amir Goldstein <amir73il@gmail.com>, Filipe Manana <fdmanana@gmail.com>
List-ID: <fstests@vger.kernel.org>

On Tue, Nov 06, 2018 at 06:15:36PM -0500, Theodore Y. Ts'o wrote:
> On Mon, Nov 05, 2018 at 02:16:57PM -0600, Jayashree Mohan wrote:
> > 
> > I believe that to _scratch_mkfs, I must first _cleanup dm_flakey. If I replace the above snippet by 
> > _cleanup
> > _scratch_mkfs
> > _init_flakey
> > 
> > The time taken for the test goes up by around 10 seconds (due to mkfs maybe). So I thought it was sufficient to remove the working directory.
> 
> Can you try adding _check_scratch_fs after each test case?  Yes, it

_check_scratch_fs now runs xfs_scrub on XFS as well as xfs_repair,
so it's actually quite expensive.

The whole point of aggregating all these tests into one fstest is to
avoid the overhead of running _check_scratch_fs after every single
test that are /extremely unlikely/ to fail on existing filesystems.

> Also, how big does the file system have to be?  I wonder if we can
> speed things up if a ramdisk is used as the backing device for
> dm-flakey.

I already run fstests on pmem devices for fast iteration of the
entire test suite. The slowest part of the test suite for quick
tests is still the filesystem checking between tests. So putting
dm-flakey on a ramdisk doesn't help anything here.

I also run fstests on memory constrained VMs, where there isn't ram
to add a ramdisk for random stuff like this. Then all the dm-flakey
tests either wont run or fail due to OOM-kills.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
