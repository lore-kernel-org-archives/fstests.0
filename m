Received: from mx2.suse.de ([195.135.220.15]:41882 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751466AbdFZNkw (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 26 Jun 2017 09:40:52 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7ADB7AB5D
        for <fstests@vger.kernel.org>; Mon, 26 Jun 2017 13:40:46 +0000 (UTC)
From: David Disseldorp <ddiss@suse.de>
Subject: [PATCH 2/2] common: remove tmp.mkfs[err/std] files by name
Date: Mon, 26 Jun 2017 15:40:17 +0200
Message-Id: <20170626134017.2741-2-ddiss@suse.de>
In-Reply-To: <20170626134017.2741-1-ddiss@suse.de>
References: <20170626134017.2741-1-ddiss@suse.de>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: David Disseldorp <ddiss@suse.de>
List-ID: <fstests@vger.kernel.org>

Without any $tmp suffix, users silly enough to run xfstests without
mktemp present will unintentionally "rm -f *".

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 common/rc  | 2 +-
 common/xfs | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/rc b/common/rc
index ff1b75c9..a38f4e03 100644
--- a/common/rc
+++ b/common/rc
@@ -595,7 +595,7 @@ _scratch_do_mkfs()
 	cat $tmp.mkfsstd
 	eval "cat $tmp.mkfserr | $mkfs_filter" >&2
 
-	rm -f $tmp*
+	rm -f $tmp.mkfsstd $tmp.mkfserr
 	return $mkfs_status
 }
 
diff --git a/common/xfs b/common/xfs
index 0f0825bc..59776a6f 100644
--- a/common/xfs
+++ b/common/xfs
@@ -104,7 +104,7 @@ _scratch_mkfs_xfs()
 	# output mkfs stdout and stderr
 	cat $tmp.mkfsstd
 	cat $tmp.mkfserr >&2
-	rm -f $tmp*
+	rm -f $tmp.mkfsstd $tmp.mkfserr
 
 	return $mkfs_status
 }
-- 
2.12.3

