Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEEA2F2D
	for <fstests@vger.kernel.org>; Mon,  6 Oct 2025 09:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759744717; cv=none; b=NRBSAdcb+n524Y4AFJH3XnDMOsZaXs/dZoaGqY5+UR3u1OUJULQ84K7z15Ui5Qb80Pf0w6YA6etHjMG6HQekTCfsvDgJf0QAI3/FRnQOc6mH0UXZP/9le7MTcS1ZpVft46vNIA7CW4C+mt2JSNNZtTNKt9p0ODR1xWn6WJdspes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759744717; c=relaxed/simple;
	bh=tuyw+rQN52fKBBrA28TI7nHi+GHMhzTaISK7mFLQqEc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ToINsBXk0enMTEmNYBtdEKOSU3uyoVJCJL54SCHQaXZvvbILGfDmHvwqRy5gaIdluO/U/4lZWAk5LaQipgmQNe3CiYlEGzYqAtmRItVsEy/6ePkEvNObK8Ki2PgHlymJGV/7CC7+MdBihVOybhpFcZo7lw91e4PVGdcXARnNrIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jprusakowski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4YdyUPFO; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jprusakowski.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4YdyUPFO"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b41c67edce5so482701766b.3
        for <fstests@vger.kernel.org>; Mon, 06 Oct 2025 02:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759744714; x=1760349514; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Sc4vGQFYPIBaWztyvb1x80Wmo5m+eEeS575TWEadZus=;
        b=4YdyUPFOSYUn8DIcW061N+685gpR0WybxQ+7HhgRwbuoBrrDg8TmiYdyibvfXEdA7h
         97RcoArL576CE5ZyoB3P9yFxFciA1GRG7SKMVtA9Uw9ANEAic8P+jEK8BcQzpE1KJZ/0
         +nu6tj+KJNueG4eKyJqYZSpIrFTWX1EpueWRTj4KwJ+rCKNkV9jhTU0fv5m3QEeIMUki
         ShhcDaY1aTe9KGdR1VY0N0s9BSF67LeQZnyuX2/RU77SMApbElD+Qg3WHnDN30ih82gY
         ZziSZnhh4dpxrPZ+9S1+G9p+umenoK9AV4dCoIFsPKvdTyU6r+ZBVTWfHCX9+vI26fuU
         ZIEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759744714; x=1760349514;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sc4vGQFYPIBaWztyvb1x80Wmo5m+eEeS575TWEadZus=;
        b=BAEvXOFk++dVEBjjEwIL9SfxOown1INHPsDC4axy0pgXCBkX/9p3pqp6vxjlwrSVr/
         wqXShj1IoCfoUdfT9HT7QBrPG4FAXBwzP+D3ILWkHxFoZBmmu8aZ2G1UFYFAJjSDOCOQ
         mpL1DsFRudP2SSnxI4EzU5LwM8QfWW4OujKncac3bMVorIf5S58PzcRieUzXCegzCQEQ
         g3sUuNjyj8bLupUrDCMzystGm/3Il2+9Z1GLAR/2Nr6tdF2CxUc0tEj2S0YjYQmUlSO8
         GFYJxdhTserHp+fs++aFR4r6Pl/5zwm54c9i2we+COvrBqSqfcIbPuvdlO4l4p61Uazl
         MINA==
X-Forwarded-Encrypted: i=1; AJvYcCXmjqo9HiRZP6nbkIxxC8j0wiISsuRH79YV4ugmeuciHo4RGwfNEWg2qZomsG/kB8WXUHnK2H/0@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/YYXMUgiywQ1S2PT7aJZLGbTP8Yerx8cYc04SRLma+kqZxAbs
	xn7U1WxBuP7cxqqazQdRQm9mlA3rPYWusHRogs3DtGLcm8f8GPFmowrnYhpG5GxhixKVoaUklB4
	qtYdJNPY5Xl5UaOVTAKBpGyGu6UxflA==
X-Google-Smtp-Source: AGHT+IH38hWGPvZTjm7gSlYootDowCEylUmuxNHmWeR8Ovsb7/fEr161qyR4TF7YXSyDwiHegDbvcDrCXNF/znzR6Eo=
X-Received: from ejbci9.prod.google.com ([2002:a17:906:c349:b0:b3d:d79a:5f98])
 (user=jprusakowski job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:3f21:b0:b38:6689:b9fe with SMTP id a640c23a62f3a-b49c2a576ebmr1293699966b.7.1759744714330;
 Mon, 06 Oct 2025 02:58:34 -0700 (PDT)
Date: Mon,  6 Oct 2025 11:58:13 +0200
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251006095813.3497619-1-jprusakowski@google.com>
Subject: [PATCH v3] common/encrypt: Explicitly set the test file to uncompressed
From: Jan Prusakowski <jprusakowski@google.com>
To: Zorro Lang <zlang@kernel.org>, Eric Biggers <ebiggers@google.com>, fstests@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, 
	Jan Prusakowski <jprusakowski@google.com>
Content-Type: text/plain; charset="UTF-8"

verify_ciphertext_for_encryption_policy() checks if encryption works
correctly by reading encrypted file's contents directly from a block device and
comparing it to a known good ciphertext.

This, however, won't work if the test file is also compressed. So this patch
adds a check if a test file is compressed and disables its compression in this
case.

Signed-off-by: Jan Prusakowski <jprusakowski@google.com>

---
Changes in v2:
The test file is now created empty first, followed by resetting the
FS_COMP_FL attribute, and then copying the test data.

Changes in v3:
Added explicit FS_NOCOMP_FL attribute to the test file.

---
 common/encrypt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/common/encrypt b/common/encrypt
index d4f6e3dc..f2687631 100644
--- a/common/encrypt
+++ b/common/encrypt
@@ -790,6 +790,13 @@ _do_verify_ciphertext_for_encryption_policy()
 	_set_encpolicy $dir $keyspec $set_encpolicy_args -f $policy_flags
 	for src in $tmp.testfile_*; do
 		dst=$dir/${src##*.}
+		# To make sure the test file is not compressed we create an empty one
+		# and disable compression first (F2FS won't allow resetting the
+		# compression flag if the file has data already in it).
+		touch $dst
+		if lsattr $dst | grep -qE ".+c.+ $dst" ; then
+			chattr -c +m $dst
+		fi
 		cp $src $dst
 		inode=$(stat -c %i $dst)
 		blocklist=$(_get_ciphertext_block_list $dst)
-- 
2.51.0.618.g983fd99d29-goog

