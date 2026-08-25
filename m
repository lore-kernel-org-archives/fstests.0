Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1106EEB3
	for <fstests@vger.kernel.org>; Tue, 25 Aug 2026 00:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787616828; cv=none; b=um6UqeACP/Z2w9/ZXVopNyfPBbut87VevRCSB6/y/X3tRKXg1ysCbjUjrYOMHN1yb1mJLKpeiMzSWzIA6Bw3VApgmLderGz33gMQA7C2aCEg4hv2kMc9/2E2saUAK/gDzsh0NSOrSCQ+pGkx/TZAHP/dspkhcsL+y9gDKrG8bE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787616828; c=relaxed/simple;
	bh=rLNO3tYOEtKHF/oYXHpwHTfB+7feIev/E4LxSct8f6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JugqeKNFfcAaEfS2ptgvz/vVQCAhcLIWgqZEQrAhewUi//mHs1yIqu6UafY1umtTqTfcNWXPluWAJt//2v24RhYL2cqcWJdOJgYFeATDPhZe25eBJIDLnH28W+IUIggS7D+ghBxi60KKfhS7hCFD3ZUnDdYoT6qqYav2AvpYxNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QfIeBZwG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=H21nMVus; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QfIeBZwG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="H21nMVus"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787616825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aiOxKGxqo3jx7hF7x6Ypl1GOjhdyRgd8tqTgQKEtK1Q=;
	b=QfIeBZwGKJQQU1+5Z8+cSUE4ueQS0SyN8ftPpp7T2T4kjO57hgn5no4bDpTTTNxMexkbFU
	8clUS1YGObvZLwNdSdYctlQfjnqVvqhKnPJMM1qnKrkx3OG3ZlSushne3tMoaExLeYRHzc
	OvuwhaYirNDnRUuwsksmUOAXGY2QZ9s=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-4vtioAu4NvOSx1_At86gPg-1; Mon, 24 Aug 2026 20:13:44 -0400
X-MC-Unique: 4vtioAu4NvOSx1_At86gPg-1
X-Mimecast-MFC-AGG-ID: 4vtioAu4NvOSx1_At86gPg_1787616823
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7e9e0e71e05so8102919a34.2
        for <fstests@vger.kernel.org>; Mon, 24 Aug 2026 17:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787616823; x=1788221623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aiOxKGxqo3jx7hF7x6Ypl1GOjhdyRgd8tqTgQKEtK1Q=;
        b=H21nMVusTW/jG17PViK89oJpnZqCKvKSq/rG0ZzGjJvh5fmB+nQrNnyO0fYhJg+uGN
         3MLosftk85+YLEXcfdJyFSjicBL3GvjdVLcAydnk2J1TsBsDyb2nAyYxBUGw8Jr5hc0a
         MqsGrq55K6TZrofVMxW9no/FrPEHMTJCJgSKiHAdoR7xdp1NTL5XPJOHA5vpmy3UC+48
         pVbOco7msu9+iIolgAOTk61IAIMxBoRcNd4dviCSDIIc6QhkMdikRfNoQ9LVPZ7WGbfp
         isxj7+WETlgaTvBmyo8yNdhi+01Wp84OWU1xN/4JBm8ni7uFX747dW+4D6ggPWeu5B68
         B79g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787616823; x=1788221623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aiOxKGxqo3jx7hF7x6Ypl1GOjhdyRgd8tqTgQKEtK1Q=;
        b=b+k6x0s7th5NM4ZOgtbXmzFWT40v0YZg05YQLljgnn2M+nlT1XOJu/+6O3kdsyafm3
         eMZX7Uj+bBrChuBhjdecCfQw6LWHG0F0AU8hrh5DBZoICJEFjZ/P7l114C9Y7SdE7VL1
         st7a+rwGlalbS2rDKqLBk3DdNJMCeUPjZfR+SPJ/dLmlP8hGzXROUqyacJm9dS5TEJ4G
         U131yhbkRlGO5VYb2uX9nq93nVgmtomnomcb0Hg3WlmbDofca2Yr+TV7e6rt+xlWHUWG
         4g/F/CB9tWriy6p3bDJJLwBw18Ex4dsBUFMWRpRFXCJz1u4moYXIMPGd7ESLXTWSTiv5
         SUQg==
X-Gm-Message-State: AFuF++nwPgcUt0bh9Layz/kPkJk319Wzo9rmtNNtvjS5hIdH91iTg1jt
	EfBS/Ri4WcxIWrZ9I31HvwIVq6nkj/DukUXluCTnvJDmhPrld8Ff1bwAi27U4uBY40iE4d5sC0k
	I07s1GgOM46/qbHwoFlM0vy0uX/0+MZNOJiNE89V2Syx16C7FDLj/cabwjUkTp/ZopN6kxsID4R
	lpGvQaKHW99lfK+xc1h0ki1Px9USsqOePicwNp2zf8Wdgr
X-Gm-Gg: AR+sD11lVd4t9Kt6bEWhkE+IpFiElc9ByhJfF+gED6N4gfKOVKPMyL0lNwG16/ezS7s
	DqsyGehHxG/kVI7eWO76taZKSXMWfWo9OoP4YD3SYD+ZhjVVqR1qPebR6YFRLz6wtGki7JzNSQE
	HM2RWKYdl6INgCBA1iWuIS5nuMeOPjEcUDqGNJ8YrN9Y3hvyXnQKL7r9VAsEKZTx6Iot7CYcWOc
	nEwqv/zxNPa/FlFv5atXVMx3xYoGK0spAe/ULx9H7G2x1QJfSnHkvpglrK0d4FFjLaEi/xAPGTK
	iQTDYqBFGhGpELxj+XPvL60Q/PuJneqG6SadH1Cj7f8Zj36bW8n4CYUVrSA7osS/ovoaigCnoo2
	MFUk5ZpBzSKUFK7utiVODyo4WfJa7RVu4NrYoos1sKsY=
X-Received: by 2002:a05:6830:4117:b0:7e9:e8ae:7049 with SMTP id 46e09a7af769-7f4af81de39mr2516327a34.7.1787616823371;
        Mon, 24 Aug 2026 17:13:43 -0700 (PDT)
X-Received: by 2002:a05:6830:4117:b0:7e9:e8ae:7049 with SMTP id 46e09a7af769-7f4af81de39mr2516269a34.7.1787616822711;
        Mon, 24 Aug 2026 17:13:42 -0700 (PDT)
Received: from big24.xxmyappdomainxx.com (97-127-68-83.mpls.qwest.net. [97.127.68.83])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f48fc89283sm6433923a34.24.2026.08.24.17.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 17:13:42 -0700 (PDT)
From: Eric Sandeen <sandeen@redhat.com>
To: fstests@vger.kernel.org
Cc: Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH 4/5] Add _require_hardlinks as needed
Date: Mon, 24 Aug 2026 19:11:11 -0500
Message-ID: <20260825001337.449670-5-sandeen@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825001337.449670-1-sandeen@redhat.com>
References: <20260825001337.449670-1-sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---
 tests/generic/066 | 1 +
 tests/generic/084 | 1 +
 tests/generic/398 | 1 +
 tests/generic/423 | 1 +
 tests/generic/440 | 1 +
 tests/generic/479 | 1 +
 tests/generic/520 | 1 +
 tests/generic/556 | 1 +
 tests/generic/572 | 1 +
 tests/generic/597 | 1 +
 tests/generic/681 | 1 +
 tests/generic/682 | 1 +
 tests/generic/782 | 1 +
 tests/generic/789 | 1 +
 tests/generic/790 | 1 +
 15 files changed, 15 insertions(+)

diff --git a/tests/generic/066 b/tests/generic/066
index 98674cdf..98f23723 100755
--- a/tests/generic/066
+++ b/tests/generic/066
@@ -34,6 +34,7 @@ _cleanup()
 . ./common/attr
 
 _require_scratch
+_require_hardlinks
 _require_dm_target flakey
 _require_attrs
 
diff --git a/tests/generic/084 b/tests/generic/084
index fe758f11..05f2f4ba 100755
--- a/tests/generic/084
+++ b/tests/generic/084
@@ -25,6 +25,7 @@ _cleanup()
 . ./common/filter
 
 _require_scratch
+_require_hardlinks
 
 link_unlink_storm()
 {
diff --git a/tests/generic/398 b/tests/generic/398
index 40d7b6e3..a6939b22 100755
--- a/tests/generic/398
+++ b/tests/generic/398
@@ -20,6 +20,7 @@ _begin_fstest auto quick encrypt
 . ./common/renameat2
 
 _require_scratch_encryption
+_require_hardlinks
 _require_renameat2 exchange
 
 _init_session_keyring
diff --git a/tests/generic/423 b/tests/generic/423
index 9d41f7a8..36f8dccc 100755
--- a/tests/generic/423
+++ b/tests/generic/423
@@ -27,6 +27,7 @@ _require_test_program "stat_test"
 _require_test_program "af_unix"
 _require_statx
 _require_symlinks
+_require_hardlinks
 _require_mknod
 
 function check_stat () {
diff --git a/tests/generic/440 b/tests/generic/440
index 1c8e3e8f..9d80cf04 100755
--- a/tests/generic/440
+++ b/tests/generic/440
@@ -20,6 +20,7 @@ _begin_fstest auto quick encrypt
 
 _require_scratch_encryption
 _require_symlinks
+_require_hardlinks
 _require_command "$KEYCTL_PROG" keyctl
 
 # Set up an encryption-capable filesystem and an encryption key.
diff --git a/tests/generic/479 b/tests/generic/479
index f9661001..ceeaa754 100755
--- a/tests/generic/479
+++ b/tests/generic/479
@@ -26,6 +26,7 @@ _cleanup()
 
 _require_scratch
 _require_symlinks
+_require_hardlinks
 _require_mknod
 _require_dm_target flakey
 
diff --git a/tests/generic/520 b/tests/generic/520
index 3c7ae615..d03c726c 100755
--- a/tests/generic/520
+++ b/tests/generic/520
@@ -28,6 +28,7 @@ _cleanup()
 fssize=$((2**20 * 256))
 
 _require_scratch_nocheck
+_require_hardlinks
 _require_dm_target flakey
 
 # initialize scratch device
diff --git a/tests/generic/556 b/tests/generic/556
index 279ff58b..7c5d0371 100755
--- a/tests/generic/556
+++ b/tests/generic/556
@@ -15,6 +15,7 @@ _begin_fstest auto quick casefold
 _require_scratch_nocheck
 _require_scratch_casefold
 _require_symlinks
+_require_hardlinks
 _require_check_dmesg
 _require_attrs
 
diff --git a/tests/generic/572 b/tests/generic/572
index c3059eb2..97f99a53 100755
--- a/tests/generic/572
+++ b/tests/generic/572
@@ -29,6 +29,7 @@ _cleanup()
 _require_scratch_verity
 _require_chmod
 _require_chown
+_require_hardlinks
 _disable_fsverity_signatures
 
 _scratch_mkfs_verity &>> $seqres.full
diff --git a/tests/generic/597 b/tests/generic/597
index 3aef67a1..6256c4f4 100755
--- a/tests/generic/597
+++ b/tests/generic/597
@@ -37,6 +37,7 @@ _require_group fsgqa2
 _require_user fsgqa
 _require_group fsgqa
 _require_symlinks
+_require_hardlinks
 
 OWNER=fsgqa2
 OTHER=fsgqa
diff --git a/tests/generic/681 b/tests/generic/681
index 651ee157..14bc78bc 100755
--- a/tests/generic/681
+++ b/tests/generic/681
@@ -24,6 +24,7 @@ _require_quota
 _require_user
 _require_scratch
 _require_chown
+_require_hardlinks
 
 _scratch_mkfs > "$seqres.full" 2>&1
 _qmount_option usrquota
diff --git a/tests/generic/682 b/tests/generic/682
index 80846463..964200c7 100755
--- a/tests/generic/682
+++ b/tests/generic/682
@@ -25,6 +25,7 @@ _require_user
 _require_scratch
 _require_chmod
 _require_chown
+_require_hardlinks
 
 _scratch_mkfs > "$seqres.full" 2>&1
 _qmount_option usrquota
diff --git a/tests/generic/782 b/tests/generic/782
index f3298a70..ef6f6a8e 100755
--- a/tests/generic/782
+++ b/tests/generic/782
@@ -23,6 +23,7 @@ _cleanup()
 . ./common/dmflakey
 
 _require_scratch
+_require_hardlinks
 _require_dm_target flakey
 
 _fixed_by_fs_commit btrfs bfe3d755ef7c \
diff --git a/tests/generic/789 b/tests/generic/789
index 0e72966e..7cacf238 100755
--- a/tests/generic/789
+++ b/tests/generic/789
@@ -22,6 +22,7 @@ _cleanup()
 . ./common/dmflakey
 
 _require_scratch
+_require_hardlinks
 _require_dm_target flakey
 
 _fixed_by_fs_commit btrfs 5254d4181add \
diff --git a/tests/generic/790 b/tests/generic/790
index 28f7faa2..44de7bb8 100755
--- a/tests/generic/790
+++ b/tests/generic/790
@@ -25,6 +25,7 @@ _cleanup()
 . ./common/dmflakey
 
 _require_scratch
+_require_hardlinks
 _require_dm_target flakey
 
 _fixed_by_fs_commit btrfs 9573a365ff9f \
-- 
2.55.0

