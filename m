Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:34974 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751294AbeCWGRX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 23 Mar 2018 02:17:23 -0400
From: Eryu Guan <eguan@linux.alibaba.com>
Subject: [PATCH] README: add gdbm-devel in prerequisite package list for Fedora/RHEL
Date: Fri, 23 Mar 2018 14:16:58 +0800
Message-Id: <20180323061658.23648-1-eguan@linux.alibaba.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@linux.alibaba.com>
List-ID: <fstests@vger.kernel.org>

gdbm-devel is needed to build src/dbtest, libgdbm-dev is listed as
prerequisite package for Ubuntu, let's add it for Fedora/RHEL too.

Signed-off-by: Eryu Guan <eguan@linux.alibaba.com>
---
 README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/README b/README
index 50c68afaf0c2..ba24627f3e45 100644
--- a/README
+++ b/README
@@ -12,7 +12,7 @@ _______________________
   For Fedora, RHEL, or CentOS:
 	yum install acl attr automake bc dbench dump e2fsprogs fio \
 	gawk gcc indent libtool lvm2 make psmisc quota sed \
-	xfsdump xfsprogs \
+	xfsdump xfsprogs gdbm-devel \
 	libacl-devel libattr-devel libaio-devel libuuid-devel \
 	xfsprogs-devel btrfs-progs-devel python sqlite
 	(Older distributions may require xfsprogs-qa-devel as well.)
-- 
2.14.3

