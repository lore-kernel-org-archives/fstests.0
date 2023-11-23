Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C1B11F
	for <fstests@vger.kernel.org>; Thu, 23 Nov 2023 00:58:51 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="142214593"
X-IronPort-AV: E=Sophos;i="6.04,221,1695654000"; 
   d="scan'208";a="142214593"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 17:58:50 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
	by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 8E506D6187
	for <fstests@vger.kernel.org>; Thu, 23 Nov 2023 17:58:47 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id C0953D296A
	for <fstests@vger.kernel.org>; Thu, 23 Nov 2023 17:58:46 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 563CF20076847
	for <fstests@vger.kernel.org>; Thu, 23 Nov 2023 17:58:46 +0900 (JST)
Received: from irides.g08.fujitsu.local (unknown [10.167.226.34])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 0B0E11A006F;
	Thu, 23 Nov 2023 16:58:45 +0800 (CST)
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
To: fstests@vger.kernel.org
Cc: ruansy.fnst@fujitsu.com
Subject: [PATCH] fsstress: unify verbose output format
Date: Thu, 23 Nov 2023 16:58:43 +0800
Message-ID: <20231123085843.1152470-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28014.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28014.006
X-TMASE-Result: 10--4.019700-10.000000
X-TMASE-MatchedRID: f7AFKO04MPxlJTodqNqEzk7nLUqYrlslFIuBIWrdOePfUZT83lbkEH38
	DhskX88zN4nbTwZZBF6bbexJXGYzE5H0YXYnbGozFEUknJ/kEl7dB/CxWTRRu+rAZ8KTspSz/fO
	JNp+A35t5vRp2WTYpa7Xj7Aq6xvP0grAvaGplPRvHMEDW8dd68Z1fhzxlXPo4KK8FXMWhGPd5W9
	T2ECMvld+cKtFNzpqXIcmnZRhVxyrE4HwnSlEuHInEpJmLAFfpC1FNc6oqYVV+3BndfXUhXQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Wrap offset, length within '[]' and remove meanless 't' in
do_fallocate().

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 ltp/fsstress.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/ltp/fsstress.c b/ltp/fsstress.c
index abe287425..9778fce82 100644
--- a/ltp/fsstress.c
+++ b/ltp/fsstress.c
@@ -3810,7 +3810,7 @@ do_fallocate(opnum_t opno, long r, int mode)
 	mode |= FALLOC_FL_KEEP_SIZE & random();
 	e = fallocate(fd, mode, (loff_t)off, (loff_t)len) < 0 ? errno : 0;
 	if (v)
-		printf("%d/%lld: fallocate(%s) %s %st %lld %lld %d\n",
+		printf("%d/%lld: fallocate(%s) %s%s [%lld,%lld] %d\n",
 		       procid, opno, translate_falloc_flags(mode),
 		       f.path, st, (long long)off, (long long)len, e);
 	free_pathname(&f);
@@ -3932,7 +3932,7 @@ fiemap_f(opnum_t opno, long r)
 
 	e = ioctl(fd, FS_IOC_FIEMAP, (unsigned long)fiemap);
 	if (v)
-		printf("%d/%lld: ioctl(FIEMAP) %s%s %lld %lld (%s) %d\n",
+		printf("%d/%lld: ioctl(FIEMAP) %s%s [%lld,%lld,%s] %d\n",
 		       procid, opno, f.path, st, (long long)fiemap->fm_start,
 		       (long long) fiemap->fm_length,
 		       translate_fiemap_flags(fiemap->fm_flags), e);
@@ -4866,7 +4866,7 @@ resvsp_f(opnum_t opno, long r)
 	fl.l_len = (off64_t)(random() % (1024 * 1024));
 	e = xfsctl(f.path, fd, XFS_IOC_RESVSP64, &fl) < 0 ? errno : 0;
 	if (v)
-		printf("%d/%lld: xfsctl(XFS_IOC_RESVSP64) %s%s %lld %lld %d\n",
+		printf("%d/%lld: xfsctl(XFS_IOC_RESVSP64) %s%s [%lld,%lld] %d\n",
 		       procid, opno, f.path, st,
 			(long long)off, (long long)fl.l_len, e);
 	free_pathname(&f);
@@ -5334,7 +5334,7 @@ unresvsp_f(opnum_t opno, long r)
 	fl.l_len = (off64_t)(random() % (1 << 20));
 	e = xfsctl(f.path, fd, XFS_IOC_UNRESVSP64, &fl) < 0 ? errno : 0;
 	if (v)
-		printf("%d/%lld: xfsctl(XFS_IOC_UNRESVSP64) %s%s %lld %lld %d\n",
+		printf("%d/%lld: xfsctl(XFS_IOC_UNRESVSP64) %s%s [%lld,%lld] %d\n",
 		       procid, opno, f.path, st,
 			(long long)off, (long long)fl.l_len, e);
 	free_pathname(&f);
-- 
2.42.1

