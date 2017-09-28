Received: from mx1.redhat.com ([209.132.183.28]:39294 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751817AbdI1Hlr (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 28 Sep 2017 03:41:47 -0400
From: Xiong Zhou <xzhou@redhat.com>
Subject: [PATCH v6 0/4] fix dax to nondax dio fake failures
Date: Thu, 28 Sep 2017 15:41:36 +0800
Message-Id: <1506584500-867-1-git-send-email-xzhou@redhat.com>
In-Reply-To: <1506328847-1669-1-git-send-email-xzhou@redhat.com>
References: <1506328847-1669-1-git-send-email-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: ross.zwisler@linux.intel.com, dan.j.williams@intel.com, jmoyer@redhat.com, eguan@redhat.com, Xiong Zhou <xzhou@redhat.com>
List-ID: <fstests@vger.kernel.org>

v6:
  add new group dax.
  sort src/ binaries name.
  add comment about O_DIRECT in t_mmap_write_ro.c
  add comment about _require_user in write_ro case.
  fix test file size and write pattern in write_ro case.
  check errno in dax to nondax dio testrun, then skip if fit.

Xiong Zhou (4):
  tests: add new group dax
  gitignore: sort src/ binaries name
  generic: mmap write readonly DAX file
  generic/413: skip dax to nondax dio test if needed

 .gitignore            | 51 +++++++++++++--------------
 src/Makefile          |  2 +-
 src/t_mmap_dio.c      |  2 +-
 src/t_mmap_write_ro.c | 81 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/413     | 10 ++++++
 tests/generic/461     | 95 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/461.out |  2 ++
 tests/generic/group   |  9 ++---
 tests/xfs/group       |  2 +-
 9 files changed, 222 insertions(+), 32 deletions(-)
 create mode 100644 src/t_mmap_write_ro.c
 create mode 100755 tests/generic/461
 create mode 100644 tests/generic/461.out

-- 
1.8.3.1

