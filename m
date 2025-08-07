Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA50204F93
	for <fstests@vger.kernel.org>; Thu,  7 Aug 2025 14:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754578357; cv=none; b=F65MJIxFlzsQxlFRfrRruDKqNFtw3dMW22bHgggUtVBH7t3BbkwOYqJvRmRmSqKxCqEUOVr7DYJV5bF3wAV0UobQyHNUVNPFWXmJ51cpbBidRqWprlgy5UA7j9xIZ3KWibCG8L3nulwVRE69B3qKcP1ASexe5dBC5XkD5e0nRbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754578357; c=relaxed/simple;
	bh=1/V8AF0w6kbcPGw3x+zZ+qNok/I3kfNH4+VDj+1di68=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CdqrsCcQXN0qny+npxhvTwbdwq54tzSyyUPkJSv8lB75TZocjPkpKLxZuswl83XNrBeZmdq1FkgSmyCdyTG3v5eCRCtCxTPk0x25S8odwH2RHNJlvuGa8++Sog1A75o58NxTdoK69FbLR8FB6g5eWsSLBAfTOJRahbdCDxqPPY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W1ub0xxL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W1ub0xxL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754578353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9CH5CEQ7wX0+qXi+FYSzNutPc7SuyEZM/TA0JNT/aGQ=;
	b=W1ub0xxLY1LIszCuWfH8MckaMlUU0ECxQILY6zpC/LYaRQbjvr0dMnGqXF7X4kcSLRkjHk
	CuHHBi6GfIdCQvSbewQkN8c5ViXq9anBZURtOerHGyw/qHOWRxIk0M+QLaGTwrjPQNSo8m
	flKPc+U/ayE2QFawnh3cZO1XUHGwzLs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-342-YCu4hEL5OwCzohoS9pk0HQ-1; Thu,
 07 Aug 2025 10:52:32 -0400
X-MC-Unique: YCu4hEL5OwCzohoS9pk0HQ-1
X-Mimecast-MFC-AGG-ID: YCu4hEL5OwCzohoS9pk0HQ_1754578351
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 449D319560B1
	for <fstests@vger.kernel.org>; Thu,  7 Aug 2025 14:52:31 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.88.68])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C1F073001456
	for <fstests@vger.kernel.org>; Thu,  7 Aug 2025 14:52:30 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: fstests@vger.kernel.org
Subject: [PATCH] xfs/131: test iomap zero range via fsx and error tag
Date: Thu,  7 Aug 2025 10:56:26 -0400
Message-ID: <20250807145626.564764-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

iomap supports a zero range operation based on buffered writes. This
mechanism is used in limited spots, such as partial block zeroing,
etc., because usually for larger zeroing ops it is more efficient to
punch a hole and allocate unwritten extents.

This means iomap zero range has limited production test coverage
even though it has some particular corner cases that warrant test
coverage. XFS supports an error injection knob to force use of iomap
zero range on fallocate zero range operations. Add a test to run fsx
with this knob enabled to provide more zeroing test coverage.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---

FYI, this test is intended to go along with this patch[1] that
introduces the errortag.

[1] https://lore.kernel.org/linux-fsdevel/20250807144711.564137-8-bfoster@redhat.com/

 tests/xfs/131     | 26 ++++++++++++++++++++++++++
 tests/xfs/131.out |  2 ++
 2 files changed, 28 insertions(+)
 create mode 100755 tests/xfs/131
 create mode 100644 tests/xfs/131.out

diff --git a/tests/xfs/131 b/tests/xfs/131
new file mode 100755
index 00000000..eb8882a3
--- /dev/null
+++ b/tests/xfs/131
@@ -0,0 +1,26 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Red Hat, Inc..  All Rights Reserved.
+#
+# FS QA Test 131
+#
+# Run fsx with XFS force_zero_range error injection enabled. This is a proxy
+# test for iomap zero range. Zero range is used in limited cases by default,
+# such as EOF zeroing on file extension, etc. This error tag forces use of iomap
+# zero range for fallocate zero range operations.
+#
+. ./common/preamble
+_begin_fstest auto quick zero
+
+# Import common functions.
+. ./common/inject
+
+# Modify as appropriate.
+_require_test
+_require_xfs_io_error_injection "force_zero_range"
+
+_test_inject_error "force_zero_range"
+run_fsx "-q -S 0 -N 100000"
+
+# success, all done
+_exit 0
diff --git a/tests/xfs/131.out b/tests/xfs/131.out
new file mode 100644
index 00000000..2ca0d932
--- /dev/null
+++ b/tests/xfs/131.out
@@ -0,0 +1,2 @@
+QA output created by 131
+fsx -q -S 0 -N 100000
-- 
2.50.1

