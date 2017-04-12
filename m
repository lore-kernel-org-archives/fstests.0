Received: from mx1.redhat.com ([209.132.183.28]:40780 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752650AbdDLOqj (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 12 Apr 2017 10:46:39 -0400
From: Xiong Zhou <xzhou@redhat.com>
Subject: [PATCH v3 0/4] split DAX mmap DIO cases
Date: Wed, 12 Apr 2017 22:46:16 +0800
Message-Id: <1492008380-29164-1-git-send-email-xzhou@redhat.com>
In-Reply-To: <20170412062608.y2u5og3xz2oly44b@XZHOUW.usersys.redhat.com>
References: <20170412062608.y2u5og3xz2oly44b@XZHOUW.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: ross.zwisler@linux.intel.com, dan.j.williams@intel.com, jmoyer@redhat.com, eguan@redhat.com, Xiong Zhou <xzhou@redhat.com>
List-ID: <fstests@vger.kernel.org>

In generic/413 and xfs/260, we run mmap DIO tests between
DAX and non-DAX mountpoints: dax_to_dax, dax_to_nondax,
nondax_to_dax, nondax_to_nondax.

Now tests from DAX to non-DAX fails as:
  read(Bad address) len 1024 dio dax to nondax
  ...

It is expected:
https://lists.01.org/pipermail/linux-nvdimm/2017-February/008959.html

So, this patchset run dax_to_nondax in separated cases, in which
checking devices underneath, _notrun if not compatible. The checking
helper may be ugly, though it stops confusing failures and tests
as much as possible. Comments are welcome.

The 4/4 write read only file test is not related to above changes,
just sending it together.

v3:
  split dax_to_nondax to separated cases;
  adding helper _require_pmem_key_value to require *_DEV in specific
status;
  adding Ross's fix to t_mmap_write_ro.c;
  adding munmap and close to t_mmap_write_ro.c;
  do not require devs' status in read-only file case, just adding
comment that it requires pmem memory mode device to reproduce;
  throw large testfile in TEST_DIR instead of $tmp.

Xiong Zhou (4):
  DAX-DIO: make dax_to_non_dax dio test solo
  generic: test mmap io fom DAX to non-DAX
  xfs: test per-inode DAX flag DAX to non-DAX
  generic: mmap write readonly DAX file

 .gitignore            |   1 +
 common/config         |   2 +
 common/rc             |  41 ++++++++++++++++++
 src/Makefile          |   2 +-
 src/t_mmap_write_ro.c |  76 +++++++++++++++++++++++++++++++++
 tests/generic/413     |  13 +-----
 tests/generic/423     | 113 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/423.out |   2 +
 tests/generic/424     |  92 ++++++++++++++++++++++++++++++++++++++++
 tests/generic/424.out |   2 +
 tests/generic/group   |   2 +
 tests/xfs/260         |  19 ++-------
 tests/xfs/288         | 111 +++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/288.out     |   2 +
 tests/xfs/group       |   1 +
 15 files changed, 450 insertions(+), 29 deletions(-)
 create mode 100644 src/t_mmap_write_ro.c
 create mode 100755 tests/generic/423
 create mode 100644 tests/generic/423.out
 create mode 100755 tests/generic/424
 create mode 100644 tests/generic/424.out
 create mode 100755 tests/xfs/288
 create mode 100644 tests/xfs/288.out

-- 
1.8.3.1

