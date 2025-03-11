Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7041EB9E8
	for <fstests@vger.kernel.org>; Tue, 11 Mar 2025 08:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741680276; cv=none; b=J66PJ9+hgiBlaywjYc7A75XHtdIU+aLMlJszlSRqBnayKSPC+6AL+kBrSkg2KtpRGwHhyBJGohaTxFsTCagKk2w1MU7Yh1uFBgoY+y1fCrEmgeEG4qMtw8AcMmt438QHvp/6Y0SCbjdF35qI7s197qUy1E6Eohko6Ta+Fd5F09g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741680276; c=relaxed/simple;
	bh=G1iFw1mERxQm3fRA2+x+GlTb1f2Yl2TewlO/Q3TPSY8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qyoFMZ/pmdga03vRhqvqE8CAq3GnzpOoq64cBo3WJE2onuBQlpXqL3ZWjUZlIG80t+RECPynLZm2yHkmCS/tdC1wGYb+H8flNUedZkqhbXcGCpJayXLmIHb5/imEIna6t/4VttTkSq69HrgIXukflgaS/M3Zyy2EeGpR1WEV1Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ev9BahO1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ev9BahO1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF0BC4CEE9;
	Tue, 11 Mar 2025 08:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741680275;
	bh=G1iFw1mERxQm3fRA2+x+GlTb1f2Yl2TewlO/Q3TPSY8=;
	h=From:To:Cc:Subject:Date:From;
	b=ev9BahO170rBcAZeAFnyHRY/Hn+ck2U4yhox6OA/yW/3IIeQd0CEbNEwfeh00YsO/
	 0m5oGkSfu8qgF+RtrG8dTW+TwzEwpdMkCos0aFKXqXEXP4tmGkpWD5vgwqOBaHz4IM
	 Sq6eJXlp7uf4iPXBZdY9BaTlnmAAaZFAjME8kB/JKKRoa0R6AaFB47VL2nJtuWpHRK
	 pyumX2aW/i+nMWPFMxzuD/Z1rfiO2t4ed/XrWOYZ1wgyXzbYuRwKcB0Mu9ImY/WGg+
	 3I2N4FUdeckLvKGGfba5SgymLIBio5TKBqX6FtB9ThpN3+89rHYjgFXSjq3osmPHLd
	 RBbK1AR4nNs3g==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>,
	David Disseldorp <ddiss@suse.de>,
	Zorro Lang <zlang@redhat.com>
Subject: [PATCH v3 1/6] common/config: remove redundant export variables
Date: Tue, 11 Mar 2025 16:04:25 +0800
Message-ID: <20250311080430.3696582-1-chao@kernel.org>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

F2FS_IO_PROG and TIMEOUT_PROG are exported twice, remove the redudant
one.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Reviewed-by: David Disseldorp <ddiss@suse.de>
Signed-off-by: Zorro Lang <zlang@redhat.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v3:
- no changes
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

