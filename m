Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009D6B0
	for <fstests@vger.kernel.org>; Mon,  4 Dec 2023 03:34:44 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="141423252"
X-IronPort-AV: E=Sophos;i="6.04,249,1695654000"; 
   d="scan'208";a="141423252"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 20:34:40 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
	by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 906F3D6188
	for <fstests@vger.kernel.org>; Mon,  4 Dec 2023 20:34:37 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id CEA5CD3F13
	for <fstests@vger.kernel.org>; Mon,  4 Dec 2023 20:34:36 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 66B0B202CCD24
	for <fstests@vger.kernel.org>; Mon,  4 Dec 2023 20:34:36 +0900 (JST)
Received: from rhel93GA.g08.fujitsu.local (unknown [10.167.221.71])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 1370A1A0071;
	Mon,  4 Dec 2023 19:34:35 +0800 (CST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: fstests@vger.kernel.org
Cc: Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH] generic/733: use correct kernel commit id
Date: Mon,  4 Dec 2023 06:34:28 -0500
Message-Id: <20231204113428.68071-1-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28036.007
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28036.007
X-TMASE-Result: 10--9.715400-10.000000
X-TMASE-MatchedRID: fqobMUxwrit4VMEOH2fwTCZm6wdY+F8KwTlc9CcHMZerwqxtE531VIpb
	wG9fIuITewNtMWg+aObkJdh0Vw0TYx/Qfe1gmZY9joyKzEmtrEdZDdHiTk9OcMwHSQ+yXjTDBk0
	sRysFrTDE7gW9Nmz5nKau4JLYI3mtiiMVQOiPaXyeAiCmPx4NwBnUJ0Ek6yhj2bNx1HEv7HAqtq
	5d3cxkNRk9sc7V/Os07QJEaFveglJ+wauT0ePW6psCn7LEqQbcAVGZaYVXI9k=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 tests/generic/733 | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/generic/733 b/tests/generic/733
index ca4dd519..d88d92a4 100755
--- a/tests/generic/733
+++ b/tests/generic/733
@@ -6,7 +6,7 @@
 #
 # Race file reads with a very slow reflink operation to see if the reads
 # actually complete while the reflink is ongoing.  This is a functionality
-# test for XFS commit f3ba4762fa56 "xfs: allow read IO and FICLONE to run
+# test for XFS commit 14a537983b22 "xfs: allow read IO and FICLONE to run
 # concurrently".
 #
 . ./common/preamble
@@ -26,6 +26,9 @@ _require_test_program "punch-alternating"
 _require_test_program "t_reflink_read_race"
 _require_command "$TIMEOUT_PROG" timeout
 
+[ "$FSTYP" = "xfs" ] && _fixed_by_kernel_commit 14a537983b22 \
+        "xfs: allow read IO and FICLONE to run concurrently"
+
 rm -f "$seqres.full"
 
 echo "Format and mount"
-- 
2.27.0

