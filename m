Received: from mx1.redhat.com ([209.132.183.28]:35648 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932249AbcJ2QLm (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 29 Oct 2016 12:11:42 -0400
Message-Id: <201610291604.u9TG4euC023650@int-mx11.intmail.prod.int.phx2.redhat.com>
Date: Sun, 30 Oct 2016 00:04:40 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: [GIT PULL] fstests: updates on 2016-10-29
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
List-ID: <fstests@vger.kernel.org>

Hi Dave,

Can you please pull the fstests update from the location below? There're
updates from last two weeks in this pull request. After this update, xfs_io is
run with -i option if supported. There're also more fixes for rmap/reflink
tests, one new generic test and more small fixes.

New failure I noticed in this update:
- generic/389 fails due to xfs_io bug when handling -m option

Thanks,
Eryu

The following changes since commit 16ef0843f2122deaf9845833ae73f60c67862aa4:

  xfs/122: remove dead code (2016-10-14 10:05:34 +0800)

are available in the git repository at:

  https://github.com/guaneryu/xfstests.git for-dave

for you to fetch changes up to efef020df5b257085831106847d318c93d46531c:

  src/seek_sanity_test: discover allocation size (2016-10-26 19:15:44 +0800)

----------------------------------------------------------------

fstests: update on 2016-10-29

This update contains:
o Add -i option to xfs_io command if supported
o New generic test
o More fixes to reflink tests and xfs_db usage
o Fixes to overlay tests, xfs and generic tests

----------------------------------------------------------------
Amir Goldstein (6):
      fstests: fix call sites that used xfs_io directly
      fstests: strip quotes from "$XFS_IO_PROG" call sites
      fstests: run xfs_io with -i option if supported
      t_truncate_self: describe self better in error message
      overlay/013: fix bug in test_upper creation
      overlay/013: adjust test expectation to kernel v4.8

Andreas Gruenbacher (1):
      generic: Check linking O_TMPFILE into namespace with POSIX ACLs

Benjamin Coddington (1):
      src/seek_sanity_test: discover allocation size

Darrick J. Wong (3):
      xfs: set the refcount btree cowflag when setting up cow
      fstests: fix fallocate commands that need the unshare switch
      xfs: fix more xfs_db open-coding instances

Eric Biggers (1):
      generic/314: remove from acl group

Eryu Guan (1):
      xfs/054: only filter ROOT_INO at the beginning

Xiao Yang (1):
      xfs: remove the device parameter from __populate_check_xfs_dir

 common/quota           |  4 +--
 common/rc              | 21 ++++++++++-----
 common/reflink         | 26 +++++++++---------
 src/seek_sanity_test.c | 41 +++++++++++++++++++++++-----
 src/t_truncate_self.c  |  7 +++--
 tests/generic/043      |  2 +-
 tests/generic/044      |  4 +--
 tests/generic/045      |  4 +--
 tests/generic/046      |  4 +--
 tests/generic/047      |  2 +-
 tests/generic/048      |  2 +-
 tests/generic/049      |  2 +-
 tests/generic/156      | 16 +++++------
 tests/generic/176      |  2 +-
 tests/generic/224      |  4 +--
 tests/generic/264      |  4 +--
 tests/generic/389      | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/389.out  |  6 +++++
 tests/generic/group    |  3 ++-
 tests/overlay/013      |  3 +--
 tests/overlay/013.out  |  2 +-
 tests/xfs/004          |  2 +-
 tests/xfs/007          |  8 +++---
 tests/xfs/021          |  4 +--
 tests/xfs/044          |  2 +-
 tests/xfs/052          |  2 +-
 tests/xfs/054          | 14 +++++-----
 tests/xfs/099          |  2 +-
 tests/xfs/100          |  2 +-
 tests/xfs/101          |  2 +-
 tests/xfs/102          |  2 +-
 tests/xfs/105          |  2 +-
 tests/xfs/109          |  4 +--
 tests/xfs/112          |  2 +-
 tests/xfs/113          |  2 +-
 tests/xfs/114          |  4 +--
 tests/xfs/116          |  4 +--
 tests/xfs/132          | 12 ++++-----
 tests/xfs/136          |  6 ++---
 tests/xfs/184          |  3 ++-
 tests/xfs/190          |  4 +--
 tests/xfs/192          |  3 ++-
 tests/xfs/199          |  6 ++---
 tests/xfs/200          |  3 ++-
 tests/xfs/201          |  2 +-
 tests/xfs/204          |  3 ++-
 tests/xfs/229          |  2 +-
 tests/xfs/250          |  2 +-
 tests/xfs/278          | 16 +++++------
 tests/xfs/291          |  4 +--
 tests/xfs/307          | 21 ++++++++-------
 tests/xfs/308          | 21 ++++++++-------
 tests/xfs/328          |  2 +-
 tests/xfs/344          |  3 ++-
 tests/xfs/345          |  3 ++-
 tests/xfs/346          |  3 ++-
 tests/xfs/347          |  3 ++-
 57 files changed, 267 insertions(+), 144 deletions(-)
--
Eryu Guan
eguan@redhat.com
