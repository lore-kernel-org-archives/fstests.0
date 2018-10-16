Received: from szxga04-in.huawei.com ([45.249.212.190]:14078 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726729AbeJPPVm (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 16 Oct 2018 11:21:42 -0400
From: "zhangyi (F)" <yi.zhang@huawei.com>
Subject: [PATCH v2 0/4] overlay: enhance fsck.overlay test cases
Date: Tue, 16 Oct 2018 15:45:55 +0800
Message-ID: <20181016074559.24728-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org, amir73il@gmail.com
Cc: guaneryu@gmail.com, miklos@szeredi.hu, yi.zhang@huawei.com, miaoxie@huawei.com
List-ID: <fstests@vger.kernel.org>

Hi all,

These are the second version of fsck.overlay[1] program related patch set
(the first one was posted about two mounths ago[2], sorry for the late).
I have fix all comments as Amir suggested and looks fine after test.

The first two patches correct the exit code and fix the tests failure
with master branch of fsck.overlay, and the last two patches were just
want to test stability and exception handling processes.

Hi Amir,

Patch 1 and 2 will fix the test failure you mentioned yesterday when you
run -g overlay/fsck with fsck.overlay's master branch. I am very grateful
if you can give a review.

Thanks,
Yi.

Changes from v1:
 - split patch 2 from patch 1 for readable.
 - move exit code definitions from common/config to common/overlay.
 - factor out a common function _run_check_fsck() to fsck and check
   return value.
 - fix some mistakes in patch 3 and 4.

[1] https://github.com/hisilicon/overlayfs-progs/commits/master
[2] https://www.spinics.net/lists/fstests/msg10267.html

zhangyi (F) (4):
  overlay: correct fsck.overlay exit code
  overlay: fix exit code for some fsck.overlay valid cases
  overlay: add fsck.overlay stress test
  overlay: add fsck.overlay exception tests

 common/overlay        |  37 ++++++++-
 tests/overlay/045     |  46 ++++++-----
 tests/overlay/046     |  49 ++++++------
 tests/overlay/056     |   9 +--
 tests/overlay/062     |  84 +++++++++++++++++++
 tests/overlay/062.out |   2 +
 tests/overlay/063     | 217 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/overlay/063.out |  10 +++
 tests/overlay/group   |   2 +
 9 files changed, 403 insertions(+), 53 deletions(-)
 create mode 100755 tests/overlay/062
 create mode 100644 tests/overlay/062.out
 create mode 100755 tests/overlay/063
 create mode 100644 tests/overlay/063.out

-- 
2.5.0
