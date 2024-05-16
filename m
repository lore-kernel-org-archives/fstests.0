Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474023FE4
	for <fstests@vger.kernel.org>; Thu, 16 May 2024 22:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715897577; cv=none; b=sAOY5avOKHFhWSRQVlAfLE4KEouC8mtlgKSoXZbtwQ7AwVjHjV4E4AzpgD6oIYSmUyewZbCkKyIP118zZMyxBjpZRfXF7Hal5NgH0YWZa/zyR6YW4cBl3vJjQQsEZuBPYIyfpRRJFXbWjJuwjXJPxvMim8hm28FR4VoujhV6ljk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715897577; c=relaxed/simple;
	bh=9oS8IhyRucgLBfFYzPKZxgCAn293ONv+rvggqNDDPKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IZNb/SxG1VDRTpGf1eWdVyqhXaZK8PrhJTLyRlwU44LdxAI/hlXTEpCG3P4/uslh7RV6Lz4ndKKTUeuPqVedpIiV10pQZOo7bTp1pZ1yskKm6thctfCyPJYalVRZywoTQv7poZiS4E2YUuK0MqLIzZxgxB47qnjCbJPrieLGvNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YL7AQyDV; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YL7AQyDV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YL7AQyDV";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YL7AQyDV"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6E8975CBEF;
	Thu, 16 May 2024 22:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715897573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7hJ+8JBAFLHvq9FnRn13vP0lFnauEJjYwMMrJ7yhszg=;
	b=YL7AQyDVR+4WPaW2oQb6TAmrQgRDP90GkQIPjHE6yvlDtw3lKLbfllGvSbNoEBqXZDYOXu
	0eEzHQbg23b9VDiseoIPkm2KI0iwuTLTqvC56sr2DPueGUewoE/ZC3gQkOh4BKg8JsnCx7
	mzYq8JuFeNNBMfGDMTvt8pHCZ1GoiZA=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715897573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7hJ+8JBAFLHvq9FnRn13vP0lFnauEJjYwMMrJ7yhszg=;
	b=YL7AQyDVR+4WPaW2oQb6TAmrQgRDP90GkQIPjHE6yvlDtw3lKLbfllGvSbNoEBqXZDYOXu
	0eEzHQbg23b9VDiseoIPkm2KI0iwuTLTqvC56sr2DPueGUewoE/ZC3gQkOh4BKg8JsnCx7
	mzYq8JuFeNNBMfGDMTvt8pHCZ1GoiZA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 68B28137C3;
	Thu, 16 May 2024 22:12:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6OaMGeWERmaNaQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 16 May 2024 22:12:53 +0000
From: David Sterba <dsterba@suse.com>
To: fstests@vger.kernel.org
Cc: josef@toxicpanda.com,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 6/6] btrfs/{140,141}: verify read-repair test data by md5sum
Date: Fri, 17 May 2024 00:12:53 +0200
Message-ID: <77ac47e540951bd6a292d53455d8d21682fb390c.1715896529.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1715896529.git.dsterba@suse.com>
References: <cover.1715896529.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]

From: Josef Bacik <josef@toxicpanda.com>

For validating that read repair works properly we corrupt one mirror and
then read back the physical location after we do a direct or buffered
read on the mounted file system and then unmount the file system.  The
golden output expects all a's, however with encryption this will
obviously not be the case.

However I still broke read repair, so these tests are quite valuable.
Fix them to dump the on disk values to a temporary file and then md5sum
the files, and then validate the md5sum to make sure the read repair
worked properly.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 tests/btrfs/140     | 15 ++++++++++++++-
 tests/btrfs/140.out | 34 ----------------------------------
 tests/btrfs/141     | 16 +++++++++++++++-
 tests/btrfs/141.out | 34 ----------------------------------
 4 files changed, 29 insertions(+), 70 deletions(-)

diff --git a/tests/btrfs/140 b/tests/btrfs/140
index f1bee5d3841234..eb0fbc13b2513b 100755
--- a/tests/btrfs/140
+++ b/tests/btrfs/140
@@ -74,6 +74,13 @@ devpath=$(get_device_path ${devid})
 
 _scratch_unmount
 
+# Grab the contents of the the area so we can compare to the final part
+orig=$(mktemp)
+$XFS_IO_PROG -d -c "pread -v -b 512 $physical 512" $devpath |\
+	 _filter_xfs_io_offset > $orig
+origcsum=$(_md5_checksum $orig)
+rm -f $orig
+
 echo " corrupt stripe #1, devid $devid devpath $devpath physical $physical" \
 	>> $seqres.full
 $XFS_IO_PROG -d -c "pwrite -S 0xbb -b 64K $physical 64K" $devpath > /dev/null
@@ -88,10 +95,16 @@ _btrfs_direct_read_on_mirror 1 2 "$SCRATCH_MNT/foobar" 0 128K
 _scratch_unmount
 
 # check if the repair works
+final=$(mktemp)
 $XFS_IO_PROG -d -c "pread -v -b 512 $physical 512" $devpath |\
-	_filter_xfs_io_offset
+	_filter_xfs_io_offset > $final
+finalcsum=$(_md5_checksum $final)
+rm -f $final
 
 _scratch_dev_pool_put
+
+[ "$origcsum" == "$finalcsum" ] || _fail "repair failed, csums don't match"
+
 # success, all done
 status=0
 exit
diff --git a/tests/btrfs/140.out b/tests/btrfs/140.out
index fb5aa1087235ac..58dfb24ec1a565 100644
--- a/tests/btrfs/140.out
+++ b/tests/btrfs/140.out
@@ -1,37 +1,3 @@
 QA output created by 140
 wrote 131072/131072 bytes
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-read 512/512 bytes
-XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/btrfs/141 b/tests/btrfs/141
index c78ee33e484cad..d46301a5220ba3 100755
--- a/tests/btrfs/141
+++ b/tests/btrfs/141
@@ -72,6 +72,14 @@ devid=$(get_devid ${logical_in_btrfs} 1)
 devpath=$(get_device_path ${devid})
 
 _scratch_unmount
+
+# Grab the contents of the area so we can compare to the final part
+orig=$(mktemp)
+$XFS_IO_PROG -c "pread -v -b 512 $physical 512" $devpath |\
+	_filter_xfs_io_offset > $orig
+origcsum=$(_md5_checksum $orig)
+rm -f $orig
+
 echo " corrupt stripe #1, devid $devid devpath $devpath physical $physical" \
 	>> $seqres.full
 $XFS_IO_PROG -d -c "pwrite -S 0xbb -b 64K $physical 64K" $devpath > /dev/null
@@ -86,10 +94,16 @@ _btrfs_buffered_read_on_mirror 1 2 "$SCRATCH_MNT/foobar" 0 128K
 _scratch_unmount
 
 # check if the repair works
+final=$(mktemp)
 $XFS_IO_PROG -c "pread -v -b 512 $physical 512" $devpath |\
-	_filter_xfs_io_offset
+	_filter_xfs_io_offset > $final
+finalcsum=$(_md5_checksum $final)
+rm -f $final
 
 _scratch_dev_pool_put
+
+[ "$origcsum" == "$finalcsum" ] || _fail "repair failed, csums don't match"
+
 # success, all done
 status=0
 exit
diff --git a/tests/btrfs/141.out b/tests/btrfs/141.out
index 4b8be189144e36..d8c6940f109b1d 100644
--- a/tests/btrfs/141.out
+++ b/tests/btrfs/141.out
@@ -1,37 +1,3 @@
 QA output created by 141
 wrote 131072/131072 bytes
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-read 512/512 bytes
-XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-- 
2.45.0

