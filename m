Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C10134389C
	for <fstests@vger.kernel.org>; Mon, 14 Sep 2026 14:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789394885; cv=none; b=rkbPxSj5IAzVVp9AMLApQ8BNke8qMAAG+Mz+/qqdX32F6WDcvaGF32nTLGgBzcLIFj5oJ75Ki3eBanZJAXRdqhK4Y3tKy+3OGnFVFRHoDHFOnjQp0nhMjWj2FRv0iFPDmGEiEsYg/WVf9QihYB3v8jlhgNJ3e91grTHMLJ8OHCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789394885; c=relaxed/simple;
	bh=MjUuozjFcQyb8HGvKlacBCXiDrv1alOKLy7l64aWb3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qM2H5fCtqp/nNCkthnCOoqq7/iJSbyeLW290N/IpovSZ4GVWvBkobTYPnGCXvvMDqV0ZyBi3Gy5l8igMb4wA/4PVw3zfBnlIq4ODzJnib1OIU6ouGhiKKJaRCNCYM8eubzrTAiNTqDlLVpkKkijSnH9nEPL3maJ10oKV1XsThyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eQZrqpcK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=D/5SIAsW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WqbDn8Ei; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=E6V2Tq4G; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eQZrqpcK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="D/5SIAsW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WqbDn8Ei";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="E6V2Tq4G"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 928F61F7D7;
	Mon, 14 Sep 2026 14:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789394875; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZbEMH1hg5amTt2VIDp9zb2WNegMkP9+skbWNsWuV1cw=;
	b=eQZrqpcKvIkDE57gy6SUbGa73w3t4PJsOoqmz4bSXLYZeyDztgdCuJCg8onW0Ub0Azf+WJ
	QG4U+2MS/4UZmRm9fBTr3bLvtgckuVuts2jmMMlQRQlmzcJiRlDy9E7vHlm1I/RGIr1yw5
	QEJwyRdih9uyvTsXV1ScCkkCQLTWsFE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789394875;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZbEMH1hg5amTt2VIDp9zb2WNegMkP9+skbWNsWuV1cw=;
	b=D/5SIAsWlfNpTqC+vuHZmXGaz+5H1JXHXZlxZWEegyBbThBqQWzkBVGtjhiI/90igpIoTx
	42Dx5llmLeZEY7AQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789394871; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZbEMH1hg5amTt2VIDp9zb2WNegMkP9+skbWNsWuV1cw=;
	b=WqbDn8EiiZHF0VFUPFvpRWZU1sDrDHjO1YbQOf5wxQKByg+Y3k4RhkUGGCFwZsyeUkepUR
	XGg/njq+fLZeBNd8cGy8Wp381iRYtXwu51dPOeLNwTy8Gx978gPYyOD6zVCWJGcr+bKiNS
	poR5xAJuZyJ9lWxcWg8Sr7r772pWRy0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789394871;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZbEMH1hg5amTt2VIDp9zb2WNegMkP9+skbWNsWuV1cw=;
	b=E6V2Tq4GYXYrk8WRYSLoFTgGCCO+P8TIvdK+r16HPcIbd/FNxYjppnfLO57S3HHh2rj5Ic
	oS9pKKadHPidqcAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C65C013515;
	Mon, 14 Sep 2026 14:07:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OHgDGrX/p2pQCwAAD6G6ig
	(envelope-from <ddiss@suse.de>); Mon, 14 Sep 2026 14:07:49 +0000
From: David Disseldorp <ddiss@suse.de>
To: fstests@vger.kernel.org
Cc: David Disseldorp <ddiss@suse.de>
Subject: [PATCH 2/2] report: add xunit-gzip report type
Date: Mon, 14 Sep 2026 23:46:12 +1000
Message-ID: <20260914140710.111641-3-ddiss@suse.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914140710.111641-1-ddiss@suse.de>
References: <20260914140710.111641-1-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Score: -2.72
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.72 / 50.00];
	BAYES_HAM(-2.92)[99.66%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]

xunit xml output is quite compressible, so provide an option to do it
during report generation.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 check         |  2 +-
 common/report | 18 ++++++++++++++----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/check b/check
index bca30215..eba515bc 100755
--- a/check
+++ b/check
@@ -74,7 +74,7 @@ General options:
     -S section              exclude the specified section from the config file
     -T                      output timestamps
     -R fmt[,fmt]            generate report in formats specified. Supported
-                              formats: xunit, xunit-quiet
+                              formats: xunit, xunit-quiet, xunit-gzip
     --exact-order           run tests in the exact order specified
     --extra-space <size>    require minimum free space on scratch device
     --fs <type>             test the given FSTYP; valid types include:
diff --git a/common/report b/common/report
index eff01a7f..3aa8dcc2 100644
--- a/common/report
+++ b/common/report
@@ -110,6 +110,7 @@ _xunit_make_section_report()
 	local bad_count="$3"
 	local notrun_count="$4"
 	local sect_time="$5"
+	local report_format="$6"
 	local timestamp
 	local tmp_fn="$REPORT_DIR/result.xml.new"
 	local out_fn="$REPORT_DIR/result.xml"
@@ -158,7 +159,13 @@ ENDL
 		cat $report >> "$tmp_fn"
 	fi
 	echo "</testsuite>" >> "$tmp_fn"
-	_sync_fs "$tmp_fn" && mv "$tmp_fn" "$out_fn"
+	_sync_fs "$tmp_fn" || return
+	if [ "$report_format" = "xunit-gzip" ]; then
+		out_fn="${out_fn}.gz"
+		"$GZIP_PROG" --stdout "$tmp_fn" > "$out_fn" && rm -f "$tmp_fn"
+	else
+		mv "$tmp_fn" "$out_fn"
+	fi
 	echo "Xunit report: $out_fn"
 }
 
@@ -260,10 +267,10 @@ _make_section_report()
 	local sect_time="$5"
 	for report in $REPORT_LIST; do
 		case "$report" in
-		"xunit"|"xunit-quiet")
+		"xunit"|"xunit-quiet"|"xunit-gzip")
 			_xunit_make_section_report "$sect_name" "$tests_count" \
 						   "$bad_count" "$notrun_count" \
-						   "$sect_time"
+						   "$sect_time" "$report"
 			;;
 		*)
 			_dump_err "format '$report' is not supported"
@@ -280,7 +287,7 @@ _make_testcase_report()
 	local test_time="$4"
 	for report in $REPORT_LIST; do
 		case "$report" in
-		"xunit"|"xunit-quiet")
+		"xunit"|"xunit-quiet"|"xunit-gzip")
 			_xunit_make_testcase_report "$sect_name" "$test_seq" \
 						    "$test_status" "$test_time" "$report"
 			;;
@@ -296,6 +303,9 @@ _assert_report_list() {
 		case "$report" in
 		"xunit"|"xunit-quiet")
 			;;
+		"xunit-gzip")
+			[ -x "$GZIP_PROG" ] || _fatal "'$report' requires gzip"
+			;;
 		*)
 			_fatal "report format '$report' is not supported"
 			;;
-- 
2.55.0

