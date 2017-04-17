Received: from mx1.redhat.com ([209.132.183.28]:38256 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932719AbdDQHO0 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 17 Apr 2017 03:14:26 -0400
From: Xiong Zhou <xzhou@redhat.com>
Subject: [PATCH v4 0/4] split DAX mmap DIO cases
Date: Mon, 17 Apr 2017 15:14:11 +0800
Message-Id: <1492413255-11146-1-git-send-email-xzhou@redhat.com>
In-Reply-To: <1492008380-29164-1-git-send-email-xzhou@redhat.com>
References: <1492008380-29164-1-git-send-email-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: ross.zwisler@linux.intel.com, dan.j.williams@intel.com, jmoyer@redhat.com, eguan@redhat.com, Xiong Zhou <xzhou@redhat.com>
List-ID: <fstests@vger.kernel.org>

v4:
  simpler helper to require *_DEV nvdimm device with specific
attr, by searching sysfs: find region by device name then find
namespace mode by region id. Don't need ndctl and jq.
  use __attribute__((__unused__)) to mute the warning instead.

Xiong Zhou (4):
  DAX-DIO: make dax_to_non_dax dio test solo
  generic: test mmap io fom DAX to non-DAX
  xfs: test per-inode DAX flag DAX to non-DAX
  generic: mmap write readonly DAX file

 .gitignore            |   1 +
 common/rc             |  45 ++++++++++++++++++++
 src/Makefile          |   2 +-
 src/t_mmap_write_ro.c |  77 ++++++++++++++++++++++++++++++++++
 tests/generic/413     |  13 +-----
 tests/generic/423     | 113 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/423.out |   2 +
 tests/generic/424     |  92 ++++++++++++++++++++++++++++++++++++++++
 tests/generic/424.out |   2 +
 tests/generic/group   |   2 +
 tests/xfs/260         |  17 +-------
 tests/xfs/288         | 111 +++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/288.out     |   2 +
 tests/xfs/group       |   1 +
 14 files changed, 451 insertions(+), 29 deletions(-)
 create mode 100644 src/t_mmap_write_ro.c
 create mode 100755 tests/generic/423
 create mode 100644 tests/generic/423.out
 create mode 100755 tests/generic/424
 create mode 100644 tests/generic/424.out
 create mode 100755 tests/xfs/288
 create mode 100644 tests/xfs/288.out

-- 
1.8.3.1

