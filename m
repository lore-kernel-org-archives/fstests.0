Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E2815F312
	for <fstests@vger.kernel.org>; Thu,  1 Feb 2024 16:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706804270; cv=none; b=IH9DIXjQU0KIteSzn23hfxI0CljwsYGSmDj0nhH5gfbxaO0eDMi2mgyGDMLq2TGTsEPw33h2o5CcetbWYNFWXWgcvd8KThJEwrZ04NLRnDjzQsNRo12eLStFDDK7i249PsomqqZ0Q3OAZdgsFMuZwe6Lmq++AQtmbD9r2RDydcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706804270; c=relaxed/simple;
	bh=Wqp5EjF4eEIsy46AP+oNZbzpGY8LtjAKLRNNqf7yEEk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=niMZmvQDtQkC9NVP49Lpe8bf7wBlsZGr+sWJw6ymNgRuVmxakl0EdaPDuUEnloLNEwk0htcBuCo/2TyIQwAe268UB+8WbOpENZqaxzn2xgx7jIZIP9tqcGzNTzGtXwVkFWTaQtDV1RWq7mWUmpSLOzgmxd0EEUZ520NlnEYwiAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WtT7iuRO; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WtT7iuRO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WtT7iuRO";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WtT7iuRO"
Received: from localhost.localdomain (unknown [10.100.128.76])
	by smtp-out1.suse.de (Postfix) with ESMTP id 9331F22160
	for <fstests@vger.kernel.org>; Thu,  1 Feb 2024 16:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706804265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rX9gQQHHwlyEIEWXUfWlopzhtR538MYCXoOH9xv4Avs=;
	b=WtT7iuROWXjJuozNPsnSwYd5ottbN1XKrNMH0Gswf5rr1382I83xl1Weis6Q0hVHg/+eC6
	2s/FKtgn6yQrA+88QIw3cNobWEhHPMzRiZFmnMKq3n21gz1XyeNeySzGKA8oU2X18xHNyR
	6qyEVmLSpvsxCeQAq6l7GA9gr+5P4KU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706804265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rX9gQQHHwlyEIEWXUfWlopzhtR538MYCXoOH9xv4Avs=;
	b=WtT7iuROWXjJuozNPsnSwYd5ottbN1XKrNMH0Gswf5rr1382I83xl1Weis6Q0hVHg/+eC6
	2s/FKtgn6yQrA+88QIw3cNobWEhHPMzRiZFmnMKq3n21gz1XyeNeySzGKA8oU2X18xHNyR
	6qyEVmLSpvsxCeQAq6l7GA9gr+5P4KU=
From: Anthony Iliopoulos <ailiop@suse.com>
To: fstests@vger.kernel.org
Subject: [PATCH 1/2] generic/68[12]: use the dir blocksize for xfs filesystems
Date: Thu,  1 Feb 2024 17:17:31 +0100
Message-ID: <20240201161732.6126-2-ailiop@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240201161732.6126-1-ailiop@suse.com>
References: <20240201161732.6126-1-ailiop@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [1.90 / 50.00];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_DN_NONE(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: *
X-Spam-Score: 1.90
X-Spam-Flag: NO

The tests are using the filesystem block size for calculating the number
of dirents required to fill a 2-block directory. For v4 xfs filesystems
formatted with fs blocksize of 512 bytes this is failing, as the tests
do not take into account that the directory block size is not always
equal to the filesystem block size. As such, the tests never go over
quota, and even if they did there is no hard block limit being set (due
to 512 / 1024 = 0 calculation in setquota).

Use the directory blocksize instead of the filesystem blocksize, when
the fstype under test is xfs.

Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
---
 common/rc         | 11 +++++++++++
 tests/generic/681 |  2 +-
 tests/generic/682 |  2 +-
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/common/rc b/common/rc
index a9e0ba7e22f1..8be375965aaa 100644
--- a/common/rc
+++ b/common/rc
@@ -4719,6 +4719,17 @@ _get_block_size()
 	stat -f -c %S $1
 }
 
+# Obtain the directory block size of an fs.
+_get_dir_block_size()
+{
+	case "$FSTYP" in
+	xfs)
+		_xfs_get_dir_blocksize $1 ;;
+	*)
+		_get_block_size $1 ;;
+	esac
+}
+
 # Require that the fundamental allocation unit of a file is the same as the
 # filesystem block size.  The sole parameter must be the root dir of a
 # filesystem.
diff --git a/tests/generic/681 b/tests/generic/681
index 090da795ce64..f41647741a7d 100755
--- a/tests/generic/681
+++ b/tests/generic/681
@@ -30,7 +30,7 @@ _scratch_mkfs > "$seqres.full" 2>&1
 _qmount_option usrquota
 _qmount
 
-blocksize=$(_get_block_size $SCRATCH_MNT)
+blocksize=$(_get_dir_block_size $SCRATCH_MNT)
 scratchdir=$SCRATCH_MNT/dir
 scratchfile=$SCRATCH_MNT/file
 mkdir $scratchdir
diff --git a/tests/generic/682 b/tests/generic/682
index b4cd0cd9dd2e..a51d18338742 100755
--- a/tests/generic/682
+++ b/tests/generic/682
@@ -30,7 +30,7 @@ _scratch_mkfs > "$seqres.full" 2>&1
 _qmount_option usrquota
 _qmount
 
-blocksize=$(_get_block_size $SCRATCH_MNT)
+blocksize=$(_get_dir_block_size $SCRATCH_MNT)
 scratchdir=$SCRATCH_MNT/dir
 scratchfile=$SCRATCH_MNT/file
 stagedir=$SCRATCH_MNT/staging
-- 
2.41.0

