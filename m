Received: from mx2.suse.de ([195.135.220.15]:51824 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754411AbdFNHTc (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 14 Jun 2017 03:19:32 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F27D0AD8B
        for <fstests@vger.kernel.org>; Wed, 14 Jun 2017 07:19:25 +0000 (UTC)
From: Jan Kara <jack@suse.cz>
Subject: [PATCH 2/2] common: UDF does not support journalling
Date: Wed, 14 Jun 2017 09:19:21 +0200
Message-Id: <20170614071921.6741-2-jack@suse.cz>
In-Reply-To: <20170614071921.6741-1-jack@suse.cz>
References: <20170614071921.6741-1-jack@suse.cz>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>
List-ID: <fstests@vger.kernel.org>

UDF does not support journalling. Make the appropriate feature test fail
for it.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index ff1b75c9cd25..d3ce3acc3308 100644
--- a/common/rc
+++ b/common/rc
@@ -3014,7 +3014,7 @@ _require_metadata_journaling()
 	fi
 
 	case "$FSTYP" in
-	ext2|vfat|msdos)
+	ext2|vfat|msdos|udf)
 		_notrun "$FSTYP does not support metadata journaling"
 		;;
 	ext4)
-- 
2.12.3

