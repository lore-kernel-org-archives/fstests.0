Received: from mail-pg1-f193.google.com ([209.85.215.193]:41238 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727752AbfBXPkB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 24 Feb 2019 10:40:01 -0500
Received: by mail-pg1-f193.google.com with SMTP id m1so3295896pgq.8
        for <fstests@vger.kernel.org>; Sun, 24 Feb 2019 07:40:00 -0800 (PST)
Date: Sun, 24 Feb 2019 23:39:54 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH 0/6] squashfs: introduce squashfs support
Message-ID: <20190224153954.GD2713@desktop>
References: <20190122032408.91336-1-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122032408.91336-1-zhengbin13@huawei.com>
Sender: fstests-owner@vger.kernel.org
To: zhengbin <zhengbin13@huawei.com>
Cc: david@fromorbit.com, fstests@vger.kernel.org, houtao1@huawei.com, zhaohongjiang@huawei.com
List-ID: <fstests@vger.kernel.org>

[Sorry for being so long to review this squashfs support.]

On Tue, Jan 22, 2019 at 11:24:02AM +0800, zhengbin wrote:
> This patch add squashfs support in xfstests-dev. Add two directories
> in tests directory, readonly can also be used for other readonly
> filesystem, squashfs is just used for squashfs filesystem.
> tests/readonly/001        mount test
> tests/readonly/002--010   metadata test
> tests/readonly/011--018   data test
> tests/readonly/019--021   xattr test
> tests/squashfs/001--005   mksquashfs options test

I don't quite like the idea of "forking" random tests from 'generic' to
'readonly'. The biggest benefit of adding new fs support to fstests is
that it shares most of the 'generic' tests and gets good test coverage.
But forking a very small subset of generic tests not only defeats the
benefit but also adding extra maintain burden.

But the problem is that squashfs is a readonly filesystem and sharing
the existing generic tests is not easy. (Actually I've been looking at
this series several times, but couldn't come out with a good solution.)
Because fstests harness assumes the filesystem being tested is writable
by default, various _require rules also write/create files to check if a
functionality is supported by the underlying filesystem. This leads me
to wonder if fstests is suitable for such readonly filesystems?

I'm glad to hear what do others think, any comments are welcomed!

Thanks,
Eryu

> 
> The reason of use 'readonly' directory instead of generic/shard is:
> The step of tests in readonly filesystem(such as squashfs) are
> as follows:
> 1. write data in $SCRATCH_DEV
> 2. mkfs $SCRATCH_DEV file
> 3. mount file $SCRATCH_MNT
> 4. test in $SCRATCH_MNT
> 
> While the rw filesystems are as follows:
> 1. mkfs $SCRATCH_DEV
> 2. mount $SCRATCH_DEV $SCRATCH_MNT
> 3. test in $SCRATCH_MNT(just write data in $SCRATCH_MNT)
> 
> The tests in generic/shared are set as rw filesystem, it is hard
> to use this in readonly filesystem, use 'readonly' dir which can
> be easier to read.
> 
> PS: As readonly filesystems need to mkfs in every test, do not
> use TEST_DEV&TEST_DIR.
> 
> zhengbin (6):
>   squashfs: add squashfs support
>   squashfs: add mount test
>   squashfs: add metadata test
>   squashfs: add data test
>   squashfs: add xattr test
>   squashfs: add mksquashfs options test
> 
>  .gitignore                                  |   1 +
>  README.squashfs                             |  12 ++
>  check                                       |  19 ++-
>  common/attr                                 |   5 +
>  common/config                               |   6 +
>  common/rc                                   |  63 ++++++++-
>  src/aio-dio-regress/aio-subblock-eof-read.c |  84 ++++++++++++
>  tests/readonly/001                          |  97 ++++++++++++++
>  tests/readonly/001.out                      |   2 +
>  tests/readonly/002                          |  48 +++++++
>  tests/readonly/002.out                      |   6 +
>  tests/readonly/003                          |  72 +++++++++++
>  tests/readonly/003.out                      |   5 +
>  tests/readonly/004                          |  50 +++++++
>  tests/readonly/004.out                      |   3 +
>  tests/readonly/005                          |  77 +++++++++++
>  tests/readonly/005.out                      |   2 +
>  tests/readonly/006                          |  48 +++++++
>  tests/readonly/006.out                      |   4 +
>  tests/readonly/007                          |  74 +++++++++++
>  tests/readonly/007.out                      |   9 ++
>  tests/readonly/008                          | 193 ++++++++++++++++++++++++++++
>  tests/readonly/008.out                      |  34 +++++
>  tests/readonly/009                          |  50 +++++++
>  tests/readonly/009.out                      |   2 +
>  tests/readonly/010                          |  49 +++++++
>  tests/readonly/010.out                      |   4 +
>  tests/readonly/011                          |  92 +++++++++++++
>  tests/readonly/011.out                      |  30 +++++
>  tests/readonly/012                          |  56 ++++++++
>  tests/readonly/012.out                      |   5 +
>  tests/readonly/013                          |  47 +++++++
>  tests/readonly/013.out                      |   2 +
>  tests/readonly/014                          |  46 +++++++
>  tests/readonly/014.out                      |   2 +
>  tests/readonly/015                          |  42 ++++++
>  tests/readonly/015.out                      |   2 +
>  tests/readonly/016                          | 145 +++++++++++++++++++++
>  tests/readonly/016.out                      |   8 ++
>  tests/readonly/017                          | 107 +++++++++++++++
>  tests/readonly/017.out                      |   2 +
>  tests/readonly/018                          |  49 +++++++
>  tests/readonly/018.out                      |   2 +
>  tests/readonly/019                          | 109 ++++++++++++++++
>  tests/readonly/019.out                      |  45 +++++++
>  tests/readonly/020                          |  56 ++++++++
>  tests/readonly/020.out                      |   9 ++
>  tests/readonly/021                          |  74 +++++++++++
>  tests/readonly/021.out                      |  11 ++
>  tests/readonly/Makefile                     |  20 +++
>  tests/readonly/group                        |  26 ++++
>  tests/squashfs/001                          |  60 +++++++++
>  tests/squashfs/001.out                      |   9 ++
>  tests/squashfs/002                          |  40 ++++++
>  tests/squashfs/002.out                      |   2 +
>  tests/squashfs/003                          |  55 ++++++++
>  tests/squashfs/003.out                      |  12 ++
>  tests/squashfs/004                          |  73 +++++++++++
>  tests/squashfs/004.out                      |  23 ++++
>  tests/squashfs/005                          |  54 ++++++++
>  tests/squashfs/005.out                      |  13 ++
>  tests/squashfs/Makefile                     |  20 +++
>  tests/squashfs/group                        |  10 ++
>  63 files changed, 2372 insertions(+), 5 deletions(-)
>  create mode 100644 README.squashfs
>  create mode 100644 src/aio-dio-regress/aio-subblock-eof-read.c
>  create mode 100755 tests/readonly/001
>  create mode 100644 tests/readonly/001.out
>  create mode 100755 tests/readonly/002
>  create mode 100644 tests/readonly/002.out
>  create mode 100755 tests/readonly/003
>  create mode 100644 tests/readonly/003.out
>  create mode 100755 tests/readonly/004
>  create mode 100644 tests/readonly/004.out
>  create mode 100755 tests/readonly/005
>  create mode 100644 tests/readonly/005.out
>  create mode 100755 tests/readonly/006
>  create mode 100644 tests/readonly/006.out
>  create mode 100755 tests/readonly/007
>  create mode 100644 tests/readonly/007.out
>  create mode 100755 tests/readonly/008
>  create mode 100644 tests/readonly/008.out
>  create mode 100755 tests/readonly/009
>  create mode 100644 tests/readonly/009.out
>  create mode 100755 tests/readonly/010
>  create mode 100644 tests/readonly/010.out
>  create mode 100755 tests/readonly/011
>  create mode 100644 tests/readonly/011.out
>  create mode 100755 tests/readonly/012
>  create mode 100644 tests/readonly/012.out
>  create mode 100755 tests/readonly/013
>  create mode 100644 tests/readonly/013.out
>  create mode 100755 tests/readonly/014
>  create mode 100644 tests/readonly/014.out
>  create mode 100755 tests/readonly/015
>  create mode 100644 tests/readonly/015.out
>  create mode 100755 tests/readonly/016
>  create mode 100644 tests/readonly/016.out
>  create mode 100755 tests/readonly/017
>  create mode 100644 tests/readonly/017.out
>  create mode 100755 tests/readonly/018
>  create mode 100644 tests/readonly/018.out
>  create mode 100755 tests/readonly/019
>  create mode 100644 tests/readonly/019.out
>  create mode 100755 tests/readonly/020
>  create mode 100644 tests/readonly/020.out
>  create mode 100755 tests/readonly/021
>  create mode 100644 tests/readonly/021.out
>  create mode 100644 tests/readonly/Makefile
>  create mode 100644 tests/readonly/group
>  create mode 100755 tests/squashfs/001
>  create mode 100644 tests/squashfs/001.out
>  create mode 100755 tests/squashfs/002
>  create mode 100644 tests/squashfs/002.out
>  create mode 100755 tests/squashfs/003
>  create mode 100644 tests/squashfs/003.out
>  create mode 100755 tests/squashfs/004
>  create mode 100644 tests/squashfs/004.out
>  create mode 100755 tests/squashfs/005
>  create mode 100644 tests/squashfs/005.out
>  create mode 100644 tests/squashfs/Makefile
>  create mode 100644 tests/squashfs/group
> 
> --
> 2.16.2.dirty
> 
