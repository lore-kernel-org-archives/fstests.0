Received: from mgwym01.jp.fujitsu.com ([211.128.242.40]:60191 "EHLO
	mgwym01.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752526AbcBDAy4 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 3 Feb 2016 19:54:56 -0500
Received: from g01jpfmpwkw01.exch.g01.fujitsu.local (g01jpfmpwkw01.exch.g01.fujitsu.local [10.0.193.38])
	by yt-mxq.gw.nic.fujitsu.com (Postfix) with ESMTP id 9F392AC01C3
	for <fstests@vger.kernel.org>; Thu,  4 Feb 2016 09:54:50 +0900 (JST)
Received: from g01jpexchkw33.g01.fujitsu.local (unknown [10.0.193.4])
	by g01jpfmpwkw01.exch.g01.fujitsu.local (Postfix) with ESMTP id E07FD6926D2
	for <fstests@vger.kernel.org>; Thu,  4 Feb 2016 09:54:48 +0900 (JST)
From: Satoru Takeuchi <takeuchi_satoru@jp.fujitsu.com>
Subject: [PATCH] Fix prerequisite packages to build fstests on Ubuntu
Message-ID: <56B2A14E.90002@jp.fujitsu.com>
Date: Thu, 4 Feb 2016 09:54:38 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

To build xfstests from minimal Ubuntu, it's necessary to install
some more packages in addition to ones mentioned in README.
Plus, libtool is not needed to specify here since libtool-bin
depends on it.

Signed-off-by: Satoru Takeuchi <takeuchi_satoru@jp.fujitsu.com>
---
 README | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/README b/README
index a824c10..e44ce51 100644
--- a/README
+++ b/README
@@ -6,8 +6,8 @@ Building Linux:
 	- cd into the xfstests directory
 	- install prerequisite packages
 	  For example, for Ubuntu:
-		"sudo apt-get install xfslibs-dev uuid-dev libtool e2fsprogs
-		 automake gcc libuuid1 quota attr libattr1-dev
+		"sudo apt-get install xfslibs-dev uuid-dev libtool-bin e2fsprogs
+		 automake gcc libuuid1 quota attr libattr1-dev make
 		 libacl1-dev libaio-dev xfsprogs libgdbm-dev gawk fio dbench"
 	- run make
 	- run make install
-- 
2.7.0.rc3

