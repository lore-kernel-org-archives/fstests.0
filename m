Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9127D4689
	for <fstests@vger.kernel.org>; Wed, 27 Nov 2024 04:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732683588; cv=none; b=k/yxzN3/sjIzB9BwLA+jZk1jJEtm6vjqS/RctANW0KjizUxUlHWIwdeD8yhMkou1P34Xflw3bmbHpD8n3pNJKsEpE+ZyOBltrnCe+BB+ftt0qzO2qxyyFB8ZityMf9pS2wlZMpm5MSx9V8lGqV3CK7SiovjFQRpL8THLtmtnOd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732683588; c=relaxed/simple;
	bh=6lk5SvdJgCvc3NF57facjOsN22xR1dJpxk4y/YrBOxk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bJhP51MRGINKwsmoGCt3KugnhjZcwXWAfeYQxghu8/Yuzmae7VE3FhnJ0h3B/xOjQCUptuPfB/TWXcTzN3e+E8VORV7UMtOrp628Gt3YJ2Xic4iE9ambNvL/zYQoXP1XUy0/x0LIv1NN9P4vrL6ZI0GyfKfx76e1dNcV+8S5XhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=qRRERs8w; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="qRRERs8w"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-724f41d520cso2532108b3a.1
        for <fstests@vger.kernel.org>; Tue, 26 Nov 2024 20:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1732683586; x=1733288386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fCIfwS9+Qu4/GAAoXb9FEN4Ou9bsUTltYBHizoDa+q0=;
        b=qRRERs8wChjyOyUB5JZKZcAq7LlLjIXKAjitwBf9M6LWeXghGDNXAnu4xFUIDfTQnh
         mQc8xwJ7ZAWB5YOCtbeUz4iz/JGxpKjWj7pyLFaIoR1ZSIOfVea/lKWB1qq9LqqMSvDs
         WkYt3t73Om2BsdwM1qTYsOqQOXQf2y/3LwipeqRAFPrcohI6VqjfsR2f8jq9plKiFwIq
         cC1RjLmPdYlGrCzFK1c/vVqmDtAUVC8ogT3G9y28RCtHEypm07VrW1R3uPUBclLhlNuR
         KB1n7emiBTW+j3yLAXWayOr2bBHFBKj1evCZ6A1BXrdX9FUXbZhPcmtsFf8e8Epo6J24
         4WbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732683586; x=1733288386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fCIfwS9+Qu4/GAAoXb9FEN4Ou9bsUTltYBHizoDa+q0=;
        b=QQiTZ++rmirBZ8n28jC6jgYI0RXxRiboWZum4rvwBWpIg9vcJNA7mf6qz9prsbWjf5
         UxtBhxIe/C6BUbqKsV8o+6PLSr+cFSsgB63fvjxpm68amy7nKy40aMrKIw3azCHgOlV2
         vz5a0y9vrCeNrW8G1bXQZOqlcDRXa4+6GjiClbkgkRkktQl1tztj/EwEvsq2egunROMu
         QYfH0gbzpmPQE5394LQaU/duz4/DEQMUxm5ylux2ZiSQcXozv6Pv1Xw7OdPF1061dZ+A
         cvedj+SCxsI9pACWqVvyoMWTfz3KrrnNWLpgtCCh9rhfx/JikHuG09SZo0VEYfzLAxDO
         2ylA==
X-Gm-Message-State: AOJu0YxHY2R06oVqcxcFaCPawGhq8FHTr/sx2AwH1AYOQHlYc5SraOl/
	84aVXVAzfSNNc1Fj0sD7n1bMHgNlipNemocFIWoS/mm86YC0w0YxZQ/4ME3sHxRiJ2JBmRcTxqx
	S
X-Gm-Gg: ASbGnct4s+QeqUKa3w7PVsieWtWTLPJTORNmi+M1EIgHyz8XpRjTtVgY+cyATyDy4O5
	2ab5UaK8NGQ6XmryB02q3YFJTCv2GuleC6mXGBBW5hmu95zm8x5CG9k/s/FP0yuGmh9l4V8mo6M
	HAiO04XlLCYXZ/USEnazB9ZY0LlRKQZxsYXWmj9Alne/2SpbvLrX+kuHuDE1dnwB+TIU+CvYOul
	BOoPie/SGgU99xq5DX+IjcVzX8CWY/9t+63nHoG4LmR7EAYMNFU0YEUjIRWIZn2D7X22v6ZRU3c
	imLlx5v+fp0RpA==
X-Google-Smtp-Source: AGHT+IHZvCYw6iMt327qi8ZlZpAYTHWFGkeoUYiRUK+eb9WYpClqu3oJyOPI0e42WFqw2kHaj5Tnpw==
X-Received: by 2002:a05:6a00:3c8c:b0:71e:5d1d:1aa7 with SMTP id d2e1a72fcca58-7253011eef9mr2525036b3a.17.1732683585767;
        Tue, 26 Nov 2024 20:59:45 -0800 (PST)
Received: from dread.disaster.area (pa49-180-121-96.pa.nsw.optusnet.com.au. [49.180.121.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724ead1e79asm8303978b3a.41.2024.11.26.20.59.45
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 20:59:45 -0800 (PST)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1tGA3x-00000003ZVC-2851
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:05 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1tGA3x-0000000FQf8-2czh
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:05 +1100
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Subject: [PATCH 21/40] generic/127: reduce runtime
Date: Wed, 27 Nov 2024 15:51:51 +1100
Message-ID: <20241127045403.3665299-22-david@fromorbit.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241127045403.3665299-1-david@fromorbit.com>
References: <20241127045403.3665299-1-david@fromorbit.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Chinner <dchinner@redhat.com>

...
generic/127 684
...

This takes a long time to run because it runs 6 individual
invocations of fsx sequentially. Make them run concurrently
as they can operate on separate files.

...
generic/127 168
...

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 tests/generic/127     | 67 ++++++++++++++++++++++++++-----------------
 tests/generic/127.out |  6 ----
 2 files changed, 41 insertions(+), 32 deletions(-)

diff --git a/tests/generic/127 b/tests/generic/127
index c8984f273..985c99cfb 100755
--- a/tests/generic/127
+++ b/tests/generic/127
@@ -16,7 +16,10 @@ _begin_fstest rw auto
 # Override the default cleanup function.
 _cleanup()
 {
-    rm -f $tmp.output
+	[ -n "$fsx_pids" ] && kill $fsx_pids 2> /dev/null
+	wait
+	cd /
+	rm -f $tmp.*
 }
 
 # Import common functions.
@@ -27,7 +30,6 @@ FSX_ARGS="-q -l $FSX_FILE_SIZE -o 65536 -S 191110531 -N 100000"
 
 _fsx_lite_nommap()
 {
-    echo "=== FSX Light Mode, No Memory Mapping ==="
     dd if=/dev/zero of=$TEST_DIR/fsx_lite_nommap bs=${FSX_FILE_SIZE} count=1 > /dev/null 2>&1
     if ! ltp/fsx $FSX_ARGS -L -R -W $FSX_AVOID $TEST_DIR/fsx_lite_nommap > $tmp.output 2>&1
     then
@@ -41,7 +43,6 @@ _fsx_lite_nommap()
 
 _fsx_lite_mmap()
 {
-    echo "=== FSX Light Mode, Memory Mapping ==="
     dd if=/dev/zero of=$TEST_DIR/fsx_lite_mmap bs=${FSX_FILE_SIZE} count=1 > /dev/null 2>&1
     if ! ltp/fsx $FSX_ARGS -L $FSX_AVOID $TEST_DIR/fsx_lite_mmap > $tmp.output 2>&1
     then
@@ -55,42 +56,56 @@ _fsx_lite_mmap()
 
 _fsx_std_nommap()
 {
-    echo "=== FSX Standard Mode, No Memory Mapping ==="
-    if ! ltp/fsx $FSX_ARGS -R -W $FSX_AVOID $TEST_DIR/fsx_std_nommap > $tmp.output 2>&1
-    then
-        echo "ltp/fsx $FSX_ARGS -R -W fsx_std_nommap"
-        cat $tmp.output
-        return 1
-    fi
-    cat $tmp.output
-    return 0
+	local fname="$TEST_DIR/$1"
+
+	if ! ltp/fsx $FSX_ARGS -R -W $FSX_AVOID $fname > $tmp.output 2>&1
+	then
+		echo "ltp/fsx $FSX_ARGS -R -W fsx_std_nommap"
+		cat $tmp.output
+		return 1
+	fi
+	cat $tmp.output
+	return 0
 }
 
 _fsx_std_mmap()
 {
-    echo "=== FSX Standard Mode, Memory Mapping ==="
-    if ! ltp/fsx $FSX_ARGS $FSX_AVOID $TEST_DIR/fsx_std_mmap > $tmp.output 2>&1
-    then
-    	echo "ltp/fsx $FSX_ARGS fsx_std_mmap"
+	local fname="$TEST_DIR/$1"
+
+	if ! ltp/fsx $FSX_ARGS $FSX_AVOID $fname > $tmp.output 2>&1
+	then
+		echo "ltp/fsx $FSX_ARGS fsx_std_mmap"
+		cat $tmp.output
+		return 1
+	fi
 	cat $tmp.output
-	return 1
-    fi
-    cat $tmp.output
-    return 0
+	return 0
 }
 
 _require_test
 
-_fsx_lite_nommap || exit
-_fsx_lite_mmap || exit
+_fsx_lite_nommap &
+fsx_pids=$!
 
-_fsx_std_nommap || exit
-_fsx_std_mmap || exit
+_fsx_lite_mmap &
+fsx_pids="$! $fsx_pids"
+
+_fsx_std_nommap fsx_std_nommap &
+fsx_pids="$! $fsx_pids"
+
+_fsx_std_mmap fsx_std_mmap &
+fsx_pids="$! $fsx_pids"
 
 #flush cache after write
 FSX_ARGS="-f $FSX_ARGS"
-_fsx_std_nommap || exit
-_fsx_std_mmap || exit
+_fsx_std_nommap fsx_std_nommap_flush &
+fsx_pids="$! $fsx_pids"
+
+_fsx_std_mmap fsx_std_mmap_flush &
+fsx_pids="$! $fsx_pids"
+
+wait $fsx_pids
+unset fsx_pids
 
 status=0
 _cleanup
diff --git a/tests/generic/127.out b/tests/generic/127.out
index 9459dc897..99fb0fddc 100644
--- a/tests/generic/127.out
+++ b/tests/generic/127.out
@@ -1,13 +1,7 @@
 QA output created by 127
-=== FSX Light Mode, No Memory Mapping ===
 All 100000 operations completed A-OK!
-=== FSX Light Mode, Memory Mapping ===
 All 100000 operations completed A-OK!
-=== FSX Standard Mode, No Memory Mapping ===
 All 100000 operations completed A-OK!
-=== FSX Standard Mode, Memory Mapping ===
 All 100000 operations completed A-OK!
-=== FSX Standard Mode, No Memory Mapping ===
 All 100000 operations completed A-OK!
-=== FSX Standard Mode, Memory Mapping ===
 All 100000 operations completed A-OK!
-- 
2.45.2

