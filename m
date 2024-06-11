Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25657176AA7
	for <fstests@vger.kernel.org>; Tue, 11 Jun 2024 08:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718096349; cv=none; b=H5CVgd487SMdlXM1dxGPFyj9aIvL+msKxcWYiJw+fmNPVDt6N564eWZQ19YwRVMnUlcc2cATgRwgNqs6nQoyzrXJVqWeSDnHgtrrW2Gb5/193M+QtIOrEKypDxDvByZNAkBfZtoAiWDsiVEnLggXHFLtOc+WrX7ycUKGiWdyUHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718096349; c=relaxed/simple;
	bh=8Z49mIZ9qVHJxCRu6GuXPAAQBps/B3PJdd7iD4gneno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F00oDNFgtZVv3QTnKt6Oyu5WOLJoTv+o0b8QSu/c0FxsNxn46HpA5S/x0l+eTz8GqSKgcpLb43RB0Pd7kn/rpbisCHDyswgdVaGzeNXUcEW7Ml8rGu6w1ychtgjeb51HKwA5HRDRFt0ZLjWGlaTUDhACPtFj3iqNguY7UqP4Ax0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=YHwSAgQv; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="YHwSAgQv"
Received: from cwcc.thunk.org (pool-173-48-115-193.bstnma.fios.verizon.net [173.48.115.193])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 45B8x2pE015404
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 04:59:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1718096344; bh=FONV8FfQW1ELUNBxG2j7Ysw8xwLoKJR4wsAOwwoZ+gM=;
	h=From:Subject:Date:Message-ID:MIME-Version;
	b=YHwSAgQvhbtyQ0t1lWmPR3TdC3FXG9LHn0QmXYkbewcm6/Mh8AyCaKzl+W3wIn71q
	 /O83GC+kZsiakbY9jc63wz/s62GQiIYeCSZ/v9jDHfYXYhu3npXq4Jf1xRN8k8K5u+
	 RCcRJ4tqCFVubsirA1qbVxhHePUTT3jOAi+TfpCQRdb06ef6kFFcgeEsjRQzmpW88g
	 x3hxqNEVaQZJ354IEWIBT6iLnM5kypDR8l7xKINAUsRNhSkc+ocGbMQB8Yb8DPQuRk
	 ChrnPiGMsBSL3WRde63fwJVYayoboEoFZ46bMXECGf9if/op0Rnbk+/Q4fZelGnKSH
	 osgvg9KO6P7Ow==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id DB76F15C0579; Tue, 11 Jun 2024 04:59:02 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: fstests@vger.kernel.org
Cc: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 2/2] generic/455: skip the test if the file system doesn't support journaling
Date: Tue, 11 Jun 2024 04:58:53 -0400
Message-ID: <20240611085853.200102-2-tytso@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240611085853.200102-1-tytso@mit.edu>
References: <20240611085853.200102-1-tytso@mit.edu>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test uses dm-log-writes to test power fail scenarios, so it won't
work if the file system doesn't support metadata journaling.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 tests/generic/455 | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/generic/455 b/tests/generic/455
index da803de08..75437b90d 100755
--- a/tests/generic/455
+++ b/tests/generic/455
@@ -65,6 +65,13 @@ _log_writes_init $DMTHIN_VOL_DEV
 
 _log_writes_mkfs >> $seqres.full 2>&1
 
+# This test requires metadata journaling since it simulates a power failure
+msg=$(_has_metadata_journaling "$LOGWRITES_DMDEV")
+if [ -n "$msg" ]; then
+    _log_writes_remove
+    _notrun "$msg"
+fi
+
 # Log writes emulates discard support, turn it on for maximum crying.
 _log_writes_mount -o discard
 
-- 
2.43.0

