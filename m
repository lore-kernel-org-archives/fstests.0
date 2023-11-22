Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bygTLAOw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0/7K2Wim"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359A29F
	for <fstests@vger.kernel.org>; Wed, 22 Nov 2023 09:03:27 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D4DE21F8D9
	for <fstests@vger.kernel.org>; Wed, 22 Nov 2023 17:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1700672605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=Y9cWYNBWvFgrJR3LV8qvGXBVLv9r/ucd8qJpFz+xXRY=;
	b=bygTLAOwully1L4Hw4H3GLnylh41BRPotMhzO8eDKolBj9YIRLqo+SnwX+wJPdzj3bfxvj
	mFpLSP2wvj//LuaDwSOymFVij8toX9Qcy4hZN7Yq0FNfFtkIMskZF0LlWsa7zMaTqRTG0h
	97u/oi1Hn3h4qBDoDG4cpdXviYBeFSI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1700672605;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=Y9cWYNBWvFgrJR3LV8qvGXBVLv9r/ucd8qJpFz+xXRY=;
	b=0/7K2WimiM+UUud3ukg7gxIklHaMp7pN3uTCm2WP4eflXakK4iD9FyirJHJqbyjtHC3Okz
	JdZsZgGFbAdWrVCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B16B213461
	for <fstests@vger.kernel.org>; Wed, 22 Nov 2023 17:03:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id wzg2KF00XmW5TgAAMHmgww
	(envelope-from <lhenriques@suse.de>)
	for <fstests@vger.kernel.org>; Wed, 22 Nov 2023 17:03:25 +0000
Received: from localhost (brahms.olymp [local])
	by brahms.olymp (OpenSMTPD) with ESMTPA id 5bc50212
	for <fstests@vger.kernel.org>;
	Wed, 22 Nov 2023 17:03:24 +0000 (UTC)
Date: Wed, 22 Nov 2023 17:03:24 +0000
From: Luis Henriques <lhenriques@suse.de>
To: fstests@vger.kernel.org
Subject: [PATCH] generic/581: remove extra escape character from awk line
Message-ID: <ZV40XOGNJdru13XE@suse.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-0.999];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[fstests@vger.kernel.org];
	 TO_DN_NONE(0.00)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_LAST(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]

Checking the keys in /proc/key-users is buggy, as there's an extra '\'
character: in '{print \$4}' the '$4' shouldn't be escaped otherwise the
'awk' command will fail.  This has passed unnoticed because the output
is sent to '_user_do' function and the result assigned to a variable.

While there, replace 'awk' by $AWK_PROG.

Signed-off-by: Luis Henriques <lhenriques@suse.de>
---
 tests/generic/581 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Hi!

Please note that I'm not an 'awk' expert and I may be wrong!  But if I do
see an error if I run something like:

$ awk '/^[[:space:]]*1000:/{print \$4}' /proc/key-users 
awk: cmd. line:1: /^[[:space:]]*1000:/{print \$4}
awk: cmd. line:1:                            ^ backslash not last character on line

But maybe this depends on the awk implementation, although I've tried a few.

diff --git a/tests/generic/581 b/tests/generic/581
index cabc7e1c69ab..1a4b571d40ce 100755
--- a/tests/generic/581
+++ b/tests/generic/581
@@ -92,7 +92,7 @@ while grep -E -q '^[0-9a-f]+ [^ ]*i[^ ]*' /proc/keys; do
 done
 
 # Set the user key quota to the fsgqa user's current number of keys plus 5.
-orig_keys=$(_user_do "awk '/^[[:space:]]*$(id -u fsgqa):/{print \$4}' /proc/key-users | cut -d/ -f1")
+orig_keys=$(_user_do "$AWK_PROG '/^[[:space:]]*$(id -u fsgqa):/{print $4}' /proc/key-users | cut -d/ -f1")
 : ${orig_keys:=0}
 echo "orig_keys=$orig_keys" >> $seqres.full
 orig_maxkeys=$(</proc/sys/kernel/keys/maxkeys)
