Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C1726AF2
	for <fstests@vger.kernel.org>; Sat, 20 Jul 2024 08:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721464710; cv=none; b=KtxtWEYirhjMKSI7uVughnrXgh+gRammq8GB4tIIbLFCsEjrmRu8ItFUyJyDuvCbg6QasP5wIN/AR7GS8JTKLaFcIPSwxampbVY+7ss7IopL6RPW3E43Q/sOLtG2p0Iy94IdPsAYdhnDexl6NztmyLXwe04plwXERzZATJE7X0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721464710; c=relaxed/simple;
	bh=NSsWrxv7wPlspnFxa+ACXCeqBZ57cMZjFkDx6OKUt0k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=etMQHha5MtKTwsUgwyF5kPMJapP3LfjCZgM74ZEAYh2bKc+vEgYfA6Xss63F0YuWAWq3iIC7nfjR2VwMrLD9zKJV8a4y1xaLLpt+lE3RApqgcOFT3hQzfQtFXEVlE5T3+OKeBlYCxMXbly7vjwUHWOrrkrfTAni0rbFoLoal3Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WR0JR0CrvzdjVb;
	Sat, 20 Jul 2024 16:36:39 +0800 (CST)
Received: from kwepemf100006.china.huawei.com (unknown [7.202.181.220])
	by mail.maildlp.com (Postfix) with ESMTPS id 2CD4F18006C;
	Sat, 20 Jul 2024 16:38:24 +0800 (CST)
Received: from localhost.localdomain (10.175.104.67) by
 kwepemf100006.china.huawei.com (7.202.181.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 20 Jul 2024 16:38:23 +0800
From: Yang Erkun <yangerkun@huawei.com>
To: <zlang@kernel.org>, <fdmanana@suse.com>
CC: <fstests@vger.kernel.org>, <linux-mm@kvack.org>, <hughd@google.com>,
	<akpm@linux-foundation.org>, <yangerkun@huawei.com>
Subject: [PATCH] generic/736: don't run it on tmpfs
Date: Sat, 20 Jul 2024 16:35:38 +0800
Message-ID: <20240720083538.2999155-1-yangerkun@huawei.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf100006.china.huawei.com (7.202.181.220)

We use offset_readdir for tmpfs, and every we call rename, the offset
for the parent dir will increase by 1. So for tmpfs we will always
fail since the infinite readdir.

Signed-off-by: Yang Erkun <yangerkun@huawei.com>
---
 tests/generic/736 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/736 b/tests/generic/736
index d2432a82..9fafa8df 100755
--- a/tests/generic/736
+++ b/tests/generic/736
@@ -18,7 +18,7 @@ _cleanup()
 	rm -fr $target_dir
 }
 
-_supported_fs generic
+_supported_fs generic ^tmpfs
 _require_test
 _require_test_program readdir-while-renames
 
-- 
2.39.2

