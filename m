Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3838722423F
	for <fstests@vger.kernel.org>; Mon, 10 Mar 2025 11:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741607838; cv=none; b=CGpnfvU68kXjiQQxfspX9dnZtx8Jobl9Q2/7YWSW73QedoDonb0uW7/FbmJgnEPnr0VPwLhBJ2LoLaGL1VMMYUy+C2FyWJ3m4wygcmFUkq1jJDSDeUODBXGo23sBVS/xwrmOnTuuZr7KFJ/B8LEDzNN9DXY8E3N2mQYhKc1+WP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741607838; c=relaxed/simple;
	bh=2i2mVcUoEEJErWlRXsEieReXX6af21WasR5ug/fmQrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X9WVPdjguliDp1vFTlJVB2M6IvUoZsG+PPPBmrHyGGujeGZQU3vCw4d1ZG/uj8nGILcw765ZSlwfhBiDdR6gCHrn5TFwIcGANpQC0zY26WNq/+ybwdtlY3/Ylqhq1hWLfv4xWU1XRZESUvu1l1J3oAgN5c/IhUvyZW4DdBL+AdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q9//8GiC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q9//8GiC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 202F6C4CEE5;
	Mon, 10 Mar 2025 11:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741607837;
	bh=2i2mVcUoEEJErWlRXsEieReXX6af21WasR5ug/fmQrQ=;
	h=From:To:Cc:Subject:Date:From;
	b=q9//8GiC26nydhcUzbdirCDMSSATbA8Gf0gTX2n8IR4PLTeWNhCS/2C60KvYh7Sid
	 XC4njpdwFpX8LPEoF14n6RuJuZxwAfxzU+qi9ZRjepsv6VhSq1fsn0GAlOoakTuyyy
	 e9SJnMm77X3nfveHZIdW4bUgAUi4tDiUeB3c5xZ14a+aSQunPjTfUwubbL5zQHxKSi
	 eyvkJTp6TG+pM/bMla1tCCZG4wUPBxR4+F9pguVK6ir3fS0ckDaXf50iMrwUaMZ2qS
	 A/Prl1lYHVAyCjxaQnvOI3uN+Nv/ofeWmdPUO7hViLS7sHhr6uUKGohwP0RJKD5RbS
	 iRjD8evrP9h7A==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH v2 1/4] common/config: remove redundant export variables
Date: Mon, 10 Mar 2025 19:56:18 +0800
Message-ID: <20250310115621.3441518-1-chao@kernel.org>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

F2FS_IO_PROG and TIMEOUT_PROG are exported twice, remove the redundant
one.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
Reviewed-by: David Disseldorp <ddiss@suse.de>
---
v2:
- remove another redundant export variable
 common/config | 2 --
 1 file changed, 2 deletions(-)

diff --git a/common/config b/common/config
index 2afbda14..aa525825 100644
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
@@ -220,7 +219,6 @@ export UBIUPDATEVOL_PROG="$(type -P ubiupdatevol)"
 export THIN_CHECK_PROG="$(type -P thin_check)"
 export PYTHON3_PROG="$(type -P python3)"
 export SQLITE3_PROG="$(type -P sqlite3)"
-export TIMEOUT_PROG="$(type -P timeout)"
 export SETCAP_PROG="$(type -P setcap)"
 export GETCAP_PROG="$(type -P getcap)"
 export CAPSH_PROG="$(type -P capsh)"
-- 
2.48.1

