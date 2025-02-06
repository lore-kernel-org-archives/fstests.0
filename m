Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED031CEAC8
	for <fstests@vger.kernel.org>; Thu,  6 Feb 2025 21:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738876914; cv=none; b=Qt4s0m3ExonrbQdv6YsBx3FVmwWdwDlKCtJkOX2OGKLzhhFGl/CeEtBV+S5pLXTEiZE4/h+C0U6KpwD/06B5kBQycwQuhxsW6LMv/sE6uBDPW1f51LcI3O83e934ZGenXynlOt0+B76ndM9gt8XPQxR7VpEPKT32rtFj9xq2M80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738876914; c=relaxed/simple;
	bh=JUV36Ey7mkf9flasEnSj/dEVwniRaxehflYNZPYCaek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qOvNoFIEq9fyBt1ZjqEIq/6eIeFpauZihb2EOHdne8oxh2eSs8yT+Xz1W5IBif8gN3vIwOoo2ZHCpbkXd0x3N9Ex1gUAwvGawgcu631sA1HztO5irJw92z0kaqjlf//H+j6MWcuF2XnEvi2CQ36QPxvlD2nb6OJ8PAVN0muu1k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NXvRxfb4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NXvRxfb4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738876911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lKwjKVNejs6w3Hw0cmKUpZYv+RNLmLTojt4wHh6J1t0=;
	b=NXvRxfb4aO11BXdBKCAZOB3+qynskHpGAMsrOImReFEoFYOPhadftQbFZ7Wz1lc6nFjLk9
	jy2qg3J8JVW44eCsbsI0NilxybkS0yfiKPAsnJYahBEue64dQsRkmJ7KstW7v6tKY+raYL
	pKgkmTdexwFBqOf7wM6N7+kvnMoJ/Lw=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-PHsI0m7EO5aQXTBVLyCqPQ-1; Thu, 06 Feb 2025 16:21:50 -0500
X-MC-Unique: PHsI0m7EO5aQXTBVLyCqPQ-1
X-Mimecast-MFC-AGG-ID: PHsI0m7EO5aQXTBVLyCqPQ
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3ce7a0ec1easo9975815ab.0
        for <fstests@vger.kernel.org>; Thu, 06 Feb 2025 13:21:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738876909; x=1739481709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lKwjKVNejs6w3Hw0cmKUpZYv+RNLmLTojt4wHh6J1t0=;
        b=wD10CYzTQEm8AgE0uoE5wxSyj+yVzuvHszsquVOW0F4RyKHHm1Z9NgBpaNP0fS0HJK
         Qwn2MfyQqOdl47xfClLmbDFBtxgkxolnMXciVnn9drfojBW0WC0EWYes4DkriRH8i5yt
         R7jM4579gxIMXp5BIbyy7L9W2/OB1hfpV+o4TEY4iyqvb8VUBvrnyPI7hHEnOsVgWrV2
         zeOSi+97EW2tJJ/HF9ebax+uus+m1ySd0AjuM01EU+u4FlGGHflGOu+u4y+ALI9deDY8
         zMM4Q8VORndPOWVUR3aTXvKpnJpvbFx3jOxP1H954R0FHYRKc0o7boN/fw0qY7VsQSVJ
         T9aw==
X-Gm-Message-State: AOJu0YwZeunOxe+pqatd5iEjBdLi7SGFFpvNX1FGtyG1ltjvAotIWoIs
	nzemTsKaNvATvk8A6MWCNOB8tGbo6SfrdijAAt2mGvpMEKFECaLEH8bLS6C/1FaHKRV+nnccn1I
	YT82HsCKrBP9fdcJPAhRsNO/ltgax4BOE88oL7DrD2QbQC+3ZgK2wblUEBDe8giZiRNc1Vqv7W3
	ghrOG6vSD0+zAlfBO+OpjHeDVQKVRqcFVh3D5/YAmQ
X-Gm-Gg: ASbGncsH0WWWMm/LkvpjXTE17XVUiWRO6gcDfLydrTcFAv2mafDneD40kbHx6cTPhZx
	RGgo9zlBLvm6vwwGdo83Bt2fOQYxsN5b4nPX1tDSEhCnoWP7EOE8TO0RH5dPCaEbiF2X9litxn2
	itYBeVswSGf7XP96t4uBBnVXu2cssWZ4UaBVVR7DNWZE/Ot/3SbTuTkrXZyv9Lefyv+y/3nxrP5
	U81Cpv0fv92jCSYYkTjqU4nlukiXu/cue0YmVawOQFAii/Uir5kTj3wHyxhhXBX8ew3iHEQiO3V
	AkgU0O/sHBrKQMFOlnxfOdI9afVzRDXXGCFBTC9iqPbafKYAoP/41Q==
X-Received: by 2002:a05:6e02:1a0d:b0:3d0:137a:8c9d with SMTP id e9e14a558f8ab-3d13dd13f7emr5950165ab.8.1738876909067;
        Thu, 06 Feb 2025 13:21:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9Jfa1UGfrBA9GWTTl0dB7FwgXfnuG59VU6axbFSkIH9qBPyIoOtJtMkft8DxWjcvSXBC3Dg==
X-Received: by 2002:a05:6e02:1a0d:b0:3d0:137a:8c9d with SMTP id e9e14a558f8ab-3d13dd13f7emr5949955ab.8.1738876908688;
        Thu, 06 Feb 2025 13:21:48 -0800 (PST)
Received: from fedora-rawhide.sandeen.net (97-116-166-216.mpls.qwest.net. [97.116.166.216])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4eccf9afe8bsm435133173.6.2025.02.06.13.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 13:21:48 -0800 (PST)
From: Eric Sandeen <sandeen@redhat.com>
To: fstests@vger.kernel.org
Cc: Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH 1/7] fstests: enable sparse checking with make C=[12]
Date: Thu,  6 Feb 2025 15:19:56 -0600
Message-ID: <20250206212145.7732-2-sandeen@redhat.com>
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

Enable "make C=1" sparse checking when files get rebuilt. To check
all files, run "make clean" first.

Enable "make C=2" sparse checking of all files without rebuilding them.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---
 Makefile           | 14 ++++++++++++++
 include/buildrules | 19 +++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/Makefile b/Makefile
index f6f91a4d..79779d5e 100644
--- a/Makefile
+++ b/Makefile
@@ -14,6 +14,20 @@ else
   Q = @
 endif
 
+CHECK=sparse
+CHECK_OPTS=-Wsparse-all -Wbitwise -Wno-transparent-union -Wno-return-void -Wno-undef \
+	-Wno-non-pointer-null -D__CHECK_ENDIAN__ -D__linux__
+
+ifeq ("$(origin C)", "command line")
+  CHECK_CMD=$(CHECK) $(CHECK_OPTS)
+  CHECKSRC=$(C)
+else
+  CHECK_CMD=@true
+  CHECKSRC=0
+endif
+
+export CHECK_CMD CHECKSRC
+
 MAKEOPTS = --no-print-directory Q=$(Q)
 
 TOPDIR = .
diff --git a/include/buildrules b/include/buildrules
index bf187662..6c2b7e18 100644
--- a/include/buildrules
+++ b/include/buildrules
@@ -35,6 +35,21 @@ endif
 # Standard targets
 #
 
+ifeq ($(CHECKSRC),2)
+
+# Check every .c file with sparse CHECK_CMD, do not call compiler
+$(LTCOMMAND) $(LTLIBRARY) : $(SUBDIRS) $(OBJECTS)
+.PHONY: $(LTCOMMAND) $(LTLIBRARY)
+
+%.lo %.o : %.c FORCE
+	@echo "    [CHECK]  $<"
+	$(Q)$(CHECK_CMD) $(CFLAGS) $<
+
+FORCE:
+
+else
+# Regular build, possibly calling sparse CHECK_CMD as well
+
 ifdef LTCOMMAND
 $(LTCOMMAND) : $(SUBDIRS) $(OBJECTS) $(LTDEPENDENCIES)
 	@echo "    [LD] $*"
@@ -49,12 +64,16 @@ $(LTLIBRARY) : $(SUBDIRS) $(LTOBJECTS)
 %.lo: %.c
 	@echo "    [CC] $@"
 	$(Q)$(LTCOMPILE) -c $<
+	$(Q)$(CHECK_CMD) $(CFLAGS) $<
 else
+
 %.o: %.c
 	@echo "    [CC] $@"
 	$(Q)$(CC) $(CFLAGS) -c $<
+	$(Q)$(CHECK_CMD) $(CFLAGS) $<
 
 endif
+endif
 
 ifdef POTHEAD
 %.pot: $(XGETTEXTFILES)
-- 
2.48.0

