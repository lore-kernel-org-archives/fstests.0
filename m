Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF6C1A680E
	for <fstests@vger.kernel.org>; Thu, 18 Jun 2026 03:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781754497; cv=none; b=lafuyErRgg6Cg/T58icg0wBqsjjUFTIuehl5oxmPdOrEZYG0NsTOX08emkKjtotto7cMa8Xb5ey4cVofsQcjmFrRbumIqQYjYCgQ0kTpgHhea9hXhRyaM8XjEYltCXOD2W+dkf6/eqrgJUxhvZHHhZ8froNVw9Zfmv61D5lzrlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781754497; c=relaxed/simple;
	bh=TlMumCUdmJxhVhOeDsTrGHP0ICiPqN90lsAkGtyEx7A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M3n/b68rQRpDi62DJfNP9qPZnmg5slM20pQkmZkFgsroiMLYGvrvoTLEx/WOpYfFY7HHhb65ew3fH2kb2NK0Z2Jq2pDLgtWNHYDdEFVRQI21ttnxYFpGIeBF1zYbwtvqH55tVYjpuCqp3WyQDUjOI0li4RkU/pBpKf+1LAZbP2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 8510883e6ac811f1aa26b74ffac11d73-20260618
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR, DN_TRUSTED
	SRC_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_TRUSTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD_SPF, CIE_UNKNOWN
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:44b9d2d2-b2b4-4fb3-aade-d82f8389db0c,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:35
X-CID-INFO: VERSION:1.3.12,REQID:44b9d2d2-b2b4-4fb3-aade-d82f8389db0c,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:35
X-CID-META: VersionHash:e7bac3a,CLOUDID:45a59520a1c9dcfc58d8af8f02115695,BulkI
	D:2606181148111VTZUVX8,BulkQuantity:0,Recheck:0,SF:10|66|78|102|127|850|86
	5|898,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS
	:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,A
	RC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8510883e6ac811f1aa26b74ffac11d73-20260618
X-User: sangyao@kylinos.cn
Received: from localhost.localdomain [(114.246.239.49)] by mailgw.kylinos.cn
	(envelope-from <sangyao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1872883708; Thu, 18 Jun 2026 11:48:08 +0800
From: Yao Sang <sangyao@kylinos.cn>
To: fstests@vger.kernel.org
Cc: hch@lst.de,
	zlang@kernel.org,
	Yao Sang <sangyao@kylinos.cn>
Subject: [RFC] common: skip data write EIO tests on fatal configs
Date: Thu, 18 Jun 2026 11:47:56 +0800
Message-Id: <20260618034756.615426-1-sangyao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

generic/441 and xfs/656 both inject data write errors after the scratch
filesystem is mounted on dm-error.  They are not testing whether the
filesystem may keep running after the media error; they need the
filesystem to survive long enough to report the error through the path
being tested.  generic/441 checks that writeback errors reach fsync(2),
and xfs/656 checks that healthmon reports the per-I/O error event.

That is the wrong expectation for filesystem configurations where a data
write error is fatal.  Zoned XFS is one such case.  Once a data write
fails, XFS cannot reliably recover its in-core zone allocation state, so
it shuts the mount down.  The shutdown is the correct result, but it makes
these tests fail before they can observe the fsync or healthmon result
they were written to verify.

Add a common helper that describes this precondition and use it in both
tests after mounting the dm-error scratch device.  The helper can be
forced with FS_DATA_WRITE_EIO_SHUTDOWN=yes/no.  In auto mode it currently
detects XFS zoned mounts through the XFS per-mount zoned/max_open_zones
sysfs attribute, so the check follows the filesystem instance rather than
the underlying block queue alone.

Fatal-on-data-write-error configurations are now reported as notrun
instead of as test failures.

Signed-off-by: Yao Sang <sangyao@kylinos.cn>
---
RFC / validation notes:

This patch handles tests that require the filesystem to survive an injected
data write EIO long enough to report the error through the path being tested.
That expectation is not valid for configurations where a data write EIO is
fatal to the filesystem. Zoned XFS is one such configuration because a failed
data writeback can leave the in-core zone allocation state untrustworthy, so
shutting down the mount is expected behavior.

The auto detection is intentionally XFS-specific for now. It checks the XFS
per-mount sysfs attribute zoned/max_open_zones, not the block layer
/sys/block/.../queue/zoned attribute. A zoned block device alone does not
prove that the mounted XFS instance is using zoned filesystem semantics.

One test-number detail is worth calling out. The maintainer report first
mentions generic/441 and xfs/665, but the following fserror/healthmon
description refers to xfs/656. I checked both tests: xfs/656 is the dmerror
plus healthmon data I/O error test and matches the reported failure; xfs/665 is
a systemd xfs_healer / online-repair test and does not exercise dmerror data
write EIO or the healthmon fserror path. Therefore this patch updates xfs/656
and leaves xfs/665 unchanged; the xfs/665 mention looks like a test-number
typo unless there is another affected path.

 common/rc         | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/441 |  1 +
 tests/xfs/656     |  1 +
 3 files changed, 48 insertions(+)

diff --git a/common/rc b/common/rc
index 9632b211..674122ab 100644
--- a/common/rc
+++ b/common/rc
@@ -4162,6 +4162,52 @@ _require_scratch_shutdown_and_syncfs()
 	_require_scratch_shutdown
 }
 
+# Test whether the mounted scratch filesystem treats data write errors as
+# fatal.  Return true if data write errors shut the filesystem down.
+#
+# The filesystem must be mounted before calling this helper because the auto
+# detection path can depend on per-mount sysfs attributes.
+_scratch_data_write_eio_is_fatal()
+{
+	local dev="${1:-$SCRATCH_DEV}"
+
+	case "${FS_DATA_WRITE_EIO_SHUTDOWN:-auto}" in
+	yes|true|1)
+		return 0
+		;;
+	no|false|0)
+		return 1
+		;;
+	auto|"")
+		;;
+	*)
+		_fail "invalid FS_DATA_WRITE_EIO_SHUTDOWN=$FS_DATA_WRITE_EIO_SHUTDOWN"
+		;;
+	esac
+
+	case "$FSTYP" in
+	xfs)
+		# This is an XFS per-mount sysfs attribute, not a block queue
+		# attribute.  Its existence means XFS mounted this instance with
+		# zoned filesystem semantics.
+		_has_fs_sysfs_attr "$dev" "zoned/max_open_zones" && return 0
+		;;
+	esac
+
+	return 1
+}
+
+# Require that data write errors are reported through the regular error
+# reporting path instead of shutting down the filesystem.
+_require_scratch_survives_data_write_errors()
+{
+	local dev="${1:-$SCRATCH_DEV}"
+
+	_scratch_data_write_eio_is_fatal "$dev" || return
+
+	_notrun "$FSTYP treats data write errors as fatal"
+}
+
 _check_s_dax()
 {
 	local target=$1
diff --git a/tests/generic/441 b/tests/generic/441
index 6b48fc9e..b5bab2e0 100755
--- a/tests/generic/441
+++ b/tests/generic/441
@@ -53,6 +53,7 @@ echo "Format and mount"
 _scratch_mkfs > $seqres.full 2>&1
 _dmerror_init no_log
 _dmerror_mount
+_require_scratch_survives_data_write_errors $DMERROR_DEV
 
 _require_fs_space $SCRATCH_MNT 65536
 
diff --git a/tests/xfs/656 b/tests/xfs/656
index 3a867692..d39917f3 100755
--- a/tests/xfs/656
+++ b/tests/xfs/656
@@ -48,6 +48,7 @@ echo "Format and mount"
 _scratch_mkfs > $seqres.full 2>&1
 _dmerror_init no_log
 _dmerror_mount
+_require_scratch_survives_data_write_errors $DMERROR_DEV
 
 _require_fs_space $SCRATCH_MNT 65536
 
-- 
2.25.1

