Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC061AF0D0
	for <fstests@vger.kernel.org>; Thu, 17 Apr 2025 03:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744859536; cv=none; b=CglsEvoyyu5GWuTzteHMGyFaYtub2bgM/AWue9J5WDKRVhZvIRn72IiJohpqWa/5qqGf6H77i5Uk6GVS2UNmdqdlr/y51u++lqDSVXqqDnnQ6oGkJIjDipsb5diTEnlqHfcqYmjfyRh9ei6gmCj91/MRz8Z66N1CSlQNU73nh8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744859536; c=relaxed/simple;
	bh=EPN8rcQe6QdQqotRd35P3k3gdpXikrObrjnYTliYtRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kvqwsJM4QhLXDetHiS1muGPexrXmjU5jnj+qnkPD8FJboZJcf0AVN9cKB9As1EKOSlwXf85/501YlEx07wEV98hsWo2K+H7+wtibJBkBH7rguIl3MUENcqcfHO92flSrzQofMSwoVp7Xw4OuElN7LaFY7z5xcBP8ymOkB12rtSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=B8XwciH2; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="B8XwciH2"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-223fd89d036so3743105ad.1
        for <fstests@vger.kernel.org>; Wed, 16 Apr 2025 20:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1744859534; x=1745464334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z/qnQeATAihtq7BAno0Zx9KWsxou/huMZY/dfnC4bjE=;
        b=B8XwciH2vVjp1muylszzkSa2rEuZmejUvxUPtY9VHwNeVjZdVAbGbZwSCvQYGmbuam
         kHeqNYeMs+y6GGtwufQtYjm94ECaFtVUloZAIiguS5ZCsJqM+M2voWVypeI/0zxofged
         XhWbJYJQgxxLDIBZ99BG8v80VReRcMrOHHGMikgT+Hvy3aLroQrT4sSo1GT3KFsIhrEB
         W+m+TizHHb5T/IiXtwTOtpiQVHAZoMu8gitDhqwkEpeCc+1GYfSck0GEJn7+Hx/9Cz0y
         /Tl1lC1/mv9+8IB+064qUYFAkgRpyuocP5rcoAGrNsXj7haahYSYWgRkANuNq4Vzxm9s
         8lDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744859534; x=1745464334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z/qnQeATAihtq7BAno0Zx9KWsxou/huMZY/dfnC4bjE=;
        b=a34u50jKKbX/h3qnK0LhhRn/N4aLRWJ1mapXLZFuQBgx58exywTJNgcSkXZut+i0eq
         lY6Dcdy/610qtp3dXEjDpADvhv+AnfraWSVavp6OaYZP3l9hg3fG49mEOJQI1e2qcqvD
         KrVTTCnl4XWkAqgx5VV3Uy6y2VOQaUrRw/Y7d9ho4nDz7tqgR+NPsDO5JTKfo0AyROHz
         1v2ljUFAlImkkf01+OaXGy+0O7JlcWlUSy1ATz/JP4YDNaE2+V20IZgr+3HVzlTMy8cz
         2z8AErqpF0Sq+R7rPDk5wYK4X8lSArtswjvq1vWcOxkGaqkiBinZURjfSbBVewFnLF8q
         8uaQ==
X-Gm-Message-State: AOJu0YzWJCLzW6T1VrEdXUESeDeEfGTAoz1Hy4EglmOJyA0pLw3qIayL
	Thf3skZZgYH6JdwtOo1xlqMixtl4wcaKmlJwARrsU8ll26MYKdkX0qxEvcG8vP1pmNkNT2m4t8M
	L
X-Gm-Gg: ASbGncuJSLTRsTPJ8Z8Ggu7pfOxMOUOFq3LMCXs46ZcbhXc7A9I2/go11+fo9YXH8U8
	ldpdpWdkA5imOQZgFLeJ6jVUsCEABhjKnVzbdnZjOsBa/TNSJxHbVj0Jh/6Yhw2VpBXbst4DWBR
	FqV1FkSYyAbEOdu0s7Rt7sy7htOIteaFPtF1IepRMyc7Jk0k5jRRaqvj04pXtA/FUBAulaQYXcx
	TVSfYqEAl/7nK7JViapZlqGr7eAzawtz33rCFJI6BPQjf6kdNRG/a0i2ZgCFf1FLQBp5Ls9TjD+
	Xbsr+flCugRRQJtJXKW3iBmRSn8fmE/Iu8i1FrWcvhgQjA3+qUWtDbDOwYvg/yBFOVr3vxuICBp
	mXl/2T/TKNsKQ
X-Google-Smtp-Source: AGHT+IH6yYYureTCxKITM0wAlAgKjLGN+sI7Kzd5jJeYCh81NMPTCx+E1WvOTXRcqSYnA61XsQ2I9A==
X-Received: by 2002:a17:903:98f:b0:21f:6a36:7bf3 with SMTP id d9443c01a7336-22c358ddbc3mr82974765ad.12.1744859534498;
        Wed, 16 Apr 2025 20:12:14 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33fcad31sm22219075ad.186.2025.04.16.20.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 20:12:13 -0700 (PDT)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1u5Ffe-00000009Y9r-0cIG;
	Thu, 17 Apr 2025 13:12:10 +1000
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1u5Ffe-00000007mEU-1Rye;
	Thu, 17 Apr 2025 13:12:10 +1000
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Cc: zlang@kernel.org
Subject: [PATCH 08/28] check-parallel: add logwrite device support
Date: Thu, 17 Apr 2025 13:00:49 +1000
Message-ID: <20250417031208.1852171-9-david@fromorbit.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250417031208.1852171-1-david@fromorbit.com>
References: <20250417031208.1852171-1-david@fromorbit.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Chinner <dchinner@redhat.com>

Every logwrite test will use the same /dev/mapper/<dev>
name for the logwrites device, so we also need to convert
common/dmlogwrite to use per-test device names as we have done for
other dm devices.

Then add a per-test-runner LOGWRITES_DEV so that all tests using
dm-logwrites now get run by check-parallel.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 check-parallel     | 4 ++++
 common/dmlogwrites | 5 +++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/check-parallel b/check-parallel
index 0649a417f..5fee62f37 100755
--- a/check-parallel
+++ b/check-parallel
@@ -216,12 +216,14 @@ runner_go()
 	local me=$basedir/runner-$id
 	local _test=$me/test.img
 	local _scratch=$me/scratch.img
+	local _logwrites=$me/logwrites.img
 	local _results=$me/results-$2
 
 	mkdir -p $me
 
 	xfs_io -f -c 'truncate 2g' $_test
 	xfs_io -f -c 'truncate 8g' $_scratch
+	xfs_io -f -c 'truncate 1g' $_logwrites
 
 	mkfs.xfs -f $_test > /dev/null 2>&1
 
@@ -229,6 +231,7 @@ runner_go()
 	export TEST_DIR=$me/test
 	export SCRATCH_DEV=$(_create_loop_device $_scratch)
 	export SCRATCH_MNT=$me/scratch
+	export LOGWRITES_DEV=$(_create_loop_device $_logwrites)
 	export FSTYP=xfs
 	export RESULT_BASE=$_results
 
@@ -249,6 +252,7 @@ runner_go()
 	umount -R $SCRATCH_MNT 2> /dev/null
 	_destroy_loop_device $TEST_DEV
 	_destroy_loop_device $SCRATCH_DEV
+	_destroy_loop_device $LOGWRITES_DEV
 
 	grep -q Failures: $me/log
 	if [ $? -eq 0 ]; then
diff --git a/common/dmlogwrites b/common/dmlogwrites
index a27e1966a..7c3ad95c9 100644
--- a/common/dmlogwrites
+++ b/common/dmlogwrites
@@ -4,6 +4,9 @@
 #
 # common functions for setting up and tearing down a dm log-writes device
 
+LOGWRITES_NAME=logwrites-$seq
+LOGWRITES_DMDEV=/dev/mapper/$LOGWRITES_NAME
+
 _require_log_writes()
 {
 	[ -z "$LOGWRITES_DEV" -o ! -b "$LOGWRITES_DEV" ] && \
@@ -81,8 +84,6 @@ _log_writes_init()
 		BLK_DEV_SIZE=$((length / blksz))
 	fi
 
-	LOGWRITES_NAME=logwrites-test
-	LOGWRITES_DMDEV=/dev/mapper/$LOGWRITES_NAME
 	LOGWRITES_TABLE="0 $BLK_DEV_SIZE log-writes $blkdev $LOGWRITES_DEV"
 	_dmsetup_create $LOGWRITES_NAME --table "$LOGWRITES_TABLE" || \
 		_fail "failed to create log-writes device"
-- 
2.45.2

