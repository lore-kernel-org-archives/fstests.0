Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8451DD543
	for <fstests@vger.kernel.org>; Mon,  6 Jan 2025 14:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736172082; cv=none; b=ZmjXojfL1garZloF+DeBd87/N3G7nwxmsqOVbzKODxEYt15sDUpD9l4xUauXCKIJ6wxeR4v4pWRZbICkndz9NRzmp0PuiPMU9WyUdRzTdH8Wc5cKGkB+g6ib4RHrinm2/KbveQ5briVIcr+T8JWtKM38eFLKKsYzvEglIaZNtVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736172082; c=relaxed/simple;
	bh=weSaS73iLOjabmsNDp4NbPiKtfGOrG83nulZ6GiKVBI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RT4vc1cv6Z2KyPa2y8y41KSeLHbjI62UreKd/VM7+WC8ifxDXTyKniZ3FmY+FDA6j35AJdMnP9NaDiyBIMfobOZ8wHax0jfPQl64i/526VaOX50MydgalzLeb2nKNo4CZXoc1YjDALAu1Lf5xDveyRGH9pDDF3plmPvSiYPPLx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=El5IgLVQ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="El5IgLVQ"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-436202dd730so103118635e9.2
        for <fstests@vger.kernel.org>; Mon, 06 Jan 2025 06:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736172078; x=1736776878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VtJFxE+ALM3Spv3q9VMkafBFERfb4RbEXw3ei70PFA4=;
        b=El5IgLVQfpvQ45F+aSNd1Yv/TOz9K+qNITCj2QvUbLObrDtFkts5dEbuMYS00e5CTK
         0B903gncb4/LuE5YNqOIdeCV+0im6mOfu/cxYhgYZj/qHMBTGNQyv2xKSWvpsiSyvR3z
         AdAuqCWw7u4SFxed/8CJ6T1Te7qfN7pDDUgugXjCNpSW649vlsURzAUPOAgzvYjxoShJ
         gGec53oTZ1v8QZ/cMyubBxkNKwfr4sBtrnJD+pS2uNFdqjnEn7qyT39pM7/u0ee9aoUS
         5+wp6+dQNSsSpwYWe+KCZoc5JyJbMRE+lajRRtzs/2Oyrf2dzlfbK/eOChUtgSE58ruq
         FRFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736172078; x=1736776878;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VtJFxE+ALM3Spv3q9VMkafBFERfb4RbEXw3ei70PFA4=;
        b=HE/zeMSG63eoiP+CGFQcKAxjrndpDa0XfGNfo9MSKFEnyA/CvxW5uBTiSMaCCtlgqT
         909AdcUNNl8NfjRSM6ckuwU4b26tEpGAPlEurNq+owt8YoaIiGNaOliNMWr32vUanWfB
         U3o3rVMJKod+HaeJSGsTRz9BOB7lK0NsORnsASr9kiDWNLHtWX6Syxf/DfiDfzF+R1u9
         1a+kmCAvrh4nP4QmOCVtJWvDS2hLKs3psiOh1hGeCx6UojEEIebsUQP/Fb8vzROw0OCq
         Lj/g7wMmx5NKCJZSiAzPs5I0o6oGWzs6pQ7BHPOMAQycFVZDzGbK9OTtzBvhpPEvtI6T
         9Q/w==
X-Gm-Message-State: AOJu0YzS/wm3YxpkUVcAT72yHRHSGW+EBVRzhWlbqcO1Q6YjTTUQGIYA
	uT72y3fgq1R5nuOorGOyaol2Ze4yN2orDwS1Nv7Z5846Hcv+EDbLyvxpcETN6BlAF66XoVMRetl
	wisQ=
X-Gm-Gg: ASbGncu1W+9D8o6ICpXXP/s+7Ax0WttvNHqdGAHRU+qWj9/kjt78LY3aebTFjdoxxzk
	l/pMWtRQWvXMKInpFcqwhb69tx1X5P8yUs++jom2z3XFYlWmrKCRp71DyrOUh5/DnEh7JlOKX/X
	wmpn5uekQp6e9M4heagI9gN9ihgcc2KdEanr9CUvVl0IudWaxvAlXx4PTnSs1XYfxwEctL2DaBw
	79S5IV9PSh+9DfVWWXZAVAeSIJJhaPBYUlF9y25xPaTTqntTDIr45P3
X-Google-Smtp-Source: AGHT+IE4N6dd4N2bbEQe/0ddWHEm2ObeRRkdj4+yqbu76BwyuRc/pRDJpAy81wZx391QZESD9p4klA==
X-Received: by 2002:a05:6000:4a01:b0:385:f6c7:90c6 with SMTP id ffacd0b85a97d-38a221eac31mr51624871f8f.20.1736172077937;
        Mon, 06 Jan 2025 06:01:17 -0800 (PST)
Received: from MacBookPro.lan ([23.247.139.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac478be3sm1505382185a.74.2025.01.06.06.01.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 06 Jan 2025 06:01:16 -0800 (PST)
From: Su Yue <glass.su@suse.com>
To: fstests@vger.kernel.org
Cc: ocfs2-devel@lists.linux.dev,
	Su Yue <glass.su@suse.com>
Subject: [PATCH] generic/620: add '-J block64' mkfs option for ocfs2
Date: Mon,  6 Jan 2025 22:01:04 +0800
Message-Id: <20250106140104.91880-1-glass.su@suse.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mkfs.ocfs2 is using 32bit journal as default.
For 16T size device support, '-J block64' should be used.

Signed-off-by: Su Yue <glass.su@suse.com>
---
 tests/generic/620 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/generic/620 b/tests/generic/620
index 3f1ce45a55fd..60e5a2cacdda 100755
--- a/tests/generic/620
+++ b/tests/generic/620
@@ -41,6 +41,9 @@ sectors=$((2*1024*1024*1024*17))
 chunk_size=128
 
 _dmhugedisk_init $sectors $chunk_size
+
+[ "$FSTYP" = "ocfs2"  ] && MKFS_OPTIONS="$MKFS_OPTIONS -J block64"
+
 _mkfs_dev $DMHUGEDISK_DEV
 _mount $DMHUGEDISK_DEV $SCRATCH_MNT || _fail "mount failed for $DMHUGEDISK_DEV $SCRATCH_MNT"
 testfile=$SCRATCH_MNT/testfile-$seq
-- 
2.47.1

