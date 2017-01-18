Received: from mail-pg0-f65.google.com ([74.125.83.65]:36709 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751204AbdARKdK (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 18 Jan 2017 05:33:10 -0500
Received: by mail-pg0-f65.google.com with SMTP id 75so1082395pgf.3
        for <fstests@vger.kernel.org>; Wed, 18 Jan 2017 02:33:09 -0800 (PST)
From: Kinglong Mee <kinglongmee@gmail.com>
Subject: [PATCH] README: fix the typo of local.config.example
Message-ID: <83ca1aaa-7f30-bece-87e1-4faab1ebdc72@gmail.com>
Date: Wed, 18 Jan 2017 18:33:03 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>, fstests@vger.kernel.org
Cc: sandeen@redhat.com, Kinglong Mee <kinglongmee@gmail.com>
List-ID: <fstests@vger.kernel.org>

Commit b7d908a0e8eb "README: document Fedora, RHEL, and
 CentOS dependencies" adds a typo of local.config.example 
to config.local.example, fix it.

Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
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
2.9.3

