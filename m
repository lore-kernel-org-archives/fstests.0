Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67EC351C14
	for <fstests@vger.kernel.org>; Mon, 22 Jun 2026 07:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782111906; cv=none; b=oJZqpS3ZfpSq640H2ebaGj2z8fzaYCB3lBXr87QfXTyXcg4/hfZ9E+H/0vnsbOoIGkJElbvhsTHuvFWu6T7+g8ZSD0yCEOqCCK5ARWZnGE8tdf87/6RiEpgMCZ206fuZWJoH9BG19PrZUALiBMpZG72HRe0X1AgSs11mxq/7fg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782111906; c=relaxed/simple;
	bh=lR2DKc3uUKYbJATesFe9dJ4qVX5E+i16sBGIybKqn+Q=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rYetqONH9uLcA/VuahCVIg15GZfgRnba/jfrZQU1TYvyWOo/aEV7RiaxvbuSZh1k2orJRarJr0yvfZcQRJBfDV5rn44VJ4QfQ5uN/XOoMoN9vQViCNaBli65UZxY1wyNjhB1K1hOHMoUFOl1M6uMrFQHfX1u/iynqHpq6eDfM0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jprusakowski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YyJjM955; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jprusakowski.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YyJjM955"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-bf5ea9d13f9so468715566b.0
        for <fstests@vger.kernel.org>; Mon, 22 Jun 2026 00:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782111903; x=1782716703; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ujIs4t5hz58eh39dBAa6anbidVLmJ4StFcuVqSWPC0o=;
        b=YyJjM955W9qn/qwGp7bPLmn8aFw8zGVaaSwaAj7E2h1OBYln0ns+WHlAbO+rwF8h0q
         M7FsMPpqqipvi/BfhpFqRRYgkmVrnktMWnGDgl3ue32eNKA5x+7KudCRFG5Fx8e3j+il
         vQkMq+qraeNAgqQ3CFELtqLcn9vIDk3pdfHU2kLxvnQqPtWH1r2aH78ja6neIbme/V0M
         LWNmx6YD5RRjnmd+C3sWCMk+n30smrMDE7T2pQkFGY8eG1NYTMAnpQubzDqEZAQed71b
         mDUM6lMtbvxatpcAO33Uold5ep4Wz5R9ghMr4/+5/A3hxNTrIQfGv0jVZeIDMlD3MRmm
         mpsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782111903; x=1782716703;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ujIs4t5hz58eh39dBAa6anbidVLmJ4StFcuVqSWPC0o=;
        b=UIOfJjhZrgy589xImItXwsEr4rs2XTDxRkvvJS5Ii5Y4lvN9Ab7qBzgDTa6TvJcjcU
         BoAA+Ic0+g7jFhF59maa5IgjIvaO+vgciXo+OPr6zoydrLoQPOwaB9885Q6YxU9gjmKi
         xa36HswulVOoYYhffmEsbuA9Kl7ELrYxsYKTApyWKOeMMyHyPv+m1GvWCT6N7MJrptnq
         T7rsOktjZBV4K/TXfZod0ooBNaXvKP9XlXyY/Q4ZO7FjVRZW4cSFSz0+iJiBvpjUwgOZ
         GzjYhEUUhONE8zfXE0kVD2Q47NEGVvYeCuILdmT1HCp+GQrG5/U8CDEZudDtOtbQeKyd
         xtlg==
X-Gm-Message-State: AOJu0YwW7Je9Pfdc77pyIw3Ny+Zy1wTqYq5QFhsMR/f3Y/ldtKYLMOY2
	C/8Dxo8qX0kCzOibJXXfsMtniZhAPEAycTL5LoNVAVFtL+EZtoJcRYdNNizWHXvx6hkDv2UR2Wz
	ZfmCglrxJuW2JAKjYEYtRtQg1kay65oBqagh8Bnko4k5v2R+dHwGb3XdYe7sgnQf1kkSbXzpzkB
	dg6YZ3tPRr9jgmWViLGvnhfyOrIWXr96eNzKpQLQRMb/5BkydeWUr/TnyD/YPQoR/G6ib4mQ==
X-Received: from ejbck25.prod.google.com ([2002:a17:906:c459:b0:c0f:76a8:6c5c])
 (user=jprusakowski job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:fdc1:b0:bee:323d:1239 with SMTP id a640c23a62f3a-c0989ce9151mr667323666b.38.1782111902585;
 Mon, 22 Jun 2026 00:05:02 -0700 (PDT)
Date: Mon, 22 Jun 2026 07:04:38 +0000
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.786.g65d90a0328-goog
Message-ID: <20260622070438.1542638-1-jprusakowski@google.com>
Subject: [PATCH] generic/064: allow 50 extents on F2FS after fcollapse
From: Jan Prusakowski <jprusakowski@google.com>
To: fstests@vger.kernel.org
Cc: zlang@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, 
	Jan Prusakowski <jprusakowski@google.com>
Content-Type: text/plain; charset="UTF-8"

On F2FS, generic/064 fails with "extents mismatched before = 1 after =
50" following multiple fcollapse (collapse range) operations.

To ensure crash consistency and checkpoint integrity, F2FS forbids
in-place SSR (Summary Standalone Replacement) overwrites on valid
checkpointed blocks. When collapse range shifts blocks, F2FS allocates
new data pages in LFS mode (out-of-place log writes). As a result,
sequential collapse range calls rewrite shifted blocks at new log
locations, intentionally leaving the file with 50 extents.

Adjust the extent verification in generic/064 to expect exactly 50
extents on F2FS, while preserving the strict 1-extent requirement for
all other filesystems. Data integrity continues to be verified via byte
comparison.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Jan Prusakowski <jprusakowski@google.com>
---
 tests/generic/064 | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tests/generic/064 b/tests/generic/064
index aed13970..b77eccb4 100755
--- a/tests/generic/064
+++ b/tests/generic/064
@@ -59,7 +59,13 @@ for (( j=0; j < $(($BLOCKS/2)); j++ )); do
 done
 
 extent_after=`_count_extents $dest`
-if [ $extent_before -ne $extent_after ]; then
+
+if [ "$FSTYP" == "f2fs" ];
+then
+	if [ $extent_before -ne 1 ] || [ $extent_after -ne 50 ]; then
+		echo "extents mismatched before = $extent_before after = $extent_after"
+	fi
+elif [ $extent_before -ne $extent_after ]; then
 	echo "extents mismatched before = $extent_before after = $extent_after"
 fi
 
-- 
2.55.0.rc0.786.g65d90a0328-goog

