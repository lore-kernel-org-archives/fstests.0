Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031F028684
	for <fstests@vger.kernel.org>; Mon, 23 Sep 2024 09:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727082377; cv=none; b=g38FWCX0fV75Pci50/rIKXb8Z8Al8zY6c+YBd3oHM/m2q7FmoLttNI0cqXQi/oxJ/tGSg7xRPNyuP8Af1pwnS5hrOBedPqiFIj2MCR/cVrGDmO+0w/u4LIZGI7LWn2C+njbKakZ1RrEwVwy10ofQHJbOP4pZytcwFRk7Q9apdZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727082377; c=relaxed/simple;
	bh=kAU45L1hZjrfUVWyL3OzJ1rA+4gQ1s8XkbORNjro1ls=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Al5yGFF1ZdprhmQQ3tAitOtVy2sBFucEBP4xnQ2Ef/akIzljf+4TLkd8VJ2OHhSb/VpFevlGYYIkY6Mp9yThvPRvTqZwzko3BDmfGA3db6sq72KM9IqUopGutbO1zFQpJeQugadKeM72DInKoAsir+JtTTF9qI2cdL+8YozIqno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMZDaTkg; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMZDaTkg"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-206bd1c6ccdso38291865ad.3
        for <fstests@vger.kernel.org>; Mon, 23 Sep 2024 02:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727082375; x=1727687175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=stiQuxNhweaqS9DOm7RQLXoA/ZNjEijsglCx3kOAUTg=;
        b=LMZDaTkg0aRi+zJ17bEhiSNHqoNlT4VVS0tGIbsKUR7FvMIKhRl4iNTSBG07McRIjB
         k+VLKdOhF3CcQ7XEXraHgHjjzrRLH3yBU6nkMRgPH+Hcxu47XvluExFRfGIZYYDI3DJd
         PfvmntsdOfWiJdvjQYvGyLfqp6UNkWuSH7JVcTQmb/gHE3Uz9nOL/3TrvF+LIgfNpUFU
         OkQRfGZtJiphC/dqjL1onnOkBZ+X9dRhckgGT9zy3JUkLrctgbcPuQLxKKZ04KTYRLmp
         ZunO7uu3FPPwAtv6NxP9UIiFz/po+1pjR38HHqs+tPfYQO1e5x2akFJqpCbR73N7s2oo
         Neyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727082375; x=1727687175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=stiQuxNhweaqS9DOm7RQLXoA/ZNjEijsglCx3kOAUTg=;
        b=hyLbmgEaTEvdRgJxmnWmodx0cP7adtw/6XJGfmJ8OW7NRpj3btqD/N1zcKbwCspU2I
         fblCTSx+HdhDrEO+OHNh5gZXnpXNdQNZID3XGt78EgEfoqw9huTRqYRt2wt7xWaIzKGX
         5KETh9xCbHtoyRCKMXxlhUhb6X410e3GpkvlnFKZEEOo57Vos1vZMd4/ONRkPIb51T3F
         8EGIBYv0Ta0i/HiHaAHU+hjn1ezZ7GSziLziU5U0wuDbjyQYa0p9jEWDc+tH96OXeM6X
         dnmqcjPoE6MDU3MIVHYr/+a/WAG+p3mJyPwPXHb/xNiL5/VhDyxkruEWFPNVfwt2quRY
         idZg==
X-Gm-Message-State: AOJu0Ywj3+2qbEM6EucH/0HzlYMEX9gt+U6zyFGinh4CJBqxN5Wo1fTm
	sS0xPgo+Zw2dgGkFNlWb0oYN5mvoj/QGvpY0RImlmN4g8KK8YUtdDkzr4Ir1
X-Google-Smtp-Source: AGHT+IHYNQbnJMkK5yBtFiZDr+xu/31cgvxmt1Ta3Yxv5M0b07iCTqhMCyS8MRXcwPU5CaFg2xSCPw==
X-Received: by 2002:a17:903:1249:b0:207:14a3:602c with SMTP id d9443c01a7336-208d8398134mr169998365ad.19.1727082374918;
        Mon, 23 Sep 2024 02:06:14 -0700 (PDT)
Received: from alpha.. ([142.171.39.121])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2079473d05dsm129520595ad.287.2024.09.23.02.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 02:06:14 -0700 (PDT)
From: Wu Bo <wubo.oduw@gmail.com>
To: fstests@vger.kernel.org
Cc: Zorro Lang <zlang@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Wu Bo <bo.wu@vivo.com>,
	Wu Bo <wubo.oduw@gmail.com>
Subject: [PATCH] check stx_dio_offset_align to determine if DIO is supported
Date: Mon, 23 Sep 2024 17:06:07 +0800
Message-Id: <20240923090607.953579-1-wubo.oduw@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the statx manual, if stx_dio_offset_align is 0, it
indicates that Direct I/O (DIO) is not supported on this file.

Signed-off-by: Wu Bo <wubo.oduw@gmail.com>
---
 src/min_dio_alignment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/min_dio_alignment.c b/src/min_dio_alignment.c
index 131f6023..c50ae8c3 100644
--- a/src/min_dio_alignment.c
+++ b/src/min_dio_alignment.c
@@ -28,7 +28,7 @@ static int min_dio_alignment(const char *mntpnt, const char *devname)
 	fd = open(mntpnt, O_TMPFILE | O_RDWR | O_EXCL, 0600);
 	if (fd >= 0 &&
 	    xfstests_statx(fd, "", AT_EMPTY_PATH, STATX_DIOALIGN, &stx) == 0 &&
-	    (stx.stx_mask & STATX_DIOALIGN))
+	    (stx.stx_mask & STATX_DIOALIGN) && stx.stx_dio_offset_align)
 		return stx.stx_dio_offset_align;
 
 	/*
-- 
2.34.1

