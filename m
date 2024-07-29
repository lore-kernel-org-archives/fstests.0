Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7148328B6
	for <fstests@vger.kernel.org>; Mon, 29 Jul 2024 08:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722243040; cv=none; b=lDBZQ/Zl77TRWhhwP+ITcVnwzhztOT4Z8oFDOTelQR2KiJui9m9uoZP+qBCWmKgU4s2oMk++MOXBWaO8BK5mliAoIyP3Q/3i1QolDbo7TsmF7y18jiqqVFvupw4KLpBn7I7r2GUVCTjcXxLNjYNwT0+L4gI1ALDtHr8P+rvEwXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722243040; c=relaxed/simple;
	bh=aZgvztVTvmtA0wH5pm0pkg2+u8/zuSpiqCrHtnpF48c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VTsZFe8IesWb37muRm3udxKB+hgM//Sx9eoVAK6FT2/+kucs8p+pAFE6LFO4V5R+UGE1z+Wo/5cqUJ+rTVr3OSnQUAEMZQYb/JVsIbi/a01vqMrOZSmsh0oLSAO3N2i3LxS/9Q4seBPOvOwVrioBzdl9Tv9U4dOMxXtkNgoLixs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WXX8F30b4zdkPX;
	Mon, 29 Jul 2024 16:48:45 +0800 (CST)
Received: from kwepemf100006.china.huawei.com (unknown [7.202.181.220])
	by mail.maildlp.com (Postfix) with ESMTPS id E14F4140444;
	Mon, 29 Jul 2024 16:50:34 +0800 (CST)
Received: from localhost.localdomain (10.175.104.67) by
 kwepemf100006.china.huawei.com (7.202.181.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 29 Jul 2024 16:50:34 +0800
From: Yang Erkun <yangerkun@huawei.com>
To: <hch@infradead.org>, <zlang@kernel.org>
CC: <fstests@vger.kernel.org>, <linux-mm@kvack.org>, <hughd@google.com>,
	<akpm@linux-foundation.org>, <yoyang@redhat.com>, <yangerkun@huawei.com>
Subject: [PATCH v2 2/2] generic/732: don't run it on tmpfs
Date: Mon, 29 Jul 2024 16:47:15 +0800
Message-ID: <20240729084715.1736839-2-yangerkun@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240729084715.1736839-1-yangerkun@huawei.com>
References: <20240729084715.1736839-1-yangerkun@huawei.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemf100006.china.huawei.com (7.202.181.220)

Like what 4fd042e0465c("generic/732: don't run it on NFS") say, the same
options for tmpfs won't share the same backend. Skip it for tmpfs.

Besides, add some explanation for why we should skip tmpfs.

Signed-off-by: Yang Erkun <yangerkun@huawei.com>
---
 tests/generic/732 | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/generic/732 b/tests/generic/732
index d8475cda..d08028c2 100755
--- a/tests/generic/732
+++ b/tests/generic/732
@@ -21,7 +21,10 @@ _cleanup()
 	rm -r -f $tmp.*
 }
 
-_supported_fs ^nfs ^overlay
+# This case give a assumption that the same mount options for
+# different mount point will share the same superblock, which won't
+# sucess for the follow fs.
+_supported_fs ^nfs ^overlay ^tmpfs
 
 _require_test
 _require_scratch
-- 
2.39.2

