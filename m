Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAD17711C
	for <fstests@vger.kernel.org>; Tue, 11 Jun 2024 22:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718144829; cv=none; b=i9+Y2HtJX4KRvrK1Vvx800xLFzTm+dy4qpdM2xOZ3SO0NbGEbmincb88FH/CpSFnzOI9vmsYmGgl7D/hmHLNxuzfqUBr0ioczxzHZKGYfud6Ds53GFT0iR1P3fks8hf9RCE2x7op6iQKQNckG6Ew6hU9qRoqN387lpgMFIKC1D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718144829; c=relaxed/simple;
	bh=Km73BhjX7bmaFwtWUCqg9zDRnj5I3ur0tI2SaD6C2jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gFZ9Qr2ocuMUn7hdKzDayumtc0nQI8q6yRh6VeDtYbyKuTAKh8HWbSAiqA9PPbuZw4jJKSKdxW+QF37LugEVrKm9lfbbOnS3jJEeox7lBgH8AWxcdNqfSvMJnyjM6ChWmw1HIotApXHCnlKX7Yzhe2RKxkHcqnl+9vpH05405lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=R6E1gpYA; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="R6E1gpYA"
Received: from cwcc.thunk.org (pool-173-48-115-193.bstnma.fios.verizon.net [173.48.115.193])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 45BMR35w005886
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 18:27:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1718144824; bh=VzCYgLAQ8B/1PS1xZ8zgI7Hrpnmb7hMn6z5S+Z9JGus=;
	h=From:Subject:Date:Message-ID:MIME-Version;
	b=R6E1gpYAhHyE6y4hi921m31hmdWZmkjn2TUjvpgrOGI5+TvPl0y6dT0Ip076oVcYy
	 XnTAq/FwjKtEpePuW+U4fVUhpOxYWOkvE9peNER8OnRy+Cggc34ei0IUhI4/if7QJe
	 hNIu/vBLiqnFrcFH/3+VcR+yZrde7xxfOc8D+a9gUhnpVhvlyvFenfdMLZ119dYeRi
	 4u/7dVIwKA5YbSMe3Vy5+a2+Zj3f4Gt1uahXatiOCZnv7EXVD3QFBhwB8Q41gxj+8u
	 0ij3r77UdWRECCP53YITF/lOxshQyBQrxnHmKoWcQz+eo5IF66W4rCNHuUKBkbVddd
	 JswRrWDqXgZ7g==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 2AAFB15C0CB5; Tue, 11 Jun 2024 18:27:03 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: fstests@vger.kernel.org
Cc: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH -v2 2/2] generic/455: skip the test if the file system doesn't support journaling
Date: Tue, 11 Jun 2024 18:26:59 -0400
Message-ID: <20240611222659.256476-2-tytso@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240611222659.256476-1-tytso@mit.edu>
References: <20240611222659.256476-1-tytso@mit.edu>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test uses dm-log-writes to test power fail scenarios, so it won't
work if the file system doesn't support metadata journaling.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 tests/generic/455 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/generic/455 b/tests/generic/455
index da803de08..6dce8a659 100755
--- a/tests/generic/455
+++ b/tests/generic/455
@@ -65,6 +65,9 @@ _log_writes_init $DMTHIN_VOL_DEV
 
 _log_writes_mkfs >> $seqres.full 2>&1
 
+# This test requires metadata journaling since it simulates a power failure
+_require_metadata_journaling "$LOGWRITES_DMDEV"
+
 # Log writes emulates discard support, turn it on for maximum crying.
 _log_writes_mount -o discard
 
-- 
2.43.0

