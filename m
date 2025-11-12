Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58802236E8
	for <fstests@vger.kernel.org>; Wed, 12 Nov 2025 13:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762955552; cv=none; b=HiUPhA6RXebEa7J4pLC3+9FkTvBQx6ydben5heQKBBFD9XyVW5JYUFjKUZnm3yZpMupuqJKwA5W2PJGlKp1CjwlnYEmIYmqk8zXkNRIdkt2Qo5rK5or0aiPvuMLuQUoheo7lXP0NsLV6PtWXEVcWAUzm8uGVdngMXNCzPXd4xOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762955552; c=relaxed/simple;
	bh=jhPPAEuaECdlGx/Ur9iCh3Bo0V5ddtzcufUO/fSbPyE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=DGp71O+I3HHPumAanHH0baz3K9CkY/FcmuV40XhSDNImx2+2Z7Sl7a92KoaCJskEbntkp0khJFJWuqYrwoCFjmRKfU0wf5Zs3ijFqfBgSOSJUXJih7UB6jNTpwGUN86TvQS0l5uN6Y+9IjpsscSDG2Qn0LURWGpVNL5rgd6q0/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joannechien.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EOT2V2ZC; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joannechien.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EOT2V2ZC"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-295592eb5dbso9505495ad.0
        for <fstests@vger.kernel.org>; Wed, 12 Nov 2025 05:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762955550; x=1763560350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cAqmjbnFTx0PD1U3KZiXQZaIp+Ci7CPGA/Vlub4qq/c=;
        b=EOT2V2ZCnbokJL0HCsSl/ncDyb2MxoOQLbEKeCpAfLMss6zNfdTKTIiOU6bqD7RXmk
         bsbixQ5VhSMYQufhTELReGwdB+qWHeD0wG1EUGyGSJ3BAtD/Zb2nO1TyY+EWo/uA/jg2
         UoFWLBVlPpRc7jtmjisuFVVOiGLjBYtSHdcA27HLChk2lXlTvEBMDIcJhBSUucLv1xky
         eS+UVjXQjsF+sSqRCIgkvw7707TEEOuJnUhzoSYtwdP4Lxx548v7vi19wsCtWHfyF8y/
         +/ZFrudFjmaLFE8230wZfrykGTkBqFANqre/P/hj6nlikl6PzEPVcUoEXmAlkOYmEMI3
         UMwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762955550; x=1763560350;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cAqmjbnFTx0PD1U3KZiXQZaIp+Ci7CPGA/Vlub4qq/c=;
        b=olIgoNxubQpXti1d/W7LpI6ekXobf4NMD9SqFVzIAoTkaR76TIbjI6WFUlAz2HuQfB
         uz10FXFWErRDjmkm5INtCYFw98VoKhDbplLvE3ma4yevjEgJxmVJPD38hEGx8J6b0g5d
         XaBuvSitIgv7SnzjwdYJgrb/xLNR2xYekNpI0AuMMaWdjwe1GySUR2klE8AMapCgILRy
         MEZpyXieFdTLlGsNOCSI2yNcbciI0HE0wEjTQV0239r1XRJVXOro/XvKFZSthZbd2loC
         QyNeW7rAGV2bMBIr2hfx01hpyjse8Z0AQ8z/pVrgieMGDQnThE+xf0YDOQTJDdutAiYO
         HyLw==
X-Forwarded-Encrypted: i=1; AJvYcCVJOml42zAAOZRKmY8KScegh3Qm0/X6DdtU/+it18i4eKUe2riMWAkaaZTiy/1X3merUO1uXokm@vger.kernel.org
X-Gm-Message-State: AOJu0YzwS0Xpdq0rKz4Juggz8kcSEZdDpkt5/n8Ygoz6I+/avZqbXpYy
	veS/0CMRMqJpt0OvdAMDLsZFnU1TU1h45nRKbeJ/Pmx+kTC0T7AL128TD9P2j9iSABJ7YWrOG5G
	uXdmbALABdJ6I+PQ3Odrw0X7qXA==
X-Google-Smtp-Source: AGHT+IFa1/z3OmNWJRFn7pOmrLwDKdq+UncKUvLXHcY+9584LDffNgyGIdkpaXYCSTZqvtr6F2u6H1JyPVJ9JsxmCw==
X-Received: from plxe3.prod.google.com ([2002:a17:902:ef43:b0:298:33c9:abd5])
 (user=joannechien job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:38cd:b0:295:fac:7b72 with SMTP id d9443c01a7336-2984ede39d5mr36881895ad.52.1762955550222;
 Wed, 12 Nov 2025 05:52:30 -0800 (PST)
Date: Wed, 12 Nov 2025 13:52:21 +0000
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251112135223.3467852-1-joannechien@google.com>
Subject: [PATCH v1 1/3] f2fs/015: clear MKFS_OPTIONS and MOUNT_OPTIONS
From: Joanne Chang <joannechien@google.com>
To: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net, 
	Chao Yu <chao@kernel.org>, Joanne Chang <joannechien@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Currently, residual options can interfere with checking the mount
behavior of the listed MKFS_OPTIONS and MOUNT_OPTIONS. For example,
"Option#120: test_dummy_encryption" should fail with the listed
options but succeeds if =E2=80=9CMKFS_OPTIONS=3Dencrypt=E2=80=9D is preset.=
 By
explicitly clearing MKFS_OPTIONS and MOUNT_OPTIONS, the test=E2=80=99s
reliability can be improved.

f2fs/015.out is also updated to expect failure for cases that require
additional mkfs attributes to mount.

Signed-off-by: Joanne Chang <joannechien@google.com>
---
 tests/f2fs/015     | 3 +++
 tests/f2fs/015.out | 8 ++++----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/tests/f2fs/015 b/tests/f2fs/015
index 73ac3d82..6a7a582c 100755
--- a/tests/f2fs/015
+++ b/tests/f2fs/015
@@ -103,6 +103,9 @@ options=3D(
 	"norecovery,ro"			""			\
 )
=20
+# remove all mkfs/mount options to avoid affecting results
+export MKFS_OPTIONS=3D""
+export MOUNT_OPTIONS=3D""
 for ((i=3D0;i<${#options[@]};i=3Di+2))
 do
 	echo "Option#$i: ${options[$i]} : ${options[$((i+1))]}"
diff --git a/tests/f2fs/015.out b/tests/f2fs/015.out
index 8d6712f0..3df29436 100644
--- a/tests/f2fs/015.out
+++ b/tests/f2fs/015.out
@@ -38,7 +38,7 @@ Option#34: inline_xattr :
 Option#36: noinline_xattr :=20
 0
 Option#38: inline_xattr_size=3D400 :=20
-0
+32
 Option#40: inline_data :=20
 0
 Option#42: noinline_dentry :=20
@@ -120,11 +120,11 @@ Option#116: fsync_mode=3Dstrict :
 Option#118: fsync_mode=3Dnobarrier :=20
 0
 Option#120: test_dummy_encryption :=20
-0
+32
 Option#122: test_dummy_encryption=3Dv1 :=20
-0
+32
 Option#124: test_dummy_encryption=3Dv2 :=20
-0
+32
 Option#126: checkpoint=3Denable :=20
 0
 Option#128: checkpoint=3Ddisable :=20
--=20
2.51.2.1041.gc1ab5b90ca-goog

