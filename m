Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DBC2EEE61
	for <fstests@vger.kernel.org>; Tue, 11 Aug 2026 15:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786462060; cv=none; b=j9CzaLSq3uRSxWi92bCgkQroCDDAPuHGShhpHNUbybE0tVN31TfF6R9urPVAxC/ptSNneiDBzzhQWzgThBHynt5W3HhpdebENmQvxSZyUex1LbDqg3yHtCCaJxsxQuV1e0RvSY/SUZWtTij3vSaO2dtseR2+a7XomgHujQ0E/0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786462060; c=relaxed/simple;
	bh=fo5Rh+MaFKDVfsDQQNWvL5zGPGPyMcaLOVrlpWhATgY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SYFlDX7G1Ot28/6XJ9/9YUoj/SMjNyQkQHXL/wxVLaVTWA4Srokzh1Fx6Ljn2UCUi436IGJ6xuXa1cyEJRAKehItdUl4YTugZaNQBvSA4WxYS20gc5A5gu3gRAgBPKJYwWCWRnP9mjB2BXw47p/00MWHR/I806EqJV1F0u9JbEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OxA2+fXX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qUT1Krws; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OxA2+fXX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qUT1Krws"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786462057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IdvSwCeY4NdtA+mq9zclySiPc8pPZgwi8xAktxMwpRM=;
	b=OxA2+fXXCbZtmPahc8XorrKU+KwLZjD9EGJwyYFaaHCgz6971/AbJpZ0vjQ7WE/CN5wh5m
	86Y2ZMAsiATL1gOedO+fVSndRriRpsjdbMUpBI40mJnTIILHXikzI7c5nd8m2rIcgVMgMA
	ffIOYKBk2cPDFqSQWi8sm2YduQt34LE=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-MqXJOTR0NIilrDzn_lSktw-1; Tue, 11 Aug 2026 11:27:36 -0400
X-MC-Unique: MqXJOTR0NIilrDzn_lSktw-1
X-Mimecast-MFC-AGG-ID: MqXJOTR0NIilrDzn_lSktw_1786462056
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cfa55c9430so576775ad.0
        for <fstests@vger.kernel.org>; Tue, 11 Aug 2026 08:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786462056; x=1787066856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IdvSwCeY4NdtA+mq9zclySiPc8pPZgwi8xAktxMwpRM=;
        b=qUT1KrwsZSr4oHnZ9JUlIi94IljM7n6r+siMfYv0IegzLhWlAF6C16e+ocnvYVCShM
         DTFii+9vP6ds+gJnFVOWK33m78XGn2GuRSYHVCo8CjPZDp9bIPnmDdp2ZyddDTSBUjPa
         3V0TfTqgejoETtFkn7fYvwH5w4ouEXkjxCDk5vP9AGoz8gJwcAjC5APQ0dkCSxClfrt0
         f0WrAZZ0JB1mOJ2fFzGwQci98xKa3CqYDaoPXcvc5PEn7YqCqC0HgT8N0KPszyKjfxBi
         2fUNBxtY0l0PYvgSaie9UXMSYmPkQoZILin2bICeEaukrQTTnpko3xrV92uHwPcJe1Ig
         dYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786462056; x=1787066856;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IdvSwCeY4NdtA+mq9zclySiPc8pPZgwi8xAktxMwpRM=;
        b=SSCPuLn572GnUUsdWP13cAEK2P4mAurNybNbRmhC6/16MEaojLgO9LUsZtFNAU6Trv
         zuCk8GT7ZKYulaHDHMxTw4HC1r/I7GusLTv7Q61LH/+1ed//+PleRIvWLWjb+tCBI0so
         VhuL9CQLiXug5xMMKkgIyvPz4MNj5/xGC0WQqS/HVzXPMqLqWtnV+jwHhat/P7SNS9yZ
         yOOG5mRjkT9If3iN6H+n/R9jH5u4WlWHneg5kInsTVnHql9qcVrJFFJ4SE/mN1Gjh8Tw
         L2rFjZnjlnXKgLA6t+A/xVnz/7t/FB8i/qkXx9+n0/DAPTIjonXP9Ow2Zb2ez5GdFEcp
         hwfQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq5sPuobQnv6X6DY4znUyE7IO6FH2dRbQsKe+to3Q/T9Nbsk7lzWIlJLhDGR6xKS4ERLgORK1pU@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4BeEZrnbExf3BJFCXbYhRoBMI9QkKXKB5ffoiweZiIaQ2gICR
	Yt39m5F/7jP31rwGVWT0DOM6Myaj3ChAFGsOc52zLvlFo/Rk/pRGPr8bRpq7x2A9fn5TWvUvlqr
	yWOrMSLc99iU094EIfFFZOmrOTBTAxKsC1DWd0Rh0KNFEeR6LCtkZWC4dz2s=
X-Gm-Gg: AR+sD102+lTEbP97V0+2iEE7VlrNft7VQorGvQnhBfgNyM2g8t0FyCTP4/80YgBMfz4
	b1eH4I3xyrOagZzMyEUPAF3dPevb90B1QegVEB3P24v3G/Dbd5UXoo5Y8Y2QLZdJrnnpbsuhPBj
	GfPR7ta8h/dggtE3vb9n1Eo4CxRuNusSN+n3yd2nx+Ijb3vhtZUpzLxUu2ECMmK/y+RHI8d2UUC
	lS5U5R8QKxtinVXi7O6abUZs+kpv6nQ2FmyfAJ8YzazyDJwxMNQNoc4VOVwZJSZdIyA0MJ1+NTd
	3bNampJ3ZDaKCPHg6e//EvYnRf5y9Q8hf3g1eT/J2sRyc+TPJLcpB0L7OLyN4GHOh9lRh3v95Z+
	50I+ZOWuV6SA=
X-Received: by 2002:a17:902:c403:b0:2d3:160b:c01f with SMTP id d9443c01a7336-2d3177bbd85mr43271445ad.6.1786462055554;
        Tue, 11 Aug 2026 08:27:35 -0700 (PDT)
X-Received: by 2002:a17:902:c403:b0:2d3:160b:c01f with SMTP id d9443c01a7336-2d3177bbd85mr43270935ad.6.1786462055014;
        Tue, 11 Aug 2026 08:27:35 -0700 (PDT)
Received: from anathem.redhat.com ([2001:8003:4b1b:d900:266e:8be8:569:ffa6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31cf628e2aasm590811eec.14.2026.08.11.08.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 08:27:33 -0700 (PDT)
From: Donald Douwsma <ddouwsma@redhat.com>
To: linux-xfs@vger.kernel.org,
	fstests@vger.kernel.org
Cc: Donald Douwsma <ddouwsma@redhat.com>
Subject: [PATCH] xfs: flag panicking tests as dangerous
Date: Wed, 12 Aug 2026 01:27:04 +1000
Message-ID: <20260811152705.2813177-1-ddouwsma@redhat.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xfs/649 can derail test runs as its not flagged as dangerous.
Fix that and pick up other tests that can also BUG or hang.

Signed-off-by: Donald Douwsma <ddouwsma@redhat.com>
---
Note: xfs/270 mentions a potential hang/panic, but its unclear if that's
likely or expected. If not then we shouldn't flag it, thoughts?
---
 tests/xfs/051 | 2 +-
 tests/xfs/081 | 2 +-
 tests/xfs/270 | 2 +-
 tests/xfs/306 | 2 +-
 tests/xfs/311 | 2 +-
 tests/xfs/431 | 2 +-
 tests/xfs/649 | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/xfs/051 b/tests/xfs/051
index 95c89bbab..a46959375 100755
--- a/tests/xfs/051
+++ b/tests/xfs/051
@@ -9,7 +9,7 @@
 # causes BUG() errors or a panic.
 #
 . ./common/preamble
-_begin_fstest shutdown auto log metadata
+_begin_fstest shutdown auto log metadata dangerous
 
 _cleanup()
 {
diff --git a/tests/xfs/081 b/tests/xfs/081
index 14c0d13e5..6f85bd8a6 100755
--- a/tests/xfs/081
+++ b/tests/xfs/081
@@ -13,7 +13,7 @@
 # removexattr will hang.
 #
 . ./common/preamble
-_begin_fstest auto quick attr
+_begin_fstest auto quick attr dangerous
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/270 b/tests/xfs/270
index d3bce386a..71430dd15 100755
--- a/tests/xfs/270
+++ b/tests/xfs/270
@@ -10,7 +10,7 @@
 # ro-compat features), and this case is the regression testcase.
 #
 . ./common/preamble
-_begin_fstest auto quick mount
+_begin_fstest auto quick mount dangerous
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/306 b/tests/xfs/306
index d48b75363..8430aea84 100755
--- a/tests/xfs/306
+++ b/tests/xfs/306
@@ -13,7 +13,7 @@
 # CIL (i.e., when the log is subsequently flushed).
 #
 . ./common/preamble
-_begin_fstest auto quick punch
+_begin_fstest auto quick punch dangerous
 
 # Import common functions.
 
diff --git a/tests/xfs/311 b/tests/xfs/311
index 8b806fc29..766d8bad4 100755
--- a/tests/xfs/311
+++ b/tests/xfs/311
@@ -11,7 +11,7 @@
 # panic.
 #
 . ./common/preamble
-_begin_fstest auto quick
+_begin_fstest auto quick dangerous
 
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/xfs/431 b/tests/xfs/431
index 9764d2437..5fb76ccd1 100755
--- a/tests/xfs/431
+++ b/tests/xfs/431
@@ -12,7 +12,7 @@
 # See CVE-2017-14340 for more information.
 #
 . ./common/preamble
-_begin_fstest auto quick
+_begin_fstest auto quick dangerous
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/649 b/tests/xfs/649
index 56277c629..2f735fb0e 100755
--- a/tests/xfs/649
+++ b/tests/xfs/649
@@ -23,7 +23,7 @@
 #
 
 . ./common/preamble
-_begin_fstest auto quick attr
+_begin_fstest auto quick attr dangerous
 
 _fixed_by_kernel_commit ae668cd567a6 \
 	"xfs: do not propagate ENODATA disk errors into xattr code"
-- 
2.52.0

