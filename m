Received: from mail-wr0-f196.google.com ([209.85.128.196]:46622 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751008AbeC2MFg (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 29 Mar 2018 08:05:36 -0400
From: Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v2 0/5] Yet another overlayfs exportfs test
Date: Thu, 29 Mar 2018 15:06:45 +0300
Message-Id: <1522325210-17900-1-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Eryu,

I fixed your review comments.
Separated the -h fix patch and added a re-send of the
fix commit documentation fix to the series.

Thanks,
Amir.

Amir Goldstein (5):
  overlay/[054,055]: Document the fix commit
  open_by_handle: make -h (help) a valid option
  open_by_handle: add -n option to suppress drop caches
  open_by_handle: add -s option to sleep and keep files open by handle
  overlay: test decoding overlay file handles with warm/cold dentry
    cache

 src/open_by_handle.c  |  59 +++++++++++++++-------
 tests/overlay/054     |   3 ++
 tests/overlay/055     |   3 ++
 tests/overlay/058     | 137 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/overlay/058.out |   9 ++++
 tests/overlay/group   |   1 +
 6 files changed, 194 insertions(+), 18 deletions(-)
 create mode 100755 tests/overlay/058
 create mode 100644 tests/overlay/058.out

-- 
2.7.4

