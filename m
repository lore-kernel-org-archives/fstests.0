Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:8155 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751573AbeEEXge (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 5 May 2018 19:36:34 -0400
Date: Sun, 6 May 2018 09:36:31 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] README: document the new default run mode
Message-ID: <20180505233631.GG10363@dastard>
References: <20180505001951.5665-1-david@fromorbit.com>
 <CAOQ4uxgJ4+R05wfkgCA6DUEoQbPPJEhTGiE=5QDqoX5hjE7D7A@mail.gmail.com>
 <20180505140911.GE8373@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180505140911.GE8373@desktop>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: Amir Goldstein <amir73il@gmail.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Sat, May 05, 2018 at 10:09:11PM +0800, Eryu Guan wrote:
> On Sat, May 05, 2018 at 09:55:54AM +0300, Amir Goldstein wrote:
> > On Sat, May 5, 2018 at 3:19 AM, Dave Chinner <david@fromorbit.com> wrote:
> > If running ./check would exclude 'dangerous' tests by default, should it
> > also exclude dangerous_* tests? Or should we just remove the 20
> > 'dangerous' tests from auto group and try not to add new auto&dangerous
> > tests in the future?
> 
> I agreed, I think we should just remove the 20 'dangerous' tests from
> auto group (AFAICT, they are not dangerous anymore). And I'll avoid
> adding new tests that are in both dangerous & auto group.

If the test is not dangerous anymore, then remove the dangerous tag
from the test.

FWIW:

$ git grep auto tests/*group |grep dangerous
tests/btrfs/group:150 auto quick dangerous
tests/ext4/group:022 auto quick attr dangerous
tests/ext4/group:024 auto quick encrypt dangerous
tests/ext4/group:025 auto quick fuzzers dangerous
tests/generic/group:068 other auto freeze dangerous stress
tests/generic/group:280 auto quota freeze dangerous
tests/generic/group:390 auto freeze stress dangerous
tests/generic/group:406 auto quick dangerous
tests/generic/group:421 auto quick encrypt dangerous
tests/generic/group:446 auto quick rw dangerous
tests/generic/group:459 auto dangerous
tests/generic/group:463 auto quick clone dangerous
tests/xfs/group:115 auto quick fuzzers dangerous
tests/xfs/group:118 auto quick fsr dangerous
tests/xfs/group:119 log v2log auto freeze dangerous
tests/xfs/group:294 auto dir metadata dangerous
tests/xfs/group:306 auto dangerous quick punch
tests/xfs/group:311 auto dangerous quick
tests/xfs/group:431 auto quick dangerous
tests/xfs/group:438 auto quick quota dangerous

$ sudo ./run_check.sh "" "" "-b -s xfs generic/068 generic/280 generic/390 generic/406 generic/421 generic/446 generic/459 generic/463 xfs/115 xfs/118 xfs/119 xfs/294 xfs/306 xfs/311 xfs/431 xfs/438"
[....]
SECTION       -- xfs
FSTYP         -- xfs (debug)
PLATFORM      -- Linux/x86_64 test4 4.17.0-rc3-dgc+
MKFS_OPTIONS  -- -f -m rmapbt=1,reflink=1 -i sparse=1 /dev/pmem1
MOUNT_OPTIONS -- /dev/pmem1 /mnt/scratch

generic/068 49s ... 45s
generic/280 2s ... 3s
generic/390 25s ... 19s
generic/406 2s ... 2s
generic/421      [not run] No encryption support for xfs
generic/446 13s ... 13s
generic/459 15s ... 14s
generic/463 5s ... 1s
xfs/115 1s ... [not run] test requires XFS bug_on_assert to be off, turn it off to run the test
xfs/118 15s ... 15s
xfs/119 11s ... 12s
xfs/294 58s ... 58s
xfs/306 39s ... 41s
xfs/311 23s ... 23s
xfs/431 1s ... 1s
xfs/438 5s ... 5s
Passed all 16 tests


I can't speak for the btrfs and ext4 tests or generic/421
(encryption test), but none of the other generic or xfs tests marked
dangerous appear to be dangerous on a 4.17-rc3 kernel....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
