Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4AD2DB7B4
	for <fstests@vger.kernel.org>; Mon,  3 Aug 2026 12:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785758467; cv=none; b=SASPbN8MSbxc/qhj7MS0c0qPQXinS7eeJm5Q7sQOka+LKMNMiVxOmmAObWjdp80DewjRM7XjOcux2Ma7Rqk4s6pzVzKzlrj+H3ZIYVuk09CfYpsxW420YM1dNgAVuU5ldNX9Vik/ijFaZ5/RVHHfpHi3RrPyXgCW6C6nPAaDkb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785758467; c=relaxed/simple;
	bh=a60X0M+1uRJrbbXUWcAlZZWHatS8DnR42KwUA+F72VU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ra+eTi/dzc0abY+RWIKbtXsi1dc/iV9NfPeBwmRCwQYarh3Lv+Bsni3lvyfQpG6315+RfO4rMcXW1mU+aisjvu6ztpZJMrPceSZ918UyY9X9s6duLttCXZ1c2T48uulVYBlF+X6XXCYMoFk/YNujzNSdX6iQfybqeyIKL1ntoXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=u9QADXXx; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bUByuuCE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="u9QADXXx";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bUByuuCE"
Received: from localhost.localdomain (unknown [10.128.32.2])
	by smtp-out2.suse.de (Postfix) with ESMTP id E266A3FFF
	for <fstests@vger.kernel.org>; Mon,  3 Aug 2026 12:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1785758460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=9J01DHN7hRkQ1hBKHfXpSZ8xmLxnmRfn58soisiWCco=;
	b=u9QADXXxAwthvYB6JA4G3hXDgHjfPlM0DfsSbL26VnM5xunz6WWMMGM5dRSkozKzSrsNNF
	FGQnLLHBGmf7CjMxBlBMkxkvWDV5lV9ymY4MEg2R6quKdRR/omTXEFHiM6QveeJdZUk7JA
	5PSk1XxxT10grBQnV6OXtWPnhZsqwok=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1785758455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=9J01DHN7hRkQ1hBKHfXpSZ8xmLxnmRfn58soisiWCco=;
	b=bUByuuCEb4M3Ck88i7pCEBhX6euN7DO62kWHhK+8rNcx7QLaM5rTkdJhEB55NvfGVluSFb
	i7CoYnez79SqsfR5TOs827RKJOE80dbajEZnrd5GP3pLKyCKFgzCu6rE81VAW/LPiSRzr2
	hJl7Qevto/K7vEKHpD0v/JojICR4Bng=
From: Anthony Iliopoulos <ailiop@suse.com>
To: fstests@vger.kernel.org
Subject: [PATCH] xfs: use -w instead of --path for man program portability
Date: Mon,  3 Aug 2026 13:58:19 +0200
Message-ID: <20260803115819.17110-1-ailiop@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	URIBL_BLOCKED(0.00)[suse.com:mid,suse.com:email,localhost.localdomain:helo];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,localhost.localdomain:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

Some implementations of man(1) do not support the long option --path to
display the actual location of a man page, which can cause these tests
to fail on systems using alternative man packages, such as mandoc.

Switch to using the more standard -w flag across these tests to improve
portability while maintaining the same behavior, given that the --path
option is just an alias to -w in the standard man-db utility.

Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
---
 tests/xfs/293 | 2 +-
 tests/xfs/505 | 2 +-
 tests/xfs/514 | 2 +-
 tests/xfs/515 | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/xfs/293 b/tests/xfs/293
index 3e887f1c40cf..9735c441ab32 100755
--- a/tests/xfs/293
+++ b/tests/xfs/293
@@ -19,7 +19,7 @@ _require_command "$MAN_PROG" man
 
 echo "Silence is golden"
 
-MANPAGE=`$MAN_PROG --path xfs_io`
+MANPAGE=`$MAN_PROG -w xfs_io`
 
 case "$MANPAGE" in
 *.gz|*.z\|*.Z)	CAT=zcat;;
diff --git a/tests/xfs/505 b/tests/xfs/505
index 81f53ffac23d..f0f435241dda 100755
--- a/tests/xfs/505
+++ b/tests/xfs/505
@@ -16,7 +16,7 @@ _require_command "$MAN_PROG" man
 
 echo "Silence is golden"
 
-MANPAGE=$($MAN_PROG --path xfs_spaceman)
+MANPAGE=$($MAN_PROG -w xfs_spaceman)
 
 case "$MANPAGE" in
 *.gz|*.z\|*.Z)	CAT=zcat;;
diff --git a/tests/xfs/514 b/tests/xfs/514
index d3641c3e1af6..215ae5e7cc5a 100755
--- a/tests/xfs/514
+++ b/tests/xfs/514
@@ -24,7 +24,7 @@ _require_test
 
 echo "Silence is golden"
 
-MANPAGE=$($MAN_PROG --path xfs_db)
+MANPAGE=$($MAN_PROG -w xfs_db)
 
 case "$MANPAGE" in
 *.gz|*.z\|*.Z)	CAT=zcat;;
diff --git a/tests/xfs/515 b/tests/xfs/515
index 7d6e99405972..0596457e5adc 100755
--- a/tests/xfs/515
+++ b/tests/xfs/515
@@ -24,7 +24,7 @@ _require_test
 
 echo "Silence is golden"
 
-MANPAGE=$($MAN_PROG --path xfs_quota)
+MANPAGE=$($MAN_PROG -w xfs_quota)
 
 case "$MANPAGE" in
 *.gz|*.z\|*.Z)	CAT=zcat;;
-- 
2.49.0

