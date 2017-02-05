Received: from mx1.redhat.com ([209.132.183.28]:57398 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751385AbdBEGVy (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 5 Feb 2017 01:21:54 -0500
From: Xiong Zhou <xzhou@redhat.com>
Subject: [PATCH v5 0/2] mmap dio and DAX
Date: Sun,  5 Feb 2017 14:21:42 +0800
Message-Id: <1486275704-18917-1-git-send-email-xzhou@redhat.com>
In-Reply-To: <1486221472-1007-1-git-send-email-ross.zwisler@linux.intel.com>
References: <1486221472-1007-1-git-send-email-ross.zwisler@linux.intel.com>
Sender: fstests-owner@vger.kernel.org
To: ross.zwisler@linux.intel.com, fstests@vger.kernel.org
Cc: linux-nvdimm@ml01.01.org, jmoyer@redhat.com, eguan@redhat.com, Xiong Zhou <xzhou@redhat.com>
List-ID: <fstests@vger.kernel.org>

Hi Ross,

Thanks for the fixup!
Here are v5 for testing and reviewing. And I need your
permission to add you in the signed-off list :)

---
common/rc         : requires SCRATCH_DEV support DAX
src/t_mmap_dio.c  : intro mmap and O_DIRECT rw through files
tests/generic/405 : IO between DAX/non-DAX mountpoints
tests/xfs/138     : IO between DAX/non-DAX xfs files(per-inode flag)

v2 :
  Merge helper function changes into the first patch;
  Rewrite _require_dax, check options for sure;
  Print msg in t_mmap_dio.c to show which test going wrong;
  Empty mount options and check after mount to ensure we
wont mount with wrong option;
  Remove unnecessary leading underscore and _fail;
  Use xfs_io instead of dd;
  Other minor fixes.

v3:
 close fds in C test programme for clean up.

v4:
 Test both buffered and O_DIRECT IO;
 Fix arg numbers in C test programme;
 Fix fs options check after mount.
 Cc Jeff Moyer since this test is based on his code.
 (Sorry for the late cc!)

v5:
 Mainly from Ross Zwisler <ross.zwisler@linux.intel.com>
 Add mkfs options to make fs 2M aligned, to hit PMD faults;
 Use falloc instead of pwrite to init test file aviding 4k
alignment;
 64M test file instead of 1G;
 Bumping test seq numners;
 Other minor fixes.

Test status:
  Both cases not run on normal block device;
  Both cases PASS on ramdisk based pmem devices;
  Both cases PASS on nvdimm(memory namespace) devices;
  DIO in both cases FAIL on brd based ramdisk with:
  DIO in both cases FAIL on nvdimm(raw namespace) devices with:
    +write(Bad address) len 1024 dio dax to nondax
    +write(Bad address) len 4096 dio dax to nondax
    +write(Bad address) len 16777216 dio dax to nondax
    +write(Bad address) len 67108864 dio dax to nondax
  (expected behavior)
  https://lists.01.org/pipermail/linux-nvdimm/2017-January/008600.html

Xiong Zhou (2):
  xfs: test per-inode DAX flag by IO
  generic: test mmap io through DAX and non-DAX

 .gitignore            |   1 +
 common/rc             |  13 ++++++
 src/Makefile          |   2 +-
 src/t_mmap_dio.c      | 107 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/407     | 125 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/407.out |   2 +
 tests/generic/group   |   1 +
 tests/xfs/196         | 124 +++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/196.out     |   2 +
 tests/xfs/group       |   1 +
 10 files changed, 377 insertions(+), 1 deletion(-)
 create mode 100644 src/t_mmap_dio.c
 create mode 100755 tests/generic/407
 create mode 100644 tests/generic/407.out
 create mode 100755 tests/xfs/196
 create mode 100644 tests/xfs/196.out

-- 
1.8.3.1

