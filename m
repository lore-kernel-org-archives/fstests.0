Received: from szxga06-in.huawei.com ([45.249.212.32]:35510 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725616AbfBTBz7 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 19 Feb 2019 20:55:59 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id CDA871FE771470DC44A5
        for <fstests@vger.kernel.org>; Wed, 20 Feb 2019 09:55:57 +0800 (CST)
From: Yufen Yu <yuyufen@huawei.com>
Subject: [PATCH 0/5] define common _get_max_file_size function 
Date: Wed, 20 Feb 2019 09:59:50 +0800
Message-ID: <20190220015955.26342-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

We define a new function _get_max_file_size, and let generic/299,
351, 349 use this.

Yufen Yu (5):
  commom/rc: define function _get_max_file_size
  generic/299: limit max file size
  generic/351: use the common function _get_max_file_size
  generic/349: use the common function _get_max_file_size
  generic/350: use the common function _get_max_file_size

 common/rc         | 23 +++++++++++++++++++++++
 tests/generic/299 |  5 +++++
 tests/generic/349 | 13 ++-----------
 tests/generic/350 | 13 ++-----------
 tests/generic/351 | 13 ++-----------
 5 files changed, 34 insertions(+), 33 deletions(-)

-- 
2.16.2.dirty
