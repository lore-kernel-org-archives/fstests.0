Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585132E6116
	for <fstests@vger.kernel.org>; Tue, 11 Nov 2025 11:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762862240; cv=none; b=gxHjbkyZ/vQVy70LZb2kv9XL9+0t3ftC1wpLmmYB9BTI/Q4uVnViJo3hQlNkHV9G3b1M0qQpFcqnJJDmFmrlpd347oasZceDBGCr5IoJxtk6mLeKttxVfTICv6Gqf08QbEH7MzK00qD9EMZDZmZClK7Tv6Q9Bn8pN1BFKlA0dXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762862240; c=relaxed/simple;
	bh=gBfwHqBb0fjwfPhWFJcOx6nUwjcyDaYpSVAJNF/iu+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X/iJLbtNeCnyUjleygVQo4W3We4z+Yt/Nl4l7ELwDE2n2pxV+suiymDaza4F/2l+S5eGJMIR7V641v2+0itUmlYG/cLLBlIjJ9ibBUtjfXfbg8beTPuWbA+tS6i0IohtWWKyJpN0RT96XYy1alWMRXmxiZc00BcRZTR7jpEKdNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C49yH5WH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=A4jz8OvO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C49yH5WH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="A4jz8OvO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762862237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2zrnqMNwwQisUi5/0HFSYT5H78cYFJYZVtgQ4kdh24I=;
	b=C49yH5WHFQkF986j8SRUxpGNfwVGSwMymo9HZIzeEE3rLID5ZQHWJnn6/7J8MFMgy79Rq6
	c3qbU4+rhFh6eabDAv22KO/c1dmhWTMm29YQQ7j4rxAP7aiVAXTCAzgMb6Je4J+BUSmVwq
	2a+mHHn1DrgneeijlJ9c+mwGZj1jxfQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-L2lsRfKJPem_bbhCKV15CQ-1; Tue, 11 Nov 2025 06:57:16 -0500
X-MC-Unique: L2lsRfKJPem_bbhCKV15CQ-1
X-Mimecast-MFC-AGG-ID: L2lsRfKJPem_bbhCKV15CQ_1762862235
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4edb205b610so23132491cf.0
        for <fstests@vger.kernel.org>; Tue, 11 Nov 2025 03:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762862235; x=1763467035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2zrnqMNwwQisUi5/0HFSYT5H78cYFJYZVtgQ4kdh24I=;
        b=A4jz8OvOiy5CSkT4tpagKyQP+lcq+nzhYe2Y1K3Mz7tpF4JkKc3ejWggTZ4Ftvb30N
         0BxpfZLH7l/dmYrt8J05J0SeqwmerAK5YqcjdydRpuS70H8BGI+HwJcWibJXtodlsnkN
         iZuumwNFi4I8tNtA86n9a6DksC//7/m6AJSyYdAd+X0PEu7kt5Ibji5LUxYlOO6b/6wu
         NQYL0t5LZTB75hX9BHBvm0Co2NTcSk0mQEGV6S8LarjxdCcLsDUCPZDx3AlbDFS0R5bn
         rvGZr0S75HH9h2HuWqoxpnEeSo7emmu2OLHBMFOJnztcPVVSkd5QzKkIie6x0mdWeQaz
         dW+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762862235; x=1763467035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2zrnqMNwwQisUi5/0HFSYT5H78cYFJYZVtgQ4kdh24I=;
        b=kS0vbFXhkJpI/+aXDWL0IIKdMFy2PvPQWtuMZVxDwgpIcyefo5faBTmczK4QGOy0Wr
         8MNJx0XqocQfvzZJ6IkeS7CAI5IYyeX+ftDWUfkrwFnpdX8asmo0GxCNQpZ+n8hPzzXC
         zF2qH0H4YpFSlXib4MP6eqRqaBRs9wqqoLv821ei6SVATWe5NWxiuif7JSt/lIKmdp5R
         lekhhWjPk7tr9xyKjkt99NLPeyUQowWI7E/Z7S6wlk5gKJTZC56iqffhsAs1WAAZqlrG
         fC3Xrhlq1zRjPo9Gp1ozKKOul/AcMKsKrd4Ffo75RifnLqH+KvKLPEnW1Myssafb0/tG
         yKtw==
X-Gm-Message-State: AOJu0YxBJ0GsmoZsGh42xpCx5FdNu+lvEkcN5cj05nIUGYt94zoDPPB3
	26Jbau2G6rBHIs0gNGx1KFdeIs0R3sRoOnf4msAsIlyjU5TcKjC8pFfcXRAzF9yjKihc+3Q4ZdU
	z/Zrdi+K/J8laiHwwxjd1fBR6xE77McZkvyz92T0kENTckkc/YKbKg/LGB7Jga5gDo2/hvgEAu8
	v0JmBHx6Qy4eUu71e4zMpT+40NImt1haGWdls=
X-Gm-Gg: ASbGncu/TRx2VHRQYzQwfL0NXLrm+sGG+IlADwuy16N0ceG7fObDAS8pQadmLmFqHVF
	7zoQOPzKoZ2YxoWXptW4L46WlZScpxns3MAjgJco4q3LYFsQe93yFlXB4m04ep1BQQ9hB1OaNhk
	lnfQB6P3u5jq+n+ggppzfI3A/ZckyIONj7ZGFvdQiFnqxQuebLQOsDadUlS0IBrwVsG6/zKIUYU
	Bt6doM9waCIJQ/iwiYlqVl8JVhZBrvqBrYixN8F4RaIoLKDsNkRgW8ZSBhwVYKc5BDht+1HHMkP
	uTo3oDLc4FDtkod+wmkWtp5i0LYWG4luZdLbZ/I=
X-Received: by 2002:a05:6214:628:b0:880:4ed1:ce3f with SMTP id 6a1803df08f44-882386e733bmr161225436d6.55.1762862233143;
        Tue, 11 Nov 2025 03:57:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKby1qL9uh1ShzymCv8CnWkn5Mch6UkI9Lf8/qJhQueJsV3Xy+POSDe1JQZv84hktxwnB8hg==
X-Received: by 2002:a05:6214:628:b0:880:4ed1:ce3f with SMTP id 6a1803df08f44-882386e733bmr161225086d6.55.1762862232531;
        Tue, 11 Nov 2025 03:57:12 -0800 (PST)
Received: from fedorakvm ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88238b75896sm70180696d6.49.2025.11.11.03.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 03:57:12 -0800 (PST)
From: Ravi Singh <ravising@redhat.com>
To: fstests@vger.kernel.org
Cc: zlang@redhat.com
Subject: [PATCH] README: improve README formatting and clarity
Date: Tue, 11 Nov 2025 06:56:58 -0500
Message-ID: <20251111115658.603209-1-ravising@redhat.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Standardize shell command prompts with '$' for readability
- Correct minor typos
- Clarify instructions for running tests.

Signed-off-by: Ravi Singh <ravising@redhat.com>
---
 README | 44 ++++++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/README b/README
index 9e9afe3c..6edcdf31 100644
--- a/README
+++ b/README
@@ -216,6 +216,8 @@ Setup Environment
 5. Copy local.config.example to local.config and edit as needed. The TEST_DEV
    and TEST_DIR are required.
 
+   $ cp local.config.example local.config
+
 6. (optional) Create fsgqa test users and groups:
 
    $ sudo useradd -m fsgqa
@@ -241,13 +243,13 @@ Setup Environment
 
 For example, to run the tests with loopback partitions:
 
-    # xfs_io -f -c "falloc 0 10g" test.img
-    # xfs_io -f -c "falloc 0 10g" scratch.img
-    # mkfs.xfs test.img
-    # losetup /dev/loop0 ./test.img
-    # losetup /dev/loop1 ./scratch.img
-    # mkdir -p /mnt/test && mount /dev/loop0 /mnt/test
-    # mkdir -p /mnt/scratch
+    $ xfs_io -f -c "falloc 0 10g" test.img
+    $ xfs_io -f -c "falloc 0 10g" scratch.img
+    $ mkfs.xfs test.img
+    $ losetup /dev/loop0 ./test.img
+    $ losetup /dev/loop1 ./scratch.img
+    $ mkdir -p /mnt/test && mount /dev/loop0 /mnt/test
+    $ mkdir -p /mnt/scratch
 
 The config for the setup above is:
 
@@ -316,7 +318,7 @@ Tools specification:
       test, if the kernel supports kmemleak.
  - fsstress:
     - Set FSSTRESS_AVOID and/or FSX_AVOID, which contain options added to
-      the end of fsstresss and fsx invocations, respectively, in case you wish
+      the end of fsstress and fsx invocations, respectively, in case you wish
       to exclude certain operational modes from these tests.
  - core dumps:
     - Set COREDUMP_COMPRESSOR to a compression program to compress crash dumps.
@@ -378,25 +380,27 @@ ______________________
 
 Running tests:
 
-    - cd xfstests
+    - $ cd xfstests-dev
     - By default the tests suite will run all the tests in the auto group. These
       are the tests that are expected to function correctly as regression tests,
       and it excludes tests that exercise conditions known to cause machine
       failures (i.e. the "dangerous" tests).
-    - ./check '*/001' '*/002' '*/003'
-    - ./check '*/06?'
-    - Groups of tests maybe ran by: ./check -g [group(s)]
+          $ ./check
+    - Running specific tests:
+          $ ./check '*/001' '*/002' '*/003'
+          $ ./check '*/06?'
+    - Groups of tests maybe ran by: $ ./check -g [group(s)]
       See the tests/*/group.list files after building xfstests to learn about
       each test's group memberships.
     - If you want to run all tests regardless of what group they are in
-      (including dangerous tests), use the "all" group: ./check -g all
-    - To randomize test order: ./check -r [test(s)]
+      (including dangerous tests), use the "all" group: $ ./check -g all
+    - To randomize test order: $ ./check -r [test(s)]
     - You can explicitly specify NFS/AFS/CIFS/OVERLAY, otherwise
       the filesystem type will be autodetected from $TEST_DEV:
-        - for running nfs tests: ./check -nfs [test(s)]
-        - for running afs tests: ./check -afs [test(s)]
-        - for running cifs/smb3 tests: ./check -cifs [test(s)]
-        - for overlay tests: ./check -overlay [test(s)]
+        - for running nfs tests: $ ./check -nfs [test(s)]
+        - for running afs tests: $ ./check -afs [test(s)]
+        - for running cifs/smb3 tests: $ ./check -cifs [test(s)]
+        - for overlay tests: $ ./check -overlay [test(s)]
           The TEST and SCRATCH partitions should be pre-formatted
           with another base fs, where the overlay dirs will be created
 
@@ -438,7 +442,7 @@ Test script environment:
 	    $TEST_DEV.
 
 	(b) mkfs a new XFS filesystem on $SCRATCH_DEV, and mount this
-	    on $SCRATCH_MNT. Call the the _require_scratch function
+	    on $SCRATCH_MNT. Call the _require_scratch function
             on startup if you require use of the scratch partition.
             _require_scratch does some checks on $SCRATCH_DEV &
             $SCRATCH_MNT and makes sure they're unmounted. You should
@@ -507,7 +511,7 @@ Test script environment:
 	initialise the test environment correctly, the the build infrastructure
 	also scans the test files for _begin_fstests invocations. It does this
 	to compile the group lists that are used to determine which tests to run
-	when `check` is executed. In other words, test files files must call
+	when `check` is executed. In other words, test files must call
 	_begin_fstest with their intended groups or they will not be run.
 
 	However, because the build infrastructure also uses _begin_fstests as
-- 
2.51.1

