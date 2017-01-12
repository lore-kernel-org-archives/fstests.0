Received: from mx2.suse.de ([195.135.220.15]:41510 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751139AbdALRTB (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 12 Jan 2017 12:19:01 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1F1ACACED
        for <fstests@vger.kernel.org>; Thu, 12 Jan 2017 17:18:59 +0000 (UTC)
From: David Disseldorp <ddiss@suse.de>
Subject: [PATCH 3/3] common: remove tmp.mkfs[err/std] files by name
Date: Thu, 12 Jan 2017 18:18:49 +0100
Message-Id: <20170112171849.10784-3-ddiss@suse.de>
In-Reply-To: <20170112171849.10784-1-ddiss@suse.de>
References: <20170112132656.7caa64dd@suse.de>
 <20170112171849.10784-1-ddiss@suse.de>
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
index 37d0fc8..4cbe00f 100644
--- a/common/rc
+++ b/common/rc
@@ -464,7 +464,7 @@ _scratch_do_mkfs()
 	cat $tmp.mkfsstd
 	eval "cat $tmp.mkfserr | $mkfs_filter" >&2
 
-	rm -f $tmp*
+	rm -f $tmp.mkfsstd $tmp.mkfserr
 	return $mkfs_status
 }
 
diff --git a/common/xfs b/common/xfs
index 767a481..582fcbe 100644
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
2.10.2

