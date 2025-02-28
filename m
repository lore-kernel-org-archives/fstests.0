Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E8C1EF36F
	for <fstests@vger.kernel.org>; Fri, 28 Feb 2025 15:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740755606; cv=none; b=XBh5PZE2fAJUHaTgEkO82Pm513IgWHFCOEVd1B2Lp2yni55qCh3ifcO4K6JwDcyF9a7U19Mt2YjlAsyStwqC4iuamx2mbfa9KJhnOtRgnLL8lW1wKYBoamsBLtOhvMBPE3sPD0vrKEkFgp07UTpQD+rIvczPRYsSAzUM2q5n7m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740755606; c=relaxed/simple;
	bh=iKrcG10aCiZJEeKCd1FVCGbW+zIoFgHqe0lysXaY3f8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=QnAxxIS4yGGH/iQ4HTQI051Uu5AVQ3ZW5zZqxF2HIuj1TiObQ+BotXSsD6NC448IO+SSIU1Qq4ekbEdig0yLEngP4TnMmp4GuAIdKqSgH74XDWI0MM2Z5tOom/76bh2w5N+NMBjne28iYwGCgPYqtkgbPtoaPkwKP1XLNxjUwAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nax2K1EM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nax2K1EM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740755603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mD9Sf+66M986BAk7h4L1zWsXc36Y60fmqYc9pvEmo04=;
	b=Nax2K1EMmzYG7xZjxZMdr1BWjN63U4qe+Lt0+xFiidGOiLOPbi+y4cRfy4cHGwhYsuQfVQ
	okPNs+ote8sw+D72pfUCFSO3soKbzTEYp/FJk5vMlGggHPMhGGOgqUotxrJDDpTfUj9urw
	nTTfiSge4Et9UEDsqXz8pKkQKXcNpWU=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-94-1jSjjMtG7Ec5UL1zEEg-1; Fri, 28 Feb 2025 10:13:21 -0500
X-MC-Unique: 94-1jSjjMtG7Ec5UL1zEEg-1
X-Mimecast-MFC-AGG-ID: 94-1jSjjMtG7Ec5UL1zEEg_1740755601
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3d2a60faa44so46108135ab.0
        for <fstests@vger.kernel.org>; Fri, 28 Feb 2025 07:13:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740755601; x=1741360401;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mD9Sf+66M986BAk7h4L1zWsXc36Y60fmqYc9pvEmo04=;
        b=Tc5iDTgFEExwe1JXXOmU0h9fj4FLPqnUiMjyM5AFbfjRcR5j4bH37u0bQGYTL3Qbe+
         Qx99MG0kOLnv0ahAXRHMLyGO3p1GvOjuElm9VPtVJ0cRYyPULv7N7NmLhY5l+saL4n8d
         fRr0ESfzpBDh3Hv0oAN50/fbLrDQ6XngxezpiAr2wsK6i8oU39RghNsNp+8xzXLL8L0o
         fFVk9shO9Ac6wgMEh0QyEAR4fBCVGwLmeB8tBuEe4a1UUAeq97wsD3MjfSC8e8CZeFF3
         VQ1cSEnKkeiM83m8Lt3BG93PKOqPF2RdxWESmBLAHlhuVkHuRGlIMF+0AkcYJCjgzG4z
         AJ6A==
X-Gm-Message-State: AOJu0YyzFBk5nm781df8QsOrqF8CN90t6Ph+cmDL3enk98bCSL/Hcb8d
	ezGhogEUw6wgAQSx3dl0SNCpKKmugizeAVLxf8BGCqOKXkWqAzfbhPw/UHVBq0erlF9ax4QrAMa
	wUM97wjkX6uwlJa22f4EuHlpys6DCUApEkClfxbVhQaUFHgiuunfJvTDsqE3Ie3/yyvKXdNlIA8
	e2u1O8oMOpmWRCbjAH1FOsycy0Kvhg+KcpmBWa9ogz
X-Gm-Gg: ASbGncuLHmIkxH2jObm8D8ucw+Wz6o28d692UNVMPrjQdSG5Z76adeC8Q/dwsgf1iik
	ufpL/12/yNpqWtg+RmE/N47AxvhIbQTf/9i5/0tQyp6k7Y23jYJFPZzDxoVyMq/ZYMKZ1dBILEr
	cpCbPMGGVKTksIWXj/lc49BRBzLvtUfiknjiVPaXaqbMBbUOPkz6qEUas+0T3usR39uvPjsjxO1
	IKo00Vy0a0EcX7Dzey4VxHB5/u54hDiakWo8AR+LKpxKxSzOVe8UeU6lzVA0Sts/t4x9mEyH7zN
	+tkW4GIQTXIQx8hoZ4vJ1NgwyMYApf1GlsD1Y9dXfxG2+ZHm+cE0Lg==
X-Received: by 2002:a05:6e02:19ca:b0:3d3:e3fc:d5e1 with SMTP id e9e14a558f8ab-3d3e6e42248mr38283415ab.1.1740755600875;
        Fri, 28 Feb 2025 07:13:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHRCmlAihX9QKBSkKyhKbYoWfIuhaacBij8HOii8MxZ5nZ/adohZjLxVg/WxHWBAFF5TaA4bg==
X-Received: by 2002:a05:6e02:19ca:b0:3d3:e3fc:d5e1 with SMTP id e9e14a558f8ab-3d3e6e42248mr38283015ab.1.1740755600533;
        Fri, 28 Feb 2025 07:13:20 -0800 (PST)
Received: from [10.0.1.24] (nwtn-09-2828.dsl.iowatelecom.net. [67.224.43.12])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f061f790bcsm932878173.126.2025.02.28.07.13.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 07:13:20 -0800 (PST)
Message-ID: <3bd585ba-fe21-4f93-802a-f32f9e0f1c61@redhat.com>
Date: Fri, 28 Feb 2025 09:13:19 -0600
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Cc: Namjae Jeon <linkinjeon@kernel.org>
From: Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH V2] generic: test zero-byte writes to file
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

A bug was recently fixed in exfat where attempting to do a zero-byte
write would yield -EFAULT; test for that here.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

V2: remove the test that file exists, fix .out file and filter xfs_io

Zorro - If there is more debate over whether or not the file should be
removed at the end of the test, please feel free to fix it up to
whatever makes the most people happy. ;)

diff --git a/tests/generic/762 b/tests/generic/762
new file mode 100755
index 00000000..25eb88b9
--- /dev/null
+++ b/tests/generic/762
@@ -0,0 +1,29 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Red Hat, Inc.  All Rights Reserved.
+#
+# FS QA Test 762
+#
+# test zero-byte writes
+#
+# exfat had a regression where a zero-byte write to a file would
+# yield -EfAULT. Should work on all filesystems - write should
+# succeed.
+#
+. ./common/preamble
+_begin_fstest auto quick
+
+# Import common functions.
+. ./common/filter
+
+[ "$FSTYP" = "exfat" ] && _fixed_by_kernel_commit dda0407a2026 \
+	"exfat: short-circuit zero-byte writes in exfat_file_write_iter"
+
+# Modify as appropriate.
+_require_test
+
+$XFS_IO_PROG -f -c "pwrite 0 0" $TEST_DIR/testfile.$seq 2>&1 | _filter_xfs_io
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/762.out b/tests/generic/762.out
new file mode 100644
index 00000000..918f5455
--- /dev/null
+++ b/tests/generic/762.out
@@ -0,0 +1,3 @@
+QA output created by 762
+wrote 0/0 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)

