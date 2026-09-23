Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B34240926E
	for <fstests@vger.kernel.org>; Wed, 23 Sep 2026 09:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790156003; cv=none; b=R2VCAxQJ9yWe/7M5cPIS4zejt4HbE4cLwwi/s/iLWFHKW0DQxab3qPF77D0lPhL/Z+TxFEXD6Ixq5Mq6WrPU152XA9Yv6GsG8yDV75tUFEz08noypU6RqK4lspwJCJUxYBQUXNUOvSdoPaj4pRudiV8wqEenEskd/J3vLSz4Ceg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790156003; c=relaxed/simple;
	bh=ouB1CfNyFOfJpUE8lgkL7HZCjyAiUFZhxDheS1yQa1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FRLxUuLPRTU/EsM25U0AgQdfG3OSjdAPM/M+CUxDvR8eRETXWf7c8+60eA1lPX4dLkfreDe3B2TETHnv3ue8NcWYX4NqlRIvM3MR5zx1JzJOb/9KYyYa2MDSPcE5rOXvsNsTNmE1P4O15ZOLGRO5hw7rS/uA6Z3xhp9/kjGFFwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jV3vqAvb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jV3vqAvb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B527B1F00893;
	Wed, 23 Sep 2026 09:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790156000;
	bh=mO4ryxeYeyBf71971oqEhgXfNXerWub5yoFGmGJVbwU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jV3vqAvbJ0+uMWYNSG3Q9EsH+17HNc6LRd4Mg+8ECAg2zIGu5c6btlNT3L5OnYw3V
	 FuJgdMj4axQlf2y7M4Y3NJgsqX77hF35DfkQo1X7izhGVfe8sP8Hb4EjIn3gCZmVEp
	 9eEWX/V/ZJJnKCAshhTckXSmlRFmSyZQBN+Jjn3+nCQPGbOcQ1QyefyWy+zU64ZkAI
	 k80a6ilYuMawGgQeSNvkT32AX2Npat5HandSrzyfG2yRVHUbc37Q7cxO5r1PHgYiAG
	 OC9ZR9BVpqGSkkHaH+lIj2WW+mdkHw70UoS/ejoXQc+y6Ld/MZZ7ROp1hfNlu6kQiv
	 6uKQnLX9ipPzw==
From: Andrey Albershteyn <aalbersh@kernel.org>
To: fstests@vger.kernel.org,
	zlang@kernel.org
Cc: Andrey Albershteyn <aalbersh@kernel.org>
Subject: [PATCH v2 3/4] generic/452: make coping work with multi-call binary
Date: Wed, 23 Sep 2026 11:32:54 +0200
Message-ID: <20260923093259.16199-4-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260923093259.16199-1-aalbersh@kernel.org>
References: <20260923093259.16199-1-aalbersh@kernel.org>
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

