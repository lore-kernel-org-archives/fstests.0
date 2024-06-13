Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A848F14B941
	for <fstests@vger.kernel.org>; Thu, 13 Jun 2024 22:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718317115; cv=none; b=Y3tl3rIOsze2R0d026U/72kH630gCR9ns4zJkUB+PgEun4KRjmsRpplapL85G8wF7IJaMFYVvnMKITmWJATpmaAZICMl9sslfw3NHvfNTNdjNV1kwsX3VWHLHOFEgA7gO6JSN/k+kl8GByIuDsUlYiTGH9Y8XeGQqnnvBW1lPB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718317115; c=relaxed/simple;
	bh=33AldXDpmVe32yhuUuAdtOOCmd+INFN4OtrEwKQ2rD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RE+1b9KEieL2LJnZD5TFGCNIwOcYq+lpzqqOSzES+Tf8Jw1cCWa+W0hUZipAHXmhzdHcWWsCCVI0V4zDQz+cnajo5Y3E7nkn50E72BP/Zh+Leuo8b9MxNjGt3anRh51yjzMETTT6MzPs6B0MDyCNRZmtt1BwrQKl1htQHBjEkgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=FME7tX0h; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="FME7tX0h"
Received: from cwcc.thunk.org (pool-173-48-115-193.bstnma.fios.verizon.net [173.48.115.193])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 45DMISUl008375
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 18:18:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1718317110; bh=FCYCBWIypQYLonDFM0fuxlBKHs7fK2m/V8Ut9mlF7vY=;
	h=From:Subject:Date:Message-ID:MIME-Version;
	b=FME7tX0hUKpmiAjvlTNAVyVKitOdxqitG1WIzW2v76qt6bM/TYvGkRwng4fTdzRkx
	 c4p03QxkNiAtWNkZTpkZmKBsG3vFf7kExyXDdpoWev9LnegHztLdit6lXz/8FKhE+u
	 f7spu7vw0gFPFH1nz96lahlImNLVZl8z8I766l1v8129A9INxpS0JKbcOUorfXw7n6
	 JAeGeXixlL1TzfI+7xk9A3JNX9sQyYt92cwWw0hGfbhl0quH0CumT9JLTXxJsqB1Z+
	 hz3kl5pEkSOUHfHTZd4FhW1eqa4fK3p66phNrWDYH6H5oC7GwjfEK/x5s5WMc2IDac
	 4Mle0dlqotrig==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id C4B1915C0579; Thu, 13 Jun 2024 18:18:28 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: fstests@vger.kernel.org
Cc: Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 2/2] generic: new test which tests for an io_uring bug that causes umounts to fail
Date: Thu, 13 Jun 2024 18:18:10 -0400
Message-ID: <20240613221810.803463-2-tytso@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240613221810.803463-1-tytso@mit.edu>
References: <20240613215639.GE1906022@mit.edu>
 <20240613221810.803463-1-tytso@mit.edu>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test for an I/O uring bug which holds on to a file reference after the
userspace program exits.

Link: https://lore.kernel.org/fstests/20230831151837.qexyqjgvrllqaz26@zlang-mailbox/
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 tests/generic/750     | 61 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/750.out |  2 ++
 2 files changed, 63 insertions(+)
 create mode 100755 tests/generic/750
 create mode 100644 tests/generic/750.out

diff --git a/tests/generic/750 b/tests/generic/750
new file mode 100755
index 000000000..b45df86b5
--- /dev/null
+++ b/tests/generic/750
@@ -0,0 +1,61 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2006 Silicon Graphics, Inc.  All Rights Reserved.
+#
+# FSQA Test No. 750
+#
+# Run fsstress ; umount to check for EBUSY errors when io_uring is enabled
+# For more information see:
+#    https://lore.kernel.org/fstests/20230831151837.qexyqjgvrllqaz26@zlang-mailbox/
+#
+#
+. ./common/preamble
+_begin_fstest auto rw io_uring stress
+
+# Import common functions.
+. ./common/filter
+# Disable all sync operations to get higher load
+FSSTRESS_AVOID="$FSSTRESS_AVOID -ffsync=0 -fsync=0 -ffdatasync=0"
+
+_workout()
+{
+	num_iterations=30
+	out=$SCRATCH_MNT/fsstress.$$
+	args=`_scale_fsstress_args -p128 -n1000 -f setattr=1 $FSSTRESS_AVOID -d $out`
+	for ((i=0; i < num_iterations; i++))
+	do
+	    $FSSTRESS_PROG $args &>> $seqres.full &
+	    pid=$!
+	    sleep 1
+	    kill $pid >> $seqres.full 2>&1
+	    wait $pid
+	    if ! _scratch_unmount; then
+		echo "failed to umount"
+		status=1
+		exit
+	    fi
+	    _scratch_mount
+	done
+}
+
+# real QA test starts here
+_supported_fs generic
+_require_scratch
+_require_io_uring
+
+_scratch_mkfs_sized $((512 * 1024 * 1024)) >> $seqres.full 2>&1
+_scratch_mount
+
+if ! _workout; then
+	_scratch_unmount 2>/dev/null
+	exit
+fi
+
+if ! _scratch_unmount; then
+	echo "failed to umount"
+	status=1
+	exit
+fi
+status=0
+echo "Silence is golden"
+exit
diff --git a/tests/generic/750.out b/tests/generic/750.out
new file mode 100644
index 000000000..bd79507b6
--- /dev/null
+++ b/tests/generic/750.out
@@ -0,0 +1,2 @@
+QA output created by 750
+Silence is golden
-- 
2.43.0

