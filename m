Return-Path: <fstests-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:39722 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751473AbaJAP11 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 1 Oct 2014 11:27:27 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 77615AD35
	for <fstests@vger.kernel.org>; Wed,  1 Oct 2014 15:27:26 +0000 (UTC)
From: Jan Kara <jack@suse.cz>
Subject: [PATCH] xfs/195: Use XFSDUMP_PROG instead of xfsdump directly
Date: Wed,  1 Oct 2014 17:27:18 +0200
Message-Id: <1412177239-27241-1-git-send-email-jack@suse.cz>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>
List-ID: <fstests@vger.kernel.org>

Use appropriate environment variable (XFSDUMP_PROG) instead of hardcoding
'xfsdump' name. This also makes the test fail graciously when xfsdump
isn't installed.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 tests/xfs/195 |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/tests/xfs/195 b/tests/xfs/195
index c7bc7b8..b86aedb 100755
--- a/tests/xfs/195
+++ b/tests/xfs/195
@@ -48,7 +48,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 #
 _do_dump()
 {
-	xfsdump -l 0 -s d -F  \
+	$XFSDUMP_PROG -l 0 -s d -F  \
 		-L prova -M prova \
 		-f $TEST_DIR/dumpfile -e -v excluded_files=debug $TEST_DIR \
 		| grep "ino $inum" \
@@ -58,6 +58,7 @@ _do_dump()
 # get standard environment, filters and checks
 . ./common/rc
 . ./common/filter
+. ./common/dump
 
 # real QA test starts here
 _supported_fs xfs
-- 
1.6.0.2

