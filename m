Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA84331A57
	for <fstests@vger.kernel.org>; Fri, 31 Oct 2025 09:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761902858; cv=none; b=TdWNDzeJT3PHZSQvX39tc6DoJHBG0mhdnW3mVEw2xPJM5F7wqHNTPxDHarwOU78Id6wICpMOb7+WXn9itEnORcEUvsb+AAXNneodpKL0IzPcJaDyd6bAfRD5FAKZD9LnBpij566aQC6UwgQ6HWcODZxLBUuHJ1wdrEP699f3tnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761902858; c=relaxed/simple;
	bh=Sjt2bbIMj/45CMvIEKVeWxV7LCZT7CjHFX9qRoe8Qro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U4zItCNIT+ZdN5FaDO3/ykAzXQC7ROR7vm8vwXNzrJtqpp6xzbREKvlyrigex+Lw7N39gTDaizv9lQCTl0F0ueF/MehkHfTRR19MG875MDMoa5YPQf6mE0FrOWKq6eD3jrYJYvOvuYmkz4Ax3JGnqwU+usnUh/EivM+mUyY+wWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CdFeZ51f; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CdFeZ51f"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42421b1514fso1241774f8f.2
        for <fstests@vger.kernel.org>; Fri, 31 Oct 2025 02:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761902854; x=1762507654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KPhLQNLAU1fbcq/av0fAljxMlBrL+NWqMpJWhcqFJc8=;
        b=CdFeZ51fZejcaQgYMisK7PJGbaJNsRkEooZ9iTAL3oedUN/3FrUGtAVTDXpTr63QI8
         NofoVKe/B/l01RsO2/2ngaItviBBOLkww9RwkCqPThT3Vc+ZGCzpM2B0Zhjrp9qa6KDt
         OALsAFbhMlE1zrIwm9FExwxrHe3UZQzH/LixefOPXHTag3T3DnqcXf4yI5Xv7XUDZ+gO
         VzpcYW+4YfncOEyumEC5W7Uu+Q3V5v9uHaOmdlRfoodh/4ZCNK4aT0OJoOTQNmE7/IAg
         f90N4Li72MiwPx/c5CMU/JC2LjZe8p7OdVPklpzZP6sYPv6HPRn/QFBEbkzHmq6PJkxV
         GGGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761902854; x=1762507654;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KPhLQNLAU1fbcq/av0fAljxMlBrL+NWqMpJWhcqFJc8=;
        b=F+xQhPPi6zb6cs8KfBs7OWGLd4XlcbNsxdP2/N0GFhl4rewi+7s8wALdZzzrFc3LOv
         fgeCHBHB8FoT9g/WeeHV3CzoivrB6PP5sngl7xZyi0sOxlHfvUBpQ6nZEy133fqU8uwu
         buAMcqA1N4KN0OF0B/1mNSelXTOAWQPlcDphqZYbywzZlUhqPhVnKqLcpyB+h4xoAw+/
         2EfL3FtYbHlYj/fNNF/T8OOGrhTVBEmB0Qlo1ujJwQWOo59do/oC3wSWt6qcCp2zz/nS
         eQYkJ4ZzSVFGiVHgY7JaZcIh2HQ4w0a/EuymW531NrEcEooun9r8UpCMvgyY/+8hJLNH
         QbuQ==
X-Gm-Message-State: AOJu0Yx5ZXVSBdXmKWPkBh5TWDNbot1eVMIx5CWswC2VNKdLxqp6iz16
	cJKKy3QsGtNrlp8xGAXY1BokMqROYnQpqi2NJz47s34XjDRwOQFwUPwtZmO4bYPE5rWh+nLo+dY
	XZhfJ
X-Gm-Gg: ASbGncv/kvBcjXOZFg2P9a8wMrB4bz8HZJUQdyH13TjSFMGnHu9tD33qZI9dHbXfjsJ
	e5By14fFwYeGT3KP3qESEHq0QSGfobZJKbFlyF3S0BpfcrdQ7E00u9Ff8XPYtjccXM0vU8WUF8k
	KFl7pgvzSM6yMt1sPn5o19TAom8sXqGC91GIL1LhZLfIn6swBw7nKKd88Z7hv9OB0CT6m20Ktjt
	VrXZ6BvRl6JvQpD/ObVBknJtuHxBxRTT87f0DZ3WoI9SUq6V9PO7wf3odczZbZ16q21KGD8Jwds
	4+89rLQrYsv5hJpS1tp7mQ4Yc8F34ADAViJPVidVZUnLYVxnd2zVBZCWQyXUg+MfDCQ6ZGRnmdq
	2WTAum3nQ4Uwu5K36r5zNgE2pn/fKsCEN4u+qliSija107Arc7HU6Ri3ZQfj5Ko5+CkQl5HxM3H
	PloSbSeg6EfoXMgebj
X-Google-Smtp-Source: AGHT+IFVvJ2jYF8HJW7cHmYf0ztxdJTW+WGyJjCb8O11yV5cPdmuaRROoFcWJ51ZC/1c/y4Ryapl+A==
X-Received: by 2002:a05:6000:4009:b0:427:a05:2ff with SMTP id ffacd0b85a97d-429bd6ad9dbmr2083263f8f.33.1761902854477;
        Fri, 31 Oct 2025 02:27:34 -0700 (PDT)
Received: from localhost.localdomain ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2952687106esm17137935ad.7.2025.10.31.02.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 02:27:33 -0700 (PDT)
From: Yong Sun <yosun@suse.com>
To: fstests@vger.kernel.org
Cc: yosun@suse.com
Subject: [PATCH] generic/270: replace pidwait to wait
Date: Fri, 31 Oct 2025 17:27:29 +0800
Message-ID: <20251031092729.73144-1-yosun@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some system without command pidwait run generic/270 will fail with
"pidwait: command not found". Replace pidwait to wait could solve it.

Signed-off-by: Yong Sun <yosun@suse.com>
---
 tests/generic/270 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/270 b/tests/generic/270
index ce515920..c3d5127a 100755
--- a/tests/generic/270
+++ b/tests/generic/270
@@ -51,7 +51,7 @@ _workout()
 	done
 
 	_pkill -PIPE -f fsstress
-	pidwait $_FSSTRESS_PID
+	wait $_FSSTRESS_PID
 	return 0
 }
 
-- 
2.51.0

