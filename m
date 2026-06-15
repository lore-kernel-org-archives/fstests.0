Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296002F7EE5
	for <fstests@vger.kernel.org>; Mon, 15 Jun 2026 09:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781514365; cv=none; b=JZa4QeaCCr+ys6vd0nPDMan3SJm33N36kEHZLU99catoPLvtkRCxVVWU68KGaD6d63YSR2R0rHNJylqGLADwIU5v68ID3TXtvc2lABdl14Fzr/u4I6G/COfVjJ55e9tu8Vnk+heGOTBvE7+JDq7RCo0FNgrazhBu0XEYtwaz6Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781514365; c=relaxed/simple;
	bh=KRRoPxA5a9i/8z3RQ7icxQmONRZnok+glsVtKtkq6W0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=McdQhBR4BUoF0eCEKzImS2q9HCmQnxgW7wLahTRCkJrPlTj/zFrb+zcXURuVHllBuEi4edcQKMV46pMKJkZloIsC2/XRKFn/6XMzCpxPmPr156h5a3VexXz0GfIhGy9cGQAqXZkcgaVbkSlNZYfJUo5A86JkGO/zp5ShNbnFuGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=icBl4NEk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="icBl4NEk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEBD71F000E9;
	Mon, 15 Jun 2026 09:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781514362;
	bh=XZy5wMSiDgSztcVXwwgsTdupiVNDTJpjLK9MK/K3gSY=;
	h=From:To:Cc:Subject:Date;
	b=icBl4NEkjZYxoQaAesNy536AkUfliP4BEpdFucWqv7Ei/M/hkX5WYsI8fDvBnhgKp
	 W4o1npOU0ACDrEETt8VF4tjB3qt3Ellmj8XnlNxYZmtdjULcf7NFgkiIkgw++uQi8s
	 njEzZp5+9INUEkO0RtTB9y9gYNYGRjw4MH8ztUvKZPuEAJiQAdS1Iukgr878RCe5fX
	 PgUtckRNxO+CUZcEXRWGQpoN/cQOW/5JUEmlJsCz5vG8mp/GQdUYA0ilySKngpBzWg
	 IbaGfo+4JvJNP9EPXAbUVHII+WVyZLeKLYigRiOZzTc9qe22Ays6fvYCM06+95w6q5
	 hQhqt8jHvzvNw==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs/009: use common _scratch_shutdown helper
Date: Mon, 15 Jun 2026 09:05:58 +0000
Message-ID: <20260615090558.1627456-1-chao@kernel.org>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

f2fs has supported ioctl(_IOR ('X', 125, uint32_t)), so that
"f2fs_io shutdown" can be completely replaced w/ _scratch_shutdown(),
let's clean up in f2fs/009.

Suggested-by: Zorro Lang <zlang@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 tests/f2fs/009 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/f2fs/009 b/tests/f2fs/009
index fa4a39d16..39a4bad3d 100755
--- a/tests/f2fs/009
+++ b/tests/f2fs/009
@@ -12,6 +12,7 @@
 _begin_fstest auto quick
 
 _require_scratch
+_require_scratch_shutdown
 _require_inject_f2fs_command node i_links
 _require_command "$(type -P socket)" socket
 
@@ -106,7 +107,7 @@ ino=`stat -c '%i' $filename`
 $F2FS_IO_PROG write 1 0 1 zero atomic_commit $filename 5000 >> $seqres.full 2>&1 &
 stat $filename >> $seqres.full
 rm $filename
-$F2FS_IO_PROG shutdown 1 $SCRATCH_MNT/ >> $seqres.full
+_scratch_shutdown -f
 sleep 6
 check_links 1 0 $ino
 
-- 
2.49.0

