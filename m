Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAEA2107
	for <fstests@vger.kernel.org>; Sun, 24 Mar 2024 14:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711289832; cv=none; b=dRok0glEqwJKaiB0YcdPotlFF1F7tptng69a/j4POuXFLak5T+uW0t3epQjeBXtwUGKafhTM6Ya3KVEKlmWwfzk8cW424isl9STSUiygaogS89FLGMvm1XT4/H9Mvc62ZrVJS1GUKnxGyPTO6VETxD+3Rnx17ws2Ky2mMKnzgrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711289832; c=relaxed/simple;
	bh=4O/o75B7SFsp7ithfCMXtFO3UwrfeRYrVqgDxMoYk9s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=WTCWVnxZr6rAo2HtXo3wwjcGCBvaUF7rKwh1fGDAAoKYsKtE4FriWC/1aRNbiqUfILgCwFGnSY5YMEhr3W/lV8TZl/Fp7Xvefte71xIjg+D/GIWbWZ3icEA4PatDISF1hv6bOn1UDXv8E/2hSCvEJffO/CzZgB2uP/9XYYyaEOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+Aqif7U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+Aqif7U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EB97C433C7
	for <fstests@vger.kernel.org>; Sun, 24 Mar 2024 14:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711289832;
	bh=4O/o75B7SFsp7ithfCMXtFO3UwrfeRYrVqgDxMoYk9s=;
	h=From:To:Subject:Date:From;
	b=d+Aqif7U6hCa9TyE4cJah+caSzVKG/wByKtyTEB/PjkwB75yGFLfI8hLK8JeUWdK8
	 hU3JpQQLP/Aastm1gMR4G7TtK80ZckcDO6U1Z8Dwf8rb6q2R8tQOjMC+FNo7ofXpYL
	 eVwGVo9+uZEV65mMpNTAI0Vo+7tPJsqYSzBixYx+PPYgosi4a/qXKJTYonQdmVVLvB
	 gMxYW21INg/h6Z1YywdhzUlZKbUxkztcyEkOOucgadjLq38bh12PIIXadz99Lf2XuR
	 vQCgatG4tCgrV23YBrp5CYlMtxleiWMFoEpNjlE1Dv7OzNIfi67v5ka0zBAbf0sSTD
	 PuJMeelShUzEA==
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [PATCH] common/rc: fix unknown _xfs_repair_test_fs function name
Date: Sun, 24 Mar 2024 22:17:07 +0800
Message-ID: <20240324141707.303321-1-zlang@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sometimes I hit below errors:
  ./common/rc: line 1293: _xfs_repair_test_fs: command not found
  ./common/rc: line 1298: _xfs_repair_test_fs: command not found

The _repair_test_fs trys to call _xfs_repair_test_fs(), but there's
not that function in fstests. According to commit c7d81cdecbef,
it brought in _test_xfs_repair, but called wrong name. So fix it.

Fixes: c7d81cdecbef ("check: try to fix the test device if it gets corrupted")
Signed-off-by: Zorro Lang <zlang@kernel.org>
---
 common/rc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/rc b/common/rc
index 37d26bf2..47736dc3 100644
--- a/common/rc
+++ b/common/rc
@@ -1290,12 +1290,12 @@ _repair_test_fs()
 			res=$?
 			if [ $res -gt 0 ]; then
 				echo "mount returns $res; zap log?" >>$tmp.repair
-				_xfs_repair_test_fs -L >>$tmp.repair 2>&1
+				_test_xfs_repair -L >>$tmp.repair 2>&1
 				echo "log zap returns $?" >> $tmp.repair
 			else
 				umount "$TEST_DEV"
 			fi
-			_xfs_repair_test_fs "$@" >>$tmp.repair 2>&1
+			_test_xfs_repair "$@" >>$tmp.repair 2>&1
 			res=$?
 		fi
 		;;
-- 
2.44.0

