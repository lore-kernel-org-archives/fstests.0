Received: from mail-it1-f179.google.com ([209.85.166.179]:37752 "EHLO
        mail-it1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728140AbeKCGi5 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 3 Nov 2018 02:38:57 -0400
Received: by mail-it1-f179.google.com with SMTP id e74-v6so5075965ita.2
        for <fstests@vger.kernel.org>; Fri, 02 Nov 2018 14:30:10 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
Subject: [PATCH 0/7] fstests: test Btrfs swapfile support
Date: Fri,  2 Nov 2018 14:29:35 -0700
Message-Id: <cover.1541193856.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: kernel-team@fb.com, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Omar Sandoval <osandov@fb.com>

This series fixes a couple of generic swapfile tests and adds some
Btrfs-specific swapfile tests. Btrfs swapfile support is scheduled for
4.21 [1].

1: https://www.spinics.net/lists/linux-btrfs/msg83454.html

Thanks!

Omar Sandoval (7):
  generic/{472,496,497}: fix $seeqres typo
  generic/{472,496}: fix swap file creation on Btrfs
  btrfs: test swap file activation restrictions
  btrfs: test invalid operations on a swap file
  btrfs: test swap files on multiple devices
  btrfs: test device add/remove/replace with an active swap file
  btrfs: test balance and resize with an active swap file

 tests/btrfs/173     | 55 ++++++++++++++++++++++++++++++
 tests/btrfs/173.out |  5 +++
 tests/btrfs/174     | 66 ++++++++++++++++++++++++++++++++++++
 tests/btrfs/174.out | 10 ++++++
 tests/btrfs/175     | 73 ++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/175.out |  8 +++++
 tests/btrfs/176     | 82 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/176.out |  5 +++
 tests/btrfs/177     | 64 +++++++++++++++++++++++++++++++++++
 tests/btrfs/177.out |  6 ++++
 tests/btrfs/group   |  5 +++
 tests/generic/472   | 16 ++++-----
 tests/generic/496   |  8 ++---
 tests/generic/497   |  2 +-
 14 files changed, 391 insertions(+), 14 deletions(-)
 create mode 100755 tests/btrfs/173
 create mode 100644 tests/btrfs/173.out
 create mode 100755 tests/btrfs/174
 create mode 100644 tests/btrfs/174.out
 create mode 100755 tests/btrfs/175
 create mode 100644 tests/btrfs/175.out
 create mode 100755 tests/btrfs/176
 create mode 100644 tests/btrfs/176.out
 create mode 100755 tests/btrfs/177
 create mode 100644 tests/btrfs/177.out

-- 
2.19.1
