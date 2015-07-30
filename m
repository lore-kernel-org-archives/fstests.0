Received: from cn.fujitsu.com ([59.151.112.132]:39160 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751212AbbG3GMh (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 30 Jul 2015 02:12:37 -0400
From: Dongsheng Yang <yangds.fnst@cn.fujitsu.com>
Subject: [PATCH 2/5] xfstest: generic/219 add _require_odirect
Date: Thu, 30 Jul 2015 14:06:54 +0800
Message-ID: <1438236417-24612-3-git-send-email-yangds.fnst@cn.fujitsu.com>
In-Reply-To: <1438236417-24612-1-git-send-email-yangds.fnst@cn.fujitsu.com>
References: <1438236417-24612-1-git-send-email-yangds.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: eguan@redhat.com, fstests@vger.kernel.org, dedekind1@gmail.com, richard.weinberger@gmail.com
Cc: linux-mtd@lists.infradead.org, Dongsheng Yang <yangds.fnst@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

generic/219 is testing quota in three use cases including
Direct I/O. So we have to add a dependence to odirect in
this test.

Signed-off-by: Dongsheng Yang <yangds.fnst@cn.fujitsu.com>
---
 tests/generic/219 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/generic/219 b/tests/generic/219
index 2b75b89..866e7b7 100755
--- a/tests/generic/219
+++ b/tests/generic/219
@@ -44,6 +44,7 @@ _supported_fs generic
 _supported_os Linux #IRIX
 _require_scratch
 _require_quota
+_require_odirect
 _require_user
 _require_group
 
-- 
1.8.4.2

