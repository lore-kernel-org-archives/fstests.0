Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C3E3985A
	for <fstests@vger.kernel.org>; Tue, 19 Mar 2024 18:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710872357; cv=none; b=svYWh57SbJsEp7gTjLeMT98Kz2tkf7+iDDjPw+G+6dtuOnO5vO27VJyvFCz/6ekLzKslDBNdc81yAzKQi4z/Ag12O642YOeV39KsWRqDm4A3uM0OtWJ9rnZGAO3qiqo5IMY5+j1RmDwsJ5H6gDvvbusQ31fHBFEXIHzvnMH844c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710872357; c=relaxed/simple;
	bh=z7tkQLJaFxbsIMjVUmGixp852DF4hTqmrcZYYNz09WA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O67gJc+NltLyfeZ8up0HmpZ/jvN8NOKKXxC/bQVb/RJ4hZz9Z+3DWDCM1XBcG36YDa2ex60y7sC7LFDr9p6N0PFiZJMG1ejbeICLg6+JHD+qI/TF+b3Ec4m8kUDpqhPB3rlN0CTziWxYXpp2j/IFVEP8Zrc12ZN41yxQgUhhDys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=coFxsLLe; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=coFxsLLe; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="coFxsLLe";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="coFxsLLe"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 80A5F1F46E;
	Tue, 19 Mar 2024 18:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710872353; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uuwtaYFspQURRhm1ZhJJM7/HhvkM2Lo97+FxTlR6kU4=;
	b=coFxsLLeqpXtAXL5ACrYGTHNiVH93UqwTGnDEg17ti6k6atS46u/FdGvvmNc+GvdYFwQxV
	n4sdy9HLthpuBxEZjUCKf4f/eniQLXXAJYkILz0GDDir539nIl/6iZLHfHm3XzQbx/lGOB
	bSmD+1kVqA27rzpWliGg98disXdSQeE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710872353; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uuwtaYFspQURRhm1ZhJJM7/HhvkM2Lo97+FxTlR6kU4=;
	b=coFxsLLeqpXtAXL5ACrYGTHNiVH93UqwTGnDEg17ti6k6atS46u/FdGvvmNc+GvdYFwQxV
	n4sdy9HLthpuBxEZjUCKf4f/eniQLXXAJYkILz0GDDir539nIl/6iZLHfHm3XzQbx/lGOB
	bSmD+1kVqA27rzpWliGg98disXdSQeE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A18C136D6;
	Tue, 19 Mar 2024 18:19:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VFbMHSHX+WWGSwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 19 Mar 2024 18:19:13 +0000
From: David Sterba <dsterba@suse.com>
To: fstests@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 1/5] common/verity: use the correct options for btrfs-corrupt-block
Date: Tue, 19 Mar 2024 19:12:00 +0100
Message-ID: <0b2ef42d6fb3e3b6ebe91c84b9a5e698af13d80b.1710871719.git.dsterba@suse.com>
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
X-Spam-Level: ***
X-Spam-Score: 3.70
X-Spamd-Result: default: False [3.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[15.44%]
X-Spam-Flag: NO

From: Josef Bacik <josef@toxicpanda.com>

A long time ago we changed the short options to long options in
btrfs-corrupt-block, so adjust the helper to use the correct options so
the verity tests pass properly.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 common/verity | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/verity b/common/verity
index 03d175ce1b7a18..0e5f0d75e746a8 100644
--- a/common/verity
+++ b/common/verity
@@ -402,7 +402,7 @@ _fsv_scratch_corrupt_merkle_tree()
 			# in the default filesystem tree (-r 5) and corrupt one byte (-b 1) at
 			# $offset (-o $offset) with the ascii representation of the byte we read
 			# (-v $ascii)
-			$BTRFS_CORRUPT_BLOCK_PROG -r 5 -I $ino,37,0 -v $ascii -o $offset -b 1 $SCRATCH_DEV
+			$BTRFS_CORRUPT_BLOCK_PROG -r 5 -I $ino,37,0 --value $ascii --offset $offset -b 1 $SCRATCH_DEV
 			(( offset += 1 ))
 		done
 		_scratch_mount
-- 
2.42.1

