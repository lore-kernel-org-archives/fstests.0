Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640933612D
	for <fstests@vger.kernel.org>; Tue, 19 Mar 2024 18:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710872364; cv=none; b=RQUdUC2tU3kEd6RJD7aPtEV7jFjOhiDrGKz0qYqQdGElebv/ILxt11z8FTGp/ifWdAH4H3ajcd/9/HBgtHvUw0jn1ixbamef6ROJ8mIw4Gv85ACTVflT2oE2BmqXaHz541zmp2+UZX4AoNXLrDIqW/KfHl3ZB4qOGHsdSDA3ygE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710872364; c=relaxed/simple;
	bh=2F0o13IB5ykzrpJZrasp0bgkBpAvK0fQeRAUmFQuYF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b/6WDO4Src2YXMM45AU903hf/ISzmtSVJCIGcNFY9S8W8AyxUbIZEV34DfJS5G+VuWtn6Q5L+mEzQO5bgL/HPq5VSnhmFLXZoZRmlWF3IVUxnlIfsPDBFc5YDPKM/iSeVftKAlc2SqZ3fdCBrxlOVfCUuV0cyzPvctUxKuCStkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=aiCY5RDW; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=aiCY5RDW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="aiCY5RDW";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="aiCY5RDW"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9CAA71F454;
	Tue, 19 Mar 2024 18:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710872360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=feoRwtHcrS8oa6itZmGuS8rJwzHkzyv0RsmHWXh2b4U=;
	b=aiCY5RDWQK4wD2pZW5MAzzMRlJqe3SgN4Phcmgj/qTsPHTLyDu/k2xvr2oB6zr3514DUmo
	mbF+b/BwqCVdDEfR8v3wLnRr6EGHHgjugV3AfUJVGAtXaR7m98G08l3O6jlEPk8auwt4gd
	wHn1ZeLTS2IlupEcbrxRcSoAtGXWAlc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710872360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=feoRwtHcrS8oa6itZmGuS8rJwzHkzyv0RsmHWXh2b4U=;
	b=aiCY5RDWQK4wD2pZW5MAzzMRlJqe3SgN4Phcmgj/qTsPHTLyDu/k2xvr2oB6zr3514DUmo
	mbF+b/BwqCVdDEfR8v3wLnRr6EGHHgjugV3AfUJVGAtXaR7m98G08l3O6jlEPk8auwt4gd
	wHn1ZeLTS2IlupEcbrxRcSoAtGXWAlc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9698A136D6;
	Tue, 19 Mar 2024 18:19:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NYzAJCjX+WWWSwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 19 Mar 2024 18:19:20 +0000
From: David Sterba <dsterba@suse.com>
To: fstests@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 4/5] common/rc: use proper temporary file path in _repair_test_fs()
Date: Tue, 19 Mar 2024 19:12:07 +0100
Message-ID: <e8d43ad899188461f42f0184075dcaf70526bdbc.1710871719.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1710871719.git.dsterba@suse.com>
References: <cover.1710871719.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: *
X-Spam-Score: 1.13
X-Spamd-Result: default: False [1.13 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWO(0.00)[2];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-2.57)[98.10%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

The path /tmp.repair would be on the system root that could not be
writable, the temporary files are available at $tmp .

Signed-off-by: David Sterba <dsterba@suse.com>
---
 common/rc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/rc b/common/rc
index 37d26bf21b7c5f..ff2949bd05353d 100644
--- a/common/rc
+++ b/common/rc
@@ -1301,9 +1301,9 @@ _repair_test_fs()
 		;;
 	btrfs)
 	echo 'yes|$BTRFS_UTIL_PROG check --repair --force "$TEST_DEV"' > \
-								/tmp.repair 2>&1
+								$tmp.repair 2>&1
 	yes | $BTRFS_UTIL_PROG check --repair --force "$TEST_DEV" >> \
-								/tmp.repair 2>&1
+								$tmp.repair 2>&1
 		res=$?
 		;;
 	*)
-- 
2.42.1

