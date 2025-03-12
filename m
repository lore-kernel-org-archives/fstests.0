Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643CE2F44
	for <fstests@vger.kernel.org>; Wed, 12 Mar 2025 07:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741764202; cv=none; b=ay429hXxAVR8XD+A+F/WxDp7szcikIxn/+g6RuCW63axngXZR9i3KHaj8Il37D0t12mZ55Bj6rNVUQajHi7uPb3zjHu/nbI8rjJbAJ2wjyhmgmRD/luqeVn3a3C7EBosicgbN2Hzs/WHL4dc1XBsFYGumyMlEXfXFLOJmwyN/ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741764202; c=relaxed/simple;
	bh=9abPyMZNZpjPTxRIU3EzPNArc5vpHFGSWM5BVeufFRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pfesdAq3YcyTTO9sh+0QLmItHz/ktwRUDOj1KuK35rioh8NVvv3lSJa8N0FgWZfRpjP61SIrV94VGzeZvIso5CmPs9Nc155wkXXx1kZAP7S56qcLv6ycRF9Y4q2N5fmZ6gqwGyPLUQA/tG2AMSQnQqDxLKZ98ik+3pkQvuVM4sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6QZGkcl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6QZGkcl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6112AC4CEE3;
	Wed, 12 Mar 2025 07:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741764201;
	bh=9abPyMZNZpjPTxRIU3EzPNArc5vpHFGSWM5BVeufFRg=;
	h=From:To:Cc:Subject:Date:From;
	b=d6QZGkcl6FrYC0x5IR/QnBN3Khm4QmTVV9fTPj+U7niP3tVrqoG90TmwBvesvXGEu
	 gbWlI2cv5cT59sKr5wVdKoA3lJ63fCrYimD6HWm0AduGp7eolbHkU9Nu/3WcCPXVeR
	 nMLPWCDaarpXuybATDIKHchA2tzylc9x4L7tSfmWwMgWPzB99CiCWo7K7VRbc7WEiw
	 QgStTSsfZUF7/wFHsAS2jSBdWGyEowXglkw1O5AovhLDMv6WqYtvqFaqB3JR39C1pv
	 AUQCpEgI6ohftOdoquHSRPXrG9mNhQhiXvet2WWiyPwm//yVispOhs0RWY2XQSRBSr
	 hqND1wD3viifw==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>,
	David Disseldorp <ddiss@suse.de>,
	Zorro Lang <zlang@redhat.com>
Subject: [PATCH v4 1/6] common/config: remove redundant export variables
Date: Wed, 12 Mar 2025 15:23:04 +0800
Message-ID: <20250312072309.3989074-1-chao@kernel.org>
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

