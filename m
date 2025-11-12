Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E8B2264A3
	for <fstests@vger.kernel.org>; Wed, 12 Nov 2025 13:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762955556; cv=none; b=kJosUR/DpdAsVVoO5PRJrscjVhJ65Z5xferC/nAxYC/haO1OTDxz11hy79326sRtTyl34uy09j3p6T1156Ir9xyxvnZWmyNEF5en459u9Onwp7SXdJWNiiMqVC3yzZVab1WP5fDB6o85Osn2wOeJf13LeiQw7P3PWbEGqWeEFOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762955556; c=relaxed/simple;
	bh=XacK+f/z/ZowWVgMhgDp0o4XT7Xyy1ABCWIHqpGAB1c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j3hS+LYz92Mei9UfsY/L4K94mi8MTUbeO9FL2Tw6zVTLyOO8vkHnKf7yERb45HFmxXGGqEw6TmYj7pgPIeQxcW98jIy+ccOOEM8zURE6daxIlZCVeHIubo6w05S59fp3+CcdSYCf7MPHBiXb7qt7MIT2KisZxaEq4G/DC4XsNME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joannechien.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l58DMMgs; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joannechien.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l58DMMgs"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-297f8a2ba9eso23559505ad.3
        for <fstests@vger.kernel.org>; Wed, 12 Nov 2025 05:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762955555; x=1763560355; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OENtFm3i817Weeec6gfeOIxaItbxpGoqMQTgjpOdTX8=;
        b=l58DMMgsjvnCWznAOMWw6k4fwgdjFQO79tAG/j9XBbcHyjDmqOu2merZlp1mxTttEl
         rUbw5238ss9sLJ9zSIcwJJMOG81udIxu1U/Gs13FD1wMuqFD4/YD3vQDd58hnSc6SBAr
         cMCBBK/tvzQ1ndrPu1t+SUsufnYyJXK8WS1l754PQ4s6EkyATi27ZqMH4ZPdBExgEgvL
         DeEdYFOYqUCeEAzPKL/f8759iIsC4GOZhNopU7dAQ/toKHthh9Akqv4thbMsf1i2hOlf
         jF3+f4kLwOVAQI9viilfa+0p/69feyJSgRbpL28bM6XZXbNa81kH6+OpkmPMrCYmK9FX
         Bk5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762955555; x=1763560355;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OENtFm3i817Weeec6gfeOIxaItbxpGoqMQTgjpOdTX8=;
        b=RTEkZkMLYX1Z77H6SvPhRIYn+q0O2PIzT5LZS5L/4bbLxXgY0jU4htLr2A5gk+NlST
         CqqDiLjwuWzoOSLiiRRwAZY2jAyZrKmTaIrBr4ewhHeu42qYv5e+hIIs7pzmLEkULkVO
         WS7sAmVkIitNwyFQN0b28I6M6DlEv81XCOfjgBlHfuEdrZgQAEJOZiRrNG54v7v0NrDA
         rK6U7Rg0bAoXKAjt/SGQYTCrJnC6U1zTbfJxKlk9yT3uPRGLooE1PQ7CXoPAkj7SDfAi
         bkytSQV4RTQndjuF9htTc6cx6NUZKL0Qvx0ytrxMrVqa42lQTqWvrkHlhORlvNIEYMgq
         oyGg==
X-Forwarded-Encrypted: i=1; AJvYcCWS/eoWakwDChl+wcSDByqYNqYUh/p0lkifj/8KZ/ZuzsRxAqPG4uHdPDgBlS6uvxgyM/tD4wPC@vger.kernel.org
X-Gm-Message-State: AOJu0YyIg9TtyjTmzyrJv+DKiaTGqwKBECikHOT3ndkYpaaEYFCtxlIw
	V+PCuRersrvC2HaJxf+99XoE9+SXhjRh60FMZHU41ZMJw1XwcK5kFPqiBttFkaO46KbhvFQWzBJ
	VDCM1SmkYeYPIUISS1QNjNtRJrQ==
X-Google-Smtp-Source: AGHT+IGYly76A9Dd808N0QerjHX/E1vUnUBAoo2QELTCdqvZDNN1bXjuebt9+R3/MPxan6OXBu1W5VVnu9LUrxpnQw==
X-Received: from plby21.prod.google.com ([2002:a17:902:ed55:b0:295:304d:8359])
 (user=joannechien job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1904:b0:297:c638:d7ca with SMTP id d9443c01a7336-2984ed356e1mr34439665ad.14.1762955554887;
 Wed, 12 Nov 2025 05:52:34 -0800 (PST)
Date: Wed, 12 Nov 2025 13:52:22 +0000
In-Reply-To: <20251112135223.3467852-1-joannechien@google.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251112135223.3467852-1-joannechien@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251112135223.3467852-2-joannechien@google.com>
Subject: [PATCH v1 2/3] f2fs/016: add test cases for test_dummy_encryption
 mount option
From: Joanne Chang <joannechien@google.com>
To: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net, 
	Chao Yu <chao@kernel.org>, Joanne Chang <joannechien@google.com>
Content-Type: text/plain; charset="UTF-8"

Add test cases to verify f2fs's support for different versions of the
"test_dummy_encryption" mount option.

To ensure test robustness, the MKFS_OPTIONS and MOUNT_OPTIONS are
cleared. This prevents additional options from interfereing with the
test results.

Signed-off-by: Joanne Chang <joannechien@google.com>
---
 tests/f2fs/016     | 6 ++++++
 tests/f2fs/016.out | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/tests/f2fs/016 b/tests/f2fs/016
index 800f75fc..a6df827d 100755
--- a/tests/f2fs/016
+++ b/tests/f2fs/016
@@ -35,8 +35,14 @@ options=(
 	"compress_mode=fs"		"extra_attr,compression"	\
 	"compress_mode=user"		"extra_attr,compression"	\
 	"compress_cache"		"extra_attr,compression"	\
+	"test_dummy_encryption"		"encrypt"					\
+	"test_dummy_encryption=v1"	"encrypt"					\
+	"test_dummy_encryption=v2"	"encrypt"					\
 )
 
+# remove all mkfs/mount options to avoid affecting results
+export MKFS_OPTIONS=""
+export MOUNT_OPTIONS=""
 for ((i=0;i<${#options[@]};i=i+2))
 do
 	echo "Option#$i: ${options[$i]} : ${options[$((i+1))]}"
diff --git a/tests/f2fs/016.out b/tests/f2fs/016.out
index a8c96972..5ff116a7 100644
--- a/tests/f2fs/016.out
+++ b/tests/f2fs/016.out
@@ -31,3 +31,9 @@ Option#28: compress_mode=user : extra_attr,compression
 0
 Option#30: compress_cache : extra_attr,compression
 0
+Option#32: test_dummy_encryption : encrypt
+0
+Option#34: test_dummy_encryption=v1 : encrypt
+0
+Option#36: test_dummy_encryption=v2 : encrypt
+0
-- 
2.51.2.1041.gc1ab5b90ca-goog

