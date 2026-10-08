Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EC34756CE
	for <fstests@vger.kernel.org>; Thu,  8 Oct 2026 09:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791451923; cv=none; b=CoNj46/u61+R8vjrVlcVpyx9TBL59USHgd4VgKH3t7UGqx9OzYjFDqgXSxL66n5cVo0lw3dy1tKbpT9LrqWLABvPkIUKzea1IuahRpsYnmjCT+d7BYZbCxKXbBEQrq/pl2HRrA1But0ZB1HEiug5DUalrmFpAQ6ENpQVIPYA2xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791451923; c=relaxed/simple;
	bh=c1RtyYzkXtm0864rhcoBD4dMOe3mH7Xx7JDj95Pk8c4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PA5SBBBP2BbU9jp6a2zQ46DkGO00EMlJrKjKmU9AoFfQuQ6WE3If3Fjb6MMbGUqaaUqbBNXjcGuz16FzREauVTX2pUnPup2TiyRKPQwY2i1l9E3EA3guh1be5bKnQhpBQ1CBaWci6aZBi28KzEgUvkuo9MJCXtw+SEzXQ2NJG+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jprusakowski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O8Xz/4Xl; arc=none smtp.client-ip=209.85.218.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jprusakowski.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O8Xz/4Xl"
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c2e4d39c795so531579066b.1
        for <fstests@vger.kernel.org>; Thu, 08 Oct 2026 02:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791451917; x=1792056717; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qk2wzeUjr5cHJrsg9CCba8cREUuAl6jxOiia5ToFeSk=;
        b=O8Xz/4Xlu99zbG/Z238g0HViGyWTEecTC7x/XMAheeEMm9uOjJHxeZbs/8scKvCtD2
         vN8B1HMjJDUkOiOZDdfFOMAObCEuQZ0d3yMlGK10aZ7dEMFu6r5XUYeLVH7XyILcOkGA
         5OHmARKf+I4A4eDNVG+9sLxRbWgfFeTRVpcQufAvrmJBh3BdamK0tyErjS1SFY0lQSUa
         RbYU4Mr1q3EfjzHpMGKVwHbiVP4T8mF5n0fuGCjSVYgj+imCUZ9M8VCeL9luPvIahv9g
         LCT/61OxSzO4UVsW61q+0cb3UuGY2/ZFt7v23765C9XCCwiN4mPnm726wR50eH1VAHT9
         mw2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791451917; x=1792056717;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qk2wzeUjr5cHJrsg9CCba8cREUuAl6jxOiia5ToFeSk=;
        b=cZide2uQrNe2Umss9D3Ow83TA5lLFaNHr4ANp/c3oBHrJf1LECcaoX7Cyvgm4QfK03
         O0vnjtg6Ykdz9nVA2z5PqSQuEFw/R7/zcgdIYCPvYMr9BXLtSuwk+GWHfg4O0nhrUiQ3
         0cq0wmn7GcWh+RA8C7V85T8bdoTWNoCn8t7R9J8P4nRY201l/6DXOmCKaqi9OyL+Teuj
         ybTlsawLfawyomn87ohqYMiJUlnhClXSDlxDaVDL05xFuDU5WLh2cscPGhfsJzSdQqzw
         SzhOLWWiWDG5LSH1jIpaqAj0p3GUXrPP10xr3jPosEz2bd1mZaB42WPjK4GJqdZUUi8q
         rLrA==
X-Forwarded-Encrypted: i=1; AKwUvBz4pBG0R2jgKZkHr/ySi3k7432Qpmw9KBQiI9IscyCArZGvoDb8XPQGYWDbhDlVhVi6lHFyTXCk@vger.kernel.org
X-Gm-Message-State: AFq9FYJyIFogXj3X8JpIVjh2FemWEmldAg9xDbEzx/6gtXrd0/gbRWne
	xredBLwEtrv1v2zeI7RTd6ZPskdF6ScaxU35189RlxxLlzJNwoOzQ9q71uIaWT32LBv8fd18SNl
	UgyeIGnEqSCAW8ymKghTiikQ8t1iBHw==
X-Received: from ejbbh21.prod.google.com ([2002:a17:906:a0d5:b0:c31:95dc:c07])
 (user=jprusakowski job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:dc90:b0:c2e:65f1:5c7e with SMTP id a640c23a62f3a-c317bdd7703mr463818766b.24.1791451916959;
 Thu, 08 Oct 2026 02:31:56 -0700 (PDT)
Date: Thu,  8 Oct 2026 09:31:02 +0000
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
Message-ID: <20261008093102.2791457-1-jprusakowski@google.com>
Subject: [PATCH] generic/794: add fsync_mode=strict mount option for f2fs
From: Jan Prusakowski <jprusakowski@google.com>
To: Zorro Lang <zlang@kernel.org>, Chao Yu <chao@kernel.org>, fstests@vger.kernel.org
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	Jan Prusakowski <jprusakowski@google.com>
Content-Type: text/plain; charset="UTF-8"

generic/794 tests that extending a file past a non-block-aligned EOF
correctly zero-fills the gap [old_EOF, block_boundary) both in memory
and on disk, and that the zeroed data persists across a filesystem
shutdown with metadata flush and subsequent remount.

On F2FS, kernel commit 5eced87b7d19 ("f2fs: fix to zero post-EOF data
when extending file size") zeroes post-EOF data in the partial page and
writes it back immediately before committing the updated i_size when
mounted with "fsync_mode=strict".

Mount F2FS with "-o fsync_mode=strict" in generic/794, matching other
strict crash-recovery tests (generic/342, generic/502, generic/526,
and generic/527).

Signed-off-by: Jan Prusakowski <jprusakowski@google.com>
---
 tests/generic/794 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/generic/794 b/tests/generic/794
index e10fb1f8..80be959a 100755
--- a/tests/generic/794
+++ b/tests/generic/794
@@ -154,6 +154,9 @@ _test_eof_zeroing()
 }
 
 _scratch_mkfs >> $seqres.full 2>&1
+if [ $FSTYP = "f2fs" ]; then
+	export MOUNT_OPTIONS="-o fsync_mode=strict $MOUNT_OPTIONS"
+fi
 _scratch_mount
 
 blksz=$(_get_block_size $SCRATCH_MNT)
-- 
2.55.0.1082.g2b9226bbc0-goog

