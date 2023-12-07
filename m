Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="n0klsBdR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7jdEAuxx"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B199D53
	for <fstests@vger.kernel.org>; Wed,  6 Dec 2023 23:21:20 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 97A801F86B;
	Thu,  7 Dec 2023 07:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1701933678; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i/rqbQDCPwLDaShfjIjOsG/Sa4ilRPeHucrzmdgp7RU=;
	b=n0klsBdR2BJGf/0su7gIJW7Clah53kyf5haFm59k/D22fvZV7NWPChBIiwr/7QqW311nJ9
	53yCd3FlrVZX97WpMYuV0fXi0nMOF2Ki13ZBb2D218ytu+nTQHHs7lQyAcsZd5CME0jVV+
	IklNBf7Cy/EObwGXFPetJzCyrx/mpZw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1701933678;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i/rqbQDCPwLDaShfjIjOsG/Sa4ilRPeHucrzmdgp7RU=;
	b=7jdEAuxx6l6pUmT+89XUJOSScm/ubAUegtNKzCS93dO4cZZOJaz575eF0kc3niF+XgfT7F
	8YBTSkPB0XiSvNAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8AB8C13976;
	Thu,  7 Dec 2023 07:21:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iLhMDmxycWXdGAAAD6G6ig
	(envelope-from <ddiss@suse.de>); Thu, 07 Dec 2023 07:21:16 +0000
From: David Disseldorp <ddiss@suse.de>
To: fstests@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH 5/5] btrfs/282: increase throttled scrub rate tolerance
Date: Thu,  7 Dec 2023 18:20:56 +1100
Message-Id: <20231207072056.14588-6-ddiss@suse.de>
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
X-Spam-Score: 6.09
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [6.09 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_SPAM(1.19)[83.35%];
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

Even with dmdelay injected latencies, I still observe occasional test
failures on shared storage (e.g. VMs). The extra 10% tolerance resolves
these intermittent failures on my system.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 tests/btrfs/282 | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tests/btrfs/282 b/tests/btrfs/282
index 42d992a6..6649623a 100755
--- a/tests/btrfs/282
+++ b/tests/btrfs/282
@@ -95,9 +95,8 @@ speed=$($BTRFS_UTIL_PROG scrub status --raw $SCRATCH_MNT |\
 	tee -a $seqres.full |\
 	$AWK_PROG '$1 == "Rate:" {sub(/\/s/, "", $2); print $2}')
 
-# We gave a +- 10% tolerance for the throttle
-if [ "$speed" -gt "$(( $target_speed * 11 / 10 ))" -o \
-     "$speed" -lt "$(( $target_speed * 9 / 10))" ]; then
+# We gave a +- 20% tolerance for the throttle
+if (( speed > target_speed * 12 / 10 || speed < target_speed * 8 / 10 )); then
 	echo "scrub speed $speed Bytes/s is not properly throttled, target is $target_speed Bytes/s"
 fi
 
-- 
2.35.3

