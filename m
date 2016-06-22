Received: from mx1.redhat.com ([209.132.183.28]:60803 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752505AbcFVLno (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 22 Jun 2016 07:43:44 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3E69078225
	for <fstests@vger.kernel.org>; Wed, 22 Jun 2016 11:43:39 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH v3 2/2] ext4/271: _notrun if there are journal related mount options
Date: Wed, 22 Jun 2016 19:43:31 +0800
Message-Id: <1466595811-23822-2-git-send-email-eguan@redhat.com>
In-Reply-To: <1466595811-23822-1-git-send-email-eguan@redhat.com>
References: <1466595811-23822-1-git-send-email-eguan@redhat.com>
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
v3:
- rename _require_no_mount_opts to _exclude_mount_option

v2:
- update comments in the code
- rebase on top of current master

 tests/ext4/271 | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/ext4/271 b/tests/ext4/271
index d68c271..c04fd4a 100755
--- a/tests/ext4/271
+++ b/tests/ext4/271
@@ -39,6 +39,12 @@ trap "rm -f $tmp.*; exit \$status" 0 1 2 3 15
 _supported_fs ext4
 _supported_os Linux
 _require_scratch
+# this test needs no journal to be loaded, skip on journal related mount
+# options, otherwise mount would fail with "-o noload" mount option
+_exclude_mount_option "data="
+_exclude_mount_option "commit="
+_exclude_mount_option "journal_checksum"
+_exclude_mount_option "journal_async_commit"
 
 rm -f $seqres.full
 _scratch_mkfs_sized $((128 * 1024 * 1024)) >> $seqres.full 2>&1
-- 
2.7.4

