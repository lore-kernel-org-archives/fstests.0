Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67C1EAE7
	for <fstests@vger.kernel.org>; Thu, 17 Apr 2025 03:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744859536; cv=none; b=J0WYnf2+UR/5oGrp7YPOOOBarmjjjpOTcQyuw8mz2Yod1bfxAtCAiCVbzqupL0nXEE8PDCWXydcITeauOf+NbQxGgKgHFs3DBvBVJHIlloMcm3QksWgsNCqbSkuzFSI9cvPrl2TvN103KFdtJO/BFMadtN2kOneUFRHVSPlCQ6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744859536; c=relaxed/simple;
	bh=z4nEoMXt4RtmRYOAnKqZq2ny/Y2j58Ci9lLaG54QgOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y8ysCMzukkthYzBAGHD4tgU34jlzA/QAqqjI4AWd+7y9M1gX6ZdwBfQ8djpaU9a3vjGSSyyMb1Rrqa+7FwRgtYa8/CLqrlw8MmWAqqGnZR6IqVMoFtBRz0Oe0U7ixOWgl6UOxJCsWFIGaFYW9R7iE4ioMPJvVL7TtcsSo6Q38Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=2maoMXpD; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="2maoMXpD"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-736c062b1f5so217211b3a.0
        for <fstests@vger.kernel.org>; Wed, 16 Apr 2025 20:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1744859534; x=1745464334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYc8jSHhiJjjA2jV4a98jESgDC20bwS2vHiSSh2Hazc=;
        b=2maoMXpDFOLWMw055AkLPcME5cNHABJJTjHxIhZelQsAHY210mo8hcKpVcr/TyI70w
         TdvxjdA5f0sXXLT6mY1GNHLHNZVCGmYRDp3hvgz+pza+tZQEasbfjA+/s9LIuVN5c3ep
         2LUfUPiy8Rplc3cErec93tevLiKRWdPWHmH2WYfpGgEvrN7xDJBt0HkoXcPgcFM51t5o
         lmaUVa5vVh/fNLC55fb82FDar5hSpvKgmbmhedn3TKiyWV0p2yO3d+xmGHe3PldRLdhs
         FJmaKlDJJBqcLKXfKj4kbUiYCE8tmnb5MBBJJuf3Y9gygz8aYIa/ylS7SU9genG/sYCN
         gOvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744859534; x=1745464334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QYc8jSHhiJjjA2jV4a98jESgDC20bwS2vHiSSh2Hazc=;
        b=YMMfIcLWyGwc6k5QahHgJendkBNa+l9GICmgxV5SozjiFyfyjKxwrI/06C1M7fV5R6
         ESPNwb3OySOy2UzDSXmVZ4IDfP0MBugIa9X0s+GmFDKb/bOtgz4UvcpuMQoQYSk1PzXB
         qrg320iUgommpvHZNv0IG3e9AbApjFTyIplMU4+s44AcLEwVxrprkEY1Fy/dtA43quih
         u8ONo6BJRKEKC8g4xAzk7tRrydA5XuXpPTDBXvJxCAy1+KL/IQQTuiRgEo6S8yVRVo1l
         22FMnSibCzsPvTp0X9Q0BBV2hk25LkFOkFj3t4GvVg7JjSr0xEkSllWR4IFp720KYWLK
         Pi8Q==
X-Gm-Message-State: AOJu0YyKBzQ6WHLohdoqlsTLrYl0wqEARATFBYePcTChqIDqFt/QfV8Z
	9NP+GF0DsAXEifSc7bel2KHkqmpCFnNKK8wGpfwAxu774JA9dALzJPecKt/vwENQaNkUsf+uSaC
	o
X-Gm-Gg: ASbGncuCWpsL52DZZRSphKJD8Vgou2tSMR/t0NTySUwyK172Xy18byrCdGAHWlQ8F2r
	ThJP57QYIfKsRZSbSDNPyqF/BLOcAOcMq7Btu90wGoXaM74WpwnVDv1lQH5YmLhf/QGvS4n+0Zp
	IXU92qwAc8SG1N5wF2Gslid8V2i3fZbPbvWPA1hafITAkCPtzf+44sdVkwf13cPkwS1qbjBkKPX
	GFBEPj+4MPrvhrjOAT2m6we89P41x+PZwOHXLSYG5aAS+8QSqEMUbJJw0figLYmZUxhKYJPkita
	MpYFQyGck8tZzqjhW9296Yh2nlJt1UXcenpk6JjD3P7xiag4gtcbUmGAGNmu8hSty9jM6KLky4L
	VgySt3AltCnxy
X-Google-Smtp-Source: AGHT+IFbTfjocc1QZWzA5w/yAYgbY7O2SWzKu6YHJ9TSt6lSObdP7e0m9wYgnQvuuTmWznA1nqAGBw==
X-Received: by 2002:a05:6a00:3001:b0:732:5611:cbb5 with SMTP id d2e1a72fcca58-73c2671557bmr5409906b3a.11.1744859534115;
        Wed, 16 Apr 2025 20:12:14 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd22fa730sm11544341b3a.94.2025.04.16.20.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 20:12:13 -0700 (PDT)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1u5Ffe-00000009Y9X-05Za;
	Thu, 17 Apr 2025 13:12:10 +1000
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1u5Ffe-00000007mE9-0sYb;
	Thu, 17 Apr 2025 13:12:10 +1000
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Cc: zlang@kernel.org
Subject: [PATCH 04/28] check-parallel: report how many tests were _notrun
Date: Thu, 17 Apr 2025 13:00:45 +1000
Message-ID: <20250417031208.1852171-5-david@fromorbit.com>
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

We already count tests "run" and tests that failed, but there is no
indication of how many tests were _notrun. With tests actually
failing to run because of things like bugs in _scratch_mkfs_sized
being reported as "_notrun" instead of failing, visibility of
changing numbers of _notrun tests is needed.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 check-parallel | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/check-parallel b/check-parallel
index c85437252..d68d76e55 100755
--- a/check-parallel
+++ b/check-parallel
@@ -188,7 +188,10 @@ done;
 wait
 
 echo -n "Tests run: "
-grep Ran /mnt/xfs/*/log | sed -e 's,^.*:,,' -e 's, ,\n,g' | sort | uniq | wc -l
+grep Ran $basedir/*/log | sed -e 's,^.*:,,' -e 's, ,\n,g' | sort | uniq | wc -l
+
+echo -n "Tests _notrun: "
+grep "^Not run" $basedir/*/log | uniq | sed -e 's,^.*:,,' -e 's, ,\n,g' -e 's,^\n,,' | wc -l
 
 echo -n "Failure count: "
 grep Failures: $basedir/*/log | uniq | sed -e "s/^.*Failures://" -e "s,\([0-9]\) \([gx]\),\1\n \2,g" |wc -l
-- 
2.45.2

