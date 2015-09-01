Received: from imap.thunk.org ([74.207.234.97]:58040 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753010AbbIAO4H (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 1 Sep 2015 10:56:07 -0400
Date: Tue, 1 Sep 2015 10:56:02 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: xfstests run to run variability
Message-ID: <20150901145602.GM7642@thunk.org>
References: <x4937yyrzh1.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x4937yyrzh1.fsf@segfault.boston.devel.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Jeff Moyer <jmoyer@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Sep 01, 2015 at 10:22:34AM -0400, Jeff Moyer wrote:
> Hi,
> 
> I typically use ./check -g auto to test for regressions in my patches.
> However, I've noticed that there is some run-to-run variability in the
> results, even for a single kernel.

I've certainly noticed this for ext4.  My response is to keep an
archive of test results, and keeping an eye on those tests which are
known to be flaky.

I've considered having a way of keeping a database of tests known to
be flaky, and having a program which automates updating that list over
time, but I haven't gotten around to it yet.

At least for ext4, in many cases the flaky tests are often (I'd say at
least 75% of the time when I've investigated) a bug in the file system
as opposed to the test.  There are a large number of bigalloc failures
which are due to the fact that xfs doesn't support file systems where
the block size can be different from the cluster allocation size, but
Eric Whitney was going to work on patches to enhance xfstests to
support this.

Probably not helpful for you since you're looking at flaky tests for
xfs.  I can say that I don't see an intersection between the flaky
tests for ext4 and the flaky generic tests you've listed for xfs:

> intermittent failures: generic/192 generic/247 generic/232 xfs/167

Cheers,

					- Ted
