Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:5095 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725829AbeLCGnI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 3 Dec 2018 01:43:08 -0500
Received: from discord.disaster.area ([192.168.1.111])
        by dastard with esmtp (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1gThwZ-0003G3-1w
        for fstests@vger.kernel.org; Mon, 03 Dec 2018 17:42:59 +1100
Received: from dave by discord.disaster.area with local (Exim 4.91)
        (envelope-from <david@fromorbit.com>)
        id 1gThwY-00075F-WE
        for fstests@vger.kernel.org; Mon, 03 Dec 2018 17:42:59 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH 0/3] fstests: copy_file_range() bounds testing
Date: Mon,  3 Dec 2018 17:42:53 +1100
Message-Id: <20181203064256.26768-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi folks,

We suck at bounds testing new system calls. This is a test that
exercises the expected failure cases for copy_file_range(). It's
going to fail miserably on existing kernels - I'm about to post a
series of fixes to linux-fsdevel that make this test pass.

The test is also dependent on xfs_io changes that I posted a few
hours ago. The three (not 2!) patches can be found here:

https://marc.info/?l=linux-xfs&m=154378403323889&w=2
https://marc.info/?l=linux-xfs&m=154378403523890&w=2
https://marc.info/?l=linux-xfs&m=154378403323888&w=2
https://marc.info/?l=linux-xfs&m=154379644526132&w=2

Comments welcome.

-Dave

---

As an aside, one thing that I've discovered in writing this test is
that certain things we do to test certain file conditions are not
being tested corectly. e.g. immutable files.

When we set a file as immutable and then go to modify it with xfs_io
like this:

# xfs_io -c "chattr +i" test_file
# xfs_io -c "pwrite 0 4k" test_file

We are not actually testing whether the pwrite() syscall detected
that it can't write to an immutable file. xfs_io actually fails when
the open(O_RDWR) syscall fails because we can't open an immutable
file for writing. IOWs, it's not testing pwrite() at all.

Hence tests like generic/159 and generic/160 are not actually
testing whether cloning/deduping files fails on immutable files.

Instead, what we need to do is open the file O_RDWR, then set the
file immutable, then perform the modification operation. i.e. this:

# xfs_io -c "chattr +i" -c "pwrite 0 4k" test_file

Will exercise the pwrite() syscall hitting an immutable file. A
similar thing happens with trying to write/modify to read only files
- the open() call fails, not the call that we want to test. That's
why I added the "chmod" operation to xfs_io, to allow us to open a
file for write, then turn it read only while we still have a
writeable fd open. This then exercises trying to write/modify a
read-only file.

I'm sure there's lots of tests that have these problems. I don't
have time to audit them right now, but I'm bringing it up so that
people are aware of the issue and at least catch problems like this
in new tests....
