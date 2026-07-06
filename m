Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30ABD420E72
	for <fstests@vger.kernel.org>; Mon,  6 Jul 2026 06:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783320230; cv=none; b=W4t4VkBgryouH8ORv8hF536+IMsOu/6prg1etMs0ohQzqPPPLgUnKHUV/6IaHWIoGKVX/dlX97LWkqWvftPtDOlkarhTmyLmSPQAVwtpwe5m4pQePkbc2mgb7BHhgjEDHcP2T8Mey7q6IYdejTO5QInTLZVHIg8KHZnAKw0L8Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783320230; c=relaxed/simple;
	bh=yz+5I2uQN3lsJgW9TqjGgbxbWSaXoBUP4Wc+TJebu7w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XMoOCP8zG7QgGYhRHpuSQlixjzYx1GquABnNWLnItuQOWj2WHw2huGnaIVGoDRo7oQzmA0GOMkSTUEp3w/jwGc47DS6w/dAjqTaR0C5OPz8wX1poWZALxdmKWzUN/4DWBNziZVR9NshVccKEy/beiQG42ZtchkLFOH5nQB0vC8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K5YwCuI5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5YwCuI5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 609F71F000E9;
	Mon,  6 Jul 2026 06:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783320222;
	bh=pn/v4mi91yPi1z8my42KU//6VlnVSyj7cZh1HgSNcRQ=;
	h=From:To:Cc:Subject:Date;
	b=K5YwCuI5rEz4Kx4rJTvU1KZ9KXelowowpw/QMeiDp3ZtAf8hJeJIXoQqQGrFM2Y5o
	 Ud+wp1tsh/uT5ihDkkMMIr/ENChpxH/2j76Tix7c04MmzasDwNE90Ni+SrY6fALGER
	 5PQNlX6cbByQPlNFWIYoorYQfHrDqF1naLWpq47vwTqJeBJcWgyMN5dFotYGaGoTsF
	 7+plrwqOccuXRKQqB3AjzE5krhTTINGmrx00PCk1wNF6o1H4tDcsaNOrT3bzEqQzle
	 UGYlF5OcyPHTdz3YRFoFujJlgIesJAC109AdOJReXvhJsrqku0Lxum/B7ZVHjGtEBh
	 9AIos5rAH0qDg==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH v2] common/rc: support f2fs in _require_fanotify_ioerrors()
Date: Mon,  6 Jul 2026 06:43:26 +0000
Message-ID: <20260706064326.3657995-1-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
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
 common/rc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/common/rc b/common/rc
index 494725547..f51ad59f3 100644
--- a/common/rc
+++ b/common/rc
@@ -6257,6 +6257,9 @@ _require_fanotify_ioerrors()
 		x="$(_get_fs_sysfs_attr $TEST_DEV err_report_sec)"
 		test -n "$x" && return 0
 		;;
+	f2fs)
+		x="$(cat /sys/fs/f2fs/features/fserror)"
+		test -n "$x" && return 0
 	esac
 
 	_notrun "$FSTYP does not support fanotify ioerrors"
-- 
2.49.0

