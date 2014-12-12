Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:28449 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759114AbaLLFWO (ORCPT
	<rfc822;fstests@vger.kernel.org>); Fri, 12 Dec 2014 00:22:14 -0500
Date: Fri, 12 Dec 2014 16:21:59 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] xfstests: generic/315: make sure the test file exists
 and is zero length
Message-ID: <20141212052159.GL24183@dastard>
References: <1418267623-29612-1-git-send-email-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1418267623-29612-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

[cc fstests@vger.kernel.org]

On Wed, Dec 10, 2014 at 10:13:43PM -0500, Theodore Ts'o wrote:
> Before we determine how much space is available to be fallocated, and
> before trying to fallocate the file, we need to make sure testfile.315
> exists and is zero-length.  Otherwise the fallocate program will fail
> the first time generic/315 is run on a freshly mkfs'ed file system:
>
> generic/315 0s ...	[06:31:43] [06:31:44] [failed, exit status 1] - output mismatch (see /results/results-ext3conv/generic/315.out.bad)
>     --- tests/generic/315.out	2014-10-31 10:13:04.000000000 -0400
>     +++ /results/results-ext3conv/generic/315.out.bad	2014-11-24 06:31:44.111279060 -0500
>     @@ -1,2 +1,6 @@
>      QA output created by 315
>      Slience is golden
>     +ls: cannot access /vdd/testfile.315: No such file or directory
>     +./tests/generic/315: line 69: [: : integer expression expected
>     +File size is changed to ( Bytes)
>     +(see /results/results-ext3conv/generic/315.full for details)

Already fixed by commit ca28228 ("generic: use xfs_io falloc, not
fallocate").

Yet another demonstration of why we have a "use xfs_io whereever
possible" rule for new tests: we don't have to hack around semantic
oddities of random CLI tools. ;)

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
