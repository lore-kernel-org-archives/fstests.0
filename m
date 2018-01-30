Received: from mx2.mpynet.fi ([82.197.21.85]:64916 "EHLO mx2.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751826AbeA3NzX (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 30 Jan 2018 08:55:23 -0500
From: Rostislav Skudnov <rostislav@tuxera.com>
Subject: [PATCH 1/2] generic/307: Require ACL support
Date: Tue, 30 Jan 2018 13:54:58 +0000
Message-ID: <1517320499-14714-2-git-send-email-rostislav@tuxera.com>
In-Reply-To: <1517320499-14714-1-git-send-email-rostislav@tuxera.com>
References: <1517320499-14714-1-git-send-email-rostislav@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Signed-off-by: Rostislav Skudnov <rostislav@tuxera.com>
---
 tests/generic/307 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/generic/307 b/tests/generic/307
index f5d0680..bbdc70f 100755
--- a/tests/generic/307
+++ b/tests/generic/307
@@ -51,6 +51,7 @@ testfile=$SCRATCH_MNT/testfile.$seq
 _supported_fs generic
 _supported_os Linux
 _require_scratch
+_require_acls
 
 echo "Silence is golden"
 
-- 
2.1.4

