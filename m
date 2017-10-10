Received: from mail-wm0-f65.google.com ([74.125.82.65]:53013 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751385AbdJJOz1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 10 Oct 2017 10:55:27 -0400
Received: by mail-wm0-f65.google.com with SMTP id k4so6162142wmc.1
        for <fstests@vger.kernel.org>; Tue, 10 Oct 2017 07:55:26 -0700 (PDT)
From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 0/3] generalize AIO/DIO dmesg filter
Date: Tue, 10 Oct 2017 16:54:55 +0200
Message-Id: <1507647298-9971-1-git-send-email-idryomov@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Lukas Czerner <lczerner@redhat.com>
List-ID: <fstests@vger.kernel.org>

With upstream commit 332391a9935d ("fs: Fix page cache inconsistency
when mixing buffered and AIO DIO"), we need to whitelist dio_complete()
for ext4 pretty much everywhere iomap_dio_complete() and friends are
whitelisted for xfs.

Thanks,

                Ilya


Ilya Dryomov (3):
  common/rc: move _filter_xfs_dmesg() to common/rc
  common/rc: turn _filter_xfs_dmesg() into _filter_aiodio_dmesg()
  generic/036,208: whitelist [iomap_]dio_complete() WARNs

 common/rc         | 25 +++++++++++++++++++++++++
 common/xfs        | 22 ----------------------
 tests/generic/036 |  2 ++
 tests/generic/095 |  7 ++-----
 tests/generic/208 |  2 ++
 tests/generic/224 |  9 +++------
 tests/generic/247 |  9 +++------
 tests/generic/446 |  9 +++------
 8 files changed, 40 insertions(+), 45 deletions(-)

-- 
2.4.3

