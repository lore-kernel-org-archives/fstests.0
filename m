Received: from mail-qt0-f194.google.com ([209.85.216.194]:32887 "EHLO
	mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751193AbcGGUJL (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 7 Jul 2016 16:09:11 -0400
Received: by mail-qt0-f194.google.com with SMTP id f89so1860610qtd.0
        for <fstests@vger.kernel.org>; Thu, 07 Jul 2016 13:09:11 -0700 (PDT)
Date: Thu, 7 Jul 2016 16:12:02 -0400
From: Eric Whitney <enwlinux@gmail.com>
Subject: [PATCH] ext4/021: add _require_metadata_journaling
Message-ID: <20160707201202.GA3195@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

An ext4 file system can be created without a journal, but ext4/021
presumes it will contain one.  Make that requirement explicit to avoid
unnecessary failures when testing "nojournal" file systems.

Signed-off-by: Eric Whitney <enwlinux@gmail.com>
---
 tests/ext4/021 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/ext4/021 b/tests/ext4/021
index 9dfd191..d758818 100755
--- a/tests/ext4/021
+++ b/tests/ext4/021
@@ -48,6 +48,7 @@ _supported_fs ext4
 _supported_os Linux
 _require_scratch
 _require_dumpe2fs
+_require_metadata_journaling $SCRATCH_DEV
 
 # 8M in bytes
 fssize=$((8 * 1024 * 1024))
-- 
2.1.4

