Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0764F25A2AC
	for <fstests@vger.kernel.org>; Tue, 25 Mar 2025 12:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742907525; cv=none; b=uMe+I1QBmy9GgEhcyFpR87YBJ1RBQOgadm1/znxHQSKZ0k7OZaFM4hKQX5giiHPkkkR78rXv24dlk+V9WiFz1ot8uAQ18idcrVthFpycbVPPvom7qzDXT8AUtfqryKaH1AyZqZ7OlUFZoUrK1ec6xcxJSF9QbqDK0jlnF1kWveg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742907525; c=relaxed/simple;
	bh=9abPyMZNZpjPTxRIU3EzPNArc5vpHFGSWM5BVeufFRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NMMzbLUkIxsHVgS7ShsULCaJxL3cViddhQXxNuOBMJuN1C75AKenf6DhH0ZlPlc80NN2eS0ZWz+YicfxoQvoyOV23ZrU2G8YUKtsRRotkQQ/9kFFKI/OwbQaQ2WePr6o+wpqNmMLwMtEGwKnMEGb9KU9r+JP1auEuG/AjhNwsM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGEdvDOF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGEdvDOF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A86A8C4CEE9;
	Tue, 25 Mar 2025 12:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742907522;
	bh=9abPyMZNZpjPTxRIU3EzPNArc5vpHFGSWM5BVeufFRg=;
	h=From:To:Cc:Subject:Date:From;
	b=GGEdvDOF4c0J9AZD+9fFlsUuljfzST4iI6kV8FaT1c3DlWFuRSpV5QEn5AQpH7oOj
	 tkddKBdDGVNpfwiET+QZa1jpb3KmtvM0W6ZiflJwCdARkbL9rcmP2Zw25E/XKyUxwC
	 qn/ab7ttTY/MxpRu03qR7NcCi9FiikErjkolqR/xEfoiN7TVxG3/wewm6Ob+p/ifgT
	 xEhMIP4UXhM1jbP46IFJsvBadU8TnseQujpeOtQ8z0/Xj6EHch/VSzEoYohnhUxI5M
	 l1lelX8qT3i9xxGQuY+KlLnCesxgzIOtUX55h3EJhW+iNClkBhAF57tzJ4quXJMXFF
	 Dck5/PloSSN+A==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>,
	David Disseldorp <ddiss@suse.de>,
	Zorro Lang <zlang@redhat.com>
Subject: [PATCH v5 1/6] common/config: remove redundant export variables
Date: Tue, 25 Mar 2025 20:58:19 +0800
Message-ID: <20250325125824.3367060-1-chao@kernel.org>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
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

