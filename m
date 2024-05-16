Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0C5157467
	for <fstests@vger.kernel.org>; Thu, 16 May 2024 22:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715897555; cv=none; b=hlbTBu3+ojqdQ6mD7Lj9nFx+wfbz41EBBp9dKvidX/FG2TNOITqSM+SjYf3Q3RS2uILz/v/Y2mDQKz0/F73mLInwF6usrTQ6L+xnL+oIxiOxy2S8gJet+XCF0lA83V8W5oaXfqJ9W3f4j2osWNV535/9ywVmYkizc+Yg0QVF0cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715897555; c=relaxed/simple;
	bh=u2z/+tZkz1vvVemWu8AvdH9YeSy6PXvzwsh9ePnyp8E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=te1d/oyFidxzlLY1emVqgw7taHkIYACOChBwo2YDpbTCJGlaKc9tjFLCGPnb+vaImL7l+T7yRO6G5Am0Q56TGiuqVHAkUzrXkZJn9O0lFlOOMWmm3HE7eQnN9eQGGOWTeCNfaEp7J4+NypUfdL5KGUOsZH0B9jTQnGb9tUkgCBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=J0NORSKw; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=J0NORSKw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="J0NORSKw";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="J0NORSKw"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 349A035056;
	Thu, 16 May 2024 22:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715897551; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=25qU0rbS51YOevbTzvIo6+qH8nop3iZt1MkVK0hHeOw=;
	b=J0NORSKwOTK4uvqTCe7IfjA+F4XVsNhAFkhIqXTqegqHox9ei3NiVZcS80FfkMYseBM8pU
	5BSC/mBa8hUcpGX/vK4zRp3D4FqfelQVjeGnBmQOH477BZWquX9is4+q19kk/frfsAzKyq
	Xda0PmRdtm/r1VXQIZ9JQa8TNkd2KAY=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715897551; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=25qU0rbS51YOevbTzvIo6+qH8nop3iZt1MkVK0hHeOw=;
	b=J0NORSKwOTK4uvqTCe7IfjA+F4XVsNhAFkhIqXTqegqHox9ei3NiVZcS80FfkMYseBM8pU
	5BSC/mBa8hUcpGX/vK4zRp3D4FqfelQVjeGnBmQOH477BZWquX9is4+q19kk/frfsAzKyq
	Xda0PmRdtm/r1VXQIZ9JQa8TNkd2KAY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2B080137C3;
	Thu, 16 May 2024 22:12:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id B6c+Cs+ERmY2YgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 16 May 2024 22:12:31 +0000
From: David Sterba <dsterba@suse.com>
To: fstests@vger.kernel.org
Cc: josef@toxicpanda.com,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 0/6] Btrfs test updates and fixups
Date: Fri, 17 May 2024 00:12:25 +0200
Message-ID: <cover.1715896529.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Hi,

another batch of changes that we had for our CI. This adds requirements
for some test cases or adjusts conditions for running them successfuly
on btrfs (no affecting other filesystems).

Please add them to fstests, thanks.

Josef Bacik (6):
  common: udev settle before _scratch_pool_mkfs
  generic/352: require no compression
  generic/027: require no compression
  generic/269: require no compression
  btrfs/011: mkfs the scratch dev before exiting
  btrfs/{140,141}: verify read-repair test data by md5sum

 common/rc           |  6 ++++++
 tests/btrfs/011     |  5 +++++
 tests/btrfs/140     | 15 ++++++++++++++-
 tests/btrfs/140.out | 34 ----------------------------------
 tests/btrfs/141     | 16 +++++++++++++++-
 tests/btrfs/141.out | 34 ----------------------------------
 tests/generic/027   |  4 ++++
 tests/generic/269   |  3 +++
 tests/generic/352   |  4 ++++
 9 files changed, 51 insertions(+), 70 deletions(-)

-- 
2.45.0

