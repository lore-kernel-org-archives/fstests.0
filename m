Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DCF50B429
	for <fstests@vger.kernel.org>; Fri, 18 Sep 2026 17:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789752762; cv=none; b=cvSloCwJ5SxwB9Sswfzr4gJTlEutekLE3a7FWSYaIKLl7lY6i4JoYd0cgB/X0+zYRXKQ68R3KQrJaNKfIyNYGyuWmVuDluKcCrP1Y4eNSVNW9qJtjkfeB4n5t51IHrSA4/mHwBm8LU6KRzfe8OoCmwJUaJIk7suPcb3DoFbwWi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789752762; c=relaxed/simple;
	bh=KGGsjQP4uHnFVgBGnrBRV6cqte1s+BjHxwGw9+SRpMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Of0bMJ73qR2o03CF6LUyzjAr0ZOIghMEM4HYKEr++8I/yw8ODrDZDmohbntaj4jIsxpVMyWm35wVbdMg8pemYHKfrIF96hRdklVYekGarzVK/lshg5zWs51XMMqNmSvPHC1jSGMqrfC6/9UABcHLxz/Ira71Ou3CGAb+MmDvY10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+8vNEVm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+8vNEVm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF3281F0089B;
	Fri, 18 Sep 2026 17:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789752756;
	bh=ZuqHvaq5wa26Hvh+PmadXdXwqlhSeZENiHE/60wlbjs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E+8vNEVm8YgU7w2b2yM1wkITwwSnGuZbV5VaOSfYu9fE01zgGfyisCQmeEsCOSaS/
	 QYSf/qW/OfccNgS+tf8P2crBJXWdCoknFlozYaR6a4po/NwYbRufwFphlI4nYjeuo6
	 BuF9I/3i5/efDMss4RAzEbcrxro2EkZSmLAkqfmrUvKUFHmzQz9tAHgry/AUMtGR4Y
	 EpjJk2Y4nGQlxc0Y3Occ4J5YZiefZm6uLiZvkb/vFBVm4LJQ6FHkQ+gnJJR3B0unEq
	 gEVxYU1cw+waz5s2qkpjqvEILdzYec6qVOGvc4+IKI8LVpt2ngAdGGKrazjiRWHSI4
	 cNAcSpTr2WqeQ==
From: Andrey Albershteyn <aalbersh@kernel.org>
To: fstests@vger.kernel.org,
	zlang@kernel.org
Cc: Andrey Albershteyn <aalbersh@kernel.org>
Subject: [PATCH 3/4] generic/452: make coping work with multi-call binary
Date: Fri, 18 Sep 2026 19:32:08 +0200
Message-ID: <20260918173218.1254465-4-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260918173218.1254465-1-aalbersh@kernel.org>
References: <20260918173218.1254465-1-aalbersh@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On some system coreutils binaries are all symlink to the single
coreutils binary. Just copying 'ls' will not work in this setup,
especially, with the different binary name.

Add 'realpath' to find out the real binary is make it behave like an
'ls' by renaming it to 'ls'.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 tests/generic/452     | 4 ++--
 tests/generic/452.out | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/generic/452 b/tests/generic/452
index a19a79623489..2166d4edd227 100755
--- a/tests/generic/452
+++ b/tests/generic/452
@@ -24,8 +24,8 @@ _exclude_scratch_mount_option "noexec"
 _scratch_mkfs > $seqres.full 2>&1
 _scratch_mount >> $seqres.full 2>&1
 
-LS="$(type -P ls)"
-SCRATCH_LS=$SCRATCH_MNT/ls_on_scratch
+LS="$(realpath $(type -P ls))"
+SCRATCH_LS=$SCRATCH_MNT/ls
 cp $LS $SCRATCH_LS
 
 $SCRATCH_LS $SCRATCH_LS | _filter_scratch
diff --git a/tests/generic/452.out b/tests/generic/452.out
index 1d24d6b3c83a..436a01e13b09 100644
--- a/tests/generic/452.out
+++ b/tests/generic/452.out
@@ -1,3 +1,3 @@
 QA output created by 452
-SCRATCH_MNT/ls_on_scratch
-SCRATCH_MNT/ls_on_scratch
+SCRATCH_MNT/ls
+SCRATCH_MNT/ls
-- 
2.54.0

