Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD8B7497
	for <fstests@vger.kernel.org>; Sun,  5 Nov 2023 08:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAHA2xCA"
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1B1CF
	for <fstests@vger.kernel.org>; Sun,  5 Nov 2023 01:20:18 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1cc37fb1310so24197075ad.1
        for <fstests@vger.kernel.org>; Sun, 05 Nov 2023 01:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699172418; x=1699777218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qLg2JkA4OlSNNXC4QfJ+XJ/7qUza7SPR+xHC5c18/P0=;
        b=QAHA2xCAMVEbkZJX5EqqgwXh5PFKMC47CLrsof0tGsXt0aYiFFfxZ9nZD5QJ7hkcLy
         GOfqnnJcamyFYtKwQCV3JJ52GMaatnf5L8ghluoiMbtU7Tryfio4ukVkaWJBf+sJLhkb
         6NNpTczUUoJfXGEma2+fk1A4mEd7DOFQfiFQeArbosHqnketMVJA1sgQj+rqaFfSrqbC
         n+PCEQFX6uZXlOx9p0BplL6TryElRIAxobRJTY06lM9t272OaKE36xUTNuhJt6q83YiB
         E0aoRJKW6h+P5X6i/locNtdFd6cBsrMEb3yXXq71sm9QXFcOK/oH51htzu1IoVrYs+9J
         pcxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699172418; x=1699777218;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qLg2JkA4OlSNNXC4QfJ+XJ/7qUza7SPR+xHC5c18/P0=;
        b=JnVJulwbbUp5T9mlMHYrzBvg3oOpp96nDsOqBqo5CRy8Tslu9+1LVp41vY9LqCKGyk
         x7bAMecFzcIaIil71G0Ip3pvVAitFxiuDZoqHiPTgmIv6CtXPPzws2IUZDw+apbKNuAK
         BpeFQvWF9r/bA/T55D8MW5RSAB5oZC8S+GvR6dLB40BQw3khXFEh2qzEx08eQiREHxq+
         o2DWuzbo1l6fAwK1SZTGENpLV10RACXGK5wm4aUOv5lH7QI5Th1/c7b72Yy6yEQKUT7e
         HEbd6vWLxwmclRuMldl6Ws4fLCTKwFLY317G7ti7x+bfP2E0wwFUsmDFPF5S5OVD4f12
         jgSw==
X-Gm-Message-State: AOJu0YytkqELi+wKRKYbuAkgwCkxXMp5jMZS4TAQ1hrCmWtcbI+HcGwJ
	JiSSytYQQCYMQUaNdb1e7gDhGqh8a6lwjg==
X-Google-Smtp-Source: AGHT+IEngxn8wtmhmHxle6AMb8Y9j6jdp7LqkBjaoOkbKtppW06rw30ZFkrMXigsOKIECg3nDaI5Hg==
X-Received: by 2002:a05:6a20:4421:b0:15b:2125:890f with SMTP id ce33-20020a056a20442100b0015b2125890fmr27286103pzb.37.1699172417889;
        Sun, 05 Nov 2023 01:20:17 -0700 (PDT)
Received: from apollo.hsd1.ca.comcast.net ([2601:646:9100:2cb0::46eb])
        by smtp.gmail.com with ESMTPSA id y7-20020a170902864700b001c5eb37e92csm3847366plt.305.2023.11.05.01.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 01:20:17 -0700 (PDT)
From: Khem Raj <raj.khem@gmail.com>
To: fstests@vger.kernel.org
Cc: Khem Raj <raj.khem@gmail.com>
Subject: [PATCH] ltp/fsx.h: Explicitly use int for return type for aio_rw()
Date: Sun,  5 Nov 2023 01:20:14 -0700
Message-ID: <20231105082014.1010683-1-raj.khem@gmail.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes build with clang-17+
error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 ltp/fsx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ltp/fsx.c b/ltp/fsx.c
index ee4b8fe4..c0aec23f 100644
--- a/ltp/fsx.c
+++ b/ltp/fsx.c
@@ -2581,7 +2581,7 @@ out_error:
 	return -1;
 }
 #else
-aio_rw(int rw, int fd, char *buf, unsigned len, unsigned offset)
+int aio_rw(int rw, int fd, char *buf, unsigned len, unsigned offset)
 {
 	fprintf(stderr, "io_rw: need AIO support!\n");
 	exit(111);
-- 
2.42.1

