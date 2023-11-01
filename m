Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4628AA28
	for <fstests@vger.kernel.org>; Wed,  1 Nov 2023 18:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPwy5vP6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D34C433C8;
	Wed,  1 Nov 2023 18:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698862637;
	bh=4vPFVnWstkhzW5nHrdG6MlQDLAG5nuuT6qkINzznnos=;
	h=From:Date:Subject:To:Cc:From;
	b=JPwy5vP6asSxWrEoQuKsCRCVIEPkmnM7Nd7eKu1kz7RqmgGoeDZjVTZFKUP5qX5US
	 rgTy1bsJ4lZ3U3Qg1OrFYdG/YR65gHFW5kKV01QsuWiFObNDUdhrE7rLjVJJ1v3pyc
	 VH47Gyuku7TLxek8OptUsa9LcdJTHw/JQJsxEc3jgUZVOMo+NYfuKsYI5JcZh+3sOZ
	 dkqrWcGe21t5trMwICwaI9Uzhoy93x7V6BivcvsJKtIik49TqUUi6m40RWLdyMAokG
	 J2ojKxgkLeqn6MAaEBEu2G12tt7Ce4K+tRePCR/fhDLJMib8owKK332vHvTklieq72
	 fdUStUFsekMmg==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 01 Nov 2023 14:17:13 -0400
Subject: [PATCH] generic/732: fix mount option munging
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231101-master-v1-1-08bbe2f83307@kernel.org>
X-B4-Tracking: v=1; b=H4sIACmWQmUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDQwND3dzE4pLUIl1jI4u0NGOD5FQzszQloOKCotS0zAqwQdGxtbUA4Wf
 Uz1gAAAA=
To: fstests@vger.kernel.org
Cc: Yongcheng Yang <yoyang@redhat.com>, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1109; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=4vPFVnWstkhzW5nHrdG6MlQDLAG5nuuT6qkINzznnos=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlQpYsUvT2318FcLUEQ7OLAn6Eh+d2Iwfdv93q+
 JKV4ZmAWz2JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZUKWLAAKCRAADmhBGVaC
 FXtCEACmCnKP1Zwki+43Azc3fEEbQ4e+PAW52hkfT1chjbNhelnehw5FRkqosoUGcm5RHn32/jV
 9qi1yMm5liwHc8Y9W6sSqBulnUpz8dE7wUCxGif24f8b6yQCLJnOkT3M3kJsXmByIH+XGWwuDib
 WKiLEoKcApJDhD1dNyJWkWvmi0QGLjNgzG6vHaTKEKgOGkIDhIlG2hDB8TM8X6f4a1OTtFYU3k8
 fofPzxOy2Ni0/tGd0nx5QL+MloGfreQS5t9Jglf0P6QXc7z1OitAhXffe/g9q+uln1dALchIEgS
 JzDJ815N7TxIEAUNK/KHqoaemUaGmvMhvQABmvpRfb7cfuhdFOFl7qDb0mnx0Px9fpYfCQpHgIx
 zONwD3RW2RjSq60tAwSAt2KrkH+EXed5/7j6nEYjKe+wXhPHTL/NObIcvhcKDDPWm6dc2QptXg7
 3jKFDn5MegELT2Jrf2MAesewhPEYon9MrZqtjYIUZW+xfSM8+h52sTRCzXIDQIvwcybNAfIZ5U7
 YWLNJ0iYUoWasKguID/xwO6E3sJ8T275vfAbHWamiEJ9TGQhPrP/f1Wc9gBFjeKArjCWCyowcFB
 PM2Za14fWo2gmNqQAOdn5wy4uE8oM/EZoMPCdGwP42f8hO8X3NzwsIsxh4YCcERn2mmGwTZd4Ps
 Gl3TTuXwXYMsOWQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

With NFS in particular, we are usually testing with some mount options.
Ensure that we preserve those and just add "nosharecache" onto the end
of the string.

Cc: Yongcheng Yang <yoyang@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 tests/generic/732 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/732 b/tests/generic/732
index 785aac58f361..ae49152e42dc 100755
--- a/tests/generic/732
+++ b/tests/generic/732
@@ -40,7 +40,7 @@ mkdir -p $testdir1 $testdir2
 # Don't share the data and attribute caches among mount points for NFS.
 # This caching behavior is necessary to reproduce this issue as we're
 # checking the alignment of each mount point's own unique cache.
-[ "$FSTYP" = "nfs" ] && MOUNT_OPTIONS="-o nosharecache"
+[ "$FSTYP" = "nfs" ] && MOUNT_OPTIONS="$MOUNT_OPTIONS -o nosharecache"
 
 SCRATCH_MNT=$testdir1 _scratch_mount
 SCRATCH_MNT=$testdir2 _scratch_mount

---
base-commit: 59299b65ac8f15935ab45e7920cbfda8a6beffd1
change-id: 20231101-master-328ff30ce66f

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>

