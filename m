Received: from mgwkm01.jp.fujitsu.com ([202.219.69.168]:27821 "EHLO
	mgwkm01.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924AbcCWB2M (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 22 Mar 2016 21:28:12 -0400
Received: from m3050.s.css.fujitsu.com (msm.b.css.fujitsu.com [10.134.21.208])
	by kw-mxauth.gw.nic.fujitsu.com (Postfix) with ESMTP id E8A90AC009D
	for <fstests@vger.kernel.org>; Wed, 23 Mar 2016 10:28:06 +0900 (JST)
From: Satoru Takeuchi <takeuchi_satoru@jp.fujitsu.com>
Subject: [PATCH] xfstests: lib/tlibio: Fix a build warning
Message-ID: <56F1F119.4020007@jp.fujitsu.com>
Date: Wed, 23 Mar 2016 10:27:53 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Remove the following warning message.

  ===============================
  tlibio.c: In function 'lio_set_debug':
  tlibio.c:212:1: warning: type of 'level' defaults to 'int' [-Wimplicit-int]
   lio_set_debug(level)
   ^
  ==============================

Signed-off-by: Satoru Takeuchi <takeuchi_satoru@jp.fujitsu.com>
---
 lib/tlibio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/tlibio.c b/lib/tlibio.c
index f2078da..9b1b890 100644
--- a/lib/tlibio.c
+++ b/lib/tlibio.c
@@ -209,7 +209,7 @@ int	*max;
  * This function will allow someone to set the debug level.
  ***********************************************************************/
 int
-lio_set_debug(level)
+lio_set_debug(int level)
 {
     int old;

-- 
2.5.0
