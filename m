Received: from mx1.redhat.com ([209.132.183.28]:45600 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751022AbcJHHYV (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 8 Oct 2016 03:24:21 -0400
Message-Id: <201610080724.u987OJnP008694@int-mx11.intmail.prod.int.phx2.redhat.com>
Date: Sat, 08 Oct 2016 15:24:19 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: [GIT PULL] fstests: updates on 2016-10-08
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
List-ID: <fstests@vger.kernel.org>

Hi Dave,

Can you please pull the fstests update from the location below? This is a big
update which contains patches from last two weeks. It has new tests and fixes
for rmap/reflink tests from Darrick, new generic and XFS tests and other misc
bug fixes.

I didn't see any new failures in this update when testing with latest Linus
tree and xfsprogs.

Thanks,
Eryu

The following changes since commit 0bbd20b104765c75faaf8e28a54c32df505ce7fd:

  btrfs: test free space tree mount options (2016-09-24 00:39:13 +0800)

are available in the git repository at:

  https://github.com/guaneryu/xfstests.git for-dave

for you to fetch changes up to c61fa13e94513c15340a1891282e2513bdd087e1:

  xfs: renumber tests after merge (2016-10-08 14:02:04 +0800)

----------------------------------------------------------------

fstests: update on 2016-10-08

This update contains:
o A new generic log recovery test, new xfs_io inode command test
o New tests and fixes for rmap/reflink tests
o Other minor fixes all around the tree

----------------------------------------------------------------
Brian Foster (1):
      generic: shutdown fs after log recovery

Darrick J. Wong (8):
      xfs/122: decrease the log update done item sizes
      xfs/130: don't modify files after failed mount
      xfs/207,327: fsxattr no longer has the reflink flag
      fstests: use get_block_size helper
      xfs: fix $XFS_DB_PROG usage
      xfs: more rmapbt tests
      xfs: test realtime rmapbt code
      xfs: check copy-on-write fragmentation

David Disseldorp (1):
      fsx: fix compiler warning due to bad prototype

Eric Sandeen (1):
      xfs: exercise and validate the xfs_io inode command

Eryu Guan (5):
      generic/317: use id to get user id
      generic/052: use _check_scratch_fs not _xfs_check
      xfs/287: fix wrong seq number in test
      generic/349,350,351: remove from quick group
      xfs: renumber tests after merge

Theodore Ts'o (1):
      generic/361: require that file system uses a real block device

Zorro Lang (1):
      xfs/032: test the next block size if mkfs fails

 common/populate       | 100 ++++++++++++++++++++++------------------------
 common/rc             |  11 ++++--
 ltp/fsx.c             |  20 ++++------
 tests/generic/052     |   2 +-
 tests/generic/150     |   2 +-
 tests/generic/151     |   2 +-
 tests/generic/152     |   2 +-
 tests/generic/153     |   2 +-
 tests/generic/154     |   2 +-
 tests/generic/155     |   2 +-
 tests/generic/156     |   2 +-
 tests/generic/157     |   2 +-
 tests/generic/158     |   2 +-
 tests/generic/159     |   2 +-
 tests/generic/160     |   2 +-
 tests/generic/171     |   2 +-
 tests/generic/173     |   2 +-
 tests/generic/174     |   2 +-
 tests/generic/175     |   2 +-
 tests/generic/176     |   2 +-
 tests/generic/205     |   2 +-
 tests/generic/206     |   2 +-
 tests/generic/216     |   2 +-
 tests/generic/217     |   2 +-
 tests/generic/218     |   2 +-
 tests/generic/220     |   2 +-
 tests/generic/222     |   2 +-
 tests/generic/227     |   2 +-
 tests/generic/229     |   2 +-
 tests/generic/238     |   2 +-
 tests/generic/242     |   2 +-
 tests/generic/243     |   2 +-
 tests/generic/296     |   2 +-
 tests/generic/297     |   2 +-
 tests/generic/298     |   2 +-
 tests/generic/301     |   2 +-
 tests/generic/302     |   2 +-
 tests/generic/317     |   2 +-
 tests/generic/361     |   1 +
 tests/generic/388     |  89 +++++++++++++++++++++++++++++++++++++++++
 tests/generic/388.out |   2 +
 tests/generic/group   |   7 ++--
 tests/xfs/001         |  16 ++++----
 tests/xfs/002         |   4 +-
 tests/xfs/032         |   5 +++
 tests/xfs/054         | 104 ++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/054.out     |  13 ++++++
 tests/xfs/070         |   4 +-
 tests/xfs/077         |   6 +--
 tests/xfs/086         |   2 +-
 tests/xfs/087         |   2 +-
 tests/xfs/088         |   2 +-
 tests/xfs/089         |   2 +-
 tests/xfs/091         |   2 +-
 tests/xfs/093         |   2 +-
 tests/xfs/097         |   2 +-
 tests/xfs/098         |   4 +-
 tests/xfs/099         |   2 +-
 tests/xfs/100         |   4 +-
 tests/xfs/101         |   2 +-
 tests/xfs/102         |   4 +-
 tests/xfs/105         |   4 +-
 tests/xfs/111         |   2 +-
 tests/xfs/112         |   4 +-
 tests/xfs/113         |   4 +-
 tests/xfs/117         |   2 +-
 tests/xfs/120         |   2 +-
 tests/xfs/122.out     |   6 +--
 tests/xfs/123         |   2 +-
 tests/xfs/124         |  10 ++---
 tests/xfs/125         |   8 ++--
 tests/xfs/126         |  10 ++---
 tests/xfs/127         |   2 +-
 tests/xfs/128         |   2 +-
 tests/xfs/129         |   2 +-
 tests/xfs/130         |  13 +++---
 tests/xfs/130.out     |   1 -
 tests/xfs/132         |   2 +-
 tests/xfs/135         |   2 +-
 tests/xfs/137         |   6 +--
 tests/xfs/139         |   2 +-
 tests/xfs/140         |   2 +-
 tests/xfs/169         |   2 +-
 tests/xfs/179         |  10 ++---
 tests/xfs/180         |   2 +-
 tests/xfs/182         |   2 +-
 tests/xfs/184         |   2 +-
 tests/xfs/186         |   8 ++--
 tests/xfs/187         |  14 +++----
 tests/xfs/192         |   2 +-
 tests/xfs/193         |   2 +-
 tests/xfs/198         |   2 +-
 tests/xfs/200         |   2 +-
 tests/xfs/204         |   2 +-
 tests/xfs/207.out     |   4 +-
 tests/xfs/208         |   2 +-
 tests/xfs/211         |   2 +-
 tests/xfs/215         |   2 +-
 tests/xfs/218         |   2 +-
 tests/xfs/219         |   2 +-
 tests/xfs/221         |   2 +-
 tests/xfs/223         |   2 +-
 tests/xfs/224         |   2 +-
 tests/xfs/225         |   2 +-
 tests/xfs/226         |   2 +-
 tests/xfs/228         |   2 +-
 tests/xfs/230         |   2 +-
 tests/xfs/231         |   2 +-
 tests/xfs/232         |   2 +-
 tests/xfs/233         |   2 +-
 tests/xfs/234         |   2 +-
 tests/xfs/235         |   4 +-
 tests/xfs/236         |   2 +-
 tests/xfs/265         |   2 +-
 tests/xfs/287         |   7 ++--
 tests/xfs/298         |   2 +-
 tests/xfs/309         |   2 +-
 tests/xfs/310         |   4 +-
 tests/xfs/327.out     |   6 +--
 tests/xfs/328         |   2 +-
 tests/xfs/331         |  78 ++++++++++++++++++++++++++++++++++++
 tests/xfs/331.out     |   4 ++
 tests/xfs/332         |  92 +++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/332.out     |  10 +++++
 tests/xfs/333         |  83 +++++++++++++++++++++++++++++++++++++++
 tests/xfs/333.out     |   9 +++++
 tests/xfs/334         |  67 +++++++++++++++++++++++++++++++
 tests/xfs/334.out     |   7 ++++
 tests/xfs/335         |  89 +++++++++++++++++++++++++++++++++++++++++
 tests/xfs/335.out     |   7 ++++
 tests/xfs/336         |  97 +++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/336.out     |   8 ++++
 tests/xfs/337         | 106 +++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/337.out     |  11 ++++++
 tests/xfs/338         |  75 +++++++++++++++++++++++++++++++++++
 tests/xfs/338.out     |   7 ++++
 tests/xfs/339         |  83 +++++++++++++++++++++++++++++++++++++++
 tests/xfs/339.out     |   9 +++++
 tests/xfs/340         |  80 +++++++++++++++++++++++++++++++++++++
 tests/xfs/340.out     |   7 ++++
 tests/xfs/341         |  98 +++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/341.out     |   7 ++++
 tests/xfs/342         |  99 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/342.out     |   7 ++++
 tests/xfs/343         |  81 ++++++++++++++++++++++++++++++++++++++
 tests/xfs/343.out     |   6 +++
 tests/xfs/344         | 104 ++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/344.out     |  10 +++++
 tests/xfs/345         | 102 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/345.out     |  10 +++++
 tests/xfs/346         | 107 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/346.out     |  10 +++++
 tests/xfs/347         | 106 +++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/347.out     |  10 +++++
 tests/xfs/group       |  18 +++++++++
 155 files changed, 2151 insertions(+), 240 deletions(-)
--
Eryu Guan
eguan@redhat.com
