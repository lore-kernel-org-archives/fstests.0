Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2BA1AD9D9
	for <fstests@vger.kernel.org>; Wed, 31 Jul 2024 11:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722426125; cv=none; b=CphUiaxNrIt3aglCjeGdmK0ra06VQVsLAo+ecvhnbGHk9YCYQlOqiNXmWz+vHmOCoe8uc3cRUDH58FdWv0ITCLbPXLaOMIea7ui8Osk2+HJ6wk/mXg72Y2WCTJhbjpYUCm0AE3ReIeAGWI1z4toS0Ot8wHVh5i79OXx7vMKBCRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722426125; c=relaxed/simple;
	bh=EiesWp2Z9XMbPNCRUcuO5hYYX0qmcAzbDYxZjrj7IqQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O/2U4J/v7VzZuBxvyvnTws65rpWbXUe4T4XIBcIZhiTXNc/NMKWTckqm+9982oIn6LIJhOYWTEQp3E6ALKPE9GJmwB2T8ax5V02b9C2+B0xx41mgxi9+7iNInpgulNjHPh/gxlPGncP3/8S657E8kW1Ndu5PGK7ENYPg+3Z986o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=KV38/zpP; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="KV38/zpP"
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46V7dRHt005463
	for <fstests@vger.kernel.org>; Wed, 31 Jul 2024 04:42:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=facebook; bh=xkeYsR/y
	Ou9fTF/v1vPasbk+rgg5BN7hJGnExZybaLc=; b=KV38/zpPanL6L8tAhl8gS3V3
	/nFMYKzkE72fUAc2ubV6PyhCEcKL+4KIoNxtBAncf9BJKXCpi53f7y7j8y9pSeZ4
	8y2X7CjUvmaBDnU8oZft5/5eQMtpsBou6j2kIZDqiXbt2tFQyZsO37rkkAcXIQoF
	SRltVJUgIJXGesN7WyU=
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 40qa6c39xv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <fstests@vger.kernel.org>; Wed, 31 Jul 2024 04:42:02 -0700 (PDT)
Received: from twshared52931.03.ash8.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Wed, 31 Jul 2024 11:42:01 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id D01644EA91CC; Wed, 31 Jul 2024 12:41:50 +0100 (BST)
From: Mark Harmstone <maharmstone@fb.com>
To: <fstests@vger.kernel.org>
CC: Mark Harmstone <maharmstone@fb.com>
Subject: [PATCH] common/fail_make_request: fix error message
Date: Wed, 31 Jul 2024 12:41:33 +0100
Message-ID: <20240731114150.2259760-1-maharmstone@fb.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: hxbmLOL2HaylugpSwknCgG4zuWRVVTXh
X-Proofpoint-ORIG-GUID: hxbmLOL2HaylugpSwknCgG4zuWRVVTXh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-31_08,2024-07-30_01,2024-05-17_01

fail_make_request depends on the kernel option CONFIG_FAIL_MAKE_REQUEST
to function, not CONFIG_FAULT_INJECTION_DEBUG_FS.

Signed-off-by: Mark Harmstone <maharmstone@fb.com>
---
 common/fail_make_request | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/fail_make_request b/common/fail_make_request
index b5370ba6..56402021 100644
--- a/common/fail_make_request
+++ b/common/fail_make_request
@@ -7,7 +7,7 @@ _require_fail_make_request()
 {
     [ -f "$DEBUGFS_MNT/fail_make_request/probability" ] \
 	|| _notrun "$DEBUGFS_MNT/fail_make_request \
- not found. Seems that CONFIG_FAULT_INJECTION_DEBUG_FS kernel config opt=
ion not enabled"
+ not found. Seems that CONFIG_FAIL_MAKE_REQUEST kernel config option not=
 enabled"
 }
=20
 _allow_fail_make_request()
--=20
2.44.2

