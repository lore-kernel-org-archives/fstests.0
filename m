Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0DD3A16B9
	for <fstests@vger.kernel.org>; Tue, 23 Jun 2026 06:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782196008; cv=none; b=XovsqzcJjgGjUhrYn6FbKCOpn5ilXG/OAigrvNEaQDuKD2C58WVlhrhnd1SDavX3LOtkN/RYc8Er3LeEvp8jKrXqU7NPITPGKYjA7x5X1970se4FeruwecP5Mg9hUxNHfDQTXTg65LTGc0WA+1noEpjs7R/rMtA7Y5ShyEdyujY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782196008; c=relaxed/simple;
	bh=g25ChgBZeGnpbDciXwL/kKbTm7gfxraEmKHkiFTbKDw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tb6g08zO/8OB+knuj5emdzQH49lAWDRDiRconQ9SawMYWIfqCXdgcwHmrJb8O946RXeTKfsfSOl4uyfHw9MzxadD7sqC2ZxZ7O3+Za4+M+W0WZSpOQvrmw1nKjBzwQCqDSF5Pp0yX73IdT0Daval3QhfWH6czXQud4zfjpo+HGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 7cbff6446ecc11f1aa26b74ffac11d73-20260623
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_T1, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:980f4442-c786-4ef2-9480-b50740baa9ef,IP:20,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:45
X-CID-INFO: VERSION:1.3.12,REQID:980f4442-c786-4ef2-9480-b50740baa9ef,IP:20,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:45
X-CID-META: VersionHash:e7bac3a,CLOUDID:78f6dc67a5c1ea6ab2476b75694d1104,BulkI
	D:26062314122055B2NCCP,BulkQuantity:1,Recheck:0,SF:10|66|78|102|127|850|86
	5|898,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:99|1,File:nil,RT:nil,Bulk:40,
	QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
	,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7cbff6446ecc11f1aa26b74ffac11d73-20260623
X-User: sangyao@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sangyao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 515989491; Tue, 23 Jun 2026 14:26:37 +0800
From: Yao Sang <sangyao@kylinos.cn>
To: fstests@vger.kernel.org
Cc: hch@lst.de,
	zlang@kernel.org,
	Yao Sang <sangyao@kylinos.cn>
Subject: [PATCH] common: skip data write EIO survival tests on fatal configs
Date: Tue, 23 Jun 2026 14:26:16 +0800
Message-Id: <20260623062616.1994466-1-sangyao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

generic/441 and xfs/656 inject data write errors after mounting the scratch
filesystem on dm-error. These tests do not verify whether a filesystem may
shut down after media errors. They require the filesystem to survive long
enough to report the error through the path under test: generic/441 checks
fsync(2) writeback error reporting, and xfs/656 checks healthmon per-I/O
error events.

That expectation is not valid for filesystem configurations where a data
write error is fatal. Zoned XFS is one such case because a failed data write
can leave the in-core zone allocation state untrustworthy, so shutting down
the mount is expected behavior.

Add a common helper for tests that require data write EIO to be reported
without shutting down the mounted filesystem, and use it after mounting the
dm-error device in both tests. The helper currently detects zoned XFS by
checking the XFS per-mount zoned/max_open_zones sysfs attribute for the
mounted device, so the check follows the filesystem instance rather than the
underlying block queue alone.

Fatal-on-data-write-error configurations are reported as notrun instead of
test failures.

Signed-off-by: Yao Sang <sangyao@kylinos.cn>
---
Changes since RFC:
- Replace the separate fatal predicate and survival requirement helpers with
  a single _require_fs_survives_data_write_eio helper.
- Drop the FS_DATA_WRITE_EIO_SHUTDOWN override.
- Require callers to pass the mounted device explicitly.
- Remove _scratch from the helper name.
- Keep the XFS per-mount zoned/max_open_zones detection.

RFC Link:
https://lore.kernel.org/fstests/20260618034756.615426-1-sangyao@kylinos.cn/

 common/rc         | 22 ++++++++++++++++++++++
 tests/generic/441 |  1 +
 tests/xfs/656     |  1 +
 3 files changed, 24 insertions(+)

diff --git a/common/rc b/common/rc
index 9632b211..4bf0861b 100644
--- a/common/rc
+++ b/common/rc
@@ -4162,6 +4162,28 @@ _require_scratch_shutdown_and_syncfs()
 	_require_scratch_shutdown
 }
 
+# Require that the mounted filesystem survive data write errors long enough to
+# report them through the regular error reporting path.
+_require_fs_survives_data_write_eio()
+{
+	local dev=$1
+
+	if [ ! -b "$dev" ]; then
+		_fail "Usage: _require_fs_survives_data_write_eio <mounted_device>"
+	fi
+
+	case "$FSTYP" in
+	xfs)
+		# This is an XFS per-mount sysfs attribute, not a block queue
+		# attribute.  Its existence means XFS mounted this instance with
+		# zoned filesystem semantics.
+		if _has_fs_sysfs_attr "$dev" "zoned/max_open_zones"; then
+			_notrun "zoned XFS shuts down on data write EIO"
+		fi
+		;;
+	esac
+}
+
 _check_s_dax()
 {
 	local target=$1
diff --git a/tests/generic/441 b/tests/generic/441
index 6b48fc9e..cc370bea 100755
--- a/tests/generic/441
+++ b/tests/generic/441
@@ -53,6 +53,7 @@ echo "Format and mount"
 _scratch_mkfs > $seqres.full 2>&1
 _dmerror_init no_log
 _dmerror_mount
+_require_fs_survives_data_write_eio $DMERROR_DEV
 
 _require_fs_space $SCRATCH_MNT 65536
 
diff --git a/tests/xfs/656 b/tests/xfs/656
index 3a867692..3830d719 100755
--- a/tests/xfs/656
+++ b/tests/xfs/656
@@ -48,6 +48,7 @@ echo "Format and mount"
 _scratch_mkfs > $seqres.full 2>&1
 _dmerror_init no_log
 _dmerror_mount
+_require_fs_survives_data_write_eio $DMERROR_DEV
 
 _require_fs_space $SCRATCH_MNT 65536
 
-- 
2.25.1
