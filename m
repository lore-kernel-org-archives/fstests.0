Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839D91C8603
	for <fstests@vger.kernel.org>; Thu, 19 Mar 2026 03:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773891406; cv=none; b=rBz4mUHTdL1YUZ5cTuTHCCor9r2Kf3tZ/1vwBlDX+cEzIHySLAMesRSt2Nt9JiJelVzt+jrIO38bCwO6ErkfA9YhCcIqrk1nwcBBYZIPbpZkpWNtyJGfyOBXYQFw4dFTm3Lks+pyENV1fzVhRXhHoEhOvADc88dQnYYTglvjXuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773891406; c=relaxed/simple;
	bh=9ExAsUNOQjxOng6kvbFdlHRuCbzmvZR+sa8UNwmARvM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RkIrWcT6QLfqzL6LUqMIhJNbVVTlF3SsWcUOltXxeuN5KzFqrwj0pq8vOuT4AAfOii+p1ZRreECMaTrq8rd3FnVxUewV3Y8eXONtmP0/RLIxeyN8h38qxDZb1SjMXzsS8MRfCkQ1BgOuL0nPQ4P/NF96E3nwYAK+25V0P9R/gLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HtjzZTk0; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtjzZTk0"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-35691a231a7so348779a91.3
        for <fstests@vger.kernel.org>; Wed, 18 Mar 2026 20:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773891405; x=1774496205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9aZC5KSiPpLsgrBubTTYXLhtxpbWFaK0/SDKknuNMh0=;
        b=HtjzZTk0EeFOtsnwGf9o8ultbjvGgp5izRiXYABCpKBdMrMi5MJAMCjpfFpcMsFLqm
         5PrCz1Ks0wiZ6Op2lVHV2W7LZKDTQvfGuen4W3QRUwBWxrCrLJSjP078QwfXTmhbdDrC
         7/30EKECZwdFHmQ02gQKwhitrzJSW3UAHcc6gam3BB2I/FknLYxCQ0PYZO12BB1jKw4P
         k4934AVygpb3mNM0Yjnq5CJ0o0VlbRM0JiNoeFkoZBQXIHRhdH02657gAbR9wT7AawRC
         H4tnkH/aazP602LBC9Em+gM6oIWPEwQ/pU4X3Weinr9eXxqT4JVXYbIu4WaKF7hFdIoT
         qS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773891405; x=1774496205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9aZC5KSiPpLsgrBubTTYXLhtxpbWFaK0/SDKknuNMh0=;
        b=Lc0zirwcj+pKJCi4In0RNbEjFKIAP2PZDpq6/NtzNIsFuzFf8r2HHLkji8xZYfLMeY
         If+fCkINpTscSm2CsTs8VYGBF/NEmdq2mRnbYb4mxWt5ab+5Z5nogMaNiFy3gY9dm9uS
         GbTmee7fdPvzHODKGqM18t872stn11MJkGEo04VeOksWBDt9OXJ8duN4cWretW9NTe8z
         CIhJBc0JRkdYviPg7vIIkjcG74MzaisNUzi1zpTxtA8MIDQTACe1FLtbRt0DLqrT4u+n
         sKOFt41Z+gZWPzI7TUKVuKkyrYVNqcdCeRgRmX10jpk10cvrxwijETmWBH36VPWkutKM
         4ELw==
X-Gm-Message-State: AOJu0YzZLshCnhqD0Ti5dV7ih7VLY+xZEtMbdPW3shDC4cEfkLcDnUsE
	QmvlmIGn2k4TQO8Lk+2ZlsryKEVVtLyyfgoBjflIyVINsA8WjL19IRC1
X-Gm-Gg: ATEYQzyhCBZiOXW6wyQPA7JugKIdy3vAlZQ7i8cIJDAPCMdipRA295HDgCjwCVMCrrj
	YtMQN42tKh2kt5T097es/v/IdLdBaVB+XtpBuuSB5G/PwQcNn9JY8Da976vEHlkSYEkIJ3jVi5f
	t0gMBCS1TwOB75KcL1SNFjZ5qkFKKny4GFJdYP8deV2m90AvjsjG7T6mkbx/2/N1N9GaDK43dpd
	7sa8P7zB4E4rqzzipIToS7S0FcaPavq09TQc0kpqb9vYG2JYuL6an41JW7+UtDNW4MRM4+Q7Yqh
	A03n31Cc7siJLxqsd9bOLWFhBPlnwLFk5JLY/yK8dClaTwv4U7SQZ4hCLQ/PGjC5S7zfebMNGTp
	Y2/CPRUW0ZYQwOzUtQz3fc8OrK20t7df+exrXbZzYtzPfmNq7Y86K71ugNh5DCMI4RtpZOi+fGZ
	jirCmWdbAzfxAOMfuxZ+v3qtJWq5r5IOs=
X-Received: by 2002:a17:90b:3d05:b0:35b:a7be:ae62 with SMTP id 98e67ed59e1d1-35bb9f865admr4052049a91.30.1773891404831;
        Wed, 18 Mar 2026 20:36:44 -0700 (PDT)
Received: from zyy.mioffice.cn ([2408:8607:1b00:8:de2a:6d3a:185:22cf])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bbabae770sm1994294a91.1.2026.03.18.20.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 20:36:44 -0700 (PDT)
From: Yangyang Zang <zangyangyang66@gmail.com>
X-Google-Original-From: Yangyang Zang <zangyangyang1@xiaomi.com>
To: zlang@kernel.org
Cc: fstests@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Yangyang Zang <zangyangyang1@xiaomi.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 1/2] common/config: export F2FS_RESIZE_PROG
Date: Thu, 19 Mar 2026 11:35:18 +0800
Message-ID: <20260319033519.3954784-1-zangyangyang1@xiaomi.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

export F2FS_RESIZE_PROG w/ resize.f2fs, it can be used for resize f2fs.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <chao@kernel.org>
Signed-off-by: Yangyang Zang <zangyangyang1@xiaomi.com>
---
 common/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/common/config b/common/config
index 1420e35ddfee..d95b3226e85f 100644
--- a/common/config
+++ b/common/config
@@ -309,6 +309,7 @@ export DUMP_F2FS_PROG=$(type -P dump.f2fs)
 export F2FS_IO_PROG=$(type -P f2fs_io)
 export F2FS_INJECT_PROG=$(type -P inject.f2fs)
 export F2FS_FSCK_PROG=$(type -P fsck.f2fs)
+export F2FS_RESIZE_PROG=$(type -P resize.f2fs)
 export BTRFS_UTIL_PROG=$(type -P btrfs)
 export BTRFS_SHOW_SUPER_PROG=$(type -P btrfs-show-super)
 export BTRFS_CONVERT_PROG=$(type -P btrfs-convert)
-- 
2.43.2

