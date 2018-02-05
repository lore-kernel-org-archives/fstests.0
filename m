Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:60003 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751175AbeBEWbF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 5 Feb 2018 17:31:05 -0500
Date: Tue, 6 Feb 2018 09:31:57 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: xfstests failures
Message-ID: <20180205223157.euwzcw57tqkpbw5k@destitution>
References: <94286394-157a-421b-7f73-52f10529f23f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94286394-157a-421b-7f73-52f10529f23f@intel.com>
Sender: fstests-owner@vger.kernel.org
To: Dave Jiang <dave.jiang@intel.com>
Cc: eguan@redhat.com, fstests@vger.kernel.org, "Zwisler, Ross" <ross.zwisler@intel.com>
List-ID: <fstests@vger.kernel.org>

On Mon, Feb 05, 2018 at 02:40:40PM -0700, Dave Jiang wrote:
> Eryu,
> I've noticed that these tests fails under what I think is a normal
> config (BRD of 48G). We have an expectation that for simple configs all
> tests in the 'auto' group should pass, and these ones don't. Are these
> false positive failures?  If so, what do we need to do to remove these
> false positives?  a) fix the tests to handle these cases b) remove the
> tests from the 'auto' group?  Something else? Attached file with test
> outputs. I think some if not all of these failures have lasted many
> kernel versions.
> 
> # xfs
> generic/009
> generic/012
> generic/016
> generic/021
> generic/022
> generic/058
> generic/060
> generic/061
> generic/063
> generic/092
> generic/255
> xfs/167
> xfs/191-input-validation
> xfs/242
> xfs/252
> xfs/432

Except for xfs/191, these all look to be extent mapping failures.
i.e. there's one bug or config issue that is causing them all.

> # ext4
> generic/388
> 
> 
> -- 
> 
> Dave Jiang
> Software Engineer, SSG/OTC
> Intel Corp.
> dave.jiang@intel.com

> # XFS failures
> 
> # ./check generic/009
> FSTYP         -- xfs (non-debug)
> PLATFORM      -- Linux/x86_64 skx-ntbusd 4.15.0+
> MKFS_OPTIONS  -- -f -bsize=4096 /dev/ram0p2
> MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/ram0p2 /mnt/xfstests_scratch
> 
> generic/009	 - output mismatch (see /root/xfstests/xfstests-dev/results//generic/009.out.bad)
>     --- tests/generic/009.out	2016-09-09 09:30:36.006800609 -0700
>     +++ /root/xfstests/xfstests-dev/results//generic/009.out.bad	2018-02-05 13:24:23.702640408 -0700
>     @@ -1,79 +1,75 @@
>      QA output created by 009
>      	1. into a hole
>     -0: [0..7]: hole
>     -1: [8..23]: unwritten
>     -2: [24..39]: hole
>     +0: [0..4095]: unwritten

You're getting a 2MB extent allocated here. I'm guessing your
testdev is configured with a 2MB extent size hint or something
similar left over from trying to test DAX w/ 2MB huge pages?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
