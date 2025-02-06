Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEBC1DF96F
	for <fstests@vger.kernel.org>; Thu,  6 Feb 2025 21:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738876914; cv=none; b=Sc1sH1eQElKZ+fPVvFKWnF6bbSUNciSh8LLeXPOsRYmpwpJjLDs4DOXFjAk8js0NIEbKL1XR4wHyRR+3910ylLcaowWnsScLUkDdza/fHRpCPiQKX7++84YUjFljbxm2adYSMC/3meR9TVSW4TpQh/51Z6q1re7TX1xBcLaIQRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738876914; c=relaxed/simple;
	bh=2r92bRjaC0yhtEPXbWclHLXSmtabqHGp6bqVZo4hKh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gGAaBZzUFq30LtXs1FwsCWIFugMqBN5h6fPljXnY7g5xUckyTAZlVh9F6MlH+SMO7sTwQB9sO7EVLSe5fwtvYu0Ic6FP4XL8bpJZrlXzvwOr9810z5wEJGEU25Rhhk7GKNyM5XnSVl9Zn4kO09urItpH+3gsFWaQaDHeAjArEAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BLtDIu7L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BLtDIu7L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738876912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lA8i/oRdyCBlDg773iCwg2jTsbIUKoN2kaiGlFn877g=;
	b=BLtDIu7LaA0j9t3ZqqVcvizravHqKSOnKwDBygC2WcT6uReI2Sk+wUIRWj9PnsGdhzX3Cz
	wRofJcJELwsfSEs7HRGO8bgc0ImJ6YIYKUssODZT5Uoo1Vx+zjZnmeD0t8g0K4glfqISFN
	GfUNBZ1z5WkIbL47/uf1hcaKvnWDqfQ=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-gy8uYDDVNuevmErYDcQEJg-1; Thu, 06 Feb 2025 16:21:51 -0500
X-MC-Unique: gy8uYDDVNuevmErYDcQEJg-1
X-Mimecast-MFC-AGG-ID: gy8uYDDVNuevmErYDcQEJg
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d058142573so13433325ab.1
        for <fstests@vger.kernel.org>; Thu, 06 Feb 2025 13:21:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738876910; x=1739481710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lA8i/oRdyCBlDg773iCwg2jTsbIUKoN2kaiGlFn877g=;
        b=C5M7j3PXRC092qRt788DuNQNWMtTb3VIa1wjBI0gpzXcS/Xj+ZVCD8a6U+alZfEFtH
         YFuydinFx5vhVndCl1NtOEoNcaWfOx+fP7FAmZq6T06FBL6QN1isdoFo4tF9w9n7U0Q0
         B1DQ5akNQZo1MNMVKkZ+b/geAqKXjZIyiEnpREC+NpM5m7BzremP8mATQDm6JRPQo+6z
         z7/PSrS6g7m1pAmg8poYKGpFAwhHjpMqUgWuy4KDiPNFnFTfbgZOb+NDTlCqVOpXSYwl
         XTHxYRD/NWxsq3QfDWttVdzee5BqMNy9IxmIIg6ULfyM5JM4ycXlNsz7moYtfsMZPANB
         JnBg==
X-Gm-Message-State: AOJu0YzApxDvBuyod33kQerEUDffeYDtgus69nXxPilXJSR+o1ZNLuvi
	9hq8Vo08QeWR+7LgW3dWnf5cBH0vWHrcGWjuV+QOvNafIBmeL8fRKpkeOB+83ImpDrcCHOgKUZE
	2FHSggkdrG9JuIznBYZ8s3Ab3t3mQaaf+RG1vcHn7taltcJiGESZ4j84PBEPGfwjjRkbovhcC/0
	49b3rRw4RWeIIj/dmAaft1GcemJv+D6cnLQAvrw9GS
X-Gm-Gg: ASbGncusQln9j3CsIM3/tJW+eBtKJr7ipi1X8qqIwWe2rVbk02HI7RyXlEWkNV3iYBS
	oXW+l20vzWb2uOII/NPJRjPJF/beeHrU0nY0zhfnIr6RGyT8SMmZ0ITSsT2X4mQ4MRKvPKyh3zp
	kZ8Sez7QBjPfAiAXE7cgd1vspAShnodeNMYYtBENPgso/kc9V2mkcVf82kcNzgrjOQqSIh1N0U9
	k6guiijFJkLaoAhrf8EMwzbCVIFOPjIvE2eNO+EbWWtvKqe9lP+U+koWxl5PKVLSdlDd3+fQIXI
	VmFOokZFd+/lKjv6Jpgz0vpbfYalH/j4+wZnvLzy0HI6/bjubRinaQ==
X-Received: by 2002:a05:6e02:20e8:b0:3ce:7a41:d885 with SMTP id e9e14a558f8ab-3d05a540706mr43220705ab.1.1738876910195;
        Thu, 06 Feb 2025 13:21:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZGL36BNOjat4wnL/U/JW6jVjbcBpOAI6xGXLK/jxiQD9pb755doCGlV3HuT7mgU/Hffjetg==
X-Received: by 2002:a05:6e02:20e8:b0:3ce:7a41:d885 with SMTP id e9e14a558f8ab-3d05a540706mr43220555ab.1.1738876909876;
        Thu, 06 Feb 2025 13:21:49 -0800 (PST)
Received: from fedora-rawhide.sandeen.net (97-116-166-216.mpls.qwest.net. [97.116.166.216])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4eccf9afe8bsm435133173.6.2025.02.06.13.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 13:21:49 -0800 (PST)
From: Eric Sandeen <sandeen@redhat.com>
To: fstests@vger.kernel.org
Cc: Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH 2/7] builddefs: define linux
Date: Thu,  6 Feb 2025 15:19:57 -0600
Message-ID: <20250206212145.7732-3-sandeen@redhat.com>
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

There are several #ifdef linux guards in the code, but nothing
defined it. This caused several sparse warnings, so define it
when building on linux.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---
 include/builddefs.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/builddefs.in b/include/builddefs.in
index 7274cde8..00dec0ea 100644
--- a/include/builddefs.in
+++ b/include/builddefs.in
@@ -78,7 +78,7 @@ HAVE_FICLONE = @have_ficlone@
 GCCFLAGS = -funsigned-char -fno-strict-aliasing -Wall
 
 ifeq ($(PKG_PLATFORM),linux)
-PCFLAGS = -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 $(GCCFLAGS)
+PCFLAGS = -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -Dlinux $(GCCFLAGS)
 endif
 ifeq ($(PKG_PLATFORM),darwin)
 PCFLAGS = -traditional-cpp $(GCCFLAGS)
-- 
2.48.0

