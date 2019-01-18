Received: from szxga04-in.huawei.com ([45.249.212.190]:2202 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725982AbfARJgM (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 18 Jan 2019 04:36:12 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8FD02A8D36DFCDEB7CF1
        for <fstests@vger.kernel.org>; Fri, 18 Jan 2019 17:33:49 +0800 (CST)
From: zhengbin <zhengbin13@huawei.com>
Subject: [PATCH 0/1] squashfs: introduce squashfs support
Date: Fri, 18 Jan 2019 17:37:24 +0800
Message-ID: <20190118093725.103172-1-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: guaneryu@gmail.com, fstests@vger.kernel.org
Cc: houtao1@huawei.com, zhaohongjiang@huawei.com, zhengbin13@huawei.com
List-ID: <fstests@vger.kernel.org>

This patch add squashfs support in xfstests-dev. Add two directories
in tests directory, readonly can also be used for other readonly
filesystem, squashfs is just used for squashfs filesystem.
tests/readonly/001        mount test
tests/readonly/002--010   metadata test
tests/readonly/011--018   data test
tests/readonly/019--021   xattr test
tests/squashfs/001--005   mksquashfs options test

zhengbin (1):
  squashfs: add squashfs tests

 .gitignore                                  |   1 +
 README.squashfs                             |  12 ++
 check                                       |  19 ++-
 common/attr                                 |   5 +
 common/config                               |   6 +
 common/rc                                   |  63 ++++++++-
 src/aio-dio-regress/aio-subblock-eof-read.c |  84 ++++++++++++
 tests/readonly/001                          |  97 ++++++++++++++
 tests/readonly/001.out                      |   2 +
 tests/readonly/002                          |  48 +++++++
 tests/readonly/002.out                      |   6 +
 tests/readonly/003                          |  72 +++++++++++
 tests/readonly/003.out                      |   5 +
 tests/readonly/004                          |  50 +++++++
 tests/readonly/004.out                      |   3 +
 tests/readonly/005                          |  77 +++++++++++
 tests/readonly/005.out                      |   2 +
 tests/readonly/006                          |  48 +++++++
 tests/readonly/006.out                      |   4 +
 tests/readonly/007                          |  74 +++++++++++
 tests/readonly/007.out                      |   9 ++
 tests/readonly/008                          | 193 ++++++++++++++++++++++++++++
 tests/readonly/008.out                      |  34 +++++
 tests/readonly/009                          |  50 +++++++
 tests/readonly/009.out                      |   2 +
 tests/readonly/010                          |  49 +++++++
 tests/readonly/010.out                      |   4 +
 tests/readonly/011                          |  92 +++++++++++++
 tests/readonly/011.out                      |  30 +++++
 tests/readonly/012                          |  56 ++++++++
 tests/readonly/012.out                      |   5 +
 tests/readonly/013                          |  47 +++++++
 tests/readonly/013.out                      |   2 +
 tests/readonly/014                          |  46 +++++++
 tests/readonly/014.out                      |   2 +
 tests/readonly/015                          |  42 ++++++
 tests/readonly/015.out                      |   2 +
 tests/readonly/016                          | 145 +++++++++++++++++++++
 tests/readonly/016.out                      |   8 ++
 tests/readonly/017                          | 107 +++++++++++++++
 tests/readonly/017.out                      |   2 +
 tests/readonly/018                          |  49 +++++++
 tests/readonly/018.out                      |   2 +
 tests/readonly/019                          | 109 ++++++++++++++++
 tests/readonly/019.out                      |  45 +++++++
 tests/readonly/020                          |  56 ++++++++
 tests/readonly/020.out                      |   9 ++
 tests/readonly/021                          |  74 +++++++++++
 tests/readonly/021.out                      |  11 ++
 tests/readonly/Makefile                     |  20 +++
 tests/readonly/group                        |  26 ++++
 tests/squashfs/001                          |  60 +++++++++
 tests/squashfs/001.out                      |   9 ++
 tests/squashfs/002                          |  40 ++++++
 tests/squashfs/002.out                      |   2 +
 tests/squashfs/003                          |  55 ++++++++
 tests/squashfs/003.out                      |  12 ++
 tests/squashfs/004                          |  73 +++++++++++
 tests/squashfs/004.out                      |  23 ++++
 tests/squashfs/005                          |  54 ++++++++
 tests/squashfs/005.out                      |  13 ++
 tests/squashfs/Makefile                     |  20 +++
 tests/squashfs/group                        |  10 ++
 63 files changed, 2372 insertions(+), 5 deletions(-)
 create mode 100644 README.squashfs
 create mode 100644 src/aio-dio-regress/aio-subblock-eof-read.c
 create mode 100755 tests/readonly/001
 create mode 100644 tests/readonly/001.out
 create mode 100755 tests/readonly/002
 create mode 100644 tests/readonly/002.out
 create mode 100755 tests/readonly/003
 create mode 100644 tests/readonly/003.out
 create mode 100755 tests/readonly/004
 create mode 100644 tests/readonly/004.out
 create mode 100755 tests/readonly/005
 create mode 100644 tests/readonly/005.out
 create mode 100755 tests/readonly/006
 create mode 100644 tests/readonly/006.out
 create mode 100755 tests/readonly/007
 create mode 100644 tests/readonly/007.out
 create mode 100755 tests/readonly/008
 create mode 100644 tests/readonly/008.out
 create mode 100755 tests/readonly/009
 create mode 100644 tests/readonly/009.out
 create mode 100755 tests/readonly/010
 create mode 100644 tests/readonly/010.out
 create mode 100755 tests/readonly/011
 create mode 100644 tests/readonly/011.out
 create mode 100755 tests/readonly/012
 create mode 100644 tests/readonly/012.out
 create mode 100755 tests/readonly/013
 create mode 100644 tests/readonly/013.out
 create mode 100755 tests/readonly/014
 create mode 100644 tests/readonly/014.out
 create mode 100755 tests/readonly/015
 create mode 100644 tests/readonly/015.out
 create mode 100755 tests/readonly/016
 create mode 100644 tests/readonly/016.out
 create mode 100755 tests/readonly/017
 create mode 100644 tests/readonly/017.out
 create mode 100755 tests/readonly/018
 create mode 100644 tests/readonly/018.out
 create mode 100755 tests/readonly/019
 create mode 100644 tests/readonly/019.out
 create mode 100755 tests/readonly/020
 create mode 100644 tests/readonly/020.out
 create mode 100755 tests/readonly/021
 create mode 100644 tests/readonly/021.out
 create mode 100644 tests/readonly/Makefile
 create mode 100644 tests/readonly/group
 create mode 100755 tests/squashfs/001
 create mode 100644 tests/squashfs/001.out
 create mode 100755 tests/squashfs/002
 create mode 100644 tests/squashfs/002.out
 create mode 100755 tests/squashfs/003
 create mode 100644 tests/squashfs/003.out
 create mode 100755 tests/squashfs/004
 create mode 100644 tests/squashfs/004.out
 create mode 100755 tests/squashfs/005
 create mode 100644 tests/squashfs/005.out
 create mode 100644 tests/squashfs/Makefile
 create mode 100644 tests/squashfs/group

--
2.16.2.dirty
