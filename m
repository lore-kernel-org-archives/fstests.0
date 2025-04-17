Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8695B1C5D67
	for <fstests@vger.kernel.org>; Thu, 17 Apr 2025 03:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744860581; cv=none; b=DLHC357gYTumlQVbogtJtj+0zMWbQFBgpQszCBjB16d6ZIyzwFiEnzlgUO7bsnCXRYomZz63k69BY917aMmmRQ0knUaD9xKexR8rP2IUFjgSO0/3BVdFH/NH8CJnFG4xOpmRyNH9weo/5Fbk477yOtXGbpIx3D0m5Av/bztm5lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744860581; c=relaxed/simple;
	bh=0SFQlicHNTvEhkMunJcFiHL1jNfTcLn5vHIrJU0cK64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=htHUdtcOzTq6br4YpRZ06ZxJ0wIXMvH6CDV4eODblRQ2PvD1HFMZ1d9kMGn6PXEBHu457rm6TVikMaTleJIj07/sLfTJRHrkkWrYC89H/pEFAK+GZ2//cvti4hrkrxvDouxDChVRtcMjp08wrlrxccDg3Z+R4L5OGGutwOWwQKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=NiL71h3x; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="NiL71h3x"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3031354f134so195124a91.3
        for <fstests@vger.kernel.org>; Wed, 16 Apr 2025 20:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1744860580; x=1745465380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AKvdDogWrWnYR5FYlTvHRRqJnC6+OHDiYvjCuh7YALw=;
        b=NiL71h3xOYJt1maIAYeCYdbK88JWfepSXBcqI5bjIqbqPCEnNk3DWykxPZQz82Zvo8
         xbyjRfmxQG8+olFuLTBnoHp2KZ20yYHeiKQwgoZeG/VKhb7g9OJd/GLUdMS/k2H/wzG5
         llCT8YSO1Q2qziyzlS/0hbHZXR1wZ0AESOEpuzmXVucFaFCEi2S0twvSEPq2eBq3RJUD
         dcP6rnqRWP4OegCx8wvge1pj+r+OPyyt79WsqtPQHEWWjSviKsEegCmLrA/1Qg2/TrPm
         TEVAbMdNwgjgTlmgqtUPBxt2gco4oev4i9YMjlTjjvrs3wMEM1f7FB1MpM9rxSyXF+I+
         o88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744860580; x=1745465380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AKvdDogWrWnYR5FYlTvHRRqJnC6+OHDiYvjCuh7YALw=;
        b=Ybvu95rwNI2kUCypBxTR9TKgBqmIsbjOePzQihLgCgoJIl7CF8JC6l26HimLrtEJFb
         3lAs7CZpXcCgEhEsiUYMXb1eePEbwwxLUKrR85dSVH9kJYhK3JDEvsZrjf00PkCj7Wcx
         HBSoOiNUY0WMyIbl1Z+3qZi2uNPoWzTke3/V2F29h2e3xVKm06R6G0QT0U9yZQZ3fa8f
         IaXXvHY6rksXp3Z72EVzVCX1vzFS//7vCEY0kzh2bCD0w1JibAMoQLTwm1hKKTTfSfsi
         tzQ4lGP1slTwvkzHO+yKApt0X4owU23U6GNhXnBm6fr/ejZcQhg3EpzNpPQ9sRjh3zoy
         4HOg==
X-Gm-Message-State: AOJu0YxeaA8nIhEDrovoEpu/n6Y7+hR/FQHlCM1iWAJLjfjc/rtvhxX9
	tUqSgtjGLjj+5DZAG9OPwtTAWnxmL/1Vma51lpLm5OCRnN4Zy0KzH/Z1rRBRtGKJPImnW/HdGqE
	T
X-Gm-Gg: ASbGncsKOxe367PZGYH7lJuFZN4uum78zVVmaNJ7Vge9WthOUzcs4o9I+XibJEL1wLo
	E85PiSzOyiBMb3tx9cVMJscUR9AyFtOAVeatxHxSyX+dU6/Iea8zDJsPNc3pZuzkY4e6Y2ALIGj
	MOzzxLi6L/gBXkkewgNoRPQ4fYYSyW/dT+V8m7jj5z01y5s6I82X3teICWnrw2CseZFnqgHB9T0
	2edbTJWd0brzGr1zyUtaOFEkgYKPnnKgO7A7sePpkSpXFVnVfEEMHbUU5vNnz2RftFucNoXHirK
	SWUuCKVjYMk2z2Ft/gCljpx8dWhcMlKetZl4Ijg9fchaNod1z7xXY0Nn0UwxczFODldjt+lWgnx
	rsdSg5MmqewBG
X-Google-Smtp-Source: AGHT+IGhIb1yJeemQQDVOnfPdATaqTMDMmSImaBpdfPyUuCDqVV5N0OTUPW0lYcbHW6R4XLVktnnmA==
X-Received: by 2002:a17:90b:2e10:b0:2fa:228d:5b03 with SMTP id 98e67ed59e1d1-30863f2f626mr5983834a91.19.1744860579755;
        Wed, 16 Apr 2025 20:29:39 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3086121a164sm2490386a91.28.2025.04.16.20.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 20:29:39 -0700 (PDT)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1u5Ffe-00000009YAj-2bG0;
	Thu, 17 Apr 2025 13:12:10 +1000
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1u5Ffe-00000007mFd-3SMb;
	Thu, 17 Apr 2025 13:12:10 +1000
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Cc: zlang@kernel.org
Subject: [PATCH 22/28] fsync-tester.c: use syncfs() rather than sync()
Date: Thu, 17 Apr 2025 13:01:03 +1000
Message-ID: <20250417031208.1852171-23-david@fromorbit.com>
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

generic/311 runs each fsync-tester unit test 4 times, and there are
20 separate tests. At least 9 of those unit tests run sync() to
flush dirty data periodically.

When running check-parallel, sync() can take a -long- time to
run as there can be dozens of filesystems that need to be synced,
not to mention sync getting hung up behind all the mount and
unmounts that are also being run. This results in:

Ten slowest tests - runtime in seconds:
generic/311 419

This test running for a really long time.

Convert the sync() calls to syncfs() so that they only try to sync
the filesystem under test and not the entire system. This avoids
interactions and delays with other tests and mount/unmount
operations, hence allowing both the test and the overall
check-parallel operation to run faster:

generic/311        166s

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 src/fsync-tester.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/fsync-tester.c b/src/fsync-tester.c
index 417187491..048cb4853 100644
--- a/src/fsync-tester.c
+++ b/src/fsync-tester.c
@@ -131,7 +131,7 @@ static int test_three(int *max_blocks, int prealloc, int rand_fsync,
 		/* Force a transaction commit in between just for fun */
 		if (blocks == sync_block && (do_sync || drop_caches)) {
 			if (do_sync)
-				sync();
+				syncfs(test_fd);
 			else
 				sync_file_range(test_fd, 0, 0,
 						SYNC_FILE_RANGE_WRITE|
-- 
2.45.2

