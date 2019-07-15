Received: from bombadil.infradead.org ([198.137.202.133]:42504 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729416AbfGOIZb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 15 Jul 2019 04:25:31 -0400
Received: from 089144194016.atnat0003.highway.a1.net ([89.144.194.16] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hmwIc-0004Ue-Lb
        for fstests@vger.kernel.org; Mon, 15 Jul 2019 08:25:31 +0000
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/3] common/cgroup2: better error message if cgroup2 fs is not mounted
Date: Mon, 15 Jul 2019 10:25:21 +0200
Message-Id: <20190715082523.18387-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Improve the _require_cgroup2 helper to print a more useful message
if the cgroup2 fs is not mounted.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 common/cgroup2 | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/common/cgroup2 b/common/cgroup2
index f89825e2..8833c9c8 100644
--- a/common/cgroup2
+++ b/common/cgroup2
@@ -4,9 +4,14 @@ export CGROUP2_PATH="${CGROUP2_PATH:-/sys/fs/cgroup}"
 
 _require_cgroup2()
 {
+	if [ `findmnt -d backward -n -o FSTYPE -f ${CGROUP2_PATH}` != "cgroup2" ]; then
+		_notrun "cgroup2 not mounted on ${CGROUP2_PATH}"
+	fi
+
 	if [ ! -f "${CGROUP2_PATH}/cgroup.subtree_control" ]; then
 		_notrun "Test requires cgroup2 enabled"
 	fi
+
 	if [[ ! $(cat ${CGROUP2_PATH}/cgroup.controllers) =~ $1 ]]; then
 		_notrun "Cgroup2 doesn't support $1 controller $1"
 	fi
-- 
2.20.1
