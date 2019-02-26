Received: from szxga06-in.huawei.com ([45.249.212.32]:41594 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725977AbfBZOHp (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 26 Feb 2019 09:07:45 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CDC4EBDDDAAF645BE3D5
        for <fstests@vger.kernel.org>; Tue, 26 Feb 2019 22:07:42 +0800 (CST)
From: Yufen Yu <yuyufen@huawei.com>
Subject: [PATCH v2 0/2] define common get_max_file_size function
Date: Tue, 26 Feb 2019 22:11:52 +0800
Message-ID: <20190226141154.142271-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: guaneryu@gmail.com
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

We move get_max_file_size from generic/485 to common rc,
and add max filesize limit to generic/299.

In addition, we pick up the common function get_max_lfs_filesize()
from generic/349, 350, 351 to make code more concise.

Yufen Yu (2):
  commom/rc: use the common function get_max_file_size
  common/rc: add get_max_lfs_filesize to return MAX_LFS_FILESIZE

 common/rc         | 39 +++++++++++++++++++++++++++++++++++++++
 tests/generic/299 |  5 +++++
 tests/generic/349 | 12 +-----------
 tests/generic/350 | 12 +-----------
 tests/generic/351 | 12 +-----------
 tests/generic/485 | 23 -----------------------
 6 files changed, 47 insertions(+), 56 deletions(-)

-- 
2.16.2.dirty
