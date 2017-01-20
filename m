Received: from mx1.redhat.com ([209.132.183.28]:58634 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751059AbdATGSS (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 20 Jan 2017 01:18:18 -0500
From: Xiong Zhou <xzhou@redhat.com>
Subject: [PATCH v4 0/2] mmap dio and DAX
Date: Fri, 20 Jan 2017 14:15:48 +0800
Message-Id: <1484892950-25178-1-git-send-email-xzhou@redhat.com>
In-Reply-To: <1484878888-11483-1-git-send-email-xzhou@redhat.com>
References: <1484878888-11483-1-git-send-email-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: jmoyer@redhat.com, ross.zwisler@linux.intel.com, eguan@redhat.com, linux-nvdimm@ml01.01.org, Xiong Zhou <xzhou@redhat.com>
List-ID: <fstests@vger.kernel.org>

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

Test status:
  Both cases not run on normal block device;
  Both cases PASS on ramdisk based pmem devices;
  DIO in both cases FAIL on brd based ramdisk with:
  DIO in both cases FAIL on nvdimm devices with:
    +write(Bad address) len 1024 dio dax to nondax
    +write(Bad address) len 4096 dio dax to nondax
    +write(Bad address) len 16777216 dio dax to nondax
    +write(Bad address) len 67108864 dio dax to nondax

  I've reported this to nvdimm list.
  https://lists.01.org/pipermail/linux-nvdimm/2017-January/008600.html

Xiong Zhou (2):
  xfs: test per-inode DAX flag by IO
  generic: test mmap io through DAX and non-DAX

 .gitignore            |   1 +
 common/rc             |  13 ++++++
 src/Makefile          |   2 +-
 src/t_mmap_dio.c      | 105 ++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/405     | 119 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/405.out |   2 +
 tests/generic/group   |   1 +
 tests/xfs/138         | 116 ++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/138.out     |   2 +
 tests/xfs/group       |   1 +
 10 files changed, 361 insertions(+), 1 deletion(-)
 create mode 100644 src/t_mmap_dio.c
 create mode 100755 tests/generic/405
 create mode 100644 tests/generic/405.out
 create mode 100755 tests/xfs/138
 create mode 100644 tests/xfs/138.out

-- 
1.8.3.1

