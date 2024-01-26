Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D67D225CD
	for <fstests@vger.kernel.org>; Fri, 26 Jan 2024 20:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706300152; cv=none; b=T729eipU5FXTJc4Umj94BPBvbZnxx/iDVvyzKvqNBtQ8k5+WUP8sH6AAYUgVmj0vvaceLG95ie446QdsQmBl9R/X8PyOmZ6orc+3VxgsqEWumUTwh0Y6ENzvQ/eSY4P8MZO5qXnAk1hiEd6QQifW9Y3r7Q2JYDQIshrO7jLS+Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706300152; c=relaxed/simple;
	bh=MJTc7OcLO+Hcu+6JoN0F9NN6bJwBYbc478bUR6J8a50=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=U2tysHO/bqdJsLqX54qrFGBRF/xhTsSVGnPLaqswkIDbLbYFQAr6+muadzq0BD4Qqyh722Kk+mLQ31z0kaVByskP7qT+96RMisFLnUCEa5oKNaubvBqaExg/qwbVYjENLse9a7YGbKWbHMHnivRmcOQW4TlWRqjDLi9LiV0W0sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8iFHjZU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8iFHjZU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D710EC433C7
	for <fstests@vger.kernel.org>; Fri, 26 Jan 2024 20:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706300152;
	bh=MJTc7OcLO+Hcu+6JoN0F9NN6bJwBYbc478bUR6J8a50=;
	h=From:To:Subject:Date:From;
	b=k8iFHjZUb4gRNnptrtfn197+4/YQeyveDGw4koH7KdeCWYxqLbTST+T26fcm15Rj5
	 ejyxjNAmqqHNMfl2ohHBnbC+msFm48Kj35PwF4nZcvG4xYWbKYc9QrM3I/J8OPQuja
	 iHlElIhkQBIHJTsxvLJ3t2ucZ25WoRpt/xF++dFJVzrrbzVV4Q+iCnKhXInDKQO9p+
	 QV3GTNLt2g90q0k3noIkLBEm9l0UZ9bbH9n1Z5m3v9eyfPLCeyvOm7j1TRyipxt2Fb
	 TxHZBB9TmI19FmTBojallXGm9IE1xmuA5ri9ARszxO+ZU+8TDh5mTdGqew2SV1oper
	 I+i9MunejOoTQ==
From: Jeff Layton <jlayton@kernel.org>
To: fstests@vger.kernel.org
Subject: [PATCH fstests] generic/089: increase the lock timeout to 120s
Date: Fri, 26 Jan 2024 15:15:50 -0500
Message-ID: <20240126201550.109929-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On NFS, this test can take a long time. There is enough contention for
the lock that it can take more than 10s (or even 60s) to acquire it.

Bump this value up to 120s, which seems to be long enough for testing
with kdevops.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 src/t_mtab.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/t_mtab.c b/src/t_mtab.c
index c0640a1951a4..4b3b26c86d02 100644
--- a/src/t_mtab.c
+++ b/src/t_mtab.c
@@ -16,7 +16,7 @@
 #include <mntent.h>
 #include <limits.h>
 
-#define LOCK_TIMEOUT	10
+#define LOCK_TIMEOUT	120
 #define _(x)		(x)
 
 static char *mounted = "t_mtab";
-- 
2.43.0

