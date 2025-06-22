Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1D81F152D
	for <fstests@vger.kernel.org>; Sun, 22 Jun 2025 20:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750624791; cv=none; b=hX4piOjL8K6nqGKKV7mXtfmNaPQHpWiMqPOK7Mu44NtNl+r/E2hTBKUzFKTtW419cflRGZSfMBPfGcwKPWOBnlNVLbk+BdbRQv8Gpub31jXg/JDY4TQFL6VNvNcsOa10/foE4D5dpZM6GcM5lFhvU/wSRaybpsDSqwG82b71vuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750624791; c=relaxed/simple;
	bh=sUw94w07kbr+rKNh811gI7OCOK57y6rvn9lMYxyrw+c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=b7UnjLYf8HcLCJDladKPdpzCtw5JtJBZKwQbUxAWsvxvZ+dUeqR3ElaDZo3OgifWoYwsErC+xO9LXOgaVvRaFe0KGnaG0eabUH9Tay7NfUCk8xZ1rCLgZKQ6/8Uui8pqruuHS2/H6nwWKNNsDt/7HFZIsmDkfd3BeuAEW3D5yPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BtUIiWtU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BtUIiWtU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE9D0C4CEE3
	for <fstests@vger.kernel.org>; Sun, 22 Jun 2025 20:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750624790;
	bh=sUw94w07kbr+rKNh811gI7OCOK57y6rvn9lMYxyrw+c=;
	h=From:To:Subject:Date:From;
	b=BtUIiWtU/j/lCK2+jJgNoLwuUT5fkOpGyJYn0eOJE/mGaa1ls8mlLeJAvmfKX7jyj
	 aq3bRj/7Y6MRL/8aX+2r+8hLFHmFQRFmsWv9AGFJD2Xsfeb0vLXHlbP72gYe7a7DND
	 aVgh/vl00yRYdP/C6kw1oYE7Qnz/pj4xRq7jjSq2VpLod41yxZ181CFAloRDwfMn72
	 KuA1hiq3t2MttU6maF9XSA+jx5X5SCOzdhKXnJ+1jTprXtR5G+mkeNQni9jlM661IM
	 FcWRo2yUkPr5MXBhLifun/dCwDFzPLLeafskUVUgXHgdA0TXoMdBgDGAgZ4RNlEkom
	 cqouVdCjrcenw==
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [PATCH 1/2] common/rc: remove useless _pgrep funcion
Date: Mon, 23 Jun 2025 04:39:46 +0800
Message-ID: <20250622203947.797199-1-zlang@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The _pgrep() function isn't used anymore, remove it.

Signed-off-by: Zorro Lang <zlang@kernel.org>
---
 common/rc | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/common/rc b/common/rc
index fbab26b25..a27f87a0b 100644
--- a/common/rc
+++ b/common/rc
@@ -36,16 +36,6 @@ _pkill()
 	pkill "$@"
 }
 
-# Find only the test processes started by this test
-_pgrep()
-{
-	if [ "$FSTESTS_ISOL" = "setsid" ]; then
-		pgrep --session 0 "$@"
-	else
-		pgrep "$@"
-	fi
-}
-
 # Common execution handling for fsstress invocation.
 #
 # We need per-test fsstress binaries because of the way fsstress forks and
-- 
2.47.1

