Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490CD16A396
	for <fstests@vger.kernel.org>; Mon,  1 Jul 2024 14:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719845523; cv=none; b=CO60lkDCHM1DbJtKjvJzlyLIrfULbktik33SPi+EoWaNsBbLkAWi6lnkz/T2Il0TzfClyNd5wc0DbN5DUgNVQJfUpxjiQXAL7A/YfVn6gs/K+HxpYvbKMFNeQkCNNosRlZfoENyEoucCmMI0WmKxRjo6338NlS2QyByFWp7UUzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719845523; c=relaxed/simple;
	bh=c036HfecGkCQQnRZiI3XZzw+POggcXKkyATf2qyrYG0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pnmAJc5LerGdOa3Mvl1NnqlA/odby/IyCT2lVFmsAR6q/kQ0sos+4KkO/NjSMG+eCCFXpPHA/R3oZELevBlCG4XgWx3kmo+vTss6mf4cOoUWvbtQR2xadmfK6kFxHgfmdpf+X1DmbIpoF5eC4jq400HmOwqvOiwAnie6fIR+0ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mk0R366H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mk0R366H"
Received: by smtp.kernel.org (Postfix) with ESMTPS id F1EB2C4AF0D;
	Mon,  1 Jul 2024 14:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719845523;
	bh=c036HfecGkCQQnRZiI3XZzw+POggcXKkyATf2qyrYG0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=mk0R366H+ivYa/fd+WNWXNVgeuEkM7x80raM4ftAOxvGgS64e2OIWtizTIny+KpS/
	 bwtS/dNPdnqEcEG1+RFtoO13J50heaUKs7HOTR2hcSLCm6WJMFi+S21n4vD891b/Ae
	 ri70QQV096N8yEMCE3QBSZmogkfuOk+PW+kMk5m0GaasgI+Z+KDcuhMLiCAZ6gRb+C
	 dr0brD5L1r70m945hjv23nN+zCusYbWG7+/HqMUsg2NKt1f12eRoMVBXEI+l0uqVIc
	 CnYoU2WBdfSD/WCOYBUdvy1o7aV5RcN2TN8EsTLCH+8FGLhLWUcOuNzi9AAd+2scd0
	 L4CavQsBA1Rvg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E027BC3065E;
	Mon,  1 Jul 2024 14:52:02 +0000 (UTC)
From: Daniel Gomez via B4 Relay <devnull+da.gomez.samsung.com@kernel.org>
Date: Sun, 30 Jun 2024 23:52:42 +0200
Subject: [PATCH v2 3/5] common/config: enable section parsing when
 recreation
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240630-common-fixes-v2-3-16d26fb1dee0@samsung.com>
References: <20240630-common-fixes-v2-0-16d26fb1dee0@samsung.com>
In-Reply-To: <20240630-common-fixes-v2-0-16d26fb1dee0@samsung.com>
To: fstests@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>, Zorro Lang <zlang@redhat.com>, 
 mcgrof@kernel.org, gost.dev@samsung.com, 
 Samsung Samsung <"Daniel Gomez d+samsung"@kruces.com>, 
 Daniel Gomez <da.gomez@samsung.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719784382; l=1040;
 i=da.gomez@samsung.com; s=20240621; h=from:subject:message-id;
 bh=CweM8hFKTR+/uaj1ksPTKot0K1j7X/HoaXPstHW9eK4=;
 b=6B4XAtAkwHvME4dbL0MLn062ggfwvqLlTfHhmwrkYArXkq0Z1VSXywhzAgot9Og3yTpusGlzi
 toGbeazCZlSDITOlIZ/XOzyUtbxL9Bat7VKDLKhx9wt5RWb3S0elUla
X-Developer-Key: i=da.gomez@samsung.com; a=ed25519;
 pk=BqYk31UHkmv0WZShES6pIZcdmPPGay5LbzifAdZ2Ia4=
X-Endpoint-Received: by B4 Relay for da.gomez@samsung.com/20240621 with
 auth_id=175
X-Original-From: Daniel Gomez <da.gomez@samsung.com>
Reply-To: da.gomez@samsung.com

From: Daniel Gomez <da.gomez@samsung.com>

When RECREATE_TEST_DEV is enabled, specific fs mount options such as
TMPFS_MOUNT_OPTIONS are ignored during section parsing unless the FSTYP
is modified. This allows the filesystem type to remain the same while
only specific fs mount options are changed during the parsing of section
parameters for test device recreation or when the section with speciic
fs mount options are different from the default.

Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
 common/config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/config b/common/config
index 43b32b93d..c739c4578 100644
--- a/common/config
+++ b/common/config
@@ -802,7 +802,7 @@ get_next_config() {
 	fi
 
 	parse_config_section $1
-	if [ ! -z "$OLD_FSTYP" ] && [ $OLD_FSTYP != $FSTYP ]; then
+	if $RECREATE_TEST_DEV || ([ ! -z "$OLD_FSTYP" ] && [ $OLD_FSTYP != $FSTYP ]); then
 		[ -z "$MOUNT_OPTIONS" ] && _mount_opts
 		[ -z "$TEST_FS_MOUNT_OPTS" ] && _test_mount_opts
 		[ -z "$MKFS_OPTIONS" ] && _mkfs_opts

-- 
2.43.0


