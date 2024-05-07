Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63A616D9D2
	for <fstests@vger.kernel.org>; Tue,  7 May 2024 19:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715108867; cv=none; b=PN54H+OKSSzgOFOLRVsWV9D27QD6hhNKtOvBROdzjUccWG3l1uF+8ewBC/XFpOQEK2or2viKO6465100NnBe9AzkPphjSQMDNeBGhr5qC4+Gdnas11uwyvpt2ppP+wisbk1GVanlNWn3JOZY6a/zva4VvFQdD86ooKmhpukoU5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715108867; c=relaxed/simple;
	bh=MVBKVZyn2cideKkeg2KldXAJ4NPAzvaT2TGW+jiqqFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MLFa20+bcMCsEKOvAFMFs762yZjMPzq341JeoLUrLIwT7UWHPh4OKnRtVHuZ2eKabbLDHR72JGkvFXnrHtdK+CRHnHARn92zhFdX8sp9qzbvU1TJbPquWcuo/niB0Mnb+GEcQWVOQtEFktzMmwWJA89mC+KIwWQ42iEommQZ15g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=iKlZwjFI; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=iKlZwjFI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iKlZwjFI";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iKlZwjFI"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0035620F67;
	Tue,  7 May 2024 19:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715108864; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XxVU7VVErSUy7qvQBj9qFVnKGbAdxP8kvmy+bsDHv6Y=;
	b=iKlZwjFICl5TyVCXY5v0rlyitT4+LE9ElxYKT8wi9+m5l5NVwSP89Ox5YtmetdCFEX7D/J
	D/HI8KN65+XdNJgpkgdWmEwwXA+MqMJ3JxB92OFTMhvULkn0VQKz7v822DM8hY/iHEtxmQ
	fTAIkJMkAR/LoKNnrr+liPX3DLZPRSY=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715108864; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XxVU7VVErSUy7qvQBj9qFVnKGbAdxP8kvmy+bsDHv6Y=;
	b=iKlZwjFICl5TyVCXY5v0rlyitT4+LE9ElxYKT8wi9+m5l5NVwSP89Ox5YtmetdCFEX7D/J
	D/HI8KN65+XdNJgpkgdWmEwwXA+MqMJ3JxB92OFTMhvULkn0VQKz7v822DM8hY/iHEtxmQ
	fTAIkJMkAR/LoKNnrr+liPX3DLZPRSY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EF260139CB;
	Tue,  7 May 2024 19:07:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NpVhOv97OmZlGwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 07 May 2024 19:07:43 +0000
From: David Sterba <dsterba@suse.com>
To: fstests@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 2/4] Move shared/002 to generic/745
Date: Tue,  7 May 2024 21:07:39 +0200
Message-ID: <ddb9dd4eabcb5c6695c2c0ea7e257d0b615814e9.1715108589.git.dsterba@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1715108589.git.dsterba@suse.com>
References: <cover.1715108589.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -6.80
X-Spam-Flag: NO

The shared/ directory was supposed to host tests that apply to a subset
of all supported filesystems but this is not utilized much and creates a
split from the generic tests. Move the test to generic.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 tests/{shared/002 => generic/745}         | 2 +-
 tests/{shared/002.out => generic/745.out} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename tests/{shared/002 => generic/745} (99%)
 rename tests/{shared/002.out => generic/745.out} (100%)

diff --git a/tests/shared/002 b/tests/generic/745
similarity index 99%
rename from tests/shared/002
rename to tests/generic/745
index d99539c91907b5..0f47f9c69ef40a 100755
--- a/tests/shared/002
+++ b/tests/generic/745
@@ -2,7 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # Copyright (C) 2015 SUSE Linux Products GmbH. All Rights Reserved.
 #
-# FS QA Test No. 002
+# FS QA Test No. 745
 #
 # Test that after syncing the filesystem, adding many xattrs to a file, syncing
 # the filesystem again, writing to the file and then doing a fsync against that
diff --git a/tests/shared/002.out b/tests/generic/745.out
similarity index 100%
rename from tests/shared/002.out
rename to tests/generic/745.out
-- 
2.44.0

