Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D36634A77D
	for <fstests@vger.kernel.org>; Tue, 24 Mar 2026 20:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774384805; cv=none; b=ZIhKq6f62wSKQHhyuavV16h+6lmMj2nAkf9cTfy9GUaX1X4QdA8r5AYkz/9VPzndF2uLmA2aHqa1z0J5SrOn3HoHGsZo1ibgHtLZ6x2NxrU/2h7e1mzSQRg4mvwlmxm2t05gmghGtvR/yC7CkvHhwiH+SAwjAEfBun0E5ygWWos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774384805; c=relaxed/simple;
	bh=Jyvm+hAJgOFR/cXUU6E8c/lAFJ2joNdyKFhBWNxRSbc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=d8CILsO7CQxJk5HTXHVW6uJPc1HKbQqbBtjDlSz/b5kz7r1aSXOJXUA4JKuJdUUR40SYj3dPa9S8hDTuvUzjLde1QiRpIcBMbvMGrSGKakj/JgQK1+RKNi7k1oN+FtCXieuDKZkBTqRCwnwTHwlDWo97nOjCZYUCZpUwaE6xXjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SlBNQhti; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SlBNQhti"
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-79827d28fc4so50659677b3.1
        for <fstests@vger.kernel.org>; Tue, 24 Mar 2026 13:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774384803; x=1774989603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=SV5y3qN1rapkvhai2SfnVgrSnlR+8z62Znia9g0GMWw=;
        b=SlBNQhti2yPECySDVvVVkXRG7amlyc/FXFl9vzX3soSSX/jycu6ehFBRk+bW1QIvWL
         8MUHHr44WAVrjhwF7q8Pd2rbGNqIIO+TV8giBMgf/jwV5BXNQZxL5Ik0Iqko9arZYMzU
         D7c3cWaA/DjIqxbZ0mThfuHC022IxRrGWDtRDYlXd578yZxR5EVCYNUESATUdMhgd4sW
         0OzDTGXK+HRIkzArIT0KykXT/oQtKb09gLgybNvFf2leGwSOmJan7XwFU9s0Q9WAKr6k
         iH26oDK7E8cC9Zg/x8RC8gNMLeg3SjmG3ebhL1Sv9/kj1RWDubIDtA9EM1WuzpvRn3jV
         4P7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774384804; x=1774989604;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SV5y3qN1rapkvhai2SfnVgrSnlR+8z62Znia9g0GMWw=;
        b=ew4QJEeXvW54k0tKEdOqzilnXQtMBvGVHdsyGvq9JOnwIi/71MRl2HhGAIRB4Amz0C
         JwEHE20GpnY51chxVQpbLNix0W6Ach0iRDlqWO4MrvPXXrn4aGHpEbUU6QoHP2qlXPKx
         y3m9XuFXlRaOEAJfj7iMhRCk2p1Rqdkdti6qv00r6WjQsJICXppgOFW2XKL12R81b0f+
         AtO0tiBmD9n8EAEGyhF1OC3Yhgq373U9fOPDOyZtZt5dDXWIeDwhzY8LCZ6RSfNdBINK
         f8Y4Q4asFFFEXXMpAB3z1Au7xVBUef+Ze4qIIGOWe0s9IPOg//tYm4rRVFSyzxzLpQDp
         e6rw==
X-Forwarded-Encrypted: i=1; AJvYcCVfhZGgOuYKhvs5AGm956C4m6jMoYSOwfj2D/747+p9yRNq6fiaWZvG7XoApoRqjNDUyuFZE1+o@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm3U9qB7UfmWIHiItHpeK6DizKiAIPTT3PpZuMZqCmxDce5rvK
	s6fRQLeo8Jnt077e4eLB1qRrngfnHk7ErktJkxiJSDF1kF8iHnmOKBg1vpUK/tV9
X-Gm-Gg: ATEYQzw5+lgZyVeU1LQWpoUetM7O7eUdEuC8LVjgggpSdogZWllhttHD6DMKSisR1XC
	KZhtDiMINQbyn3j9V9eHu4LRHxtBWSRT8cv+E2Owtl3ouSUq4apnvroBCO6xvV2pYLM2sa45Me1
	HSipjgBsqk2i15NdvlTbalqQRSnSfGElDDa1swuEQ/NdYJL/YBlzOu8m9GF726hm4aecQ7DmInn
	lycGaTr4Of1Jg7cgxG2KpCidPlRrDxxZVL7UOoDdNznkUSnzHNyyQF2zyYPYXCLvAMDE9yXkG4R
	PsFZABBGn5jXbqwynbQFT7x+B5lTMK5jlb5X5XJR9y3RRvlvBbzv1VVcyLxxQmw6Po+QCdECwB5
	jfBS/eFAwI/6rHMexJkpDfZs8nZIgk80we/YoSR/4kVpE5uqOeobCOjYP27zovZnpb3ddUvagE5
	pvaYCdp9VPBWKuCszviA==
X-Received: by 2002:a05:690c:22c9:b0:79a:c98d:2bb2 with SMTP id 00721157ae682-79acf69623emr13165777b3.55.1774384803410;
        Tue, 24 Mar 2026 13:40:03 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:59::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a9057eb37sm77707147b3.33.2026.03.24.13.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 13:40:02 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	fstests@vger.kernel.org
Subject: [PATCH] generic/301: skip extent count check on btrfs
Date: Tue, 24 Mar 2026 13:40:00 -0700
Message-ID: <c56960b514baf810f2929b5e955a966d9955c468.1774383226.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 2/3 fragmentation threshold was designed for XFS's cowextsize
mechanism and is not applicable to btrfs. After commit 0dc118b3c327
("btrfs: be less aggressive with metadata overcommit when we can do
full flushing"), btrfs commits transactions more frequently during
writeback, reducing the extent allocator's opportunity to coalesce
adjacent CoW extents. This causes the extent count to sometimes cross
the threshold, making the test flaky on btrfs.

Skip only the extent count assertion for btrfs while keeping the CoW
write + remount + md5sum data integrity checks, which remain useful.

Signed-off-by: Leo Martins <loemra.dev@gmail.com>
---
 tests/generic/301 | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/generic/301 b/tests/generic/301
index 0303f25d..985d943a 100755
--- a/tests/generic/301
+++ b/tests/generic/301
@@ -62,7 +62,12 @@ new_extents=$(_count_extents $testdir/file2)
 echo "old extents: $old_extents" >> $seqres.full
 echo "new extents: $new_extents" >> $seqres.full
 echo "maximum extents: $internal_blks" >> $seqres.full
-test $new_extents -lt $((internal_blks * 2 / 3)) || echo "file2 badly fragmented"
+# btrfs CoW extent allocation depends on transaction commit frequency and
+# metadata reservation behavior, so the 2/3 fragmentation threshold (designed
+# for XFS cowextsize) is not applicable.
+if [ "$FSTYP" != "btrfs" ]; then
+	test $new_extents -lt $((internal_blks * 2 / 3)) || echo "file2 badly fragmented"
+fi
 
 # success, all done
 status=0
-- 
2.52.0

