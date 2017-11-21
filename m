Received: from mail.cn.fujitsu.com ([183.91.158.132]:3946 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751899AbdKUG1d (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 21 Nov 2017 01:27:33 -0500
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH v2] generic/459: add check for dm-snapshot target
Date: Tue, 21 Nov 2017 14:27:20 +0800
Message-ID: <1511245640-12862-1-git-send-email-yangx.jy@cn.fujitsu.com>
In-Reply-To: <20171121060714.GM2749@eguan.usersys.redhat.com>
References: <20171121060714.GM2749@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: eguan@redhat.com
Cc: fstests@vger.kernel.org, Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

generic/459 should be skipped when dm-snapshot is not supported.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 tests/generic/459 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/generic/459 b/tests/generic/459
index d1ad372..eb05fb8 100755
--- a/tests/generic/459
+++ b/tests/generic/459
@@ -62,6 +62,7 @@ _supported_fs generic
 _supported_os Linux
 _require_scratch_nocheck
 _require_dm_target thin-pool
+_require_dm_target snapshot
 _require_command $LVM_PROG lvm
 _require_command "$THIN_CHECK_PROG" thin_check
 _require_freeze
-- 
1.8.3.1



