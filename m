Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D322025484D
	for <fstests@vger.kernel.org>; Wed, 19 Mar 2025 10:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742381860; cv=none; b=kB3xo5xnyr0N2rM+8dlhT5rUDL7gG9Prm6uwG8nMDqapf1ICB/HDqYcEWGfs9ymrFTmYBr1tmodGcGaCvl0CwTvhYIAu3BZbe8aRO11+gkgkvbUIAlQ/p2OZV1cy/TBea+3Mb9mdBokEIWe2aCS04pEe1OJYw/KS9EocCM3OkTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742381860; c=relaxed/simple;
	bh=wyY+oetOYDPuFeWad7tOx7yjjWVdCVPzmfQnkXLBoYM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lt+vn8gN7SjkfflOuf07psMDSpIK+t1WVkjX1h6xwBGLaL168sPySe/nyPsSmFNXPezKiNCZDgn8wfp1yCeIBXNM9uevkwwjs43Gw4zfdf/9Qk/OjE2CtvQGcBYPhYIynRakr2NXB5Uch0TGnDr0TWJ0HW6O5LTJoIMsucUxj2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N1LXR0gF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N1LXR0gF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742381857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iDh2G25cDrqSFxGejdnMGDPJkuorNI9XTWy2sSoHYFI=;
	b=N1LXR0gF3H7t07Jms5Ma6ZXfrwO2T6LY20ZCz4lWOfKJQ4yKki3XaXj2BuJyRAXKEq7/7+
	a0EUeqN489kspA+vYVMD8KIrpp4OFIAuUzwwGgZOsOkWdjPvVbob9wX5rZU5j53TslW+/W
	8elrqfw+t3BPEr6gI+OtreIwtGk0y7g=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-uwEeClkvMfKRCtVZAbF4KQ-1; Wed, 19 Mar 2025 06:57:36 -0400
X-MC-Unique: uwEeClkvMfKRCtVZAbF4KQ-1
X-Mimecast-MFC-AGG-ID: uwEeClkvMfKRCtVZAbF4KQ_1742381855
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5e636b06d34so3929813a12.1
        for <fstests@vger.kernel.org>; Wed, 19 Mar 2025 03:57:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742381855; x=1742986655;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iDh2G25cDrqSFxGejdnMGDPJkuorNI9XTWy2sSoHYFI=;
        b=W6cAvEpUbh+MRlp2HT2n3Ju3DsbsLhZ33tMzCMYkU5Sb5XnaX5N0t+D56u7ASBfMuZ
         /8P2mJ15HuD1srFigi2vVJBQvUQ6qjrkmyTmpok73xntnmckgA6AC/nM/guP4fFfjde0
         MFdkolHPKY2lwLAm476Bjo6vt1hrbzX5pamtQqVlYXkysVQS77inIyqfsEwfwQ4g3BJm
         u0BRz2OTkxJaqe8Ujr+hNz6JD40QdHRC8WqD33w89Ux5xXuQdsnfVoml/0lekqerEjtk
         P9w/7c5imAt7erHFlKf5YAr2y/Qf59q4Pil7fK9ruMVgufKHeGCWLKMHHTHugrs9dj85
         NnkQ==
X-Gm-Message-State: AOJu0Yw/PJBsyc9S3s/hkMhUphh92vavgkSSVBuQvIn1IpmNMPQ68Ouh
	I/NAqP7+Y+L+HRNpCdqv/USKKJ+qsdUs/otmjAIY0RIHlLn4zwyiHNXk7frzvAk1eCBP2BUoxs2
	B/QgSLAkaJQu+PjcTmrK0Onr+PrhhiGvfW6MmF7bZfol5JQa7dscAUgSJgJARBQ==
X-Gm-Gg: ASbGncvAg1VdjAti5g1gHByt1l/+2K1nfvb4FLovByISHeeEKMWOOa+mrxC1cY3UQgK
	9xZ9TKYcF/ZYiezWphQdvkxxl/L41a1CETwPRubV6i1T+oaW3r/HWltfcUtoMGsvtfV7byVKDQH
	pF+Lv/3wBnnujlUGWVOaU4lY+HMdJlpqDCybi1AghGhxHVJEIyfAezTgvZgD+3EEUypR/Bah6g0
	3ZjoC91MfLAIjBJwc004O9rns78NTBKI10HTfeVunZGLNP0hI1I6axfg5QQLScmINsh5cbSDHC+
	fI31q4LtQQNFVr1cnrdesipkzudmr+pkRBPZshrWaw==
X-Received: by 2002:a17:907:2ce3:b0:ac3:b12c:b1f2 with SMTP id a640c23a62f3a-ac3b7f58e9amr206370166b.35.1742381854602;
        Wed, 19 Mar 2025 03:57:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+unE+cSnn5ri/XC/BpamEegJX9z98cSfZmnySMSVti5hTcf7tS5fyE3ocJChuFUxwlJt/Bw==
X-Received: by 2002:a17:907:2ce3:b0:ac3:b12c:b1f2 with SMTP id a640c23a62f3a-ac3b7f58e9amr206368366b.35.1742381854079;
        Wed, 19 Mar 2025 03:57:34 -0700 (PDT)
Received: from [127.0.0.2] (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3149cf10asm985433566b.120.2025.03.19.03.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 03:57:33 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Wed, 19 Mar 2025 11:57:33 +0100
Subject: [PATCH v2] fstests: update missing gitignore entries
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-update-gitignore-v2-1-a77183931c15@kernel.org>
X-B4-Tracking: v=1; b=H4sIAByj2mcC/32NQQ7CIBBFr9LMWgzQFlNX3sN0gTLQiQaaARtN0
 7uLPYDL95L//goZmTDDuVmBcaFMKVbQhwbuk40BBbnKoKXuZasG8ZqdLSgCFQoxMQojOy29lkb
 LE9TZzOjpvSevY+WJckn82R8W9bN/YosSShhjOmtvg/Ntf3kgR3weEwcYt237AoGKeaOxAAAA
X-Change-ID: 20250319-update-gitignore-60420f206207
To: fstests@vger.kernel.org
Cc: Andrey Albershteyn <aalbersh@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=944; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=wyY+oetOYDPuFeWad7tOx7yjjWVdCVPzmfQnkXLBoYM=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIY0m8tlnUO/bul1XbhldI8zqDTehLT4173yBpMX5Gz4
 vV9Z7UHtts7SlkYxLgYZMUUWdZJa01NKpLKP2JQIw8zh5UJZAgDF6cATORkBSPDpttSB2yevjut
 9G/ZccZ5bar3Oy91PeHZFJ7mbhrcf2v1Sob/yZ5GT0ob88MSze492+C4uPnrXMmy6+rGLvWiM29
 k7vvICwDxLErs
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

Add autoconf backup files (file~).

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
Minor patch to update gitignore autoconf backup files.
---
Changes in v2:
- Remove sources compiled into other executables or removed
- Link to v1: https://lore.kernel.org/r/20250319-update-gitignore-v1-1-6664aab9df35@kernel.org
---
 .gitignore | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.gitignore b/.gitignore
index 4fd817243dca37715d9a6ca52afa0f7fecfabc64..cce0795ea81878e88957324377b81051905471a6 100644
--- a/.gitignore
+++ b/.gitignore
@@ -7,6 +7,7 @@
 .*
 *.state
 tags
+/*~
 
 /local.config
 /results
@@ -37,6 +38,7 @@ tags
 /include/builddefs
 /include/config.h
 /include/config.h.in
+/include/*~
 
 # quilt
 /patches

---
base-commit: d71157da4ef4cfdbf39e2c4a07f8013633e6bcbe
change-id: 20250319-update-gitignore-60420f206207

Best regards,
-- 
Andrey Albershteyn <aalbersh@kernel.org>

