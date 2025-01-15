Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540FC22DFBA
	for <fstests@vger.kernel.org>; Wed, 15 Jan 2025 06:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736920987; cv=none; b=VxYQ1DHsQScyZUUvjMhK/wK31ZKQVVmkJvP94SFQscmNqJqBL1cnaboOvFQ3G0lIsvgzoNsuNX2LCWIsscKg/g23WvCCkd3sKsPeYFCvQx1RLKGdRItYVZi3IcZV9kZMKIWbHizLjh8ejlvC1mVruNeySW71WJGv1oeEQeQf6ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736920987; c=relaxed/simple;
	bh=H8p6u0E+Ozv4HyVMTmrHKteOF6IlF+1nwDowI5wjGqs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=btmoNvhnfoBntzfeCpndF8oe+J4AJTSo8O+8avPs+Q/DVwZrS8T9Hz0U5DxmHszHOLLAmqqUHEdWEmoIgaCe/v10mA1xt0sV6qmP3qBvHJj8FVoR3ZWJZod+fhZOrhOILcNAb2gMDcbqzI3rJYzKcpO01VE98hWCSYG7cqA3ZYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=GJqN/eND; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="GJqN/eND"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21680814d42so93887115ad.2
        for <fstests@vger.kernel.org>; Tue, 14 Jan 2025 22:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1736920985; x=1737525785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jZ518HjSKouwTknISSUOgzctwWvRO5yFxjmqsxs/VPU=;
        b=GJqN/eNDLu6NftoIORoD17L0LPJmBjYqgpw5kf97DEeKGcvjj5nE6Y1qTZeBm1YMzt
         Gvnz8TZ/kP8QRUqfiJGwav+S6DiCVS8OOpsE2hLiCAekrlFq3QicYbmFwHiZsjvm2el3
         RqwI2b0Gl4HDWGqmYBHm7+KfL9Z1We5l6Oj5bQEHfaJJruo6Jj10WtJyPjOBmF+YOKuf
         JVr9ORIo2soc6SiuWQ9vtea2CMfgj40kuLFdbXP2R3h3iyxPBtJAFssGS9XQfzxOXZzX
         i7MD1e6W4IhGurVXZgerdWuPbO+WrtU3bNG/taHoaXj400I9NAqDQrDlSM7L2FEn5P/y
         F+lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736920985; x=1737525785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jZ518HjSKouwTknISSUOgzctwWvRO5yFxjmqsxs/VPU=;
        b=hY5UuFKRwW/FngqUMRIDnOFq3y54h/qK0KvnlrYVMkh90ewFW4Qsc7XuAOqn3l7Ell
         KVuj03k9JMT2zO/xg2nqN/At2Ro/1X8xsysAMVGNxOy/zhw/bt05aGRsocscgW6eEhGF
         NVoGkGBFS7Gxcq5ZGGq/X6yeKt8WGojBLaoBFFCg9VQXnP3t2CMqL/nZAXzeM8qUeN54
         UYoPMh3nq92BTsoP9POY1dcA/1hOT8SJZ5bO0fjFBoNY5fZ3Pd4auJ6bpSfw8v1dAomI
         UZyRGjeEb8yaOnjQt7ZLNvZthCdEg9Hh04x2YWuvWVsULGIWpKscVrBnzZKGaPRRYmvA
         Mbyg==
X-Gm-Message-State: AOJu0YwQyDYrrXKHjXmNE4DLTssFruQ61iQqN3y+ZahUWVC4Ur/z4/qM
	8KezpFQdnxieDLzSgf91Uj/nltxpMxHtqauWporTjdxn8uooY/Z5n1UB1m1+jB9qyw36DQPdUJM
	y
X-Gm-Gg: ASbGncshrr9VGe+4fVAYMWv6yoOHKdXyL+g8MavRFSb+7S8zo6Cvwd7mMpkPsVxPX3v
	pz/nkz2L2YNxFCrOei9JiNPb09pCpHO+jg/q9W3lWHl05KjzOL2GMlOazykkxAHnIPeECmf8Zf5
	v2piQ5jChpdsaDm/qYJE8h4wy96j6OsmnHrtdisFTwHrycdfwi7XU4jU3Ax2v1YfU0R8AWBRZh4
	MyFz8T+sq8hNl9TqTkMbuH9EqfPWM6ZoMRTG9hSLNQEAqqUxxmhdDhv/vOpPJ/AedU3Bb8fazIC
	pJFraI/i2+4Fw+lInwPUjpjkfx8RrEc=
X-Google-Smtp-Source: AGHT+IGG0h0fLggOIMIXJpi/LTjLSzOBOPu1wxCu4xk0xZfj8MgKQl4S6WnxoC7Q6wMMZTm78CENWw==
X-Received: by 2002:a17:902:d485:b0:216:32c4:f7f5 with SMTP id d9443c01a7336-21a83f54d55mr405464985ad.19.1736920985613;
        Tue, 14 Jan 2025 22:03:05 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a319a125fe4sm7794144a12.46.2025.01.14.22.03.03
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 22:03:03 -0800 (PST)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1tXwUW-0000000641V-1Zf2
	for fstests@vger.kernel.org;
	Wed, 15 Jan 2025 17:03:00 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1tXwUW-0000000GabK-2QXl
	for fstests@vger.kernel.org;
	Wed, 15 Jan 2025 17:03:00 +1100
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Subject: [PATCH 1/5] check-parallel: adjust concurrency according to CPU count
Date: Wed, 15 Jan 2025 16:51:12 +1100
Message-ID: <20250115060258.3951185-2-david@fromorbit.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250115060258.3951185-1-david@fromorbit.com>
References: <20250115060258.3951185-1-david@fromorbit.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Chinner <dchinner@redhat.com>

COncurrency is currently hard coded at 64 worker threads. THis is
too many for small CPU count machines; the idea is to create a
sustained load of roughly one test per CPU as they are mostly single
threaded/single process tests. The number "64" was chosen because
I've been developing this functionality on a 64p VM.

Rather than hard coding the concurrency, probe the number of CPUs
available and create that many running contexts.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 check-parallel | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/check-parallel b/check-parallel
index c85437252..d34c73f66 100755
--- a/check-parallel
+++ b/check-parallel
@@ -13,7 +13,7 @@ export SRC_DIR="tests"
 basedir=$1
 shift
 check_args="$*"
-runners=64
+runners=$(getconf _NPROCESSORS_CONF)
 runner_list=()
 runtimes=()
 
-- 
2.45.2

