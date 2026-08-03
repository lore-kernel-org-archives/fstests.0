Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE6040681A
	for <fstests@vger.kernel.org>; Mon,  3 Aug 2026 12:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785761174; cv=none; b=XYPX9GSLUzji2f6g6Etc2gjLWu7ooaD6QDqpqwSI57BbnJPhx2wq76x3iJ3+rEv4lD7AIx+cmTbmIZuRxmPKpyI1tXV/6GvRwgPQWLw/xbZEHRZPQzHRgnhpIwpvVwO6S4NisST80phwYYu4gXMDzEv4vXW+JhJdci/q2egfvyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785761174; c=relaxed/simple;
	bh=lTzV1vkVfpAISdKxcfersYWwsZzowyxukKv5LC4w/tw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D/mhrA7WJEzH5L1uxBUCQo8Pt39356LuHXi+NEQVakw8Bi0acIYMbayvRMkCKOHq9YRSewfvRI/l3xP2iVSiHe9KJdjcdfhapzf6D0PGKcGgYTpigghkCNXY+afKdF8FGEWuvDmzREQdVmLcHafFOEcE14kIjfds5waEyDv64/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chenxiaosong.com; spf=pass smtp.mailfrom=chenxiaosong.com; dkim=pass (2048-bit key) header.d=chenxiaosong.com header.i=@chenxiaosong.com header.b=l3xA/cJT; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chenxiaosong.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chenxiaosong.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chenxiaosong.com header.i=@chenxiaosong.com header.b="l3xA/cJT"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chenxiaosong.com;
	s=key1; t=1785761169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lqMecJSQWssHniFaJ9CxPddpg2ICi7gAE+0zfY4a1hM=;
	b=l3xA/cJTHB5KojEoeyq3JxK3lyOCezcHXQxkdoKdYCXvdV2OpiyxOZGHiCKbnl5X8MpAtx
	JO7HAOwkb1qBI+EmWD2/NYEmpvsoQhXD+BFUvMR56WmlYIlDcOtPDbLFFWE8BtxwJD9EF7
	cAnS9RqHQdzW1EDoZ0wBkpT4nc8xIg4A/j2LBezP6HT4mau3/VfiFl+Xs+3OUpUcmHRvzQ
	seb0+vhe7VoLKFOZxMirysKALsg9wBBcQ9I09mghSRxjC+SmULpQrivbJ2ZObaBim5AydY
	c9BCuqo7OkmYky1tLv5AHD62puM1qoYgweRUctmLepqj1rhgjY3JxBNmZeQkrA==
From: ChenXiaoSong <chenxiaosong@chenxiaosong.com>
To: smfrench@gmail.com,
	linkinjeon@kernel.org,
	hch@lst.de,
	zlang@kernel.org
Cc: linux-cifs@vger.kernel.org,
	fstests@vger.kernel.org,
	ChenXiaoSong <chenxiaosong@kylinos.cn>
Subject: [PATCH xfstests v4 resend 1/2] generic/002: add test to hardlink group
Date: Mon,  3 Aug 2026 12:45:22 +0000
Message-ID: <20260803124523.238457-2-chenxiaosong@chenxiaosong.com>
In-Reply-To: <20260803124523.238457-1-chenxiaosong@chenxiaosong.com>
References: <20260803124523.238457-1-chenxiaosong@chenxiaosong.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: ChenXiaoSong <chenxiaosong@kylinos.cn>

The test creates and removes hard links, so add it to the hardlink
group.

Suggested-by: Zorro Lang <zlang@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Zorro Lang <zlang@kernel.org>
Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
---
 tests/generic/002 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/002 b/tests/generic/002
index 6df57a7a..a0773e22 100755
--- a/tests/generic/002
+++ b/tests/generic/002
@@ -7,7 +7,7 @@
 # simple inode link count test for a regular file
 #
 . ./common/preamble
-_begin_fstest metadata udf auto quick
+_begin_fstest metadata udf auto quick hardlink
 
 # Import common functions.
 . ./common/filter
-- 
2.43.0

