Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D0685624
	for <fstests@vger.kernel.org>; Tue, 16 Apr 2024 10:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713262643; cv=none; b=nnGG37gB0lyAfc7R2rmtgIe74xzoi7pX+Ir0RIhUUyT0rj28NvFyrm6ZFV5l4+xWqojEH/DMGhnCqPvLGUbGW8hJD5qiV6bfQ4fwqniQT+/rec82Gr563M+cvSxpgdreuCuDDDGdoWNPnj3+L6anvxe/PSd+Z0YfHw7giKVgrIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713262643; c=relaxed/simple;
	bh=niqDEdS2YIw7sdPWeFN+Ymj6+SKkFG3ZVVWcVrQ1eb0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YtLB0JnfLj3TqznNtHBQXc1SsUiXP9FmejpWQKcwf1JH1P95EzgSJbV73fnnHrWAfzvZUMbpgWu8YjRLYn0suJPHGaQs/fbqcXiH6zJg3AAxWddUX6LukbeJVYt/O7cgXc103SXuoaBYjzGFZdX+R12pvw7ABhS9vxW6FzCtX9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZZ0OJT+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZZ0OJT+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805EBC3277B;
	Tue, 16 Apr 2024 10:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713262643;
	bh=niqDEdS2YIw7sdPWeFN+Ymj6+SKkFG3ZVVWcVrQ1eb0=;
	h=From:To:Cc:Subject:Date:From;
	b=QZZ0OJT+Qfzuo5pqWx26IFAVHSPWyxzYmvpbJUdYA+/QPpxWYdWTlrN16tLO5F2ak
	 QhP7GQ9YDOH0/ohFkwqu8uHiUBfV1Awsrf11tFlgJmVC/xvxHuA4ZtP2oTQc4T47kP
	 +NQ8d+hZg6eUNVHHCIFuskGc0ZFvM6mv3tQmWYh7KWJK/eJFhpTnJq5MGHVTr+Sewo
	 6+BQBYjPm4OlTt9Q13bbBW++FHTmmeqib6Y+qe9oKLWqzkC4DT4PeKCyljyJrUlOTb
	 qsCaV0G7gL7AaSBukk+cqZ8ObqB7R9TEh7ReLSrtr97lJ32hGrWswXqtRNtM/2W/wd
	 yYFzgSSEbZeNg==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH v2] common/quota: update keywords of quota feature in _require_prjquota() for f2fs
Date: Tue, 16 Apr 2024 18:16:50 +0800
Message-Id: <20240416101650.53078-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, in f2fs, sysfile quota feature has different name:
- "quota" in mkfs.f2fs
- and "quota_ino" in dump.f2fs

Now, it has unified the name to "quota" since commit 92cc5edeb7
("f2fs-tools: reuse feature_table to clean up print_sb_state()").

It needs to update keywords "quota" in _require_prjquota() for f2fs,
Otherwise, quota testcase will fail as below.

generic/383 1s ... [not run] quota sysfile not enabled in this device /dev/vdc

This patch keeps keywords "quota_ino" in _require_prjquota() to
keep compatibility for old f2fs-tools.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- keep keywords "quota_ino" for compatibility of old f2fs-tools
suggested by Zorro Lang.
 common/quota | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/quota b/common/quota
index 6b529bf4..4c1d3dcd 100644
--- a/common/quota
+++ b/common/quota
@@ -145,7 +145,7 @@ _require_prjquota()
     if [ "$FSTYP" == "f2fs" ]; then
 	dump.f2fs $_dev 2>&1 | grep -qw project_quota
 	[ $? -ne 0 ] && _notrun "Project quota not enabled in this device $_dev"
-	dump.f2fs $_dev 2>&1 | grep -qw quota_ino
+	dump.f2fs $_dev 2>&1 | grep -Eqw "quota|quota_ino"
 	[ $? -ne 0 ] && _notrun "quota sysfile not enabled in this device $_dev"
 	cat /sys/fs/f2fs/features/project_quota | grep -qw supported
 	[ $? -ne 0 ] && _notrun "Installed kernel does not support project quotas"
-- 
2.40.1

