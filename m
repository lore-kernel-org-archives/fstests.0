Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793276936;
	b=rVSQzX+dqkXYdosduzcqzFWmedr3Vn2iSxY/F7RngmoMwukLgSd3L8tbiK9WpQvQQUUH
	 NSNIIj44w2ytvlcZAJMqHthCFinHDZCjxlmNJCfm+MOyVFfHtBtUkq12P9dhgzbLiEvdI
	 bdLnUuNdLnUgZXarHwrJthNTTYefgL/AIY4oP1HjvrFwVYogOWWCeUAV2O9/1cnLwHRAH
	 Ig33ioSQ2E9Ki2/SeHgxq+nWSAqeaNOgNsO5d0xLOePEnIVcHbLBwv5RYVJye2f6CONCY
	 2GFNyfnAwwbGnbm1bxBoKBYmB+kskr/ZO4gVXnuIqb5TUCS6lH174SIVqlwAPHcSaEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793276936;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=UHCq+Q1Qg64dQBjI9+7Le+PpgR5lNI91wIHu/Y3QtVA=;
	b=Tvd4yuGKsXzzQyKa7PxDN9td3XAEZrxzBjSxCmDKPXhSvyAFiAAtH4s5j+eHpJ2xseo2
	 hHF/Ja5c3xIpV1SH8MXclSmFAf+GEryDn+oVDpqzQ7onESFIlHv2BvIIvNO1CzUs8kmid
	 fi24xdA4FcTVTc3Nn5MgiLYmh/D5jD0X5oCbrz9ZZ4+60RFKZf99Xcl3Zc1q2ZTTgaM8I
	 69hrTAzfEJM2hqq0lBsygbslcuFQ7NFVQJ7sKjFdl8jxMk6AjA4Cx3d/lnLATRdw+srxh
	 mDyCjwhgV119/xeAC3B+nqAbfc6sdd1qAs73RuUyYJJ6T3fHt2Re0j5seJrdaXc8w/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z5RCd+i7;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCB8606A32C
	for <fstests@vger.kernel.org>; Thu, 29 Oct 2026 12:28:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CCB8606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z5RCd+i7
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a60f9474c4so24704585e9.0
        for <fstests@vger.kernel.org>; Thu, 29 Oct 2026 05:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793276935; x=1793881735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UHCq+Q1Qg64dQBjI9+7Le+PpgR5lNI91wIHu/Y3QtVA=;
        b=Z5RCd+i7LZ17IOuPvuX+4AT5T1xY4bX7VuSPS4UR84I3Zs12qn+na1YP41zj4oMarN
         JxCg0G5Mkf5ZqOuJDU1jZuczvmehXFYnNDJc4ZneE2Fmf3VkQbQ6p8G6+PioLqLPbdIC
         3Grp/82RqOqxeXCE1XqH2Gq7M7nFnDX+PdeNbx+eChJ27YMphq3Wk9lKVGAE23i/Bz4b
         sPS9BpRNjKSEsn+PhfTje6vVGbVQuN7hu35RHpOLgvn1r8xT5q5h5lPnLPrV3aVJTsy0
         pnV2gr3812y+ioe5OvVVRkL0cavx8bJV6dOcVMFWUcxP3BBfNyGhxPqHuEzNyHL8qslq
         Z9Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793276935; x=1793881735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UHCq+Q1Qg64dQBjI9+7Le+PpgR5lNI91wIHu/Y3QtVA=;
        b=Fb51BrmJSxzz1EO8PwKjnJpF9EZwybIWAZqNNWGeIXlKcYMERaWZGPl6tDAeAOy41M
         o62ndJxXtQJ9maJKJ3TJfLL+hbqLsiacxgGTsbXWATmiW5KGZiLGo4ZEs7fKoidmzNra
         LJQVu4ibPQ8ZyU5Y8mOzefIUW2MfhMW4vJQ355nbge1SIeJt06ifh05+uGvXGHmROloC
         8Nzv9TDDjWQ4DAMsB31YbjfERo3CEyb1TR3vaYU1n3KrKussqMU90U7QQ46BjjHwm3Lj
         v2G/nwk0trMQqd1jt7piOx4vYK+akSk/G4NU1MFxCYqLMfbHCqaxSKylMYYqXGKhU3Y9
         UNGA==
X-Gm-Message-State: AFq9FYL/szWdePamdnXywdK2SZQpb1n4rFzFCuQWw0tg4Ez0T83rTdTI
	Zhfxbs6XzXVr8IpiBaHPKu2FtqjfPLKeZlgr5bGg0r+IWN0ApcXFu4yoJFkW5att
X-Gm-Gg: AYBFou36s1MkqR8oG49kfegEztDQ0jcLjDYIwXupEQhRRIQ5/prniIXCsn0Twm0FQuA
	PdQOwavZWJjR84REhchhx3I5Fv8ZftJ7vISKDgAAqKy1/mS5jiORD3/fR78vP8hpQ25rgoS5W3s
	kdKcirHxbM6fxcuEud9Iabh8EKxZCInOe+lgkZSb0ndgfh7NcS4Zt8qPLcNu0llsIPzR7/GshKU
	cHSjEn1szV7qFoyRG3yge7pbXnZw7iIVPu8T+DuSg0VY8coUHkxNbsCFbKzV80n55GsfoTi9mNI
	o0dKRqlj8VD3nR1CDX8mMkfqPJTYpdGvo0gdF1TgEo4/uAggfXdAnmcr/YTH5hJXtRo4gHWhjCl
	cjK4vswwG1rTqLwcx+tI/NQ0Qhtx9WTtjNGUN2GCDfTEtKiyEHIVY4tVSEIae7r87P0S52xGASr
	iwbNSaf6xUkhYtK+gFrFM/yNHdJ//6SkBVXbYGYAOPF5R7ETXWnZ7COoRHi7EQZykclVzkoboEQ
	ybme5JhA+mXGNSzydBp1mqUF9lQ3zbChVGHpSK9g9K+hK2auuYnbsBXHui7VKAwId/9/BKvjvf9
	qnULgtqjw5t/Ne3VdMoS1x6fXwg9Wni11Wz7/Y1qCpHblfz+v5hSpw/aU6xLR/GjsQtjwGrGCDy
	svbYAng==
X-Received: by 2002:a05:600c:4454:b0:4a3:5a7b:6002 with SMTP id 5b1f17b1804b1-4a96720213bmr122180355e9.28.1793276934603;
        Thu, 29 Oct 2026 05:28:54 -0700 (PDT)
Received: from Cluster2.powerhub ([2a0a:ef40:18b5:9e01:225:90ff:fefc:9ffe])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa7f7f50d3sm92477915e9.8.2026.10.29.05.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 05:28:54 -0700 (PDT)
From: Artem Blagodarenko <artem.blagodarenko@gmail.com>
X-Google-Original-From: Artem Blagodarenko <ablagodarenko@thelustrecollective.com>
To: fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org,
	adilger.kernel@dilger.ca,
	ablagodarenko@thelustrecollective.com,
	Artem Blagodarenko <artem.blagodarenko@gmail.com>
Subject: [RFC PATCH v5 1/8] ext4: add common helper to check whether dirdata is applied
Date: Thu, 29 Oct 2026 12:28:32 +0000
Message-ID: <20261029122842.230704-2-ablagodarenko@thelustrecollective.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261029122842.230704-1-ablagodarenko@thelustrecollective.com>
References: <20261029122842.230704-1-ablagodarenko@thelustrecollective.com>
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

