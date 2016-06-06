Received: from cn.fujitsu.com ([222.73.24.84]:56220 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750764AbcFFKjm (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 6 Jun 2016 06:39:42 -0400
Received: from localhost.localdomain (unknown [10.167.226.107])
	by cn.fujitsu.com (Postfix) with ESMTP id DD7C94056404
	for <fstests@vger.kernel.org>; Mon,  6 Jun 2016 18:26:32 +0800 (CST)
From: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
Subject: [PATCH] generic/015, generic/274: add to the 'enospc' group
Date: Mon,  6 Jun 2016 18:25:30 +0800
Message-Id: <1465208730-3994-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

>From test purpose=EF=BC=8C both two test cases belong to 'enospc' group.

Signed-off-by: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
---
 tests/generic/group | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/generic/group b/tests/generic/group
index 36fb759..c79cacf 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -17,7 +17,7 @@
 012 auto quick prealloc
 013 other ioctl udf auto quick
 014 rw udf auto quick
-015 other auto quick
+015 other auto quick enospc
 016 auto quick prealloc
 017 auto prealloc
 018 auto fsr quick
@@ -276,7 +276,7 @@
 271 auto quick clone
 272 auto quick clone
 273 auto rw
-274 auto rw prealloc
+274 auto rw prealloc enospc
 275 auto rw enospc
 276 auto quick clone
 277 auto ioctl quick metadata
--=20
1.8.3.1



