Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:45335 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754547AbaJHEdp (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 8 Oct 2014 00:33:45 -0400
Date: Wed, 8 Oct 2014 15:33:41 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] xfs/242: fix for archs with 8k page size
Message-ID: <20141008043341.GH12693@dastard>
References: <20141007191259.7e5b5ee3@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141007191259.7e5b5ee3@oracle.com>
Sender: fstests-owner@vger.kernel.org
To: Dwight Engen <dwight.engen@oracle.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Oct 07, 2014 at 07:12:59PM -0400, Dwight Engen wrote:
> This test was failing on sparc64 because there is a minimum granularity of
> PAGE_CACHE_SIZE in xfs_vnodeops.c:xfs_zero_file_space(). This change follows
> the approach taken in xfs/194 to filter the bmap output to be in terms of
> "blocksize" which is computed from pagesize.

xfs/194 existed long before xfs/242, so it's not necessarily the
best example to follow. You've missed various things that make the
special hackery xfs/194 does to make it work. e.g.  clearing
mkfs/mount options. Your change doesn't do this, so it will make it
fail on CRC enable XFS filesystems because 4k / 8 = 512 bytes and
that's smaller than the minimum block size support on CRC enabled
XFS filesystems.

> _test_generic_punch is modified to optionally take multiple as an argument,
> so the file under test will be twice the size on an 8k machine as a 4k
> machine. Since the files will be different sizes, we can no longer use
> md5sum so od -x is used instead with the byte offsets converted to
> "blocksize" offsets.

Brian posted patches yesterday on the XFS list to fix zero range
problems, and they remove the page size rounding from
xfs_zero_file_space(). Hence this strange corner case behaviour is
likely to go away real soon, and so I don't think we should change
the test to work around it now...

Would would be much more useful for you to do would with a platform
like sparc64 is use it to test MKFS_OPTION="-b size=8k" and make all
these extent-map-output dependent tests work properly with >4k block
size filesystems.  ;)

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
