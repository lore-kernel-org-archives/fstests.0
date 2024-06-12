Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B36C171C4;
	Wed, 12 Jun 2024 03:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718164439; cv=none; b=gOqVoF/2UXUdWKSFuay7bAkDAXAiV3jd25wtyfLImnnRtRjsj+Oo1UB21pD6nOpuywcY8EAx9hz4jS+6nbzhnYA7Icpl+0pW++HLprodEUXeAn8QijI2L9WoM5atC20aNptyArsKkxNp1xiDMcFOBMjBH6S3jcj+lt5wOcrkeMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718164439; c=relaxed/simple;
	bh=Gm3l44/yk0jha05XNf0EnDiNhjAQDV0ZE4m01kVK26I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZwdhYfgNLWfNIHW6mBPsMoLP6Vvp+6Huf/rYI0Bmt6GBN2dX5IDIh8GHYTdd77OtZC9GNJZNnSS2k53pGLuBw0e48boFxnJBpbyFWH1gDxgGNgxhnGMBFBsyL+a4rQljboICDksbgthZhF71/+yrOdex90nJJhcA7OyM9Hp22+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=duwwjL3P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="duwwjL3P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5EFBC32786;
	Wed, 12 Jun 2024 03:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718164438;
	bh=Gm3l44/yk0jha05XNf0EnDiNhjAQDV0ZE4m01kVK26I=;
	h=From:To:Cc:Subject:Date:From;
	b=duwwjL3PiZR1pAsDccJKuWA47s5+sGdZPrDfXN12fmHi8KfYrgWjqVl6Tga7nm/h1
	 AtVFlIcg6DOQkH1biyKB5ov2rZ7uy8MGmyVoc1PPNKMgmPgG3CXSBztgCWivVAorS/
	 halpIlcrbqhcPcnCOoVbeZprws3FpqQ4pd+gHJuQZoPM8cCvx4cMi1QhwacNUFp2B0
	 YFtOuVgoX2uLFdq0PPHdtB9cRQoql/kh83fdZSJcyHmWvSoquXCFOJSnbVhhKST/HL
	 /sjJvXivW5oyqOaooiNatweIDlvLR8tQOKbO01Rs6dlLRlqlrjrvI0futycFB7R0wo
	 rHJqpCXq2JVYw==
From: Eric Biggers <ebiggers@kernel.org>
To: fstests@vger.kernel.org
Cc: fsverity@lists.linux.dev
Subject: [xfstests PATCH] generic/574: test corruption at more offsets
Date: Tue, 11 Jun 2024 20:53:34 -0700
Message-ID: <20240612035334.134434-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Expand generic/574 to test for corruption in more different parts of the
file to try to exercise any hashing optimizations that might be used.

There is no existing bug that this finds.  This is just to prevent
future bugs, considering optimizations along the lines of
https://lore.kernel.org/fsverity/20240611034822.36603-7-ebiggers@kernel.org/

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 tests/generic/574 | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tests/generic/574 b/tests/generic/574
index cb42baaa..72440d49 100755
--- a/tests/generic/574
+++ b/tests/generic/574
@@ -194,10 +194,25 @@ test_block_size()
 	corruption_test $block_size 131072 0 5
 	corruption_test $block_size 131072 4091 5
 	corruption_test $block_size 131072 65536 65536
 	corruption_test $block_size 131072 131067 5
 
+	# Test corrupting a block in files of length 1..4 blocks, and test
+	# corrupting each block of a 4-block file.  This ensures that all code
+	# paths that might exist due to multi-block hashing optimizations the
+	# fsverity implementation may use get covered, assuming no more than 4
+	# blocks are hashed at once.  E.g., consider an fsverity implementation
+	# that verifies sets of blocks but has a bug when given a single block,
+	# or that has a bug that makes it not verify all the blocks of each set.
+	local i
+	for i in $(seq 1 4); do
+		corruption_test $block_size $((i*block_size)) $((block_size/2)) 5
+	done
+	for i in $(seq 0 3); do
+		corruption_test $block_size $((4*block_size)) $((i*block_size)) 5
+	done
+
 	corrupt_eof_block_test $block_size 130999 72
 
 	# Merkle tree corruption.
 	corruption_test $block_size 200000 100 10 true
 

base-commit: e46fa3a7dae4a65fd80128bf381dba4fd5036ebb
-- 
2.45.2

