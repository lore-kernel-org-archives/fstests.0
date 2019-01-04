Received: from szxga06-in.huawei.com ([45.249.212.32]:44280 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725931AbfADIQC (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 4 Jan 2019 03:16:02 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3C3E69B9DF154
        for <fstests@vger.kernel.org>; Fri,  4 Jan 2019 16:15:59 +0800 (CST)
From: Hou Tao <houtao1@huawei.com>
Subject: [PATCH v2 0/2] tiny fixes for xfstests
Date: Fri, 4 Jan 2019 16:19:25 +0800
Message-ID: <20190104081927.112622-1-houtao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: houtao1@huawei.com
List-ID: <fstests@vger.kernel.org>

Hou Tao (2):
  generic/131: wait until the server is ready or timeout
  fsx: check ENOSYS in test_copy_range() & test_fallocate()

 ltp/fsx.c         |  5 +++--
 tests/generic/131 | 15 ++++++++++++---
 2 files changed, 15 insertions(+), 5 deletions(-)

-- 
2.16.2.dirty
