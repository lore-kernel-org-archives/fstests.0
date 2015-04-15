Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:3438 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755719AbbDOXyf (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 15 Apr 2015 19:54:35 -0400
Date: Thu, 16 Apr 2015 09:42:37 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [RFC PATCH] fiemap-tester.c: Do not error out when
 FIEMAP_EXTENT_NOT_ALIGNED is set and extent is aligned.
Message-ID: <20150415234237.GA15810@dastard>
References: <1429104593-24136-1-git-send-email-chandan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1429104593-24136-1-git-send-email-chandan@linux.vnet.ibm.com>
Sender: fstests-owner@vger.kernel.org
To: Chandan Rajendra <chandan@linux.vnet.ibm.com>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org, chandan@mykolab.com
List-ID: <fstests@vger.kernel.org>

On Wed, Apr 15, 2015 at 06:59:53PM +0530, Chandan Rajendra wrote:
> From Linux kernel's Documentation/filesystems/fiemap.txt,
> 
> * FIEMAP_EXTENT_NOT_ALIGNED
> Extent offsets and length are not guaranteed to be block aligned.
> 
> So this means that FIEMAP_EXTENT_NOT_ALIGNED is just a hint that indicates
> that the extent range could possibly be out of alignment w.r.t to the
> filesystem's blocksize. It should still be possible for fiemap ioctl to return
> extents with FIEMAP_EXTENT_NOT_ALIGNED flag set (e.g. Inline extents) but
> which have blocksize aligned ranges.

Perhaps, but if the inline extent is blocksize aligned, then it's
aligned data, and so FIEMAP_EXTENT_NOT_ALIGNED should not be set.

This is regression test code - we want to error out when the hints
are not correct, thereby telling the developer they haven't got
their logic correct. Indeed, we may have inadvertantly broken it,
and this check will tell us that.

i.e. If we set FIEMAP_EXTENT_NOT_ALIGNED in kernel code, you do
it because we the extent is not aligned. There's no "grey area" here;
the filesystem knows if the data is not aligned, and so should be
setting the appropriate flags to tell fiemap_fill_next_extent() that
it is unaligned data. Getting this wrong is a *bug* in the
filesystem's fiemap implementation, and that's what a regression
test suite is supposed to expose.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
