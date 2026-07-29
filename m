Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292A4443313
	for <fstests@vger.kernel.org>; Wed, 29 Jul 2026 09:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785318564; cv=none; b=SsIJsrYN42eAfb5o6rNNDApFS4LRmme/nib7h1IhBgWMvnDUds1l7cR1j0BqC4HfbpiYRHVcOHwuOlnCOlKswYGvsMgiZqKEH/4/nGkWK5yukt++t7Bj7Ws1KsaY8QHHRwmJTkZJyAtsDIcTkFYdsmA5I4AJQjoFq/1IV5whkm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785318564; c=relaxed/simple;
	bh=q5BuIHicge+8uQgaGAwPsPEOC81jr07P/kIrW6mvnbU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pZQJafFy4eE4Viw8VvllHR44VYBDN3dNt1Ij38ZGhLu9aqJjkyJypcuVaYcwZaNHvgzjDwjXZLdMeK4doweBHdPHuKKhpYYdcqR2xa0FbRkcsLQvqhUEXc0gTbpsBiu3BCCd0pF9epAYgM7HfQtQVQ5psAchvpP7d8z23S4KPC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PaXzav7Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PaXzav7Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD6451F00A3A;
	Wed, 29 Jul 2026 09:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785318562;
	bh=aVDAINXpByrQ66MLRoTWkHlTC6MrJnJ+AqRjvdfK4oE=;
	h=From:To:Cc:Subject:Date;
	b=PaXzav7ZMbqh44dDbopES8g2sb3BuXF45uiH22fILzLs+AWQQs2lffXZuSeoyWJsF
	 xcs9CkonqSbdrs5PXr6mcw/BBNLUFH+LwnE47qKQfPplRKH/kmsklIWNtp0Vsm+kpk
	 MfbufHeObY1aemIA4+e3TdJ6xIkjwzl6sN9mEySp7293+O10cRram35nWYtZYfFkdd
	 7nguR8jY07teDRcbAyhO07cKrgjGZSWkKDXz9SQWO0zIlL+XW7jqDCNukQ2wt33xuC
	 14oU3IfJTE42dLBUq5CDc13LmHa+bD23iiG8Fp0+KkfLo/PKXTVNhMAVr8RGtijpum
	 Al67oUUVTJC2A==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH v3] common/rc: support f2fs in _require_fanotify_ioerrors()
Date: Wed, 29 Jul 2026 09:49:09 +0000
Message-ID: <20260729094909.1499590-1-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

f2fs has supported to report fserror, this patch adds support for f2fs
in _require_fanotify_ioerrors(), so that we can run generic/791 on f2fs.

Cc: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v3:
- fix to chech sysfs node correctly
 common/rc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/common/rc b/common/rc
index 106f044ad..3a8f03412 100644
--- a/common/rc
+++ b/common/rc
@@ -6266,6 +6266,12 @@ _require_fanotify_ioerrors()
 		x="$(_get_fs_sysfs_attr $TEST_DEV err_report_sec)"
 		test -n "$x" && return 0
 		;;
+	f2fs)
+		local feat_file="/sys/fs/f2fs/features/fserror"
+		if [ -f "$feat_file" ] && [ "$(cat "$feat_file")" = "supported" ]; then
+			return 0
+		fi
+		;;
 	esac
 
 	_notrun "$FSTYP does not support fanotify ioerrors"
-- 
2.49.0

