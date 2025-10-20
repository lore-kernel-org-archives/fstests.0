Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B766A33987
	for <fstests@vger.kernel.org>; Mon, 20 Oct 2025 02:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760927477; cv=none; b=rcNuQ37C+q+KjqBNT5ioaasSfft2AErvQGepogBA/Pk1HrSw4iXmsfOME2mGX3XtbiEjpkhmeWujpPLrQvyvESjeCaaJGOYhwBKdIwr8F+lrXGjgHTBegcTRZ//FK03smUFp0Em22taee9ZyHTPXa/IFBlBQlel8YYGlimbhzcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760927477; c=relaxed/simple;
	bh=zH5t+wqmszTT+27i4XIEn7dPrWgnpg/gn5uTS78dewk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ie8GdemeliU5SKE/bG9YYbAZIQ8sLLrBMauT9UyyVjf4XdcJk4ynQD8RDBlqk+py3mQ9HLjGuFawEaN46wbU62O/xotoTeeeF5b8Jm7T2RcuJKrqXLZOAxPPmONJ6ipAd8ERvUm0ffZ8zObJQD/WDiSXJSJUM0M5ysCj11Uzr3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rFLYUkI6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rFLYUkI6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B136C4CEE7;
	Mon, 20 Oct 2025 02:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760927477;
	bh=zH5t+wqmszTT+27i4XIEn7dPrWgnpg/gn5uTS78dewk=;
	h=From:To:Cc:Subject:Date:From;
	b=rFLYUkI6pekSZMPfXtynwcBS4ILFrL7onBKoDAwt2biaFQ/UqdVpdUVmv+2idDsrt
	 H0oAH96GXkp0iB2HDNezTTmJr9mvc+FA0osKqaJyLQ2uOOnAKAjAY6lDoLtGEj2lYU
	 h2uaJwqob1xei6SDH0Rh8R2n6FmYv2tN8J62xNX/zfLeMxLgk55wcuWjDqiraxs6a4
	 /NNXjUA+vJsnYJdasdO/tiXofWr0Q8HJZqWEgWUgO6u0HtMFBsjEd422IxLseyx5Qd
	 p088rANgINIqQXqjTa+KfzupKP0GdLLus2vE57ZfJhPE7LI9R3WgiEAFIVwW8rIkhd
	 fVvUcc8s7jWCQ==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 1/2] f2fs: add commit id to _fixed_by_kernel_commit for f2fs/02[1-2]
Date: Mon, 20 Oct 2025 10:31:07 +0800
Message-ID: <20251020023108.327728-1-chao@kernel.org>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bugs related to f2fs/02[1-2] regression testcases have been fixed
by below commits:

- 930a9a6ee8e7 ("f2fs: fix to avoid NULL pointer dereference in
f2fs_check_quota_consistency()")

- c18ecd99e0c7 ("f2fs: fix to do sanity check on node footer for non
inode dnode")

Let's add commit id to _fixed_by_kernel_commit in f2fs/02[1-2].

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 tests/f2fs/021 | 2 +-
 tests/f2fs/022 | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/f2fs/021 b/tests/f2fs/021
index 96fc97c4..0cacb138 100755
--- a/tests/f2fs/021
+++ b/tests/f2fs/021
@@ -10,7 +10,7 @@
 . ./common/preamble
 _begin_fstest auto quick mount quota remount
 
-_fixed_by_kernel_commit xxxxxxxxxxxx \
+_fixed_by_kernel_commit 930a9a6ee8e7 \
 	"f2fs: fix to avoid NULL pointer dereference in f2fs_check_quota_consistency()"
 
 _require_scratch
diff --git a/tests/f2fs/022 b/tests/f2fs/022
index 48a8386b..f6d77c96 100755
--- a/tests/f2fs/022
+++ b/tests/f2fs/022
@@ -15,7 +15,7 @@ _begin_fstest auto quick rw
 
 . ./common/attr
 
-_fixed_by_kernel_commit xxxxxxxxxxxx \
+_fixed_by_kernel_commit c18ecd99e0c7 \
 	"f2fs: fix to do sanity check on node footer for non inode dnode"
 
 _require_scratch_nocheck
-- 
2.49.0

