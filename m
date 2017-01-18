Received: from mx1.redhat.com ([209.132.183.28]:36838 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751354AbdARDHo (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 17 Jan 2017 22:07:44 -0500
From: Xiong Zhou <xzhou@redhat.com>
Subject: [PATCH 0/4] mmap dio and DAX
Date: Wed, 18 Jan 2017 11:07:02 +0800
Message-Id: <1484708826-23529-1-git-send-email-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-nvdimm@ml01.01.org, Xiong Zhou <xzhou@redhat.com>
List-ID: <fstests@vger.kernel.org>

common/rc         : requires SCRATCH_DEV support DAX
src/t_mmap_dio.c  : intro mmap and O_DIRECT rw through files
tests/generic/405 : IO between DAX/non-DAX mountpoints
tests/xfs/138     : IO between DAX/non-DAX xfs files(per-inode flag)

Xiong Zhou (4):
  common/rc: add _require_scratch_dax
  src/t_mmap_dio: add mmap dio test
  xfs: test per-inode DAX flag by IO
  generic: test mmap dio through DAX and non-DAX

 .gitignore            |   1 +
 common/rc             |  10 +++++
 src/Makefile          |   2 +-
 src/t_mmap_dio.c      |  81 ++++++++++++++++++++++++++++++++++++++
 tests/generic/405     | 100 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/405.out |   2 +
 tests/generic/group   |   1 +
 tests/xfs/138         | 105 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/138.out     |   2 +
 tests/xfs/group       |   1 +
 10 files changed, 304 insertions(+), 1 deletion(-)
 create mode 100644 src/t_mmap_dio.c
 create mode 100755 tests/generic/405
 create mode 100644 tests/generic/405.out
 create mode 100755 tests/xfs/138
 create mode 100644 tests/xfs/138.out

-- 
1.8.3.1

