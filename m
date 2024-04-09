Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2003212F5AD
	for <fstests@vger.kernel.org>; Tue,  9 Apr 2024 13:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712670011; cv=none; b=Eaev/CDyMUnsRoFP4+yrGz0zogGZ6lwYms2UNWhAA475RF31srPXUKDBIYnw/NT1jcfpk23ggTeek2avuGw9vdt/5W6kS+EjPyIxgwOaubQmVddNbHiZ1I7V0AEpb0YIF8ZmHsCn7Y0ZKTEtCNpzVji/2PoMMRohIWFV2eCBFXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712670011; c=relaxed/simple;
	bh=jCvFSj3NBbFf2xoxb+qDXsBOO46t/wZt65skks4nuCE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RqW+cgnvMR4fNRdB/YDQEP7LAmYjAjITFDCr1/HgxG6xogl90YATKemC6BJMnWMt7WaKtwTF0udjhPKyevwCgWQi1PfR4xnRIlrrKwPxgX1iyW9gWhqyNxumEa72hzk7k7dsHyXAncvi1qDpWUqzl788oRLOnMKanbLq5OrGMhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nCjJQ5Mc; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nCjJQ5Mc; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nCjJQ5Mc";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nCjJQ5Mc"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1B0CB33A0B;
	Tue,  9 Apr 2024 13:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712670003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NjOOOFtHXeFPCYgtJqa1ADys2iJIh4So3vnyNtVnwdM=;
	b=nCjJQ5McDVa3GwZc0f5rE+NYL3L3P9B3lbJU6KiDv2ZlD6NgDMyuygmb9pP/oDzGQxgqzN
	uPtO00V6yzQMl3GRIMB8ryxKzBFz+ZOsg2S2y3U9hER38sPmcdtwiM5NhVzsGACagDoMNw
	o1GBeMmxXA23Tik7hzGe8iv4V2ClzfA=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=nCjJQ5Mc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712670003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NjOOOFtHXeFPCYgtJqa1ADys2iJIh4So3vnyNtVnwdM=;
	b=nCjJQ5McDVa3GwZc0f5rE+NYL3L3P9B3lbJU6KiDv2ZlD6NgDMyuygmb9pP/oDzGQxgqzN
	uPtO00V6yzQMl3GRIMB8ryxKzBFz+ZOsg2S2y3U9hER38sPmcdtwiM5NhVzsGACagDoMNw
	o1GBeMmxXA23Tik7hzGe8iv4V2ClzfA=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 02F831332F;
	Tue,  9 Apr 2024 13:40:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id qz1EADNFFWZ1fwAAn2gu4w
	(envelope-from <dsterba@suse.com>); Tue, 09 Apr 2024 13:40:02 +0000
From: David Sterba <dsterba@suse.com>
To: fstests@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: remove useless comments
Date: Tue,  9 Apr 2024 15:32:34 +0200
Message-ID: <20240409133234.3374-1-dsterba@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns,suse.com:dkim,suse.com:email];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 1B0CB33A0B
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.01

Remove comments from the new test template that are not relevant once
the test case is written:

- commented out common.filters (no filters used)
- Import common functions.
- real QA test starts here
- Modify as appropriate.
- get standard environment, filters and checks

Signed-off-by: David Sterba <dsterba@suse.com>
---
 tests/btrfs/001 | 2 --
 tests/btrfs/002 | 2 --
 tests/btrfs/003 | 1 -
 tests/btrfs/004 | 2 --
 tests/btrfs/005 | 2 --
 tests/btrfs/006 | 4 ----
 tests/btrfs/007 | 2 --
 tests/btrfs/008 | 2 --
 tests/btrfs/009 | 2 --
 tests/btrfs/011 | 2 --
 tests/btrfs/012 | 4 ----
 tests/btrfs/013 | 2 --
 tests/btrfs/014 | 2 --
 tests/btrfs/015 | 2 --
 tests/btrfs/016 | 2 --
 tests/btrfs/017 | 3 ---
 tests/btrfs/018 | 2 --
 tests/btrfs/019 | 2 --
 tests/btrfs/020 | 2 --
 tests/btrfs/021 | 2 --
 tests/btrfs/022 | 1 -
 tests/btrfs/023 | 2 --
 tests/btrfs/024 | 2 --
 tests/btrfs/025 | 2 --
 tests/btrfs/026 | 2 --
 tests/btrfs/027 | 3 ---
 tests/btrfs/028 | 2 --
 tests/btrfs/029 | 2 --
 tests/btrfs/030 | 2 --
 tests/btrfs/031 | 2 --
 tests/btrfs/032 | 2 --
 tests/btrfs/033 | 2 --
 tests/btrfs/034 | 2 --
 tests/btrfs/035 | 2 --
 tests/btrfs/036 | 2 --
 tests/btrfs/037 | 2 --
 tests/btrfs/038 | 2 --
 tests/btrfs/039 | 2 --
 tests/btrfs/040 | 2 --
 tests/btrfs/041 | 2 --
 tests/btrfs/042 | 1 -
 tests/btrfs/043 | 2 --
 tests/btrfs/044 | 2 --
 tests/btrfs/045 | 2 --
 tests/btrfs/046 | 2 --
 tests/btrfs/047 | 3 ---
 tests/btrfs/048 | 2 --
 tests/btrfs/049 | 2 --
 tests/btrfs/050 | 2 --
 tests/btrfs/051 | 2 --
 tests/btrfs/052 | 2 --
 tests/btrfs/053 | 2 --
 tests/btrfs/054 | 2 --
 tests/btrfs/055 | 2 --
 tests/btrfs/056 | 2 --
 tests/btrfs/057 | 2 --
 tests/btrfs/058 | 2 --
 tests/btrfs/059 | 2 --
 tests/btrfs/060 | 2 --
 tests/btrfs/061 | 2 --
 tests/btrfs/062 | 2 --
 tests/btrfs/063 | 2 --
 tests/btrfs/064 | 2 --
 tests/btrfs/065 | 2 --
 tests/btrfs/066 | 2 --
 tests/btrfs/067 | 2 --
 tests/btrfs/068 | 2 --
 tests/btrfs/069 | 2 --
 tests/btrfs/070 | 2 --
 tests/btrfs/071 | 2 --
 tests/btrfs/072 | 2 --
 tests/btrfs/073 | 2 --
 tests/btrfs/074 | 2 --
 tests/btrfs/075 | 2 --
 tests/btrfs/076 | 2 --
 tests/btrfs/077 | 2 --
 tests/btrfs/078 | 2 --
 tests/btrfs/079 | 2 --
 tests/btrfs/080 | 2 --
 tests/btrfs/081 | 2 --
 tests/btrfs/082 | 2 --
 tests/btrfs/083 | 2 --
 tests/btrfs/084 | 2 --
 tests/btrfs/085 | 2 --
 tests/btrfs/086 | 2 --
 tests/btrfs/087 | 2 --
 tests/btrfs/088 | 2 --
 tests/btrfs/089 | 4 ----
 tests/btrfs/090 | 4 ----
 tests/btrfs/091 | 3 ---
 tests/btrfs/092 | 2 --
 tests/btrfs/093 | 2 --
 tests/btrfs/094 | 2 --
 tests/btrfs/095 | 2 --
 tests/btrfs/096 | 2 --
 tests/btrfs/097 | 2 --
 tests/btrfs/098 | 2 --
 tests/btrfs/099 | 3 ---
 tests/btrfs/100 | 1 -
 tests/btrfs/101 | 1 -
 tests/btrfs/102 | 2 --
 tests/btrfs/103 | 2 --
 tests/btrfs/104 | 2 --
 tests/btrfs/105 | 2 --
 tests/btrfs/106 | 2 --
 tests/btrfs/107 | 3 ---
 tests/btrfs/108 | 2 --
 tests/btrfs/109 | 2 --
 tests/btrfs/110 | 2 --
 tests/btrfs/111 | 2 --
 tests/btrfs/112 | 2 --
 tests/btrfs/113 | 2 --
 tests/btrfs/114 | 2 --
 tests/btrfs/115 | 2 --
 tests/btrfs/116 | 2 --
 tests/btrfs/117 | 2 --
 tests/btrfs/118 | 2 --
 tests/btrfs/119 | 2 --
 tests/btrfs/120 | 2 --
 tests/btrfs/121 | 2 --
 tests/btrfs/122 | 2 --
 tests/btrfs/123 | 4 ----
 tests/btrfs/124 | 3 ---
 tests/btrfs/125 | 3 ---
 tests/btrfs/126 | 4 ----
 tests/btrfs/127 | 2 --
 tests/btrfs/128 | 2 --
 tests/btrfs/129 | 2 --
 tests/btrfs/130 | 4 ----
 tests/btrfs/131 | 3 ---
 tests/btrfs/132 | 4 ----
 tests/btrfs/133 | 2 --
 tests/btrfs/134 | 2 --
 tests/btrfs/135 | 2 --
 tests/btrfs/136 | 4 ----
 tests/btrfs/137 | 2 --
 tests/btrfs/138 | 3 ---
 tests/btrfs/139 | 1 -
 tests/btrfs/140 | 4 ----
 tests/btrfs/141 | 4 ----
 tests/btrfs/142 | 4 ----
 tests/btrfs/143 | 4 ----
 tests/btrfs/144 | 2 --
 tests/btrfs/145 | 2 --
 tests/btrfs/146 | 2 --
 tests/btrfs/147 | 2 --
 tests/btrfs/148 | 2 --
 tests/btrfs/149 | 2 --
 tests/btrfs/150 | 4 ----
 tests/btrfs/151 | 4 ----
 tests/btrfs/152 | 2 --
 tests/btrfs/153 | 4 ----
 tests/btrfs/154 | 3 ---
 tests/btrfs/155 | 2 --
 tests/btrfs/156 | 4 ----
 tests/btrfs/157 | 4 ----
 tests/btrfs/158 | 4 ----
 tests/btrfs/159 | 2 --
 tests/btrfs/160 | 2 --
 tests/btrfs/161 | 4 ----
 tests/btrfs/162 | 4 ----
 tests/btrfs/163 | 4 ----
 tests/btrfs/164 | 3 ---
 tests/btrfs/165 | 2 --
 tests/btrfs/166 | 2 --
 tests/btrfs/167 | 4 ----
 tests/btrfs/168 | 2 --
 tests/btrfs/169 | 2 --
 tests/btrfs/170 | 2 --
 tests/btrfs/171 | 2 --
 tests/btrfs/172 | 4 ----
 tests/btrfs/176 | 4 ----
 tests/btrfs/177 | 1 -
 tests/btrfs/178 | 2 --
 tests/btrfs/179 | 4 ----
 tests/btrfs/180 | 4 ----
 tests/btrfs/181 | 4 ----
 tests/btrfs/182 | 4 ----
 tests/btrfs/183 | 2 --
 tests/btrfs/184 | 2 --
 tests/btrfs/185 | 2 --
 tests/btrfs/186 | 2 --
 tests/btrfs/187 | 2 --
 tests/btrfs/188 | 2 --
 tests/btrfs/189 | 2 --
 tests/btrfs/190 | 4 ----
 tests/btrfs/191 | 2 --
 tests/btrfs/192 | 4 ----
 tests/btrfs/193 | 4 ----
 tests/btrfs/194 | 4 ----
 tests/btrfs/195 | 4 ----
 tests/btrfs/196 | 4 ----
 tests/btrfs/197 | 2 --
 tests/btrfs/198 | 2 --
 tests/btrfs/199 | 4 ----
 tests/btrfs/200 | 2 --
 tests/btrfs/201 | 2 --
 tests/btrfs/203 | 2 --
 tests/btrfs/204 | 4 ----
 tests/btrfs/205 | 2 --
 tests/btrfs/206 | 2 --
 tests/btrfs/207 | 1 -
 tests/btrfs/208 | 2 --
 tests/btrfs/209 | 2 --
 tests/btrfs/210 | 4 ----
 tests/btrfs/211 | 2 --
 tests/btrfs/212 | 4 ----
 tests/btrfs/213 | 2 --
 tests/btrfs/214 | 3 ---
 tests/btrfs/215 | 3 ---
 tests/btrfs/216 | 2 --
 tests/btrfs/217 | 4 ----
 tests/btrfs/218 | 4 ----
 tests/btrfs/219 | 3 ---
 tests/btrfs/220 | 2 --
 tests/btrfs/221 | 2 --
 tests/btrfs/222 | 2 --
 tests/btrfs/223 | 2 --
 tests/btrfs/224 | 4 ----
 tests/btrfs/225 | 4 ----
 tests/btrfs/226 | 2 --
 tests/btrfs/227 | 2 --
 tests/btrfs/228 | 4 ----
 tests/btrfs/229 | 2 --
 tests/btrfs/230 | 3 ---
 tests/btrfs/231 | 2 --
 tests/btrfs/232 | 3 ---
 tests/btrfs/233 | 2 --
 tests/btrfs/234 | 2 --
 tests/btrfs/235 | 2 --
 tests/btrfs/236 | 2 --
 tests/btrfs/237 | 3 ---
 tests/btrfs/238 | 4 ----
 tests/btrfs/239 | 2 --
 tests/btrfs/240 | 2 --
 tests/btrfs/241 | 2 --
 tests/btrfs/242 | 2 --
 tests/btrfs/243 | 2 --
 tests/btrfs/244 | 6 ------
 tests/btrfs/245 | 3 ---
 tests/btrfs/246 | 2 --
 tests/btrfs/247 | 4 ----
 tests/btrfs/248 | 6 ------
 tests/btrfs/249 | 6 ------
 tests/btrfs/250 | 3 ---
 tests/btrfs/251 | 4 ----
 tests/btrfs/252 | 2 --
 tests/btrfs/254 | 2 --
 tests/btrfs/255 | 1 -
 tests/btrfs/256 | 3 ---
 tests/btrfs/257 | 4 ----
 tests/btrfs/258 | 3 ---
 tests/btrfs/259 | 4 ----
 tests/btrfs/260 | 4 ----
 tests/btrfs/262 | 3 ---
 tests/btrfs/263 | 4 ----
 tests/btrfs/264 | 3 ---
 tests/btrfs/265 | 3 ---
 tests/btrfs/266 | 3 ---
 tests/btrfs/267 | 3 ---
 tests/btrfs/272 | 1 -
 tests/btrfs/273 | 3 ---
 tests/btrfs/275 | 2 --
 tests/btrfs/277 | 4 ----
 tests/btrfs/278 | 1 -
 tests/btrfs/282 | 1 -
 tests/btrfs/284 | 1 -
 tests/btrfs/286 | 4 ----
 tests/btrfs/288 | 4 ----
 tests/btrfs/289 | 3 ---
 tests/btrfs/290 | 3 ---
 tests/btrfs/291 | 2 --
 tests/btrfs/292 | 4 ----
 tests/btrfs/294 | 4 ----
 tests/btrfs/296 | 1 -
 tests/btrfs/299 | 2 --
 tests/btrfs/301 | 4 ----
 tests/btrfs/310 | 6 ------
 tests/btrfs/311 | 1 -
 tests/btrfs/320 | 1 -
 280 files changed, 704 deletions(-)

diff --git a/tests/btrfs/001 b/tests/btrfs/001
index 6c2639990373db..4c9da98c251b4f 100755
--- a/tests/btrfs/001
+++ b/tests/btrfs/001
@@ -9,11 +9,9 @@
 . ./common/preamble
 _begin_fstest auto quick subvol snapshot
 
-# Import common functions.
 . ./common/filter
 . ./common/filter.btrfs
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 
diff --git a/tests/btrfs/002 b/tests/btrfs/002
index 58f0cdcd7cd0eb..e5fe8825769de9 100755
--- a/tests/btrfs/002
+++ b/tests/btrfs/002
@@ -9,7 +9,6 @@
 . ./common/preamble
 _begin_fstest auto snapshot
 
-# Import common functions.
 . ./common/filter
 
 _supported_fs btrfs
@@ -114,7 +113,6 @@ _append_file()
 	wait $!
 }
 
-##################### real QA test starts here###################################
 # sv1 - is just a name nothing spl
 firstvol="$SCRATCH_MNT/sv1"
 $BTRFS_UTIL_PROG subvolume create $firstvol > /dev/null || _fail "btrfs subvolume create $firstvol failed"
diff --git a/tests/btrfs/003 b/tests/btrfs/003
index fae6d9d19a389a..3ac53ef78090bf 100755
--- a/tests/btrfs/003
+++ b/tests/btrfs/003
@@ -38,7 +38,6 @@ _cleanup()
     fi
 }
 
-# Import common functions.
 . ./common/filter
 
 _supported_fs btrfs
diff --git a/tests/btrfs/004 b/tests/btrfs/004
index 381ad072fdcfad..2d2841ff049234 100755
--- a/tests/btrfs/004
+++ b/tests/btrfs/004
@@ -22,10 +22,8 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 _require_no_large_scratch_dev
diff --git a/tests/btrfs/005 b/tests/btrfs/005
index 846347708179b7..8d66f0be640dc0 100755
--- a/tests/btrfs/005
+++ b/tests/btrfs/005
@@ -99,11 +99,9 @@ _rundefrag()
 	_check_scratch_fs
 }
 
-# Import common functions.
 . ./common/filter
 . ./common/defrag
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 
diff --git a/tests/btrfs/006 b/tests/btrfs/006
index bff6f980a567d9..cd3a0c63133b17 100755
--- a/tests/btrfs/006
+++ b/tests/btrfs/006
@@ -10,12 +10,8 @@
 . ./common/preamble
 _begin_fstest auto quick volume
 
-# Import common functions.
 . ./common/filter.btrfs
 
-# real QA test starts here
-
-# Modify as appropriate.
 _supported_fs btrfs
 _require_scratch
 _require_scratch_dev_pool
diff --git a/tests/btrfs/007 b/tests/btrfs/007
index ed7d143a0d70bc..2e0a918eaaed6c 100755
--- a/tests/btrfs/007
+++ b/tests/btrfs/007
@@ -23,10 +23,8 @@ _cleanup()
 	rm -fr $send_files_dir
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 _require_fssum
diff --git a/tests/btrfs/008 b/tests/btrfs/008
index 438cec8234bec1..bcbb72da0ae92e 100755
--- a/tests/btrfs/008
+++ b/tests/btrfs/008
@@ -21,10 +21,8 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_test
 _require_scratch
diff --git a/tests/btrfs/009 b/tests/btrfs/009
index be7e2f02fd980e..4a151049c81c48 100755
--- a/tests/btrfs/009
+++ b/tests/btrfs/009
@@ -9,10 +9,8 @@
 . ./common/preamble
 _begin_fstest auto quick subvol
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 
diff --git a/tests/btrfs/011 b/tests/btrfs/011
index d8b5a978275032..ea825ce5924b42 100755
--- a/tests/btrfs/011
+++ b/tests/btrfs/011
@@ -38,10 +38,8 @@ _cleanup()
 	_scratch_unmount > /dev/null 2>&1
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch_nocheck
 _require_scratch_dev_pool 5
diff --git a/tests/btrfs/012 b/tests/btrfs/012
index ab90c8a7208b5b..1cb2905b3a5302 100755
--- a/tests/btrfs/012
+++ b/tests/btrfs/012
@@ -16,12 +16,8 @@
 . ./common/preamble
 _begin_fstest auto convert
 
-# Import common functions.
 . ./common/filter.btrfs
 
-# real QA test starts here
-
-# Modify as appropriate.
 _supported_fs btrfs
 _require_scratch_nocheck
 
diff --git a/tests/btrfs/013 b/tests/btrfs/013
index 459b6e80a312f5..623de320bda09c 100755
--- a/tests/btrfs/013
+++ b/tests/btrfs/013
@@ -13,10 +13,8 @@
 . ./common/preamble
 _begin_fstest auto quick balance prealloc
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 _require_xfs_io_command "falloc"
diff --git a/tests/btrfs/014 b/tests/btrfs/014
index 9e236274c56387..af7a7aeb0bed06 100755
--- a/tests/btrfs/014
+++ b/tests/btrfs/014
@@ -26,10 +26,8 @@ _balance()
 	done
 }
 
-#get standard environment, filters and checks
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 
 _require_scratch
diff --git a/tests/btrfs/015 b/tests/btrfs/015
index aeec8cc917c5db..346812da18a1ab 100755
--- a/tests/btrfs/015
+++ b/tests/btrfs/015
@@ -10,10 +10,8 @@
 . ./common/preamble
 _begin_fstest auto quick snapshot remount
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 
diff --git a/tests/btrfs/016 b/tests/btrfs/016
index 37119363af2692..95e13854f70dc4 100755
--- a/tests/btrfs/016
+++ b/tests/btrfs/016
@@ -12,10 +12,8 @@ _begin_fstest auto quick send prealloc
 tmp=`mktemp -d`
 tmp_dir=send_temp_$seq
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 _require_fssum
diff --git a/tests/btrfs/017 b/tests/btrfs/017
index 496cc7df1b199e..aa5b7c1d1a6c86 100755
--- a/tests/btrfs/017
+++ b/tests/btrfs/017
@@ -15,11 +15,8 @@
 . ./common/preamble
 _begin_fstest auto quick qgroup
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
-
 _supported_fs btrfs
 _require_scratch
 _require_scratch_qgroup
diff --git a/tests/btrfs/018 b/tests/btrfs/018
index c522e20784d577..f9e9497a695adb 100755
--- a/tests/btrfs/018
+++ b/tests/btrfs/018
@@ -9,10 +9,8 @@
 . ./common/preamble
 _begin_fstest auto quick subvol
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 
diff --git a/tests/btrfs/019 b/tests/btrfs/019
index a5b590d32a8bb0..3ecde39fec51e4 100755
--- a/tests/btrfs/019
+++ b/tests/btrfs/019
@@ -21,10 +21,8 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_test
 _require_scratch
diff --git a/tests/btrfs/020 b/tests/btrfs/020
index ac876ea3428fd7..d2d9269fe614a6 100755
--- a/tests/btrfs/020
+++ b/tests/btrfs/020
@@ -25,10 +25,8 @@ _cleanup()
 	rm -f $fs_img1 $fs_img2 $fs_img3
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_test
 _require_loop
diff --git a/tests/btrfs/021 b/tests/btrfs/021
index 1b55834aa99cd6..13f2ba3253d606 100755
--- a/tests/btrfs/021
+++ b/tests/btrfs/021
@@ -12,10 +12,8 @@
 . ./common/preamble
 _begin_fstest auto quick balance defrag
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 run_test()
 {
 	_run_btrfs_balance_start $SCRATCH_MNT >> $seqres.full &
diff --git a/tests/btrfs/022 b/tests/btrfs/022
index 32ad80bf9c64e8..786283e9ae1e04 100755
--- a/tests/btrfs/022
+++ b/tests/btrfs/022
@@ -9,7 +9,6 @@
 . ./common/preamble
 _begin_fstest auto qgroup limit
 
-# Import common functions.
 . ./common/filter
 
 _supported_fs btrfs
diff --git a/tests/btrfs/023 b/tests/btrfs/023
index 9facf3e2092c74..15ce7d6968c671 100755
--- a/tests/btrfs/023
+++ b/tests/btrfs/023
@@ -11,10 +11,8 @@
 . ./common/preamble
 _begin_fstest auto
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch_dev_pool 4
 # Zoned btrfs only supports SINGLE profile
diff --git a/tests/btrfs/024 b/tests/btrfs/024
index a8ca0e1d32d6bb..2eefbe62a2fed2 100755
--- a/tests/btrfs/024
+++ b/tests/btrfs/024
@@ -11,10 +11,8 @@
 . ./common/preamble
 _begin_fstest auto quick compress
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 _require_btrfs_no_nodatacow
diff --git a/tests/btrfs/025 b/tests/btrfs/025
index 26f95c7d9a1eb8..1c3773be4bbff5 100755
--- a/tests/btrfs/025
+++ b/tests/btrfs/025
@@ -21,10 +21,8 @@ _cleanup()
     rm -fr $tmp
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 _require_xfs_io_command "falloc"
diff --git a/tests/btrfs/026 b/tests/btrfs/026
index ddd093b88204ca..00914f10a3a6f3 100755
--- a/tests/btrfs/026
+++ b/tests/btrfs/026
@@ -10,10 +10,8 @@
 . ./common/preamble
 _begin_fstest auto quick compress prealloc
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 _require_xfs_io_command "falloc"
diff --git a/tests/btrfs/027 b/tests/btrfs/027
index dbf12c26d0cdd8..7d3307a130c6ef 100755
--- a/tests/btrfs/027
+++ b/tests/btrfs/027
@@ -9,11 +9,8 @@
 . ./common/preamble
 _begin_fstest auto replace volume scrub
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
-
 _supported_fs btrfs
 # we check scratch dev after each loop
 _require_scratch_nocheck
diff --git a/tests/btrfs/028 b/tests/btrfs/028
index d860974ec20732..efafa00431a5ab 100755
--- a/tests/btrfs/028
+++ b/tests/btrfs/028
@@ -13,10 +13,8 @@
 . ./common/preamble
 _begin_fstest auto qgroup balance
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 _require_btrfs_qgroup_report
diff --git a/tests/btrfs/029 b/tests/btrfs/029
index 94886788c585cd..9b56cc73f818a0 100755
--- a/tests/btrfs/029
+++ b/tests/btrfs/029
@@ -18,11 +18,9 @@
 . ./common/preamble
 _begin_fstest auto quick clone
 
-# Import common functions.
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _supported_fs btrfs
 
 _require_test
diff --git a/tests/btrfs/030 b/tests/btrfs/030
index bce5ba1e73db16..5b91dd21d59be9 100755
--- a/tests/btrfs/030
+++ b/tests/btrfs/030
@@ -28,10 +28,8 @@ _cleanup()
     rm -fr $tmp
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 _require_fssum
diff --git a/tests/btrfs/031 b/tests/btrfs/031
index b0796bae027a8d..83a28e4cce5e82 100755
--- a/tests/btrfs/031
+++ b/tests/btrfs/031
@@ -14,11 +14,9 @@
 . ./common/preamble
 _begin_fstest auto quick subvol clone
 
-# Import common functions.
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _supported_fs btrfs
 
 _require_test
diff --git a/tests/btrfs/032 b/tests/btrfs/032
index 502a523b3a6191..b7b1fcf656834a 100755
--- a/tests/btrfs/032
+++ b/tests/btrfs/032
@@ -10,10 +10,8 @@
 . ./common/preamble
 _begin_fstest auto quick remount
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 
diff --git a/tests/btrfs/033 b/tests/btrfs/033
index 50ec5856d671be..da002bcfe25f45 100755
--- a/tests/btrfs/033
+++ b/tests/btrfs/033
@@ -9,10 +9,8 @@
 . ./common/preamble
 _begin_fstest auto quick send snapshot
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 
diff --git a/tests/btrfs/034 b/tests/btrfs/034
index abda75db76a97f..f2759826346c3f 100755
--- a/tests/btrfs/034
+++ b/tests/btrfs/034
@@ -18,10 +18,8 @@ _cleanup()
     rm -fr $tmp
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 _require_xfs_io_command "falloc"
diff --git a/tests/btrfs/035 b/tests/btrfs/035
index 7e644ecff4408c..dac2fff7dcdf9d 100755
--- a/tests/btrfs/035
+++ b/tests/btrfs/035
@@ -9,11 +9,9 @@
 . ./common/preamble
 _begin_fstest auto quick clone
 
-# Import common functions.
 . ./common/filter
 . ./common/filter.btrfs
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 _require_cloner
diff --git a/tests/btrfs/036 b/tests/btrfs/036
index c3d13da24d644d..32c129c3a7ac28 100755
--- a/tests/btrfs/036
+++ b/tests/btrfs/036
@@ -40,10 +40,8 @@ do_snapshots()
 	done
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 
diff --git a/tests/btrfs/037 b/tests/btrfs/037
index 61193fdd2a7baa..4e4178cdd067b9 100755
--- a/tests/btrfs/037
+++ b/tests/btrfs/037
@@ -25,10 +25,8 @@ _cleanup()
     rm -fr $tmp
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 _require_xfs_io_command "falloc"
diff --git a/tests/btrfs/038 b/tests/btrfs/038
index 13e50701374352..f2f35a6b308ddf 100755
--- a/tests/btrfs/038
+++ b/tests/btrfs/038
@@ -24,10 +24,8 @@ _cleanup()
     rm -fr $tmp
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 _require_fssum
diff --git a/tests/btrfs/039 b/tests/btrfs/039
index c2d7c20cbc0d0a..bcc9d58abfc875 100755
--- a/tests/btrfs/039
+++ b/tests/btrfs/039
@@ -27,10 +27,8 @@ _cleanup()
     rm -fr $tmp
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 _require_fssum
diff --git a/tests/btrfs/040 b/tests/btrfs/040
index 35bd12cd0030b3..da5ec1faa56b56 100755
--- a/tests/btrfs/040
+++ b/tests/btrfs/040
@@ -27,10 +27,8 @@ _cleanup()
     rm -fr $tmp
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 _require_fssum
diff --git a/tests/btrfs/041 b/tests/btrfs/041
index 5b4577641d4797..35f058fa979be2 100755
--- a/tests/btrfs/041
+++ b/tests/btrfs/041
@@ -24,10 +24,8 @@ _cleanup()
 	rm -fr $restore_dir
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_test
 _require_scratch
diff --git a/tests/btrfs/042 b/tests/btrfs/042
index 230f8fc05dcb80..89742303e817a3 100755
--- a/tests/btrfs/042
+++ b/tests/btrfs/042
@@ -9,7 +9,6 @@
 . ./common/preamble
 _begin_fstest auto quick qgroup limit
 
-# Import common functions.
 . ./common/filter
 
 _supported_fs btrfs
diff --git a/tests/btrfs/043 b/tests/btrfs/043
index 14b7cb71d0d7fe..788806b3b35c15 100755
--- a/tests/btrfs/043
+++ b/tests/btrfs/043
@@ -23,10 +23,8 @@ _cleanup()
     rm -fr $tmp
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 _require_fssum
diff --git a/tests/btrfs/044 b/tests/btrfs/044
index 0864d0401b0e1a..1a8f225a042f76 100755
--- a/tests/btrfs/044
+++ b/tests/btrfs/044
@@ -28,10 +28,8 @@ _cleanup()
     rm -fr $tmp
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 _require_fssum
diff --git a/tests/btrfs/045 b/tests/btrfs/045
index 9b23730b1e961f..04ba8ea0dcdfdf 100755
--- a/tests/btrfs/045
+++ b/tests/btrfs/045
@@ -44,10 +44,8 @@ _cleanup()
     rm -fr $tmp
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 _require_fssum
diff --git a/tests/btrfs/046 b/tests/btrfs/046
index 8b65fb1f1ecbe4..f0b08b6cdf5ed7 100755
--- a/tests/btrfs/046
+++ b/tests/btrfs/046
@@ -27,10 +27,8 @@ _cleanup()
 	rm -fr $tmp
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_test
 _require_scratch
diff --git a/tests/btrfs/047 b/tests/btrfs/047
index ac79b9f14b6696..4b3fb35411a40b 100755
--- a/tests/btrfs/047
+++ b/tests/btrfs/047
@@ -10,12 +10,9 @@
 . ./common/preamble
 _begin_fstest auto quick snapshot attr
 
-# Import common functions.
 . ./common/filter
 . ./common/attr
 
-# real QA test starts here
-
 _supported_fs btrfs
 _require_attrs
 _require_scratch
diff --git a/tests/btrfs/048 b/tests/btrfs/048
index aa2030b12df679..52cc2bf8da33a9 100755
--- a/tests/btrfs/048
+++ b/tests/btrfs/048
@@ -20,11 +20,9 @@ _cleanup()
     rm -fr $tmp
 }
 
-# Import common functions.
 . ./common/filter
 . ./common/filter.btrfs
 
-# real QA test starts here
 _supported_fs btrfs
 _require_test
 _require_scratch
diff --git a/tests/btrfs/049 b/tests/btrfs/049
index c48e4087cc88b6..dd07c94a14a746 100755
--- a/tests/btrfs/049
+++ b/tests/btrfs/049
@@ -11,8 +11,6 @@
 . ./common/preamble
 _begin_fstest quick balance auto
 
-# real QA test starts here
-
 _supported_fs btrfs
 _require_scratch_swapfile
 _require_scratch_dev_pool 3
diff --git a/tests/btrfs/050 b/tests/btrfs/050
index ef1b3139112b04..7096eb83d63a90 100755
--- a/tests/btrfs/050
+++ b/tests/btrfs/050
@@ -25,10 +25,8 @@ _cleanup()
     rm -fr $tmp
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_test
 _require_scratch
diff --git a/tests/btrfs/051 b/tests/btrfs/051
index f0ac86aa2ce98b..743dfd66b8996d 100755
--- a/tests/btrfs/051
+++ b/tests/btrfs/051
@@ -22,10 +22,8 @@ _cleanup()
     rm -fr $tmp
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_test
 _require_scratch
diff --git a/tests/btrfs/052 b/tests/btrfs/052
index 0d60d413250aec..eabe43c477b305 100755
--- a/tests/btrfs/052
+++ b/tests/btrfs/052
@@ -17,10 +17,8 @@ _cleanup()
     rm -fr $tmp
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 _require_cloner
diff --git a/tests/btrfs/053 b/tests/btrfs/053
index 67239f10d3ab93..7f533bf42c66bb 100755
--- a/tests/btrfs/053
+++ b/tests/btrfs/053
@@ -23,11 +23,9 @@ _cleanup()
     rm -fr $tmp
 }
 
-# Import common functions.
 . ./common/filter
 . ./common/attr
 
-# real QA test starts here
 _supported_fs btrfs
 _require_test
 _require_scratch
diff --git a/tests/btrfs/054 b/tests/btrfs/054
index f1b5b2c3f14f34..daf3cb3d5f46e4 100755
--- a/tests/btrfs/054
+++ b/tests/btrfs/054
@@ -31,11 +31,9 @@ _cleanup()
     rm -fr $tmp
 }
 
-# Import common functions.
 . ./common/filter
 . ./common/attr
 
-# real QA test starts here
 _supported_fs btrfs
 _require_test
 _require_scratch
diff --git a/tests/btrfs/055 b/tests/btrfs/055
index e538636d933fae..900c3dba820fa8 100755
--- a/tests/btrfs/055
+++ b/tests/btrfs/055
@@ -21,10 +21,8 @@ _cleanup()
     rm -fr $tmp
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 _require_cloner
diff --git a/tests/btrfs/056 b/tests/btrfs/056
index e126398327c4b1..128c261a27b329 100755
--- a/tests/btrfs/056
+++ b/tests/btrfs/056
@@ -24,11 +24,9 @@ _cleanup()
 	rm -fr $tmp
 }
 
-# Import common functions.
 . ./common/filter
 . ./common/dmflakey
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 _require_cloner
diff --git a/tests/btrfs/057 b/tests/btrfs/057
index e932a6572177ef..6cb001b7afc674 100755
--- a/tests/btrfs/057
+++ b/tests/btrfs/057
@@ -9,10 +9,8 @@
 . ./common/preamble
 _begin_fstest auto quick
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 _require_qgroup_rescan
diff --git a/tests/btrfs/058 b/tests/btrfs/058
index 493f2c54efac93..ad7f850f61c92e 100755
--- a/tests/btrfs/058
+++ b/tests/btrfs/058
@@ -25,10 +25,8 @@ _cleanup()
 	rm -fr $tmp
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 _require_xfs_io_command "-T"
diff --git a/tests/btrfs/059 b/tests/btrfs/059
index 8b458b341f37b8..27be694726d55e 100755
--- a/tests/btrfs/059
+++ b/tests/btrfs/059
@@ -19,11 +19,9 @@ _cleanup()
 	rm -fr $tmp
 }
 
-# Import common functions.
 . ./common/filter
 . ./common/filter.btrfs
 
-# real QA test starts here
 _supported_fs btrfs
 _require_test
 _require_scratch
diff --git a/tests/btrfs/060 b/tests/btrfs/060
index a018489160273d..f15d2cf182260a 100755
--- a/tests/btrfs/060
+++ b/tests/btrfs/060
@@ -10,10 +10,8 @@
 . ./common/preamble
 _begin_fstest auto balance subvol scrub
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 # we check scratch dev after each loop
 _require_scratch_nocheck
diff --git a/tests/btrfs/061 b/tests/btrfs/061
index c101041360cebb..a545833917c6ab 100755
--- a/tests/btrfs/061
+++ b/tests/btrfs/061
@@ -10,10 +10,8 @@
 . ./common/preamble
 _begin_fstest auto balance scrub
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 # we check scratch dev after each loop
 _require_scratch_nocheck
diff --git a/tests/btrfs/062 b/tests/btrfs/062
index 818a0156668d8c..538324f0d98817 100755
--- a/tests/btrfs/062
+++ b/tests/btrfs/062
@@ -10,10 +10,8 @@
 . ./common/preamble
 _begin_fstest auto balance defrag compress scrub
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 # we check scratch dev after each loop
 _require_scratch_nocheck
diff --git a/tests/btrfs/063 b/tests/btrfs/063
index 2f771baf7cea2b..e5d4842a0e5569 100755
--- a/tests/btrfs/063
+++ b/tests/btrfs/063
@@ -10,10 +10,8 @@
 . ./common/preamble
 _begin_fstest auto balance remount compress scrub
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 # we check scratch dev after each loop
 _require_scratch_nocheck
diff --git a/tests/btrfs/064 b/tests/btrfs/064
index e9b46ce665775d..10ad289f700ebe 100755
--- a/tests/btrfs/064
+++ b/tests/btrfs/064
@@ -12,10 +12,8 @@
 . ./common/preamble
 _begin_fstest auto balance replace volume scrub
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 # we check scratch dev after each loop
 _require_scratch_nocheck
diff --git a/tests/btrfs/065 b/tests/btrfs/065
index c4b6aafe7d263e..ef32cca2edb992 100755
--- a/tests/btrfs/065
+++ b/tests/btrfs/065
@@ -10,10 +10,8 @@
 . ./common/preamble
 _begin_fstest auto subvol replace volume scrub
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 # we check scratch dev after each loop
 _require_scratch_nocheck
diff --git a/tests/btrfs/066 b/tests/btrfs/066
index a29034bb3a7eec..18644494d5888a 100755
--- a/tests/btrfs/066
+++ b/tests/btrfs/066
@@ -10,10 +10,8 @@
 . ./common/preamble
 _begin_fstest auto subvol scrub
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 # we check scratch dev after each loop
 _require_scratch_nocheck
diff --git a/tests/btrfs/067 b/tests/btrfs/067
index 709db155d20934..811b09d97f5dbc 100755
--- a/tests/btrfs/067
+++ b/tests/btrfs/067
@@ -10,10 +10,8 @@
 . ./common/preamble
 _begin_fstest auto subvol defrag compress scrub
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 # we check scratch dev after each loop
 _require_scratch_nocheck
diff --git a/tests/btrfs/068 b/tests/btrfs/068
index 15fd41db97b40d..17846aa624bc9b 100755
--- a/tests/btrfs/068
+++ b/tests/btrfs/068
@@ -11,10 +11,8 @@
 . ./common/preamble
 _begin_fstest auto subvol remount compress scrub
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 # we check scratch dev after each loop
 _require_scratch_nocheck
diff --git a/tests/btrfs/069 b/tests/btrfs/069
index 139dde48a5f44c..049cc1809acc5b 100755
--- a/tests/btrfs/069
+++ b/tests/btrfs/069
@@ -10,10 +10,8 @@
 . ./common/preamble
 _begin_fstest auto replace scrub volume
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 # we check scratch dev after each loop
 _require_scratch_nocheck
diff --git a/tests/btrfs/070 b/tests/btrfs/070
index 54aa275c7d0f72..d56fde2448de3a 100755
--- a/tests/btrfs/070
+++ b/tests/btrfs/070
@@ -10,10 +10,8 @@
 . ./common/preamble
 _begin_fstest auto replace defrag compress volume scrub
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 # we check scratch dev after each loop
 _require_scratch_nocheck
diff --git a/tests/btrfs/071 b/tests/btrfs/071
index 6ebbd8cc3c54fc..5de62694203342 100755
--- a/tests/btrfs/071
+++ b/tests/btrfs/071
@@ -10,10 +10,8 @@
 . ./common/preamble
 _begin_fstest auto replace remount compress volume scrub
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 # we check scratch dev after each loop
 _require_scratch_nocheck
diff --git a/tests/btrfs/072 b/tests/btrfs/072
index 4b6b6fb5723172..7da9b1668ed172 100755
--- a/tests/btrfs/072
+++ b/tests/btrfs/072
@@ -10,10 +10,8 @@
 . ./common/preamble
 _begin_fstest auto scrub defrag compress
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 # we check scratch dev after each loop
 _require_scratch_nocheck
diff --git a/tests/btrfs/073 b/tests/btrfs/073
index b1604f94989aaf..4e94e3dea174da 100755
--- a/tests/btrfs/073
+++ b/tests/btrfs/073
@@ -10,10 +10,8 @@
 . ./common/preamble
 _begin_fstest auto scrub remount compress
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 # we check scratch dev after each loop
 _require_scratch_nocheck
diff --git a/tests/btrfs/074 b/tests/btrfs/074
index 9b22c62029f0bb..789dcad2790363 100755
--- a/tests/btrfs/074
+++ b/tests/btrfs/074
@@ -10,10 +10,8 @@
 . ./common/preamble
 _begin_fstest auto defrag remount compress scrub
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 # we check scratch dev after each loop
 _require_scratch_nocheck
diff --git a/tests/btrfs/075 b/tests/btrfs/075
index e10d656215dbc9..c54239e6c204ff 100755
--- a/tests/btrfs/075
+++ b/tests/btrfs/075
@@ -18,10 +18,8 @@ _cleanup()
 	$UMOUNT_PROG $subvol_mnt >/dev/null 2>&1
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 
diff --git a/tests/btrfs/076 b/tests/btrfs/076
index 894a1ac7fa5dbc..730be879ec1579 100755
--- a/tests/btrfs/076
+++ b/tests/btrfs/076
@@ -17,11 +17,9 @@ _cleanup()
 	rm -fr $tmp
 }
 
-# Import common functions.
 . ./common/filter
 . ./common/defrag
 
-# real QA test starts here
 _supported_fs btrfs
 _require_test
 _require_scratch
diff --git a/tests/btrfs/077 b/tests/btrfs/077
index 4cfd6ed75c79ee..7a69b98fc19f31 100755
--- a/tests/btrfs/077
+++ b/tests/btrfs/077
@@ -31,10 +31,8 @@ _cleanup()
     rm -fr $tmp
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 _require_fssum
diff --git a/tests/btrfs/078 b/tests/btrfs/078
index bdd7e04eacd917..9ebae93b12e878 100755
--- a/tests/btrfs/078
+++ b/tests/btrfs/078
@@ -24,10 +24,8 @@ _cleanup()
 	rm -fr $tmp
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 
diff --git a/tests/btrfs/079 b/tests/btrfs/079
index 22f57396e7b164..d13056ae8db53e 100755
--- a/tests/btrfs/079
+++ b/tests/btrfs/079
@@ -30,10 +30,8 @@ _cleanup()
 	rm -fr $tmp.* $tmp
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 # Since xfs_io's fiemap always use SYNC flag and can't be unset,
diff --git a/tests/btrfs/080 b/tests/btrfs/080
index ac9d9b6422d196..3330a9354c19a8 100755
--- a/tests/btrfs/080
+++ b/tests/btrfs/080
@@ -28,10 +28,8 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch_nocheck
 
diff --git a/tests/btrfs/081 b/tests/btrfs/081
index 65fed9a7ecc42f..c3f84c7780b73b 100755
--- a/tests/btrfs/081
+++ b/tests/btrfs/081
@@ -19,10 +19,8 @@
 . ./common/preamble
 _begin_fstest auto quick clone
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 _require_cloner
diff --git a/tests/btrfs/082 b/tests/btrfs/082
index 888464d33285a5..c20896bfcff1ed 100755
--- a/tests/btrfs/082
+++ b/tests/btrfs/082
@@ -18,10 +18,8 @@
 . ./common/preamble
 _begin_fstest auto quick remount
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 
diff --git a/tests/btrfs/083 b/tests/btrfs/083
index e09769dd484dd1..df3a44377aaed4 100755
--- a/tests/btrfs/083
+++ b/tests/btrfs/083
@@ -23,10 +23,8 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 _require_fssum
diff --git a/tests/btrfs/084 b/tests/btrfs/084
index 04ccbb91a52f2f..0e618f2e660f86 100755
--- a/tests/btrfs/084
+++ b/tests/btrfs/084
@@ -22,10 +22,8 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 _require_fssum
diff --git a/tests/btrfs/085 b/tests/btrfs/085
index bcbf1a05dc8384..6726dd62829c32 100755
--- a/tests/btrfs/085
+++ b/tests/btrfs/085
@@ -23,11 +23,9 @@ _cleanup()
     rm -f $tmp.*
 }
 
-# Import common functions.
 . ./common/filter
 . ./common/dmflakey
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 _require_dm_target flakey
diff --git a/tests/btrfs/086 b/tests/btrfs/086
index 8c1339ab5a929a..b0f9609df8f94b 100755
--- a/tests/btrfs/086
+++ b/tests/btrfs/086
@@ -18,10 +18,8 @@
 . ./common/preamble
 _begin_fstest auto quick clone
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 _require_cloner
diff --git a/tests/btrfs/087 b/tests/btrfs/087
index 59a775efff90de..129b83e7cb7a50 100755
--- a/tests/btrfs/087
+++ b/tests/btrfs/087
@@ -28,10 +28,8 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 _require_fssum
diff --git a/tests/btrfs/088 b/tests/btrfs/088
index 59972ae7a117bb..1696d02a595ec8 100755
--- a/tests/btrfs/088
+++ b/tests/btrfs/088
@@ -16,11 +16,9 @@
 . ./common/preamble
 _begin_fstest auto quick metadata
 
-# Import common functions.
 . ./common/filter
 . ./common/fail_make_request
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 _require_fail_make_request
diff --git a/tests/btrfs/089 b/tests/btrfs/089
index e0b61e8ef72f7a..9460d4e8bf6b73 100755
--- a/tests/btrfs/089
+++ b/tests/btrfs/089
@@ -11,13 +11,9 @@
 . ./common/preamble
 _begin_fstest auto quick subvol
 
-# Import common functions.
 . ./common/filter
 . ./common/filter.btrfs
 
-# real QA test starts here
-
-# Modify as appropriate.
 _supported_fs btrfs
 _require_scratch
 
diff --git a/tests/btrfs/090 b/tests/btrfs/090
index 3693a3ad0f40be..d89f933858885f 100755
--- a/tests/btrfs/090
+++ b/tests/btrfs/090
@@ -16,12 +16,8 @@
 . ./common/preamble
 _begin_fstest auto quick metadata
 
-# Import common functions.
 . ./common/filter.btrfs
 
-# real QA test starts here
-
-# Modify as appropriate.
 _supported_fs btrfs
 _require_scratch
 _require_scratch_dev_pool
diff --git a/tests/btrfs/091 b/tests/btrfs/091
index a71e03406f8c59..b71e803eb09e93 100755
--- a/tests/btrfs/091
+++ b/tests/btrfs/091
@@ -10,12 +10,9 @@
 . ./common/preamble
 _begin_fstest auto quick qgroup
 
-# Import common functions.
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
-
 _supported_fs btrfs
 _require_scratch
 _require_cp_reflink
diff --git a/tests/btrfs/092 b/tests/btrfs/092
index f752f97296b343..c397a3c5c164d7 100755
--- a/tests/btrfs/092
+++ b/tests/btrfs/092
@@ -27,10 +27,8 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 _require_fssum
diff --git a/tests/btrfs/093 b/tests/btrfs/093
index f4ee873a2a62e4..eb4bea6cae48d6 100755
--- a/tests/btrfs/093
+++ b/tests/btrfs/093
@@ -15,10 +15,8 @@
 . ./common/preamble
 _begin_fstest auto quick clone
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 _require_cloner
diff --git a/tests/btrfs/094 b/tests/btrfs/094
index 75804465d0ad17..cde26a2a510761 100755
--- a/tests/btrfs/094
+++ b/tests/btrfs/094
@@ -27,10 +27,8 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 _require_cloner
diff --git a/tests/btrfs/095 b/tests/btrfs/095
index 3bd34c72e8eb39..b0076f3f1bd8cc 100755
--- a/tests/btrfs/095
+++ b/tests/btrfs/095
@@ -22,11 +22,9 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# Import common functions.
 . ./common/filter
 . ./common/dmflakey
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 _require_dm_target flakey
diff --git a/tests/btrfs/096 b/tests/btrfs/096
index 8081868293e275..8e014cd24cc1fa 100755
--- a/tests/btrfs/096
+++ b/tests/btrfs/096
@@ -9,11 +9,9 @@
 . ./common/preamble
 _begin_fstest auto quick clone
 
-# Import common functions.
 . ./common/filter
 . ./common/filter.btrfs
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 _require_cloner
diff --git a/tests/btrfs/097 b/tests/btrfs/097
index 16ed7e008fc7eb..3cd48822d9f5ad 100755
--- a/tests/btrfs/097
+++ b/tests/btrfs/097
@@ -17,10 +17,8 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 _require_cloner
diff --git a/tests/btrfs/098 b/tests/btrfs/098
index d4e9f43dbae9d1..092543f40a11db 100755
--- a/tests/btrfs/098
+++ b/tests/btrfs/098
@@ -18,11 +18,9 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# Import common functions.
 . ./common/filter
 . ./common/dmflakey
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 _require_dm_target flakey
diff --git a/tests/btrfs/099 b/tests/btrfs/099
index f3a2002a072029..f19c301cf5d6ff 100755
--- a/tests/btrfs/099
+++ b/tests/btrfs/099
@@ -10,11 +10,8 @@
 . ./common/preamble
 _begin_fstest auto quick qgroup limit
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
-
 _supported_fs btrfs
 _require_scratch
 _require_btrfs_qgroup_report
diff --git a/tests/btrfs/100 b/tests/btrfs/100
index 410e83ba176194..53fc548957ee70 100755
--- a/tests/btrfs/100
+++ b/tests/btrfs/100
@@ -17,7 +17,6 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# Import common functions.
 . ./common/filter
 . ./common/filter.btrfs
 . ./common/dmerror
diff --git a/tests/btrfs/101 b/tests/btrfs/101
index e8ed8c5c735133..fe380d73d69425 100755
--- a/tests/btrfs/101
+++ b/tests/btrfs/101
@@ -17,7 +17,6 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# Import common functions.
 . ./common/filter
 . ./common/filter.btrfs
 . ./common/dmerror
diff --git a/tests/btrfs/102 b/tests/btrfs/102
index 2a384f3cb74ea5..303904b8e6ae54 100755
--- a/tests/btrfs/102
+++ b/tests/btrfs/102
@@ -10,10 +10,8 @@
 . ./common/preamble
 _begin_fstest auto quick metadata enospc balance
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 
diff --git a/tests/btrfs/103 b/tests/btrfs/103
index 57309106e1dc0c..b60527cb1602b9 100755
--- a/tests/btrfs/103
+++ b/tests/btrfs/103
@@ -10,10 +10,8 @@
 . ./common/preamble
 _begin_fstest auto quick clone compress
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 _require_cloner
diff --git a/tests/btrfs/104 b/tests/btrfs/104
index c9528eb13d610d..d2e10c3ee74987 100755
--- a/tests/btrfs/104
+++ b/tests/btrfs/104
@@ -19,10 +19,8 @@
 . ./common/preamble
 _begin_fstest auto qgroup
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 _require_btrfs_qgroup_report
diff --git a/tests/btrfs/105 b/tests/btrfs/105
index b6cc23b928f28e..988ce05ccf870f 100755
--- a/tests/btrfs/105
+++ b/tests/btrfs/105
@@ -20,10 +20,8 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 
diff --git a/tests/btrfs/106 b/tests/btrfs/106
index 7444e4d5a7cb12..2eb02be7de75ee 100755
--- a/tests/btrfs/106
+++ b/tests/btrfs/106
@@ -11,10 +11,8 @@
 . ./common/preamble
 _begin_fstest auto quick clone compress
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 _require_cloner
diff --git a/tests/btrfs/107 b/tests/btrfs/107
index 58ff6936c2ecb0..ae83f4d37b2637 100755
--- a/tests/btrfs/107
+++ b/tests/btrfs/107
@@ -10,12 +10,9 @@
 . ./common/preamble
 _begin_fstest auto quick prealloc
 
-# Import common functions.
 . ./common/filter
 . ./common/defrag
 
-# real QA test starts here
-
 _supported_fs btrfs
 _require_scratch
 _require_xfs_io_command "falloc"
diff --git a/tests/btrfs/108 b/tests/btrfs/108
index 0f734e9cfa0dd7..3fe06461cd7c3e 100755
--- a/tests/btrfs/108
+++ b/tests/btrfs/108
@@ -18,11 +18,9 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# Import common functions.
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 _require_cp_reflink
diff --git a/tests/btrfs/109 b/tests/btrfs/109
index c545733e067a4c..2fbfdb6c5dd6d2 100755
--- a/tests/btrfs/109
+++ b/tests/btrfs/109
@@ -18,11 +18,9 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# Import common functions.
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 _require_cp_reflink
diff --git a/tests/btrfs/110 b/tests/btrfs/110
index 86049233b490ee..7c3f7228bcdfcf 100755
--- a/tests/btrfs/110
+++ b/tests/btrfs/110
@@ -18,10 +18,8 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 
diff --git a/tests/btrfs/111 b/tests/btrfs/111
index f03555bbbec97f..e9f0d432750e52 100755
--- a/tests/btrfs/111
+++ b/tests/btrfs/111
@@ -18,10 +18,8 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 
diff --git a/tests/btrfs/112 b/tests/btrfs/112
index fd7aaad41ffb9b..2e1238288f666d 100755
--- a/tests/btrfs/112
+++ b/tests/btrfs/112
@@ -10,11 +10,9 @@
 . ./common/preamble
 _begin_fstest auto quick clone prealloc compress
 
-# Import common functions.
 . ./common/filter
 . ./common/filter.btrfs
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 _require_cloner
diff --git a/tests/btrfs/113 b/tests/btrfs/113
index 7c90c3b61b3281..a076a06f20edae 100755
--- a/tests/btrfs/113
+++ b/tests/btrfs/113
@@ -12,11 +12,9 @@
 . ./common/preamble
 _begin_fstest auto quick compress clone
 
-# Import common functions.
 . ./common/filter
 . ./common/filter.btrfs
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 _require_cloner
diff --git a/tests/btrfs/114 b/tests/btrfs/114
index 28e1ce3499042b..35efbd7714d816 100755
--- a/tests/btrfs/114
+++ b/tests/btrfs/114
@@ -10,10 +10,8 @@
 . ./common/preamble
 _begin_fstest auto qgroup
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 
diff --git a/tests/btrfs/115 b/tests/btrfs/115
index 715f10b21d1a20..4af83b617a62e7 100755
--- a/tests/btrfs/115
+++ b/tests/btrfs/115
@@ -10,10 +10,8 @@
 . ./common/preamble
 _begin_fstest auto qgroup
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 
diff --git a/tests/btrfs/116 b/tests/btrfs/116
index 2449e6e3a64df3..99da568dab6a0e 100755
--- a/tests/btrfs/116
+++ b/tests/btrfs/116
@@ -12,10 +12,8 @@
 . ./common/preamble
 _begin_fstest auto quick metadata
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 # Writing non-contiguous data directly to the device
diff --git a/tests/btrfs/117 b/tests/btrfs/117
index 6539827b5a40b7..942e85fab1d0cd 100755
--- a/tests/btrfs/117
+++ b/tests/btrfs/117
@@ -13,11 +13,9 @@ _begin_fstest auto quick send clone
 
 tmp=`mktemp -d`
 
-# Import common functions.
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 _require_cp_reflink
diff --git a/tests/btrfs/118 b/tests/btrfs/118
index bd47748d8a8c84..3cc2729c588180 100755
--- a/tests/btrfs/118
+++ b/tests/btrfs/118
@@ -19,11 +19,9 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# Import common functions.
 . ./common/filter
 . ./common/dmflakey
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 _require_dm_target flakey
diff --git a/tests/btrfs/119 b/tests/btrfs/119
index d1926da99ee319..85aaf35958e95f 100755
--- a/tests/btrfs/119
+++ b/tests/btrfs/119
@@ -18,11 +18,9 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# Import common functions.
 . ./common/filter
 . ./common/dmflakey
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 _require_dm_target flakey
diff --git a/tests/btrfs/120 b/tests/btrfs/120
index ba297bbb9abf4c..4e692c4cc24836 100755
--- a/tests/btrfs/120
+++ b/tests/btrfs/120
@@ -20,11 +20,9 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# Import common functions.
 . ./common/filter
 . ./common/dmflakey
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 _require_dm_target flakey
diff --git a/tests/btrfs/121 b/tests/btrfs/121
index 009f3b72172826..649d1676167d25 100755
--- a/tests/btrfs/121
+++ b/tests/btrfs/121
@@ -14,10 +14,8 @@
 . ./common/preamble
 _begin_fstest auto quick snapshot qgroup
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 
diff --git a/tests/btrfs/122 b/tests/btrfs/122
index 0d585a99972a3c..fc8ea5ec0fe083 100755
--- a/tests/btrfs/122
+++ b/tests/btrfs/122
@@ -10,10 +10,8 @@
 . ./common/preamble
 _begin_fstest auto quick snapshot qgroup
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 _require_btrfs_qgroup_report
diff --git a/tests/btrfs/123 b/tests/btrfs/123
index 4c5b7e116a4d9e..db7b1986241beb 100755
--- a/tests/btrfs/123
+++ b/tests/btrfs/123
@@ -13,12 +13,8 @@
 . ./common/preamble
 _begin_fstest auto quick qgroup balance
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
-
-# Modify as appropriate.
 _supported_fs btrfs
 _require_scratch
 _require_btrfs_qgroup_report
diff --git a/tests/btrfs/124 b/tests/btrfs/124
index 3d8141a109f0c6..f1e33c8c7948f1 100755
--- a/tests/btrfs/124
+++ b/tests/btrfs/124
@@ -33,11 +33,8 @@ _cleanup()
 	_btrfs_rescan_devices
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
-
 _supported_fs btrfs
 _require_scratch_dev_pool 2
 _test_unmount
diff --git a/tests/btrfs/125 b/tests/btrfs/125
index 1b6e5d78b2f1f0..78c52b3e7d9deb 100755
--- a/tests/btrfs/125
+++ b/tests/btrfs/125
@@ -32,11 +32,8 @@ _cleanup()
 	_btrfs_rescan_devices
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
-
 _supported_fs btrfs
 _require_scratch_dev_pool 3
 _test_unmount
diff --git a/tests/btrfs/126 b/tests/btrfs/126
index 1bb24e00f98ace..74a507dd64d092 100755
--- a/tests/btrfs/126
+++ b/tests/btrfs/126
@@ -9,12 +9,8 @@
 . ./common/preamble
 _begin_fstest auto quick qgroup limit
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
-
-# Modify as appropriate.
 _supported_fs btrfs
 _require_scratch
 _require_btrfs_qgroup_report
diff --git a/tests/btrfs/127 b/tests/btrfs/127
index f21531729e6be1..45a6d2d175071d 100755
--- a/tests/btrfs/127
+++ b/tests/btrfs/127
@@ -19,10 +19,8 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_test
 _require_scratch
diff --git a/tests/btrfs/128 b/tests/btrfs/128
index baf194cf6f744e..e68d03197f952e 100755
--- a/tests/btrfs/128
+++ b/tests/btrfs/128
@@ -18,10 +18,8 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_test
 _require_scratch
diff --git a/tests/btrfs/129 b/tests/btrfs/129
index 4e3046f3f38cc6..9147b9d2939eba 100755
--- a/tests/btrfs/129
+++ b/tests/btrfs/129
@@ -19,10 +19,8 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_test
 _require_scratch
diff --git a/tests/btrfs/130 b/tests/btrfs/130
index 6d9ddd4883dd61..52352d47ed4904 100755
--- a/tests/btrfs/130
+++ b/tests/btrfs/130
@@ -14,13 +14,9 @@
 . ./common/preamble
 _begin_fstest auto quick clone send
 
-# Import common functions.
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
-
-# Modify as appropriate.
 _supported_fs btrfs
 _require_scratch
 _require_scratch_reflink
diff --git a/tests/btrfs/131 b/tests/btrfs/131
index 529ee3e80f87eb..8e64191ed677a5 100755
--- a/tests/btrfs/131
+++ b/tests/btrfs/131
@@ -9,11 +9,8 @@
 . ./common/preamble
 _begin_fstest auto quick
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
-
 _supported_fs btrfs
 _require_scratch
 _require_btrfs_command inspect-internal dump-super
diff --git a/tests/btrfs/132 b/tests/btrfs/132
index f50420f5118139..9e801d0081c8a3 100755
--- a/tests/btrfs/132
+++ b/tests/btrfs/132
@@ -21,12 +21,8 @@ _cleanup()
 	wait
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
-
-# Modify as appropriate.
 _supported_fs btrfs
 _require_scratch
 
diff --git a/tests/btrfs/133 b/tests/btrfs/133
index 4f45d6e8480cd8..428736ef8aff14 100755
--- a/tests/btrfs/133
+++ b/tests/btrfs/133
@@ -19,10 +19,8 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_test
 _require_scratch
diff --git a/tests/btrfs/134 b/tests/btrfs/134
index b16fbc7437a6ca..a48b5bbdb5b967 100755
--- a/tests/btrfs/134
+++ b/tests/btrfs/134
@@ -19,10 +19,8 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_test
 _require_scratch
diff --git a/tests/btrfs/135 b/tests/btrfs/135
index 36270562ebd9c5..f57a8ad2bf7b68 100755
--- a/tests/btrfs/135
+++ b/tests/btrfs/135
@@ -20,10 +20,8 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_test
 _require_scratch
diff --git a/tests/btrfs/136 b/tests/btrfs/136
index 70e836a50c7b2c..3cb7150f9e64a8 100755
--- a/tests/btrfs/136
+++ b/tests/btrfs/136
@@ -14,12 +14,8 @@
 . ./common/preamble
 _begin_fstest auto convert
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
-
-# Modify as appropriate.
 _supported_fs btrfs
 _require_scratch_nocheck
 # ext4 does not support zoned block device
diff --git a/tests/btrfs/137 b/tests/btrfs/137
index 7d03c2602bacf7..acef0b750de872 100755
--- a/tests/btrfs/137
+++ b/tests/btrfs/137
@@ -17,11 +17,9 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# Import common functions.
 . ./common/filter
 . ./common/punch
 
-# real QA test starts here
 _supported_fs btrfs
 _require_test
 _require_scratch
diff --git a/tests/btrfs/138 b/tests/btrfs/138
index 427fdede01b243..c2d272d10b9747 100755
--- a/tests/btrfs/138
+++ b/tests/btrfs/138
@@ -10,11 +10,8 @@
 . ./common/preamble
 _begin_fstest auto compress
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
-
 _supported_fs btrfs
 _require_scratch
 _require_btrfs_command property
diff --git a/tests/btrfs/139 b/tests/btrfs/139
index f3d92ba468b6d1..f29324d3432295 100755
--- a/tests/btrfs/139
+++ b/tests/btrfs/139
@@ -12,7 +12,6 @@
 . ./common/preamble
 _begin_fstest auto qgroup limit
 
-# Import common functions.
 . ./common/filter
 
 _supported_fs btrfs
diff --git a/tests/btrfs/140 b/tests/btrfs/140
index 5ce658860c055d..f1bee5d3841234 100755
--- a/tests/btrfs/140
+++ b/tests/btrfs/140
@@ -14,12 +14,8 @@
 . ./common/preamble
 _begin_fstest auto quick read_repair fiemap
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
-
-# Modify as appropriate.
 _supported_fs btrfs
 _require_scratch_dev_pool 2
 # No data checksums for NOCOW case, so can't detect corruption and repair data.
diff --git a/tests/btrfs/141 b/tests/btrfs/141
index e1adb91e4d0a68..c78ee33e484cad 100755
--- a/tests/btrfs/141
+++ b/tests/btrfs/141
@@ -15,12 +15,8 @@
 . ./common/preamble
 _begin_fstest auto quick read_repair
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
-
-# Modify as appropriate.
 _supported_fs btrfs
 # No data checksums for NOCOW case, so can't detect corruption and repair data.
 _require_btrfs_no_nodatacow
diff --git a/tests/btrfs/142 b/tests/btrfs/142
index 7a63fb83fb10a2..d9a8609e2be1bf 100755
--- a/tests/btrfs/142
+++ b/tests/btrfs/142
@@ -15,13 +15,9 @@
 . ./common/preamble
 _begin_fstest auto quick read_repair
 
-# Import common functions.
 . ./common/filter
 . ./common/dmdust
 
-# real QA test starts here
-
-# Modify as appropriate.
 _supported_fs btrfs
 _require_scratch_dev_pool 2
 _require_dm_target dust
diff --git a/tests/btrfs/143 b/tests/btrfs/143
index b6ff2a424af626..07ebf33c347029 100755
--- a/tests/btrfs/143
+++ b/tests/btrfs/143
@@ -22,13 +22,9 @@
 . ./common/preamble
 _begin_fstest auto quick read_repair
 
-# Import common functions.
 . ./common/filter
 . ./common/dmdust
 
-# real QA test starts here
-
-# Modify as appropriate.
 _supported_fs btrfs
 _require_scratch_dev_pool 2
 _require_dm_target dust
diff --git a/tests/btrfs/144 b/tests/btrfs/144
index d41ce7e3c7f566..daae7821ce2790 100755
--- a/tests/btrfs/144
+++ b/tests/btrfs/144
@@ -19,10 +19,8 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_test
 _require_scratch
diff --git a/tests/btrfs/145 b/tests/btrfs/145
index ba97a2ad09bc3d..4e10a0e032a81d 100755
--- a/tests/btrfs/145
+++ b/tests/btrfs/145
@@ -19,10 +19,8 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_test
 _require_scratch
diff --git a/tests/btrfs/146 b/tests/btrfs/146
index e3b75dc0b8d32d..f734b610684e91 100755
--- a/tests/btrfs/146
+++ b/tests/btrfs/146
@@ -20,11 +20,9 @@ _cleanup()
     _dmerror_cleanup
 }
 
-# Import common functions.
 . ./common/filter
 . ./common/dmerror
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 _require_scratch_dev_pool
diff --git a/tests/btrfs/147 b/tests/btrfs/147
index 74ead3d6d13526..71703be320a5e4 100755
--- a/tests/btrfs/147
+++ b/tests/btrfs/147
@@ -19,10 +19,8 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_test
 _require_scratch
diff --git a/tests/btrfs/148 b/tests/btrfs/148
index 65a262922569bc..52a416c11e7543 100755
--- a/tests/btrfs/148
+++ b/tests/btrfs/148
@@ -9,10 +9,8 @@
 . ./common/preamble
 _begin_fstest auto quick rw scrub
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 _require_scratch_dev_pool 4
diff --git a/tests/btrfs/149 b/tests/btrfs/149
index d6dce45dcef579..5054a57c1c8ae8 100755
--- a/tests/btrfs/149
+++ b/tests/btrfs/149
@@ -20,11 +20,9 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# Import common functions.
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _supported_fs btrfs
 _require_test
 _require_scratch
diff --git a/tests/btrfs/150 b/tests/btrfs/150
index c21e0a66b144b4..a02bdafc61c1dc 100755
--- a/tests/btrfs/150
+++ b/tests/btrfs/150
@@ -13,13 +13,9 @@
 . ./common/preamble
 _begin_fstest auto quick dangerous read_repair compress
 
-# Import common functions.
 . ./common/filter
 . ./common/fail_make_request
 
-# real QA test starts here
-
-# Modify as appropriate.
 _supported_fs btrfs
 _require_scratch
 _require_fail_make_request
diff --git a/tests/btrfs/151 b/tests/btrfs/151
index 54cd0827d915cb..edf42a83d3af4c 100755
--- a/tests/btrfs/151
+++ b/tests/btrfs/151
@@ -13,12 +13,8 @@
 . ./common/preamble
 _begin_fstest auto quick volume
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
-
-# Modify as appropriate.
 _supported_fs btrfs
 _require_scratch
 _require_scratch_dev_pool 3
diff --git a/tests/btrfs/152 b/tests/btrfs/152
index 75f576c3cfcaa0..8094320f3fdc46 100755
--- a/tests/btrfs/152
+++ b/tests/btrfs/152
@@ -10,10 +10,8 @@
 . ./common/preamble
 _begin_fstest auto quick metadata qgroup send
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 
diff --git a/tests/btrfs/153 b/tests/btrfs/153
index 4a5fe2b8ce4fae..ecd648c2421bf2 100755
--- a/tests/btrfs/153
+++ b/tests/btrfs/153
@@ -9,12 +9,8 @@
 . ./common/preamble
 _begin_fstest auto quick qgroup limit preallocrw
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
-
-# Modify as appropriate.
 _supported_fs btrfs
 _require_scratch
 _require_btrfs_qgroup_report
diff --git a/tests/btrfs/154 b/tests/btrfs/154
index 6be2d5f6420924..ccd7603580ecce 100755
--- a/tests/btrfs/154
+++ b/tests/btrfs/154
@@ -14,11 +14,8 @@
 . ./common/preamble
 _begin_fstest auto quick
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
-
 _supported_fs btrfs
 _require_scratch
 _require_command $PYTHON3_PROG python3
diff --git a/tests/btrfs/155 b/tests/btrfs/155
index e99a1054dab1bd..70cccab7cd1576 100755
--- a/tests/btrfs/155
+++ b/tests/btrfs/155
@@ -19,10 +19,8 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_test
 _require_scratch
diff --git a/tests/btrfs/156 b/tests/btrfs/156
index 4f323f3703de59..eb8fd0624761b9 100755
--- a/tests/btrfs/156
+++ b/tests/btrfs/156
@@ -17,12 +17,8 @@
 . ./common/preamble
 _begin_fstest auto quick trim balance
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
-
-# Modify as appropriate.
 _supported_fs btrfs
 _require_scratch
 _require_fstrim
diff --git a/tests/btrfs/157 b/tests/btrfs/157
index 648db0d09d3df0..788687efb957a7 100755
--- a/tests/btrfs/157
+++ b/tests/btrfs/157
@@ -23,12 +23,8 @@
 . ./common/preamble
 _begin_fstest auto quick raid read_repair
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
-
-# Modify as appropriate.
 _supported_fs btrfs
 # No data checksums for NOCOW case, so can't detect corruption and repair data.
 _require_btrfs_no_nodatacow
diff --git a/tests/btrfs/158 b/tests/btrfs/158
index 28599d096305ec..b45e4dcdce04bc 100755
--- a/tests/btrfs/158
+++ b/tests/btrfs/158
@@ -15,12 +15,8 @@
 . ./common/preamble
 _begin_fstest auto quick raid scrub
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
-
-# Modify as appropriate.
 _supported_fs btrfs
 # No data checksums for NOCOW case, so can't detect corruption and repair data.
 _require_btrfs_no_nodatacow
diff --git a/tests/btrfs/159 b/tests/btrfs/159
index 7641f65db537f8..0cbf5be142dca1 100755
--- a/tests/btrfs/159
+++ b/tests/btrfs/159
@@ -19,11 +19,9 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# Import common functions.
 . ./common/filter
 . ./common/dmflakey
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 _require_dm_target flakey
diff --git a/tests/btrfs/160 b/tests/btrfs/160
index 48c2133c9622df..23a2a8c42f3a9f 100755
--- a/tests/btrfs/160
+++ b/tests/btrfs/160
@@ -19,11 +19,9 @@ _cleanup()
 	_dmerror_cleanup
 }
 
-# Import common functions.
 . ./common/filter
 . ./common/dmerror
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch_dev_pool
 
diff --git a/tests/btrfs/161 b/tests/btrfs/161
index 5aac8fe93a3bdc..2fbbc54010a3d8 100755
--- a/tests/btrfs/161
+++ b/tests/btrfs/161
@@ -11,12 +11,8 @@
 . ./common/preamble
 _begin_fstest auto quick volume seed
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
-
-# Modify as appropriate.
 _supported_fs btrfs
 _require_command "$BTRFS_TUNE_PROG" btrfstune
 _require_scratch_dev_pool 2
diff --git a/tests/btrfs/162 b/tests/btrfs/162
index 1d8dbf9546be4f..68652a355a8250 100755
--- a/tests/btrfs/162
+++ b/tests/btrfs/162
@@ -12,13 +12,9 @@
 . ./common/preamble
 _begin_fstest auto quick volume seed
 
-# Import common functions.
 . ./common/filter
 . ./common/filter.btrfs
 
-# real QA test starts here
-
-# Modify as appropriate.
 _supported_fs btrfs
 _require_command "$BTRFS_TUNE_PROG" btrfstune
 _require_scratch_dev_pool 3
diff --git a/tests/btrfs/163 b/tests/btrfs/163
index da31cfb8f1dd03..c7a29bf33af39e 100755
--- a/tests/btrfs/163
+++ b/tests/btrfs/163
@@ -24,13 +24,9 @@ _cleanup()
 	_btrfs_rescan_devices
 }
 
-# Import common functions.
 . ./common/filter
 . ./common/filter.btrfs
 
-# real QA test starts here
-
-# Modify as appropriate.
 _supported_fs btrfs
 _require_command "$BTRFS_TUNE_PROG" btrfstune
 _require_scratch_dev_pool 3
diff --git a/tests/btrfs/164 b/tests/btrfs/164
index bc62b535ca0c66..d5e91cfacefe1e 100755
--- a/tests/btrfs/164
+++ b/tests/btrfs/164
@@ -20,9 +20,6 @@ _cleanup()
 	_btrfs_rescan_devices
 }
 
-# real QA test starts here
-
-# Modify as appropriate.
 _supported_fs btrfs
 _require_btrfs_forget_or_module_loadable
 _require_scratch_dev_pool 2
diff --git a/tests/btrfs/165 b/tests/btrfs/165
index c4a52a155a425c..bab40060b9d57d 100755
--- a/tests/btrfs/165
+++ b/tests/btrfs/165
@@ -31,10 +31,8 @@ rm_r_subvol() {
 	rm -r $1 >> $seqres.full 2>&1
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 _require_btrfs_fs_feature "rmdir_subvol"
diff --git a/tests/btrfs/166 b/tests/btrfs/166
index 47f7f9b38debd3..726db698e70201 100755
--- a/tests/btrfs/166
+++ b/tests/btrfs/166
@@ -19,11 +19,9 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# Import common functions.
 . ./common/filter
 . ./common/dmflakey
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 _require_dm_target flakey
diff --git a/tests/btrfs/167 b/tests/btrfs/167
index 7ab2fdbaa60e1c..fb087a7385efe2 100755
--- a/tests/btrfs/167
+++ b/tests/btrfs/167
@@ -13,12 +13,8 @@
 . ./common/preamble
 _begin_fstest auto quick replace volume remount compress
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
-
-# Modify as appropriate.
 _supported_fs btrfs
 _require_scratch_dev_pool 2
 _require_scratch_dev_pool_equal_size
diff --git a/tests/btrfs/168 b/tests/btrfs/168
index acc58b51ee3954..29a18183d53fee 100755
--- a/tests/btrfs/168
+++ b/tests/btrfs/168
@@ -19,10 +19,8 @@ _cleanup()
 	rm -fr $send_files_dir
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_test
 _require_scratch
diff --git a/tests/btrfs/169 b/tests/btrfs/169
index 009fdaee7c466d..269c1a586f6975 100755
--- a/tests/btrfs/169
+++ b/tests/btrfs/169
@@ -19,10 +19,8 @@ _cleanup()
 	rm -fr $send_files_dir
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_test
 _require_scratch
diff --git a/tests/btrfs/170 b/tests/btrfs/170
index ab105d36fb969e..fcbd38b9a284a1 100755
--- a/tests/btrfs/170
+++ b/tests/btrfs/170
@@ -11,10 +11,8 @@
 . ./common/preamble
 _begin_fstest auto quick snapshot prealloc
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 _require_xfs_io_command "falloc" "-k"
diff --git a/tests/btrfs/171 b/tests/btrfs/171
index 6a1ed1c1a9d4f4..e820fd9d573205 100755
--- a/tests/btrfs/171
+++ b/tests/btrfs/171
@@ -13,11 +13,9 @@
 . ./common/preamble
 _begin_fstest auto quick qgroup
 
-# Import common functions.
 . ./common/filter
 . ./common/filter.btrfs
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 
diff --git a/tests/btrfs/172 b/tests/btrfs/172
index f2997c047effb0..0b7cf1b749a3c3 100755
--- a/tests/btrfs/172
+++ b/tests/btrfs/172
@@ -20,13 +20,9 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# Import common functions.
 . ./common/filter
 . ./common/dmlogwrites
 
-# real QA test starts here
-
-# Modify as appropriate.
 _supported_fs btrfs
 _require_scratch
 _require_log_writes
diff --git a/tests/btrfs/176 b/tests/btrfs/176
index 0ddff8d8e62d22..7675441083319f 100755
--- a/tests/btrfs/176
+++ b/tests/btrfs/176
@@ -9,12 +9,8 @@
 . ./common/preamble
 _begin_fstest auto quick swap volume
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
-
-# Modify as appropriate.
 _supported_fs btrfs
 _require_scratch_dev_pool 3
 _require_scratch_swapfile
diff --git a/tests/btrfs/177 b/tests/btrfs/177
index 7b004b83c15fd9..38c3d41d49d3a2 100755
--- a/tests/btrfs/177
+++ b/tests/btrfs/177
@@ -11,7 +11,6 @@ _begin_fstest auto quick swap balance
 
 . ./common/filter
 
-# Modify as appropriate.
 _supported_fs btrfs
 _require_scratch_swapfile
 
diff --git a/tests/btrfs/178 b/tests/btrfs/178
index 5e148615a1840d..fda287dd9dcc4f 100755
--- a/tests/btrfs/178
+++ b/tests/btrfs/178
@@ -21,10 +21,8 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_test
 _require_scratch
diff --git a/tests/btrfs/179 b/tests/btrfs/179
index 00013af0a19038..7fcdbfd32d9c31 100755
--- a/tests/btrfs/179
+++ b/tests/btrfs/179
@@ -12,12 +12,8 @@
 . ./common/preamble
 _begin_fstest auto qgroup dangerous
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
-
-# Modify as appropriate.
 _supported_fs btrfs
 _require_scratch
 
diff --git a/tests/btrfs/180 b/tests/btrfs/180
index aa195f7b40085d..59bb3c83d68cd4 100755
--- a/tests/btrfs/180
+++ b/tests/btrfs/180
@@ -13,12 +13,8 @@
 . ./common/preamble
 _begin_fstest auto quick qgroup limit prealloc
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
-
-# Modify as appropriate.
 _supported_fs btrfs
 _require_scratch
 _require_xfs_io_command falloc
diff --git a/tests/btrfs/181 b/tests/btrfs/181
index 8a3c3c17ed08ab..068e6e8e4e9566 100755
--- a/tests/btrfs/181
+++ b/tests/btrfs/181
@@ -13,12 +13,8 @@
 . ./common/preamble
 _begin_fstest auto quick balance
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
-
-# Modify as appropriate.
 _supported_fs btrfs
 _require_scratch
 _require_btrfs_command inspect-internal dump-super
diff --git a/tests/btrfs/182 b/tests/btrfs/182
index 1967469bbed4bb..b5bd022b73e742 100755
--- a/tests/btrfs/182
+++ b/tests/btrfs/182
@@ -15,12 +15,8 @@
 . ./common/preamble
 _begin_fstest auto quick balance
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
-
-# Modify as appropriate.
 _supported_fs btrfs
 _require_scratch
 
diff --git a/tests/btrfs/183 b/tests/btrfs/183
index e7afb0588e01f4..9d3e78cc855536 100755
--- a/tests/btrfs/183
+++ b/tests/btrfs/183
@@ -10,11 +10,9 @@
 . ./common/preamble
 _begin_fstest auto quick clone compress punch
 
-# Import common functions.
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch_reflink
 _require_xfs_io_command "fpunch"
diff --git a/tests/btrfs/184 b/tests/btrfs/184
index ee43a8d3a387aa..ad95745780d260 100755
--- a/tests/btrfs/184
+++ b/tests/btrfs/184
@@ -10,10 +10,8 @@
 . ./common/preamble
 _begin_fstest auto quick volume
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 _require_scratch_dev_pool 2
diff --git a/tests/btrfs/185 b/tests/btrfs/185
index c7b8d2d46951d5..2050672edf0bac 100755
--- a/tests/btrfs/185
+++ b/tests/btrfs/185
@@ -21,10 +21,8 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch_dev_pool 2
 _scratch_dev_pool_get 2
diff --git a/tests/btrfs/186 b/tests/btrfs/186
index b52d0b05cf6cc8..164e39757c1a34 100755
--- a/tests/btrfs/186
+++ b/tests/btrfs/186
@@ -20,10 +20,8 @@ _cleanup()
 	rm -fr $send_files_dir
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_test
 _require_scratch
diff --git a/tests/btrfs/187 b/tests/btrfs/187
index d3cf05a1bd92f5..326071b8609168 100755
--- a/tests/btrfs/187
+++ b/tests/btrfs/187
@@ -15,12 +15,10 @@
 . ./common/preamble
 _begin_fstest auto send dedupe clone balance
 
-# Import common functions.
 . ./common/attr
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch_dedupe
 _require_attrs
diff --git a/tests/btrfs/188 b/tests/btrfs/188
index fcaf84b15053c7..2791a133fa73a0 100755
--- a/tests/btrfs/188
+++ b/tests/btrfs/188
@@ -20,10 +20,8 @@ _cleanup()
 	rm -fr $send_files_dir
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_test
 _require_scratch
diff --git a/tests/btrfs/189 b/tests/btrfs/189
index ec6e56fa0020e0..fb7ebfad360315 100755
--- a/tests/btrfs/189
+++ b/tests/btrfs/189
@@ -22,11 +22,9 @@ _cleanup()
 	rm -fr $send_files_dir
 }
 
-# Import common functions.
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _supported_fs btrfs
 _require_fssum
 _require_test
diff --git a/tests/btrfs/190 b/tests/btrfs/190
index f78c14fe446458..6d805e6be17aa8 100755
--- a/tests/btrfs/190
+++ b/tests/btrfs/190
@@ -10,13 +10,9 @@
 . ./common/preamble
 _begin_fstest auto quick replay balance qgroup recoveryloop
 
-# Import common functions.
 . ./common/filter
 . ./common/dmlogwrites
 
-# real QA test starts here
-
-# Modify as appropriate.
 _supported_fs btrfs
 _require_scratch
 # and we need extra device as log device
diff --git a/tests/btrfs/191 b/tests/btrfs/191
index 3c565d0ad20999..60b08137db0aa5 100755
--- a/tests/btrfs/191
+++ b/tests/btrfs/191
@@ -18,11 +18,9 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# Import common functions.
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _supported_fs btrfs
 _require_test
 _require_scratch_dedupe
diff --git a/tests/btrfs/192 b/tests/btrfs/192
index 00ea1478ab1a71..0a35e055b3ce9a 100755
--- a/tests/btrfs/192
+++ b/tests/btrfs/192
@@ -22,14 +22,10 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# Import common functions.
 . ./common/filter
 . ./common/attr
 . ./common/dmlogwrites
 
-# real QA test starts here
-
-# Modify as appropriate.
 _supported_fs btrfs
 
 _require_command "$KILLALL_PROG" killall
diff --git a/tests/btrfs/193 b/tests/btrfs/193
index 67220c7a5c68df..bf9e92b4aaf91a 100755
--- a/tests/btrfs/193
+++ b/tests/btrfs/193
@@ -12,12 +12,8 @@
 . ./common/preamble
 _begin_fstest auto quick qgroup enospc limit prealloc
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
-
-# Modify as appropriate.
 _supported_fs btrfs
 _require_scratch
 _require_xfs_io_command falloc
diff --git a/tests/btrfs/194 b/tests/btrfs/194
index d749377cb19eb0..726f61d4298a9c 100755
--- a/tests/btrfs/194
+++ b/tests/btrfs/194
@@ -13,12 +13,8 @@
 . ./common/preamble
 _begin_fstest auto volume
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
-
-# Modify as appropriate.
 _supported_fs btrfs
 _require_scratch_dev_pool 2
 _scratch_dev_pool_get 2
diff --git a/tests/btrfs/195 b/tests/btrfs/195
index 96cc4134392592..c820c9d2718325 100755
--- a/tests/btrfs/195
+++ b/tests/btrfs/195
@@ -10,12 +10,8 @@
 . ./common/preamble
 _begin_fstest auto volume balance scrub
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
-
-# Modify as appropriate.
 _supported_fs btrfs
 _require_scratch_dev_pool 4
 # Zoned btrfs only supports SINGLE profile
diff --git a/tests/btrfs/196 b/tests/btrfs/196
index 71b67ce2ffc0c7..9602c6f44cbc4e 100755
--- a/tests/btrfs/196
+++ b/tests/btrfs/196
@@ -25,14 +25,10 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# Import common functions.
 . ./common/filter
 . ./common/dmthin
 . ./common/dmlogwrites
 
-# real QA test starts here
-
-# Modify as appropriate.
 _supported_fs btrfs
 
 # Use thin device as replay device, which requires $SCRATCH_DEV
diff --git a/tests/btrfs/197 b/tests/btrfs/197
index d259fd99fb505d..db24f9c5ad25c5 100755
--- a/tests/btrfs/197
+++ b/tests/btrfs/197
@@ -21,11 +21,9 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# Import common functions.
 . ./common/filter
 . ./common/filter.btrfs
 
-# real QA test starts here
 _supported_fs btrfs
 _require_test
 _require_scratch
diff --git a/tests/btrfs/198 b/tests/btrfs/198
index 7d23ffcee3c5be..8312aa23353363 100755
--- a/tests/btrfs/198
+++ b/tests/btrfs/198
@@ -9,11 +9,9 @@
 . ./common/preamble
 _begin_fstest auto quick volume
 
-# Import common functions.
 . ./common/filter
 . ./common/filter.btrfs
 
-# real QA test starts here
 _supported_fs btrfs
 _require_command "$WIPEFS_PROG" wipefs
 _require_scratch
diff --git a/tests/btrfs/199 b/tests/btrfs/199
index a4920b99ef97ec..ff6877048c0372 100755
--- a/tests/btrfs/199
+++ b/tests/btrfs/199
@@ -24,12 +24,8 @@ _cleanup()
 	rm -rf $tmp.*
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
-
-# Modify as appropriate.
 _supported_fs btrfs
 _fixed_by_kernel_commit 6b7faadd985c \
 	"btrfs: Ensure we trim ranges across block group boundary"
diff --git a/tests/btrfs/200 b/tests/btrfs/200
index 5ce3775f2222f9..20f16bf7913f36 100755
--- a/tests/btrfs/200
+++ b/tests/btrfs/200
@@ -18,12 +18,10 @@ _cleanup()
 	rm -fr $send_files_dir
 }
 
-# Import common functions.
 . ./common/filter
 . ./common/reflink
 . ./common/punch
 
-# real QA test starts here
 _supported_fs btrfs
 _require_fssum
 _require_test
diff --git a/tests/btrfs/201 b/tests/btrfs/201
index e61abb5ebba06b..007319ae4ccc2b 100755
--- a/tests/btrfs/201
+++ b/tests/btrfs/201
@@ -19,12 +19,10 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# Import common functions.
 . ./common/attr
 . ./common/filter
 . ./common/dmflakey
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 _require_dm_target flakey
diff --git a/tests/btrfs/203 b/tests/btrfs/203
index e506118e2cd25c..87ed0c66ad1fa9 100755
--- a/tests/btrfs/203
+++ b/tests/btrfs/203
@@ -19,11 +19,9 @@ _cleanup()
 	rm -fr $send_files_dir
 }
 
-# Import common functions.
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _supported_fs btrfs
 _require_test
 _require_scratch_reflink
diff --git a/tests/btrfs/204 b/tests/btrfs/204
index ec751e421961a6..73511d997120e7 100755
--- a/tests/btrfs/204
+++ b/tests/btrfs/204
@@ -10,12 +10,8 @@
 . ./common/preamble
 _begin_fstest auto quick punch
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
-
-# Modify as appropriate.
 _supported_fs btrfs
 _require_scratch
 _require_xfs_io_command "fpunch"
diff --git a/tests/btrfs/205 b/tests/btrfs/205
index 728f9a7c748773..096a5dd9e2d74b 100755
--- a/tests/btrfs/205
+++ b/tests/btrfs/205
@@ -16,11 +16,9 @@
 . ./common/preamble
 _begin_fstest auto quick clone compress prealloc
 
-# Import common functions.
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch_reflink
 _require_xfs_io_command "falloc" "-k"
diff --git a/tests/btrfs/206 b/tests/btrfs/206
index 6ac3d27bbde375..79286f8768c67e 100755
--- a/tests/btrfs/206
+++ b/tests/btrfs/206
@@ -21,11 +21,9 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# Import common functions.
 . ./common/filter
 . ./common/dmlogwrites
 
-# real QA test starts here
 _supported_fs btrfs
 _require_test
 _require_scratch
diff --git a/tests/btrfs/207 b/tests/btrfs/207
index dc35899b8bdd08..fc18b17f67c28b 100755
--- a/tests/btrfs/207
+++ b/tests/btrfs/207
@@ -10,7 +10,6 @@
 . ./common/preamble
 _begin_fstest auto rw raid
 
-# Import common functions.
 . ./common/filter
 
 _supported_fs btrfs
diff --git a/tests/btrfs/208 b/tests/btrfs/208
index d58803e2f801a0..c104fa7453fd15 100755
--- a/tests/btrfs/208
+++ b/tests/btrfs/208
@@ -10,11 +10,9 @@
 . ./common/preamble
 _begin_fstest auto quick subvol
 
-# Import common functions.
 . ./common/filter
 . ./common/filter.btrfs
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 _require_btrfs_command subvolume delete --subvolid
diff --git a/tests/btrfs/209 b/tests/btrfs/209
index 3094885f585085..9f8808b60c8d9c 100755
--- a/tests/btrfs/209
+++ b/tests/btrfs/209
@@ -20,12 +20,10 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# Import common functions.
 . ./common/attr
 . ./common/filter
 . ./common/dmflakey
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 _require_dm_target flakey
diff --git a/tests/btrfs/210 b/tests/btrfs/210
index f3d769fa09de6b..021a4b8a522cd2 100755
--- a/tests/btrfs/210
+++ b/tests/btrfs/210
@@ -10,12 +10,8 @@
 . ./common/preamble
 _begin_fstest auto quick qgroup snapshot
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
-
-# Modify as appropriate.
 _supported_fs btrfs
 _require_scratch
 
diff --git a/tests/btrfs/211 b/tests/btrfs/211
index f5744b75f4e840..d80dc06f16234c 100755
--- a/tests/btrfs/211
+++ b/tests/btrfs/211
@@ -20,11 +20,9 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# Import common functions.
 . ./common/filter
 . ./common/dmflakey
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 _require_xfs_io_command "falloc" "-k"
diff --git a/tests/btrfs/212 b/tests/btrfs/212
index a7df938b9e2525..71337722b5bf92 100755
--- a/tests/btrfs/212
+++ b/tests/btrfs/212
@@ -22,12 +22,8 @@ _cleanup()
 	wait
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
-
-# Modify as appropriate.
 _supported_fs btrfs
 _require_scratch
 _require_command "$KILLALL_PROG" killall
diff --git a/tests/btrfs/213 b/tests/btrfs/213
index 816041a0cc2ea0..33504d3dac3357 100755
--- a/tests/btrfs/213
+++ b/tests/btrfs/213
@@ -17,10 +17,8 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# Import common functions.
 . ./common/filter
 
-# Modify as appropriate.
 _supported_fs btrfs
 _require_scratch
 _require_xfs_io_command pwrite -D
diff --git a/tests/btrfs/214 b/tests/btrfs/214
index 2a728f7e9ebf35..24d7c9814c4fb7 100755
--- a/tests/btrfs/214
+++ b/tests/btrfs/214
@@ -11,7 +11,6 @@ _begin_fstest auto quick send snapshot
 
 _register_cleanup "cleanup"
 
-# Import common functions.
 . ./common/filter
 
 _supported_fs btrfs
@@ -122,8 +121,6 @@ roundtrip_send()
 	_scratch_unmount
 }
 
-# real QA test starts here
-
 echo "Test full send + file without capabilities, then incremental send bringing a new capability"
 full_nocap_inc_withcap_send
 
diff --git a/tests/btrfs/215 b/tests/btrfs/215
index 6fa226fe1e056d..7054a9ba79ce25 100755
--- a/tests/btrfs/215
+++ b/tests/btrfs/215
@@ -11,10 +11,8 @@
 . ./common/preamble
 _begin_fstest auto quick read_repair
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 get_physical()
 {
 	$BTRFS_UTIL_PROG inspect-internal dump-tree -t 3 $SCRATCH_DEV | \
@@ -22,7 +20,6 @@ get_physical()
 		$AWK_PROG "(\$1 ~ /stripe/ && \$3 ~ /devid/ && \$2 ~ /0/) { print \$6 }"
 }
 
-# Modify as appropriate.
 _supported_fs btrfs
 _require_scratch
 # No data checksums for NOCOW case, so can't detect corruption and repair data.
diff --git a/tests/btrfs/216 b/tests/btrfs/216
index 979dcb73f09742..e606ca33afbdc3 100755
--- a/tests/btrfs/216
+++ b/tests/btrfs/216
@@ -10,10 +10,8 @@
 . ./common/preamble
 _begin_fstest auto quick seed
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _fixed_by_kernel_commit 4faf55b03823 \
 	"btrfs: don't traverse into the seed devices in show_devname"
diff --git a/tests/btrfs/217 b/tests/btrfs/217
index 92bbba2336ad6a..f96a6933ba28b9 100755
--- a/tests/btrfs/217
+++ b/tests/btrfs/217
@@ -12,12 +12,8 @@
 . ./common/preamble
 _begin_fstest auto quick trim dangerous
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
-
-# Modify as appropriate.
 _supported_fs btrfs
 _require_scratch_size $((5 * 1024 * 1024)) #kB
 _require_fstrim
diff --git a/tests/btrfs/218 b/tests/btrfs/218
index b0434834ff6536..3afa95af109770 100755
--- a/tests/btrfs/218
+++ b/tests/btrfs/218
@@ -10,13 +10,9 @@
 . ./common/preamble
 _begin_fstest auto quick volume
 
-# Import common functions.
 . ./common/filter
 . ./common/filter.btrfs
 
-# real QA test starts here
-
-# Modify as appropriate.
 _supported_fs btrfs
 _fixed_by_kernel_commit 124604eb50f8 \
 	"btrfs: init device stats for seed devices"
diff --git a/tests/btrfs/219 b/tests/btrfs/219
index 9da835dcab10fc..6f89b8aed3a620 100755
--- a/tests/btrfs/219
+++ b/tests/btrfs/219
@@ -35,11 +35,8 @@ _cleanup()
 	_btrfs_rescan_devices
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
-
 _supported_fs btrfs
 
 loop_mnt1=$TEST_DIR/$seq/mnt1
diff --git a/tests/btrfs/220 b/tests/btrfs/220
index a7ec6558b4ca98..2b62c9bbef13fe 100755
--- a/tests/btrfs/220
+++ b/tests/btrfs/220
@@ -12,7 +12,6 @@ _begin_fstest auto quick remount
 
 _register_cleanup "cleanup"
 
-# Import common functions.
 . ./common/filter
 
 _supported_fs btrfs
@@ -325,7 +324,6 @@ _try_scratch_mount "-o clear_cache" > /dev/null 2>&1 && \
 	  echo $shown_opts | grep -q clear_cache && enable_clear_cache_shown=true
 	  _scratch_unmount; }
 
-# real QA test starts here
 _scratch_mkfs >/dev/null
 
 # This test checks mount options, so having random MOUNT_OPTIONS set could
diff --git a/tests/btrfs/221 b/tests/btrfs/221
index a3007587c3bf73..be5d7be3965bf3 100755
--- a/tests/btrfs/221
+++ b/tests/btrfs/221
@@ -21,10 +21,8 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_test
 _require_scratch
diff --git a/tests/btrfs/222 b/tests/btrfs/222
index f45247649456c9..e732101195fb91 100755
--- a/tests/btrfs/222
+++ b/tests/btrfs/222
@@ -20,10 +20,8 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_test
 _require_scratch
diff --git a/tests/btrfs/223 b/tests/btrfs/223
index 8125cdf25770a5..e69ed7062b74e3 100755
--- a/tests/btrfs/223
+++ b/tests/btrfs/223
@@ -12,10 +12,8 @@
 . ./common/preamble
 _begin_fstest auto quick replace trim
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch_dev_pool 3
 _require_command "$WIPEFS_PROG" wipefs
diff --git a/tests/btrfs/224 b/tests/btrfs/224
index 611df3ab4217c2..28b39121cb15c6 100755
--- a/tests/btrfs/224
+++ b/tests/btrfs/224
@@ -9,13 +9,9 @@
 . ./common/preamble
 _begin_fstest auto quick qgroup
 
-# Import common functions.
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
-
-# Modify as appropriate.
 _supported_fs btrfs
 
 _require_scratch
diff --git a/tests/btrfs/225 b/tests/btrfs/225
index 677c162cb63aec..d6b1cbc1f82cf9 100755
--- a/tests/btrfs/225
+++ b/tests/btrfs/225
@@ -21,12 +21,8 @@ _cleanup()
 	_btrfs_rescan_devices
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
-
-# Modify as appropriate.
 _supported_fs btrfs
 _fixed_by_kernel_commit b5ddcffa3777 \
 	"btrfs: fix put of uninitialized kobject after seed device delete"
diff --git a/tests/btrfs/226 b/tests/btrfs/226
index 7034fcc7b2a57e..f60947ced41e76 100755
--- a/tests/btrfs/226
+++ b/tests/btrfs/226
@@ -10,11 +10,9 @@
 . ./common/preamble
 _begin_fstest auto quick rw snapshot clone prealloc punch
 
-# Import common functions.
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch_reflink
 _require_chattr C
diff --git a/tests/btrfs/227 b/tests/btrfs/227
index c881ab986a604f..4663874c29cc20 100755
--- a/tests/btrfs/227
+++ b/tests/btrfs/227
@@ -20,10 +20,8 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_test
 _require_scratch
diff --git a/tests/btrfs/228 b/tests/btrfs/228
index 5ef1dfd74188f8..c7eeade1ab0434 100755
--- a/tests/btrfs/228
+++ b/tests/btrfs/228
@@ -9,12 +9,8 @@
 . ./common/preamble
 _begin_fstest auto quick volume
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
-
-# Modify as appropriate.
 _supported_fs btrfs
 _require_scratch
 _require_btrfs_command inspect-internal dump-tree
diff --git a/tests/btrfs/229 b/tests/btrfs/229
index 6c8c819352bd73..54ed74a104a2aa 100755
--- a/tests/btrfs/229
+++ b/tests/btrfs/229
@@ -20,11 +20,9 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# Import common functions.
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _supported_fs btrfs
 _require_test
 _require_scratch_reflink
diff --git a/tests/btrfs/230 b/tests/btrfs/230
index 7a4cd18e926872..4cef062b0a5830 100755
--- a/tests/btrfs/230
+++ b/tests/btrfs/230
@@ -10,11 +10,8 @@
 . ./common/preamble
 _begin_fstest auto quick qgroup limit
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
-
 _supported_fs btrfs
 
 # This test requires specific data space usage, skip if we have compression
diff --git a/tests/btrfs/231 b/tests/btrfs/231
index 562f1fffd4b2b7..69801295894eee 100755
--- a/tests/btrfs/231
+++ b/tests/btrfs/231
@@ -21,11 +21,9 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# Import common functions.
 . ./common/filter
 . ./common/dmflakey
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 _require_btrfs_fs_feature "no_holes"
diff --git a/tests/btrfs/232 b/tests/btrfs/232
index 84c39c071d5296..9caeee4c6825bc 100755
--- a/tests/btrfs/232
+++ b/tests/btrfs/232
@@ -14,7 +14,6 @@
 . ./common/preamble
 _begin_fstest auto quick qgroup limit
 
-# Import common functions.
 . ./common/filter
 
 writer()
@@ -29,8 +28,6 @@ writer()
 	done
 }
 
-# real QA test starts here
-
 _supported_fs btrfs
 
 # This test requires specific data space usage, skip if we have compression
diff --git a/tests/btrfs/233 b/tests/btrfs/233
index f2c1eba090be6e..1a7ea6ada3a9ba 100755
--- a/tests/btrfs/233
+++ b/tests/btrfs/233
@@ -19,12 +19,10 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# Import common functions.
 . ./common/filter
 . ./common/filter.btrfs
 . ./common/dmflakey
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 _require_dm_target flakey
diff --git a/tests/btrfs/234 b/tests/btrfs/234
index 542515e81525d3..eccfc5ca7b8d99 100755
--- a/tests/btrfs/234
+++ b/tests/btrfs/234
@@ -10,11 +10,9 @@
 . ./common/preamble
 _begin_fstest auto quick compress rw
 
-# Import common functions.
 . ./common/filter
 . ./common/attr
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 _require_odirect
diff --git a/tests/btrfs/235 b/tests/btrfs/235
index cfa7603c2da667..a1ec3aadb3d442 100755
--- a/tests/btrfs/235
+++ b/tests/btrfs/235
@@ -19,10 +19,8 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_test
 _require_scratch
diff --git a/tests/btrfs/236 b/tests/btrfs/236
index 8481d8f380d2ce..ed3bddb880d3ab 100755
--- a/tests/btrfs/236
+++ b/tests/btrfs/236
@@ -19,11 +19,9 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# Import common functions.
 . ./common/filter
 . ./common/dmflakey
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 _require_dm_target flakey
diff --git a/tests/btrfs/237 b/tests/btrfs/237
index 367019b6025d25..33b2f262ca030d 100755
--- a/tests/btrfs/237
+++ b/tests/btrfs/237
@@ -12,11 +12,8 @@
 . ./common/preamble
 _begin_fstest auto quick zone balance
 
-# Import common functions.
 . ./common/zoned
 
-# real QA test starts here
-
 _supported_fs btrfs
 _require_scratch
 _require_btrfs_command inspect-internal dump-tree
diff --git a/tests/btrfs/238 b/tests/btrfs/238
index 3a711ea7a1a829..b85eb3400eddea 100755
--- a/tests/btrfs/238
+++ b/tests/btrfs/238
@@ -9,12 +9,8 @@
 . ./common/preamble
 _begin_fstest auto quick seed trim
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
-
-# Modify as appropriate.
 _supported_fs btrfs
 _fixed_by_kernel_commit 5e753a817b2d \
 	"btrfs: fix unmountable seed device after fstrim"
diff --git a/tests/btrfs/239 b/tests/btrfs/239
index 5a2dbe58d5fb28..41fe438ebc56db 100755
--- a/tests/btrfs/239
+++ b/tests/btrfs/239
@@ -21,11 +21,9 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# Import common functions.
 . ./common/filter
 . ./common/dmflakey
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 _require_dm_target flakey
diff --git a/tests/btrfs/240 b/tests/btrfs/240
index afc6aae0234656..f0fcf8a482b149 100755
--- a/tests/btrfs/240
+++ b/tests/btrfs/240
@@ -21,11 +21,9 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# Import common functions.
 . ./common/filter
 . ./common/dmflakey
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 _require_dm_target flakey
diff --git a/tests/btrfs/241 b/tests/btrfs/241
index d7348edf0c82d6..32f0e109339bcc 100755
--- a/tests/btrfs/241
+++ b/tests/btrfs/241
@@ -21,10 +21,8 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_test
 _require_scratch
diff --git a/tests/btrfs/242 b/tests/btrfs/242
index 6ce620810ce22b..8daf0f2e098748 100755
--- a/tests/btrfs/242
+++ b/tests/btrfs/242
@@ -11,10 +11,8 @@
 . ./common/preamble
 _begin_fstest auto quick volume trim
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_btrfs_forget_or_module_loadable
 _require_scratch_dev_pool 2
diff --git a/tests/btrfs/243 b/tests/btrfs/243
index 09a63bcd23f7b7..1ad0fa5804a1ec 100755
--- a/tests/btrfs/243
+++ b/tests/btrfs/243
@@ -23,8 +23,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmflakey
 
-# real QA test starts here
-
 _supported_fs btrfs
 _require_scratch
 _require_dm_target flakey
diff --git a/tests/btrfs/244 b/tests/btrfs/244
index fbefeedf313da6..4c5d69e71c9abe 100755
--- a/tests/btrfs/244
+++ b/tests/btrfs/244
@@ -17,12 +17,6 @@ _begin_fstest auto quick volume dangerous
 # 	rm -r -f $tmp.*
 # }
 
-# Import common functions.
-# . ./common/filter
-
-# real QA test starts here
-
-# Modify as appropriate.
 _supported_fs btrfs
 _require_scratch
 
diff --git a/tests/btrfs/245 b/tests/btrfs/245
index 426aab1c4b1e9b..c580b1fada5198 100755
--- a/tests/btrfs/245
+++ b/tests/btrfs/245
@@ -10,11 +10,8 @@
 . ./common/preamble
 _begin_fstest auto quick idmapped subvol
 
-# get standard environment, filters and checks
 . ./common/filter
 
-# real QA test starts here
-
 _supported_fs btrfs
 _require_idmapped_mounts
 _require_test
diff --git a/tests/btrfs/246 b/tests/btrfs/246
index 2fe54f9590480c..3617d7fc3ffdf8 100755
--- a/tests/btrfs/246
+++ b/tests/btrfs/246
@@ -16,10 +16,8 @@ _cleanup()
 	rm -r -f $tmp.*
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 
diff --git a/tests/btrfs/247 b/tests/btrfs/247
index ca0f41a1401311..341496e431644d 100755
--- a/tests/btrfs/247
+++ b/tests/btrfs/247
@@ -12,12 +12,8 @@
 . ./common/preamble
 _begin_fstest auto quick rename subvol
 
-# Import common functions.
  . ./common/renameat2
 
-# real QA test starts here
-
-# Modify as appropriate.
 _supported_fs btrfs
 _require_renameat2 exchange
 _require_scratch
diff --git a/tests/btrfs/248 b/tests/btrfs/248
index 856cd489d4e4d5..8e6d9211cbeeb5 100755
--- a/tests/btrfs/248
+++ b/tests/btrfs/248
@@ -14,12 +14,6 @@
 . ./common/preamble
 _begin_fstest auto quick seed volume
 
-# Import common functions.
-# . ./common/filter
-
-# real QA test starts here
-
-# Modify as appropriate.
 _supported_fs btrfs
 _require_test
 _require_scratch_dev_pool 2
diff --git a/tests/btrfs/249 b/tests/btrfs/249
index 0355434b4b5be9..c7f93ed4678cbd 100755
--- a/tests/btrfs/249
+++ b/tests/btrfs/249
@@ -16,12 +16,6 @@
 . ./common/preamble
 _begin_fstest auto quick seed volume
 
-# Import common functions.
-# . ./common/filter
-
-# real QA test starts here
-
-# Modify as appropriate.
 _supported_fs btrfs
 _require_scratch_dev_pool 3
 _require_command "$WIPEFS_PROG" wipefs
diff --git a/tests/btrfs/250 b/tests/btrfs/250
index e7ddc2f12b1861..495a323236d944 100755
--- a/tests/btrfs/250
+++ b/tests/btrfs/250
@@ -20,11 +20,8 @@ _cleanup()
 	rm -r -f $tmp.*
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
-
 _supported_fs btrfs
 _require_scratch
 _require_chattr C
diff --git a/tests/btrfs/251 b/tests/btrfs/251
index af01095828f5eb..944f0a1929487a 100755
--- a/tests/btrfs/251
+++ b/tests/btrfs/251
@@ -10,12 +10,8 @@
 . ./common/preamble
 _begin_fstest auto quick compress dangerous
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
-
-# Modify as appropriate.
 _supported_fs btrfs
 _require_scratch
 
diff --git a/tests/btrfs/252 b/tests/btrfs/252
index 8b4809b7481e0c..defca229e4acf4 100755
--- a/tests/btrfs/252
+++ b/tests/btrfs/252
@@ -32,10 +32,8 @@ _cleanup()
 	rm -r -f $tmp.*
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 _supported_fs btrfs
 # The size needed is variable as it depends on the specific randomized
diff --git a/tests/btrfs/254 b/tests/btrfs/254
index a358e374a21aef..c789d8744899a0 100755
--- a/tests/btrfs/254
+++ b/tests/btrfs/254
@@ -25,11 +25,9 @@ _cleanup()
 	cleanup_dmdev
 }
 
-# Import common functions.
 . ./common/filter
 . ./common/filter.btrfs
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch_dev_pool 3
 _require_block_device $SCRATCH_DEV
diff --git a/tests/btrfs/255 b/tests/btrfs/255
index 7e70944afa4449..21be6f872f7d65 100755
--- a/tests/btrfs/255
+++ b/tests/btrfs/255
@@ -12,7 +12,6 @@
 . ./common/preamble
 _begin_fstest auto qgroup balance
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch
 
diff --git a/tests/btrfs/256 b/tests/btrfs/256
index acbbc6fa5d4c0f..211a096237459b 100755
--- a/tests/btrfs/256
+++ b/tests/btrfs/256
@@ -20,11 +20,8 @@ _cleanup()
 	rm -r -f $tmp.*
 }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
-
 _supported_fs btrfs
 _require_scratch
 _require_fssum
diff --git a/tests/btrfs/257 b/tests/btrfs/257
index f8e69f7a6a56ed..7b4c043f119509 100755
--- a/tests/btrfs/257
+++ b/tests/btrfs/257
@@ -18,12 +18,8 @@ _begin_fstest auto quick defrag prealloc fiemap
 # 	rm -r -f $tmp.*
 # }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
-
-# Modify as appropriate.
 _supported_fs btrfs
 _require_scratch
 
diff --git a/tests/btrfs/258 b/tests/btrfs/258
index a4d15c431e6c92..7373a561152ad7 100755
--- a/tests/btrfs/258
+++ b/tests/btrfs/258
@@ -12,9 +12,6 @@ _begin_fstest auto defrag quick fiemap remount
 
 . ./common/filter
 
-# real QA test starts here
-
-# Modify as appropriate.
 _supported_fs generic
 _require_scratch
 _require_xfs_io_command "fiemap"
diff --git a/tests/btrfs/259 b/tests/btrfs/259
index 7f053ac938339f..5b0bf7e0b037b0 100755
--- a/tests/btrfs/259
+++ b/tests/btrfs/259
@@ -10,12 +10,8 @@
 . ./common/preamble
 _begin_fstest auto quick defrag fiemap compress
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
-
-# Modify as appropriate.
 _supported_fs btrfs
 _require_scratch
 _require_xfs_io_command "fiemap"
diff --git a/tests/btrfs/260 b/tests/btrfs/260
index 111a3bd6127c69..b16e8378e8eebb 100755
--- a/tests/btrfs/260
+++ b/tests/btrfs/260
@@ -17,12 +17,8 @@ _begin_fstest auto quick defrag compress prealloc fiemap
 # 	rm -r -f $tmp.*
 # }
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
-
-# Modify as appropriate.
 _supported_fs btrfs
 _require_scratch
 _require_xfs_io_command "fiemap" "ranged"
diff --git a/tests/btrfs/262 b/tests/btrfs/262
index d58afa461f5373..f50e5d237bbb2f 100755
--- a/tests/btrfs/262
+++ b/tests/btrfs/262
@@ -11,11 +11,8 @@
 . ./common/preamble
 _begin_fstest auto quick qgroup
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
-
 _supported_fs btrfs
 
 _require_scratch
diff --git a/tests/btrfs/263 b/tests/btrfs/263
index 5bf8d49998f39a..919724f5ef5085 100755
--- a/tests/btrfs/263
+++ b/tests/btrfs/263
@@ -10,12 +10,8 @@
 . ./common/preamble
 _begin_fstest auto quick defrag fiemap remount
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
-
-# Modify as appropriate.
 _supported_fs btrfs
 _require_scratch
 _require_xfs_io_command "fiemap" "ranged"
diff --git a/tests/btrfs/264 b/tests/btrfs/264
index 9f03ee3ac19ba5..da1057bb0b8d77 100755
--- a/tests/btrfs/264
+++ b/tests/btrfs/264
@@ -18,12 +18,9 @@
 . ./common/preamble
 _begin_fstest auto quick compress attr
 
-# Import common functions.
 . ./common/filter
 . ./common/attr
 
-# real QA test starts here
-
 _supported_fs btrfs
 _require_scratch
 _require_attrs
diff --git a/tests/btrfs/265 b/tests/btrfs/265
index 127da7ada7cd3b..0e72f8f2a11023 100755
--- a/tests/btrfs/265
+++ b/tests/btrfs/265
@@ -11,11 +11,8 @@
 . ./common/preamble
 _begin_fstest auto quick read_repair
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
-
 _supported_fs btrfs
 _require_scratch_dev_pool 3
 
diff --git a/tests/btrfs/266 b/tests/btrfs/266
index acfb1d59d4fae6..7a10b92fb5faa2 100755
--- a/tests/btrfs/266
+++ b/tests/btrfs/266
@@ -12,11 +12,8 @@
 . ./common/preamble
 _begin_fstest auto quick read_repair
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
-
 _supported_fs btrfs
 # No data checksums for NOCOW case, so can't detect corruption and repair data.
 _require_btrfs_no_nodatacow
diff --git a/tests/btrfs/267 b/tests/btrfs/267
index 51b28d9bcbe24d..e15a4623bbc3a7 100755
--- a/tests/btrfs/267
+++ b/tests/btrfs/267
@@ -12,11 +12,8 @@
 . ./common/preamble
 _begin_fstest auto quick read_repair
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
-
 _supported_fs btrfs
 _require_scratch_dev_pool 3
 
diff --git a/tests/btrfs/272 b/tests/btrfs/272
index a49ec0760fac4c..6b6dfc2e7967ec 100755
--- a/tests/btrfs/272
+++ b/tests/btrfs/272
@@ -15,7 +15,6 @@
 . ./common/preamble
 _begin_fstest auto quick send
 
-# real QA test starts here
 _supported_fs btrfs
 _fixed_by_kernel_commit 3aa5bd367fa5a3 \
 	"btrfs: send: fix sending link commands for existing file paths"
diff --git a/tests/btrfs/273 b/tests/btrfs/273
index dc9c21328613f3..bdee1a97c74021 100755
--- a/tests/btrfs/273
+++ b/tests/btrfs/273
@@ -21,11 +21,8 @@ _cleanup()
 	wait
 }
 
-# Import common functions.
 . ./common/zoned
 
-# real QA test starts here
-
 _supported_fs btrfs
 _fixed_by_kernel_commit 2ce543f47843 \
 	"btrfs: zoned: wait until zone is finished when allocation didn't progress"
diff --git a/tests/btrfs/275 b/tests/btrfs/275
index b34fbda019d85c..955a0c985f4c4f 100755
--- a/tests/btrfs/275
+++ b/tests/btrfs/275
@@ -9,11 +9,9 @@
 . ./common/preamble
 _begin_fstest auto quick attr
 
-# Import common functions.
 . ./common/filter
 . ./common/attr
 
-# real QA test starts here
 _supported_fs btrfs
 _fixed_by_kernel_commit b51111271b03 \
 	"btrfs: check if root is readonly while setting security xattr"
diff --git a/tests/btrfs/277 b/tests/btrfs/277
index f5684fde1b909c..da7dd7c153eb7b 100755
--- a/tests/btrfs/277
+++ b/tests/btrfs/277
@@ -17,13 +17,9 @@ _cleanup()
 	rm -r -f $tmp.*
 }
 
-# Import common functions.
 . ./common/filter
 . ./common/verity
 
-# real QA test starts here
-
-# Modify as appropriate.
 _supported_fs btrfs
 _require_scratch_verity
 _require_fsverity_builtin_signatures
diff --git a/tests/btrfs/278 b/tests/btrfs/278
index ff59ebd29d7b06..c5446201a6116a 100755
--- a/tests/btrfs/278
+++ b/tests/btrfs/278
@@ -15,7 +15,6 @@
 . ./common/preamble
 _begin_fstest auto quick send
 
-# real QA test starts here
 _supported_fs btrfs
 _fixed_by_kernel_commit 9ed0a72e5b355d \
 	"btrfs: send: fix failures when processing inodes with no links"
diff --git a/tests/btrfs/282 b/tests/btrfs/282
index 395e0626dadc61..2c6fc5fc777d98 100755
--- a/tests/btrfs/282
+++ b/tests/btrfs/282
@@ -11,7 +11,6 @@ _begin_fstest auto scrub
 
 . ./common/filter
 
-# real QA test starts here
 _supported_fs btrfs
 _wants_kernel_commit eb3b50536642 \
 	"btrfs: scrub: per-device bandwidth control"
diff --git a/tests/btrfs/284 b/tests/btrfs/284
index c6692668f7fcdf..b9a5f040eaef92 100755
--- a/tests/btrfs/284
+++ b/tests/btrfs/284
@@ -10,7 +10,6 @@
 . ./common/preamble
 _begin_fstest auto quick send compress snapshot
 
-# Modify as appropriate.
 _supported_fs btrfs
 _require_btrfs_send_v2
 _require_test
diff --git a/tests/btrfs/286 b/tests/btrfs/286
index 71f6d4bda84578..3429a6116ee72c 100755
--- a/tests/btrfs/286
+++ b/tests/btrfs/286
@@ -10,12 +10,8 @@
 . ./common/preamble
 _begin_fstest auto replace
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
-
-# Modify as appropriate.
 _supported_fs btrfs
 _require_command "$WIPEFS_PROG" wipefs
 _btrfs_get_profile_configs replace-missing
diff --git a/tests/btrfs/288 b/tests/btrfs/288
index efa9a631edc672..839ecc338220c6 100755
--- a/tests/btrfs/288
+++ b/tests/btrfs/288
@@ -11,13 +11,9 @@ _begin_fstest auto repair quick volume scrub
 
 . ./common/filter
 
-# real QA test starts here
-
-# Modify as appropriate.
 _supported_fs btrfs
 _require_scratch_dev_pool 2
 
-
 _require_odirect
 # Overwriting data is forbidden on a zoned block device
 _require_non_zoned_device "${SCRATCH_DEV}"
diff --git a/tests/btrfs/289 b/tests/btrfs/289
index f1aaf4cc5de4bc..148bf56a64844b 100755
--- a/tests/btrfs/289
+++ b/tests/btrfs/289
@@ -11,9 +11,6 @@ _begin_fstest auto quick scrub repair
 
 . ./common/filter
 
-# real QA test starts here
-
-# Modify as appropriate.
 _supported_fs btrfs
 _require_scratch
 # No data checksums for NOCOW case, so can't detect corruption and repair data.
diff --git a/tests/btrfs/290 b/tests/btrfs/290
index 61e741faeb4561..5b3f0029dc44ce 100755
--- a/tests/btrfs/290
+++ b/tests/btrfs/290
@@ -11,7 +11,6 @@
 . ./common/preamble
 _begin_fstest auto quick verity prealloc
 
-# Import common functions.
 . ./common/filter
 . ./common/verity
 
@@ -23,7 +22,6 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch_verity
 _require_scratch_nocheck
@@ -164,7 +162,6 @@ corrupt_merkle_tree() {
 	validate $f
 }
 
-# real QA test starts here
 _scratch_mkfs >/dev/null
 _scratch_mount
 
diff --git a/tests/btrfs/291 b/tests/btrfs/291
index bfffb845fea740..fc654565d1ee68 100755
--- a/tests/btrfs/291
+++ b/tests/btrfs/291
@@ -26,13 +26,11 @@ _cleanup()
 	_restore_fsverity_signatures
 }
 
-# Import common functions.
 . ./common/filter
 . ./common/attr
 . ./common/dmlogwrites
 . ./common/verity
 
-# real QA test starts here
 _supported_fs btrfs
 
 _require_scratch
diff --git a/tests/btrfs/292 b/tests/btrfs/292
index 32a7c3c589f053..f920d961600dcb 100755
--- a/tests/btrfs/292
+++ b/tests/btrfs/292
@@ -13,9 +13,6 @@ _begin_fstest auto raid volume trim
 
 . ./common/filter
 
-# real QA test starts here
-
-# Modify as appropriate.
 _supported_fs btrfs
 _require_scratch_dev_pool 6
 _require_fstrim
@@ -24,7 +21,6 @@ _fixed_by_kernel_commit a7299a18a179 \
 
 _scratch_dev_pool_get 6
 
-
 datasize=$((5 * 1024 * 1024 * 1024))
 filesize=$((8 * 1024 * 1024))
 nr_files=$(($datasize / $filesize))
diff --git a/tests/btrfs/294 b/tests/btrfs/294
index d7d13646f5d0d5..9d6f7566493642 100755
--- a/tests/btrfs/294
+++ b/tests/btrfs/294
@@ -9,12 +9,8 @@
 . ./common/preamble
 _begin_fstest auto raid volume
 
-# Import common functions.
 . ./common/filter
 
-# real QA test starts here
-
-# Modify as appropriate.
 _supported_fs btrfs
 
 # No zoned support for RAID56 yet.
diff --git a/tests/btrfs/296 b/tests/btrfs/296
index 27f48e7541a4fd..d4446198542a19 100755
--- a/tests/btrfs/296
+++ b/tests/btrfs/296
@@ -10,7 +10,6 @@
 . ./common/preamble
 _begin_fstest auto quick balance
 
-# real QA test starts here
 _supported_fs btrfs
 _require_scratch_dev_pool 3
 _fixed_by_kernel_commit b7625f461da6 \
diff --git a/tests/btrfs/299 b/tests/btrfs/299
index d38bf2ac1c863b..fe80771a8adb70 100755
--- a/tests/btrfs/299
+++ b/tests/btrfs/299
@@ -17,8 +17,6 @@
 . ./common/preamble
 _begin_fstest auto quick preallocrw logical_resolve
 
-# real QA test starts here
-# Modify as appropriate.
 _supported_fs btrfs
 _require_scratch
 _require_xfs_io_command "falloc" "-k"
diff --git a/tests/btrfs/301 b/tests/btrfs/301
index db4697247a88c4..05e0f4c8818354 100755
--- a/tests/btrfs/301
+++ b/tests/btrfs/301
@@ -10,12 +10,8 @@
 . ./common/preamble
 _begin_fstest auto quick qgroup clone subvol prealloc snapshot remount
 
-# Import common functions.
 . ./common/reflink
 
-# Real QA test starts here.
-
-# Modify as appropriate.
 _supported_fs btrfs
 _require_scratch_reflink
 _require_cp_reflink
diff --git a/tests/btrfs/310 b/tests/btrfs/310
index 507485a4e5963b..c83b6c2963aa8c 100755
--- a/tests/btrfs/310
+++ b/tests/btrfs/310
@@ -9,12 +9,6 @@
 . ./common/preamble
 _begin_fstest auto quick compress
 
-# Import common functions.
-# . ./common/filter
-
-# real QA test starts here
-
-# Modify as appropriate.
 _supported_fs btrfs
 _require_scratch
 
diff --git a/tests/btrfs/311 b/tests/btrfs/311
index 7de8f051248944..9899396521648d 100755
--- a/tests/btrfs/311
+++ b/tests/btrfs/311
@@ -22,7 +22,6 @@ _cleanup()
 . ./common/filter.btrfs
 . ./common/reflink
 
-# Modify as appropriate.
 _supported_fs btrfs
 _require_cp_reflink
 _require_scratch
diff --git a/tests/btrfs/320 b/tests/btrfs/320
index 408053457aba61..03a8aaa5176a78 100755
--- a/tests/btrfs/320
+++ b/tests/btrfs/320
@@ -10,7 +10,6 @@
 . ./common/preamble
 _begin_fstest auto qgroup limit
 
-# Import common functions.
 . ./common/filter
 
 _supported_fs btrfs
-- 
2.44.0

