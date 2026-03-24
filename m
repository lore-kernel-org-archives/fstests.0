Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECA8389E13
	for <fstests@vger.kernel.org>; Tue, 24 Mar 2026 02:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774321033; cv=none; b=JeFIk9+zunnNrakafgfqtFecPcchWoep3/0YUDR2dQ9NS79b00lwYwM7Bz51Q/V4l9zoO6MymJ/OsG3rxiX8UoQEORWV7DOTRRIQptLziHKq9j3KoUuS3O1RusqBM3kgEG1bMC3DENKs/2YH5bx1vMhLfeubdpzOy9Nl5X/GcfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774321033; c=relaxed/simple;
	bh=Hoir3FZd1ihnk39f3Bg524daUAtvJHXnLaeMyHbvdmI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N2SJ9Jg3F7JCn4eFM5szpkAviMs+RGMQdSyEfWWtzBYmmUn9jnxQQro4yonNPjx4mMCF2yySrcoeId9tvYzz+nwpgWFmxvnfZRpvA2/WSe+Tv9zh1qQi51RF0ip73LnCUqafDv5o+4Fyuk2zv3oqPGaW6Tb/AOfq06csQliTWSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cre3XuwD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cre3XuwD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F5F4C4CEF7;
	Tue, 24 Mar 2026 02:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774321032;
	bh=Hoir3FZd1ihnk39f3Bg524daUAtvJHXnLaeMyHbvdmI=;
	h=From:To:Cc:Subject:Date:From;
	b=Cre3XuwDSak3Wi9efN1sgL6sf6c798d9eApukxtR6/WVDYYY562PNI0zIPezW/RV8
	 MQXvCfBDLjGZ0Kz4xA9ycFmmxEmHXOQJt9Lgokm9vBLN/kEpljrEP4epLUR8r/sqte
	 ViDfpiWe2hloIfLP0bc8Rx8VqJuhStOR1/1pdMhbToVJDoeJXt1vYH1TMcNhd6KL7M
	 MPsDUJtLDNOYua1kE6Bw2b+z2mB72zm2hOpSenLLt894b7/QYf2Y2tYQVZBoo3aX6S
	 5QduA62Of2QsV4bVhbzQ4ywZhFp0k9Xz42tdI8tAkfedk6b9CjehSDLOeokxyLkoAB
	 e4bceiy/GQdfw==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] common/rc: support f2fs in _require_fanotify_ioerrors()
Date: Tue, 24 Mar 2026 10:56:55 +0800
Message-ID: <20260324025656.493776-1-chao@kernel.org>
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch allows to run generic/791 on f2fs.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 common/rc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/common/rc b/common/rc
index 5fe44e21..8f09f19a 100644
--- a/common/rc
+++ b/common/rc
@@ -6184,6 +6184,9 @@ _require_fanotify_ioerrors()
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

