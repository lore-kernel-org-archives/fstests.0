Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3449E33998
	for <fstests@vger.kernel.org>; Thu, 26 Sep 2024 14:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727361643; cv=none; b=B9XZQ24UDcTc7qRj5+sdq22W6796l236S7fDJ/rh7CwtB9PZrYKuyd10bbixv0NQIBzFnZq8tc+Q7i2qdUxYYPZjMvDF1b3LrmpV3ISTxis2nhMp9w5n5jMUZ/QmlsgtB3qYVRozQhm52kx6YEvyCvJirzFs9hJUj/NB7RaHFkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727361643; c=relaxed/simple;
	bh=Gh3BDefzWANIBlUkItwrnnGL70b4AwBwZag3ufhwfOU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FL14lRPnFojB/bM+l14tT7wcx3+LUlplAD9RsXrB7EuWkfx6IYymlGJIiBeBAZjOun63ZeoKrM3hJxR73GHufQmAJMvt6+j+JC3wJFCpSIu4p71cLvC1D23Pm8YS9DiF5QJAY1N0pUOn20PnaVTRyfYQ4aM3Buiio2g+5UWYTNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=byFoJwsc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="byFoJwsc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727361641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GB3dwb9sxHNH9jLb9R81wNQ8Y4QrwR7v6huH3iDLBe8=;
	b=byFoJwscZ7pCSOnMeAO0Mi1uCOx7cB61mUtgWS9nbLd4lpNKY7sYEb45L3vOYs4wJMh8dm
	AxuO+RB2tbvCYbV4ZqwCtlsa+MaMafI8Yj0Q4JnxcDIX7mMkPMJlNykdBiOYvE/yVnLfpe
	s3X63slisu8NOGRP+FSH7HKnNy7D1mo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-284-MX1YQHgROSSFkAqRsFDu4A-1; Thu,
 26 Sep 2024 10:40:39 -0400
X-MC-Unique: MX1YQHgROSSFkAqRsFDu4A-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CDB2D1943CFC
	for <fstests@vger.kernel.org>; Thu, 26 Sep 2024 14:40:38 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.32.70])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 66308195421D
	for <fstests@vger.kernel.org>; Thu, 26 Sep 2024 14:40:38 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: fstests@vger.kernel.org
Subject: [PATCH 2/2] fsx: add missing fallocate flag ifdefs
Date: Thu, 26 Sep 2024 10:41:47 -0400
Message-ID: <20240926144147.106685-3-bfoster@redhat.com>
In-Reply-To: <20240926144147.106685-1-bfoster@redhat.com>
References: <20240926144147.106685-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The various fallocate flags are mostly ifdef'd for backward
compatibility with the exception of the associated test_fallocate()
calls to verify functionality at runtime. I suspect the reason for
this was to avoid ifdef ugliness around having to clear the runtime
flag for each operation, but unfortunately this defeats the purpose
of the ifdef protection everywhere else.

Factor out the fallocate related test calls into a new helper and
add the appropriate ifdefs.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 ltp/fsx.c | 59 ++++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 45 insertions(+), 14 deletions(-)

diff --git a/ltp/fsx.c b/ltp/fsx.c
index 677f8c9f..417743c5 100644
--- a/ltp/fsx.c
+++ b/ltp/fsx.c
@@ -2833,6 +2833,50 @@ __test_fallocate(int mode, const char *mode_str)
 #endif
 }
 
+void
+test_fallocate_calls(void)
+{
+	if (fallocate_calls)
+		fallocate_calls = test_fallocate(0);
+	if (keep_size_calls)
+		keep_size_calls = test_fallocate(FALLOC_FL_KEEP_SIZE);
+
+#ifdef FALLOC_FL_UNSHARE_RANGE
+	if (unshare_range_calls)
+		unshare_range_calls = test_fallocate(FALLOC_FL_UNSHARE_RANGE);
+#else
+	unshare_range_calls = 0;
+#endif
+
+#ifdef FALLOC_FL_PUNCH_HOLE
+	if (punch_hole_calls)
+		punch_hole_calls = test_fallocate(FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE);
+#else
+	punch_hole_calls = 0;
+#endif
+
+#ifdef FALLOC_FL_ZERO_RANGE
+	if (zero_range_calls)
+		zero_range_calls = test_fallocate(FALLOC_FL_ZERO_RANGE);
+#else
+	zero_range_calls = 0;
+#endif
+
+#ifdef FALLOC_FL_COLLAPSE_RANGE
+	if (collapse_range_calls)
+		collapse_range_calls = test_fallocate(FALLOC_FL_COLLAPSE_RANGE);
+#else
+	collapse_range_calls = 0;
+#endif
+
+#ifdef FALLOC_FL_INSERT_RANGE
+	if (insert_range_calls)
+		insert_range_calls = test_fallocate(FALLOC_FL_INSERT_RANGE);
+#else
+	insert_range_calls = 0;
+#endif
+}
+
 bool
 keep_running(void)
 {
@@ -3271,20 +3315,7 @@ main(int argc, char **argv)
 		check_trunc_hack();
 	}
 
-	if (fallocate_calls)
-		fallocate_calls = test_fallocate(0);
-	if (keep_size_calls)
-		keep_size_calls = test_fallocate(FALLOC_FL_KEEP_SIZE);
-	if (unshare_range_calls)
-		unshare_range_calls = test_fallocate(FALLOC_FL_UNSHARE_RANGE);
-	if (punch_hole_calls)
-		punch_hole_calls = test_fallocate(FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE);
-	if (zero_range_calls)
-		zero_range_calls = test_fallocate(FALLOC_FL_ZERO_RANGE);
-	if (collapse_range_calls)
-		collapse_range_calls = test_fallocate(FALLOC_FL_COLLAPSE_RANGE);
-	if (insert_range_calls)
-		insert_range_calls = test_fallocate(FALLOC_FL_INSERT_RANGE);
+	test_fallocate_calls();
 	if (clone_range_calls)
 		clone_range_calls = test_clone_range();
 	if (dedupe_range_calls)
-- 
2.46.1

