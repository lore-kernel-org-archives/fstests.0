Received: from mx1.redhat.com ([209.132.183.28]:34110 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750826AbdI2CUO (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 28 Sep 2017 22:20:14 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4AEA1C057F93
        for <fstests@vger.kernel.org>; Fri, 29 Sep 2017 02:20:14 +0000 (UTC)
From: Xiong Zhou <xzhou@redhat.com>
Subject: [PATCH 0/2] two trivial fixes
Date: Fri, 29 Sep 2017 10:20:01 +0800
Message-Id: <1506651603-21876-1-git-send-email-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: eguan@redhat.com, Xiong Zhou <xzhou@redhat.com>
List-ID: <fstests@vger.kernel.org>

sort src/ binary names in gitignore.
add new group dax for DAX related tests.

Xiong Zhou (2):
  tests: add new group dax
  gitignore: sort src/ binaries name

 .gitignore          | 24 ++++++++++++------------
 tests/generic/group |  8 ++++----
 tests/xfs/group     |  2 +-
 3 files changed, 17 insertions(+), 17 deletions(-)

-- 
1.8.3.1

