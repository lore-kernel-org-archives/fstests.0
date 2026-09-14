Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4387842E408
	for <fstests@vger.kernel.org>; Mon, 14 Sep 2026 14:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789394880; cv=none; b=FwI5vvUUZ5iEQY96bGqkFsXiwd4xG0FDPAhooqzWYQUAZ+rLbPSsgmixtUAm6HGpuBmLh4+wflrz7k19/PNbDYNpK1yTrsoUu8e1DVPzctK9JC+nZq2LUZmN0uXYNzlEVWGmxshHYctqORgMh9QSCcJ2rEsNGmbUceOZ0Go9878=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789394880; c=relaxed/simple;
	bh=Y5V/cJXi4Fz+jIUB4KpJWLuxlRzCD7hVtoX0QOgwtJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V4FEdp8JsFu5aWxpB4F4OLi4DJiurbNvV4d6J+wYgLwWiIqmUDxyOTdok+FsIO7yrUk8FBCGyApZaG0OLJkLgbQ+9HTtIVtlbt9rlKhQ1pR7NMlOBsWOOo+AD4zIHKduo/LlTeXgs+7Q93xEuL1S2Fb/5Tloy2kwqivzlZ3EIuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=T9zstlDg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eZSwhYbU; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KXYKVh/x; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DVcPttRl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="T9zstlDg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eZSwhYbU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KXYKVh/x";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DVcPttRl"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 79A9F1F391;
	Mon, 14 Sep 2026 14:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789394870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Df4Csx4ZcwzoW2Z7yPuLo/whD4atgWvmXPWqEUCQjbs=;
	b=T9zstlDgZSfHOSEsUgNzHHIwTjZWm+H5BjAsNsP1cqzwpqqRwk2nLBsem1bt8pWb605JAk
	a+6UYAVWkbWIlbHFVSJOFDCPZt4P/Icz6YxOSK8Xsj7D2S652gOPV43kiew5TGp4+pg6cG
	zSFnCPbCyjkCt//LMFlb8YanwGtO0pM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789394870;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Df4Csx4ZcwzoW2Z7yPuLo/whD4atgWvmXPWqEUCQjbs=;
	b=eZSwhYbUpdaF4TR8/1FaJ7pMwiu0WtktC1q/PfEtXNkTufhleGIeItDdfiEESW6+fTtj1L
	BfaWHZQBaZDvC8DQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="KXYKVh/x";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=DVcPttRl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789394866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Df4Csx4ZcwzoW2Z7yPuLo/whD4atgWvmXPWqEUCQjbs=;
	b=KXYKVh/xmYFH+lLaoXqcpOAyUstxIgoSevYgjKJyrrb4s969qMKX/S4YWK1pAsMiiCksdX
	25zHagC1q1WfKZOO2CaaRnAz7yLmkZ+2Wh8zucdej9Yt0NM3hDHsy3uRdFOl3iouILdQcI
	ktfGlMJPbJ+lWVudK65EIBj9zUh4ifE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789394866;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Df4Csx4ZcwzoW2Z7yPuLo/whD4atgWvmXPWqEUCQjbs=;
	b=DVcPttRlVlAB0q5hxMm2La4OiAf/f6DiZuuTe+cMztzK8i/VBlLe5zyToyn+JnAwdAQTlF
	hF34ZKUVUjG8j3Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B63EC136A1;
	Mon, 14 Sep 2026 14:07:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2GmLGbD/p2pQCwAAD6G6ig
	(envelope-from <ddiss@suse.de>); Mon, 14 Sep 2026 14:07:44 +0000
From: David Disseldorp <ddiss@suse.de>
To: fstests@vger.kernel.org
Cc: David Disseldorp <ddiss@suse.de>
Subject: [PATCH 1/2] report: put failure cdata collection in a helper fn
Date: Mon, 14 Sep 2026 23:46:11 +1000
Message-ID: <20260914140710.111641-2-ddiss@suse.de>
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
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 79A9F1F391
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Score: -3.01

xunit-quiet output omits all of this, so check for it once instead of
chaining "if [ -z "$quiet" -a ..." conditions.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 common/report | 79 +++++++++++++++++++++++++++------------------------
 1 file changed, 42 insertions(+), 37 deletions(-)

diff --git a/common/report b/common/report
index 2fa15e62..eff01a7f 100644
--- a/common/report
+++ b/common/report
@@ -162,6 +162,46 @@ ENDL
 	echo "Xunit report: $out_fn"
 }
 
+_xunit_log_failure_cdata()
+{
+	local report="$1"
+	local test_name="$2"
+	local full_file="${REPORT_DIR}/${test_name}.full"
+	local dmesg_file="${REPORT_DIR}/${test_name}.dmesg"
+	local out_src="${SRC_DIR}/${test_name}.out"
+	local outbad_file="${REPORT_DIR}/${test_name}.out.bad"
+	local mountfail_file="${REPORT_DIR}/${test_name}.mountfail"
+
+	if [ -s "$full_file" ]; then
+		echo -e "\t\t<system-out>" >> $report
+		printf	'<![CDATA[\n' >>$report
+		cat "$full_file" | tr -dc '[:print:][:space:]' | encode_cdata >>$report
+		printf ']]>\n'	>>$report
+		echo -e "\t\t</system-out>" >> $report
+	fi
+	if [ -f "$dmesg_file" ]; then
+		echo -e "\t\t<kernel-log>" >> $report
+		printf	'<![CDATA[\n' >>$report
+		cat "$dmesg_file" | tr -dc '[:print:][:space:]' | encode_cdata >>$report
+		printf ']]>\n'	>>$report
+		echo -e "\t\t</kernel-log>" >> $report
+	fi
+	if [ -s "$outbad_file" ]; then
+		echo -e "\t\t<system-err>" >> $report
+		printf	'<![CDATA[\n' >>$report
+		$diff "$out_src" "$outbad_file" | encode_cdata >>$report
+		printf ']]>\n'	>>$report
+		echo -e "\t\t</system-err>" >> $report
+	fi
+	if [ -f "$mountfail_file" ]; then
+		echo -e "\t\t<mount-failure>" >> $report
+		printf	'<![CDATA[\n' >>$report
+		cat "$mountfail_file" | tr -dc '[:print:][:space:]' | encode_cdata >>$report
+		printf ']]>\n'	>>$report
+		echo -e "\t\t</mount-failure>" >> $report
+	fi
+}
+
 _xunit_make_testcase_report()
 {
 	local sect_name="$1"
@@ -169,11 +209,6 @@ _xunit_make_testcase_report()
 	local test_status="$3"
 	local test_time="$4"
 	local report_format="$5"
-	local quiet
-
-	if [ "$report_format" = xunit-quiet ]; then
-		quiet=yes
-	fi
 
 	# TODO: other places may also win if no-section mode will be named like 'default/global'
 	if [ $sect_name == '-no-sections-' ]; then
@@ -198,42 +233,12 @@ _xunit_make_testcase_report()
 		echo -e "\t\t<skipped/>" >> $report
 		;;
 	"fail")
-		local out_src="${SRC_DIR}/${test_name}.out"
-		local full_file="${REPORT_DIR}/${test_name}.full"
-		local dmesg_file="${REPORT_DIR}/${test_name}.dmesg"
-		local mountfail_file="${REPORT_DIR}/${test_name}.mountfail"
-		local outbad_file="${REPORT_DIR}/${test_name}.out.bad"
 		if [ -z "$_err_msg" ]; then
 			_err_msg="Test $test_name failed, reason unknown"
 		fi
 		echo -e "\t\t<failure message=\"$_err_msg\" type=\"TestFail\" />" >> $report
-		if [ -z "$quiet" -a -s "$full_file" ]; then
-			echo -e "\t\t<system-out>" >> $report
-			printf	'<![CDATA[\n' >>$report
-			cat "$full_file" | tr -dc '[:print:][:space:]' | encode_cdata >>$report
-			printf ']]>\n'	>>$report
-			echo -e "\t\t</system-out>" >> $report
-		fi
-		if [ -z "$quiet" -a -f "$dmesg_file" ]; then
-			echo -e "\t\t<kernel-log>" >> $report
-			printf	'<![CDATA[\n' >>$report
-			cat "$dmesg_file" | tr -dc '[:print:][:space:]' | encode_cdata >>$report
-			printf ']]>\n'	>>$report
-			echo -e "\t\t</kernel-log>" >> $report
-		fi
-		if [ -z "$quiet" -a -s "$outbad_file" ]; then
-			echo -e "\t\t<system-err>" >> $report
-			printf	'<![CDATA[\n' >>$report
-			$diff "$out_src" "$outbad_file" | encode_cdata >>$report
-			printf ']]>\n'	>>$report
-			echo -e "\t\t</system-err>" >> $report
-		fi
-		if [ -z "$quiet" -a -f "$mountfail_file" ]; then
-			echo -e "\t\t<mount-failure>" >> $report
-			printf	'<![CDATA[\n' >>$report
-			cat "$mountfail_file" | tr -dc '[:print:][:space:]' | encode_cdata >>$report
-			printf ']]>\n'	>>$report
-			echo -e "\t\t</mount-failure>" >> $report
+		if [ "$report_format" != xunit-quiet ]; then
+			_xunit_log_failure_cdata "$report" "$test_name"
 		fi
 		;;
 	*)
-- 
2.55.0

