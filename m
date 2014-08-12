Return-Path: <fstests-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:39585 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752593AbaHLPYT (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 12 Aug 2014 11:24:19 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 8AB56AC64
	for <fstests@vger.kernel.org>; Tue, 12 Aug 2014 15:24:17 +0000 (UTC)
From: Jan Kara <jack@suse.cz>
Subject: [PATCH] generic/225: Require fiemap support
Date: Tue, 12 Aug 2014 17:24:08 +0200
Message-Id: <1407857048-10682-1-git-send-email-jack@suse.cz>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>
List-ID: <fstests@vger.kernel.org>

Add _require_xfs_io_command "fiemap" to test 225 to properly handle the
situation when fiemap isn't supported by the filesystem.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 tests/generic/225 |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/tests/generic/225 b/tests/generic/225
index 73b125a..6134c8c 100755
--- a/tests/generic/225
+++ b/tests/generic/225
@@ -44,6 +44,7 @@ _cleanup()
 _supported_fs generic
 _supported_os Linux
 _require_scratch
+_require_xfs_io_command "fiemap"
 
 _scratch_mkfs > /dev/null 2>&1
 _scratch_mount > /dev/null 2>&1
-- 
1.6.0.2

