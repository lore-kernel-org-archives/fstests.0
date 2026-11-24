Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795516593;
	b=mk+73Gwa7rm5A2irwU/bqOtSg/U76DkIHOW2o+6PoxCR4BCH2g8Vq+/FL0FGKkvDq0AH
	 E5S8AVahQ+C296GvcadQdVp862tQr+dQ7/skinrZrMQTYOpOA/9xZGpUnJDdJOdJAZzTW
	 4pOOyIu/ebz/9ktSpXSRwEkHZcy+8sLq3i2M6xwzfGAegGxqLddG18jv69uaG63J+maR0
	 zGflMG/IY1Hr34FjoU90cm8mZUlOnFXG6DKzBJEJCPylxImSqY/3vr+syJn0XE90q46KW
	 hvy5t4N2dLBj+VXSAp3du4CUF31P/2zRE8w1ouc54Cc5Vsegx6+Ok8tr6vi00BFmAVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795516593;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=KjZ8tqpQRL0UwJsz5ZY1KEQxjniam+zqzmrWoYVfBTE=;
	b=uJO99gTvcBTEnohEWCya/6IDzRQ5pXecoitniI7ehzC5nN4E+142DZFcFdSdkinBkMnS
	 r9vewHBMTQswz+ObwHddoJU5HkiaCWkVRA50JDKO0ALESBni/wXvMZUrg8D4gkM0TgZpI
	 CHkYfX0lBXAzJu9h511oZsffc7ESLv+4Lg37w6q43ipqak/1s3yCNiE3GQi2sMOsJWhHV
	 itaeCEF63kOAuYFn6DzJ+yWsNwU4f/fDJVFKam8LQFNIbCABeRf+Nwcl+neMPF0Vmrddr
	 XMyY8v2fZDRaEQaoW74yBl1HFvwK9SXiUdmayc9QRkVm3WkMbwNSo3pAD2MZ8JCMnYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WqvTPNiz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4ED9606A31E
	for <fstests@vger.kernel.org>; Tue, 24 Nov 2026 10:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WqvTPNiz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D25661F000D3;
	Tue, 24 Nov 2026 10:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795516593;
	bh=KjZ8tqpQRL0UwJsz5ZY1KEQxjniam+zqzmrWoYVfBTE=;
	h=From:To:Cc:Subject:Date;
	b=WqvTPNiz270n/83TW1gzMTQq4OMu/u7/FgwYwWnay+3bEoatkQcJ8mc5T2DVI7f6m
	 JWXhKvNKLaSyX2iWnVZw22arufrlhDkqvzrMuWcPFjCwRCOdyctXCbV7NrcOsH58NL
	 usz+YF6sGp+fXl53ccvNh9sW1nERCfM7nM2+yWEL8IjGwxLHic0G1dsNWTnVX8xyZS
	 PqlaZRG6rYOq7GBnR39UKwBrV3Zq0CL8tU+KqDFYneRelXjZbzcU4ge4YLbawD3FnH
	 SEFEDo41j5sTrA6YNxVrQBWgYZQLhg+aZ032/8RI+FZhB8xpjEelP9lnOFUVy547Ff
	 iol/lbsoao0kA==
From: Andrey Albershteyn <aalbersh@kernel.org>
To: "Zorro Lang" <zlang@kernel.org>,
	"fstests" <fstests@vger.kernel.org>
Cc: Andrey Albershteyn <aalbersh@kernel.org>,
	preichl@redhat.com
Subject: [PATCH 0/2] Hints for tests failing on older kernel/xfsprogs
Date: Tue, 24 Nov 2026 11:36:13 +0100
Message-ID: <20261124103617.4012647-1-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
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

Hey folks,

First patch adds a hint for two tests failing on xfsprogs < v7.0.0. The
second one requires online repair used by xfs_scrub (tests won't run on
older kernel or ones without online repair).

Andrey Albershteyn (2):
  generic/453,generic/454: add a hint for the missing xfsprogs commit
  xfs/349,xfs/556: both these tests require online repair in the kernel

 tests/generic/453 | 3 +++
 tests/generic/454 | 3 +++
 tests/xfs/349     | 1 +
 tests/xfs/556     | 1 +
 4 files changed, 8 insertions(+)

-- 
2.54.0

