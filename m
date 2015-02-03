Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56395 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752421AbbBCXHd (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 3 Feb 2015 18:07:33 -0500
From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 0/8 v4] make xfs/tests generic by introducing shutdown for filesystems
Date: Tue,  3 Feb 2015 15:07:12 -0800
Message-Id: <1423004840-45315-1-git-send-email-jaegeuk@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
List-ID: <fstests@vger.kernel.org>

This patch-set modifies several existing xfs's tests to be used by generic
filesystems.

1. FS requirement

In order to activate these testcases, filesystem should support a new feature,
shutdown, triggered by the following ioctl command.

#define FS_IOC_SHUTDOWN _IOR('X', 125, __u32)   /* Shutdown */

This ioctl needs one of three modes passed by a flag according to the syncing
policy.

#define FS_GOING_DOWN_FULLSYNC  0x0     /* going down with full sync */
#define FS_GOING_DOWN_METASYNC  0x1     /* going down with metadata */
#define FS_GOING_DOWN_NOSYNC    0x2     /* going down */

Whenever shutdown is requested with one of the above mode, filesystem must
stop any IOs, and wait for unmount, which is very useful to test power-off-
recovery.

2. Changes in xfstests

In this patch set, common/rc adds three macros:
 o _require_scratch_shutdown : check whether FS supports shutdown
 o _require_bmap             : check bmap tool is defined
 o _require_norecovery       : check filesystem supports norecovery option.

 The following tests become generic.
    xfs/051 -> generic/051
  * xfs/053 -> generic/054
    xfs/085 -> generic/085
    xfs/086 -> generic/086
    xfs/087 -> generic/087
    xfs/137 -> generic/137
    xfs/138 -> generic/138
    xfs/139 -> generic/139
    xfs/140 -> generic/140
    xfs/179 -> generic/179
    xfs/180 -> generic/180
    xfs/182 -> generic/182
    xfs/200 -> generic/200
  * xfs/306 -> generic/305

*) changed test numbers due to conflict.

Jaeeuk Km (8)
  comon/rc: add _require_scratch_shtudown
  common/rc: add _require_bmap
  common/rc: add _require_norecovery
  tests/xfs: convert 10 xfs's tests to be generic ones
  tests/generic: relocate xfs's tests into tests/generic/
  common/rc:  define dump.f2fs and logstate for f2fs
  tests/xfs: add f2fs testcase and convert them being generic
  tests/generic: relocate four xfs's tests into tests/generic/

 common/config              |    3 +
 common/log                 |   20 +-
 common/rc                  |   59 +
 tests/generic/051          |  103 +
 tests/generic/051.out      |    2 +
 tests/generic/054          |  102 +
 tests/generic/054.out      |   10 +
 tests/generic/085          |   98 +
 tests/generic/085.out      |  113 ++
 tests/generic/086          |  178 ++
 tests/generic/086.out.f2fs | 3306 +++++++++++++++++++++++++++++++
 tests/generic/086.out.xfs  | 4722 ++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/087          |  179 ++
 tests/generic/087.out.f2fs |  303 +++
 tests/generic/087.out.xfs  |  389 ++++
 tests/generic/137          |  106 +
 tests/generic/137.out      |    1 +
 tests/generic/138          |  112 ++
 tests/generic/138.out      |    1 +
 tests/generic/139          |  112 ++
 tests/generic/139.out      |    1 +
 tests/generic/140          |  109 +
 tests/generic/140.out      |    1 +
 tests/generic/179          |  107 +
 tests/generic/179.out      |    1 +
 tests/generic/180          |  111 ++
 tests/generic/180.out      |    1 +
 tests/generic/182          |  108 +
 tests/generic/182.out      |    1 +
 tests/generic/200          |  127 ++
 tests/generic/200.out      |   24 +
 tests/generic/305          |  105 +
 tests/generic/305.out      |    2 +
 tests/generic/group        |   14 +
 tests/xfs/051              |   95 -
 tests/xfs/051.out          |    2 -
 tests/xfs/053              |  101 -
 tests/xfs/053.out          |   10 -
 tests/xfs/085              |   93 -
 tests/xfs/085.out          |  113 --
 tests/xfs/086              |  152 --
 tests/xfs/086.out          | 4722 --------------------------------------------
 tests/xfs/087              |  153 --
 tests/xfs/087.out          |  389 ----
 tests/xfs/137              |  104 -
 tests/xfs/137.out          |    1 -
 tests/xfs/138              |  110 --
 tests/xfs/138.out          |    1 -
 tests/xfs/139              |  110 --
 tests/xfs/139.out          |    1 -
 tests/xfs/140              |  107 -
 tests/xfs/140.out          |    1 -
 tests/xfs/179              |  105 -
 tests/xfs/179.out          |    1 -
 tests/xfs/180              |  109 -
 tests/xfs/180.out          |    1 -
 tests/xfs/182              |  106 -
 tests/xfs/182.out          |    1 -
 tests/xfs/200              |  125 --
 tests/xfs/200.out          |   24 -
 tests/xfs/306              |  104 -
 tests/xfs/306.out          |    2 -
 tests/xfs/group            |   14 -
 63 files changed, 10628 insertions(+), 6860 deletions(-)
 create mode 100755 tests/generic/051
 create mode 100644 tests/generic/051.out
 create mode 100755 tests/generic/054
 create mode 100644 tests/generic/054.out
 create mode 100755 tests/generic/085
 create mode 100644 tests/generic/085.out
 create mode 100755 tests/generic/086
 create mode 100644 tests/generic/086.out.f2fs
 create mode 100644 tests/generic/086.out.xfs
 create mode 100755 tests/generic/087
 create mode 100644 tests/generic/087.out.f2fs
 create mode 100644 tests/generic/087.out.xfs
 create mode 100755 tests/generic/137
 create mode 100644 tests/generic/137.out
 create mode 100755 tests/generic/138
 create mode 100644 tests/generic/138.out
 create mode 100755 tests/generic/139
 create mode 100644 tests/generic/139.out
 create mode 100755 tests/generic/140
 create mode 100644 tests/generic/140.out
 create mode 100755 tests/generic/179
 create mode 100644 tests/generic/179.out
 create mode 100755 tests/generic/180
 create mode 100644 tests/generic/180.out
 create mode 100755 tests/generic/182
 create mode 100644 tests/generic/182.out
 create mode 100755 tests/generic/200
 create mode 100644 tests/generic/200.out
 create mode 100755 tests/generic/305
 create mode 100644 tests/generic/305.out
 delete mode 100755 tests/xfs/051
 delete mode 100644 tests/xfs/051.out
 delete mode 100755 tests/xfs/053
 delete mode 100644 tests/xfs/053.out
 delete mode 100755 tests/xfs/085
 delete mode 100644 tests/xfs/085.out
 delete mode 100755 tests/xfs/086
 delete mode 100644 tests/xfs/086.out
 delete mode 100755 tests/xfs/087
 delete mode 100644 tests/xfs/087.out
 delete mode 100755 tests/xfs/137
 delete mode 100644 tests/xfs/137.out
 delete mode 100755 tests/xfs/138
 delete mode 100644 tests/xfs/138.out
 delete mode 100755 tests/xfs/139
 delete mode 100644 tests/xfs/139.out
 delete mode 100755 tests/xfs/140
 delete mode 100644 tests/xfs/140.out
 delete mode 100755 tests/xfs/179
 delete mode 100644 tests/xfs/179.out
 delete mode 100755 tests/xfs/180
 delete mode 100644 tests/xfs/180.out
 delete mode 100755 tests/xfs/182
 delete mode 100644 tests/xfs/182.out
 delete mode 100755 tests/xfs/200
 delete mode 100644 tests/xfs/200.out
 delete mode 100755 tests/xfs/306
 delete mode 100644 tests/xfs/306.out

-- 
2.1.1

