Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EEED2F5
	for <fstests@vger.kernel.org>; Thu,  1 Aug 2024 23:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722553480; cv=none; b=q1Rh73792aLOqkoWxJLbOyo3RqbTFml6JwG+6Eqj6skMbhUrW/aksSA65fZSmbVNkChTlXR3QToxsYOyb55DadpSwGLCIoZn2WWFp5icMrBBsOcQEPWIBOJuLHmQxAdG2KLNBCNETpTPd50Q+QULItDqG6M8r8PVAoMSOGWfIsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722553480; c=relaxed/simple;
	bh=TjgCVNbjtGyEqGzc+qgOTuKYQhhu9in12804mN3Stws=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CLUrbDVzlXqK1WM6nlHZ4cJYY3SKHAersJxSG5s12gri1q36ro0TqylJyOsVZlzk1Z7596AQfzdcvMl99gcMur/19Clm12BePW1UueCAQIyaUJyAY89xjaPfkG7rhCnhCa+mkUbUEWajLgCzLBjsBw/Vjs+ZB9R+rPLuVBOY+HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattysweeps.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4cMgR+hN; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattysweeps.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4cMgR+hN"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1fd72932d74so62416905ad.1
        for <fstests@vger.kernel.org>; Thu, 01 Aug 2024 16:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722553478; x=1723158278; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q5LVuV0/YrwCBPFranR61XzBv+thyRD8ighJPPsSX98=;
        b=4cMgR+hNXmKEXXTzhkglGWxpE4LrjfbJbW4YkPik7d2gUKo/IMSZY42kkaPbuPH2xE
         3sdK9t+2+8AJRAirokxjrqmgakA60esy13VADpoz3kbIq5WZCGspX9M2mcj1owb9mlWI
         MQdsMXw7QW3BLKkI82RSoxjzcC1xTz+XCekfS/JT0IzhSO/ocqQ0sPvE+KhqvrNGxYXR
         I7pb7vCbKt5CRmvVyRMoDyyS/h7eBbyRChiwoG20lJTgO43VEOn6WumCjSWfKH1EkUZN
         UNXkSEzQj74sfGyEn0sNSi6Udr4nkJx3fP+dPn5ZmGO6fkbJ+FQUor2N/P4UFgumg3fI
         aqhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722553478; x=1723158278;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q5LVuV0/YrwCBPFranR61XzBv+thyRD8ighJPPsSX98=;
        b=oO9iyTd3JYW4rrzU+TBvZ6fWt0kdQ114Tm9FDCnYqP3IXBchXqFWH2A48WVBz0fkXI
         u2490FbqIS3tAKAX0SSDNBAj+RPc2GEDSvbN7YkJ59sh5jS8/waMgRBsuT43tg4pWUOq
         jD+qILPu0oUokvX6VTe55CQSxtLa1tmTCqRHfnJa1DxprxwH+bivdgIFjmutVJga+91o
         /BO8vf56Jtg48MRd0jGvoFTHgaNOqUT3BYRmjTBDF1wBkeZCwXFEyQXmA+CaNx33kw1u
         kWxwBxx0knkWPmetAtTzt+yQPAo2q6Gvi0QHGDNxWf58Di0aB6qx6zqIOs1mxdIWNmIY
         D9gQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0eUtO9KBWiPVCz/1nWrDxaCO5PCBbM6PbbbmBb7uGO9zowdWob8h+dDd3pj4PToOQCHdgClHEu6HANlBw9UmkPEs4RRPsfQ==
X-Gm-Message-State: AOJu0YyHy4aWTQzLxrOPrrmm1wHAsY42X5G1J3eMTW8hCA2jFVcaIVtA
	pnTGyDOkPX841Wx1tdmdTRP2thPHtetnGJhGlH3OBSa2RLbU0t9kJsuV7FCrS4tFy3XNwtybsZk
	fg3jAgAobkZMegWJu/tsyzw==
X-Google-Smtp-Source: AGHT+IELjq/tEL7i5RUFG+3ARgJBP4gzwtazOQKajGxsKNNkvnF+adcdUKirESOeadEngzuQEi+7RKnI7yAqdqxTMw==
X-Received: from sweepsreloaded.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:5d58])
 (user=mattysweeps job=sendgmr) by 2002:a17:902:ea11:b0:1fb:a38b:c59d with
 SMTP id d9443c01a7336-1ff57404ea1mr29075ad.7.1722553477863; Thu, 01 Aug 2024
 16:04:37 -0700 (PDT)
Date: Thu,  1 Aug 2024 23:04:18 +0000
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240801230417.323994-2-mattysweeps@google.com>
Subject: [PATCH] generic/375: clarify flipping the write bit
From: Matthew Broomfield <mattysweeps@google.com>
To: Zorro Lang <zlang@kernel.org>
Cc: Matthew Broomfield <mattysweeps@google.com>, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When checking if SGID is cleared upon chmod / setfacl the write bit is
flipped just to make sure permission changes are happening. This is
orthogonal to testing SGID.

Added this information to the test description.

Signed-off-by: Matthew Broomfield <mattysweeps@google.com>
---
 tests/generic/375 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/generic/375 b/tests/generic/375
index eb675144..44670350 100755
--- a/tests/generic/375
+++ b/tests/generic/375
@@ -7,6 +7,9 @@
 # Check if SGID is cleared upon chmod / setfacl when the owner is not in the
 # owning group.
 #
+# The test flips the write bit to easily observe that chmod / setfacl are
+# successful. This is unrelated to testing SGID.
+#
 . ./common/preamble
 _begin_fstest auto quick acl perms
 
-- 
2.46.0.rc2.264.g509ed76dc8-goog

