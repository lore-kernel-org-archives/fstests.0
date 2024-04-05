Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC819174ECA
	for <fstests@vger.kernel.org>; Fri,  5 Apr 2024 19:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712346990; cv=none; b=nypcXHy9lEfFxK8c2DVNRJTYeLXRVa8qsIiH1RZdf18gwvC/MAmmOpm9AxVjyDCAWG2TsrsvLuVgp2EyjVhCuUlE6rVK0MQGir17wkene0b4rzGkGSyGtUlr494mJO7/bdOFWx9DM+sQTxUAm5UrNHuRhl+h/CleHLy/Clw54DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712346990; c=relaxed/simple;
	bh=aPbMiZOwI+NGFueUpLxHWqQ6gUxj9pl36zsDIuOZjOE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GA8AKfA4tnRC/MUN2rJkpuC+0lNS+P9ttMfNLyQ9KZI8S1kukekaDIC4GbT+GWEOnOHlh1ZBWG6SF4J9fD2Z/w93X3lnJj4wVmx8IRWI5j071s4SvjEpYg0m2Ndv/xF+50AKne3WRUiIJ3RFMfWSpwTuW7XOVr4CC06Bzq8Wbos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=MNpfhgeT; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="MNpfhgeT"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6994313546aso3914606d6.2
        for <fstests@vger.kernel.org>; Fri, 05 Apr 2024 12:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1712346988; x=1712951788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zBF7VbLO1AdTYvcpdTi26pAOfpXqNacAoJuOltaVhbM=;
        b=MNpfhgeTB1/g+rul08kjEX6s+f4dUhl2Q46Qzjq2U7fxbTnwMZcWTj2PkE1T4DbuRW
         HezO5Koa17ewyu56fmVqRGjNcJMk2AOwFSzMikKrEk/KLrFAul6Kj0WTpj6sD03QtngO
         7cIae5uYtNdWOc6aTq+bc4Bhtr5IhMnifAlciY5Dx0ys0M7RxOAFylO4cojxH0w4P3+M
         bnPaDvVf+/7v34MI5YyUOQ0UEyjz+VV77fAPHgZFJGCwjaCDwwHgvXAxxAHZdftpTqK/
         RyC02ZupWrHyCAc97e4KJbq2pQ4JOq66YVf68z3aNv48xI+qIF1Av7X5i3pTVl9Jr03Z
         /wAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712346988; x=1712951788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zBF7VbLO1AdTYvcpdTi26pAOfpXqNacAoJuOltaVhbM=;
        b=kepytTStC+gTDPoc+0xyIViE25UAxzd+eK7RsnHt3WRExr145vvJkZYH69X6aNBaBa
         Wmo6C8sTMlPQWwfeUL3dMwYRhObdCjsJ3wrs4jBIKolme6TM9NtpALxLOce5bMaxyOdv
         GNEtIRuLlemNCe0sKCLEjPnyfdazxH+RPjn1y0UKZasrkQMWal3/K1b3aB7P9ZV3y7oM
         zYDbMDPOvKQfeB5BDxWDaLGcvhJRssDh/6i3e68wfUiyaD01DGlzViywjiRkNS+XeU5+
         UA9U1gXTnozYlssHQNhI5KjvEoQbCEK2r+tCse7MNwBbVBxkxZznclCSmTOiQaj4e0ov
         A2rA==
X-Gm-Message-State: AOJu0YzY003eAtpi8lRfHVm1HAI4ALyr8q9toXORw/NLd+EADokYRwPy
	e9QYNKOIJWgI0lixRCN/MmW6oQ3MD6Yn3sXBc/fNIAG4m4Xm3nol35odA7K18NTmTPwIAqHv95e
	X
X-Google-Smtp-Source: AGHT+IFxrZf584DI1C/A2wc+WeyJwP9UAfKJp/q2R1/IghLX6g5qayzXZseqwvI/TbiooPIjePreRw==
X-Received: by 2002:a05:6214:c6b:b0:699:322a:e54f with SMTP id t11-20020a0562140c6b00b00699322ae54fmr1819839qvj.59.1712346987229;
        Fri, 05 Apr 2024 12:56:27 -0700 (PDT)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id mx9-20020a0562142e0900b00699b99cc0ffsm24774qvb.25.2024.04.05.12.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 12:56:26 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 3/3] fstests: update tests to skip unsupported raid profile types
Date: Fri,  5 Apr 2024 15:56:14 -0400
Message-ID: <7111bf50942e0b72a43ceed010d8bab00c712a75.1712346845.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1712346845.git.josef@toxicpanda.com>
References: <cover.1712346845.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tests btrfs/197, btrfs/198, and btrfs/297 test multiple raid types in
their workout() function.  We may not support some of the raid types, so
add a check in the workout() function to skip any incompatible raid
profiles.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/btrfs/197 | 10 ++++++++--
 tests/btrfs/198 | 10 ++++++++--
 tests/btrfs/297 | 10 ++++++++++
 3 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/tests/btrfs/197 b/tests/btrfs/197
index 2ce41b32..9ec4e9f0 100755
--- a/tests/btrfs/197
+++ b/tests/btrfs/197
@@ -30,14 +30,20 @@ _supported_fs btrfs
 _require_test
 _require_scratch
 _require_scratch_dev_pool 5
-# Zoned btrfs only supports SINGLE profile
-_require_non_zoned_device ${SCRATCH_DEV}
+# We require at least one raid setup, raid1 is the easiest, use this to gate on
+# wether or not we run this test
+_require_btrfs_raid_type raid1
 
 workout()
 {
 	raid=$1
 	device_nr=$2
 
+	if ! _check_btrfs_raid_type $raid; then
+		echo "$raid isn't supported, skipping" >> $seqres.full
+		return
+	fi
+
 	echo $raid >> $seqres.full
 	_scratch_dev_pool_get $device_nr
 	_spare_dev_get
diff --git a/tests/btrfs/198 b/tests/btrfs/198
index a326a8ca..c5a8f392 100755
--- a/tests/btrfs/198
+++ b/tests/btrfs/198
@@ -18,8 +18,9 @@ _supported_fs btrfs
 _require_command "$WIPEFS_PROG" wipefs
 _require_scratch
 _require_scratch_dev_pool 4
-# Zoned btrfs only supports SINGLE profile
-_require_non_zoned_device ${SCRATCH_DEV}
+# We require at least one raid setup, raid1 is the easiest, use this to gate on
+# wether or not we run this test
+_require_btrfs_raid_type raid1
 _fixed_by_kernel_commit 96c2e067ed3e3e \
 	"btrfs: skip devices without magic signature when mounting"
 
@@ -28,6 +29,11 @@ workout()
 	raid=$1
 	device_nr=$2
 
+	if ! _check_btrfs_raid_type $raid; then
+		echo "$raid isn't supported, skipping" >> $seqres.full
+		return
+	fi
+
 	echo $raid >> $seqres.full
 	_scratch_dev_pool_get $device_nr
 
diff --git a/tests/btrfs/297 b/tests/btrfs/297
index a0023861..7afe854d 100755
--- a/tests/btrfs/297
+++ b/tests/btrfs/297
@@ -18,11 +18,21 @@ _require_scratch_dev_pool 3
 _fixed_by_kernel_commit 486c737f7fdc \
 	"btrfs: raid56: always verify the P/Q contents for scrub"
 
+# If neither raid5 or raid6 are supported do _notrun
+if ! _check_btrfs_raid_type raid5 && ! _check_btrfs_raid_type raid6; then
+	_notrun "requires either raid5 or raid6 support"
+fi
+
 workload()
 {
 	local profile=$1
 	local nr_devs=$2
 
+	if ! _check_btrfs_raid_type $profile; then
+		echo "$profile isn't supported, skipping" >> $seqres.full
+		return
+	fi
+
 	echo "=== Testing $nr_devs devices $profile ===" >> $seqres.full
 	_scratch_dev_pool_get $nr_devs
 
-- 
2.43.0

