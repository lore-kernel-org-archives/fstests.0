Received: from mga03.intel.com ([134.134.136.65]:4267 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726618AbfICVIT (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 3 Sep 2019 17:08:19 -0400
From: ira.weiny@intel.com
Subject: [PATCH 0/3] src/locktest: 3 fixes for locktest
Date: Tue,  3 Sep 2019 14:08:12 -0700
Message-Id: <20190903210815.29545-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Ira Weiny <ira.weiny@intel.com>
List-ID: <fstests@vger.kernel.org>

From: Ira Weiny <ira.weiny@intel.com>

Found these while working on adding a leasetest 

Ira Weiny (3):
  src/locktest: Remove D_flag
  src/locktest: Update test header comment
  src/locktest: Remove unused buf allocation

 src/locktest.c | 49 +++----------------------------------------------
 1 file changed, 3 insertions(+), 46 deletions(-)

-- 
2.20.1
