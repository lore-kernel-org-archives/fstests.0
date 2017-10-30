Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:35429 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751936AbdJ3UhB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 30 Oct 2017 16:37:01 -0400
Date: Tue, 31 Oct 2017 07:36:58 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] generic/4[13,62]: restore TEST mount options
Message-ID: <20171030203658.GA4094@dastard>
References: <20171030080831.7339-1-Omer.Zilberberg@netapp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171030080831.7339-1-Omer.Zilberberg@netapp.com>
Sender: fstests-owner@vger.kernel.org
To: Omer Zilberberg <Omer.Zilberberg@netapp.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Oct 30, 2017 at 10:08:31AM +0200, Omer Zilberberg wrote:
> These tests locally change the TEST_FS_MOUNT_OPTS/MOUNT_OPTIONS
> environment variables, and run _test_cycle_mount. As a result, following
> tests using the TEST mount point may start with different mount options,
> depending on run order.

I don't think that's the case. The change of the environment
variable should only affect the current test process and it's
children. When the test exits, we go back to the environment of the
check process, where the TEST_FS_MOUNT_OPTS environment variable is
still correctly set, and all future tests inherit from that. i.e.:

$ export FOO=foo
$ echo $FOO
foo
$ bash
$ echo $FOO
foo
$ export FOO=bar
$ echo $FOO
bar
$ exit
$ echo $FOO
foo
$

And after each test, check runs _check_filesystems(), which cycles
the test mount, so for each new test process that is run they should
already start in the correct state...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
