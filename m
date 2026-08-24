Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8523563CD
	for <fstests@vger.kernel.org>; Mon, 24 Aug 2026 06:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787554597; cv=none; b=Rb8u6w5Z1BLKb+4L1KYY65PE9A4JkWfYLGrESfsf0/GBooyuV9D8K1KVQlCUP3tu3R0CIfIcml6Tm927cmInFDm4E0dmNwctwKPicXIFBlKBBcWIpnWeZjNU4e7ZTbpQs4m7bQq1fTlhYNWLKPXT0i0MpOq6ZML3ov5tW2WU0N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787554597; c=relaxed/simple;
	bh=rwekPf3xPQugITbuTM3GfWoPYFNsYBgvjpf7VGD4sEM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mG9P8EUlZXYnujgZZOoif8gaBQ7GYiS3xnyFiSykLzMSiPRSBd32pdQmfmGOkFOKw3HhzLb+EnM80KnujLCxMjWjxHVaVsKXUNzU73+i2XAbPBOdnozC9viQ1f2I4wwJmSKARfoHaE3fF9NeRpf/4e9T7i+FQYC3gd938XMuuv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=etu7yx5n; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=COgSSKM8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="etu7yx5n";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="COgSSKM8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787554594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WUjrEErbT+lJBkyAIxeda04wNzwotU5NrmoWAdsS4Yc=;
	b=etu7yx5nNGoS18OdHyEMeSU2oEyfF08zruTJIEGV76d6tIlyVOHifzIJ9DNc5xjjO5Bx/w
	ak32FaC5Z+4qJl7Et0VShAKtFpNlHBSd1tdHLdtY0D5W0ObTvwHgmMY2xoKU/e4rSzqc9D
	eYERLNhz7roTLumtlGwqF08B0TfEimw=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-SGLVmFoiP2CZMrUvwvVR9w-1; Mon, 24 Aug 2026 02:56:23 -0400
X-MC-Unique: SGLVmFoiP2CZMrUvwvVR9w-1
X-Mimecast-MFC-AGG-ID: SGLVmFoiP2CZMrUvwvVR9w_1787554583
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cbee57593baso2254308a12.3
        for <fstests@vger.kernel.org>; Sun, 23 Aug 2026 23:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787554583; x=1788159383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WUjrEErbT+lJBkyAIxeda04wNzwotU5NrmoWAdsS4Yc=;
        b=COgSSKM8sCpIPX+SpYbz2gM3WtUbtNdHf8yNWsgKJByExaMu9Jj3bjI1t8AU++M5vx
         ZT3mTcHn7YWZtzD7mJW0MYZe2xuLXfNyz+Ah0bu/VIqxjUflRfGLwuYEyvhGiKxzhmrR
         isl9coXAQrJcIPTpB9H6frRnqguxptW0JWLo5YB794AXTnfnJ/cUCSktmNhqFfJT+3Z3
         Ne2pwSp+rliXMQMxKOZcqPbreNNFeBHWOyHCjZV5qzLOtG5al8ldac1zYg0A2YpPlR5B
         JgZhnGu/DgGxVzOLPtvww/ng6neGXuaZv4H1176KQejzA9EAT09XU4agzzpFeFVkHyQ1
         VuiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787554583; x=1788159383;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WUjrEErbT+lJBkyAIxeda04wNzwotU5NrmoWAdsS4Yc=;
        b=NfKEuH99OWPtvzk6ChqUWZlmDqiTDlTXbwV88e046kGl9KyoXUmfkxxlLlvSPnPBsH
         7BHm1txRiNRunxER64cJOe60wweUD1PvW5oO4epADeXjSCKDnVNQkRGCtQsq1QGGXmAb
         KSxUkYwBH3i6AwHPbOfx+InoU5AN74bGVJogCTqseX2n5EJ4evROu/L07mbT5M+c+2Yy
         VcpPZldr9gGPc3pCLfyq5+s3wJS5ATgKNep9PjNdWVGF4ki+5zEh/JSvhO/+MMWA/0bF
         0kFjV375t9sNDCN/Bqi698taIPx25tFejossXLTooffMRKUmdbxxzAlj3PLTSP+TiZO5
         x2ag==
X-Gm-Message-State: AFuF++mwF0ONfwpTGoS+79fRUYMY3g4eX7mB5v6I7TnHpndk72I8KTVD
	7KK4bmtBFYo3qzjZktQtAEXhFbfgyIi4BFCpxumuV2bwXWkbhsTGrLi6i1T3fuPaZiPHuViEk8o
	6Ud/SqbjI1/XvJOLpmwvpP4gp+QlDOSj1IimZlncPccQ3y6+kL/P2474ZpbyHGXbxlglbQjWtfW
	YfaTlQOy/85tF7BOMrBnbUQL0F+x/4TsjCXHW0gAOZ6bk=
X-Gm-Gg: AR+sD13iONYZU6uaqQzsXDHaCAB3ijv+NwEfMiQz7qYwKYec8IBPn4wblxnZyrw/PCe
	2l1cq8gWyMJ2v3m/Oe5sYZFUFUmDJEDys88zsW6f+7ge7r2xdyRpzkj7Z/IYb1LEyMT2gZUoHAe
	jHjjgvmlufm7VlRF2YwWqTL3RQgsrYbvEDKA6VY3LhrGEwZltW+YBVH3223Gf9FVf2YVRcwGPBH
	q2pwVcEwfSVtMPge+ZBqKnCiIYSbN9XOmQlidPa1+d6y6+bWVpYQC4VQXEZwECJfTMdH7uDEEUw
	6w8nHZX0Bh/TFgE9q2z81zT6LbQ5zmJeRyF5ci56UAXgPqapziaAsn4m4+fy8DwImJuxhqBxy4J
	3G9I5QV6h2FCo9dLrJ6O7OR53buQ46qnwEBU=
X-Received: by 2002:a05:6a21:1186:b0:3c0:eeb7:28b with SMTP id adf61e73a8af0-3cd2fea65b6mr46074580637.8.1787554582749;
        Sun, 23 Aug 2026 23:56:22 -0700 (PDT)
X-Received: by 2002:a05:6a21:1186:b0:3c0:eeb7:28b with SMTP id adf61e73a8af0-3cd2fea65b6mr46074488637.8.1787554582188;
        Sun, 23 Aug 2026 23:56:22 -0700 (PDT)
Received: from msinguru-thinkpadp1gen4i.redhat.corp ([115.110.157.234])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f925190fsm39419165eec.31.2026.08.23.23.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 23:56:21 -0700 (PDT)
From: Manognya Singuru <msinguru@redhat.com>
To: fstests@vger.kernel.org
Cc: zlang@kernel.org,
	djwong@kernel.org,
	Manognya Singuru <msinguru@redhat.com>
Subject: [PATCH] common/xfs: filter mkfs.xfs stripe geometry warning
Date: Mon, 24 Aug 2026 12:26:04 +0530
Message-ID: <20260824065604.43478-1-msinguru@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mkfs.xfs prints a warning when creating small filesystems on devices
that advertise stripe geometry:

mkfs.xfs: small data volume, ignoring data volume stripe unit XXX and
stripe width XXX

This warning causes several XFS tests to fail their golden output
comparison when SCRATCH_DEV has striped device geometry such as
scsi_debug devices.

Filter the warning in _try_scratch_mkfs_xfs() instead of
updating individual test expected outputs, as the filesystem is created
successfully and the warning does not indicate a failure.

Signed-off-by: Manognya Singuru <msinguru@redhat.com>
---
Tested with xfs/015, xfs/030, xfs/041, xfs/042, xfs/075, xfs/104,
xfs/109, xfs/168 and xfs/177.

Output for xfs/030 before the filter:
QA output created by 030
...
+mkfs.xfs: small data volume, ignoring data volume stripe unit 64 and
stripe width 64
...
Ran: xfs/030
Failures: xfs/030
Failed 1 of 1 tests

Output for xfs/030 after adding the filter:
xfs/030             15s
Ran: xfs/030
Passed all 1 tests

 common/xfs | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/common/xfs b/common/xfs
index 81add208..98981e62 100644
--- a/common/xfs
+++ b/common/xfs
@@ -157,7 +157,8 @@ _try_scratch_mkfs_xfs()
 	local mkfs_cmd="`_scratch_mkfs_xfs_opts`"
 	local mkfs_filter="sed -e '/less than device physical sector/d' \
 			       -e '/switching to logical sector/d' \
-			       -e '/Default configuration/d'"
+			       -e '/Default configuration/d' \
+			       -e '/small data volume, ignoring data volume stripe unit/d'"
 	local tmp=`mktemp -u`
 	local mkfs_status
 
-- 
2.54.0

