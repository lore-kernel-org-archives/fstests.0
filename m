Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB761D8DFB
	for <fstests@vger.kernel.org>; Mon,  2 Dec 2024 11:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733139727; cv=none; b=m+Sg7O25+RUGhaU7wysXhbcgrtpxlJWI/vNDqOscGh832wG2u1xgXKxS8IsoMK95aa7gimCQzh0OBtkjfKdz3Eh0j6j6sFqEyS1fZsmUryQUrWsX0fzuSrif7+hlI5oxzDDa+rJqPI0FhMMJsQk+GWbqV19E4WlbBDitewllK7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733139727; c=relaxed/simple;
	bh=gT73+r3iRtpdaPhRPXnrCCxqCie1FPAeMy25xabr5gI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=stF0zhq/P9G0dDIppBG8sORaS6Zl987psHMQH9+uTyJtOBz7NF5OTuudAdkSGkDQoA0QdrRJdMwHvBbfn6tsT8lJOzFkz+PktYlDKH8uIUkYi1T+p0z0zKsT4YybeCilbpIhQ4SKn2Xo+zZ1+s5cYyyYAbm58Q3ldmTw1AOhEZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DK5ou1z4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DK5ou1z4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3B1C4CEDD;
	Mon,  2 Dec 2024 11:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733139727;
	bh=gT73+r3iRtpdaPhRPXnrCCxqCie1FPAeMy25xabr5gI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DK5ou1z4LGDidXGl4rA4bV+whDsf//NnVxVuToFebVFXvOyMDUN+tA8Xqulhs+jYl
	 WO0j9ro+2TsbE5fIpSPxvQF8/WN1WSiDuZxNzS90tBtei0Qd/25IAUlSvN2mOWOyYI
	 k1CJTkpJ4xUtYIDDAepES1/vbwJWXtUoQtPIGpbwxP3qw+vW3gM3iiGpXxOW4aGrM6
	 06ZwLFYXpIEsv6jR17kM8Ljp2w4QepygtHgYYBL817LlwR18MxEO+F02pjJHCxUjFN
	 V2XA95FhjqUXFQvr6PUyOcAGNIa6OtfGvS4QO+X5l9SNFIhyZuzcVOA6aog00r1QBh
	 5dfQDMHllVRJw==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 2/3] f2fs/006: update commit id in _fixed_by_kernel_commit line
Date: Mon,  2 Dec 2024 19:41:48 +0800
Message-Id: <20241202114149.2666-2-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241202114149.2666-1-chao@kernel.org>
References: <20241202114149.2666-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bug related to this regression testcase has been fixed by commit
1acd73edbbfe ("f2fs: fix to account dirty data in __get_secs_required()"),
let's update commit id in _fixed_by_kernel_commit line.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 tests/f2fs/006 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/f2fs/006 b/tests/f2fs/006
index a9c823c1..c1f8d4ff 100755
--- a/tests/f2fs/006
+++ b/tests/f2fs/006
@@ -16,7 +16,7 @@
 . ./common/preamble
 _begin_fstest auto quick
 
-_fixed_by_kernel_commit xxxxxxxxxxxx \
+_fixed_by_kernel_commit 1acd73edbbfe \
 	"f2fs: fix to account dirty data in __get_secs_required()"
 
 _require_scratch
-- 
2.40.1

