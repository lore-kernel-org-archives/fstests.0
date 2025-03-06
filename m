Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC851A238D
	for <fstests@vger.kernel.org>; Thu,  6 Mar 2025 08:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741249103; cv=none; b=p2GoMbzj0oAdeIjd7MkbzS9O5Pe56qU0UCMqPwMFfFH+gGImcUwlVBlxwZVPdF6K1rDjhvnaT/eKiKkbNKl8S0CVHYcf/R4Bt/M3c1gIUcH8DbHwKN9cddq437dNo9JhopJJKqlv2vHVLdZf5UsFv2n6Bu9hPmtCiISFKq5Nz3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741249103; c=relaxed/simple;
	bh=RWP4wpZ3zNZLUM147XjXn5XnwdN3KEQbeXE8EZAKops=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZzcEg7oTSGPgKtCyoFpbHgoMcvEY6JugDQPkuJsOzmdMJpR69U+wnuqRDvbdKaWM8X9gLyhmQFCq3xSEHUiHBAls7LuREnD783T5oKuSqmpVqHIE7jm/SQlO34gniafU3H8DzhfvHK5M1fRDSlXRWof0jHLqNRO9PteJ/IrF/6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZjBC3Psr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZjBC3Psr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC685C4CEE0;
	Thu,  6 Mar 2025 08:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741249102;
	bh=RWP4wpZ3zNZLUM147XjXn5XnwdN3KEQbeXE8EZAKops=;
	h=From:To:Cc:Subject:Date:From;
	b=ZjBC3PsrECQaYu2hurjO31ZdC5Txicqu8AlfPeIytdzmAl9ORsxLUzwuwZMDma/fN
	 fWgKcrqMzfXOJwe5q9rxQJ9ppEHyuVAez6CmhCe6FhKi+apJzckE88rx1/q4HqVj+4
	 BPMB7FZL8I6iIAaoA22khI95RZ+sN1jiGsAq+2tZk21kcZdJRHhk4c630moatZhDq4
	 eiOUgSFwcOh9ON+GlBA1LzobnfttFonoUpZDAFcpJBioMSv1Idr31TKmDLy9iXq1ko
	 MlNS3LfKZY0IpuGS01UVv9b1JeNdEp1GSbFpIox8YN1rzv45pFKEMxe36JODqDxnmJ
	 F5jxxj/eaZCPA==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 1/4] common/config: remove redundant export of F2FS_IO_PROG
Date: Thu,  6 Mar 2025 16:18:06 +0800
Message-ID: <20250306081809.2397527-1-chao@kernel.org>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

F2FS_IO_PROG was been exported twice, remove the redudant one.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 common/config | 1 -
 1 file changed, 1 deletion(-)

diff --git a/common/config b/common/config
index 2afbda14..8d3047a5 100644
--- a/common/config
+++ b/common/config
@@ -191,7 +191,6 @@ export XFS_COPY_PROG="$(type -P xfs_copy)"
 export FSTRIM_PROG="$(type -P fstrim)"
 export DUMPE2FS_PROG="$(type -P dumpe2fs)"
 export RESIZE2FS_PROG="$(type -P resize2fs)"
-export F2FS_IO_PROG="$(type -P f2fs_io)"
 export FIO_PROG="$(type -P fio)"
 export FILEFRAG_PROG="$(type -P filefrag)"
 export E4DEFRAG_PROG="$(type -P e4defrag)"
-- 
2.48.1

