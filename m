Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846A7A94F
	for <fstests@vger.kernel.org>; Sat, 10 May 2025 00:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746837782; cv=none; b=ubCsa/jIWVhDzTUzbMfN/qXeJ8Da9tk96RWtdQpb68UAo1m0wJ6nt4ygQkoBW8L51kaIFuDB8FfnaCkmglPIMt78oyiHirHiWkbPotqG5a2zGBkWEEYGYD5mfakmY+PUXznEe7TKiH+GWLFgPvpf7xRvD6/wFnjIu33aDflc3DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746837782; c=relaxed/simple;
	bh=JGrbBSEp5lCQJeyHe2uOG+abiBSlpo9H+CrV3ySJ9Yo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T8d5b84jnvaRBgteHID/IOjDUHo67dKvvHlS5UO1DDfZl6huicvpO3l6Sg6Hirs0hGJ06AQPs2MhaiFwHQ5XTWxk2M8KyupEbiWy2Phu1redeYxLT/88IOv550gRmy1YV51fZqplMued0pU3Yd7suhza2TFfu8k5vYHkn5XFqdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b1d3ylSr; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1d3ylSr"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-30c3a038acfso2112050a91.3
        for <fstests@vger.kernel.org>; Fri, 09 May 2025 17:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746837780; x=1747442580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cl7MI0VU2olpgkyRKwZzAa4T/sHV4NpTWashWquXczo=;
        b=b1d3ylSrVuEVNDX2wCrR6fd25zma7FSQQevDSbw4fRRHgqtf4Q8gtO59FA9Aau9qwX
         0KWaEulGUtUdyYE5ib7As0gMbLZ+P3rfWUf8sGYDhu22uQB+RoX9pdqiQC+Cmqvqjtzi
         8SUN4503a7OpFjc9HJnNDZ1VxDPU/Nh+2g56B/JzL4gPNKHEusCE3VIuppaD1BIu/i82
         m5MsmJyjcut/gpFzd1IYrxJRibtYZtvRnZQN/HN3SooFLKcki7fe9u76I13OS5s+DFEf
         hB0AshY9nA3CRkeYGMdTpb8wbEjRwRUAJvT59UrIpMS64vckbes7ewIptmJ9gRi6xCLc
         01HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746837780; x=1747442580;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cl7MI0VU2olpgkyRKwZzAa4T/sHV4NpTWashWquXczo=;
        b=ToF/9Ns350bchsqxzLjuKKDIwl0gXf3CwUcN+e+OA2KoytaPoULW+jhvUNrQUAehls
         WS2aISJWjWCf+hz1AQtS3bEabElkyAqK2Dmk8aoboAvc+rhq7dHqgiO0z6/zt/vmZvE7
         c4TTEyqvl75wA2iNcaycXrvwTZWUCu1IiFrNLAcIr+7T0uSjxO9DYhujU3hr4ELYIeTg
         WkkOcqgoTsA56QFY+ZrAvqIquKTPoAil6BuKt0jfeyLXxd4QqKNgs+eJJphwYFFL5qFj
         DWbCWQFLnx5U2DLUhd6VOfj64RIvC3J6EsYjcVIOeShdcA8uPe+pkQYpFxB/NPG/97lc
         /+TQ==
X-Gm-Message-State: AOJu0Yy2WFoASoxZSDGQloOgVl6ZAa04AzAqniduvmp/IZ/a00KC0pTC
	H5xCxBxS4ST/pO0Zl+qRLr9TfI8leC23yoIKwDqrLdn/eRjhL22EXCZz0A==
X-Gm-Gg: ASbGncvqcdS8bD0DFYquNgYnG/KNdDL8ULAmuZJcnPi9DNeqD7zsXtr3vcF/O9rXeJQ
	dVESGhM4JsmQpCUjq3K75tSXtrpaE9DekJSmljUP3kgbzxCLzTg6pjv/NjPdYCHGSd027451f66
	YIwR/E3C41sPimQiSUY9iBncEK6d3LMOmR9HwVrDo7OPZslnXma0uHaYAw9g+3b42s3tpGagkdo
	fK6w6Uw7rQDw3xUmPXvglnLtoA8imh0a+qOq8uVIh4Iehafgc7qQST+LdKk5mtgFpfTmbQ7kBgR
	fY0PVCCqxguzXLiPpvxg72XyfNOKlAdIoX5kk60QRT0qXegbPDc2jzf/2Mf/dTEEXWmyXVZwTnJ
	okew=
X-Google-Smtp-Source: AGHT+IH9tgPkp/dc35A7uOyq9Ai4sYPNHOyf+hv+mdJt77MxuUS+YuOSoar8I/YIxJdfEH7kO5PbWA==
X-Received: by 2002:a17:90b:558f:b0:2ee:5958:828 with SMTP id 98e67ed59e1d1-30c3ce050edmr10287402a91.9.1746837780436;
        Fri, 09 May 2025 17:43:00 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:4309:48b4:b5fe:5557])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30ad4ffb4a0sm4701865a91.46.2025.05.09.17.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 17:43:00 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: fstests@vger.kernel.org
Cc: Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH] selftest: add a test that flakes
Date: Fri,  9 May 2025 17:42:55 -0700
Message-ID: <20250510004256.451058-1-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add selftest/007 which should fail about half of the time.

Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
---
 tests/selftest/007     | 14 ++++++++++++++
 tests/selftest/007.out |  3 +++
 2 files changed, 17 insertions(+)
 create mode 100755 tests/selftest/007
 create mode 100644 tests/selftest/007.out

diff --git a/tests/selftest/007 b/tests/selftest/007
new file mode 100755
index 00000000..0e983b37
--- /dev/null
+++ b/tests/selftest/007
@@ -0,0 +1,14 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. 007
+#
+# A test that flakes due to occasional output mismatch
+#
+. ./common/preamble
+_begin_fstest selftest
+
+echo "I am intentionally flaky"
+echo $((RANDOM % 2))
+status=0
+exit
diff --git a/tests/selftest/007.out b/tests/selftest/007.out
new file mode 100644
index 00000000..0b5e439a
--- /dev/null
+++ b/tests/selftest/007.out
@@ -0,0 +1,3 @@
+QA output created by 007
+I am intentionally flaky
+0
-- 
2.49.0.1045.g170613ef41-goog

