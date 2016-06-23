Received: from mx1.redhat.com ([209.132.183.28]:47548 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750959AbcFWGKG (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 23 Jun 2016 02:10:06 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2A10C800A8
	for <fstests@vger.kernel.org>; Thu, 23 Jun 2016 06:10:06 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH v4 2/2] ext4/271: _notrun if there are journal related mount options
Date: Thu, 23 Jun 2016 14:09:47 +0800
Message-Id: <1466662187-31201-2-git-send-email-eguan@redhat.com>
In-Reply-To: <1466662187-31201-1-git-send-email-eguan@redhat.com>
References: <1466662187-31201-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

ext4/271 runs in no journal mode (-onoload), so running test with
journal related mount options makes no sense, and test fails after
kernel commit 1e381f60dad9 ("ext4: do not allow journal_opts for fs
w/o journal"), journal related mount options are not allowed in no
journal mode. So _notrun if there're journal related mount options.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
v4:
- rename to _exclude_scratch_mount_option

v3:
- rename _require_no_mount_opts to _exclude_mount_option

v2:
- update comments in the code
- rebase on top of current master

 tests/ext4/271 | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/ext4/271 b/tests/ext4/271
index d68c271..8674090 100755
--- a/tests/ext4/271
+++ b/tests/ext4/271
@@ -39,6 +39,12 @@ trap "rm -f $tmp.*; exit \$status" 0 1 2 3 15
 _supported_fs ext4
 _supported_os Linux
 _require_scratch
+# this test needs no journal to be loaded, skip on journal related mount
+# options, otherwise mount would fail with "-o noload" mount option
+_exclude_scratch_mount_option "data="
+_exclude_scratch_mount_option "commit="
+_exclude_scratch_mount_option "journal_checksum"
+_exclude_scratch_mount_option "journal_async_commit"
 
 rm -f $seqres.full
 _scratch_mkfs_sized $((128 * 1024 * 1024)) >> $seqres.full 2>&1
-- 
2.7.4

