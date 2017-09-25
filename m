Received: from mx1.redhat.com ([209.132.183.28]:58662 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932970AbdIYIlL (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 25 Sep 2017 04:41:11 -0400
From: Xiong Zhou <xzhou@redhat.com>
Subject: [PATCH v5 0/3] fix dax to nondax dio fake failures
Date: Mon, 25 Sep 2017 16:40:44 +0800
Message-Id: <1506328847-1669-1-git-send-email-xzhou@redhat.com>
In-Reply-To: <1492413255-11146-1-git-send-email-xzhou@redhat.com>
References: <1492413255-11146-1-git-send-email-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: ross.zwisler@linux.intel.com, dan.j.williams@intel.com, jmoyer@redhat.com, eguan@redhat.com, Xiong Zhou <xzhou@redhat.com>
List-ID: <fstests@vger.kernel.org>

v5:
  Whatever the device is, skip this subtest if it failed a
silent test run.
  Remove xfs/260 since per-inode flag has been disabled
in kernel. This test now passes on 4.14-rc1+, however it's
not what it intends to test.
  Minor fix on write_ro test. This one can be merged solely
since it's not related to the other 2 patches.

Xiong Zhou (3):
  generic: mmap write readonly DAX file
  generic/413: skip dax to nondax dio test if needed
  xfs/260: remove per-inode DAX flag test

 .gitignore            |   1 +
 src/Makefile          |   2 +-
 src/t_mmap_write_ro.c |  77 ++++++++++++++++++++++++
 tests/generic/413     |   8 +++
 tests/generic/461     |  93 +++++++++++++++++++++++++++++
 tests/generic/461.out |   2 +
 tests/generic/group   |   1 +
 tests/xfs/260         | 158 --------------------------------------------------
 tests/xfs/260.out     |   2 -
 tests/xfs/group       |   1 -
 10 files changed, 183 insertions(+), 162 deletions(-)
 create mode 100644 src/t_mmap_write_ro.c
 create mode 100755 tests/generic/461
 create mode 100644 tests/generic/461.out
 delete mode 100755 tests/xfs/260
 delete mode 100644 tests/xfs/260.out

-- 
1.8.3.1

