Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31BA50A83
	for <fstests@vger.kernel.org>; Thu,  8 Feb 2024 22:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707432774; cv=none; b=Vox3Qyj9Tb2DrAELV/yKO963rNITQGfGbHTJ0WQ+8fXUDvmYZbDd5w5eqb6kWLGCPCNE5TTQmx8c3WwS7GxqA3WltrFIJiFzMvRUbm2U3JzGzk0/ahgFEUf4EiP/IZjYkEDgyS/wPhb5W49mZo8ZYOyZH2swWeUqU3PqLLQaJYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707432774; c=relaxed/simple;
	bh=Z+g2FDgnZIEkDLMDrQIsORQmm63IjtKrkTiYhzlTFeU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TastmmhZdUQSBD3hQFKvYVT9AB297EJ6K0bbKyYeD3nYKCxSo1QCNrzeDQ2hBUOXnVFx0sbYN12XMIQp4g11znKNNnDtpQeq50Jc7CRg1GUqZPJYVZBZTvgWF36aZW0dCC1jpqD1vJSWofdLxzHWUEJ3NpiFWZPeuFXb4NB7vTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hobsPOr5; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hobsPOr5"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4106344eafdso1033305e9.3
        for <fstests@vger.kernel.org>; Thu, 08 Feb 2024 14:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707432771; x=1708037571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0Ax03EBWzhAbur9lM9kduU783cF+R7aFb6z4iKC/jpk=;
        b=hobsPOr5T8iyxvyzG9r3m2HavZYlJtkV5vgY5J/F3uKVghBlWT8+hBH67XmfWx/aRx
         fCRh0BOEFG+M9Y45X3BB2NhJApweVeBW2/yeAfN3I+JExznSu17kYgtLcjdw1ZfFMABY
         QnINmWMC7C8ataH+MTUyCV3CdurVfQToKuAIo39J7gIKesrSIRa4aQ/gqWYzaTJvOOAs
         rLVZHrcynQc3brGgsWOyZtvIHKdwuMRKQSvZrQop7zl6V/kDmvXEX8e+2U9dZ+zUCD7w
         FQ8AkMb9Pbi/G+T9tnQO3j333PRM3R7f1S7X+CldJ9EERXFNnalSKANKpVZ7KPfTDLH5
         Eqfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707432771; x=1708037571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Ax03EBWzhAbur9lM9kduU783cF+R7aFb6z4iKC/jpk=;
        b=B2zmFgmCyX2DokEsWrErHISduEazadg+Hdk1D67Wv4lb7VNPyQ0XO6lbNfXU6YEbZ7
         YWUfSSoYjjivLNA0iTRtoDKSePQSypBf87C+UVLtEZX23WsWuX8qpmXxeq92pX4SjnZD
         P3tu6OXHEO8HQXfGHyRMFJfbbclsCPM+Ti1viXFHsfjUDnUB1aIrnKA6jwEhgVzQwgnq
         n79iaeW13qxvkDhm8ryBDQ3TqpzlqPqY8PF47IzOsiXtEeGH1h7Ybk/fT3lm1hB5+JAB
         m5MzST21ku4rR/5+FwcZZK+ffr8VOrUYUEF9mtsQCFU02vSDhdkC/peXYuvs42dGmfBn
         fONQ==
X-Gm-Message-State: AOJu0YyNjjTYuNX6vhoaBrdMP3MEiSISs28901p4wzyjTC7oIXjbL/f/
	uGcjvmyYxlGvF3Z+Uyb7XCOy8TPoyEFQKyHz5BuA+oEO8UYKMtv1TpHz2LtY
X-Google-Smtp-Source: AGHT+IExLJxfUYxfmIF2kJu9BTaNbite0P4rNZeI4h8ia7YPpf7AfVIpCzd0zTObWEPZ/gAo0Hy2aw==
X-Received: by 2002:a5d:6d83:0:b0:33b:649a:1aba with SMTP id l3-20020a5d6d83000000b0033b649a1abamr26985wrs.53.1707432770752;
        Thu, 08 Feb 2024 14:52:50 -0800 (PST)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with ESMTPSA id p12-20020adff20c000000b0033905a60689sm344190wro.45.2024.02.08.14.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 14:52:50 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
To: fstests@vger.kernel.org
Cc: Martin Jansa <martin.jansa@gmail.com>
Subject: [PATCH] tests/*/Makefile: make sure group.list DIRT exists before install
Date: Thu,  8 Feb 2024 23:52:41 +0100
Message-ID: <20240208225241.644701-1-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

* sometimes make install was failing with:
  cp: cannot stat 'group.list': No such file or directory
  and bunch of non-fatal messages:
  mv: failed to preserve ownership for 'group.list': Invalid argument

* this was when tools/mkgroupfile did
  mv -f "$new_groups" "$groupfile"
  overwritting the group.list file while install-sh was already
  copying it to output

* in the end easily reproducible by
  1) removing tests/*/group.list before each make install
  2) adding some sleep in mkgroupfile before the mv call

Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
---
 tests/btrfs/Makefile    | 2 +-
 tests/ceph/Makefile     | 2 +-
 tests/cifs/Makefile     | 2 +-
 tests/ext4/Makefile     | 2 +-
 tests/f2fs/Makefile     | 2 +-
 tests/generic/Makefile  | 2 +-
 tests/nfs/Makefile      | 2 +-
 tests/ocfs2/Makefile    | 2 +-
 tests/overlay/Makefile  | 2 +-
 tests/perf/Makefile     | 2 +-
 tests/selftest/Makefile | 2 +-
 tests/shared/Makefile   | 2 +-
 tests/tmpfs/Makefile    | 2 +-
 tests/udf/Makefile      | 2 +-
 tests/xfs/Makefile      | 2 +-
 15 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/tests/btrfs/Makefile b/tests/btrfs/Makefile
index 1b72a1a1..6d9995b4 100644
--- a/tests/btrfs/Makefile
+++ b/tests/btrfs/Makefile
@@ -14,7 +14,7 @@ default: $(DIRT)
 
 include $(BUILDRULES)
 
-install:
+install: default
 	$(INSTALL) -m 755 -d $(TARGET_DIR)
 	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
 	$(INSTALL) -m 644 group.list $(TARGET_DIR)
diff --git a/tests/ceph/Makefile b/tests/ceph/Makefile
index 2761e1e9..5f24d518 100644
--- a/tests/ceph/Makefile
+++ b/tests/ceph/Makefile
@@ -12,7 +12,7 @@ default: $(DIRT)
 
 include $(BUILDRULES)
 
-install:
+install: default
 	$(INSTALL) -m 755 -d $(TARGET_DIR)
 	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
 	$(INSTALL) -m 644 group.list $(TARGET_DIR)
diff --git a/tests/cifs/Makefile b/tests/cifs/Makefile
index 62c48935..0b89a01d 100644
--- a/tests/cifs/Makefile
+++ b/tests/cifs/Makefile
@@ -14,7 +14,7 @@ default: $(DIRT)
 
 include $(BUILDRULES)
 
-install:
+install: default
 	$(INSTALL) -m 755 -d $(TARGET_DIR)
 	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
 	$(INSTALL) -m 644 group.list $(TARGET_DIR)
diff --git a/tests/ext4/Makefile b/tests/ext4/Makefile
index a2a0d561..296e3850 100644
--- a/tests/ext4/Makefile
+++ b/tests/ext4/Makefile
@@ -14,7 +14,7 @@ default: $(DIRT)
 
 include $(BUILDRULES)
 
-install:
+install: default
 	$(INSTALL) -m 755 -d $(TARGET_DIR)
 	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
 	$(INSTALL) -m 644 group.list $(TARGET_DIR)
diff --git a/tests/f2fs/Makefile b/tests/f2fs/Makefile
index 9d1ed3c6..0a90b465 100644
--- a/tests/f2fs/Makefile
+++ b/tests/f2fs/Makefile
@@ -15,7 +15,7 @@ default: $(DIRT)
 
 include $(BUILDRULES)
 
-install:
+install: default
 	$(INSTALL) -m 755 -d $(TARGET_DIR)
 	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
 	$(INSTALL) -m 644 group.list $(TARGET_DIR)
diff --git a/tests/generic/Makefile b/tests/generic/Makefile
index b464b22b..d6ed3e55 100644
--- a/tests/generic/Makefile
+++ b/tests/generic/Makefile
@@ -14,7 +14,7 @@ default: $(DIRT)
 
 include $(BUILDRULES)
 
-install:
+install: default
 	$(INSTALL) -m 755 -d $(TARGET_DIR)
 	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
 	$(INSTALL) -m 644 group.list $(TARGET_DIR)
diff --git a/tests/nfs/Makefile b/tests/nfs/Makefile
index 128d2a3a..51590b5c 100644
--- a/tests/nfs/Makefile
+++ b/tests/nfs/Makefile
@@ -14,7 +14,7 @@ default: $(DIRT)
 
 include $(BUILDRULES)
 
-install:
+install: default
 	$(INSTALL) -m 755 -d $(TARGET_DIR)
 	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
 	$(INSTALL) -m 644 group.list $(TARGET_DIR)
diff --git a/tests/ocfs2/Makefile b/tests/ocfs2/Makefile
index 260ad31b..17e01bf3 100644
--- a/tests/ocfs2/Makefile
+++ b/tests/ocfs2/Makefile
@@ -14,7 +14,7 @@ default: $(DIRT)
 
 include $(BUILDRULES)
 
-install:
+install: default
 	$(INSTALL) -m 755 -d $(TARGET_DIR)
 	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
 	$(INSTALL) -m 644 group.list $(TARGET_DIR)
diff --git a/tests/overlay/Makefile b/tests/overlay/Makefile
index 2785b94d..c71e78d6 100644
--- a/tests/overlay/Makefile
+++ b/tests/overlay/Makefile
@@ -14,7 +14,7 @@ default: $(DIRT)
 
 include $(BUILDRULES)
 
-install:
+install: default
 	$(INSTALL) -m 755 -d $(TARGET_DIR)
 	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
 	$(INSTALL) -m 644 group.list $(TARGET_DIR)
diff --git a/tests/perf/Makefile b/tests/perf/Makefile
index 0c74ba39..d72c04d9 100644
--- a/tests/perf/Makefile
+++ b/tests/perf/Makefile
@@ -14,7 +14,7 @@ default: $(DIRT)
 
 include $(BUILDRULES)
 
-install:
+install: default
 	$(INSTALL) -m 755 -d $(TARGET_DIR)
 	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
 	$(INSTALL) -m 644 group.list $(TARGET_DIR)
diff --git a/tests/selftest/Makefile b/tests/selftest/Makefile
index 3ddfca37..cabc35a9 100644
--- a/tests/selftest/Makefile
+++ b/tests/selftest/Makefile
@@ -14,7 +14,7 @@ default: $(DIRT)
 
 include $(BUILDRULES)
 
-install:
+install: default
 	$(INSTALL) -m 755 -d $(TARGET_DIR)
 	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
 	$(INSTALL) -m 644 group.list $(TARGET_DIR)
diff --git a/tests/shared/Makefile b/tests/shared/Makefile
index f3128714..2e6aa718 100644
--- a/tests/shared/Makefile
+++ b/tests/shared/Makefile
@@ -14,7 +14,7 @@ default: $(DIRT)
 
 include $(BUILDRULES)
 
-install:
+install: default
 	$(INSTALL) -m 755 -d $(TARGET_DIR)
 	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
 	$(INSTALL) -m 644 group.list $(TARGET_DIR)
diff --git a/tests/tmpfs/Makefile b/tests/tmpfs/Makefile
index 46544313..46b62dad 100644
--- a/tests/tmpfs/Makefile
+++ b/tests/tmpfs/Makefile
@@ -14,7 +14,7 @@ default: $(DIRT)
 
 include $(BUILDRULES)
 
-install:
+install: default
 	$(INSTALL) -m 755 -d $(TARGET_DIR)
 	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
 	$(INSTALL) -m 644 group.list $(TARGET_DIR)
diff --git a/tests/udf/Makefile b/tests/udf/Makefile
index ed4434f0..feda69a6 100644
--- a/tests/udf/Makefile
+++ b/tests/udf/Makefile
@@ -14,7 +14,7 @@ default: $(DIRT)
 
 include $(BUILDRULES)
 
-install:
+install: default
 	$(INSTALL) -m 755 -d $(TARGET_DIR)
 	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
 	$(INSTALL) -m 644 group.list $(TARGET_DIR)
diff --git a/tests/xfs/Makefile b/tests/xfs/Makefile
index 5f413e67..6bfafdb1 100644
--- a/tests/xfs/Makefile
+++ b/tests/xfs/Makefile
@@ -14,7 +14,7 @@ default: $(DIRT)
 
 include $(BUILDRULES)
 
-install:
+install: default
 	$(INSTALL) -m 755 -d $(TARGET_DIR)
 	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
 	$(INSTALL) -m 644 group.list $(TARGET_DIR)
-- 
2.43.0

