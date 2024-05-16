Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996FD15821F
	for <fstests@vger.kernel.org>; Thu, 16 May 2024 22:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715897561; cv=none; b=XB6sxWCuAemg9y8eaNzAtSp7ABRx+JyIKl8hrXkVEtoVUz8pOGKnIFE6/mmvt6Ni/+I+8ZJD8qHM+1UTMvl1acWOil1v0hhSYAtVNzcl3thJRyFDwA0wOZx+ITPSdNIngYOQ8eLL3LjJOgS/qjcyWfNKOThaqNJQ5yUnUJ0eXYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715897561; c=relaxed/simple;
	bh=8HJmJZtdlzf7X+YxXzFnW1hUlQgBxT3u2vASJ0+zkSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rxmyiHVWhehureL7dZZN9tqBAXe5cQOSuxhIFoq22feYDhNc+rWoBED7qBfZ+dY5WS3YEsFk/wJo0183Jeb3R1scamSV7JR0LTLIB86vhddd+WxzC4gSHCX5dq8PdJKZX9vT/3OqcqJhAVpIZT+FHp5yMTYlk+yR/iPIIsjYYzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lFTiVMBS; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lFTiVMBS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lFTiVMBS";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lFTiVMBS"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9175035053;
	Thu, 16 May 2024 22:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715897557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x8GaMlikI0vNO3EFo21lee30YWTAneskF0BNlhLvoco=;
	b=lFTiVMBSEYStFMVjJcMgvpspXwpdKwWoZFrlGS4WlXzmwCJnS9acPKl8MoFcsAsP9gDKb5
	tfgFlz3bDquR+sz1fKRCTb2sglDTKlfhUrhz/FDn733nuOTKrglmweU5J8NkdhSStbiHey
	XoL5W6I7HHhCWkQLDOr6NneBSNaJ4bA=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715897557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x8GaMlikI0vNO3EFo21lee30YWTAneskF0BNlhLvoco=;
	b=lFTiVMBSEYStFMVjJcMgvpspXwpdKwWoZFrlGS4WlXzmwCJnS9acPKl8MoFcsAsP9gDKb5
	tfgFlz3bDquR+sz1fKRCTb2sglDTKlfhUrhz/FDn733nuOTKrglmweU5J8NkdhSStbiHey
	XoL5W6I7HHhCWkQLDOr6NneBSNaJ4bA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8ADCD137C3;
	Thu, 16 May 2024 22:12:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jj7lIdWERmZuZAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 16 May 2024 22:12:37 +0000
From: David Sterba <dsterba@suse.com>
To: fstests@vger.kernel.org
Cc: josef@toxicpanda.com,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 1/6] common: udev settle before _scratch_pool_mkfs
Date: Fri, 17 May 2024 00:12:33 +0200
Message-ID: <b8e39744f98bde6484d222c6e90240f074df1eaf.1715896529.git.dsterba@suse.com>
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
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
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
X-Spam-Score: -6.80
X-Spam-Flag: NO

From: Josef Bacik <josef@toxicpanda.com>

There are some btrfs tests that do _scratch_pool_mkfs in a loop.
Sometimes this fails with EBUSY.  Tracing revealed that udevd will
sometimes write to /sys/block/device/uevent to make sure an event
triggers to rules get written.  However these events will not get sent
to user space until after an O_EXCL open as been closed.  The general
flow is something like

mkfs.btrfs /dev/sda /dev/sdb /dev/sdc /dev/sdd
mount /dev/sda /mnt/test
<things>
umount /mnt/test

in a loop.  The problem is udevd will add uevents for the devices and
they won't get delivered until after the umount.  If we're doing the
above sequence in a loop the next mkfs.btrfs will fail because udev is
touching the devices to consume the KOBJ_CHANGE event.

Fix this by doing a udev settle before _scratch_pool_mkfs.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 common/rc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/common/rc b/common/rc
index 0fe56382a6a497..5d38571ffe87eb 100644
--- a/common/rc
+++ b/common/rc
@@ -903,6 +903,12 @@ _scratch_pool_mkfs()
 {
     case $FSTYP in
     btrfs)
+	# For multi-disk file systems udev can queue up events on the device
+	# when we mkfs the device, and thus tie up the device after we've
+	# unmounted.  Tests that _scratch_pool_mkfs() in a loop can sometimes
+	# trip over udev trying to do the updates after the umount, so make sure
+	# we settle before we try mkfs'ing so we don't get an EBUSY
+	$UDEV_SETTLE_PROG >/dev/null 2>&1
         $MKFS_BTRFS_PROG $MKFS_OPTIONS $* $SCRATCH_DEV_POOL > /dev/null
         ;;
     *)
-- 
2.45.0

