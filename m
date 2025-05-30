Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9B3250BF2
	for <fstests@vger.kernel.org>; Fri, 30 May 2025 19:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748633242; cv=none; b=JxH1WJTBPaOOGIuFUG97fJY51yeofEA7T35mQn4qFegqSqW8AFRWnCR8ZNoQ61Lam5+uO3+uxL2zWYYL6Fw2a20JRR/rYtEBekbUjb83czK1yL/pjjWIl2QfzpCkYcJ5kTG9dbjsuWcqHkoy8Jvz5snfKH1q5opC+uoxF7Y/jh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748633242; c=relaxed/simple;
	bh=4NluUG3tuEpLn0sSJoMw1YdqYIvG7SKUadYxUF4uRn4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JS28BYhouTWUdt1789ucuB4OCkavYEu1RTWEEqYFVd9nsmWgmo+95ZWH17x0HYPH7ujjh+zRA0+RLpfGYK4OU2usMcMZOJTf4QB0pDQ9E9y/XL7NsEmc+zx3pAldToFDz//GC9L0d/JF+WchveiHQxXsdIRkZPv8li52hejQlrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUmgttsL; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUmgttsL"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2351227b098so16201605ad.2
        for <fstests@vger.kernel.org>; Fri, 30 May 2025 12:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748633239; x=1749238039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m8Ir+3llqSerF6BR88UwGFrp/V8FoaJnuHXI+B+W0+c=;
        b=HUmgttsLvYagFtJ40o91Y1gkLwclZ0PABTv+6RmBFr0NAN9ejDKQqZ2CyO2DB4Okpc
         6kUKvCqahYdURR47o0Kv50pouzn/3CPiKelMPVpyNq1mky29YBkmTsR6mKZHfzN3OVLd
         qWvSb4auG25415dcVlR/Y1pD2oRda0b+z9k0OiOgglPOkJJQjVQTsGCatlt/ZePmFsCw
         kw0vsSfdDAywRp5cc5rVNTJ4t8tY6Kacrgcl82M6KCrOsJUjG03QRToKT1t3o7+zkH3r
         FiORNPdR37kJOQ7XYa/2YXt+ChA9BBWuLR0zOaZpBWgf2JdqYSgyPWR5ft9wycT/JJMh
         YUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748633239; x=1749238039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m8Ir+3llqSerF6BR88UwGFrp/V8FoaJnuHXI+B+W0+c=;
        b=pZsC2oIUO0IY2Oj8ZN9LBHArxRPzPx8tcjMuKM+Q50AsY/jA7wK8X6xY4yl2JAxBm9
         TOFFrfJOtqLdjlyo4RvPB/YGW40RYmV/EzKzbWknYNFSl5STnwfLQqKRrbmqzbBL+h9g
         hysvayTqpaUZuzcqFbGT5NMYAe1nSAhK4OnAB66fT7ak7RZl4JVjXo3z/Y7LnRLHd/M1
         B4OvMO0/rMQjgPDUHS8JX3gl4cAeN8njSG/imKhGTtIWDdGBT2saR2jTO7TSLHflMl4/
         5xoGI0rcGuH9roVYOULPyN4p/ho3K0a8yaa7YIjIT7m7rRnzhF28tUfbqndGlhBMb5WW
         1few==
X-Gm-Message-State: AOJu0YwYoAhJ3R/5Qm56ClTVKB5tige0CfZPw/NfHmX0TLuVT1YxQEZp
	kNJBDzerPRC+BTJs2xZ2FlhJeYR0yPFkZf/bY4JecivR2q31QkPWdH8dYnAgVyFs
X-Gm-Gg: ASbGncsLG5wd9LPvPsjLblF1NtO03WZOI4UDlnt9c8wFTnd4HniQvomuAV7vcM4NUB0
	jLvWQVk7ch3wykVx6yAX+lwQi+iGfReH5isISK4cc4KzfnzPVVGgcpvKnVTT5KVXtj5qJ3802JK
	XWZJ7XfLEOZTfxbOD4bAPQouPhdt1Xzf0cbN3iXpmyFUaYJDAyvK9xgN+EHp3HYulRvYnyN/ZPX
	GKzxRJEyY3LAKjV6EPpj5/gJJ1+Vl2lhR1eDwR4X2HP9ZOq7i+qIbyJ+e+WlmlOeAB6iZ85uNaO
	oCIsx2D6M0rXfo+MP5+OAjvhj1qP1z8cHYliL0SdmQCohJQj0C7q3JA1lRkju3okIzIRFGN7HcF
	/Wys=
X-Google-Smtp-Source: AGHT+IHaMsp/1jJLReNzFF91SMechH4c+NtdgJEbvgTC29BauQuqa3lVhbap1b350F59Z32l1UW1eg==
X-Received: by 2002:a17:903:1663:b0:234:aa98:7d3e with SMTP id d9443c01a7336-235291ee300mr69639385ad.29.1748633239479;
        Fri, 30 May 2025 12:27:19 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:8e78:f3ea:786a:9734])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cf9380sm31842085ad.203.2025.05.30.12.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 12:27:18 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: fstests@vger.kernel.org
Cc: Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH] common/rc: add repair fsck flag -f for ext4
Date: Fri, 30 May 2025 12:27:11 -0700
Message-ID: <20250530192712.2643365-1-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a descrepancy between the fsck flags for ext4 during
filesystem repair and filesystem checking which causes occasional test
failures. In particular, _check_generic_filesystems uses -f for force
checking, but _repair_scratch_fs does not. In some tests, such as
generic/441, we sometimes exit fsck repair early with the filesystem
being deemed "clean" but then _check_generic_filesystems finds issues
during the forced full check. Bringing these flags in sync fixes the
flakes.

Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
---
 common/rc | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/common/rc b/common/rc
index daf62c92..042f6c36 100644
--- a/common/rc
+++ b/common/rc
@@ -1496,19 +1496,24 @@ _repair_scratch_fs()
 	_check_scratch_fs
 	;;
     *)
 	local dev=$SCRATCH_DEV
 	local fstyp=$FSTYP
+	local fsopts=
 	if [ $FSTYP = "overlay" -a -n "$OVL_BASE_SCRATCH_DEV" ]; then
 		_repair_overlay_scratch_fs
 		# Fall through to repair base fs
 		dev=$OVL_BASE_SCRATCH_DEV
 		fstyp=$OVL_BASE_FSTYP
 		_unmount $OVL_BASE_SCRATCH_MNT
 	fi
+	if [ $FSTYP = "ext4" ]; then
+		fsopts="-f"
+	fi
+
 	# Let's hope fsck -y suffices...
-	fsck -t $fstyp -y $dev 2>&1
+	fsck -t $fstyp -y ${fsopts} $dev 2>&1
 	local res=$?
 	case $res in
 	$FSCK_OK|$FSCK_NONDESTRUCT|$FSCK_REBOOT)
 		res=0
 		;;
@@ -1548,12 +1553,16 @@ _repair_test_fs()
 	yes | $BTRFS_UTIL_PROG check --repair --force "$TEST_DEV" >> \
 								$tmp.repair 2>&1
 		res=$?
 		;;
 	*)
+		local fsopts=
+		if [ $FSTYP = "ext4" ]; then
+			fsopts="-f"
+		fi
 		# Let's hope fsck -y suffices...
-		fsck -t $FSTYP -y $TEST_DEV >$tmp.repair 2>&1
+		fsck -t $FSTYP -y ${fsopts} $TEST_DEV >$tmp.repair 2>&1
 		res=$?
 		if test "$res" -lt 4 ; then
 			res=0
 		fi
 		;;
-- 
2.49.0.1204.g71687c7c1d-goog

