Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A4B148850
	for <fstests@vger.kernel.org>; Wed,  4 Sep 2024 20:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725481982; cv=none; b=UDY1RXtUQsCjD47eFj1e6Pjf6bn0Ft/vTi7NPeU09w+OQ2cA22hAacKZViSAsTSXWREiwsdESl0gtJatmuJMgl7W4tqE5X24TtDnGYJK7Y20UcbCvYvNX4rL8x6lm3I4NfpERlOCw41oZFOA5VjkE2mrUXLuy28XME6QgIe0XM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725481982; c=relaxed/simple;
	bh=K+CbyYwwAbVTU6/pJMTuy8luxTt3cvtD/fieWJHfmHE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V1BLl2BVSSLwoUC989qzXuZeQIytBwRcQRseCdquBvW3WV66shH+JQfSZTkWcYXr6JDREhZWnZRMtusAQW52Vaa7hEenzGN/NZAbDbgIYRfxAwlMQpUYKrstshC25TQwc/ZP0aoRsNmLjbQpWCGm0ow0bix5VhhIKpId2ub92Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=BNU4x8WC; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="BNU4x8WC"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7a4df9dc885so5455485a.0
        for <fstests@vger.kernel.org>; Wed, 04 Sep 2024 13:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1725481979; x=1726086779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p7/V8rcbkowuGgIBpEivXhCW6ycCfF2REla3TxQUkdA=;
        b=BNU4x8WCEJHxOiQTdZKGdjc7GcIoP1+KAc11qBo1ODPRsIQL70ZyKqzbY4GffOl4YZ
         yv04+n2jWWk4v2oE5U0r6lpRnQ2xk2FUuY1jl7UtlJewkDR+CBw0++4J5xTzqyPjjbaV
         b1bkRL8LJwHzBh3vOGh58IHAcNCQiPgVw8F845UkSLdfHwqL2bAICFZs+XVEEKVe0M/G
         1rbcnYw52j0N4C2eFFFeLn2BrCb7gEkT+SKcKzwhO5oZDxP0FrCIBqr/jTkDNZhWkcvj
         gzbwaQSpj3QUxMEQKwTr9BOhPtFARdzdxSrHLxwEdoIb0pkMs6P9RYh6bHL14gz4KfHy
         nSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725481979; x=1726086779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p7/V8rcbkowuGgIBpEivXhCW6ycCfF2REla3TxQUkdA=;
        b=qrOPSEYVsujB/VK9MjMa37Z44CDMFgIpbDiubgHAepkuJBitAyw/4JoEVWwuX8xhRI
         U6O6tDJ9IHObqtS0d5qYxrWGJGLhctUQzX7HPTVTzGLNVjYsNJ6XCuQn07DHfB+yY8Bw
         ype5yaJOZwK5L75xFs+H0t2VnTbMS7CHARf1Mny2hPuXy7Zc73lShWQb6AokNQ5TMDk8
         Pja/qSIRIXn4jZHZb23idNrmeInyhjjutBujpUhna/g4AuOKecBxVfQICIcdG30BuDkb
         Xr7Y26z/0TOEvZe1n6tMWq/Dgowx5/N42zi9AWwlYUpK4TkYS0v5NAYaiF4WYoOy0OxL
         AmRQ==
X-Gm-Message-State: AOJu0YzDEVMos4+9wmFZnBNZOuPXkhkH8vRblnYKkcoEVo1elWgibw7B
	dHIXaNhKq2weeU3SE8KB3ra0iALQ1qYyGvP8AkvGdkTZwxrYv33fYYPVMNAkMPatOF7emSb/FQU
	e
X-Google-Smtp-Source: AGHT+IHKNpoltll7NBTDqQCuhHqYQuClaMHU5uVpi5A3kCLXHERCnznscWdXcRmCYd38T+LoIPEUew==
X-Received: by 2002:a05:620a:1a09:b0:7a4:d54f:7fe8 with SMTP id af79cd13be357-7a9888a02f0mr526852385a.19.1725481979373;
        Wed, 04 Sep 2024 13:32:59 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a98efeaf87sm15689085a.76.2024.09.04.13.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 13:32:58 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: fstests@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] fstests: add a test for executing from a precontent watch directory
Date: Wed,  4 Sep 2024 16:32:49 -0400
Message-ID: <01dd22e13ea532321b968a79f6b88d6b4dd23e4e.1725481837.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1725481837.git.josef@toxicpanda.com>
References: <cover.1725481837.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The main purpose of putting precontent hooks in the page fault path is
to enable running an executable from a precontent watch.  Add a test to
create a precontent watched directory with bash in it, and then execute
that copy of bash to validate that we fill in the pages properly and are
able to execute.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/generic/801     | 64 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/801.out |  2 ++
 2 files changed, 66 insertions(+)
 create mode 100644 tests/generic/801
 create mode 100644 tests/generic/801.out

diff --git a/tests/generic/801 b/tests/generic/801
new file mode 100644
index 00000000..7a1cc653
--- /dev/null
+++ b/tests/generic/801
@@ -0,0 +1,64 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Meta Platforms, Inc.  All Rights Reserved.
+#
+# FS QA Test 801
+#
+# Validate the pre-content hooks work properly with exec
+#
+# Copy bash into our source directory and then setup the HSM daemon to mirror
+# into the destination directory, and execute bash from the destination
+# directory to make sure it loads properly.
+#
+. ./common/preamble
+_begin_fstest quick auto fsnotify 
+
+_cleanup()
+{
+	cd /
+	rm -rf $TEST_DIR/dst-$seq
+	rm -rf $TEST_DIR/src-$seq
+}
+
+# real QA test starts here
+_supported_fs generic
+_require_test
+_require_test_program "precontent/populate"
+_require_test_program "precontent/remote-fetch"
+
+dstdir=$TEST_DIR/dst-$seq
+srcdir=$TEST_DIR/src-$seq
+
+POPULATE=$here/src/precontent/populate
+REMOTE_FETCH=$here/src/precontent/remote-fetch
+
+mkdir $dstdir $srcdir
+
+# Copy bash into our source dir
+cp $(which bash) $srcdir
+
+# Generate the stub file in the watch directory
+$POPULATE $srcdir $dstdir
+
+# Start the remote watcher
+$REMOTE_FETCH $srcdir $dstdir &
+
+FETCH_PID=$!
+
+# We may not support fanotify, give it a second to start and then make sure the
+# fetcher is running before we try to run our test
+sleep 1
+
+if ! ps -p $FETCH_PID > /dev/null
+then
+	_notrun "precontent watches not supported"
+fi
+
+$dstdir/bash -c "echo 'Hello!'"
+
+kill -9 $FETCH_PID &> /dev/null
+wait $FETCH_PID &> /dev/null
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/801.out b/tests/generic/801.out
new file mode 100644
index 00000000..98e6a16c
--- /dev/null
+++ b/tests/generic/801.out
@@ -0,0 +1,2 @@
+QA output created by 801
+Hello!
-- 
2.43.0

