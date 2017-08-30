Received: from mx1.redhat.com ([209.132.183.28]:46077 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750756AbdH3G0u (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 30 Aug 2017 02:26:50 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1DDC7C047B79
        for <fstests@vger.kernel.org>; Wed, 30 Aug 2017 06:26:50 +0000 (UTC)
Received: from dhcp-12-116.nay.redhat.com (dhcp-12-116.nay.redhat.com [10.66.12.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 463B084779
        for <fstests@vger.kernel.org>; Wed, 30 Aug 2017 06:26:49 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH] xfs/095: require 512b sector size SCRATCH_DEV
Date: Wed, 30 Aug 2017 14:26:45 +0800
Message-Id: <20170830062645.17153-1-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

xfs/095 fails on 4k hard sector size device, due to it runs:

  _mkfs_log "-l version=1 -m crc=0 -d sectsize=512"

So _notrun if SCRATCH_DEV's sector size is bigger than 512b.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---
 tests/xfs/095 | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/xfs/095 b/tests/xfs/095
index 1f5a51f6..290ccf29 100755
--- a/tests/xfs/095
+++ b/tests/xfs/095
@@ -50,6 +50,10 @@ _supported_os Linux
 _require_scratch
 _require_v2log
 
+if [ "$(blockdev --getss $SCRATCH_DEV)" != "512" ]; then
+	_notrun "need 512b sector size"
+fi
+
 export MOUNT_OPTIONS="-o logbsize=64k"
 
 # try and mount a v1 log with a v2 LRsize
-- 
2.13.5

