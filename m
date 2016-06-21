Received: from mx1.redhat.com ([209.132.183.28]:37654 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751984AbcFUKlK (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 21 Jun 2016 06:41:10 -0400
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH v2 2/2] ext4/271: _notrun if there are journal related mount options
Date: Tue, 21 Jun 2016 18:40:29 +0800
Message-Id: <1466505629-9402-2-git-send-email-eguan@redhat.com>
In-Reply-To: <1466505629-9402-1-git-send-email-eguan@redhat.com>
References: <1466505629-9402-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: jack@suse.cz, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

ext4/271 runs in no journal mode (-onoload), so running test with
journal related mount options makes no sense, and test fails after
kernel commit 1e381f60dad9 ("ext4: do not allow journal_opts for fs
w/o journal"), journal related mount options are not allowed in no
journal mode. So _notrun if there're journal related mount options.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
v2:
- update comments in the code
- rebase on top of current master

 tests/ext4/271 | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/ext4/271 b/tests/ext4/271
index d68c271..ca344d9 100755
--- a/tests/ext4/271
+++ b/tests/ext4/271
@@ -39,6 +39,12 @@ trap "rm -f $tmp.*; exit \$status" 0 1 2 3 15
 _supported_fs ext4
 _supported_os Linux
 _require_scratch
+# this test needs no journal to be loaded, skip on journal related mount
+# options, otherwise mount would fail with "-o noload" mount option
+_require_no_mount_opts "data="
+_require_no_mount_opts "commit="
+_require_no_mount_opts "journal_checksum"
+_require_no_mount_opts "journal_async_commit"
 
 rm -f $seqres.full
 _scratch_mkfs_sized $((128 * 1024 * 1024)) >> $seqres.full 2>&1
-- 
2.5.5

