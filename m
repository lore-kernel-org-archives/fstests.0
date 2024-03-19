Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C6E39AC4
	for <fstests@vger.kernel.org>; Tue, 19 Mar 2024 18:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710872362; cv=none; b=T8RoVD5/+wPBOiJGICvGkJVXGZECPIMMDvY4i9fVDBjR6cXqlTzQd/5xD6esfrp7Ju8y3X0bEPJPSO2SHy5vATl2NuD5dOdRMQK26tpEGlQr20riFyVY1JAPTNP/SEt2HXtLhNF4aR2/x3HzzcwXK79hiMjzkiFflczaKjgDgf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710872362; c=relaxed/simple;
	bh=VpfWbvqlzmlV7My27EaFB+8tLwd3H8iNEZQ+IH6yT9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FR3DCRlns+cJPNY2zaw8EEJIfaOq2A4AY3RQMFF9T3VuKAMKOtHnYJBAo4g7aEs7cROFvcVuNSQYvcaynl4FueRoqZza0QBVwmSBG/lzB4QWB4R3TK/4/ev23ZP9CVKfuiyHzljZD3P9lTJeUClXLQcVqMf/4tnww/3iim2xD30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=JLnmRFK8; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=JLnmRFK8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="JLnmRFK8";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="JLnmRFK8"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3EDC61F452;
	Tue, 19 Mar 2024 18:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710872358; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m5rpm77qAK+UprBCeQ3XKGYtoANHLeJejOZxjeFScDU=;
	b=JLnmRFK8BBd1uXOJvF22scpZYIeviPoEe+jF5CHiLOVNW9M+QumEzq9GGupghFLsIzwyoJ
	9cxAQu9QPtvchRfijAu1/lNFsrLhTvCH3o6oO/2B2DGB+g2s1Aj/Jmriqn8BHWf+Appk00
	ICs/LGRe1X4WHz/F2BMLbo7xCiUAh5Q=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710872358; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m5rpm77qAK+UprBCeQ3XKGYtoANHLeJejOZxjeFScDU=;
	b=JLnmRFK8BBd1uXOJvF22scpZYIeviPoEe+jF5CHiLOVNW9M+QumEzq9GGupghFLsIzwyoJ
	9cxAQu9QPtvchRfijAu1/lNFsrLhTvCH3o6oO/2B2DGB+g2s1Aj/Jmriqn8BHWf+Appk00
	ICs/LGRe1X4WHz/F2BMLbo7xCiUAh5Q=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 382E5136D6;
	Tue, 19 Mar 2024 18:19:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Fxy1DSbX+WWSSwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 19 Mar 2024 18:19:18 +0000
From: David Sterba <dsterba@suse.com>
To: fstests@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 3/5] btrfs/330: add test to validate ro/rw subvol mounting
Date: Tue, 19 Mar 2024 19:12:05 +0100
Message-ID: <d61b8bd818a8f9403982f532ac21586f6c96269c.1710871719.git.dsterba@suse.com>
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
X-Spam-Score: 0.52
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=JLnmRFK8
X-Spamd-Bar: /
X-Spam-Flag: NO
X-Spamd-Result: default: False [0.52 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
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
	 NEURAL_HAM_SHORT(-0.17)[-0.848];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 3EDC61F452

From: Josef Bacik <josef@toxicpanda.com>

Btrfs has had the ability for almost a decade to allow ro and rw
mounting of subvols.  This behavior specifically

mount -o subvol=foo,ro /some/dir
mount -o subvol=bar,rw /some/other/dir

This seems simple, but because of the limitations of how we did mounting
in ye olde days we would mark the super block as RO and the mount if we
mounted RO first.  In the case above /some/dir would instantiate the
super block as read only and the mount point.  So the second mount
command under the covers would convert the super block to RW, and then
allow the mount to continue.

The results were still consistent, /some/dir was still read only because
the mount was marked read only, but /some/other/dir could be written to.

This is a test to make sure we maintain this behavior, as I almost
regressed this behavior while converting us to the new mount API.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/btrfs/330     | 54 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/330.out |  6 +++++
 2 files changed, 60 insertions(+)
 create mode 100755 tests/btrfs/330
 create mode 100644 tests/btrfs/330.out

diff --git a/tests/btrfs/330 b/tests/btrfs/330
new file mode 100755
index 00000000000000..3ce9840e76d028
--- /dev/null
+++ b/tests/btrfs/330
@@ -0,0 +1,54 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2023 Meta Platforms, Inc.  All Rights Reserved.
+#
+# FS QA Test No. btrfs/330
+#
+# Test mounting one subvolume as ro and another as rw
+#
+. ./common/preamble
+_begin_fstest auto quick subvol
+
+_cleanup()
+{
+	rm -rf $TEST_DIR/$seq
+}
+
+# Import common functions.
+. ./common/filter
+. ./common/filter.btrfs
+
+# real QA test starts here
+_supported_fs btrfs
+_require_scratch
+
+$MOUNT_PROG -V | grep -q 'fd-based-mount'
+[ "$?" -eq 0 ] && _notrun "mount uses the new mount api"
+
+_scratch_mkfs > /dev/null 2>&1
+_scratch_mount
+
+# Create our subvolumes to mount
+$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/foo | _filter_scratch
+$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/bar | _filter_scratch
+
+_scratch_unmount
+
+mkdir -p $TEST_DIR/$seq/foo
+mkdir -p $TEST_DIR/$seq/bar
+
+_mount -t btrfs -o subvol=foo,ro $SCRATCH_DEV $TEST_DIR/$seq/foo
+_mount -t btrfs -o subvol=bar,rw $SCRATCH_DEV $TEST_DIR/$seq/bar
+
+echo "making sure foo is read only"
+touch $TEST_DIR/$seq/foo/baz > /dev/null 2&>1
+ls $TEST_DIR/$seq/foo
+
+echo "making sure bar allows writes"
+touch $TEST_DIR/$seq/bar/qux
+ls $TEST_DIR/$seq/bar
+
+$UMOUNT_PROG $TEST_DIR/$seq/foo
+$UMOUNT_PROG $TEST_DIR/$seq/bar
+
+status=0 ; exit
diff --git a/tests/btrfs/330.out b/tests/btrfs/330.out
new file mode 100644
index 00000000000000..4795a2ccc8cb62
--- /dev/null
+++ b/tests/btrfs/330.out
@@ -0,0 +1,6 @@
+QA output created by 330
+Create subvolume 'SCRATCH_MNT/foo'
+Create subvolume 'SCRATCH_MNT/bar'
+making sure foo is read only
+making sure bar allows writes
+qux
-- 
2.42.1

