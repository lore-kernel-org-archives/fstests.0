Received: from mail-wr0-f195.google.com ([209.85.128.195]:40413 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751780AbeENFsa (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 14 May 2018 01:48:30 -0400
From: Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH 0/3] ext4 freeze regression test
Date: Mon, 14 May 2018 08:49:48 +0300
Message-Id: <1526276991-23897-1-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: Theodore Ts'o <tytso@mit.edu>, fstests@vger.kernel.org, linux-ext4@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Eryu,

This is a regression test for a fix waiting in Ted's dev branch
preceded by two minor cleanups.

FYI, at the moment, all _require_freeze tests fail with lockdep enabled
because of DEBUG_RWSEMS:
https://marc.info/?l=linux-fsdevel&m=152622016219975&w=2

Thanks,
Amir.

Amir Goldstein (3):
  generic/459: use xfs_freeze instead of fsfreeze
  fstests: define and use TIMEOUT_PROG
  generic: test first read with freeze right after mount

 common/config         |  1 +
 tests/generic/297     |  4 +--
 tests/generic/298     |  4 +--
 tests/generic/459     |  6 ++---
 tests/generic/488     | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/488.out |  2 ++
 tests/generic/group   |  1 +
 7 files changed, 86 insertions(+), 7 deletions(-)
 create mode 100755 tests/generic/488
 create mode 100644 tests/generic/488.out

-- 
2.7.4

