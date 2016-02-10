Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:52765 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751610AbcBJF6l (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 10 Feb 2016 00:58:41 -0500
Date: Wed, 10 Feb 2016 16:58:39 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 10/12] generic: disable generic/027 for tmpfs
Message-ID: <20160210055838.GT19486@dastard>
References: <1455069001-17846-1-git-send-email-tytso@mit.edu>
 <1455069001-17846-11-git-send-email-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1455069001-17846-11-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, hughd@google.com
List-ID: <fstests@vger.kernel.org>

On Tue, Feb 09, 2016 at 08:49:59PM -0500, Theodore Ts'o wrote:
> The generic/027 test creates a large number of 1k files until the file
> creation fails.  On other file systems there will be a large number
> zero length files because the block allocation has failed, but there
> are still inodes available, and so the file creation loop runs until
> the file system runs out of inodes.
> 
> With tmpfs, we can limit the size of the file system, which limits the
> block allocation, but there is no limit to the number of inodes that
> can be created until kmalloc() fails --- or the OOM killer kills the
> test.  So this causes this test to run for a long, long time, and in
> some cases the test or the test runner will get OOM killed instead.
> We have other ENOSPC tests, so given that tmpfs is just so different
> from all other file systems, it's simpler just to disable this test
> for tmpfs than to try to make it work.

This sounds like a bug in tmpfs and a potential user level DOS
vector, too. Hence I dont think not running the test is the right
thing to do here - tmpfs should be handling this gracefully by
applying sane resource limits.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
