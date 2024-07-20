Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3E9101E4
	for <fstests@vger.kernel.org>; Sat, 20 Jul 2024 07:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721459783; cv=none; b=khEOGayXRMxFcpzqWECihozVm37tORzRTUgSiPQw3BltiNA9WO05+9GZ/vryzBX1DJ9xwqiXoYBbw6R/Mq6ryGyyLyGIRcnfOkQINJLpOUaGDtoxPgQeJ/kieC/suVrUiHuPI/nHPOaHnix8saUFG7at8Z5HOiVXeUO4jm5wm2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721459783; c=relaxed/simple;
	bh=g9j6CRNvr7KG8D+t49NjKParqsbudVCfSMx8O6pdrQU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hHY5NKqNyHdGaYRbzu6vglhf+c7Me2Y5ScmY9fk7VTWO2oGcwGFQA7rj8Wd0HDocktccxYxzqN9H+9IyPw9zB/gWbpGrWc+DQ0rww5dy1XZ++Z/tDal9n2vRXyJH6dlVdMMniEcSNI2XbVof5HC+c/bvEM5IIl3yDx7trs70k88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WQyTY1q4dzdj6f;
	Sat, 20 Jul 2024 15:14:25 +0800 (CST)
Received: from kwepemf100006.china.huawei.com (unknown [7.202.181.220])
	by mail.maildlp.com (Postfix) with ESMTPS id 5D5891401E9;
	Sat, 20 Jul 2024 15:16:10 +0800 (CST)
Received: from localhost.localdomain (10.175.104.67) by
 kwepemf100006.china.huawei.com (7.202.181.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 20 Jul 2024 15:16:09 +0800
From: Yang Erkun <yangerkun@huawei.com>
To: <zlang@kernel.org>
CC: <fstests@vger.kernel.org>, <linux-mm@kvack.org>, <hughd@google.com>,
	<akpm@linux-foundation.org>, <yoyang@redhat.com>, <yangerkun@huawei.com>
Subject: [PATCH] generic/732: don't run it on tmpfs
Date: Sat, 20 Jul 2024 15:13:23 +0800
Message-ID: <20240720071323.2893437-1-yangerkun@huawei.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf100006.china.huawei.com (7.202.181.220)

Like what 4fd042e0465c("generic/732: don't run it on NFS") say, the same
options for tmpfs won't share the same backend. Skip it for tmpfs.

Signed-off-by: Yang Erkun <yangerkun@huawei.com>
---
 tests/generic/732 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/732 b/tests/generic/732
index 7a40f49b..2b83f216 100755
--- a/tests/generic/732
+++ b/tests/generic/732
@@ -22,7 +22,7 @@ _cleanup()
 }
 
 # real QA test starts here
-_supported_fs ^nfs ^overlay
+_supported_fs ^nfs ^overlay ^tmpfs
 
 _require_test
 _require_scratch
-- 
2.39.2

