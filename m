Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E77C1DF98C
	for <fstests@vger.kernel.org>; Thu,  6 Feb 2025 21:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738876917; cv=none; b=I/mgbCqlFMS1FcGSVxbI560oQTBYR+mCcVCuItYOLCbJZczAEQ6+RH4duDY5lQt/ES87xEO3ODrck2sqBbnkZfS2ClHvUVroGVq+kAVP0dzytOtsbANSO3+4P9GBOgjrWkIOHZmCyvU2EW5IlA+FiFBQrTe7jqGcA8XxlJP7lk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738876917; c=relaxed/simple;
	bh=CaH9yhAqnQtSElYQ0bAQqyWKf1eIQlzt0U36jXRT6Rs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hISoQH3Ba0Er7TvpxOq+TMJm8lpz8tZlKcG1x6JQCQDVmgdRcdb1viuBzJWaMw1ZYFmvb8U2Hr130RydbBiYXpf+V9RL+BtOoy3PgXnCp42dg3cKvWS4jUldbEeoxuspQrLiNl6U9vwFBfSeUWmESCL27ZuZ84cN9PTF4I65Wj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DhdDdmuJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DhdDdmuJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738876915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rNaGm6uyZjVQMnJPAzPDKthK/tV5qvJZ1ClfruL6hYs=;
	b=DhdDdmuJjrw2f5rgGJ3AfjOeIyy8e6Whg5AoP6JJ3w8gMuxTqphuaokVqwt8uM+L5zXC93
	JLK7fUfuJAAX6gM83ic2ccdPSWxFFN5WVlNztdEAB+YrZ3jIAd4BHtmHFrJZRQ+VqM1YDU
	JJjeQDtBaUuOetjplLyJu08pFI+zFXk=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-WH0HLB4zMrqhmS-weSH4NA-1; Thu, 06 Feb 2025 16:21:54 -0500
X-MC-Unique: WH0HLB4zMrqhmS-weSH4NA-1
X-Mimecast-MFC-AGG-ID: WH0HLB4zMrqhmS-weSH4NA
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-84cdae60616so95661339f.3
        for <fstests@vger.kernel.org>; Thu, 06 Feb 2025 13:21:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738876913; x=1739481713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rNaGm6uyZjVQMnJPAzPDKthK/tV5qvJZ1ClfruL6hYs=;
        b=NVIYCsYWOBXYLl2J0jZt6pMe4wPqNQ6wZHmPEvYhxP19eBhLQpr8BA5Hb5N7ZHRCu/
         visi1PAnDBDuQobMcxPd516MZFApFEgBUiTmZrqO4k5f/hI3c02tGDsUJaTP1iH7rkpr
         o3VLYHBCS3fT/zp4hBN2uyRy5nXHXDEO8KazN5kEEtrT3AeF74IbLyn+d0on65ARxYOU
         PQHRtxAOtXsNrbToD2WXEA8iVap+1BAFYQ2gT1XLuo9MS0t9tWKg3akFudqePx5XTp2O
         gHVz3jUhaq4NuVv2W05YwMrBA9B4c/ZNkqXNwaRdnsNycEDTGFeuxTk+68ZJC7NimOmM
         UXYw==
X-Gm-Message-State: AOJu0Yz7gnk2mU23VO9Ak2etxVZgZ7u6gsDWSiYfSuHOC2YPniKX5K0U
	MOsdq3K3MRBVNjvE7X73RaM9Gs6jPzyynQfn3AtFG4lU7GOfz9m4MRx4wWzv1+Y35xtBXZ4Mvqs
	eQtDO45mzJOvgtNHxwubaNTwarQRDL4nkmadl1c9CLftyngAJmzU3qkKHsS7XiE8H0iaR4aTMDt
	/uWdrv0NWPbRoWjSVR2xFdphoPrKmpfptFNRxc7EmD
X-Gm-Gg: ASbGncs9BaYzYXC1oMY1YHv7VbJ6G4Honx7O0/M2CBpWnITXILJ1P/hAIfBNfztl4c/
	fVrAdu2epnuC3eXTAChTMGiqA09iNVoNnDiV9Js6+R9E/md12GoNPGdYWLGPZ4wvWe4JdXc9A7i
	3OFczVa2/G84Qbz9B29OAonw2qW/7WhjIT8RYGEoTSCE+ePcn9BClDvAZTuFq1ACzD/D359mcIj
	qLVDt1k3s48Ulm+SAkAU/rBZlWquabVOA/9iZhjTinAci2NfJz0oansDfiYaf1AzNHKjrPa8az5
	cGl7CxLTnCRrsFvByjOGnF//waDmq7e92hJm4fi+ydX2PZnJd+Z3EQ==
X-Received: by 2002:a05:6602:4008:b0:851:f176:9827 with SMTP id ca18e2360f4ac-854fd89ba0bmr126969139f.5.1738876913472;
        Thu, 06 Feb 2025 13:21:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJmSwmqEpQ83w99rZujW2flu+d6p8H9xKBimCrn+bo7OD5PY537eRwh6mPEKP/soydPNIUEw==
X-Received: by 2002:a05:6602:4008:b0:851:f176:9827 with SMTP id ca18e2360f4ac-854fd89ba0bmr126966839f.5.1738876913042;
        Thu, 06 Feb 2025 13:21:53 -0800 (PST)
Received: from fedora-rawhide.sandeen.net (97-116-166-216.mpls.qwest.net. [97.116.166.216])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4eccf9afe8bsm435133173.6.2025.02.06.13.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 13:21:52 -0800 (PST)
From: Eric Sandeen <sandeen@redhat.com>
To: fstests@vger.kernel.org
Cc: Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH 6/7] lib: make a few symbols static
Date: Thu,  6 Feb 2025 15:20:01 -0600
Message-ID: <20250206212145.7732-7-sandeen@redhat.com>
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

There are a few symbols in lib/tlibio.c which should be static,
and sparse notices this so fix it.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---
 lib/tlibio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/tlibio.c b/lib/tlibio.c
index 22ff1adc..2aa8175b 100644
--- a/lib/tlibio.c
+++ b/lib/tlibio.c
@@ -82,6 +82,7 @@ static void lio_async_signal_handler(int sig);
 /*
  * Define the structure as used in lio_parse_arg1 and lio_help1
  */
+static
 struct lio_info_type  Lio_info1[] = {
     { "s", LIO_IO_SYNC, "sync i/o" },
     { "p", LIO_IO_ASYNC|LIO_WAIT_SIGACTIVE, "async i/o using a loop to wait for a signal" },
@@ -101,6 +102,7 @@ struct lio_info_type  Lio_info1[] = {
 /*
  * Define the structure used by lio_parse_arg2 and lio_help2
  */
+static
 struct lio_info_type  Lio_info2[] = {
     { "sync",      LIO_IO_SYNC,		"sync i/o (read/write)"},
     { "async",     LIO_IO_ASYNC,	"async i/o (reada/writea/aio_read/aio_write)" },
@@ -120,7 +122,7 @@ struct lio_info_type  Lio_info2[] = {
 	"all random i/o types and wait methods (except nowait)" },
 };
 
-char Lio_SysCall[PATH_MAX];	/* string containing last i/o system call */
+static char Lio_SysCall[PATH_MAX];	/* string containing last i/o system call */
 
 static volatile int Received_signal = 0;	/* number of signals received */
 static volatile int Rec_signal;
-- 
2.48.0

