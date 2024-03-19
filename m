Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF0339851
	for <fstests@vger.kernel.org>; Tue, 19 Mar 2024 18:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710872357; cv=none; b=SxRfBrnSU8tCsfrygiwO4Y3cICPvb+v2+LeZaox7YBBAuMCL2baw7aZv/3pFFkdRyFhzx4zGpEVGlhIrJWKVJ3mUVB0tTyETSi0KFAInVM9vOFaOVRBSLJ16MdhHsBrt0oeCWuPyvqwzOujwJfZzEDKmBoLRCjxuezilyUzxikQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710872357; c=relaxed/simple;
	bh=2fUZItWAiVVMvRGNoJw3UnDLexQvYwqrcNkdAvzxcWA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CqpqJKnAHIrXBSX2yt1t1qVTjpDFYdA4p8eLM20dcTrgqaWuvdZYF6diqqJzraXMTzLh5wW/LApnTlJLGSPLtuGRYnOUv4Zr/Z0kkavubvYvrDDsbrGKQb2Jo++yl3JkGjfuRnNL9+YhbPsfGf882SUZnPS1kLr/+1YED6+qnek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bSRk8DG4; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bSRk8DG4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bSRk8DG4";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bSRk8DG4"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 25F941F454;
	Tue, 19 Mar 2024 18:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710872351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=7WCTIgz5AwP2ZyPB23fp3RIsOSMw/NbCUeNM4h2a9FE=;
	b=bSRk8DG4cx4mYr4Bni73baWFYEQQO/ppS4XJTp1CW/lnPJ3lydwZ24hiRwuClPdDUPOxG3
	bEFfLKED9ELE9R9bhj5D3tt78tJY1uEzaQy6UnAWDTdrq3/je93IjB95S01o5930s1mqF+
	mlolmcHJBlLJqPxpjoPLkBrBa9GvBbg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710872351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=7WCTIgz5AwP2ZyPB23fp3RIsOSMw/NbCUeNM4h2a9FE=;
	b=bSRk8DG4cx4mYr4Bni73baWFYEQQO/ppS4XJTp1CW/lnPJ3lydwZ24hiRwuClPdDUPOxG3
	bEFfLKED9ELE9R9bhj5D3tt78tJY1uEzaQy6UnAWDTdrq3/je93IjB95S01o5930s1mqF+
	mlolmcHJBlLJqPxpjoPLkBrBa9GvBbg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1FECC136D6;
	Tue, 19 Mar 2024 18:19:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NZLJBx/X+WV9SwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 19 Mar 2024 18:19:11 +0000
From: David Sterba <dsterba@suse.com>
To: fstests@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 0/5] Btrfs fstests fixups and updates
Date: Tue, 19 Mar 2024 19:11:57 +0100
Message-ID: <cover.1710871719.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=bSRk8DG4
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.73 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.76)[98.97%]
X-Spam-Score: 0.73
X-Rspamd-Queue-Id: 25F941F454
X-Spam-Flag: NO

Hi,

a few more fixup from our repository.  They have been in our CI branch
and consider them tested and working for our needs. All of them are
btrfs-specific and will not affect other filesystems.

Please apply, thanks.

David Sterba (2):
  common/rc: use proper temporary file path in _repair_test_fs()
  generic/733: disable for btrfs

Josef Bacik (3):
  common/verity: use the correct options for btrfs-corrupt-block
  btrfs/131,btrfs/172,btrfs/206: add check for block-group-tree feature
    in btrfs
  btrfs/330: add test to validate ro/rw subvol mounting

 common/btrfs        | 10 +++++++++
 common/rc           |  4 ++--
 common/verity       |  2 +-
 tests/btrfs/131     |  2 ++
 tests/btrfs/172     |  3 +++
 tests/btrfs/206     |  3 +++
 tests/btrfs/330     | 54 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/330.out |  6 +++++
 tests/generic/733   |  2 +-
 9 files changed, 82 insertions(+), 4 deletions(-)
 create mode 100755 tests/btrfs/330
 create mode 100644 tests/btrfs/330.out

-- 
2.42.1

