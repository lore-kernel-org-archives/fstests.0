Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF51C134B0
	for <fstests@vger.kernel.org>; Fri, 26 Jan 2024 08:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706256284; cv=none; b=BYHhZ3afK8pOOSbUc4/K5ojAGBXxHgaT9VMOpwFA8utoUzfcYtPQngxUvXJWlnnIOLJdSHZAWZvmx/YuXsjwGLhvJwnwLseXRGwaceGMXCnBpzXapZZicxqa3jb3PujBb/miIlcmBiPx7VtREDG6EQj5Q3HKtdTUhGgMO3lb0do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706256284; c=relaxed/simple;
	bh=gE+jcUogNh+MqwTrYP/D1tAJc3B5St1+gPDNo4rwfJo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f+8eyuub7T8KwNWHLTga7HS6T8MghvVJ7bwjAUf7OCi3pK4LWNrmZh7ewPewnN6m/DDpr33gxF1GuQKlGfvaEnMRqCbuMeS5s5thX9VUCXu/9yomBEtMqXxtrmEDV+53DMOS2i39iYhwWFJyseQXx5i7SyGok5y/G1HbMKVAm4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=PBlbs06S; arc=none smtp.client-ip=139.138.61.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="PBlbs06S"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1706256281; x=1737792281;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gE+jcUogNh+MqwTrYP/D1tAJc3B5St1+gPDNo4rwfJo=;
  b=PBlbs06Sbi4RKOYkiilKCalB+603EOocZ5QFKLhecQB4afXgsgGM06Zh
   iFutw1O2X82ktVn8voXY7GcPy7K/NCaSFaFSsoWBNJlLcqMZyzDjkjOfD
   W5RvoFhkDUs8y1rMVYOv0WhHL4xviFchUWwuQ1R2s4oIcVwJfAaUQ4CFn
   Xr3wpSrIfbrywDv+vyr8TCVUGH+Z9vOY4xWty9k1ggOlMAg/8BRR9QIeq
   nQeXS0xSaMZY3PUmaHkxfQTfb95XZ97pvO5rmTQ3jZruE55qLVZxaOOs3
   0n4co/G6Zz9jW48LDfzzXE/XblksJ7WTdc5xXMwPMmKjIKdcaFG3OqdtD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="126140095"
X-IronPort-AV: E=Sophos;i="6.05,216,1701097200"; 
   d="scan'208";a="126140095"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 17:04:32 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 311D8D4F60
	for <fstests@vger.kernel.org>; Fri, 26 Jan 2024 17:04:30 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 641B914252
	for <fstests@vger.kernel.org>; Fri, 26 Jan 2024 17:04:29 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id E95A620095B4C
	for <fstests@vger.kernel.org>; Fri, 26 Jan 2024 17:04:28 +0900 (JST)
Received: from rhel93GA.g08.fujitsu.local (unknown [10.167.221.71])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 69F381A006A;
	Fri, 26 Jan 2024 16:04:28 +0800 (CST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: fstests@vger.kernel.org
Cc: Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH] t_snapshot_deleted_subvolume: change the position of macro definition
Date: Fri, 26 Jan 2024 03:04:23 -0500
Message-Id: <20240126080423.138713-1-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28142.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28142.006
X-TMASE-Result: 10-0.708300-10.000000
X-TMASE-MatchedRID: TrF+XMB65Pp9lF0N05iN+FXthr2HxTUWBGvINcfHqhfbspKx4YOD3b8F
	Hrw7frluf146W0iUu2vv+zsxhXHiFUsuK6d1t+nSngIgpj8eDcBpkajQR5gb3qbj/c4OO+6RKra
	uXd3MZDVtlNiPa5BG1tC2RdwwCAjWki3gUJ3QeckVyaWjEJRBJ2b4HzCdsI6/VmzGbCIUMuDEh1
	A7zo4t2IQT5/ARC9dogmwgsF9sowcZTzakhzo0BhXFEH92Kf64nTtPxlIuIBW9Hzj86YHXBCnif
	x5AGfCL
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

On some platform, struct btrfs_ioctl_vol_args_v2 is defined, but the
macros BTRFS_IOC_SNAP_DESTROY_V2, BTRFS_IOC_SNAP_CREATE_V2 and
BTRFS_IOC_SUBVOL_CREATE_V2 are not defined. This will cause compile
error. We should always check these macros and manually define them
if necessary.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 src/t_snapshot_deleted_subvolume.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/src/t_snapshot_deleted_subvolume.c b/src/t_snapshot_deleted_subvolume.c
index c3adb1c4..d84ba35a 100644
--- a/src/t_snapshot_deleted_subvolume.c
+++ b/src/t_snapshot_deleted_subvolume.c
@@ -20,21 +20,6 @@
 #define BTRFS_IOCTL_MAGIC 0x94
 #endif
 
-#ifndef BTRFS_IOC_SNAP_DESTROY_V2
-#define BTRFS_IOC_SNAP_DESTROY_V2 \
-	_IOW(BTRFS_IOCTL_MAGIC, 63, struct btrfs_ioctl_vol_args_v2)
-#endif
-
-#ifndef BTRFS_IOC_SNAP_CREATE_V2
-#define BTRFS_IOC_SNAP_CREATE_V2 \
-	_IOW(BTRFS_IOCTL_MAGIC, 23, struct btrfs_ioctl_vol_args_v2)
-#endif
-
-#ifndef BTRFS_IOC_SUBVOL_CREATE_V2
-#define BTRFS_IOC_SUBVOL_CREATE_V2 \
-	_IOW(BTRFS_IOCTL_MAGIC, 24, struct btrfs_ioctl_vol_args_v2)
-#endif
-
 #ifndef BTRFS_SUBVOL_NAME_MAX
 #define BTRFS_SUBVOL_NAME_MAX 4039
 #endif
@@ -58,6 +43,21 @@ struct btrfs_ioctl_vol_args_v2 {
 };
 #endif
 
+#ifndef BTRFS_IOC_SNAP_DESTROY_V2
+#define BTRFS_IOC_SNAP_DESTROY_V2 \
+	_IOW(BTRFS_IOCTL_MAGIC, 63, struct btrfs_ioctl_vol_args_v2)
+#endif
+
+#ifndef BTRFS_IOC_SNAP_CREATE_V2
+#define BTRFS_IOC_SNAP_CREATE_V2 \
+	_IOW(BTRFS_IOCTL_MAGIC, 23, struct btrfs_ioctl_vol_args_v2)
+#endif
+
+#ifndef BTRFS_IOC_SUBVOL_CREATE_V2
+#define BTRFS_IOC_SUBVOL_CREATE_V2 \
+	_IOW(BTRFS_IOCTL_MAGIC, 24, struct btrfs_ioctl_vol_args_v2)
+#endif
+
 int main(int argc, char **argv)
 {
 	if (argc != 2) {
-- 
2.39.3

