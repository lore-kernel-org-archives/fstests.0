Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C38F1AD
	for <fstests@vger.kernel.org>; Wed,  6 Dec 2023 23:21:14 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 16D901F86B;
	Thu,  7 Dec 2023 07:21:13 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 042C313976;
	Thu,  7 Dec 2023 07:21:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4OpWJGZycWXdGAAAD6G6ig
	(envelope-from <ddiss@suse.de>); Thu, 07 Dec 2023 07:21:10 +0000
From: David Disseldorp <ddiss@suse.de>
To: fstests@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH 3/5] btrfs/282: dmdelay scrub I/O to fix intermittent failures
Date: Thu,  7 Dec 2023 18:20:54 +1100
Message-Id: <20231207072056.14588-4-ddiss@suse.de>
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
X-Spamd-Bar: +++++++++++++++++
Authentication-Results: smtp-out2.suse.de;
	dkim=none;
	dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.de (policy=none);
	spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither permitted nor denied by domain of ddiss@suse.de) smtp.mailfrom=ddiss@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [17.45 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 FROM_HAS_DN(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 R_SPF_SOFTFAIL(4.60)[~all:c];
	 NEURAL_SPAM_SHORT(2.16)[0.722];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 DMARC_POLICY_SOFTFAIL(0.10)[suse.de : No valid SPF, No valid DKIM,none]
X-Spam-Score: 17.45
X-Rspamd-Queue-Id: 16D901F86B

btrfs/282 can fail intermittently if scrub completes quickly (e.g. atop
  a RAM backed scratch device):
- if under one second, the reported scrub duration metric may be rounded
  down to zero, which results in a "Rate: 0/s" metric
  + I have a btrfs-progs patch to address this confusing Rate reporting
- I've also observed one second scrub durations fail intermittently,
  presumably because scheduling jitter doesn't allow throttling to take
  effect

Avoid these intermittent failures by injecting a 100ms delay to device
read I/Os using dm-delay.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 tests/btrfs/282 | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/tests/btrfs/282 b/tests/btrfs/282
index 66d14f82..f9e22e12 100755
--- a/tests/btrfs/282
+++ b/tests/btrfs/282
@@ -10,6 +10,15 @@
 _begin_fstest auto scrub
 
 . ./common/filter
+. ./common/dmdelay
+
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+	_scratch_unmount > /dev/null 2>&1
+	_cleanup_delay > /dev/null 2>&1
+}
 
 # real QA test starts here
 _supported_fs btrfs
@@ -18,6 +27,7 @@ _wants_kernel_commit eb3b50536642 \
 
 # We want at least 5G for the scratch device.
 _require_scratch_size $(( 5 * 1024 * 1024))
+_require_dm_target delay
 
 # Make sure we can create scrub progress data file
 if [ -e /var/lib/btrfs ]; then
@@ -27,7 +37,8 @@ else
 fi
 
 _scratch_mkfs >> $seqres.full 2>&1
-_scratch_mount
+_init_delay
+_mount_delay
 
 uuid=$(findmnt -n -o UUID $SCRATCH_MNT)
 
@@ -45,6 +56,10 @@ $XFS_IO_PROG -f -c "pwrite -i /dev/urandom 0 2G" $SCRATCH_MNT/file | _filter_xfs
 # Writeback above data, as scrub only verify the committed data.
 sync
 
+# 100ms read I/O delay, so that the scrub doesn't complete too quickly
+bs=$(blockdev --getsz $SCRATCH_DEV)
+_load_delay_table "0 $bs delay $SCRATCH_DEV 0 100 $SCRATCH_DEV 0 0"
+
 # The first scrub, mostly to grab the speed of the scrub.
 $BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >> $seqres.full
 
@@ -70,7 +85,8 @@ if [ -z "$init_speed" ]; then
 fi
 
 # Cycle mount to drop any possible cache.
-_scratch_cycle_mount
+_unmount_delay
+_mount_delay
 
 target_speed=$(( $init_speed / 2 ))
 echo "$target_speed" > "${devinfo_dir}/scrub_speed_max"
-- 
2.35.3

