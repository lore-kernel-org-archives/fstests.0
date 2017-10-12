Received: from mail-wm0-f67.google.com ([74.125.82.67]:52905 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751434AbdJLOyU (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 12 Oct 2017 10:54:20 -0400
Received: by mail-wm0-f67.google.com with SMTP id k4so14132981wmc.1
        for <fstests@vger.kernel.org>; Thu, 12 Oct 2017 07:54:20 -0700 (PDT)
From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH v2 0/3] generalize AIO/DIO dmesg filter
Date: Thu, 12 Oct 2017 16:54:01 +0200
Message-Id: <1507820044-2161-1-git-send-email-idryomov@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Lukas Czerner <lczerner@redhat.com>
List-ID: <fstests@vger.kernel.org>

With upstream commit 332391a9935d ("fs: Fix page cache inconsistency
when mixing buffered and AIO DIO"), we need to whitelist dio_complete()
for ext4 pretty much everywhere iomap_dio_complete() and friends are
whitelisted for xfs.

v1 -> v2:
- _filter_aiodio_dmesg() now lives in common/filter

Thanks,

                Ilya


Ilya Dryomov (3):
  common: move _filter_xfs_dmesg() to common/filter
  common: turn _filter_xfs_dmesg() into _filter_aiodio_dmesg()
  generic/036,208: whitelist [iomap_]dio_complete() WARNs

 common/filter     | 25 +++++++++++++++++++++++++
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

