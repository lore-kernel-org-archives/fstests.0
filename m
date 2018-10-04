Received: from mx1.redhat.com ([209.132.183.28]:55094 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727394AbeJEAVr (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 4 Oct 2018 20:21:47 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4226D3083395
        for <fstests@vger.kernel.org>; Thu,  4 Oct 2018 17:27:33 +0000 (UTC)
Received: from [IPv6:::1] (ovpn04.gateway.prod.ext.phx2.redhat.com [10.5.9.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E8511347D
        for <fstests@vger.kernel.org>; Thu,  4 Oct 2018 17:27:32 +0000 (UTC)
From: Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH] xfs/122: add struct xfs_unmount_log_format
Message-ID: <b1f2c982-8a23-b19b-b94d-e52470fdf5d4@redhat.com>
Date: Thu, 4 Oct 2018 12:27:32 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

struct xfs_unmount_log_format used to be anonymous and gained a name
in 4.19, so add that to the list of expected structures in xfs/122.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/tests/xfs/122.out b/tests/xfs/122.out
index ad9a0555..92fb46ae 100644
--- a/tests/xfs/122.out
+++ b/tests/xfs/122.out
@@ -98,6 +98,7 @@ sizeof(struct xfs_rtrmap_root) = 4
 sizeof(struct xfs_rud_log_format) = 16
 sizeof(struct xfs_rui_log_format) = 16
 sizeof(struct xfs_scrub_metadata) = 64
+sizeof(struct xfs_unmount_log_format) = 8
 sizeof(xfs_agf_t) = 224
 sizeof(xfs_agfl_t) = 36
 sizeof(xfs_agi_t) = 336
