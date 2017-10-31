Received: from mx1.redhat.com ([209.132.183.28]:3295 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750785AbdJaEiC (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 31 Oct 2017 00:38:02 -0400
Date: Tue, 31 Oct 2017 12:37:58 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] generic/4[13,62]: restore TEST mount options
Message-ID: <20171031043758.GF17339@eguan.usersys.redhat.com>
References: <20171030080831.7339-1-Omer.Zilberberg@netapp.com>
 <20171030203658.GA4094@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171030203658.GA4094@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>, Omer Zilberberg <Omer.Zilberberg@netapp.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Oct 31, 2017 at 07:36:58AM +1100, Dave Chinner wrote:
> On Mon, Oct 30, 2017 at 10:08:31AM +0200, Omer Zilberberg wrote:
> > These tests locally change the TEST_FS_MOUNT_OPTS/MOUNT_OPTIONS
> > environment variables, and run _test_cycle_mount. As a result, following
> > tests using the TEST mount point may start with different mount options,
> > depending on run order.
> 
> I don't think that's the case. The change of the environment
> variable should only affect the current test process and it's
> children. When the test exits, we go back to the environment of the
> check process, where the TEST_FS_MOUNT_OPTS environment variable is
> still correctly set, and all future tests inherit from that. i.e.:
> 
> $ export FOO=foo
> $ echo $FOO
> foo
> $ bash
> $ echo $FOO
> foo
> $ export FOO=bar
> $ echo $FOO
> bar
> $ exit
> $ echo $FOO
> foo
> $
> 
> And after each test, check runs _check_filesystems(), which cycles
> the test mount, so for each new test process that is run they should
> already start in the correct state...

I agreed, the changing of variables in a sub-shell won't affect the
parent's copy, and check will restore the mounts with the untouched
options.

But the problem is that _check_test_fs() will cycle mount TEST_DEV with
MOUNT_OPTIONS not TEST_FS_MOUNT_OPTS, so if you have different mount
options set for TEST_DEV and SCRATCH_DEV, you'll see mount options
changed for TEST_DEV. e.g.

MOUNT_OPTIONS="-o dax" TEST_FS_MOUNT_OPTS="" ./check generic/413 generic/445
generic/445 mount TEST_DEV with "-o dax" too

MOUNT_OPTIONS="" TEST_FS_MOUNT_OPTS="-o dax" ./check generic/413 generic/445
generic/445 mount TEST_DEV without "-o dax"

MOUNT_OPTIONS="-o dax" TEST_FS_MOUNT_OPTS="-o dax" ./check generic/413 generic/445
both tests and both devices mount with "-o dax"

That's been discussed in this thread:
https://patchwork.kernel.org/patch/9742039/

Omer, can you please confirm if you're hitting this issue?

I think fixing _check_<fs>_filesystem() is the correct way. And I guess
we can refactor out a common function and call it in
_check_[xfs|btrfs|generic]_filesystem, pass the correct mount options
based on what device we're working on.

Thanks,
Eryu
