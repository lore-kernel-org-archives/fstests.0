Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035CBD73
	for <fstests@vger.kernel.org>; Wed,  6 Dec 2023 23:21:09 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 91E4E1F86B;
	Thu,  7 Dec 2023 07:21:07 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A947513976;
	Thu,  7 Dec 2023 07:21:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kIkREWFycWXdGAAAD6G6ig
	(envelope-from <ddiss@suse.de>); Thu, 07 Dec 2023 07:21:05 +0000
From: David Disseldorp <ddiss@suse.de>
To: fstests@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH 1/5] common/dmdelay: remove DELAY_X enums
Date: Thu,  7 Dec 2023 18:20:52 +1100
Message-Id: <20231207072056.14588-2-ddiss@suse.de>
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
X-Rspamd-Queue-Id: 91E4E1F86B
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

The DELAY_NONE and DELAY_READ enums map directly to DELAY_TABLE globals,
so remove the indirection and use the DELAY_TABLE variables instead.
Rename DELAY_TABLE to DELAY_TABLE_NODELAY to better reflect that the
table doesn't specify any IO delays.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 common/dmdelay | 13 ++++---------
 tests/xfs/311  |  2 +-
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/common/dmdelay b/common/dmdelay
index 66cac1a7..e85d8d62 100644
--- a/common/dmdelay
+++ b/common/dmdelay
@@ -4,16 +4,13 @@
 #
 # common functions for setting up and tearing down a dmdelay device
 
-DELAY_NONE=0
-DELAY_READ=1
-
 _init_delay()
 {
 	local BLK_DEV_SIZE=`blockdev --getsz $SCRATCH_DEV`
 	DELAY_DEV=/dev/mapper/delay-test
-	DELAY_TABLE="0 $BLK_DEV_SIZE delay $SCRATCH_DEV 0 0"
+	DELAY_TABLE_NODELAY="0 $BLK_DEV_SIZE delay $SCRATCH_DEV 0 0"
 	DELAY_TABLE_RDELAY="0 $BLK_DEV_SIZE delay $SCRATCH_DEV 0 10000 $SCRATCH_DEV 0 0"
-	_dmsetup_create delay-test --table "$DELAY_TABLE" || \
+	_dmsetup_create delay-test --table "$DELAY_TABLE_NODELAY" || \
 		_fatal "failed to create delay device"
 }
 
@@ -44,10 +41,8 @@ _cleanup_delay()
 # table
 _load_delay_table()
 {
-	table="$DELAY_TABLE"
-	[ $1 -eq $DELAY_READ ] && table="$DELAY_TABLE_RDELAY"
-
-	suspend_opt="--nolockfs"
+	local table="$1"
+	local suspend_opt="--nolockfs"
 	[ $# -gt 1 ] && [ $2 -eq 1 ] && suspend_opt=""
 
 	# run a suspend/resume cycle to avoid excessive resume delays once a
diff --git a/tests/xfs/311 b/tests/xfs/311
index d5e3afbf..04161750 100755
--- a/tests/xfs/311
+++ b/tests/xfs/311
@@ -50,7 +50,7 @@ _unmount_delay
 _mount_delay
 
 # introduce a read I/O delay
-_load_delay_table $DELAY_READ
+_load_delay_table "$DELAY_TABLE_RDELAY"
 
 # Map the directory and immediately unmount. This should invoke an asynchronous
 # readahead on the first block of the directory. The readahead is delayed by
-- 
2.35.3

