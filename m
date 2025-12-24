Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03286314B82
	for <fstests@vger.kernel.org>; Wed, 24 Dec 2025 00:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766536296; cv=none; b=EZLHUTbNUMQR7pZh7HAFLlC2d1iAXxis/uFR+CJq7zdEJ+uPstVDgyfOmWt7dUzBmQz5AnRQs/5GjBNbzqiVp2wIKvfT1gHgjRX/VCtV8XDx7qKkkjo5GkafgVCuD7QWfptokYetH0dCTVeHLP1PN+mk1wnehdyug00qEvCo8HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766536296; c=relaxed/simple;
	bh=q5gMSiXxK+19YQ5unrApHjloewkL6CM34gTEsVFcHd8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JKDSXJztr2zXDZyFKILwIjn4FfaqVhEAfS+9WUsRCooSYIKH1yfhmPEkC3wfysTohcgUtUkD1WnbJhHEV0KxyuhzCjba/7LofQcnBnI5Eh9+Qo2IO92iX6FLvDCTv/buSSyc76hr1A8tFKaOTCpKtN9CUwob90b7ssSm4wXX670=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=2BQi91xP; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="2BQi91xP"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-6420c08f886so7154286d50.3
        for <fstests@vger.kernel.org>; Tue, 23 Dec 2025 16:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1766536293; x=1767141093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L5rDvPECvFaCsu10CL1S5YzrNkaWKW7eAydUhkB1MXQ=;
        b=2BQi91xPTyJSjdEJZgRXKTyiIg5puizTdWi8m8SwqA7zYhzA5Y3MxnHPSIvUcVDTMV
         O/QNUomNwj12IEUkYP/oFFuKPXY73/fiB2T+bDzSPqXZPggQl0oK/vwE3qB44HSiNanP
         asjnvNaw5kM30c9Bh6szwlvXR+79zLY5R3oLMS0DK2z9Qv+aOGzm+ZNZ1yT31mwINk67
         v7QFHNvy9cJWgNuAUUNtsD3ES8S2UAQoB3dfXFHeGZubMZu2d82//slZTajQ5LGfSP6J
         5FLwZWJ8uYGaUjQcNrs+O8FDii6kJe7G5Rx7a8BmFcnPXQ5jTI1Z2ps3QpM2H8USUKaC
         c9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766536293; x=1767141093;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5rDvPECvFaCsu10CL1S5YzrNkaWKW7eAydUhkB1MXQ=;
        b=I1syyBCJkloj79JNzYNJLYZkh6Sj1FntADJ/U/JmEpY6H7+viR8ouNCsWK6K+CLylr
         WiWg1Q9rMvamq2Ws1yw3YnGJj6GC0qFOsHcrAZx0dZ1J3OuWxzuNzB5DwhA8tFmgPv6K
         YrZDOCD7hH1xSa8KAWBOBUOtuIKLnw7bx4Ive4Mq/1eY1kz+Lm8vgxBmVLYhFxwiZeHV
         HyaXWIhgKQ4hvN+q9Z7g0wBtxIsoEwbGpi31igv8NW4gbxyvfmbi3U5BNVmjJXKNNXwO
         GWLVpSadmvJrLQmRx75VS0+hBU+kUcJvxAPW1ai899vv+OiGrbQnZ7jwd9aGf0m7YFBm
         ajXw==
X-Forwarded-Encrypted: i=1; AJvYcCWEXB6hlPwLc0mmpAXAxjc6a6OSR4ZOV20ZsPDVAID/xRLhXLz67Cw+k1mf7U0pNCzO1N4BML5P@vger.kernel.org
X-Gm-Message-State: AOJu0YzxDO3SRgiDbp6iBY7Y+du1CPD+UAjW80vFwBCfg7gCGtpUQ1Cv
	NuQF0mNJv+wPVN3Vs/BFWcBm96RSj5UmSrJLIj+VzjZUkM3+shYYPoVIR5TCxIEzL4I=
X-Gm-Gg: AY/fxX5PkiJDC7itfFeGGbioISM/5vhl1y6YV/5IVgZaIT+yO0uBzjMA8EOvpgXsPxz
	I32i9Rt1lXXm6DvCrpkD/429E3/ZQiAQrPmChx7RsT18EJI0U4+b5XRsoiCowhjPEWE4VeYl6XD
	DUyhJDrHrTJbZoV0UXEYEYccpa/a11ZWTfpGqdFZyCb2CnU3sCMalS0uEy6ieSWjhDXBItom2iG
	dCJvaC7WVxsdKTeNa+Q3N6/wqYoTONtPPpHzO9KQuSiPCX1D3N4w0aBMun8e9A7pz1BJnF/OP6U
	Bs1F++X1n5iz7QQMbOMbksIDD/EXVkwi8zR2LPuduD8U2XmqarSj5FtR+EohNxzlopWqgue1wo/
	tPLEtOJtMRcbmzAChgt1sMscFUPknU4QwQfkpJxqRV4eo16FnCH0okqJC8P3gCZ9ogl1bq/92Uu
	LrLSGyNDTMeUzs05lqNzXkSY1V5X5sxHEFwJ+95ySIZrG4lL53QNMum3YFnISu90tdzvL2S7va5
	QBAV/GGyblx
X-Google-Smtp-Source: AGHT+IEjLsxjJgm1tNq7go/FJWytc3qikX7hfJ771aCTmb2GXgsRKeoMSeIHBck7CqE/+dxxSKBwnw==
X-Received: by 2002:a05:690e:2453:b0:641:f5bc:68de with SMTP id 956f58d0204a3-6466a8d7899mr10102913d50.75.1766536293059;
        Tue, 23 Dec 2025 16:31:33 -0800 (PST)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:d3b4:b334:ddb5:458e])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6466a8b1758sm7595565d50.4.2025.12.23.16.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 16:31:32 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com,
	fstests@vger.kernel.org,
	zlang@kernel.org,
	konishi.ryusuke@gmail.com
Cc: Slava.Dubeyko@ibm.com,
	linux-nilfs@vger.kernel.org,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH] xfstests: add HFS/HFS+ and NILFS2 into supported FS table
Date: Tue, 23 Dec 2025 16:31:21 -0800
Message-Id: <20251224003120.1137284-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds HFS/HFS+ and NILFS2 file systems
into supported FS table with L1 level.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
---
 README | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/README b/README
index 196c79a2..d5a94205 100644
--- a/README
+++ b/README
@@ -87,6 +87,10 @@ L4: Active support from the fs list, has lots of own cases.
 +------------+-------+---------------------------------------------------------+
 | 9p         |  L1   | N/A                                                     |
 +------------+-------+---------------------------------------------------------+
+| HFS/HFS+   |  L1   | N/A                                                     |
++------------+-------+---------------------------------------------------------+
+| NILFS2     |  L1   | N/A                                                     |
++------------+-------+---------------------------------------------------------+
 
 _______________________
 BUILDING THE FSQA SUITE
-- 
2.43.0

