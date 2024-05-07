Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C23716D9C8
	for <fstests@vger.kernel.org>; Tue,  7 May 2024 19:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715108861; cv=none; b=I8Liwk3Dgsis7A3vbvHGX4o/bZHtxaHXYGEjepmH7JeRvz3Q3QcKv2a9W62JXhGugqynxltSjvsCAWJIbdqZTqGgB/v0DJuVTvf9uBzXhVsW4vAZcnWSknYD9X3EyTZgM0HplBgc75Y45ufj/vPNS3an8rP10ljlR91xRaOsogY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715108861; c=relaxed/simple;
	bh=4NCy7XQ5ZHhVRTuDj2PfamdVbNEOZ7xcRTGSgYTznOs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LiZkzuvwlU9MqLKCPrzC4eJXR1HsQRmSR+XXYhGsIqGUt4mOxyHY8RYHPRyZyULpGSthSMkl/YO/cUJokm8QjoTmt6DgBN29HeQnXSimm2LgN+u3/iH5AK7mtR/nI/KDAjp/a9pKFtD87Jl43kPSanT53ifjl8LH95qRnCIpmLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DabalCUr; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DabalCUr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DabalCUr";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DabalCUr"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 40E8A20F66;
	Tue,  7 May 2024 19:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715108855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=RAjKbeiZ8GatQ+jv78/luqhXWvSt3RrtjveH6b1n/5A=;
	b=DabalCUrr6XjJEeEfQqYceSN9Z5c31QvN8SZgGh48sFnt1yT82lFhMundlDz2HhPZeBVqx
	9bGZOCyBuM6+kBL7Xmrrx/1RHJLQvkPeeyIm0sIKuj81VGSUPPdIbSv8lXlXBwhlUkYaxQ
	IFWoVGaeHgaWvaPHeCl1uwrePTMCDv4=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715108855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=RAjKbeiZ8GatQ+jv78/luqhXWvSt3RrtjveH6b1n/5A=;
	b=DabalCUrr6XjJEeEfQqYceSN9Z5c31QvN8SZgGh48sFnt1yT82lFhMundlDz2HhPZeBVqx
	9bGZOCyBuM6+kBL7Xmrrx/1RHJLQvkPeeyIm0sIKuj81VGSUPPdIbSv8lXlXBwhlUkYaxQ
	IFWoVGaeHgaWvaPHeCl1uwrePTMCDv4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 37C15139CB;
	Tue,  7 May 2024 19:07:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /f9FDfd7OmZHGwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 07 May 2024 19:07:35 +0000
From: David Sterba <dsterba@suse.com>
To: fstests@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 0/4] Move test cased from shared to generic
Date: Tue,  7 May 2024 21:07:28 +0200
Message-ID: <cover.1715108589.git.dsterba@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -0.30
X-Spam-Level: 
X-Spamd-Result: default: False [-0.30 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	BAYES_HAM(-0.50)[79.95%];
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
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_ALL(0.00)[]

Hi,

as discussed recently, the tests in shared should be in generic.

Based on branch patches-in-queue, commit e098483c662d8f0b7583edca1501d8addd3b7549.

David Sterba (4):
  Move shared/298 to generic/740
  Move shared/002 to generic/745
  Move shared/298 to generic/746
  Remove rest of shared/

 check                                     |  2 +-
 tests/{shared/032 => generic/740}         |  2 +-
 tests/{shared/032.out => generic/740.out} |  0
 tests/{shared/002 => generic/745}         |  2 +-
 tests/{shared/002.out => generic/745.out} |  0
 tests/{shared/298 => generic/746}         |  2 +-
 tests/{shared/298.out => generic/746.out} |  0
 tests/shared/Makefile                     | 24 -----------------------
 8 files changed, 4 insertions(+), 28 deletions(-)
 rename tests/{shared/032 => generic/740} (99%)
 rename tests/{shared/032.out => generic/740.out} (100%)
 rename tests/{shared/002 => generic/745} (99%)
 rename tests/{shared/002.out => generic/745.out} (100%)
 rename tests/{shared/298 => generic/746} (99%)
 rename tests/{shared/298.out => generic/746.out} (100%)
 delete mode 100644 tests/shared/Makefile

-- 
2.44.0

