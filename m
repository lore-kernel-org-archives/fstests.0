Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CE239185E
	for <fstests@vger.kernel.org>; Tue, 28 Apr 2026 02:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777343138; cv=none; b=gaiYL3shRsO3tNs2aVGIj2ZZ3BYC2FvGPqTRuvrQ7HiK6XhGnepUtdJZKlGjolJvBS/hHORYZDQ6iG2pPMAK/9H8MQAdv/zF0IbbBTp8M5aYfVJDqJiCNDjvtbH8aZwtdQGfYu/W4TQn1IEJ+ynPVpqaP2wuUSPuIo5rFGVeXxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777343138; c=relaxed/simple;
	bh=UT66yMLW8ARFQ83A0fEq6nDqLIXcdXnnYJApOSqggls=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CzB4R/B++UPfGMBWXrHG3UTMehrnPDn2CvuuuCQ9iuw7axzx8vYsXVUboFVHqhwzz8qsL3X7BjKeiU6pM4noHzB1VOnHRiJupZWqL7/o/J3+3hluMv8jFO8iEhUJs5i2eHAFGsiyzvc4wcZdCKNBfOp1SmzztM1xlumVY0CE5HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joannechien.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XIHk27Ss; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joannechien.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XIHk27Ss"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b7c2ee830aso71434165ad.3
        for <fstests@vger.kernel.org>; Mon, 27 Apr 2026 19:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777343137; x=1777947937; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3m05/BsuNkWxYo7vhXnQHY/IOh7XjJaCl15WycXKBlw=;
        b=XIHk27SsomQ3n3pgZUfAfh25HRc5iWcNxaGqn0W/hau2cRJdx33P87i1XNrOdbbMV9
         /Cz2pgMNGy2G/kRP6XVVfWmCVFiEow5LAjqZ676fdxz50XWGzYAitl7YRsFH0NoUFC8c
         ekC5HCOAvoL2Yh7HK83EZZYHU2Ra9j6GymghJEaQU+ulTPEICM5MH5oZq7suNcqA//yu
         TZER8mQCrmLPmRJpAA/Xv8z/vkaN6mcT1YRkSVR9LmeBzvo3cWd4z64mumzZAbhyubYy
         Ki6b+rxtYi8wrM/QWlJXcOxtUXEr9DwYMN1h9oFsH2iAr6Tj0quNvrX8gwNlI9/BxwoI
         Mh3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777343137; x=1777947937;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3m05/BsuNkWxYo7vhXnQHY/IOh7XjJaCl15WycXKBlw=;
        b=DZT9jC0BpwP7KSbg6hUkYlma5QuHKGPz0p1jHhvlSss93Y9x759HGQOORY+uI6/OUp
         nqexd7lQsdESOz40ZR9ckDGJADzx7K4pJvBCh0tbjKJW8mCksF2/v1Wmz8dEz2p0bcpk
         +cc0s5RoTyKwwHv7Hc7zXOpGoglH5hv/W7Ajwo1HK5Wg9VEVzZkrK/gOPk/8mFvxZzlx
         +s9QF12XvMaXH8cdwC39KZV0SCYhlqudJxKaV70rxxCitjl7jTHAtPsqLVUUYdrFMFOd
         Avs7Da3aRsWkbJLU86j1nRDrP9TuPZR9kKJTg9NgG0gzNwyKn/FgGNKK7NIVH1S0V9TI
         0fow==
X-Forwarded-Encrypted: i=1; AFNElJ9qPn16bu/rgQVqZC1BqWPbzeyQ9OJopFYK09JRnIB+qbTK0nnVNpQxT/0UyvP5wdbq9oEWMZoJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe0+SVuxsPHmJUukSKBUPb46y0n8By7UcSjy8GPOv5W6EWVfau
	6nBuxwCLCuhcds37k0Aai0YmBXub4UzduRvQRGZaZv7bCnwi+UGtXOHON3PeB6ZGaU6S73idDqu
	qDGUnXHRMXAchsmsrqEKpyZHVNw==
X-Received: from plnr13.prod.google.com ([2002:a17:903:190d:b0:2b0:c9c5:109b])
 (user=joannechien job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:778e:b0:2b4:65e3:488e with SMTP id d9443c01a7336-2b97c4b8eeemr8219225ad.40.1777343136633;
 Mon, 27 Apr 2026 19:25:36 -0700 (PDT)
Date: Tue, 28 Apr 2026 02:24:40 +0000
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428022440.2481342-1-joannechien@google.com>
Subject: [PATCH v1] f2fs/{022,023}: clear MOUNT_OPTIONS alongside MKFS_OPTIONS
From: Joanne Chang <joannechien@google.com>
To: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net, 
	Chao Yu <chao@kernel.org>, Joanne Chang <joannechien@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently, f2fs/022 and f2fs/023 only clears MKFS_OPTIONS. This causes
the tests to fail when leftover MOUNT_OPTIONS depend on unapplied
MKFS_OPTIONS. So MOUNT_OPTIONS should also be cleared to ensure reliable
mounting.

Signed-off-by: Joanne Chang <joannechien@google.com>
---
 tests/f2fs/022 | 1 +
 tests/f2fs/023 | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tests/f2fs/022 b/tests/f2fs/022
index 728ef4e8..854ec327 100755
--- a/tests/f2fs/022
+++ b/tests/f2fs/022
@@ -23,6 +23,7 @@ _require_inject_f2fs_command node i_nid
 
 # remove all mkfs options to avoid layout change of on-disk inode
 export MKFS_OPTIONS=""
+export MOUNT_OPTIONS=""
 
 foo_path=$SCRATCH_MNT/foo
 bar_path=$SCRATCH_MNT/bar
diff --git a/tests/f2fs/023 b/tests/f2fs/023
index 33108421..f3e8785f 100755
--- a/tests/f2fs/023
+++ b/tests/f2fs/023
@@ -25,6 +25,7 @@ testfile=$SCRATCH_MNT/testfile
 
 # remove all mkfs options to avoid layout change of on-disk inode
 export MKFS_OPTIONS=""
+export MOUNT_OPTIONS=""
 
 _scratch_mkfs "-O extra_attr,flexible_inline_xattr" >> $seqres.full || _fail "mkfs failed"
 _scratch_mount "-o inline_xattr_size=512" >>$seqres.full 2>&1
-- 
2.54.0.rc2.544.gc7ae2d5bb8-goog

