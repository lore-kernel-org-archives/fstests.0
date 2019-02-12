Received: from mail.kernel.org ([198.145.29.99]:53356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726685AbfBLSSn (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 12 Feb 2019 13:18:43 -0500
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C23F4222C0
        for <fstests@vger.kernel.org>; Tue, 12 Feb 2019 18:18:42 +0000 (UTC)
From: fdmanana@kernel.org
Subject: [PATCH] Fix error message when xfs handle library not found
Date: Tue, 12 Feb 2019 18:18:40 +0000
Message-Id: <20190212181840.7093-1-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Filipe Manana <fdmanana@suse.com>

The error message mentions a "make install-lib" target from xfsprogs,
however that target does not exists in xfsprogs, what exists is a
target named "install-dev". So fix that and replace "install-lib" with
"install-dev".

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 m4/package_xfslibs.m4 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/m4/package_xfslibs.m4 b/m4/package_xfslibs.m4
index 9be56e11..ad019518 100644
--- a/m4/package_xfslibs.m4
+++ b/m4/package_xfslibs.m4
@@ -83,7 +83,7 @@ AC_DEFUN([AC_PACKAGE_NEED_ATTRLIST_LIBHANDLE],
         echo
         echo 'FATAL ERROR: could not find a current XFS handle library.'
         echo 'Install or upgrade the XFS library package.'
-        echo 'Alternatively, run "make install-lib" from the xfsprogs source.'
+        echo 'Alternatively, run "make install-dev" from the xfsprogs source.'
         exit 1
     ])
     libhdl="-lhandle"
-- 
2.11.0
