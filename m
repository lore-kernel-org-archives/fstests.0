Received: from userp2130.oracle.com ([156.151.31.86]:49306 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440150AbfFLQX7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 12 Jun 2019 12:23:59 -0400
Date: Wed, 12 Jun 2019 09:21:49 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: question about generic/473 on xfs filesystem
Message-ID: <20190612162149.GB1872778@magnolia>
References: <5D00F3BC.5000003@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5D00F3BC.5000003@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Cc: Eryu Guan <guaneryu@gmail.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Wed, Jun 12, 2019 at 08:44:44PM +0800, Yang Xu wrote:
> Hi Eryu, Darrick
> 
> Currently, on lastest kernel, generic/473 fails ,as below:
> # ./check generic/473
> FSTYP         -- xfs (non-debug)
> PLATFORM      -- 5.2.0-rc4+
> MKFS_OPTIONS  -- -f -bsize=4096 /dev/sda11
> MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/sda11 /mnt/xfstests/scratch
> generic/473 2s ... - output mismatch (see /var/lib/xfstests/results//generic/473.out.bad)
>     --- tests/generic/473.out   2019-06-12 19:30:37.219753498 +0800
>     +++ /var/lib/xfstests/results//generic/473.out.bad  2019-06-12 20:34:12.499984113 +0800
>     @@ -6,7 +6,7 @@
>      1: [256..287]: hole
>      Hole + Data
>      0: [0..127]: hole
>      -1: [128..255]: data
>      +1: [128..135]: data
>      Hole + Data + Hole
>      0: [0..127]: hole
> 
> I have seen previous mail[1]that mentioned "new ranged fiemap test (generic/473) fails on XFS, because there's no 
> final decision on the expected behavior yet and discussion has stalled somehow.". This case has been merged in 2017.12,
> but this case also fails on lastest kernel, does it have any update or I miss something? 

Nope, you haven't missed anything.  The FIEMAP documentation says that
filesystems /can/ report more data than the range requested, but XFS
and ext4 still differ as to whether or not they will.

--D

> more question:
> xfs/107 and xfs/136 also fail on lastest kernel on my machine. 
> 
> [1]https://www.spinics.net/lists/fstests/msg08426.html
> 
> 
> 
