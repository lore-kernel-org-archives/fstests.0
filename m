Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFD02DC783
	for <fstests@vger.kernel.org>; Wed, 13 May 2026 03:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778642453; cv=none; b=oJ4Qy+co8ZG6PQE7NTVFM4Cdpbac2P41bmvE89vCkwWxLpGZLQuv6fa0XOdMDju75xQLxVzWOxoCtxIb346MGHAJmbmqJzQ0u+AeozmA1vgXAjdLxNdY8rz/9Hw9SsjmUIT9NnsVl8K29QjI0a7P9NK3OxPLYshmAuB9pRQBaNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778642453; c=relaxed/simple;
	bh=Oz5HOHSbdE4I3IfLtS22WaTtotHFsrCGwwkAoygX7rA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ik/oNmtORicCa4IL08R7u5lNVTiSBpDOSGbKvLZ/OB6PpWcbAfX1ks6L3h+xv8W+aA9UQzHyrfKL3YmdxMj+WyhHQubh3hsw6bQzXvbGmJblWOiooHMcJYRRukfXu3rLcswbvaW7qZNJnf5pSM11CX8zPCXnU0nM2oU2eJCXinI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joannechien.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wKHZi4PX; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joannechien.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wKHZi4PX"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-bce224720d8so3547204a12.1
        for <fstests@vger.kernel.org>; Tue, 12 May 2026 20:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778642452; x=1779247252; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cy+ToJ6n0jT+Y90zlSgrGRFufholfFQJCUMDaRqZ8T4=;
        b=wKHZi4PXqpXYltvjV7uLhLYleOLCBafrpI92IdxjUtva+9ao0BBS3kSTRESTY43vNi
         ybwLb3r5fcHWGYVzKcIvVhea1Y3edtMRI5FFwUb4b+4gafflOWJHt/0okQ2eOCL6K70G
         0hbYJzqVmfBDr0hPBZ0Txmji7Ngw7BGbnhsaDwaCWDfapuwuMJXCR4HKHPu16Iev1jvS
         vypBT7oRCUf12j1ODyqGiTkOOuT3VEel7ilTFsUCQpbyX79JtPziWytjRBBE9p93wq8r
         TWhlXOktIn3x04D3q7ZFIbKNyPxn6UxuNUG87MvesdWEWpqMhEvH562hi0NakiDYYB6f
         GmLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778642452; x=1779247252;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cy+ToJ6n0jT+Y90zlSgrGRFufholfFQJCUMDaRqZ8T4=;
        b=FgvNKJPF5ebTuV4oRBMAIRTKt/tKyRNEQsgtNU1WoQGOQOs6xU3O5C30QfKRq5Eoz+
         Xd7JfzIVV7M81+EUfK5VS6WkmlLcudordZMt7LTHRMBGiOqZ0ccEDfs6xEyTq7kWZAoO
         Myom5YK3Dt8jF7mhyy/sKBqwDUiI45+DI90Ga9oxdzrIbjC956Ll40EjewmgUygv13sc
         mZhRMelo7uXbywQaaW723O43sKDn2ng8dPEfyHMUwuHb0mf/XXw51c46M5zhjf4OIe+i
         iC8hbc4lfYLqSghhOwYG2eq0TWmvgfRlKOQ52b1Jhvqu6eHdvEL3lAGtFHnJ+iTOy0oD
         GxIQ==
X-Forwarded-Encrypted: i=1; AFNElJ/MQC/CVx0xzI/TrcvL5EIu2ZU+z4cl0dXkIBSAy2Y3PHBhkXc0AdxAeYZtVIaObQFmlrniyRJO@vger.kernel.org
X-Gm-Message-State: AOJu0YyAHtQLhHsRy+IIv+gOBDD120/Jr7JCw/uBliqn+ZIkiFuZzjoj
	T806qjzfvnNC1urr8Ri7XD302Mj9neCT8uo0nKHSCzxLBndZSeMq9jEiHFXF+9lUZbvtqhNSXGM
	dLIVX3JdyeFTwMOVSIn/gor9PbQ==
X-Received: from pgbfm5.prod.google.com ([2002:a05:6a02:4985:b0:c82:7df9:8c21])
 (user=joannechien job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:3950:b0:3a2:d989:2b3a with SMTP id adf61e73a8af0-3af7f875047mr1492585637.20.1778642451747;
 Tue, 12 May 2026 20:20:51 -0700 (PDT)
Date: Wed, 13 May 2026 03:20:09 +0000
In-Reply-To: <20260513032009.2300435-1-joannechien@google.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260513032009.2300435-1-joannechien@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260513032009.2300435-2-joannechien@google.com>
Subject: [PATCH v1 2/2] f2fs/021: Fix mount syntax for disabling jquota
From: Joanne Chang <joannechien@google.com>
To: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net, 
	Chao Yu <chao@kernel.org>, Joanne Chang <joannechien@google.com>
Content-Type: text/plain; charset="UTF-8"

F2FS has removed the trailing "=" in the mount options for disabling
user journaled quotas. Update f2fs/021 to try the new syntax first and
fall back to the legacy syntax if the initial mount attempt fails.

Signed-off-by: Joanne Chang <joannechien@google.com>
---
 tests/f2fs/021 | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/f2fs/021 b/tests/f2fs/021
index 0cacb138..70b10fa8 100755
--- a/tests/f2fs/021
+++ b/tests/f2fs/021
@@ -21,7 +21,9 @@ quotacheck -uc $SCRATCH_MNT
 _scratch_unmount
 
 _scratch_mount "-o usrjquota=aquota.user,jqfmt=vfsold"
-_scratch_mount "-o remount,usrjquota=,jqfmt=vfsold"
+if ! _try_scratch_mount "-o remount,usrjquota,jqfmt=vfsold" >> $seqres.full 2>&1; then
+	_scratch_mount "-o remount,usrjquota=,jqfmt=vfsold"
+fi
 _scratch_unmount
 
 echo "Silence is golden"
-- 
2.54.0.563.g4f69b47b94-goog

