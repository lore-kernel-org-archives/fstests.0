Received: from userp2120.oracle.com ([156.151.31.85]:33488 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750903AbeBEXOV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 5 Feb 2018 18:14:21 -0500
Date: Mon, 5 Feb 2018 15:04:14 -0800
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: xfstests failures
Message-ID: <20180205230414.GD4844@magnolia>
References: <94286394-157a-421b-7f73-52f10529f23f@intel.com>
 <20180205223157.euwzcw57tqkpbw5k@destitution>
 <82ed52ca-bdd8-ca11-61e3-793d84c8eab1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82ed52ca-bdd8-ca11-61e3-793d84c8eab1@intel.com>
Sender: fstests-owner@vger.kernel.org
To: Dave Jiang <dave.jiang@intel.com>
Cc: Dave Chinner <david@fromorbit.com>, eguan@redhat.com, fstests@vger.kernel.org, "Zwisler, Ross" <ross.zwisler@intel.com>
List-ID: <fstests@vger.kernel.org>

On Mon, Feb 05, 2018 at 04:01:34PM -0700, Dave Jiang wrote:
> On 02/05/2018 03:31 PM, Dave Chinner wrote:
> > On Mon, Feb 05, 2018 at 02:40:40PM -0700, Dave Jiang wrote:
> >> Eryu,
> >> I've noticed that these tests fails under what I think is a normal
> >> config (BRD of 48G). We have an expectation that for simple configs all
> >> tests in the 'auto' group should pass, and these ones don't. Are these
> >> false positive failures?  If so, what do we need to do to remove these
> >> false positives?  a) fix the tests to handle these cases b) remove the
> >> tests from the 'auto' group?  Something else? Attached file with test
> >> outputs. I think some if not all of these failures have lasted many
> >> kernel versions.
> >>
> >> # xfs
> >> generic/009
> >> generic/012
> >> generic/016
> >> generic/021
> >> generic/022
> >> generic/058
> >> generic/060
> >> generic/061
> >> generic/063
> >> generic/092
> >> generic/255
> >> xfs/167
> >> xfs/191-input-validation
> >> xfs/242
> >> xfs/252
> >> xfs/432
> > 
> > Except for xfs/191, these all look to be extent mapping failures.
> > i.e. there's one bug or config issue that is causing them all.
> > 
> >> # ext4
> >> generic/388
> >>
> >>
> >> -- 
> >>
> >> Dave Jiang
> >> Software Engineer, SSG/OTC
> >> Intel Corp.
> >> dave.jiang@intel.com
> > 
> >> # XFS failures
> >>
> >> # ./check generic/009
> >> FSTYP         -- xfs (non-debug)
> >> PLATFORM      -- Linux/x86_64 skx-ntbusd 4.15.0+
> >> MKFS_OPTIONS  -- -f -bsize=4096 /dev/ram0p2
> >> MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/ram0p2 /mnt/xfstests_scratch
> >>
> >> generic/009	 - output mismatch (see /root/xfstests/xfstests-dev/results//generic/009.out.bad)
> >>     --- tests/generic/009.out	2016-09-09 09:30:36.006800609 -0700
> >>     +++ /root/xfstests/xfstests-dev/results//generic/009.out.bad	2018-02-05 13:24:23.702640408 -0700
> >>     @@ -1,79 +1,75 @@
> >>      QA output created by 009
> >>      	1. into a hole
> >>     -0: [0..7]: hole
> >>     -1: [8..23]: unwritten
> >>     -2: [24..39]: hole
> >>     +0: [0..4095]: unwritten
> > 
> > You're getting a 2MB extent allocated here. I'm guessing your
> > testdev is configured with a 2MB extent size hint or something
> > similar left over from trying to test DAX w/ 2MB huge pages?
> 
> Yes. Looks like the config script was setting 2M extent. After removing
> and retesting xfs/191 and xfs/432 fails.
> 
> 
> # ./check xfs/432
> FSTYP         -- xfs (non-debug)
> PLATFORM      -- Linux/x86_64 skx-ntbusd 4.15.0+
> MKFS_OPTIONS  -- -f -bsize=4096 /dev/ram0p2
> MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/ram0p2
> /mnt/xfstests_scratch
> 
> xfs/432	 - output mismatch (see
> /root/xfstests/xfstests-dev/results//xfs/432.out.bad)
>     --- tests/xfs/432.out	2017-10-19 10:57:22.562819579 -0700
>     +++ /root/xfstests/xfstests-dev/results//xfs/432.out.bad	2018-02-05
> 15:57:29.673255360 -0700
>     @@ -3,4 +3,5 @@
>      Create huge dir
>      Check for > 1000 block extent?
>      Try to metadump
>     +xfs_metadump: suspicious count 1088 in bmap extent 1 in dir3 ino 35

What version of xfsprogs are you running?  I fixed that a while ago... I
think.

--D

>      Check restored metadump image
>     ...
>     (Run 'diff -u tests/xfs/432.out
> /root/xfstests/xfstests-dev/results//xfs/432.out.bad'  to see the entire
> diff)
> Ran: xfs/432
> Failures: xfs/432
> Failed 1 of 1 tests
> 
> 
> > 
> > Cheers,
> > 
> > Dave.
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
