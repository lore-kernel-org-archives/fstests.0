Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E9F22CBCC
	for <fstests@vger.kernel.org>; Tue, 10 Dec 2024 06:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733813632; cv=none; b=Y3vabQqrvT9eSsM1wK024JJw8RVOWJLlNckM6s8TANQ4tu3u14u3T+2/qv3UpluYfbBRfTtrUuFyGa/7SRAFkuKJ1av7pmV8Xjfn5v9VII3TC0qsWjjl1gw9h4uHv03KQ7NatVRF8ClrjmKbWEuZsRIhn45ItS0HFaD7Qj5FQYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733813632; c=relaxed/simple;
	bh=cmWJyEgSgaUaf34JpLauzz+coAbizgJCU8saQog8n2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XzAKnsIljindNj0P2lVYWa6vSIbXuAt15q8weseENeBNqpkdVI+yxMMnShYiE5MmV8E+vhGG+MEcTc8g14cKPCcl54HHjsKQ+7RFqKZQfVlJrvc78oudqhHFR35pMfIgQOtV2wkxCQsAGhlOpoM85cvcgJTgK6Wwg+X8eYFeKls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=r0bitsAw; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r0bitsAw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=rPwE3HI87XDyI1oE9AYCoZIqVQZmgDDjuhE1pfj3sXw=; b=r0bitsAwcuR0zR6mkKJXDj4qZA
	FlDXiXjDXf870B0/5CcFUeIkecyqRH9w2LlkAti3ggA9OWsziztmDaw5q2kIaIADODHbLkomRoPyU
	skOKZrQRQQ22v3vl2HPkjoxr3e8A2Ih0xF+SFiS6q2EYp92/To/uaWDgVLLanZGJUVgWL3VEp3F2O
	CJVumIw9EWxZ1jQ+tQQ9tVclEUdjJpYjtGDCjMXBWMJ2uiZujbZmRJhfKBNWQMQbXcC8JJ0x6+gnh
	SNu4BC+aLSniGvS2pJguKrQTmxzsIZZoShTRmjuc5+ot28/QanIpGcyJ9EzIeEYKR2HFiLwERpa2j
	JD/7PwYQ==;
Received: from 2a02-8389-2341-5b80-e2a6-542f-4e27-82ec.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:e2a6:542f:4e27:82ec] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tKu7x-0000000ATua-1xei;
	Tue, 10 Dec 2024 06:53:49 +0000
From: Christoph Hellwig <hch@lst.de>
To: zlang@kernel.org
Cc: fstests@vger.kernel.org,
	cel@kernel.org
Subject: [PATCH] common: call _require_scratch_dedupe from _require_scratch_duperemove
Date: Tue, 10 Dec 2024 07:53:15 +0100
Message-ID: <20241210065346.1234550-1-hch@lst.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

_require_scratch_duperemove doesn't check if the scratch file system
actually supports dedup, so add the proper call for that.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---

Btw, I wonder if we should simply stop using dupremove in favor of the
xfs_io dedup command which seems lot less cumbersome?  For now this is
a quick fix, though.

 common/reflink | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/common/reflink b/common/reflink
index 22adc4449bc6..9177c45e70bb 100644
--- a/common/reflink
+++ b/common/reflink
@@ -83,6 +83,8 @@ _require_scratch_duperemove()
 
 	_scratch_mkfs > /dev/null
 	_scratch_mount
+	_require_scratch_dedupe
+
 	dd if=/dev/zero of="$SCRATCH_MNT/file1" bs=128k count=1 >& /dev/null
 	dd if=/dev/zero of="$SCRATCH_MNT/file2" bs=128k count=1 >& /dev/null
 	if ! "$DUPEREMOVE_PROG" -d "$SCRATCH_MNT/file1" \
-- 
2.45.2

