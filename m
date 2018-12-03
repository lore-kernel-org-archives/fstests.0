Received: from aserp2120.oracle.com ([141.146.126.78]:45476 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbeLCQls (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 3 Dec 2018 11:41:48 -0500
Date: Mon, 3 Dec 2018 08:41:36 -0800
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH 0/3] fstests: copy_file_range() bounds testing
Message-ID: <20181203164136.GB8115@magnolia>
References: <20181203064256.26768-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203064256.26768-1-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Dec 03, 2018 at 05:42:53PM +1100, Dave Chinner wrote:
> Hi folks,
> 
> We suck at bounds testing new system calls. This is a test that
> exercises the expected failure cases for copy_file_range(). It's
> going to fail miserably on existing kernels - I'm about to post a
> series of fixes to linux-fsdevel that make this test pass.

Can you please cc the xfs list on fstests changes that affect xfs? :)

(says a prolific patchbomber :P)

> The test is also dependent on xfs_io changes that I posted a few
> hours ago. The three (not 2!) patches can be found here:
> 
> https://marc.info/?l=linux-xfs&m=154378403323889&w=2
> https://marc.info/?l=linux-xfs&m=154378403523890&w=2
> https://marc.info/?l=linux-xfs&m=154378403323888&w=2
> https://marc.info/?l=linux-xfs&m=154379644526132&w=2
> 
> Comments welcome.
> 
> -Dave
> 
> ---
> 
> As an aside, one thing that I've discovered in writing this test is
> that certain things we do to test certain file conditions are not
> being tested corectly. e.g. immutable files.
> 
> When we set a file as immutable and then go to modify it with xfs_io
> like this:
> 
> # xfs_io -c "chattr +i" test_file
> # xfs_io -c "pwrite 0 4k" test_file
> 
> We are not actually testing whether the pwrite() syscall detected
> that it can't write to an immutable file. xfs_io actually fails when
> the open(O_RDWR) syscall fails because we can't open an immutable
> file for writing. IOWs, it's not testing pwrite() at all.
> 
> Hence tests like generic/159 and generic/160 are not actually
> testing whether cloning/deduping files fails on immutable files.
> 
> Instead, what we need to do is open the file O_RDWR, then set the
> file immutable, then perform the modification operation. i.e. this:
> 
> # xfs_io -c "chattr +i" -c "pwrite 0 4k" test_file

Ok, I'll post a change to 159/160 to fix that.  I don't think btrfs got
this right (inode_permission vs. security_file_permission) either, which
is why the hoisted code and tests (mis)behave the way they do.

> Will exercise the pwrite() syscall hitting an immutable file. A
> similar thing happens with trying to write/modify to read only files
> - the open() call fails, not the call that we want to test. That's
> why I added the "chmod" operation to xfs_io, to allow us to open a
> file for write, then turn it read only while we still have a
> writeable fd open. This then exercises trying to write/modify a
> read-only file.
> 
> I'm sure there's lots of tests that have these problems. I don't
> have time to audit them right now, but I'm bringing it up so that
> people are aware of the issue and at least catch problems like this
> in new tests....

--D
