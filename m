Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264971DE4E3
	for <fstests@vger.kernel.org>; Mon,  6 Jan 2025 14:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736172107; cv=none; b=WcizXklLJ9kbthbfoVvf19PYBsqtr8eNOJz66Rnw4mRe+pJ4RSUbmYIZixSPLDjJMMT0d9aOkW7F5/15BbS8pIK0WGk5nINfqYphJhUbqO0uY3zSiFyQUmh9yhm7Pv49+1xknjIw1bXunvJYDUBEK5fFzwNt9L3ElnlItbV8yQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736172107; c=relaxed/simple;
	bh=8CLu5T5/ZXNEEQadnXyb7W+lzjIG9jU7ZatkGT382D4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tcJwB0mQ3mntu9afZZgQctr5xqkDtpOahwzS1jz2kJ6sJQUCBnfzpVA6qehGg24Cb3owE2loSK/FIaO8C+oG21VYtvloovZJYR6trLIPKN399qNvPNiXTGsrqiEXVX/NhbzxLd1A+jxifRgM87NksHZfO9rKcKWQrtDUhDFXKRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZpWvZoBe; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZpWvZoBe"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3862d161947so6848715f8f.3
        for <fstests@vger.kernel.org>; Mon, 06 Jan 2025 06:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736172097; x=1736776897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vZrjYhLCiRn3Tt2/eeNEnVTraUXU06j8NKj9J6yad7o=;
        b=ZpWvZoBejFyvrjFiNt4HFZtN62vlN/MjJRDkzOBypzFPB0ueLNBpCHFg/15wchz4j/
         Vx3X02a/Z3+N1fMuG9LhI95/GWEwUvY0s1Lgz+fBd21TrQUP8rWxaZ8vO6bvwhEH5LEd
         YKKHbYMSJMpj5fFZwmp0p48pvgRNOlkIuPoPMBPd2CWHrbAZjOMHe/BkGtkOY6IVtTfI
         fkfZMFgGoq3yZ/BZa0Vv94VtDDbmhxmp1yjPuk0/mZpjbU8k45y6K3X7uUMdBFQWrqGy
         zaIClKc7nM+dsoooVG42Db2TIlUYkF7ijy5ANQslFS596fapVtPSHsXW9J+WDT5TsTt9
         VIag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736172097; x=1736776897;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vZrjYhLCiRn3Tt2/eeNEnVTraUXU06j8NKj9J6yad7o=;
        b=VxH4VbQgY+k4TcECwPIVziaSFxJeHHN82THijNBoV+E2s3K4UwpDKWIYk7ik8yNpnJ
         6LHK1CH89ncXQ2DVQyD3VKb2s405nkQfQk0/0OtoUg18SGahqF0AkPtNXpzWOitlYRf3
         W807PIm4sYswei+rLFqY+P20+TvALCyr3g7hTXsm7++EjWBXDuDINsP6LxX9rm+BNbm1
         FCH4s3eH7m3BZyHfjMOgxMkPsgO1OfACCka2vk3eeNSMijp+G9H35nZhde2I83kxxO4a
         xfCxzhuNjjOUedbR19+X669xRT9ZUXKzOWwIB28B3irVJppDeQJUIj547QyBGrdSLlgA
         8DfQ==
X-Gm-Message-State: AOJu0YyUW9zOZ0KlFcUD5qpeURC8TKINiHJ3km90fnhJPa6VPbJlscbT
	wRqome1POHQi9AO4+J364RcRko2iB0tn2+DtODbWwgsn5pnOzGrEr0uQ7ZChERGoKjZlAOuOHMz
	TXlA=
X-Gm-Gg: ASbGncvEP/uTlkioqFeWPpRRlQ+GIV91aYzVh1b8BJxpofNzMloMLUFcObq2f0NtTCu
	2TRsUeDUK91OBtkoh1BESghCycSOTkdmU7vdHmbbc+x1mz7+1lstAFbArCU/a8f50pHmMc6OQt6
	bhdNzcCw4MnEFmUE77dXAfO4A+KQ+JijeF/C1SRpKHoaahu4s1/8/R68Hwnm/eboGPG0VisOOo2
	lDeP1aCwlHdfZF3g5kv5UgZo4QFLRMK50Jh9C/1quLWReE6o0wh2OEM
X-Google-Smtp-Source: AGHT+IH+q+sj5LXu1ejTyCJXLQp0DM6JJ+q8LRi6VNoUBPz+sLvSxDc4MxT6XcIf0lJgxw2uEd4EHw==
X-Received: by 2002:a05:6000:2ce:b0:386:3803:bbd8 with SMTP id ffacd0b85a97d-38a223fef75mr48178486f8f.59.1736172097135;
        Mon, 06 Jan 2025 06:01:37 -0800 (PST)
Received: from MacBookPro.lan ([23.247.139.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac2bbfadsm1511804785a.15.2025.01.06.06.01.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 06 Jan 2025 06:01:36 -0800 (PST)
From: Su Yue <glass.su@suse.com>
To: fstests@vger.kernel.org
Cc: ocfs2-devel@lists.linux.dev,
	Su Yue <glass.su@suse.com>
Subject: [PATCH] generic/420: skip test for ocfs2
Date: Mon,  6 Jan 2025 22:01:31 +0800
Message-Id: <20250106140131.91946-1-glass.su@suse.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ocfs2 doesn't support fallocate with
mode=FALLOC_FL_KEEP_SIZE|FALLOC_FL_PUNCH_HOLE so skip it.

Signed-off-by: Su Yue <glass.su@suse.com>
---
 tests/generic/420 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/generic/420 b/tests/generic/420
index edd9655fd3a3..e67442f8979b 100755
--- a/tests/generic/420
+++ b/tests/generic/420
@@ -15,6 +15,7 @@ _begin_fstest auto quick punch
 
 
 # Modify as appropriate.
+_supported_fs ^ocfs2
 _require_test
 _require_xfs_io_command fpunch
 
-- 
2.47.1

