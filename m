Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988D4137
	for <fstests@vger.kernel.org>; Wed,  6 Dec 2023 23:21:11 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 40E0B1F86B;
	Thu,  7 Dec 2023 07:21:10 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 56EE813976;
	Thu,  7 Dec 2023 07:21:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eEJsOGNycWXdGAAAD6G6ig
	(envelope-from <ddiss@suse.de>); Thu, 07 Dec 2023 07:21:07 +0000
From: David Disseldorp <ddiss@suse.de>
To: fstests@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH 2/5] btrfs/282: append scrub status output to 282.full
Date: Thu,  7 Dec 2023 18:20:53 +1100
Message-Id: <20231207072056.14588-3-ddiss@suse.de>
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
X-Rspamd-Queue-Id: 40E0B1F86B
X-Spam-Score: 4.99
X-Spamd-Result: default: False [4.99 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 R_SPF_SOFTFAIL(0.00)[~all:c];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 DMARC_POLICY_SOFTFAIL(0.10)[suse.de : No valid SPF, No valid DKIM,none]
X-Spamd-Bar: ++++
Authentication-Results: smtp-out2.suse.de;
	dkim=none;
	dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.de (policy=none);
	spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither permitted nor denied by domain of ddiss@suse.de) smtp.mailfrom=ddiss@suse.de
X-Rspamd-Server: rspamd1

Also, collapse the grep/cut usage into the existing awk one-liner.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 tests/btrfs/282 | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tests/btrfs/282 b/tests/btrfs/282
index 395e0626..66d14f82 100755
--- a/tests/btrfs/282
+++ b/tests/btrfs/282
@@ -60,8 +60,9 @@ $BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >> $seqres.full
 # Error summary:    no errors found
 #
 # What we care is that Rate line.
-init_speed=$($BTRFS_UTIL_PROG scrub status --raw $SCRATCH_MNT | grep "Rate:" |\
-	     $AWK_PROG '{print $2}' | cut -f1 -d\/)
+init_speed=$($BTRFS_UTIL_PROG scrub status --raw $SCRATCH_MNT |\
+	     tee -a $seqres.full |\
+	     $AWK_PROG '$1 == "Rate:" {sub(/\/s/, "", $2); print $2}')
 
 # This can happen for older progs
 if [ -z "$init_speed" ]; then
@@ -76,8 +77,9 @@ echo "$target_speed" > "${devinfo_dir}/scrub_speed_max"
 
 # The second scrub, to check the throttled speed.
 $BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >> $seqres.full
-speed=$($BTRFS_UTIL_PROG scrub status --raw $SCRATCH_MNT | grep "Rate:" |\
-	     $AWK_PROG '{print $2}' | cut -f1 -d\/)
+speed=$($BTRFS_UTIL_PROG scrub status --raw $SCRATCH_MNT |\
+	tee -a $seqres.full |\
+	$AWK_PROG '$1 == "Rate:" {sub(/\/s/, "", $2); print $2}')
 
 # We gave a +- 10% tolerance for the throttle
 if [ "$speed" -gt "$(( $target_speed * 11 / 10 ))" -o \
-- 
2.35.3

