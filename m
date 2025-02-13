Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6926245035
	for <fstests@vger.kernel.org>; Thu, 13 Feb 2025 18:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739469991; cv=none; b=lh3l9/iyVlJnUgoFyomI+giwDaENyO83Wej1IFy/07b4FVQTgxVYTetq3C9awzAre5f+ThgSJiG8n1OltU1WAoXt5cmlg/QccF/NVwpM+BVYDeiQ5EGlwY2UFnOyPFohtAvySjGkgZp0rSa4n6sRPa7vAr1HDOVGvPhTmfCrCGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739469991; c=relaxed/simple;
	bh=SepH8MAM7vnZ2Zqh1YjcaRNe7SM5Ub4iYWL9fKwSW+E=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=FH0NrsJ+N6hIUjVa+rr15YXo1i0AvtQfsPBinUTkqQW98R+J3YQXitP3PRRtZoMmaZipeFNKjE/HUkG2ETGWXRJaTBoVSj8dq4fL2tm1MCBNqh5dcp9df6ZYuEtNEuvMX184QlQ6TOaNzpsM+K07iGHshCdUAc+QiEl1LuNQoRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UCcJT5W3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UCcJT5W3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739469988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=STq+EIdOrmoWc2j8I+g5iYJUpt+ujYU3Enho6Jo/i7U=;
	b=UCcJT5W3BVa0g1VWXNEE+SteolTzNFh5N/8Ry25GL2SHQ7m8tWXA3TDlctSUgld+BBIdY4
	vaFeM7uC0k3gprAnuSqv+p/SomW77GmKQZY+d9ShfavmcgYEsl1P12cdAMOkAR1UNt/x3x
	005+nv04PWMDVoeLyybv4SMCQCQvctE=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-Pq-12QLSNqGMBx_JFgZWFQ-1; Thu, 13 Feb 2025 13:06:27 -0500
X-MC-Unique: Pq-12QLSNqGMBx_JFgZWFQ-1
X-Mimecast-MFC-AGG-ID: Pq-12QLSNqGMBx_JFgZWFQ
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-72708ff1a5cso17182a34.0
        for <fstests@vger.kernel.org>; Thu, 13 Feb 2025 10:06:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739469986; x=1740074786;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=STq+EIdOrmoWc2j8I+g5iYJUpt+ujYU3Enho6Jo/i7U=;
        b=I1YGVn6pN/+MV5EzGMt7UnxsA5Sl0eoays/lJBg6EVrt0xHhIitCIVP6dyQXQ8aLtB
         yFhz80s5kvCv13YGPJ9D3ZNDmmQzss54BHoszhdSF+ApjSb7RBb9R35natxYt/hlwebO
         N4Bx+aEFB48f1DjjNzGjCVYkM2z3xydQybNvOFuovqR8zBMhszLMoSg/xpi7KHAQzA0z
         p7QDh9B/oKg5IZoC6tsVrwEybBI8GJ0lKjPjl0wzu2dptshs8DQibgIqzDn4rfb3dI6h
         zYrNaQ+f8IsEQXyl9+xFfdar/kiDaDiE1J16Qa4pKRPZoarJre6Wl/cJef0bYHG0ZhVS
         BxWA==
X-Gm-Message-State: AOJu0YxJOt/LogsbhX3CvrQdc3k3bQCK5iSqDL/g0g1OlqTWrplvF04l
	5HYch7FMz3ZIb8Xpbo+iW0e039Tv7WKLXeaumCc+iptIoQ+Fzf4D6G7sJ8zqFETAsCaP3Il389R
	ialMR1Mjnduca+n/yjhUcSAeX1G9deSmBGRge50gXBSLps11NmzwwOCKJzguJhXTl5rB0kjhFV4
	FfBJ9NNiwQQOO1APojt4yD17e1aGmYYw8/Kq3l/m6s
X-Gm-Gg: ASbGncvxZ6ktHFgWgU5TdUh9949RVJ4BUp2LL7O00l+URNroEu/QCkxbGe6OcyGQc1z
	4jWxhAtsN1312eH+0fYhMKY0D1s6w7OvndxFwKe/bbU7VyKpt0lVMgUOH/eZtEczvHol8yQDBNp
	bhmlop4y+nDMqXIWqfZNQr5YYe7FlEufLScH8U26WQKGDbOOwq1degyqqSYfy47OAN30T2paKVc
	mwm0y5YLQ527mOH64jFsi0bThQkOHwLY8U6NCftoroMbx4GAfUykVmCq40LMQQnwM6W8GFE+thQ
X-Received: by 2002:a05:6830:6a12:b0:71d:4105:4053 with SMTP id 46e09a7af769-726f1c3655amr5228615a34.5.1739469986314;
        Thu, 13 Feb 2025 10:06:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEfNbAjN/Dme9yAJiNsSFv9hsOaAFPPp/a7kLy53lwx2n2pnuwZ81RZFj0HO5gLQ/sH66fR9A==
X-Received: by 2002:a05:6830:6a12:b0:71d:4105:4053 with SMTP id 46e09a7af769-726f1c3655amr5228596a34.5.1739469985912;
        Thu, 13 Feb 2025 10:06:25 -0800 (PST)
Received: from [10.2.0.2] ([79.127.147.88])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-727001dd0e3sm787436a34.27.2025.02.13.10.06.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 10:06:25 -0800 (PST)
Message-ID: <b4d76883-e58b-4db3-b7e4-7ddeb5ec7f42@redhat.com>
Date: Thu, 13 Feb 2025 12:06:24 -0600
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
Subject: [PATCH] generic: test zero-byte writes to new file
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

A bug was recently fixed in exfat where attempting to do a zero-byte
write would yield -EFAULT; test for that here.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/tests/generic/761 b/tests/generic/761
new file mode 100755
index 00000000..e933eb83
--- /dev/null
+++ b/tests/generic/761
@@ -0,0 +1,28 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Red Hat, Inc.  All Rights Reserved.
+#
+# FS QA Test 761
+#
+# test zero-byte writes
+#
+# exfat had a regression where a zero-byte write to a file would
+# yield -EfAULT. Should work on all filesystems - write should
+# succeed and the zero-byte file should be created.
+#
+. ./common/preamble
+_begin_fstest auto quick
+
+[ "$FSTYP" = "exfat" ] && _fixed_by_kernel_commit dda0407a2026 \
+	"exfat: short-circuit zero-byte writes in exfat_file_write_iter"
+
+# Modify as appropriate.
+_require_test
+
+rm -f $TEST_DIR/testfile.$seq
+$XFS_IO_PROG -f -c "pwrite 0 0" $TEST_DIR/testfile.$seq
+test -f $TEST_DIR/testfile.$seq || _fail "file not created"
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/761.out b/tests/generic/761.out
new file mode 100644
index 00000000..72ebba4c
--- /dev/null
+++ b/tests/generic/761.out
@@ -0,0 +1,2 @@
+QA output created by 761
+Silence is golden

