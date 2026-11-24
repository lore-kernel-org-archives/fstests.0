Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795516595;
	b=Delnbv77CigJGOU3ZPgxtgrJztlGFzV0qL6K7wU5haZqk8RaDONl/RO7h3bnju5dMbn0
	 BiqyiXIDXsCUIhiC+tm4ow0xvnBxYFo/BPmPJIwm6lXMVGolIUvIhvjIH93DE42QjNcPX
	 9p5944qDPOnVCzZAz94cvzzfuFOWDubbnVw9fqrgYMBN+bBfpArehmtLIKEEM/dpA3k7Y
	 L6D3QdQdGep6PkKJWxgXWVmdjlJfdvFkyizqA3G+u8UUBBvSu7fQJZb1vJ8rvIwe+Zewr
	 EUluiSW/v1/nQMYVy4eTeKpVlejNbW4naCiBaHlFKEbL22W4mj2FrsLQllHF9Xz2kVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795516595;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=h7B/fWJTVzVDmzzWT+I7oQcUCTEsRyYcFHLC9C/m6dw=;
	b=lS0QfavSNOFMfO4XsDjTKlvtaXlNajmPLGiU9kfzv8+I0XTcxouTONQh2ZY11rE1H/aO
	 V1DZswmPNq3wEWU608viYZqvfeRUXqLJz/THpS3po+LTuV0Op2amiczHpMRhMPYQOMKZP
	 luM9ht+7evPJUon+WPo14KIQ/qRfCCX+GF2jjfeu8FJMCGu/5e5+vtCBFqTpPIcs12MvP
	 RCPkG6VcdGIbH1Jn5PRpdaXgq/YQa3J3+iXo8taxaU8fLjSQxNlE5A+PgnPdHquYcuSqc
	 70DfOyoL6r45u9RHxpZuNrsjS5N+zc2+f28wCQkQgqClqVmRWVflzDcssTTQgSHyXrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cdk3t+3e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3801F606A31E
	for <fstests@vger.kernel.org>; Tue, 24 Nov 2026 10:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cdk3t+3e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B02351F000CA;
	Tue, 24 Nov 2026 10:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795516594;
	bh=h7B/fWJTVzVDmzzWT+I7oQcUCTEsRyYcFHLC9C/m6dw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cdk3t+3easoMrxGH4zi6LHOconP64aSDjJhDsdgRacvWIAwgh/TiqrcP/0/6/0862
	 18Dy11qDNvnI3oHjenUPGiv4IiL7kfy2Xk8YRwD4vsCcEJHOmeM1YBTMwDVmzK70iP
	 PiiFuR5bQntRgPJOpNgAONlKe/fDNI5QifrC3hVwPEZzzH+eZZFFhjM93e0U0OfFN9
	 6Gxc/I09V2cIkOTnqpRUBgJpBuwUgXcus6v96S5ieBFIm5gNbrg7GiHVmgoNPQuL0Y
	 LP31fxQfq2zqnnCxRALkMAti6dLLvx5WMPy9SKDr3nr0NCjOOmO8HRel7/XuiQu3Vs
	 c3uUVstc7Na+Q==
From: Andrey Albershteyn <aalbersh@kernel.org>
To: "Zorro Lang" <zlang@kernel.org>,
	"fstests" <fstests@vger.kernel.org>
Cc: Andrey Albershteyn <aalbersh@kernel.org>,
	preichl@redhat.com
Subject: [PATCH 1/2] generic/453,generic/454: add a hint for the missing xfsprogs commit
Date: Tue, 24 Nov 2026 11:36:14 +0100
Message-ID: <20261124103617.4012647-2-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261124103617.4012647-1-aalbersh@kernel.org>
References: <20261124103617.4012647-1-aalbersh@kernel.org>
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These two test will fail with xfs_scrub before v7.0.0 which dropped
warning about use of bidirectional characters. These tests trigger these
warning and break the golden output on older xfsprogs.

+Unnecessary complaints about mixed bidi characters in a name?

This warning was removed in the referenced commit.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 tests/generic/453 | 3 +++
 tests/generic/454 | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/tests/generic/453 b/tests/generic/453
index 9b121d995ad1..7d1deb553cd3 100755
--- a/tests/generic/453
+++ b/tests/generic/453
@@ -17,6 +17,9 @@ _begin_fstest auto quick dir
 _require_scratch
 _require_names_are_bytes
 
+_fixed_by_git_commit xfsprogs 5f5d7fe4a7ef \
+	"xfs_scrub: drop the warning about mixed bidirectional codepoints in names"
+
 echo "Format and mount"
 _scratch_mkfs > $seqres.full 2>&1
 _scratch_mount >> $seqres.full 2>&1
diff --git a/tests/generic/454 b/tests/generic/454
index 81c9a721561c..b55e9474c35a 100755
--- a/tests/generic/454
+++ b/tests/generic/454
@@ -19,6 +19,9 @@ _require_scratch
 _require_attrs
 _require_names_are_bytes
 
+_fixed_by_git_commit xfsprogs 5f5d7fe4a7ef \
+	"xfs_scrub: drop the warning about mixed bidirectional codepoints in names"
+
 echo "Format and mount"
 _scratch_mkfs > $seqres.full 2>&1
 _scratch_mount >> $seqres.full 2>&1
-- 
2.54.0

