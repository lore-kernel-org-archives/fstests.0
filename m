Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C3F18DB05
	for <fstests@vger.kernel.org>; Thu,  6 Mar 2025 08:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741249105; cv=none; b=AkiSlGeD7cxOPABVNPHh6vHh8C1mNQ2MGPRZa+PusDWxuOK+VHYSaYDfG++B7q4Z+SHb3i9RXKfqxjnH03hIhB/K+SZsEtJ6Y0Hc0Q3fokxHBHn5/TzmNsO1MHeuzVE0QbVi1as2vek9iC/jLKqdBIHlaPRg6C7btxoZVIKptNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741249105; c=relaxed/simple;
	bh=VrrK9AFZRA6UMEjtPkjMxvGnlxlx7x8Uy5ufhbEEAww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vyjiao6+7Ebk14BT+fc1y2OzUFV5+/7FcOKdFwlMvJjh+8FrWh5XK5dsnH5txvGxiReVuUjGQBleKu0736ZBcoxtaRpjJoSdKpr/CWACPqP3yRKnXl8BUcFfmtHVn1sdMuME1Ybn+o0TjQi5kv/W8jHnwVvfEvVcV2M9ekN/v+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eFGp+6Tx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eFGp+6Tx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599DDC4CEE8;
	Thu,  6 Mar 2025 08:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741249104;
	bh=VrrK9AFZRA6UMEjtPkjMxvGnlxlx7x8Uy5ufhbEEAww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eFGp+6Txq7C8BnICguj+q74x75dKCWS+Eqkf5/rXeITQRbuKfc46W6tYpblbXDNSV
	 YOuubn0U6KBU76sIDHvg92ijW43lMBDhPen0IECNhwbXXoqfGDU2Gu3iRKL7I+/yqg
	 2zAeYHZtK4TygG1fcWXBOgg7zaRNjPxpGFjXxpEbSOuVS6YO+mOYqGSVhg5ItSWD0i
	 yqTuTxF5qYa76N+5900ncDOOcdw+uY1rGwnDnCNNoL01jwA7EnnbfP2pwg3mCm/K9F
	 u4mgOvN51p0bNlLhDPp2OYJ+KRETSM5/Itk2HW1piccKHznQnvRT39vTqN0m6hH1kW
	 v1nuxWB+502cA==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 2/4] common/config: export F2FS_INJECT_PROG
Date: Thu,  6 Mar 2025 16:18:07 +0800
Message-ID: <20250306081809.2397527-2-chao@kernel.org>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
In-Reply-To: <20250306081809.2397527-1-chao@kernel.org>
References: <20250306081809.2397527-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

export F2FS_INJECT_PROG w/ inject.f2fs, it can be used for fault injection.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 common/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/common/config b/common/config
index 8d3047a5..05f192ea 100644
--- a/common/config
+++ b/common/config
@@ -317,6 +317,7 @@ export MKFS_BTRFS_PROG=$(set_mkfs_prog_path_with_opts btrfs)
 export MKFS_F2FS_PROG=$(set_mkfs_prog_path_with_opts f2fs)
 export DUMP_F2FS_PROG=$(type -P dump.f2fs)
 export F2FS_IO_PROG=$(type -P f2fs_io)
+export F2FS_INJECT_PROG=$(type -P inject.f2fs)
 export BTRFS_UTIL_PROG=$(type -P btrfs)
 export BTRFS_SHOW_SUPER_PROG=$(type -P btrfs-show-super)
 export BTRFS_CONVERT_PROG=$(type -P btrfs-convert)
-- 
2.48.1

