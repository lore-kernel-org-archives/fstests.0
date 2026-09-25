Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC93D42903B
	for <fstests@vger.kernel.org>; Fri, 25 Sep 2026 10:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790333126; cv=none; b=q9lUoF2tF9gT6yQPaTu6JEBe54qtjAn/eR3FgjLUU6xizuOYxl7ZybgjGZ7d6kCMuSKAP2gHNkBFqvdQrLlQyPm9cWMNUYXeHlJz8mOYANtYMM1/vb8I0wT6POC5buo2xF2fHStChSHx9rdSeZZGdIJxZZ7TrzoWa0dIDlmytxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790333126; c=relaxed/simple;
	bh=ouB1CfNyFOfJpUE8lgkL7HZCjyAiUFZhxDheS1yQa1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q8BkPHDDpLfFNPdm4Vcv1P7fCybcWC29G1eQOL1hsUI1WXdq7N01iDqLYWf5eCleI7cu6+ZY9YiGZlLf+rS3z2Dw5s/el4SQLXRo7QIcIfcnbSN6YK/k1NoKSab/8/1if/ViDpCkuiBR5+QEpENKTGJrdwAIpgIADm2VZVEMP8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/3tTS9F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/3tTS9F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E6E1F00899;
	Fri, 25 Sep 2026 10:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790333123;
	bh=mO4ryxeYeyBf71971oqEhgXfNXerWub5yoFGmGJVbwU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B/3tTS9FgFYh5M0F3VfPRcxNpZFixNXaVM1XE353AVPlS+YSfBJwXd6hJPl5vksJ6
	 xrJrqxgscWpcKadcT923kWfLNWTg6E+DpkhUaYNhULjIajgJHOZFYwocDeKviWPo7M
	 qKe9NDta+0zvt6e48jj5aeZK/91AfuU/k/snRlyE1DXQINVkPNJZOHBcuVicDbkEh3
	 dLilEFfeI5Tyw6fVCHhid1R8jGGZArn6TI+RNBdflCgSbLSb/KUwD8dSzt55QJRcK3
	 X0PbJpsGVzmNKZzTTb53Dx0QIb0et93wTT1Sdo5zm9c3rRSdIOvZeSzc5gP/MOSFhF
	 s+tPjIMqtMueg==
From: Andrey Albershteyn <aalbersh@kernel.org>
To: fstests@vger.kernel.org,
	zlang@kernel.org
Cc: Andrey Albershteyn <aalbersh@kernel.org>
Subject: [PATCH v3 3/4] generic/452: make coping work with multi-call binary
Date: Fri, 25 Sep 2026 12:45:11 +0200
Message-ID: <20260925104514.664260-4-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260925104514.664260-1-aalbersh@kernel.org>
References: <20260925104514.664260-1-aalbersh@kernel.org>
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
 tests/generic/452     | 7 +++++--
 tests/generic/452.out | 4 ++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/tests/generic/452 b/tests/generic/452
index a19a79623489..604d978cd98c 100755
--- a/tests/generic/452
+++ b/tests/generic/452
@@ -24,8 +24,11 @@ _exclude_scratch_mount_option "noexec"
 _scratch_mkfs > $seqres.full 2>&1
 _scratch_mount >> $seqres.full 2>&1
 
-LS="$(type -P ls)"
-SCRATCH_LS=$SCRATCH_MNT/ls_on_scratch
+# Resolve full absolute path to the ls binary. This is necessary for multi-call
+# binaries. In multi-call binary setup "ls" is just a symlink to a binary (e.g.
+# coreutils) which behaves as "ls" based on the executable name (first arg $0).
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

