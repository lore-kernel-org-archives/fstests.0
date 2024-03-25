Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA9613BAEE
	for <fstests@vger.kernel.org>; Mon, 25 Mar 2024 17:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711389209; cv=none; b=dJT0l/Mb7TtidSz+o13D9GW042jqP4Evv4iZpzvF13yuDR9pr/LdKR1yY3SrzK6FQxT2hBC8JpyL7M9lzhRTvs5eApcNGKiMGsy7Sd9J6eHTu9DxtbrK/0RJKjai4zY6VcDxennEOvejNtFE7cXomuXU9/OJOtWLyuq3F5XRu1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711389209; c=relaxed/simple;
	bh=yzuRaSeVNDrtHUTtohW4RiGLWmG/WndsT8xLUv5e0yY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SGVr7R96o7wWh1sPXqSVdA+EzYSziHMsSQoo8rL3bj1jM+cL+cfm6V8VqbHc+WeZ5TCglEzPtaL2CULNrzZIfVTh6RzMvDg18j3GJSpDkE1imhWnLQkEq+QIfr2SzycDcZFxR2JCWVxZQBi01FTBCRdZScC9psFBSR6OMdj53L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AiyMX9FR; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AiyMX9FR"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c3acf4b0e1so2782094b6e.0
        for <fstests@vger.kernel.org>; Mon, 25 Mar 2024 10:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711389207; x=1711994007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8yudVExsSO0v4/Uhyk92Mp7juDMmYJymo+0w74U5J3Y=;
        b=AiyMX9FR1WwtxWD9L62ev9CKLM26w0TKEJ9byGKTaYXYDldDTEkUP9c99eWFAn6/Qr
         YHdsKQM7GLEWJkLmrAKgQJ9mk9j1kcFT4YDstKdv1YrKZ71AXtfipicfauG7N4dDSOkC
         lGSTu/GnSMIUnGOAO4QSHKPOUG/94xJnX59b7k0Fs3OzVPd6MiOPtvHVVM8iGB4v60gX
         rqIyYhgd5iFMih8P8xidc6mzRqrAqMfSyzeUrgxADSbHTQZIUwi1QISGSe5JCpfu2aLr
         t5Sb/txLr6CSuD8V1zHd/inrr+my0RAHzZa4kksUicwFNPIzwlpdcdR249zs4jKZ/1vh
         yiLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711389207; x=1711994007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8yudVExsSO0v4/Uhyk92Mp7juDMmYJymo+0w74U5J3Y=;
        b=kYFQPnadV2cT3ZTTmSiVcebSNHVQNf9OXWCwnzY/RVaiGVD3ny9A+N/PISZvv8D7Cu
         Fjh7+U/bNa8xhOueYKbHkT8DBeq6jN5RAPuVcQ0P8yoCTdZUUZeKIDN/AQzIqpntXOVT
         uNrdc2B4ypcYXJKHOMlLfnscDPVe/Lw/eEBORMtTJxQuG7egUj1SPfcvI3XsahbOplWq
         i//+Ihf4KqfmpUYUSy9GfGopqeAAdhcb3htcugCbP3AQsk6gYWIV67Ewg8VVaIpREmzD
         rjIzgil3Lak4DrwEpml9VsH9zDsoRf3SSlOYIEPU1yGQbtoXgWrOY6z24rGfrN0XiGd7
         NMow==
X-Gm-Message-State: AOJu0Ywqb+6VT9zTBZjgk2WfTlReLeBKsqe06NqMm7gHqX+IlcEWP2k7
	yEq2GdQNEx6tE+r8Iq7KZ18uwOPyuYGWHKcHPVNDjxYj9FHGiJd7+wsZ0ACG
X-Google-Smtp-Source: AGHT+IGr4+phl2knewM5zwrSsMyeiv90v8P+S4jBAKdyBd6O4a4LClr80faMk8Bcr1UYxNgR5hz5NA==
X-Received: by 2002:a05:6870:4609:b0:22a:4b13:6786 with SMTP id z9-20020a056870460900b0022a4b136786mr2489822oao.7.1711389205519;
        Mon, 25 Mar 2024 10:53:25 -0700 (PDT)
Received: from apollo.hsd1.ca.comcast.net ([2601:646:9d80:4380::5eba])
        by smtp.gmail.com with ESMTPSA id z5-20020aa79e45000000b006e641fee598sm4513867pfq.141.2024.03.25.10.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 10:53:25 -0700 (PDT)
From: Khem Raj <raj.khem@gmail.com>
To: fstests@vger.kernel.org
Cc: Khem Raj <raj.khem@gmail.com>
Subject: [PATCH 1/2] include libgen.h for basename API prototype
Date: Mon, 25 Mar 2024 10:53:22 -0700
Message-ID: <20240325175323.3450750-1-raj.khem@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

basename prototype has been removed from string.h from latest musl [1]
compilers e.g. clang-18 flags the absense of prototype as error. therefore
include libgen.h for providing it.

[1] https://git.musl-libc.org/cgit/musl/commit/?id=725e17ed6dff4d0cd22487bb64470881e86a92e7

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 src/splice-test.c                   | 1 +
 src/stat_test.c                     | 1 +
 src/t_ext4_dax_inline_corruption.c  | 1 +
 src/t_ext4_dax_journal_corruption.c | 1 +
 src/t_mmap_collision.c              | 1 +
 5 files changed, 5 insertions(+)

diff --git a/src/splice-test.c b/src/splice-test.c
index eb863673..7b7094f5 100644
--- a/src/splice-test.c
+++ b/src/splice-test.c
@@ -11,6 +11,7 @@
 #include <unistd.h>
 #include <fcntl.h>
 #include <err.h>
+#include <libgen.h>
 
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/src/stat_test.c b/src/stat_test.c
index 95cfdc4f..77e1acdd 100644
--- a/src/stat_test.c
+++ b/src/stat_test.c
@@ -4,6 +4,7 @@
  * Written by David Howells (dhowells@redhat.com)
  */
 
+#include <libgen.h>
 #include <stdarg.h>
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/src/t_ext4_dax_inline_corruption.c b/src/t_ext4_dax_inline_corruption.c
index e1a39a6c..a40c5df5 100644
--- a/src/t_ext4_dax_inline_corruption.c
+++ b/src/t_ext4_dax_inline_corruption.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2018 Intel Corporation. */
 #include <errno.h>
 #include <fcntl.h>
+#include <libgen.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/src/t_ext4_dax_journal_corruption.c b/src/t_ext4_dax_journal_corruption.c
index ba7a96e4..53be10c2 100644
--- a/src/t_ext4_dax_journal_corruption.c
+++ b/src/t_ext4_dax_journal_corruption.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2018 Intel Corporation. */
 #include <errno.h>
 #include <fcntl.h>
+#include <libgen.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/src/t_mmap_collision.c b/src/t_mmap_collision.c
index c872f4e2..d9315fcf 100644
--- a/src/t_mmap_collision.c
+++ b/src/t_mmap_collision.c
@@ -15,6 +15,7 @@
  */
 #include <errno.h>
 #include <fcntl.h>
+#include <libgen.h>
 #include <pthread.h>
 #include <stdbool.h>
 #include <stdio.h>
-- 
2.44.0

