Received: from mail-pf0-f174.google.com ([209.85.192.174]:36061 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758054AbcGZUjg (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 26 Jul 2016 16:39:36 -0400
Received: by mail-pf0-f174.google.com with SMTP id h186so3058672pfg.3
        for <fstests@vger.kernel.org>; Tue, 26 Jul 2016 13:39:36 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
Subject: [PATCH] generic/294: fix _filter_mknod quoting
Date: Tue, 26 Jul 2016 13:39:26 -0700
Message-Id: <efc1c8a69bb7d09412342841e340b51a709dee63.1469565411.git.osandov@fb.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: kernel-team@fb.com
List-ID: <fstests@vger.kernel.org>

From: Omar Sandoval <osandov@fb.com>

Coreutils 8.4 uses a back tick instead of a single quote when quoting a
file name. That means that _filter_mknod doesn't properly filter the
error message from mknod.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 common/filter | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/filter b/common/filter
index 8d9f489bea1c..886ab6deae55 100644
--- a/common/filter
+++ b/common/filter
@@ -389,7 +389,7 @@ _filter_od()
 # mknod errors print unquoted filenames
 _filter_mknod()
 {
-	sed -e "s/mknod: '\(.*\)': File exists/mknod: \1: File exists/"
+	sed -e "s/mknod: ['\`]\(.*\)': File exists/mknod: \1: File exists/"
 }
 
 # make sure this script returns success
-- 
2.9.0

