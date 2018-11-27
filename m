Received: from mail-pf1-f194.google.com ([209.85.210.194]:33103 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbeK1Iml (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 28 Nov 2018 03:42:41 -0500
Received: by mail-pf1-f194.google.com with SMTP id c123so8347525pfb.0
        for <fstests@vger.kernel.org>; Tue, 27 Nov 2018 13:43:25 -0800 (PST)
From: Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 0/3] Adapt some tests to ChromeOS
Date: Tue, 27 Nov 2018 13:43:05 -0800
Message-Id: <20181127214308.137410-1-gwendal@chromium.org>
Sender: fstests-owner@vger.kernel.org
To: guaneryu@gmail.com
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

When running xfstests on ChromeOS, some were failing for spurious
reasons:
- getconf not present on the test system because glibc is not installed.
- ftruncate want to allocate a file bigger than the partition.
- Attribute selinux.security in the way of testing xattr.

Gwendal Grignou (3):
  generic: workaround device where glibc is not installed
  ext4: 032: fail nicely if the test partition is not big enough for the
    test
  generic: exclude selinux xattr form being considered

 common/config     | 18 ++++++++++++++++++
 common/filter     |  1 +
 common/rc         |  6 ------
 tests/btrfs/053   |  2 +-
 tests/ext4/032    | 11 ++++++++++-
 tests/generic/062 |  2 +-
 tests/generic/205 |  2 +-
 tests/generic/206 |  2 +-
 tests/generic/216 |  2 +-
 tests/generic/217 |  2 +-
 tests/generic/218 |  2 +-
 tests/generic/220 |  2 +-
 tests/generic/222 |  2 +-
 tests/generic/227 |  2 +-
 tests/generic/229 |  2 +-
 tests/generic/238 |  2 +-
 tests/generic/349 |  6 +++---
 tests/generic/350 |  6 +++---
 tests/generic/351 |  6 +++---
 tests/generic/377 |  2 +-
 20 files changed, 51 insertions(+), 29 deletions(-)

-- 
2.18.1
