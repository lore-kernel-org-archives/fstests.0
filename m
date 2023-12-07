Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="B3nauW9j";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EEJ/EcGe"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F06AD5E
	for <fstests@vger.kernel.org>; Wed,  6 Dec 2023 23:21:17 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D081121D4C;
	Thu,  7 Dec 2023 07:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1701933675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IYIk1jUb9IYFlUI5myqMAeHozydt4/0esTmiXh/p6rE=;
	b=B3nauW9jTXuac7UrPS8AOKUS7t2lhej429s7k2iR3fwgMx8T4CDcU2l3O5M7KHw/4xx2fb
	IGBItSnmI9yXDW1c7RdeiaRrXOcoa3xyBFMnG/fo/9s5uRix+DyhGx4uQ44rrGzq30Rgtn
	stiaT1Rkw4FQV6BJMyH1Gu8GfAoUh4g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1701933675;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IYIk1jUb9IYFlUI5myqMAeHozydt4/0esTmiXh/p6rE=;
	b=EEJ/EcGe9e9Knz4tTEzJRhWYskZcrN8Z1VVgCppQGb+nGjUIbCSNu2xawBTv69CetF9LYJ
	eMF8Bw01h91gZHBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D7F8313976;
	Thu,  7 Dec 2023 07:21:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qK1vHGlycWXdGAAAD6G6ig
	(envelope-from <ddiss@suse.de>); Thu, 07 Dec 2023 07:21:13 +0000
From: David Disseldorp <ddiss@suse.de>
To: fstests@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH 4/5] btrfs/282: reduce scrub dataset size
Date: Thu,  7 Dec 2023 18:20:55 +1100
Message-Id: <20231207072056.14588-5-ddiss@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231207072056.14588-1-ddiss@suse.de>
References: <20231207072056.14588-1-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: 10.00
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [10.00 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_SPAM(5.10)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]

The use of dmdelay means that we can use a smaller dataset while still
achieving a reasonable scrub duration. This also drops the xfs_io pwrite
/dev/urandom input file, instead relying on xfs_io's built-in
pseudorandom pattern generation.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 tests/btrfs/282     | 8 +++-----
 tests/btrfs/282.out | 2 +-
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/tests/btrfs/282 b/tests/btrfs/282
index f9e22e12..42d992a6 100755
--- a/tests/btrfs/282
+++ b/tests/btrfs/282
@@ -25,8 +25,7 @@ _supported_fs btrfs
 _wants_kernel_commit eb3b50536642 \
 	"btrfs: scrub: per-device bandwidth control"
 
-# We want at least 5G for the scratch device.
-_require_scratch_size $(( 5 * 1024 * 1024))
+_require_scratch
 _require_dm_target delay
 
 # Make sure we can create scrub progress data file
@@ -49,9 +48,8 @@ if [ ! -f "${devinfo_dir}/scrub_speed_max" ]; then
 	_notrun "No sysfs interface for scrub speed throttle"
 fi
 
-# Create a 2G file for later scrub workload.
-# The 2G size is chosen to fit even DUP on a 5G disk.
-$XFS_IO_PROG -f -c "pwrite -i /dev/urandom 0 2G" $SCRATCH_MNT/file | _filter_xfs_io
+# Create a 100M file for later scrub workload.
+$XFS_IO_PROG -f -c "pwrite 0 100M" $SCRATCH_MNT/file | _filter_xfs_io
 
 # Writeback above data, as scrub only verify the committed data.
 sync
diff --git a/tests/btrfs/282.out b/tests/btrfs/282.out
index 8d53e7eb..840e3826 100644
--- a/tests/btrfs/282.out
+++ b/tests/btrfs/282.out
@@ -1,3 +1,3 @@
 QA output created by 282
-wrote 2147483648/2147483648 bytes at offset 0
+wrote 104857600/104857600 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-- 
2.35.3

