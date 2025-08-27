Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B982828312E
	for <fstests@vger.kernel.org>; Wed, 27 Aug 2025 15:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756307789; cv=none; b=LPQBoiVBv8YugCWZI+a33gWegNYNnJamwGG8MiQhT9wmA24qA8qLHEYbd4jl/cwFB3jKLBN5tEdqEqpSOGb0j7GIMkVE2oHBF9WChlULOoLnuZOJFnFcB8u3fc7N7FVdXbRwVYKzOloI5ij2fJoIWgv2546odvxGkcCvyzoY+ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756307789; c=relaxed/simple;
	bh=kYbsGAy8GMeUA6lqVnw4fhaUnEOWu7NsbJ/bKKr/7v8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FGNPJJcf4DiDuqBZar7mxaKsjYWJyAJexOdMjRaxjs/qH1p5Ym5HMmzxXWU+w0N46X7z0B1TMan5nBdexkSdRdx2TpcVdP3PzDZYuXf5dsjdpidDj9ntbq67bCwKul4xPOEarvs7LzpiFVvLxjL1InzYfVs5Xwg36ODKYrMJuow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZcdaDaim; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZcdaDaim"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756307786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XTUCl5n/kCYAs38Bk2khoNLAR3VoHOaPiVzysLhfkqM=;
	b=ZcdaDaimabL0GEPcmmi0aMcwj/KgpqbAI9j85SB8QgRGe4QnPxtA4DGaSfK+ErOj7OkxJS
	6suGnKx4/dVAoStRl06vNp+pot9dZ2YK5WIHM+ildAszxch1EtkR8zMZGoMySE4NsbVEE/
	aAH2BqWVhf4reIRkqiBHcF/OL2UL/d0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-WYihbJHUNV2iNcol9OaX2g-1; Wed, 27 Aug 2025 11:16:23 -0400
X-MC-Unique: WYihbJHUNV2iNcol9OaX2g-1
X-Mimecast-MFC-AGG-ID: WYihbJHUNV2iNcol9OaX2g_1756307783
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45a1ad21752so5434075e9.1
        for <fstests@vger.kernel.org>; Wed, 27 Aug 2025 08:16:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756307782; x=1756912582;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XTUCl5n/kCYAs38Bk2khoNLAR3VoHOaPiVzysLhfkqM=;
        b=BCJ1mGBYP7gDG0LGSUxYSo5+t4njMSSRpmEh5cy6t6xphljSoNbiX9f2jsIMjK36ba
         OJjjvq7RKY+evUMo9AYHyBS6nfBJZzSbu4pWGMPZGTz4x+U3ItODx/MvKn/zJh0EmNRd
         /gEmvsDPEdtPveqcDvd9gM0yUhC0mGqaMW4DtFZotiOO00QrERC9OivpN5/dWjqX31/5
         3rgTpT1J2vU5xfBBQjLhD1X89UHnq6KqLpNZGpzQD3TXDPoGZH5pfN3nsCm5ZMLoAJ0J
         NhkXRD8abQMQUEYzmGmmQQrvaMrqXEEhMHVQG7crapJqsbpqkRsvv+8MLWyqbGfsDpqs
         oJCw==
X-Gm-Message-State: AOJu0YyJMAxmkiY3R/+91rl758A8IEYjn8xShEOBE51MQIZTvnYlfIkj
	TEswytT6gL0mZ4YOm3lcjm+qkSfVIgTHdHLCts6zrFG7FRQnFC+xMJvci6bK8a7X9Dtpzk690vW
	R4E8JC5toNcs9QVcsPlRwEn/6baGlcRfBs+7BHVNMuoZEamq3Cu41qMFhrQ==
X-Gm-Gg: ASbGnct8LJWULnfGfunw21UHNiHCgPdCeBzYmidjbLFwPOVHCB1hVDGME9mLG7u5gzr
	b1V2916ERFKyp1K9RYqnxZN9bsWpC0skgGSBvZWeiWs5KSMpDqZ5d/zPK5cF1lvU1B1imktS0XR
	zWR2LG1PX5xbQR2SRqnmGhnR0sU7LU7rZM6ukjBH+/S7oJxH8+2HIBarUbv7bm8DjvDhDmDmqeo
	3qrR1BzgSirRIzfJAC1E2Fkj5ZIN/BZOwk6DDyRYK1Q4jEId8myCpn+MvP4PIsPIdGk9dPr8uHr
	Gc5LCo8GP8Ezdv9huw==
X-Received: by 2002:a05:600c:c0d9:b0:459:dbc2:201e with SMTP id 5b1f17b1804b1-45b6870dda4mr26737685e9.9.1756307782494;
        Wed, 27 Aug 2025 08:16:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPJoIJySLeawXgr/PUlSZfR/ZHT6IBnT2EEtKiU7dNbcjnC1lc9hzdIQdOtJCf9k0+zYGgNA==
X-Received: by 2002:a05:600c:c0d9:b0:459:dbc2:201e with SMTP id 5b1f17b1804b1-45b6870dda4mr26737515e9.9.1756307782002;
        Wed, 27 Aug 2025 08:16:22 -0700 (PDT)
Received: from [127.0.0.2] ([91.245.205.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f0c6dc1sm35019145e9.1.2025.08.27.08.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 08:16:21 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Wed, 27 Aug 2025 17:16:17 +0200
Subject: [PATCH v2 3/3] xfs: test quota's project ID on special files
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250827-xattrat-syscall-v2-3-ba489b5bc17a@kernel.org>
References: <20250827-xattrat-syscall-v2-0-ba489b5bc17a@kernel.org>
In-Reply-To: <20250827-xattrat-syscall-v2-0-ba489b5bc17a@kernel.org>
To: fstests@vger.kernel.org
Cc: zlang@redhat.com, linux-fsdevel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>, 
 Andrey Albershteyn <aalbersh@redhat.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3958; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=WxjcIOGrMxQ8fi2CDevfH6n7oBhoM80FQoibXLNSdqo=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMtYrOq17uqvDwDGr7//vyMqzHbX11ob6lxITJ92bc
 W4X88fpbqs6SlkYxLgYZMUUWdZJa01NKpLKP2JQIw8zh5UJZAgDF6cATIT3BSPD6b6Onr03OWbW
 m77ZM4GrO+xi/GoHbQPrWx6u4U/Yl88/x/Df8UamnvP22w4cQTcj9+d489uYuGx47SudfIb9/Ht
 b+d+MANODR5E=
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

From: Andrey Albershteyn <aalbersh@redhat.com>

With addition of file_getattr() and file_setattr(), xfs_quota now can
set project ID on filesystem inodes behind special files. Previously,
quota reporting didn't count inodes of special files created before
project initialization. Only new inodes had project ID set.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 tests/xfs/2000     | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/2000.out | 15 +++++++++++
 2 files changed, 88 insertions(+)

diff --git a/tests/xfs/2000 b/tests/xfs/2000
new file mode 100755
index 000000000000..7d45732bdbb7
--- /dev/null
+++ b/tests/xfs/2000
@@ -0,0 +1,73 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Red Hat.  All Rights Reserved.
+#
+# FS QA Test No. 2000
+#
+# Test that XFS can set quota project ID on special files
+#
+. ./common/preamble
+_begin_fstest auto quota
+
+# Import common functions.
+. ./common/quota
+. ./common/filter
+
+# Modify as appropriate.
+_require_scratch
+_require_xfs_quota
+_require_test_program "af_unix"
+_require_test_program "file_attr"
+_require_symlinks
+_require_mknod
+
+_scratch_mkfs >>$seqres.full 2>&1
+_qmount_option "pquota"
+_scratch_mount
+
+create_af_unix () {
+	$here/src/af_unix $* || echo af_unix failed
+}
+
+filter_quota() {
+	_filter_quota | sed "s~$tmp.projects~PROJECTS_FILE~"
+}
+
+projectdir=$SCRATCH_MNT/prj
+id=42
+
+mkdir $projectdir
+mkfifo $projectdir/fifo
+mknod $projectdir/chardev c 1 1
+mknod $projectdir/blockdev b 1 1
+create_af_unix $projectdir/socket
+touch $projectdir/foo
+ln -s $projectdir/foo $projectdir/symlink
+touch $projectdir/bar
+ln -s $projectdir/bar $projectdir/broken-symlink
+rm -f $projectdir/bar
+
+$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+	-c "project -sp $projectdir $id" $SCRATCH_DEV | filter_quota
+$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+	-c "limit -p isoft=20 ihard=20 $id " $SCRATCH_DEV | filter_quota
+$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+	-c "project -cp $projectdir $id" $SCRATCH_DEV | filter_quota
+$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+	-c "report -inN -p" $SCRATCH_DEV | _filter_project_quota
+$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+	-c "project -Cp $projectdir $id" $SCRATCH_DEV | filter_quota
+
+# Let's check that we can recreate the project (flags were cleared out)
+$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+	-c "project -sp $projectdir $id" $SCRATCH_DEV | filter_quota
+$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+	-c "limit -p isoft=20 ihard=20 $id " $SCRATCH_DEV | filter_quota
+$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+	-c "report -inN -p" $SCRATCH_DEV | _filter_project_quota
+$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+	-c "project -Cp $projectdir $id" $SCRATCH_DEV | filter_quota
+
+# success, all done
+status=0
+exit
diff --git a/tests/xfs/2000.out b/tests/xfs/2000.out
new file mode 100644
index 000000000000..e53ceb959775
--- /dev/null
+++ b/tests/xfs/2000.out
@@ -0,0 +1,15 @@
+QA output created by 2000
+Setting up project 42 (path SCRATCH_MNT/prj)...
+Processed 1 (PROJECTS_FILE and cmdline) paths for project 42 with recursion depth infinite (-1).
+Checking project 42 (path SCRATCH_MNT/prj)...
+Processed 1 (PROJECTS_FILE and cmdline) paths for project 42 with recursion depth infinite (-1).
+#42 8 20 20 00 [--------]
+
+Clearing project 42 (path SCRATCH_MNT/prj)...
+Processed 1 (PROJECTS_FILE and cmdline) paths for project 42 with recursion depth infinite (-1).
+Setting up project 42 (path SCRATCH_MNT/prj)...
+Processed 1 (PROJECTS_FILE and cmdline) paths for project 42 with recursion depth infinite (-1).
+#42 8 20 20 00 [--------]
+
+Clearing project 42 (path SCRATCH_MNT/prj)...
+Processed 1 (PROJECTS_FILE and cmdline) paths for project 42 with recursion depth infinite (-1).

-- 
2.49.0

