Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEA82356AA
	for <fstests@vger.kernel.org>; Mon, 10 Mar 2025 18:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741631407; cv=none; b=cNV5HgSrXFUKcT21cBfhcaJ5Pq9+DQx5CFU04u00dVLwjx1B1B3IAgf9OcykGaaQuPtFpmU7RA0tg9Ijmhf1xVrxMqc9tVAbS4hzdiP/2wPHyUZG8YCHv93zkfTB9AAIeCYic2Ze+JRG43TZz2nEeofwJ6qEF8CJ54VN4B2Mt4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741631407; c=relaxed/simple;
	bh=jBdY0mo2vgWMSmvDnelDdrM9/pN4RUvOPj9hbeyurr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ndwHX9ygggfMogmOF4qn8oY5wKUjS6OiSKbCF/pf2hzu0RVbhRauJKsvB6GLwjDWGyAbLnn6IV+NOtqSTgVSpdDLfr3T9nTWMVRfo1En2Qt0qVlqULzdWfHV2BNHkhq5lekPqHiFjssgOMZuwrPgKuxaINEGYcEpSDbWe1WBMfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LxlqdLT6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LxlqdLT6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741631404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Oz2FBjvUAa5LzJk847xEj48krMp/+FjZ6+AxKkihX4=;
	b=LxlqdLT6lr4RXu/+zCwd69tKS/IioOeobQ2Evx9kdKDKeTqhBbrgnoXie97P+bTZRg379O
	oDXz4SPPlJlULF4e7fizuJ04w5LDiWIBXohwCLhWVZ2hoHIi4h5j8Cjlp3eGUecmldx2YX
	MceM71KStdhuWYIpwObDqnLv+8BawsQ=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-0jbiRh5PMNavDqD-r_OnCQ-1; Mon, 10 Mar 2025 14:30:03 -0400
X-MC-Unique: 0jbiRh5PMNavDqD-r_OnCQ-1
X-Mimecast-MFC-AGG-ID: 0jbiRh5PMNavDqD-r_OnCQ_1741631402
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d2a6b4b2d4so83201495ab.2
        for <fstests@vger.kernel.org>; Mon, 10 Mar 2025 11:30:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741631402; x=1742236202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Oz2FBjvUAa5LzJk847xEj48krMp/+FjZ6+AxKkihX4=;
        b=D2viTYyyzemNXe4QNrrj6jKL/ZBb+1FMCQn4La8sR68Bgexp8fhychSgqd3TE7A7bl
         A9yzfN1DbnDDO+4ZmNz0fM9P7ZTprAJQkNWvLWijeKVVEg3ylGgs9nxa5EF7ef+AN11f
         gITLZawshKzeF2NA3vzUz79jQ+JVTvW1zbbCl7Rrh3ggCB2+ebhpqpoUUoIDRKqIkx/m
         1xiVEyTbryjrL+YjJJhGBDloqfR1//+h09t5cLFx63q46Tk+ix7oi//pwFOqxQ3xmdkB
         bmG2sUnusxfbe76xnmGLlTFaE73kTNtUtH2HXJHLENJusv9vvm4KtiMCoerA3bjwC7tn
         vrgA==
X-Gm-Message-State: AOJu0YwKY9Y66BwFq8eM6uqgyH3wmDAsr/zXOtjHMmzjR+9ivptcjnaQ
	TCAuADfCXLF33vnLUzMW86mnKo4OE/csYVfnFZ3VOtZaJKwGZUS97GoW3A/dbeVDzKPlHOcUU0P
	Gvet1jVJ4fi6SO7XGgLCOKzfcJGuqtJqqris5vcmA+a7GgV782/P6YkHk6Kk5QBQwWbS+3gjwOk
	Zvbvsf7N+2036kN1+cL4HyUIceWkAizSOakaqrMSmh
X-Gm-Gg: ASbGncs99j4J+fEoasmEeLnDL7BpX0Om6ep3tra/eSTHel81SaKi+pu+UPZSXdnpchp
	RcgXTFWAZJRalCAUM/RKht/32k0id/+hOiq58VKlRf1LDbjnKLwgHaoe4XutejNFdt0hNY2kujq
	rL3eHr+RsLsYJSDf4mh7it8BE6MOY8EwBpXDS9TmAihmDl8wGQQkMSqRyW0aVGJL9rLm4A5PRTP
	gC9vqk7YlirHfarJmegOc9LjW/YSCsEfSQ4i2aP840Rls729YG7p0RU34y2tujXA+0/ZzG8L/+S
	an4B/CNTFnRuJpsjHKtLCY+754N0qnI=
X-Received: by 2002:a05:6e02:1aaa:b0:3d4:3d63:e076 with SMTP id e9e14a558f8ab-3d44192e5f9mr204817935ab.18.1741631402439;
        Mon, 10 Mar 2025 11:30:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2EZ2cRwM+hF1ITF8lv8BIyCdRDQqEuqubnekLrwUN1QPAwEX/+WpOGaaYvc1Tk/EI87Wk2w==
X-Received: by 2002:a05:6e02:1aaa:b0:3d4:3d63:e076 with SMTP id e9e14a558f8ab-3d44192e5f9mr204817585ab.18.1741631401962;
        Mon, 10 Mar 2025 11:30:01 -0700 (PDT)
Received: from fedora-rawhide.sandeen.net ([65.128.97.82])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f222ee2efdsm1587512173.13.2025.03.10.11.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 11:30:01 -0700 (PDT)
From: Eric Sandeen <sandeen@redhat.com>
To: fstests@vger.kernel.org
Cc: djwong@kernel.org,
	hch@infradead.org,
	Eric Sandeen <sandeen@redhat.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 5/7] lib: replace aiocb_t with struct aiocb
Date: Mon, 10 Mar 2025 13:29:07 -0500
Message-ID: <20250310182954.1396724-6-sandeen@redhat.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250310182954.1396724-1-sandeen@redhat.com>
References: <20250310182954.1396724-1-sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

aiocb_t isn't defined anywhere, use struct aiocb instead,
to make sparse happy.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 lib/tlibio.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/lib/tlibio.c b/lib/tlibio.c
index 75f10cec..9d852ff0 100644
--- a/lib/tlibio.c
+++ b/lib/tlibio.c
@@ -42,6 +42,7 @@
  *
  */
 
+#include <aio.h>
 #include <stdio.h>
 #include <ctype.h>
 #include <fcntl.h>
@@ -810,7 +811,7 @@ lio_read_buffer(
  * (rrl 04/96)
  ***********************************************************************/
 int
-lio_check_asyncio(char *io_type, int size, aiocb_t *aiocbp, int method)
+lio_check_asyncio(char *io_type, int size, const struct aiocb *aiocbp, int method)
 {
     int ret;
     int cnt = 1;
@@ -895,9 +896,10 @@ lio_check_asyncio(char *io_type, int size, aiocb_t *aiocbp, int method)
  * (rrl 04/96)
  ***********************************************************************/
 int
-lio_wait4asyncio(int method, int fd, aiocb_t *aiocbp)
+lio_wait4asyncio(int method, int fd, const struct aiocb *aiocbp)
 {
-    int cnt;
+    struct aiocb *const aioary[1];
+    int cnt, ret;
 
     if ( (method & LIO_WAIT_RECALL)
 	|| ((method & LIO_WAIT_TYPES) == 0) ){
-- 
2.48.0

