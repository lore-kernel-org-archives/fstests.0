Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE55F286280
	for <fstests@vger.kernel.org>; Wed, 19 Feb 2025 22:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740003468; cv=none; b=Q6Vu5DYvLiMnnS09m4fh+ViLhLsufNNHQuWje7J9+GmIOE7L4hdDO1NNr+BCQITubgptmNEAkkkDtb1+Tv2v39j09fjj4+9OuJCvCUI1VB3aMZvRy17lQ6ucm7RgiDZWV/snQKkCiXIb5jQWNWlg0UY+lLaKFG8Yb9hhBX8kX04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740003468; c=relaxed/simple;
	bh=wMsgsaaUFcQa2Y04H9cuqalNpLgZfZ03Z5zzXevky2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d5pSJ4J/wHTXUUggdRq09CPwx+brmrevzzuU6EI3gii6ueAHi04atC9U1ajMYCqeStL6+NtOG19zqUW+T5G8FE0MiMFp8DKE/kKqWYYL0bdyLmIkhoGg2DFCLyBama1EEyAoASOQOGfY1Gx043Pl3mYNImWr5a2XK31BBnscbWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=AfhMJ2fe; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KMLcItQq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="AfhMJ2fe";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KMLcItQq"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E10071F7A1;
	Wed, 19 Feb 2025 22:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740003464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=e1/2E+VoTOs/0HdsBIU+KMCkNaPL8iu2pOcDkFGkQmw=;
	b=AfhMJ2fe+NZ0xfDZzM2jAsdsJDWzu61yzCxrdAeZ30bLmfdEGfkp/KSt1tODZqG9qe3I3e
	/Bu6MVQ/Z/d2B9ZUDwZ3Xg5P9FXj5aqe5gJl9uQBJ+CA1cJYQjSlXgjQrtzjOiIupHg8Qm
	F6Sepn7aZ9j3rONXRfF6/Q2n4g+IfMk=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740003463; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=e1/2E+VoTOs/0HdsBIU+KMCkNaPL8iu2pOcDkFGkQmw=;
	b=KMLcItQq9D84JgN2Byknh+ZNs28S23l2yPCBPgjObF2cCxPvj9Ol4LP6Q2Qg/huKKB5D6Y
	w3hkB23F+SG7V3LeCxJjDnQcc6OYopqESTvjkXq5F3G03RpnWDBrOpuFXH7hjeAsaxmJex
	tbKytnUzlKfY2KhGIL7cXoUKTTHJ0QU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA18F13715;
	Wed, 19 Feb 2025 22:17:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MFA5NYdYtmevMwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 19 Feb 2025 22:17:43 +0000
From: David Sterba <dsterba@suse.com>
To: fstests@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH] fstests: remove reiserfs support
Date: Wed, 19 Feb 2025 23:17:43 +0100
Message-ID: <20250219221743.20161-1-dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
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
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

The linux kernel removed Reiserfs support in 6.13 so remove it from the
tests as well.

Signed-off-by: David Sterba <dsterba@suse.com>
---

Arguably reiser4 support could be removed as well as there's no recent
upstream activity.

 common/config     | 7 -------
 common/quota      | 4 ++--
 common/rc         | 5 +----
 tests/generic/740 | 4 ----
 4 files changed, 3 insertions(+), 17 deletions(-)

diff --git a/common/config b/common/config
index 77f3fc153eb731..a9a1ce6c3655cf 100644
--- a/common/config
+++ b/common/config
@@ -384,10 +384,6 @@ _common_mount_opts()
 	f2fs)
 		echo "-o acl,user_xattr $F2FS_MOUNT_OPTIONS"
 		;;
-	reiserfs)
-		# acls & xattrs aren't turned on by default on reiserfs
-		echo "-o acl,user_xattr $REISERFS_MOUNT_OPTIONS"
-		;;
        reiser4)
 		# acls & xattrs aren't supported by reiser4
 		echo $REISER4_MOUNT_OPTIONS
@@ -441,9 +437,6 @@ _mkfs_opts()
 	ceph)
 		export MKFS_OPTIONS=$CEPHFS_MKFS_OPTIONS
 		;;
-	reiserfs)
-		export MKFS_OPTIONS="$REISERFS_MKFS_OPTIONS -q"
-		;;
        reiser4)
 		export MKFS_OPTIONS=$REISER4_MKFS_OPTIONS
 		;;
diff --git a/common/quota b/common/quota
index 8688116c6547a9..9c3d1bb4ace4bb 100644
--- a/common/quota
+++ b/common/quota
@@ -12,7 +12,7 @@ _require_quota()
     [ -n "$QUOTA_PROG" ] || _notrun "Quota user tools not installed"
 
     case $FSTYP in
-    ext2|ext3|ext4|f2fs|reiserfs)
+    ext2|ext3|ext4|f2fs)
 	if [ ! -d /proc/sys/fs/quota ]; then
 	    _notrun "Installed kernel does not support quotas"
 	fi
@@ -347,7 +347,7 @@ _check_quota_usage()
 
 	VFS_QUOTA=0
 	case $FSTYP in
-	ext2|ext3|ext4|f2fs|reiserfs|gfs2|bcachefs)
+	ext2|ext3|ext4|f2fs|gfs2|bcachefs)
 		VFS_QUOTA=1
 		quotaon -f -u -g $SCRATCH_MNT 2>/dev/null
 		;;
diff --git a/common/rc b/common/rc
index 6840bb1dfa1001..9d16df5fc0d5ae 100644
--- a/common/rc
+++ b/common/rc
@@ -1163,7 +1163,7 @@ _try_scratch_mkfs_sized()
 	btrfs)
 		def_blksz=`echo $MKFS_OPTIONS | sed -rn 's/.*-s ?+([0-9]+).*/\1/p'`
 		;;
-	ext2|ext3|ext4|reiser4|ocfs2|reiserfs)
+	ext2|ext3|ext4|reiser4|ocfs2)
 		def_blksz=`echo $MKFS_OPTIONS | sed -rn 's/.*-b ?+([0-9]+).*/\1/p'`
 		;;
 	udf)
@@ -1267,9 +1267,6 @@ _try_scratch_mkfs_sized()
 	jfs)
 		${MKFS_PROG} -t $FSTYP $MKFS_OPTIONS "$@" $SCRATCH_DEV $blocks
 		;;
-	reiserfs)
-		${MKFS_PROG} -t $FSTYP $MKFS_OPTIONS -b $blocksize "$@" $SCRATCH_DEV $blocks
-		;;
 	reiser4)
 		# mkfs.resier4 requires size in KB as input for creating filesystem
 		$MKFS_REISER4_PROG $MKFS_OPTIONS -y -b $blocksize "$@" $SCRATCH_DEV \
diff --git a/tests/generic/740 b/tests/generic/740
index 10817521cc9342..c167dbef2ff68a 100755
--- a/tests/generic/740
+++ b/tests/generic/740
@@ -63,10 +63,6 @@ do
 		# "quick" format that doesn't zero the entire device
 		postargs="--quick"
 		;;
-	reiserfs|reiser4)
-		preop="echo y |"
-		preargs="-f"
-		;;
 	*)
 		;;
 	esac
-- 
2.47.1

