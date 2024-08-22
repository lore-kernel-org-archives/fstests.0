Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5BA1CB329
	for <fstests@vger.kernel.org>; Thu, 22 Aug 2024 14:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724337820; cv=none; b=qsMnVHQ2ppHSY2D2kAcqWOFI3c/zD54TF1oYuATJN8Bgg5Wo/TKXimiZ4aFQgumjjZuS3Wm+R8gD+hfE1qlv3VK9oWXEjIhF4ypapFoJAmfanHxjpO1o9dneczD4bYln90HL5F1fNViEb/eOQJFxPkUgzkJL7MS6FiRGH4CIpFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724337820; c=relaxed/simple;
	bh=FftC8yrDvfKyuw+GZLzhvVQCslSCx/QDL1aumqfuSsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KDI9KYymfCn9K+xYYS5zFNqVYCCjnGgQCXiU8ifcFhfEsYXxbt+zPyy4ysl9KQtb1Lgn7FPt0RecUw1ac+8Umqc7lJcHbePJx47IRT3/ALy3BBp19cvOhXurOKqZz4SykRGAi8eaEEolRBtGLd2UzjA5o3x31pWNM+cfHKB8H5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A/wDss3E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A/wDss3E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724337817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NXUOaSYbloBnEGOc1GKqP3FXkNSxnzybAUTrHdXBTgA=;
	b=A/wDss3EWYGXZWiLXjkA0ekwmBbZp/rwZhaPiZMrXwzjNymXWl1Rk9Q07URSg3yzQpgCfx
	bmLzFMbPlQZSNWZ6ym9BGCra85GnizLvZ+3pCR7zmOPmTQI0gri9h6i/6gV+Xa+9X2Wk/4
	boEx65h9yJFYsjP8WWC4XkXoLVKPHQo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-310-th0zuANuMtafB62YoBSsCA-1; Thu,
 22 Aug 2024 10:43:31 -0400
X-MC-Unique: th0zuANuMtafB62YoBSsCA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0714F1956080;
	Thu, 22 Aug 2024 14:43:30 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.33.147])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CA68D19560A3;
	Thu, 22 Aug 2024 14:43:28 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: fstests@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	djwong@kernel.org,
	josef@toxicpanda.com,
	david@fromorbit.com
Subject: [PATCH 3/3] generic: test to run fsx eof pollution
Date: Thu, 22 Aug 2024 10:44:22 -0400
Message-ID: <20240822144422.188462-4-bfoster@redhat.com>
In-Reply-To: <20240822144422.188462-1-bfoster@redhat.com>
References: <20240822144422.188462-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Filesystem regressions related to partial page zeroing can go
unnoticed for a decent amount of time. A recent example is the issue
of iomap zero range not handling dirty pagecache over unwritten
extents, which leads to wrong behavior on certain file extending
operations (i.e. truncate, write extension, etc.).

fsx does occasionally uncover these sorts of problems, but failures
can be rare and/or require longer running tests outside what is
typically run via full fstests regression runs. fsx now supports a
mode that injects post-eof data in order to explicitly test partial
eof zeroing behavior. This uncovers certain problems more quickly
and applies coverage more broadly across size changing operations.

Add a new test that runs an fsx instance (modeled after generic/127)
with eof pollution mode enabled. While the test is generic, it is
currently limited to XFS as that is currently the only known major
fs that does enough zeroing to satisfy the strict semantics expected
by fsx. The long term goal is to uncover and fix issues so more
filesystems can enable this test.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 tests/generic/362     | 27 +++++++++++++++++++++++++++
 tests/generic/362.out |  2 ++
 2 files changed, 29 insertions(+)
 create mode 100755 tests/generic/362
 create mode 100644 tests/generic/362.out

diff --git a/tests/generic/362 b/tests/generic/362
new file mode 100755
index 00000000..30870cd0
--- /dev/null
+++ b/tests/generic/362
@@ -0,0 +1,27 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Red Hat, Inc.  All Rights Reserved.
+#
+# FSQA Test No. 362
+#
+# Run fsx with EOF pollution enabled. This provides test coverage for partial
+# EOF page/block zeroing for operations that change file size.
+#
+
+. ./common/preamble
+_begin_fstest rw auto
+
+FSX_FILE_SIZE=262144
+# on failure, replace -q with -d to see post-eof writes in the dump output
+FSX_ARGS="-q -l $FSX_FILE_SIZE -e 1 -N 100000"
+
+_require_test
+
+# currently only xfs performs enough zeroing to satisfy fsx
+_supported_fs xfs
+
+ltp/fsx $FSX_ARGS $FSX_AVOID $TEST_DIR/fsx.$seq > $tmp.output 2>&1
+cat $tmp.output
+
+status=0
+exit
diff --git a/tests/generic/362.out b/tests/generic/362.out
new file mode 100644
index 00000000..7af6b96a
--- /dev/null
+++ b/tests/generic/362.out
@@ -0,0 +1,2 @@
+QA output created by 362
+All 100000 operations completed A-OK!
-- 
2.45.0

