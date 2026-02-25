Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EE6392814
	for <fstests@vger.kernel.org>; Wed, 25 Feb 2026 10:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772015269; cv=none; b=MIkKMm91s+L3jvLAWNxfwDTGeQi3zxYqhUY5Ljj0aW2YCuJZd/dL5LMVjGSUi2JBVLKnxPhQsFi35YzIfcMmBIEH+ZZAW/qn1kfuWUQWec/WtnkaC8wvC9uQGJy0DDMKaZN8Ild0qXicqwkTQfKVDwKwrJ08ZX+ebh4hD3j0MU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772015269; c=relaxed/simple;
	bh=Pvkws1CeOrsL7or08z9F0NghOPMEqPI3IqRRDZd64Zc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fxHcui/LjT8xb1U4gYCWpB6cU5TUghmeQ4Sp+gOND6xuCwnrqP8bjeXEdP7rtkq35apFovcqdHutuzSg4b3YnMXGllSH+vOJDQCIELkR8LX43mLjcWUZsnfOsdCnUSuyPohNPmKk5btlwjboz4nqRTgCg6kzPAWbufSE1NKEjZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=T1xF8SmD; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="T1xF8SmD"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1772015268; x=1803551268;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Pvkws1CeOrsL7or08z9F0NghOPMEqPI3IqRRDZd64Zc=;
  b=T1xF8SmD6M7M1V/O0Vf7C3P7mEDjdoG1i+Uk1iV6XN4nvurSXT9BOcxF
   bJ0DRkPIqCPs2FlfS6D4GbPu5ZGj/jAuT0q35MEdqxaTQrp8/iKV7M5Ct
   FNuMffiwSlngWFr5Difj0BtIt09RFlV1/QMFZkZyzfbYtymKphUU5lJu1
   fvCRxcsxLwnn6KAw76VqWIkjW6OBoifFJIlSOQQhkvsO0puXNmNV96qgz
   bEisLmEkZpDVuMggzPGHGTdYwTSiQDKdUoBnQsERXASdUjEiCdT3/EdtA
   L/WgaJyL8FrRwgb7WBPE7OJTcyMyMtdJQ/b7JgZyorp+lTeOmeMxrQcAh
   g==;
X-CSE-ConnectionGUID: TeCwnOiGRUOHcglK7bgxGQ==
X-CSE-MsgGUID: aCLt7n0OS0y3/Y2oBepcIA==
X-IronPort-AV: E=Sophos;i="6.21,310,1763395200"; 
   d="scan'208";a="141040120"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2026 18:27:47 +0800
IronPort-SDR: 699ecea3_0dOVopD3nGmSk769Znm0iwl/+xAeEeSR21f/xee5nUvfyzy
 e6H/5Xits5gjU81XMrVc7Z48NdHOSnA74yjtKVw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Feb 2026 02:27:48 -0800
WDCIronportException: Internal
Received: from c02g55h7ml85.ad.shared (HELO neo.fritz.box) ([10.224.26.5])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Feb 2026 02:27:46 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 1/2] fstests: add _fixed_by_fs_commit helper
Date: Wed, 25 Feb 2026 11:27:40 +0100
Message-ID: <20260225102741.174955-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225102741.174955-1-johannes.thumshirn@wdc.com>
References: <20260225102741.174955-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new helper `_fixed_by_fs_commit` eliminating the
 if [ $FSTYP = fs ] && _fixed_by_kernel_commit XXXX YYYY
pattern.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 common/rc | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/common/rc b/common/rc
index c3cdc220a29b..73fdee6d60cd 100644
--- a/common/rc
+++ b/common/rc
@@ -1898,6 +1898,16 @@ _fixed_by_kernel_commit()
 	_fixed_by_git_commit kernel $*
 }
 
+_fixed_by_fs_commit()
+{
+	local fstyp=$1
+	shift
+
+	if [ "$fstyp" = "$FSTYP" ]; then
+		_fixed_by_kernel_commit $*
+	fi
+}
+
 # Compare with _fixed_by_* helpers, this helper is used for test cases
 # are not regression tests, e.g. functional tests or maintainer tests,
 # this helper suggests git commits that should be applied to source trees
-- 
2.53.0

