Received: from userp2120.oracle.com ([156.151.31.85]:35952 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfAFSK6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 6 Jan 2019 13:10:58 -0500
Date: Sun, 6 Jan 2019 10:10:54 -0800
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [ANNOUNCE] fstests: master branch updated to f3a1213c2494
Message-ID: <20190106181054.GF20474@magnolia>
References: <5c321737.1c69fb81.b9424.ce58@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c321737.1c69fb81.b9424.ce58@mx.google.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sun, Jan 06, 2019 at 10:56:48PM +0800, Eryu Guan wrote:
> Hi all,
> 
> The master branch of the xfstests repository at:
> 
> 	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> 
> have just been updated. This is a bugfix-only update, and notably we reverted
> the RESULT_BASE fix in kmemleak support (sorry for suggesting a wrong fix), it
> turns that it's the kmemleak infrastracture that needs to be fixed (I'll look
> into it next week).

The kmemleak thing is a mess I created, I'll clean it up.

--D

> Thanks,
> Eryu
> 
> The new head of the master branch is commit:
> 
> f3a1213c2494 Revert "common/config: create $RESULT_BASE before dumping kmemleak leaks"
> 
> New commits:
> 
> Hou Tao (3):
>       [46c1a950e375] xfs: only set XFS_MKFS_HAS_NO_META_SUPPORT for XFS
>       [2408f208c106] fsx: check ENOSYS in test_copy_range() & test_fallocate()
>       [e18876187ce7] generic/131: wait until the server is ready or timeout
> 
> Nikolay Borisov (1):
>       [f3a1213c2494] Revert "common/config: create $RESULT_BASE before dumping kmemleak leaks"
> 
> Zorro Lang (2):
>       [6dbca6feb9ff] generic/474: shift target directory to a sub-dir of SCRATCH_MNT
>       [b0c8dbccf438] xfs/139-140: skip testing on large scratch dev
> 
> 
> Code Diffstat:
> 
>  check             |  7 +++++++
>  common/config     | 23 ++++++++++-------------
>  ltp/fsx.c         |  5 +++--
>  tests/generic/131 | 21 ++++++++++++++++++---
>  tests/generic/474 | 12 ++++++++----
>  tests/xfs/139     |  3 +++
>  tests/xfs/140     |  3 +++
>  7 files changed, 52 insertions(+), 22 deletions(-)
> --
> Eryu Guan
> guaneryu@gmail.com
