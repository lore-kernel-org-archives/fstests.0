Received: from aserp2130.oracle.com ([141.146.126.79]:55010 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbfBQUEi (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 17 Feb 2019 15:04:38 -0500
Date: Sun, 17 Feb 2019 12:04:32 -0800
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [ANNOUNCE] fstests: master branch updated to 17d70b52f5da
Message-ID: <20190217200432.GE6477@magnolia>
References: <5c697a39.1c69fb81.fb482.c48a@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c697a39.1c69fb81.fb482.c48a@mx.google.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sun, Feb 17, 2019 at 11:13:52PM +0800, Eryu Guan wrote:
> Hi all,
> 
> The master branch of the xfstests repository at:
> 
> 	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> 
> have just been updated. This is a big update that contains 14 commits and adds
> 11 new tests along with some random bug fixes.
> 
> One notable change is that you need to set 'USE_KMEMLEAK=yes' variable to
> enable kmemleak check now.
> 
> New failures I've noticed (tested with 5.0-rc4 kernel):
> - generic/52{6,7} and btrfs/183 fail on btrfs
> - generic/529,530 fail on XFS

Yes, those are new regression tests for fixes that will be in 5.1. :)

--D

> As we have many patches posted for review last week, there're still some
> pending patches didn't get reviewed yet, please be patient :)
> 
> Thanks,
> Eryu
> 
> The new head of the master branch is commit:
> 
> 17d70b52f5da shared: cgroup aware writeback accounting test
> 
> New commits:
> 
> Brian Foster (1):
>       [17d70b52f5da] shared: cgroup aware writeback accounting test
> 
> Christoph Hellwig (1):
>       [ec295d73ac19] generic/075,112: detect preallocation support for fsx tests
> 
> Cui Yue (1):
>       [0177f3c45883] src/t_mtab: Add error check for unlock_mtab()
> 
> Darrick J. Wong (7):
>       [c869a6712a86] xfs: test mkfs extent size hint validation
>       [0c24aa077f64] common: fix kmemleak to work with sections
>       [08174ee11083] common: fix _require_btime for lazy filesystems
>       [26e4a81c78d7] generic: check for reasonable inode creation time
>       [e6897e32b83e] generic: posix acl extended attribute memory corruption test
>       [f98cc2256bbe] inject: skip tests when knob dir exists but knob doesn't
>       [e6703b903a50] generic: check the behavior of programs opening a lot of O_TMPFILE files
> 
> Filipe Manana (3):
>       [31603fea8083] generic: test fsync after succession of file renames
>       [7e764183bbd5] generic: test fsync after succession of renames and unlink
>       [53fc54907b7e] btrfs: test for corruption when reading compressed files
> 
> Zorro Lang (1):
>       [1ee89eea1cb9] fsstress: avoid infinite zero byte reading
> 
> 
> Code Diffstat:
> 
>  .gitignore              |   2 +
>  README                  |   2 +
>  check                   |   7 +-
>  common/cgroup2          |  15 +++++
>  common/inject           |   7 ++
>  common/rc               |  44 +++++++++----
>  ltp/fsstress.c          |   6 +-
>  src/Makefile            |   2 +-
>  src/t_attr_corruption.c | 122 +++++++++++++++++++++++++++++++++++
>  src/t_mtab.c            |  10 ++-
>  src/t_open_tmpfiles.c   | 166 ++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/183         |  76 ++++++++++++++++++++++
>  tests/btrfs/183.out     |  21 ++++++
>  tests/btrfs/group       |   1 +
>  tests/generic/075       |  14 ++--
>  tests/generic/112       |  18 ++++--
>  tests/generic/526       |  72 +++++++++++++++++++++
>  tests/generic/526.out   |   5 ++
>  tests/generic/527       |  71 +++++++++++++++++++++
>  tests/generic/527.out   |   4 ++
>  tests/generic/528       |  53 ++++++++++++++++
>  tests/generic/528.out   |   2 +
>  tests/generic/529       |  41 ++++++++++++
>  tests/generic/529.out   |   2 +
>  tests/generic/530       |  65 +++++++++++++++++++
>  tests/generic/530.out   |   2 +
>  tests/generic/531       |  71 +++++++++++++++++++++
>  tests/generic/531.out   |   2 +
>  tests/generic/group     |   6 ++
>  tests/shared/011        | 141 ++++++++++++++++++++++++++++++++++++++++
>  tests/shared/011.out    |  14 ++++
>  tests/shared/group      |   1 +
>  tests/xfs/500           |  48 ++++++++++++++
>  tests/xfs/500.out       |   2 +
>  tests/xfs/501           |  91 ++++++++++++++++++++++++++
>  tests/xfs/501.out       |   2 +
>  tests/xfs/502           |  76 ++++++++++++++++++++++
>  tests/xfs/502.out       |   2 +
>  tests/xfs/group         |   3 +
>  39 files changed, 1257 insertions(+), 32 deletions(-)
> --
> Eryu Guan
> guaneryu@gmail.com
