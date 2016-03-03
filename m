Received: from mx2.suse.de ([195.135.220.15]:47634 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754693AbcCCSQx (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 3 Mar 2016 13:16:53 -0500
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 0F6B3ADEB
	for <fstests@vger.kernel.org>; Thu,  3 Mar 2016 18:16:52 +0000 (UTC)
From: David Sterba <dsterba@suse.com>
Subject: [PATCH 1/2] filter.btrfs: new filter for property messages
Date: Thu,  3 Mar 2016 19:16:36 +0100
Message-Id: <478b11f8a7ffe7d491227ab536418f214e7d346c.1457028701.git.dsterba@suse.com>
In-Reply-To: <cover.1457028701.git.dsterba@suse.com>
References: <cover.1457028701.git.dsterba@suse.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
List-ID: <fstests@vger.kernel.org>

The error message in newer btrfs utilities contains name of the
property, we want to filter it out so it matches golden output. There's
an optional parameter with property name that is matched against the
command output.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 common/filter.btrfs | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/common/filter.btrfs b/common/filter.btrfs
index 9bb64792f14f..380454399834 100644
--- a/common/filter.btrfs
+++ b/common/filter.btrfs
@@ -68,5 +68,17 @@ _filter_btrfs_subvol_delete()
 
 }
 
+# filter name of the property from the output, optionally verify against $1
+# recognized message(s):
+#  "object is not compatible with property: label"
+_filter_btrfs_prop_error()
+{
+	if ! [ -z "$1" ]; then
+		sed -e "s/\(compatible with property\): $1/\1/"
+	else
+		sed -e "s/^\(.*compatible with property\).*/\1/"
+	fi
+}
+
 # make sure this script returns success
 /bin/true
-- 
1.8.4.5

