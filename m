Received: from mx1.redhat.com ([209.132.183.28]:38181 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750726AbcARFDr (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 18 Jan 2016 00:03:47 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (Postfix) with ESMTPS id 5E86757
	for <fstests@vger.kernel.org>; Mon, 18 Jan 2016 05:03:47 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH 2/2] ext4/271: _notrun if there are journal related mount options
Date: Mon, 18 Jan 2016 13:03:27 +0800
Message-Id: <1453093407-17734-2-git-send-email-eguan@redhat.com>
In-Reply-To: <1453093407-17734-1-git-send-email-eguan@redhat.com>
References: <1453093407-17734-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

ext4/271 runs in no journal mode (-onoload), so running test with
journal related mount options makes no sense, and test fails after
kernel commit 1e381f60dad9 ("ext4: do not allow journal_opts for fs w/o
journal") journal related mount options are not allowed in no journal
mode. So just _notrun if there're journal related mount options.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 tests/ext4/271 | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/ext4/271 b/tests/ext4/271
index 217d0d8..c8e41e9 100755
--- a/tests/ext4/271
+++ b/tests/ext4/271
@@ -40,6 +40,11 @@ _supported_fs ext4
 _supported_os Linux
 _need_to_be_root
 _require_scratch
+# this test needs no journal to be loaded, skip on journal related mount options
+_require_no_mount_opts "data="
+_require_no_mount_opts "commit="
+_require_no_mount_opts "journal_checksum"
+_require_no_mount_opts "journal_async_commit"
 
 rm -f $seqres.full
 _scratch_mkfs_sized $((128 * 1024 * 1024)) >> $seqres.full 2>&1
-- 
1.8.3.1

