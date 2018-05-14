Received: from mx2.suse.de ([195.135.220.15]:43691 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752393AbeENRD6 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 14 May 2018 13:03:58 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7E504AE16
        for <fstests@vger.kernel.org>; Mon, 14 May 2018 17:03:57 +0000 (UTC)
From: Jan Kara <jack@suse.cz>
Subject: [PATCH 3/3] common/quota: Fix _qmount_options for ext4 journalled quotas
Date: Mon, 14 May 2018 19:03:51 +0200
Message-Id: <20180514170351.13737-4-jack@suse.cz>
In-Reply-To: <20180514170351.13737-1-jack@suse.cz>
References: <20180514170351.13737-1-jack@suse.cz>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>
List-ID: <fstests@vger.kernel.org>

_qmount_options didn't properly replace ext[34] journalled quotas mount
options. As such the mount option string got garbled and the test
(e.g. generic/379) failed.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 common/quota | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/common/quota b/common/quota
index 2b99521df43d..f01bd068383b 100644
--- a/common/quota
+++ b/common/quota
@@ -229,8 +229,10 @@ _qmount_option()
 	export MOUNT_OPTIONS=`echo $MOUNT_OPTIONS \
 	| sed   -e 's/uquota/QUOTA/g'      \
 		-e 's/usrquota/QUOTA/g'    \
+		-e 's/usrjquota=[^, ]/QUOTA/g' \
 		-e 's/gquota/QUOTA/g'      \
 		-e 's/grpquota/QUOTA/g'    \
+		-e 's/grpjquota=[^, ]/QUOTA/g' \
 		-e 's/\bpquota/QUOTA/g'    \
 		-e 's/prjquota/QUOTA/g'    \
 		-e 's/quota/QUOTA/g'       \
-- 
2.13.6

