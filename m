Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:52515 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754997AbbKYDbd (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 24 Nov 2015 22:31:33 -0500
Date: Wed, 25 Nov 2015 14:31:18 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] fstests: Update generic/077 for newest version of btrfs
 progs
Message-ID: <20151125033118.GP19199@dastard>
References: <22cee31ea262eb30d3243bcd5bc05dcfe16a9440.1448272550.git.zhaolei@cn.fujitsu.com>
 <20151124044159.GO19199@dastard>
 <56550D50.3030907@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56550D50.3030907@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Qu Wenruo <quwenruo@cn.fujitsu.com>
Cc: Zhaolei <zhaolei@cn.fujitsu.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Nov 25, 2015 at 09:22:24AM +0800, Qu Wenruo wrote:
> Dave Chinner wrote on 2015/11/24 15:41 +1100:
> >On Mon, Nov 23, 2015 at 05:55:58PM +0800, Zhaolei wrote:
> >>From: Zhao Lei <zhaolei@cn.fujitsu.com>
> >>
> >>generic/077 fails on btrfs progs v4.3:
....
> >>      +mkfs failed
> >>      +(see /var/lib/xfstests/results//generic/077.full for details)
> >>       *** unmount
> >>  Ran: generic/077
> >>  Failures: generic/077
> >>  Failed 1 of 1 tests
> >>
> >>Reason:
> >>  btrfs progs v4.3 use non-mixed blockgroup for small volume as default,
> >>  it need at least 100M to build a filesystem.
> >
> ><sigh>
> >
> >btrfs got broken again.
> >
> >>Fix:
> >>  We can force mixed block group for btrfs, or increase filesystem
> >>  size to btrfs's least requirement to make test works, the first
> >>  way create a non-common filesystem in btrfs case, so this patch
> >>  use the second way.
> >
> >No. This is a clear mkfs.btrfs regression, so the mkfs.btrfs default
> >behaviour needs to be changed back to something that works for small
> >filesystems.  Anyone who makes a <100MB btrfs filesytsem is going to
> >need to use that mixed block group option, so that needs to be what
> >the test uses here.
> 
> I'm a little curious about fstests support for make small fs.
> 
> It's not strange that all filesystems have a requirement on the
> filesystem size, for btrfs it's a little larger than normal fs
> anyway.

No it isn't. btrfs can quite easily make a 50MB filesystem.
mkfs.btrfs got changed, and broke it's ability to create a 50MB
filesystem.

> Yes, this bug reported by Zhao is definitely a regression of
> mkfs.btrfs, and I'll enhance the size checking part of mkfs.btrfs.
> 
> But I hope fstests can have a generic API to make small fs other
> than current mkfs_sized without any good check on filesystem size.

Why? You're trying to invent a solution to a problem that doesn't
exist.

If a filesystem in an existing has become too small in a test to
exercise the necessary functionality, then it needs to be discussed
on the list, not worked around by trying to guess what size a
filesystem might need. Indeed, the test may very weel require a
specifically sized filesystem to exercise the particular code path
that a bug existed in, and so silently changing the filesystem size
because someone broke mkfs is exactly the wrong thing to be doing.

> Personally speaking, if the filesystem is a little larger than
> mkfs_sized parameter, it should not affect the testcases much, will
> only increase the time needed.

that's where you are wrong - there are plenty of ENOSPC tests where
the test is extremely specific about layout of files, the number and
size of them to create exact free space patterns and/or consumption.
Silently increasing the filesystem size because of mkfs suddenly
doesn't work properly means the tests no longer exercise the code
they were designed to test.

xfstests is not jsut for testing kernel changes - it tests all of
the filesystem utilities for regressions, too. And so when
inadvertant changes in default behaviour occur, it detects those
regressions too. We don't change tests just because they found
a regression...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
