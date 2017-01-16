Received: from p3nlsmtpcp01-03.prod.phx3.secureserver.net ([184.168.200.142]:44652
        "EHLO p3nlsmtpcp01-03.prod.phx3.secureserver.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751128AbdAPXQL (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 16 Jan 2017 18:16:11 -0500
Received: from [103.60.72.133] (port=42812 helo=giis.co.in)
        by p3plcpnl0639.prod.phx3.secureserver.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.87)
        (envelope-from <Lakshmipathi.G@giis.co.in>)
        id 1cTGTI-0001zZ-6C
        for fstests@vger.kernel.org; Mon, 16 Jan 2017 16:13:52 -0700
Date: Tue, 17 Jan 2017 04:43:41 +0530
From: "Lakshmipathi.G" <Lakshmipathi.G@giis.co.in>
Subject: [PATCH] README: Fix Quick start typo
Message-ID: <20170116231341.GA866@giis.co.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Signed-off-by: Lakshmipathi.G <Lakshmipathi.G@giis.co.in>
---
 README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/README b/README
index 400e902..f788e71 100644
--- a/README
+++ b/README
@@ -63,7 +63,7 @@ Preparing system for tests (IRIX and Linux):
               
     - setup your environment
 	Quick start:
-	- copy config.local.example to config.local and edit as needed
+	- copy local.config.example to local.config and edit as needed
 	Or:
         - setenv TEST_DEV "device containing TEST PARTITION"
         - setenv TEST_DIR "mount point of TEST PARTITION"   
-- 
2.7.4

