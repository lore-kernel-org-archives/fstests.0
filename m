Received: from mgwym04.jp.fujitsu.com ([211.128.242.43]:55797 "EHLO
        mgwym04.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750786AbeDWFYB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 23 Apr 2018 01:24:01 -0400
Received: from g01jpfmpwyt01.exch.g01.fujitsu.local (g01jpfmpwyt01.exch.g01.fujitsu.local [10.128.193.38])
        by yt-mxoi1.gw.nic.fujitsu.com (Postfix) with ESMTP id 5D910AC012B
        for <fstests@vger.kernel.org>; Mon, 23 Apr 2018 14:23:58 +0900 (JST)
Received: from g01jpexchyt35.g01.fujitsu.local (unknown [10.128.193.4])
        by g01jpfmpwyt01.exch.g01.fujitsu.local (Postfix) with ESMTP id B53C76D663B
        for <fstests@vger.kernel.org>; Mon, 23 Apr 2018 14:23:57 +0900 (JST)
From: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
Subject: [PATCH] common/rc: move rm out from if block to always delete
 kmemleak temp file
Message-ID: <8a5faeaa-e053-ab1b-4712-edec8d32fd93@jp.fujitsu.com>
Date: Mon, 23 Apr 2018 14:23:14 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Otherwise, *.kmemleak.tmp may remain in result folder if kmemleak is on.

Signed-off-by: Tomohiro Misono <misono.tomohiro@jp.fujitsu.com>
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 366489bb..0c3359fd 100644
--- a/common/rc
+++ b/common/rc
@@ -3515,8 +3515,8 @@ EXPERIMENTAL kmemleak reported some memory leaks!  Due to the way kmemleak
 works, the leak might be from an earlier test, or something totally unrelated.
 ENDL
 		cat "$leak_file.tmp" >> "$leak_file"
-		rm -rf "$leak_file.tmp"
 	fi
+	rm -rf "$leak_file.tmp"
 	echo "clear" > "$kern_knob"
 }
 
-- 
2.14.3

