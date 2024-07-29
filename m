Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D06328B6
	for <fstests@vger.kernel.org>; Mon, 29 Jul 2024 08:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722243044; cv=none; b=SCFXVqoJyBZ/gOe2mfNX7R9eOVA9GupUxY93bIXDjh5uPj+jshaNKDzvdqBv+i7LPjAVSAtB8o6hfoU3w2A74KXdzXbMMvzrFH141WOard/oMn9lU7qEZTwCsQdGbKpRjg8bAqRXFoS7A8BaJdm/IvyiL3iVVAePxHg7D12ACSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722243044; c=relaxed/simple;
	bh=G31frPrBTmThBuPxQLZt2nDDCeWOXoTEMmTSPm085cs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rSa4HEdaMeitySy0wHWuEf1//85+XPxnDouzpqv9ZlAi+nNTbaacySbG4VoW9NV+0574CsCsLjoPlmqm9Igy/kUU4Usli6m5TK1QW4zyr7NXq0BpbJYeqVSAFzZPda+ZU1T0Ym+xxQVjR9tM5Krrn7rXMVz5AjZKU80wxaWvQm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4WXX8K6pbpz17N0R;
	Mon, 29 Jul 2024 16:48:49 +0800 (CST)
Received: from kwepemf100006.china.huawei.com (unknown [7.202.181.220])
	by mail.maildlp.com (Postfix) with ESMTPS id 2DC651A016C;
	Mon, 29 Jul 2024 16:50:34 +0800 (CST)
Received: from localhost.localdomain (10.175.104.67) by
 kwepemf100006.china.huawei.com (7.202.181.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 29 Jul 2024 16:50:33 +0800
From: Yang Erkun <yangerkun@huawei.com>
To: <hch@infradead.org>, <zlang@kernel.org>
CC: <fstests@vger.kernel.org>, <linux-mm@kvack.org>, <hughd@google.com>,
	<akpm@linux-foundation.org>, <yoyang@redhat.com>, <yangerkun@huawei.com>
Subject: [PATCH v2 1/2] generic/732: remove unused code
Date: Mon, 29 Jul 2024 16:47:14 +0800
Message-ID: <20240729084715.1736839-1-yangerkun@huawei.com>
X-Mailer: git-send-email 2.39.2
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

After commit 4fd042e0465c("generic/732: don't run it on NFS"), we will
not run this case for nfs, so remove this unused code.

Signed-off-by: Yang Erkun <yangerkun@huawei.com>
---
 tests/generic/732 | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tests/generic/732 b/tests/generic/732
index a571f0f5..d8475cda 100755
--- a/tests/generic/732
+++ b/tests/generic/732
@@ -34,11 +34,6 @@ testdir2=$TEST_DIR/mountpoint2-$seq
 rm -rf $testdir1 $testdir2
 mkdir -p $testdir1 $testdir2
 
-# Don't share the data and attribute caches among mount points for NFS.
-# This caching behavior is necessary to reproduce this issue as we're
-# checking the alignment of each mount point's own unique cache.
-[ "$FSTYP" = "nfs" ] && MOUNT_OPTIONS="-o nosharecache"
-
 SCRATCH_MNT=$testdir1 _scratch_mount
 SCRATCH_MNT=$testdir2 _scratch_mount
 rm -rf $testdir1/{A,B}
-- 
2.39.2

