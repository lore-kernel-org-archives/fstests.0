Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E59231CB0
	for <fstests@vger.kernel.org>; Mon, 10 Mar 2025 18:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741631403; cv=none; b=ladFyUkSY0Rxj8CkesVBT8KKhdcTBNd4Qz78OZWY4Fum25ZO662BKAQtu20WjNzb+F3XVOTgHsiGJtLT5VLAVueDFsf40Gt1BN+bt20Z2D4w+Gf1/5r2ZJShtqJyKiVe815WbzJ9bfk+VSW9k4MkQaaSZFwiE1bXnJUwdok1Bxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741631403; c=relaxed/simple;
	bh=VYSVv4yNw9347y+x8jQEySXy8gxfcTIB6IESovcXVCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ET0lWweSF1dUknd3Wumv/RX9bIsZZEuXLdAFu9qW6MfDm97RkY6hRI1UJbZVY8cDZ1/FiEpqOlfIEUm/SQaf8DEJdHNuu4hlYnJ9G5vL5AWKqNYJzZnkvuyncbRVgzxGPt/J6Yx3idXzGm8etEbyq/bPXliQnMWCngkN20rQCeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hh8QWVRf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hh8QWVRf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741631400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lii5EujfPvNNsPbeqiE48YpxIfm/oF3ZDpwp8hB+9VA=;
	b=hh8QWVRfARE2pVu0wSfr9qUX0qTMgm6RM02DTFn6ztWihbx3r/inz4dspRpj4nTbp7huL0
	xQDHGL+8Kv+AXZ+A20mpV2Z3AxYmj+Zq8NMe2fmKrpKNpkSjNpKZXK6nD/otmsArrIDODm
	jwOjrAELZdfvaPzwx11H4/KDiugCBq8=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-Erss-XWQMLGu3mFFF2I4jA-1; Mon, 10 Mar 2025 14:29:59 -0400
X-MC-Unique: Erss-XWQMLGu3mFFF2I4jA-1
X-Mimecast-MFC-AGG-ID: Erss-XWQMLGu3mFFF2I4jA_1741631398
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3d05b1ae6e3so41460945ab.0
        for <fstests@vger.kernel.org>; Mon, 10 Mar 2025 11:29:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741631398; x=1742236198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lii5EujfPvNNsPbeqiE48YpxIfm/oF3ZDpwp8hB+9VA=;
        b=A+/jW9vQvpqdVPzZKLkNw1NQ6xwNyITgFm0PE/YEwrh64jpAE4M2hWbvlRox/I+j40
         lgZKmlCLS3SfgyjI1WPL7eD498H2cbAI8vbC3zOn18XJQ2g/jueGH1mA9uvLSQbpBgRI
         NWoWvkGsmKQnL5/k+AZaNPvo9QSmQboNamqb7AagV3072CntSeVM7rDmVlCXnf7d5ZuQ
         +RES9GihjQBkSwwbQ6siSEQrXv0tJrXjCQjfXx1ttfYAJR5CXNmhCWjZfIPJgcRkSgPZ
         z6zvz0laB+Wp20Wu1V7RR3HGxEHO5DdatQqnkOhxL2ZphWN1zfKmX6ga1AlTC+bJDK9U
         4W1Q==
X-Gm-Message-State: AOJu0Yywt7S6mC4wzYD31Ld01V6VFCC0P9KL3Iy4t8KntZI5FDanJui6
	j/4vp3pwZQraq7uUYn482YP5e0kUddqtXn9jFUUaruynSWWBpoBo+h49/sevDyeyGbUnAkVJGQP
	aMfNB60v0Glje4ORbMVj8xY3kXuX7GAleLu7MyiYyffmTe5Q3Pny9SnOFPn8hlkflVvyMq1Nd5X
	FBm+JeaSDrRYDijVqaN4esT5D5QS3F1mO3sMexpCnC
X-Gm-Gg: ASbGncttuyENXxK+/0xltCq3qF6LwMcJ3r28z2ipVptywuhvis4bFQs33F3xMiqfbno
	v4jPdSF6zo64Ye7LjSnmg3820eDDgexPUoHjoWEmeEK/Le/FT8+ArjVbSax4jsdEnA9dnQtuSkR
	g7PWalVFMMdSytEgJ8uCshM8jDJhQdkV64/UNBYeuW8WLxjMa000yXfxAVjJ2FGsajLYRvMYfb6
	FbXfwboGFbvtUH9P/qrPwR2vDq/ZkPCuG8zSXbr23DuDURfc5ldxY3jzd5+AAxlm80ruEO3RQqk
	RgcY8+E4sEo9z82htz+zUTaRQnLXqgY=
X-Received: by 2002:a05:6e02:1b0e:b0:3d3:fbae:397c with SMTP id e9e14a558f8ab-3d441a071a2mr119586385ab.17.1741631398248;
        Mon, 10 Mar 2025 11:29:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRxzneOY5qszBxNnfIDpMV8qhIfn5u0R0LNOOwytoCPZkw3codr1LjCBPKsXNeEkJVwAzvJw==
X-Received: by 2002:a05:6e02:1b0e:b0:3d3:fbae:397c with SMTP id e9e14a558f8ab-3d441a071a2mr119586205ab.17.1741631397859;
        Mon, 10 Mar 2025 11:29:57 -0700 (PDT)
Received: from fedora-rawhide.sandeen.net ([65.128.97.82])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f222ee2efdsm1587512173.13.2025.03.10.11.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 11:29:57 -0700 (PDT)
From: Eric Sandeen <sandeen@redhat.com>
To: fstests@vger.kernel.org
Cc: djwong@kernel.org,
	hch@infradead.org,
	Eric Sandeen <sandeen@redhat.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/7] fstests: enable sparse checking with make C=[12]
Date: Mon, 10 Mar 2025 13:29:03 -0500
Message-ID: <20250310182954.1396724-2-sandeen@redhat.com>
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

Enable "make C=1" sparse checking when files get rebuilt. To check
all files, run "make clean" first.

Enable "make C=2" sparse checking of all files without rebuilding them.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 Makefile           | 14 ++++++++++++++
 include/buildrules | 19 +++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/Makefile b/Makefile
index f955f0d3..a48d8d62 100644
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

