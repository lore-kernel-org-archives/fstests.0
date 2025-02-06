Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC5F1D61A1
	for <fstests@vger.kernel.org>; Thu,  6 Feb 2025 21:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738876917; cv=none; b=jixGnCkfuNfw7/4cakASzwMPr/TFDORQsG3J/gJhyIntBaHE+tKKF3kzdB3rFUTGp3DcStCffGSx+s54sMdzYled54K52HeF4hfqNxwcQyb82NZxyN/g8kQEhaKqWsgKWJWYLEpEUstzE+gxOaMXn37K2ublyDSvsaZC6YBMViU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738876917; c=relaxed/simple;
	bh=AicclmB2sRoP/EDpIgd/7SciCzg3e/WnxEzLHRiFsw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X6eBEpfX9ko1fV4w5TCaROqb3JVgynIDGJlVOuzkU2OFE8dytpFl4geEQEJW2wkpuRt/omBkESwOoEocdXZyWPO1h/GprDVuBUQiM2Z4KMYhRPMUsUmpsyLjO2+iJ3A1gwkMWb0R7TlSeSj4ke28v2ZqAXWB+/BKSwPIhwyvOxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IlWFMDLo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IlWFMDLo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738876914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e6lXaCMKFu4tHvUP4wEoX9HgIfpy5RxL4ebQs25fjnY=;
	b=IlWFMDLoeVo3DkXUr/+E6B+vebS3lbnL1VsbiVfOQhmmrz0Px0uOnEwZzJvhcDjd0baGkb
	9r/z6iayhEXOb7uGotCMX89lu7FbFIkQmUQ2cRo6xRZ5yAUML3ZlAUdwYrL/q9dQtxxbUk
	hBAcEGs9BoA9qXVSnaDo4Qd3n2VzKn0=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-xub8CcTjOzSuZAIQ753Zqw-1; Thu, 06 Feb 2025 16:21:53 -0500
X-MC-Unique: xub8CcTjOzSuZAIQ753Zqw-1
X-Mimecast-MFC-AGG-ID: xub8CcTjOzSuZAIQ753Zqw
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d04f44a8eeso26935375ab.3
        for <fstests@vger.kernel.org>; Thu, 06 Feb 2025 13:21:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738876912; x=1739481712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e6lXaCMKFu4tHvUP4wEoX9HgIfpy5RxL4ebQs25fjnY=;
        b=HBrxLJ23WEJoqACxv5lXBdbhXVZ/hOugLLPlrsw3FrAkFp29tXGwKx7wp6UF3/ovIX
         0oyITmbuC/+Ym2GvKuq4gXIFSmI/cXRF5jSHs2HQWaUd9AeDLQngH6Ctnn5KpAYCJHQt
         190n3lgWjwn8ZTKzWX5LNetakcNYp7Rfip1UKUFVqiWWB6+tRQ7Q+lqMmX/V479l6ECN
         0t/8dj9KG2LLarhuIfh3ylsHVKpLM9+7pTD8yqi0wcROl3quTHpVVk2SoP/bsUqT1/Hx
         yl4rm2XfkxZ5lJ9dFZjIFA7gEG9YWvRBz6d881eMhYJ/K4oKsesYxCnACBqU9qYpc5uf
         3qvA==
X-Gm-Message-State: AOJu0YwEpFrPMhVPpydSo4nvhJYQX6ZHcoHO05xKXSpw2F/P3VK/cdOP
	/BT5WzJku9zO87PwN3ZMc7m7yL3XMAYhkc2HM8A4DrhuWWlPNtV3NqpKCHyh0golR4AmWzvPfsh
	iZVTKVAW/RGxBzDd2JQpFts3qBKxsayWXWeCMjBAnBRgbSpif3Z4v2ZPGLP0KCvTd2rK2QLMjmT
	y1RN26HPizLoIW1hFWGTbLs9iYn1yqB0+dgNnUNg3R
X-Gm-Gg: ASbGncumfdzQNMa75uAltc/Pg9ZCCJak48/7x3Ghfw9XAVDaLpcL+AWPlsH0QG6HyUX
	jE3TJtUwlCJKQvbh2RjdVKuu9P5T1qPGEx1sko4ng14kiVRnCvpXuKO5gAOyC79rm9149ua9aC+
	xOn7laQgtabvI/KY6XQGmXSXy09x6uZDynnOLUdh2hLR31j2eJccdq4q27eWXw5yfSTPhxL+3Zp
	+j9lS3fy34s4d/NLdpycTQSBF99tNSlpLnLz0rXNVPwvOYg7X4wyOaZb/ZQ2JnOkgOiJRpg5tZP
	nru5YlZqY1t5KIZS/GC2kcS12Ww+ttvUMS+WoI/kahhlMlJIOBkHaQ==
X-Received: by 2002:a05:6e02:20c9:b0:3cf:cdb8:78fb with SMTP id e9e14a558f8ab-3d13df0fb5fmr4825385ab.16.1738876912413;
        Thu, 06 Feb 2025 13:21:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4lBtPFOgehijg2gxSNaB3MKmnHbgcQ5yABdVgxD+Og5vA8OpSpvKVcJnPVxrkyFbg6Fh1cg==
X-Received: by 2002:a05:6e02:20c9:b0:3cf:cdb8:78fb with SMTP id e9e14a558f8ab-3d13df0fb5fmr4825275ab.16.1738876912087;
        Thu, 06 Feb 2025 13:21:52 -0800 (PST)
Received: from fedora-rawhide.sandeen.net (97-116-166-216.mpls.qwest.net. [97.116.166.216])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4eccf9afe8bsm435133173.6.2025.02.06.13.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 13:21:51 -0800 (PST)
From: Eric Sandeen <sandeen@redhat.com>
To: fstests@vger.kernel.org
Cc: Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH 5/7] lib: replace aiocb_t with struct aiocb
Date: Thu,  6 Feb 2025 15:20:00 -0600
Message-ID: <20250206212145.7732-6-sandeen@redhat.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250206212145.7732-1-sandeen@redhat.com>
References: <20250206212145.7732-1-sandeen@redhat.com>
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
---
 lib/tlibio.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/lib/tlibio.c b/lib/tlibio.c
index 19192b38..22ff1adc 100644
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

