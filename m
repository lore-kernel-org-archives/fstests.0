Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:64935 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750830AbbKXEm3 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 23 Nov 2015 23:42:29 -0500
Date: Tue, 24 Nov 2015 15:41:59 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] fstests: Update generic/077 for newest version of btrfs
 progs
Message-ID: <20151124044159.GO19199@dastard>
References: <22cee31ea262eb30d3243bcd5bc05dcfe16a9440.1448272550.git.zhaolei@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22cee31ea262eb30d3243bcd5bc05dcfe16a9440.1448272550.git.zhaolei@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Zhaolei <zhaolei@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Nov 23, 2015 at 05:55:58PM +0800, Zhaolei wrote:
> From: Zhao Lei <zhaolei@cn.fujitsu.com>
> 
> generic/077 fails on btrfs progs v4.3:
>  # ./check generic/077
>  FSTYP         -- btrfs
>  PLATFORM      -- Linux/x86_64 lenovo 4.4.0-rc2_HEAD_1ec218373b8ebda821aec00bb156a9c94fad9cd4_
>  MKFS_OPTIONS  -- /dev/sdb6
>  MOUNT_OPTIONS -- /dev/sdb6 /var/ltf/tester/scratch_mnt
> 
>  generic/077 344s ... [failed, exit status 1] - output mismatch (see /var/lib/xfstests/results//generic/077.out.bad)
>      --- tests/generic/077.out   2015-11-23 17:06:27.144983112 +0800
>      +++ /var/lib/xfstests/results//generic/077.out.bad  2015-11-23 17:41:25.187062895 +0800
>      @@ -1,7 +1,5 @@
>       QA output created by 077
>       *** create filesystem
>      -*** set default ACL
>      -*** populate filesystem, pass #1
>      -*** populate filesystem, pass #2
>      -*** all done
>      +mkfs failed
>      +(see /var/lib/xfstests/results//generic/077.full for details)
>       *** unmount
>  Ran: generic/077
>  Failures: generic/077
>  Failed 1 of 1 tests
> 
> Reason:
>  btrfs progs v4.3 use non-mixed blockgroup for small volume as default,
>  it need at least 100M to build a filesystem.

<sigh>

btrfs got broken again.

> Fix:
>  We can force mixed block group for btrfs, or increase filesystem
>  size to btrfs's least requirement to make test works, the first
>  way create a non-common filesystem in btrfs case, so this patch
>  use the second way.

No. This is a clear mkfs.btrfs regression, so the mkfs.btrfs default
behaviour needs to be changed back to something that works for small
filesystems.  Anyone who makes a <100MB btrfs filesytsem is going to
need to use that mixed block group option, so that needs to be what
the test uses here.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
