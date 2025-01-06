Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7BA1DE2DC
	for <fstests@vger.kernel.org>; Mon,  6 Jan 2025 14:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736172095; cv=none; b=u5FSn6PAKBnSnhjYstmeT5TqIjXMYa2bzBKeY1O1WF8Oj33JI6OHH/OkGY8e2y3nsb1vfdmCaRrBnkvd+J3SavW0WN17wfTFa3DrQyBAglofJmOGMpSsFlDLUxBzrQIBRUXtvQgPS91NVXE64f9aTI3dx3RT7bFFk+68ti2XzaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736172095; c=relaxed/simple;
	bh=ustdWhN8B7AxEmjNSenhEvMBMTZjhkclrTBp50RGrv4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P8qRsRW4SoKht9wpF8CUHNjDcqq00OSIJVrHB+D9HKc6TAu2jpMUdR/n0Xcp5M3JjtmsOeQ57WiISMLy1AAvW2S8PB7f8CaZI1OkVJ2le15CscLBJmw+xls8OeAEmvn1eyIWh7rWhSbhjbBqng+LxcfRUx2HREvrwOrCkqX5K+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=U/+c43Il; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="U/+c43Il"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-385de9f789cso10815190f8f.2
        for <fstests@vger.kernel.org>; Mon, 06 Jan 2025 06:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736172091; x=1736776891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jhRAQfQjH1uGJhH2qOUgRmb0lkyZNgt9BBAljl/5XuI=;
        b=U/+c43IlJDQKtpH6GB/jvrMaONcoEICIwP4RUm4eq+84UaE3NC5633+qaqYIRHLXkw
         SScAgARpHQl47hGB95D4iDj8epAH6hvOAIF7G2sBPpQwtAQFyvUGOhsItvt2Dn77S+Ng
         I1OVkOAPHC8/27B4OZ4wL0Ckb403+KfakRMy39FOS2Q596k7UMX0R/ivZ6YUN3rdhB8X
         wR+gd9lNpU2aUlLzVNsdD9OGt73cqdWhF5Ui0wfm/unqwmhESdj2YAuhdUsbWK+GINyo
         NgfZ2MZKnx7B//Tr4VUA2OPA8mT1CyYiOlWUjZeCp8l3fZy1i96A3PpfkyNg5icqj+ln
         fvKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736172091; x=1736776891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jhRAQfQjH1uGJhH2qOUgRmb0lkyZNgt9BBAljl/5XuI=;
        b=NJDjKHFbEl3hdD1X5IbjOjTXsEVg6tY+PVYJWmvO5jPWQ6ZNMooN14gLswzknyg34K
         N5ChzmJsbv6nngDhXzAXCIRQPhyxPccV5jl78QtDwt1Re5EjVbeMsoEmMYsGCW/aeFu5
         fBdNZTySccLP1qpVmUn1Mk7jtDW9UpuxpryDoPyUsbNNrneZSDFcblXOiWmprgJ7wXv6
         hmYk7BKiqlp2DQ8UlTqSXc5INEUGnL04OKC9re7D8eN2e77hgCjdblXcv8B0/QyRNfcw
         PtN1OBFXCvEuqaqFPqOeGfH85ZOVfZWE3DyMuAULErJUe/+EpJDlEamaPdDyADfHMgns
         PllQ==
X-Gm-Message-State: AOJu0Yx2IoxOVBLcpvor//kGP97ZkEChozXVlKgSUBZ5G+TBkeiHzEfS
	lON5oB6f1j+sWxBW84ZrxviCohF78Lcp2S8UBth9prs8i0Mxr1WvxXtwE8tFsuT7+kBvmz7K1/k
	3TSM=
X-Gm-Gg: ASbGncs1jP158OYBzu3n0nmiNxz3s8tuJdORnQGa6SkHDsRwyQDI/iem3Rxne+RmIkQ
	JtbUnOL+QXT0lwS2bH91YHDj7xbh3lq2nUvqTJsOUavHfXd3CTJehx5HofXZ6VPPK5UXe6yv8IL
	mUT7CJgsvG35cB6IYEsJYW3C76cz+l01UIbVT0XNpi77xoIMGnYCNgxeu/Fy+zN7POGRdqfHGrn
	x3vgddbLDFiAzNjj1UPNcswk+qMtkfHqNGshFbqpwTat+vX1ZIc4Bzw
X-Google-Smtp-Source: AGHT+IHPYL6GOfFsut0WtPgHEJwsoPCYaLQ0m68SILlMc08KM4u5gSm96RDuXyNjPH0BjrDHmWVhBg==
X-Received: by 2002:a05:6000:4603:b0:382:38e6:1eb3 with SMTP id ffacd0b85a97d-38a221ffbcamr41054462f8f.30.1736172090857;
        Mon, 06 Jan 2025 06:01:30 -0800 (PST)
Received: from MacBookPro.lan ([23.247.139.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac478d9esm1512704785a.77.2025.01.06.06.01.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 06 Jan 2025 06:01:30 -0800 (PST)
From: Su Yue <glass.su@suse.com>
To: fstests@vger.kernel.org
Cc: ocfs2-devel@lists.linux.dev,
	Su Yue <glass.su@suse.com>
Subject: [PATCH] common/quota: filter out option projquota in _qmount_option for ocfs2
Date: Mon,  6 Jan 2025 22:01:24 +0800
Message-Id: <20250106140124.91928-1-glass.su@suse.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ocfs2 doesn't support projquota but does support usrquota an grpquota.
For now, two tests generic/594 and generic/603 are for testing
usrquota,grpquota and projquota. The mount option 'projquota' causes
failure of ocfs2 mount.

To make things simple, just skip the tests for ocfs2.
However, we can't just put '_require_prjquota $SCRATCH_DEV' before
_qmount because f2fs and xfs need runtime after mount of SCRATCH_DEV.

For ocfs2, filter out option 'projquota' in _qmount_option() to make
_qmount successful. Then in _require_prjquota(), ocfs2 will fallthrough
as a no kernel projquota support fs type.

Signed-off-by: Su Yue <glass.su@suse.com>
---
 common/quota | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/common/quota b/common/quota
index 8135b7c044bf..8688116c6547 100644
--- a/common/quota
+++ b/common/quota
@@ -325,6 +325,9 @@ _qmount_option()
 		OPTS=`echo $OPTS \
 		| sed	-e 's/\bpquota/quota/g'	\
 			-e 's/prjquota/quota/g'`
+	# ocfs2 doesn't support "-o projquota"
+	elif [[ "$FSTYP" == ocfs2 ]]; then
+		OPTS=`echo $OPTS | sed -e 's/prjquota//g'`
 	fi
 	# Ensure we have the given quota option - duplicates are fine
 	if [ -n "$OPTS" ]; then
-- 
2.47.1

