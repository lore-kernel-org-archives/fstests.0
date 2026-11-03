Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793713878;
	b=FrKM1s9puvCj3yFc2d3h1M+fFWogpQ8NEgYqjZGCy7DHC3l3C8xM5J1pHBQD567OpFze
	 pHCR55iPo04Yf9LPcqEzIFO8zB4FtnKRlJNqY3YMysMj3JTJ7t/jaOPIREPw1DMCAlP9P
	 tmZSzqwusTkaMZ/RLDEw79pO2x3DZ9nwNPiOIOIp86hRsLpohq3uQwFYyoEo8Uc69Ck6C
	 xnatxiYWQ6LIVeHdGREKdYS2iA3qIOProxK22cA3trazn+pCmAyEGKOHJPRQUY3n8Nadm
	 Y2YnThvugLJUiggcYdOgq8LPQKf+Lv8THjLm7xwGeCnlOFgFF8cwt207Gcs8iEar3dA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793713878;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=UHCq+Q1Qg64dQBjI9+7Le+PpgR5lNI91wIHu/Y3QtVA=;
	b=Z1jz/0lH5yMJrjrFpNUh7SGjzlhcNsp0/2RQiOO7+LhImPBz4GzINQ+PCfyTedIswGCf
	 SuK5+ACUTXYNwF6oZJUosB3IiZPm7wMKDqn90OK6n3dax+xOI9hUIhuk+/ud+YGyx47sZ
	 TOpKsqt3R59QVcV29jYAx6SkyCIjCqFTietYSpIH/wdJAozDDl6A3LQUTeV4rqsmDe9il
	 W/pz3YQx+69KLOYTUFrmmx3DW1PvY1Hj2G1E7ozFD+l4ca0HTgXI4QfbmswmRH6M8xxHh
	 y4IA5lSsKKk6ODezB5Te61ctadhodBzJ5krQuO7PN7sQ4XjNsGrNQxowtG+vG4p/Nuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NYL6MiUK;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A6F606D836
	for <fstests@vger.kernel.org>; Tue,  3 Nov 2026 13:51:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2A6F606D836
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NYL6MiUK
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a4dc547987so21498785e9.0
        for <fstests@vger.kernel.org>; Tue, 03 Nov 2026 05:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793713876; x=1794318676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UHCq+Q1Qg64dQBjI9+7Le+PpgR5lNI91wIHu/Y3QtVA=;
        b=NYL6MiUKfqMZdn4QSOvcv3Ol6upIKY2W2CrqtN2kN2BH7h22cD2dtvKEQaVH4j4v4t
         BfKOBt8r3AZhthZZ4FV0kbw9lbV+9fBifOWowIXh6shFB0sM1lkkGYTtHxZjBm/f/2Rp
         Y4k5MnGfHs+xOWWz8NPmleVJlb8V+tKQ0CJwWrTKFJK3BNv9ZYk0J5ZLAO54LUV2Gzis
         XzBchQnOYAcYoGf5pma3gcXeT7nvUoSmscwRTfUgfNzndNjXoUfa8daAxMbooMfWlBSd
         AA5kjfrM0m7ipa5H/rF7tLISRV6J82quwP2u4fp3/0JzQHhgb9aD2DFqzvmwK5jkG/L+
         ERtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793713876; x=1794318676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UHCq+Q1Qg64dQBjI9+7Le+PpgR5lNI91wIHu/Y3QtVA=;
        b=pu9lf1te988fxg9gjtB55oa6RpX3YcoKpaKVugOdpiqFEhdGkogdqpOogWwCu39asi
         KRsxEP7WhR0umCWRYFgK30M62CChycv0qjFPw4nfK5WSGX/oZNxKpnznvqoU8v3vQQiA
         86ced5EBPFkJDwgIgj9FHAStCizlOf2mTTS+18MLp8ue/dCSBcMvvWsE5Jr6dUr8As/H
         qAndjLXFXaw/VdbDwXNkWhBgEL1C/OIZ7QAZHy9/BOHkUTv3EaQYwRqJK3iosPTUKCv/
         Wa4sUfgvXvPpHoMMH/VJmrmwG+m2Mof1fJJ0CHwjm01kqDF0q4Z5OsKJi81i+evX6EeG
         4c6Q==
X-Gm-Message-State: APuU4Z9reAUcXwrzz6HypXA+CcrJgK90ww5aBsXab5uN0m6y9TvEuWB3
	zT/bmiaqLU0Yvu7/bbvfERcbbjBgR2iBRF2ez9itdRcQSPIzDXSQwjH+g2EyExcnrNM=
X-Gm-Gg: AYBFou0I0is/e2BVnlcHRx7mrxtRZ5dho4DqO19SdEk2snA2kuxfQve34COW2WigR/X
	EbkFbFsImQ8LOs0lN3vjtbiUJ0YVbv38sDn3Cd8eLRK5TErOY69kJBjm73fqNMd6gOwXHjDKPAT
	pqCrEzpZjEGSmWMbl/d9LLl6MerKqOQfA69Immni5wMgTiIsStRWj3Rtbddo00+bJHeXWdeVR3r
	gyA/wAUk9NqI6lyTR2fKBlCdwIiIdX/kx49GVdk45E3gGYn0VAG6bwvCW4ztL+YrzJd2gXKH6V3
	RVSwN49/oZab7MxiYNwy5VUclIn8JuKWTDV9csyZW9I3gna2S2TLrUqUeYATwdSc6jLRgn6x2dm
	LvvUPvHbHzBBlh69ivZAWAnqTaZF+fi4bdsi5g1WPEt99/nLzwOXft+qSNgj2OyEHxnSKg/fvgA
	npcko2AWAoyvsTxLdQU6pkKl3S4JoTgsQ/a8mTnduXrJDJF3bnjmZ++pMLONKkQj6M/dg1Q4kHW
	qkwiPkOt5akVm6fjZJtvJbVZTWamTJssOuEClAu9Q1rcPYFLSdn+27eC9nPSRkhrXMMnJlP4ity
	k8b3AqTQGxeVRNp88wcVYUDLvRrgWKyrIaQ7ORI65skdHAYqAqzQyevDekUo
X-Received: by 2002:a05:600c:3547:b0:4a1:e69d:90e8 with SMTP id 5b1f17b1804b1-4ac1889d442mr299842755e9.22.1793713876338;
        Tue, 03 Nov 2026 05:51:16 -0800 (PST)
Received: from Cluster2.powerhub ([2a0a:ef40:18b5:9e01:225:90ff:fefc:9ffe])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2a96fc87fsm55320335e9.12.2026.11.03.05.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 05:51:15 -0800 (PST)
From: Artem Blagodarenko <artem.blagodarenko@gmail.com>
X-Google-Original-From: Artem Blagodarenko <ablagodarenko@thelustrecollective.com>
To: fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org,
	adilger.kernel@dilger.ca,
	ablagodarenko@thelustrecollective.com,
	Artem Blagodarenko <artem.blagodarenko@gmail.com>
Subject: [RFC PATCH v6 1/8] ext4: add common helper to check whether dirdata is applied
Date: Tue,  3 Nov 2026 13:50:57 +0000
Message-ID: <20261103135106.610169-2-ablagodarenko@thelustrecollective.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261103135106.610169-1-ablagodarenko@thelustrecollective.com>
References: <20261103135106.610169-1-ablagodarenko@thelustrecollective.com>
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Artem Blagodarenko <artem.blagodarenko@gmail.com>

Add a helper that lists a directory with the -lD flags and checks
whether any dirdata fields exist.

This helper will be used by subsequent dirdata-related patches.

Signed-off-by: Artem Blagodarenko <artem.blagodarenko@gmail.com>
---
 common/ext4 | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/common/ext4 b/common/ext4
index a2ce456d..d36ae40a 100644
--- a/common/ext4
+++ b/common/ext4
@@ -242,3 +242,66 @@ _ext4_get_inum_iflags() {
 	debugfs -R "stat <${inumber}>" "${dev}" 2> /dev/null | \
 			sed -n 's/^.*Flags: \([0-9a-fx]*\).*$/\1/p'
 }
+
+# Helper to dump directory structure with hash info (requires dirdata feature)
+# This is useful for verifying that dirdata is storing hash information
+_dump_dir_structure()
+{
+	local dir=$1
+	local filename=$2
+	local dir_name=$(basename $dir)
+	local expected=$3
+
+	# Flush dirty filesystem buffers before reading the raw device via debugfs.
+	# ext4 with journaling writes directory-block changes to the journal first;
+	# the actual block in the backing file is not updated until checkpoint/sync.
+	# Without this sync, debugfs (which reads the loop device directly) may see
+	# stale pre-transaction data and show empty or missing dirdata fields.
+	sync
+
+	local debugfs_output=$({
+		echo "cd $dir_name"
+		echo "ls -lD ."
+		echo "quit"
+	} | debugfs $SCRATCH_DEV 2>/dev/null)
+
+	echo "  [DEBUG] debugfs output for $dir_name:" >>$seqres.full
+	echo "$debugfs_output" | grep -v "^debugfs:" | sed 's/^/    /' >>$seqres.full
+
+	# When a specific filename is given, restrict to that entry's line only.
+	# For encrypted directories the on-disk name is ciphertext, so match by
+	# inode number (first field in debugfs ls -lD output) instead of name.
+	local search_scope="$debugfs_output"
+	if [ -n "$filename" ]; then
+		local inum
+		inum=$(stat -c '%i' "$dir/$filename" 2>/dev/null)
+		if [ -n "$inum" ]; then
+			search_scope=$(echo "$debugfs_output" | awk -v n="$inum" '$1 == n')
+			# Plain-text fallback: if inode match is empty (old debugfs
+			# format or different column order) try by filename.
+			[ -z "$search_scope" ] && \
+				search_scope=$(echo "$debugfs_output" | grep -F " $filename")
+		else
+			search_scope=$(echo "$debugfs_output" | grep -F " $filename")
+		fi
+	fi
+
+	# Check if hash data is present (encryption+casefold+dirdata case)
+	# or if fid data is present (dirdata+encryption or dirdata only case)
+	if echo "$search_scope" | grep -q "fid="; then
+		local fid_value=$(echo "$search_scope" | grep -o "fid=[^ ]*" | head -1 | sed 's/^fid=//')
+		if [ "$fid_value" = "$expected" ]; then
+			echo "  Directory structure of $dir_name: OK (dirdata verified)"
+			return 0
+		else
+			echo "  Directory structure of $dir_name: FAILED (fid mismatch: got '$fid_value', expected '$expected')"
+			return 1
+		fi
+	elif echo "$search_scope" | grep -q "hash="; then
+		echo "  Directory structure of $dir_name: OK (dirdata verified)"
+		return 0
+	else
+		echo "  Directory structure of $dir_name: FAILED (no dirdata)"
+		return 1
+	fi
+}
-- 
2.52.0

