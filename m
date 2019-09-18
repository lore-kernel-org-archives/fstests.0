Received: from mail-pl1-f181.google.com ([209.85.214.181]:43251 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbfIRLp7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 18 Sep 2019 07:45:59 -0400
From: kaixuxia <xiakaixu1987@gmail.com>
Subject: [PATCH v3 0/2] xfstests: add deadlock between the AGI and AGF with
 RENAME_WHITEOUT test
Message-ID: <6e7e5cd2-76c1-6d4c-4b99-a166f6d26408@gmail.com>
Date: Wed, 18 Sep 2019 19:45:56 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-xfs@vger.kernel.org, "Darrick J. Wong" <darrick.wong@oracle.com>, Eryu Guan <guaneryu@gmail.com>, newtongao@tencent.com, jasperwang@tencent.com
List-ID: <fstests@vger.kernel.org>

There is ABBA deadlock bug between the AGI and AGF when performing
rename() with RENAME_WHITEOUT flag, so add test to check that whether
the rename() call works well. This test require a special rename flag,
so add support check for if a given rename flag is supported in
_requires_renameat2.

kaixuxia (2):
  common: check if a given rename flag is supported in
    _requires_renameat2
  xfs: test the deadlock between the AGI and AGF with RENAME_WHITEOUT

 common/renameat2  | 30 ++++++++++++++++-
 tests/generic/024 | 13 ++------
 tests/generic/025 | 13 ++------
 tests/generic/078 | 13 ++------
 tests/xfs/512     | 96 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/512.out |  2 ++
 tests/xfs/group   |  1 +
 7 files changed, 137 insertions(+), 31 deletions(-)
 create mode 100755 tests/xfs/512
 create mode 100644 tests/xfs/512.out

-- 
1.8.3.1

-- 
kaixuxia
