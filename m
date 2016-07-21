Received: from mx2.suse.de ([195.135.220.15]:35716 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750884AbcGUGRm (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 21 Jul 2016 02:17:42 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 073F8AC32
	for <fstests@vger.kernel.org>; Thu, 21 Jul 2016 06:17:41 +0000 (UTC)
From: Jan Kara <jack@suse.cz>
Subject: [PATCH 1/2] generic/294: Filter backquotes from mknod error output
Date: Thu, 21 Jul 2016 08:17:35 +0200
Message-Id: <1469081856-6424-1-git-send-email-jack@suse.cz>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>
List-ID: <fstests@vger.kernel.org>

Really old versions of coreutils (mine are 8.12) quote a filename in the
output with a backquote in the beginning and normal quote in the end.
Improve _filter_mknod to handle that.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 common/filter | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/filter b/common/filter
index 8d9f489bea1c..b229a97dfa0e 100644
--- a/common/filter
+++ b/common/filter
@@ -389,7 +389,7 @@ _filter_od()
 # mknod errors print unquoted filenames
 _filter_mknod()
 {
-	sed -e "s/mknod: '\(.*\)': File exists/mknod: \1: File exists/"
+	sed -e "s/mknod: [\`']\(.*\)': File exists/mknod: \1: File exists/"
 }
 
 # make sure this script returns success
-- 
2.6.6

