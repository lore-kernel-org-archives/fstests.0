Received: from mx1.redhat.com ([209.132.183.28]:34426 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751558AbdASKYX (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 19 Jan 2017 05:24:23 -0500
From: Xiong Zhou <xzhou@redhat.com>
Subject: [PATCH v2 0/2] mmap dio and DAX
Date: Thu, 19 Jan 2017 18:13:56 +0800
Message-Id: <1484820838-5098-1-git-send-email-xzhou@redhat.com>
In-Reply-To: <20170119055405.GT1859@eguan.usersys.redhat.com>
References: <20170119055405.GT1859@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: eguan@redhat.com
Cc: fstests@vger.kernel.org, linux-nvdimm@ml01.01.org, Xiong Zhou <xzhou@redhat.com>
List-ID: <fstests@vger.kernel.org>

v2 :
  Merge helper function changes into the first patch;
  Rewrite _require_dax, check options for sure;
  Print msg in t_mmap_dio.c to show which test going wrong;
  Empty mount options and check after mount to ensure we
wont mount with wrong option;
  Remove unnecessary leading underscore and _fail;
  Use xfs_io instead of dd;
  Other minor fixes.

Test status:
  Both cases not run on normal block device;
  Both cases PASS on ramdisk based pmem devices;
  Both cases FAIL on nvdimm devices with:
    +write(Bad address) len 1024 dax to nondax
    +write(Bad address) len 4096 dax to nondax
    +write(Bad address) len 16777216 dax to nondax
    +write(Bad address) len 67108864 dax to nondax

Xiong Zhou (2):
  xfs: test per-inode DAX flag by IO
  generic: test mmap dio through DAX and non-DAX

 .gitignore            |   1 +
 common/rc             |  14 ++++++
 src/Makefile          |   2 +-
 src/t_mmap_dio.c      |  81 +++++++++++++++++++++++++++++++++++
 tests/generic/405     | 116 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/405.out |   2 +
 tests/generic/group   |   1 +
 tests/xfs/138         | 110 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/138.out     |   2 +
 tests/xfs/group       |   1 +
 10 files changed, 329 insertions(+), 1 deletion(-)
 create mode 100644 src/t_mmap_dio.c
 create mode 100755 tests/generic/405
 create mode 100644 tests/generic/405.out
 create mode 100755 tests/xfs/138
 create mode 100644 tests/xfs/138.out

-- 
1.8.3.1

