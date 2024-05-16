Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67F83FE4
	for <fstests@vger.kernel.org>; Thu, 16 May 2024 22:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715897574; cv=none; b=qqYQEZ7/ILC44D4OfJKZEcwQApz5cc7/klIb0iqV18lubdzsoGwbkGPxYD+D5HWKQA3sCNumCisq95cp4E358fFj/Q8zjlvflsveTaqvqDQmUyPGtGkSES+9JzbDhvp+CNjDMpfmTjvlzNM1P5Or3+ii4qPPi9c2ZuOpp2Hfy3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715897574; c=relaxed/simple;
	bh=kr79FLlesgvWXYM0MJ+3wQ3nnLs90oOT+xL3h/x/LhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vqk27mprNQlNrEeoHHOWQf54xXzR7VOhpsxaFyW1kZ4RKQdeDaoQ9iK/eT8plmd19M41Z036EXTpFTIc9zpoJ+P0r5DqgzOMFIWAuJNw1lW82wwmE6pbLb8XWBJOj21aWZ0XVHsMQ98Upc1n7RJ5QCUxmxJ63Ylksw4X5lJkhvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 13E1B35055;
	Thu, 16 May 2024 22:12:51 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0DE2E137C3;
	Thu, 16 May 2024 22:12:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wzNiA+OERmbTaAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 16 May 2024 22:12:51 +0000
From: David Sterba <dsterba@suse.com>
To: fstests@vger.kernel.org
Cc: josef@toxicpanda.com,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 5/6] btrfs/011: mkfs the scratch dev before exiting
Date: Fri, 17 May 2024 00:12:50 +0200
Message-ID: <19804c4e3c319678768d5d24a15b000e05dd0af2.1715896529.git.dsterba@suse.com>
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
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 13E1B35055
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action

From: Josef Bacik <josef@toxicpanda.com>

When testing encryption I started getting failures because the scratch
dev didn't have a valid fs at the end of the test.  This is because for
encryption we have to disable raid5/6, which changes how the test is
run.

Normally with raid6 we end up cancelling the device replace, and thus
$SCRATCH_DEV has a valid file system on it.  However with raid5/6
disabled we end with a normal DUP profile, and the replace doesn't end
up cancelled, so $SCRATCH_DEV is wiped.  Then when the test finishes we
do the normal fsck and see that there's no fs on the $SCRATCH_DEV and
error.

This test does all the fsck'ing during the workout period, so we don't
need the final scratch check, simply re-make the $SCRATCH_DEV at the end
as it could have been replaced during the test.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 tests/btrfs/011 | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/btrfs/011 b/tests/btrfs/011
index bf63a72b11c42f..d99624fb941cce 100755
--- a/tests/btrfs/011
+++ b/tests/btrfs/011
@@ -258,6 +258,11 @@ for t in "-m single -d single:1 no 64" \
 	fi
 done
 
+# If we exclude certain RAID profiles we can end up where the scratch dev
+# doesn't have a valid fs on it because it was replaced during workout, so mkfs
+# the scratch device so we don't get _check_btrfs_filesystem errors
+_scratch_mkfs > /dev/null 2>&1
+
 echo "*** done"
 status=0
 exit
-- 
2.45.0

