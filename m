Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52837 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750880AbbBFGhg (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 6 Feb 2015 01:37:36 -0500
From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 0/9 v5] make xfs/tests generic by introducing shutdown for filesystems
Date: Thu,  5 Feb 2015 22:37:04 -0800
Message-Id: <1423204633-66673-1-git-send-email-jaegeuk@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
List-ID: <fstests@vger.kernel.org>

Thanks to Dave. :)

Change log from v4:
 o add mkfs in _require_scratch_shutdown
 o add _require_fiemap and _extent_hole_counts
 o add _require_logstate
 o modify xfs/086,087 output rules for the generic usage
 o add _get_log_configs to introduce consistent testing options
 o add _get_quota_option to define quota option for each filesystems

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

In this patch set, common/rc adds macros:
 o _require_scratch_shutdown : check whether FS supports shutdown
 o _require_fiemap           : check bmap tool is defined
 o _require_norecovery       : check filesystem supports norecovery option.
 o _require_logstate         : check logstate tools is defined
 o _get_log_configs          : define mount options for tests
 o _get_quota_option         : define quota options for filesystems

 The following tests become generic.
  xfs/053 -> generic/042
  xfs/137 -> generic/043
  xfs/138 -> generic/044
  xfs/139 -> generic/045
  xfs/140 -> generic/046
  xfs/179 -> generic/047
  xfs/180 -> generic/048
  xfs/182 -> generic/049
  xfs/200 -> generic/050
  xfs/306 -> generic/051

  xfs/085 -> generic/052
  xfs/086 -> generic/054
  xfs/087 -> generic/055

Jaegeuk Kim (9):
  common/rc: add _require_scratch_shtudown
  common/rc: add _require_fiemap and _extent_hole_counts
  common/rc: add _require_norecovery
  tests/generic: relocate xfs's tests into tests/generic/
  common/log: define _require_logstate
  xfs/086,087: remove specific testing options in output
  common/log: add _get_log_configs for testing options
  common/quota: give quota mount option per filesystem
  tests/generic: relocate xfs's tests into tests/generic/

 common/config                          |  1 +
 common/log                             | 98 +++++++++++++++++++++++++++++++---
 common/quota                           | 15 ++++++
 common/rc                              | 33 ++++++++++++
 tests/{xfs/053 => generic/042}         |  5 +-
 tests/{xfs/053.out => generic/042.out} |  2 +-
 tests/{xfs/137 => generic/043}         | 19 ++++---
 tests/generic/043.out                  |  1 +
 tests/{xfs/138 => generic/044}         | 19 ++++---
 tests/generic/044.out                  |  1 +
 tests/{xfs/139 => generic/045}         | 19 ++++---
 tests/generic/045.out                  |  1 +
 tests/{xfs/140 => generic/046}         | 15 +++---
 tests/generic/046.out                  |  1 +
 tests/{xfs/179 => generic/047}         | 13 +++--
 tests/generic/047.out                  |  1 +
 tests/{xfs/180 => generic/048}         | 13 +++--
 tests/generic/048.out                  |  1 +
 tests/{xfs/182 => generic/049}         | 13 +++--
 tests/generic/049.out                  |  1 +
 tests/{xfs/200 => generic/050}         | 10 ++--
 tests/{xfs/200.out => generic/050.out} |  2 +-
 tests/{xfs/306 => generic/051}         |  5 +-
 tests/{xfs/306.out => generic/051.out} |  2 +-
 tests/{xfs/085 => generic/052}         |  8 +--
 tests/{xfs/085.out => generic/052.out} |  2 +-
 tests/{xfs/086 => generic/054}         | 36 +++++--------
 tests/{xfs/086.out => generic/054.out} | 22 +-------
 tests/{xfs/087 => generic/055}         | 40 ++++++--------
 tests/{xfs/087.out => generic/055.out} | 53 ++++++++++++++----
 tests/generic/group                    | 13 +++++
 tests/xfs/137.out                      |  1 -
 tests/xfs/138.out                      |  1 -
 tests/xfs/139.out                      |  1 -
 tests/xfs/140.out                      |  1 -
 tests/xfs/179.out                      |  1 -
 tests/xfs/180.out                      |  1 -
 tests/xfs/182.out                      |  1 -
 tests/xfs/group                        | 13 -----
 39 files changed, 319 insertions(+), 166 deletions(-)
 rename tests/{xfs/053 => generic/042} (97%)
 rename tests/{xfs/053.out => generic/042.out} (92%)
 rename tests/{xfs/137 => generic/043} (87%)
 create mode 100644 tests/generic/043.out
 rename tests/{xfs/138 => generic/044} (87%)
 create mode 100644 tests/generic/044.out
 rename tests/{xfs/139 => generic/045} (87%)
 create mode 100644 tests/generic/045.out
 rename tests/{xfs/140 => generic/046} (90%)
 create mode 100644 tests/generic/046.out
 rename tests/{xfs/179 => generic/047} (90%)
 create mode 100644 tests/generic/047.out
 rename tests/{xfs/180 => generic/048} (91%)
 create mode 100644 tests/generic/048.out
 rename tests/{xfs/182 => generic/049} (90%)
 create mode 100644 tests/generic/049.out
 rename tests/{xfs/200 => generic/050} (95%)
 rename tests/{xfs/200.out => generic/050.out} (97%)
 rename tests/{xfs/306 => generic/051} (97%)
 rename tests/{xfs/306.out => generic/051.out} (60%)
 rename tests/{xfs/085 => generic/052} (94%)
 rename tests/{xfs/085.out => generic/052.out} (94%)
 rename tests/{xfs/086 => generic/054} (81%)
 rename tests/{xfs/086.out => generic/054.out} (93%)
 rename tests/{xfs/087 => generic/055} (79%)
 rename tests/{xfs/087.out => generic/055.out} (89%)
 delete mode 100644 tests/xfs/137.out
 delete mode 100644 tests/xfs/138.out
 delete mode 100644 tests/xfs/139.out
 delete mode 100644 tests/xfs/140.out
 delete mode 100644 tests/xfs/179.out
 delete mode 100644 tests/xfs/180.out
 delete mode 100644 tests/xfs/182.out

-- 
2.1.1

