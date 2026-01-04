Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7735B2749DF
	for <fstests@vger.kernel.org>; Sun,  4 Jan 2026 10:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767522510; cv=none; b=P9BThJTjnU+juV9peMHpIhuKaEGgsKI7Zy2f9rXAl6DpVkVvsWolTw5UCDiA65ro8CEMtAYyXTv146oIrO7n7QmbrQZoouvcuETamcwnnxeMRRCAKTcClde7+RflHLFBFvA6cY55x1dw/qwgf2XVLBH2ecMh8tX+oBK28D7neG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767522510; c=relaxed/simple;
	bh=mPf64OuzXEc3KkRuMa9elOZgsUxIXGY07NDrBM4XyIg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GHThO+p2vsgETlcZQU2dXupUTn9BbiQwy+RfsblUw+QM5zZ9rw5C0pYg42tjg9a8Zi1174ZDfCjZfvpVKBHLbTQc2BuzNoqNrr0XNYqWmLvWxApBmheH4yjypeBRFvAo5f0rVY4ZBfE+wIFBVy+xjEVxdAq9ViG2jEKMlCmzTKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ncO3PWcn; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncO3PWcn"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42fb5810d39so8626869f8f.2
        for <fstests@vger.kernel.org>; Sun, 04 Jan 2026 02:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767522506; x=1768127306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ioZCmMCvfxYbOEz6+YktSjMUFBQeEXYc6gF1BxofAfY=;
        b=ncO3PWcnws30XZq4GPBHJA0Cyj1hH6kEjJ9QErmBhIjWOgyTOM9qcNdxHjjBNLh6hQ
         sfpEdOYZSN9Ud5i/prdzIJFkH8H9gsmbcL8D7ndA053EydFOlkHFbiACbkqfsCXSAOJE
         vMfV8OlaH6aZmBBaqwHTskhJkADoDbmg0LuHvyFEp9XnkDWCyLJBQlGnPvW7hIKAbEIS
         SmRAK7nnsQID5xOs+G8msG+dp15RTQUEKLcKIx3WU3kEGAQOSd5V4vyzqEuDna4FFqTK
         Hym5DbD1eZfPuIf5gogPp+UmyAXVdavcvozFbFpRHjtvY3LVkzfS8Utkx520pYKUDFQk
         YX5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767522506; x=1768127306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ioZCmMCvfxYbOEz6+YktSjMUFBQeEXYc6gF1BxofAfY=;
        b=M1gERmGeXxzWQYuzG6s965xqPte9WQKURlR5SRoE0xh3GgO864kovd0UpTK7D+QdlB
         50VMJ9Q1Hfgotf6EIWecs2yGgPbYrnRbzt9yAJAv78yBiflUqhvcsPIUbew1fWGpFY+L
         d0rp+hPBq54g4l58LHqp/dlCz2CxN2OdFRwyQeZBobhp2U3QtgedD1mazb9c3zNPXkDP
         xkPcKQOK0cnmrJqMKiQsEUL/z6P+Ua1kBlvZhImTLs6w4zXV/k4EHVgDKXK6578TzLhJ
         L/2Czv346ogmEovwJa+zYjZut3/c8Ck6E9uTqKtjizvfh5ZwDQKiMnEHx3NHF+aSYn7D
         Qkdg==
X-Gm-Message-State: AOJu0YyNTiTvIygPM9y/OMq4kvaosjpbzU3fyQbfR9OIJgGrm50/RxWd
	bTimuwudKAJOMt4pFIUeLl2WLiz7gRte+Tp80lOAoOv67cpTEtndBC0dKWG3lQ==
X-Gm-Gg: AY/fxX6nOwIRUXp24GE3o/17hfOeKL0+osP8GPuX9AssriGkdR0sTlptPY6+JSJf0M8
	EpiXSNIH1qWVlh1DXy9CpSZUTX0KtlQmox+QyYPWl0y3kHUnyE9opqOo02k+muVZjQwZBqdHl2Q
	rpg+VKQWoMeD5F6tPp9byFLqrKcL9Rakrp9u0jaoEjPLL2oiwG8zjmaJEI3Oe+610BjspbkW8vP
	y3X1ZH5/508bqoOti1SufYp/bUz3fopV5A/IFtzjVr2+G9VAC0oZ5NzaUHGWfmWDtfcrSVfAQRa
	1nKmTokv0eJpm1gW5KGTDCyuclELlCyUlk2jvUc7gBC/1vxZDCdFbY6MRr30Q43zfe0zxClB07K
	/ia06MX1H0owg0XAldtJFTx9w0oCwky/t9llCfCNDCcUv2Whm67lobozHMJ3nhA+S5/0OD3yRcL
	7gxldEGCgttPHM85fMnp3Gq6P2Wk3oVzLxe7+3XgGOW3+zTnuLlwXEb6unETjRk8kZzwXhNAw0C
	WsI
X-Google-Smtp-Source: AGHT+IEKlqqsGQn6+FD9RYm/T8f49WT3+xuMgJG+i3M5ZhjWM6jKbozobn2yNWI6pBx66irr3du+Rw==
X-Received: by 2002:a05:6000:2285:b0:430:fafd:f1d2 with SMTP id ffacd0b85a97d-4324e4c6848mr65679831f8f.11.1767522506509;
        Sun, 04 Jan 2026 02:28:26 -0800 (PST)
Received: from shaharhoch-lin.roam.corp.google.com ([46.121.134.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eab2c4fsm94578203f8f.42.2026.01.04.02.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 02:28:26 -0800 (PST)
From: Shahar Hochma <shaharhoch@gmail.com>
To: fstests@vger.kernel.org
Cc: Shahar Hochma <shaharhoch@gmail.com>
Subject: [PATCH] t_readdir_3: Allow EOF on ignore_error
Date: Sun,  4 Jan 2026 12:28:16 +0200
Message-ID: <20260104102816.1542861-1-shaharhoch@gmail.com>
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ignore_error is used when providing random input to setpos.
This can, by chance, produce a valid response from readdir,
but with EOF. In which case, we don't want the test to fail.

Signed-off-by: Shahar Hochma <shaharhoch@gmail.com>
---
 src/t_readdir_3.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/t_readdir_3.c b/src/t_readdir_3.c
index 8f9bb326..5d7afddc 100644
--- a/src/t_readdir_3.c
+++ b/src/t_readdir_3.c
@@ -52,12 +52,12 @@ static void libc_getentry(struct dirent *entry)
 	errno = 0;
 	ret = readdir(dir);
 	if (!ret) {
+		if (ignore_error)
+			return;
 		if (errno == 0) {
 			fprintf(stderr, "Unexpected EOF while reading dir.\n");
 			exit(1);
 		}
-		if (ignore_error)
-			return;
 		perror("readdir");
 		exit(1);
 	}
@@ -92,6 +92,8 @@ static void kernel_getentry(struct dirent *entry)
 		exit(1);
 	}
 	if (ret == 0) {
+		if (ignore_error)
+			return;
 		fprintf(stderr, "Unexpected EOF while reading dir.\n");
 		exit(1);
 	}
-- 
2.52.0.351.gbe84eed79e-goog

