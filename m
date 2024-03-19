Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23D638DC3
	for <fstests@vger.kernel.org>; Tue, 19 Mar 2024 18:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710872368; cv=none; b=QwfOxRGAnk585ANy0kBeM9u00t9zfGtiNhFWVhSTKsjJIMYauJ1l3YrA8QNzADQ/vGu/ZXDxSl36E0cNfFqmTzAsKhnnjYtYzYPKzO3jjUXTlVkw8e/OtW3A383M3z4n6AGZBtGYGJ6HhxL6WfBLACASSrrgVwHqv0kN66AJNVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710872368; c=relaxed/simple;
	bh=VwVDcY0TO2axL/jWjtCB35X3LH+tkbbNehoTlHqUSVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PXFoOa5dYxDEkYPQaLpNEKKa8fXGIkkzEjqR9MeH+p2SWhc5i2zNlwWmjghHgHmjaZmj1rsMnBizIERiOLvpo529q37lIRfvOQSJCt/vyQPUD5D96BNEAEip/uDURJuff+HVl8sV6sTRoijlVs14uZlYiJgI5lKObnBiLWLLvYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sH6AynCi; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Rh4mmzfS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sH6AynCi";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Rh4mmzfS"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 00E7221CE8;
	Tue, 19 Mar 2024 18:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710872365; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=87IJRYlCZc3nG6YSubJqk7fid/9rRgikDam7bMyuKxM=;
	b=sH6AynCiM9FPRp3LixF9qWnWL0yDMMxKgYKnSXLwidEcvp7SVkacXatCzNrKmjGxze3O+8
	vkEd6Hi/CIzdHtne/iyZ3Io4foPASOzOFsKP+/BsaCUfkjOYuZWbZ8IRBQyxUHOZs5wnfy
	6p1NXigdl71RGHcrUOkiQ2LuJElc2cY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710872363; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=87IJRYlCZc3nG6YSubJqk7fid/9rRgikDam7bMyuKxM=;
	b=Rh4mmzfSoM4XY4kRRZfpO7wvHPQrfU75XeokDZcOSpGqnvBIrPX28CPRgRdol35kL8ATzi
	r+Y4BZ0kSXtqDTdDqsgRB6sNIYFCneS/NaGkYTaIw4Xu95B4J72S09G1Bj/t+eKr6vuNFm
	xq/8zkVdrEEmYSI0M/O4jGtNSUIMIA4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EEC84136D6;
	Tue, 19 Mar 2024 18:19:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aWVJOirX+WWaSwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 19 Mar 2024 18:19:22 +0000
From: David Sterba <dsterba@suse.com>
To: fstests@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 5/5] generic/733: disable for btrfs
Date: Tue, 19 Mar 2024 19:12:10 +0100
Message-ID: <094a1bdc304b236ba41aff4da454abe3c93a355c.1710871719.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1710871719.git.dsterba@suse.com>
References: <cover.1710871719.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: ***
X-Spam-Score: 3.32
X-Spamd-Result: default: False [3.32 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_SOME(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[toxicpanda.com:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.38)[77.34%]
X-Spam-Flag: NO

This tests if a clone source can be read but in btrfs there's an
exclusive lock and the test always fails. The functionality might be
implemented in btrfs in the future but for now disable the test.

CC: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 tests/generic/733 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/733 b/tests/generic/733
index d88d92a4705add..adb141e190b7b0 100755
--- a/tests/generic/733
+++ b/tests/generic/733
@@ -18,7 +18,7 @@ _begin_fstest auto clone punch
 . ./common/reflink
 
 # real QA test starts here
-_supported_fs generic
+_supported_fs ^btrfs
 _require_scratch_reflink
 _require_cp_reflink
 _require_xfs_io_command "fpunch"
-- 
2.42.1

