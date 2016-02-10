Received: from imap.thunk.org ([74.207.234.97]:57037 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752365AbcBJPsP (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 10 Feb 2016 10:48:15 -0500
Date: Wed, 10 Feb 2016 10:48:10 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH 10/12] generic: disable generic/027 for tmpfs
Message-ID: <20160210154810.GC26922@thunk.org>
References: <1455069001-17846-1-git-send-email-tytso@mit.edu>
 <1455069001-17846-11-git-send-email-tytso@mit.edu>
 <20160210055838.GT19486@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160210055838.GT19486@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, hughd@google.com
List-ID: <fstests@vger.kernel.org>

On Wed, Feb 10, 2016 at 04:58:39PM +1100, Dave Chinner wrote:
> > With tmpfs, we can limit the size of the file system, which limits the
> > block allocation, but there is no limit to the number of inodes that
> > can be created until kmalloc() fails --- or the OOM killer kills the
> > test.  So this causes this test to run for a long, long time, and in
> > some cases the test or the test runner will get OOM killed instead.
> > We have other ENOSPC tests, so given that tmpfs is just so different
> > from all other file systems, it's simpler just to disable this test
> > for tmpfs than to try to make it work.
> 
> This sounds like a bug in tmpfs and a potential user level DOS
> vector, too. Hence I dont think not running the test is the right
> thing to do here - tmpfs should be handling this gracefully by
> applying sane resource limits.

Well, it's not really that interesting of a DOS vector since if the
goal is to use up all available memory, there are other ways to do it
that are much more efficient.  If you are using a memory cgroup, the
kmalloc does eventually fail and so the O_CREAT open(2) call will
return ENOMEM --- but it can take 20+ hours with a 8G memory
container.  Without a memory cgroup in general the test runner gets
OOM killed first, but a much better DOS vector is to open one too many
tabs in Chrome, at which point your machine thrashes to death and the
X server goes unresponsive (and this is why many people have started
running Chrome inside a memory container).

OTOH, the fact that tmpfs doesn't have a inode limits is a bit weird.
What about having tmpfs enforce a per-mount "maxinodes" restriction
which by default is "maxsize / 1k", and which can be overriden using a
maxinodes mount option?  Does that sound sane to you?

Or we could charge a minimum 512 bytes per inode against the size,
since between the kernel data structures and the file name, it's not
like a zero-length tmpfs file is free.

						- Ted
