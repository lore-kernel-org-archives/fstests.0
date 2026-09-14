Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D583D413F
	for <fstests@vger.kernel.org>; Mon, 14 Sep 2026 14:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789394868; cv=none; b=InRFn1SFevO+1LxK7HVLRritqSy58o+SHpV378TfOvys2OYdX6Vl7S29BZ40q5PfZxHbOmU2UMyGaaE1DB+ZdUiyeMv7qxmRTf6j7MY5pQnmbu41BpVZw4jQuJwMUAR/Ij046Toid/Jmhu8E5gehKVSXZk79tWdV+TDuQgfaJOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789394868; c=relaxed/simple;
	bh=3HlAFbAXgBH2czwIqBZzq+V4CoFY9FuZRkXzqmlt9no=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=CcIrNv1m/uiIWZChAAlfcF5CakmJjPipdoTpXSNYDMMGDdtohJdmUbpqukY3KgOP+RRsOcY5Ra/+aLf3vJf9wjiA++DizcT5z24rhfh/jdz2AO6L1FeX1xieolikaFLQKL5jno6zucyO0bIEPvLTxRL18HhvUFLFjdYaQXodXSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=caCVF76D; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3ILnp61h; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZHDpNyyh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hAkPQzcA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="caCVF76D";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3ILnp61h";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZHDpNyyh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hAkPQzcA"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4954921A65
	for <fstests@vger.kernel.org>; Mon, 14 Sep 2026 14:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789394861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=uWdzADGrI41bey3tL2VsQU37Ztpzcb0Yx26lJIzEXYM=;
	b=caCVF76D+TCZgWiImwAV8uzt9NEAkQAsAQt9MKLotZAn4ZbeX9ltn4MwDEFLdu5FuR8HI/
	2iBRV6MoiCdokTMpHkZFv9XiUVdAxn71CkXVDId4/BhKeFhsGBfDRNfgGYdpDKfhDCB6TE
	kfPdUSLtQB15g20OM0pqYNOzPaTWZsM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789394861;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=uWdzADGrI41bey3tL2VsQU37Ztpzcb0Yx26lJIzEXYM=;
	b=3ILnp61hyz8tiMHVdLLkO5kNv1UibTBfBodjXx+AWgKeeRcXWfciW+nvci3PId9zY1QyRA
	nkugFWr0mLYbxaDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ZHDpNyyh;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=hAkPQzcA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789394857; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=uWdzADGrI41bey3tL2VsQU37Ztpzcb0Yx26lJIzEXYM=;
	b=ZHDpNyyh5zFKVbtqdvvowAgqwMwBt69MpF0aviluJWMIZIBkvL35wS0rcwldQ1wrbGlx91
	4bw6UXmVSBtCi9hlnUCNKx9BhSOBwtcK5Bi276jOWAtxksuZpQkh1K2U0bBX6UZ9oK3zeM
	nMPOom8lb3utGg4SI8tyl0Vr+TIZ9VM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789394857;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=uWdzADGrI41bey3tL2VsQU37Ztpzcb0Yx26lJIzEXYM=;
	b=hAkPQzcA0NLSVBDQgJLJlKxIgEcu5CX6SP83TA4O00QJW1H25RI2uMooV8u4stpzmkjZXJ
	AFnO7WJj7/qW9ECw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CAE5D13515
	for <fstests@vger.kernel.org>; Mon, 14 Sep 2026 14:07:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1wAOHqf/p2pQCwAAD6G6ig
	(envelope-from <ddiss@suse.de>)
	for <fstests@vger.kernel.org>; Mon, 14 Sep 2026 14:07:35 +0000
From: David Disseldorp <ddiss@suse.de>
To: fstests@vger.kernel.org
Subject: [PATCH 0/2] report: optionally gzip xunit output
Date: Mon, 14 Sep 2026 23:46:10 +1000
Message-ID: <20260914140710.111641-1-ddiss@suse.de>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4954921A65
X-Spamd-Result: default: False [-3.00 / 50.00];
	BAYES_HAM(-2.99)[99.95%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[fstests@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Score: -3.00

I collect fstests xunit reports for (possible) later analysis. The XML
compresses quite well: for an auto group run with a handful of failures,
uncompressed xunit is typically 10x larger than a gzipped result.xml.

This mostly trivial patchset adds a new xunit-gzip report type. The same
can be achieved via e.g.
  ./check -R xunit ... && gzip <REPORT_DIR>/result.xml

 check         |  2 +-
 common/report | 97 +++++++++++++++++++++++++++++----------------------
 2 files changed, 57 insertions(+), 42 deletions(-)
