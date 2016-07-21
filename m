Received: from mx2.suse.de ([195.135.220.15]:35718 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750914AbcGUGRm (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 21 Jul 2016 02:17:42 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 1BD87AC9D
	for <fstests@vger.kernel.org>; Thu, 21 Jul 2016 06:17:41 +0000 (UTC)
From: Jan Kara <jack@suse.cz>
Subject: [PATCH 2/2] generic/130: Improve xfs_io filter
Date: Thu, 21 Jul 2016 08:17:36 +0200
Message-Id: <1469081856-6424-2-git-send-email-jack@suse.cz>
In-Reply-To: <1469081856-6424-1-git-send-email-jack@suse.cz>
References: <1469081856-6424-1-git-send-email-jack@suse.cz>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>
List-ID: <fstests@vger.kernel.org>

On my test setup xfs_io reports 'nan' in bytes/s and ops/s fields when
the operation takes zero time. Account for that in _filter_xfs_io.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 common/filter | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/filter b/common/filter
index b229a97dfa0e..37f07c8ca1ac 100644
--- a/common/filter
+++ b/common/filter
@@ -221,7 +221,7 @@ common_line_filter()
 
 _filter_xfs_io()
 {
-    sed -e "s/[0-9/.]* [GMKiBbytes]*, [0-9]* ops\; [0-9/:. sec]* ([inf0-9/.]* [EPGMKiBbytes]*\/sec and [inf0-9/.]* ops\/sec)/XXX Bytes, X ops\; XX:XX:XX.X (XXX YYY\/sec and XXX ops\/sec)/"
+    sed -e "s/[0-9/.]* [GMKiBbytes]*, [0-9]* ops\; [0-9/:. sec]* ([infnan0-9/.]* [EPGMKiBbytes]*\/sec and [infnan0-9/.]* ops\/sec)/XXX Bytes, X ops\; XX:XX:XX.X (XXX YYY\/sec and XXX ops\/sec)/"
 }
 
 _filter_xfs_io_unique()
-- 
2.6.6

