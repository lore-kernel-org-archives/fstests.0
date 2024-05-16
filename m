Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE2A3FE4
	for <fstests@vger.kernel.org>; Thu, 16 May 2024 22:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715897563; cv=none; b=QEhigyIyvKXi0L4PgbRm5ywVla4nIWqrA6cj3Gw1of8SLkCKmYNdCkOZEtp/rE5V2IN3QAJ9jt9eV4TQQgSIOXEseyIVCmyFnX83P8qip3w0xeMwOoxDF5I64odzjwuPcqhSP2I90UsdlidXuPTnIztXiUYySYYtYeIV3zyIxoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715897563; c=relaxed/simple;
	bh=2okkSo+AnHGzm4akVerqBO2fdPjuf4BEbb0fzzd4ByQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iJn90B/PwB1ppHY4aV/XYDao8tNALVN3+vqlzhe7YfQb7orWi08Jgr1pkr2D+imySfbOkC5acSdoZe435WvLb5g4dLGScJCS0bcl3H36NM0qYXeOEevyauHWLRy+x62CQZdEwLNMvgOiZtdQ8jxI1PuJqG5lqUSqHp8C75w84zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QQpPcN9f; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DiqG2XB1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QQpPcN9f";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DiqG2XB1"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EDEDE5CBEF;
	Thu, 16 May 2024 22:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715897560; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H02rhoC6GtCz8wJ5CfKES2hDmcLzRteKM6NlIyWPFX0=;
	b=QQpPcN9fSeLGW/zA54ssmVPbEIEbSnpkXtvp05dSfzxNo+MvkiBpC9LCnYXzo7dZvaZ7tO
	xbSVWaXz4K+JZPHPENjcz2ig4ODKZ8sIydSVpeyQnQjc8PZeJMImwgvkoUKzq5GqrtAM9C
	k3BWmmDq4yUlGzKP4li2EY4tZWvyfEY=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715897559; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H02rhoC6GtCz8wJ5CfKES2hDmcLzRteKM6NlIyWPFX0=;
	b=DiqG2XB1mjQGFmNRJoAGAWjlS+tFgd3pQs3NMtUOupUcZA1K53R4ok/9jO37A+VbV6biu0
	DuvDXstCn/Jr6j5hDuNg3fiHzxtv5WD470HHBiJsPqyv5OIeRtyHW2ZJkN5FpoYY1EdPZz
	KrpM69wb/ykGufN0OV08vGWEF7RNNI4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E7C59137C3;
	Thu, 16 May 2024 22:12:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DSGUONeERmYkZQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 16 May 2024 22:12:39 +0000
From: David Sterba <dsterba@suse.com>
To: fstests@vger.kernel.org
Cc: josef@toxicpanda.com,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 2/6] generic/352: require no compression
Date: Fri, 17 May 2024 00:12:39 +0200
Message-ID: <d3e67b7d53f21d3e290384760ffbfda02c43cc8c.1715896529.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1715896529.git.dsterba@suse.com>
References: <cover.1715896529.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-6.77 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-2.97)[99.89%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -6.77
X-Spam-Flag: NO

From: Josef Bacik <josef@toxicpanda.com>

Our CI has been failing on this test for compression since 0fc226e7
("fstests: generic/352 should accomodate other pwrite behaviors").  This
is because we changed the size of the initial write down to 4k, and we
write a repeatable pattern.  With compression on btrfs this results in
an inline extent, and when you reflink an inline extent this just turns
it into full on copies instead of a reflink.

As this isn't a bug with compression, it's just not well aligned with
how compression interacts with the allocation of space, simply exclude
this test from running when you have compression enabled.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 tests/generic/352 | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/generic/352 b/tests/generic/352
index acc17dac38d061..3a18f07601de96 100755
--- a/tests/generic/352
+++ b/tests/generic/352
@@ -25,6 +25,10 @@ _supported_fs generic
 _require_scratch_reflink
 _require_xfs_io_command "fiemap"
 
+# The size is too small, this will result in an inline extent and then reflink
+# will simply be a copy on btrfs, so exclude compression.
+ _require_no_compress
+
 _scratch_mkfs > /dev/null 2>&1
 _scratch_mount
 
-- 
2.45.0

