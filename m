Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6BC4F1E6
	for <fstests@vger.kernel.org>; Thu, 11 Jan 2024 15:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dZpKWvI6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704986820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZbaVDZI9Yay8nKXSEiRsH6VjMkfCi8hLzBqeIODBqXk=;
	b=dZpKWvI6SchIqUSjv1/I3jLQggW0npRqR6l6bdkmCZSOf/hbIc7nCOQqLY9yPdxnViX+OR
	vs3EquwBY4boxhWQ8R/W38eIZFkKBi4+3NN3hvaXJGxz9mGBJS/srpEwCPT7DHyUBXptBz
	Ry3CezGIPkiASjOUUnpizMF0UIrAdcg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-KRFhkXvnPVi_74MtZGjjPw-1; Thu, 11 Jan 2024 10:26:59 -0500
X-MC-Unique: KRFhkXvnPVi_74MtZGjjPw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 53CC68925C1
	for <fstests@vger.kernel.org>; Thu, 11 Jan 2024 15:26:59 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.45.226.101])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CBF10492BC6;
	Thu, 11 Jan 2024 15:26:58 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: fstests@vger.kernel.org
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH] generic/390: Fix test number in comment
Date: Thu, 11 Jan 2024 16:26:58 +0100
Message-ID: <20240111152658.4318-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Fix a comment in generic/390 to refer to the right test number.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 tests/generic/390 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/390 b/tests/generic/390
index e8f6a5dc..9a5feeb1 100755
--- a/tests/generic/390
+++ b/tests/generic/390
@@ -2,7 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # Copyright (c) 2016 Red Hat, Inc.  All Rights Reserved.
 #
-# FS QA Test 999
+# FS QA Test 390
 #
 # Multi-threads freeze/unfreeze testing. This's a stress test case,
 # it won't do functional check.
-- 
2.43.0

