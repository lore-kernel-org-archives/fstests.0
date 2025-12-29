Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B32C259C80
	for <fstests@vger.kernel.org>; Mon, 29 Dec 2025 02:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766975616; cv=none; b=bs7G7dcvd3JkSXgEhV9jCSvBGRGxAHJog1uke1XwJe+f5Q6XwBexLDLPdeL8qzdOW8fSyLpMTMOEEDRAUewD9LOAuXF07knLWtY5u54QymPeqJ7xZVDRMo3ZwuJu8AlKfB5OThxix3tpmTNU1tYTXxRAKqNXM69xR9vnbFzayQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766975616; c=relaxed/simple;
	bh=lAT8NP42isiYmz5b199ZZkc3JaI86MxihBw2ekRXDZs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=D6MemK279IeOAFzh9W0nTjbCKjfEnM2yi4lWx5mnq3sAo2H4Xl/e58RwqFJYBTK5GZRER/48KLa/xAVOfDV9mHuYEUF3gE7MOoQTlA9fYE1LlPqgWnBdZG/7aWphfxgegxUNmZvsExcDu1P7xjI4Y2Je9/WnLS6XJDQywbsKkEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joannechien.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BCtnpHvL; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joannechien.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BCtnpHvL"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2a08cbeb87eso145029975ad.3
        for <fstests@vger.kernel.org>; Sun, 28 Dec 2025 18:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766975613; x=1767580413; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JPBd5FIyXpPa0h8AuPLZNLXhx7uJVz25f1JF2yVxYng=;
        b=BCtnpHvLr31E6gwC+EthBHgmJ09WILDaKaPjF81/6j1ZLIOyD+ZEtlMrYnDPEsLTs1
         W61vN6YHtmMAIZrruW2dtBOGqksQfHrqpKnp+tZswDdQ84Ugwg0prAFPhBYWjYZiOD+V
         v3vvQPLYy9YdhLAtDJRPlXU8G2CiGxwSBxu9Zo/cfc+XHC9HrRwiISRci4cBOPLJY913
         ya6tJlSilByx06TwC3qxgx9ljG+3Qh9zEJO91xr7oAWInj/yyJforc94+KP9LWT6T9R8
         kwjVnPwergtvcqe2wJ7t8cnO6vP3KjF2shmq56Lxn/56SJ/9xw+ov3J4tMYjrNXV73c2
         MWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766975613; x=1767580413;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JPBd5FIyXpPa0h8AuPLZNLXhx7uJVz25f1JF2yVxYng=;
        b=vOpOAMr+QR5coM2iI0/W8Xtt6XI8j8a/5MbOnt6ULK32had8ZqU2tl67iXHNP2pwG5
         oXmwFhVtSAPFcfEvOsQ0dhQbTVZ7Pdv9q0tstIjVA8pqbSMulg2wV2+SJEa0GFdyB5kR
         0/uzvxaJjdpiMEvJaer13Ysg4c43xOVvRxfRZv8QMm7VJS0Ao+F/RrhgWwZRWYhRT52v
         dO5U5XlBMgSt/A7TlV9l39K7J5AIXKjm9BGQs7eFmdKc9uVeNsyYvA5uauDTIFBZYuid
         9WUTIrndRq67rBWt+xPAzv6vwdo0OW99yzMOa5y777Fyyk69Tqg0Dgt24OT6OkdRJWqc
         HaSA==
X-Forwarded-Encrypted: i=1; AJvYcCUBQ5Q3vIm4YvdvA2xf0AqdyVtWmEgDKtsIGSXQB5Z7zVJT9W3hr84i57EGU/+Hb1uQ3E1o6+Lh@vger.kernel.org
X-Gm-Message-State: AOJu0YxSssVtKKdWBHNzqbWkjBUB2RycdVc5PHzvIUVE1qQVk69JBzyd
	kUCNRE2TuCoke8t4hxcqLYtbarveK31ag1rySW8+gIkEQnQ4qFsllHR4XqiF78r2jk7GPNUXwEg
	vwLqSgJ9yzHvw16W/1jU//cKQbg==
X-Google-Smtp-Source: AGHT+IEHLFHcY3xAou6YQpvVPrUgXMVF+XCu+ch5MJcD36F/s1gy5J3v+Y46BB/Nh4vvzKYb38Fjct39ghEGTvgUMQ==
X-Received: from plbmj11.prod.google.com ([2002:a17:903:2b8b:b0:29e:ebb4:3936])
 (user=joannechien job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1105:b0:2a0:f83d:c321 with SMTP id d9443c01a7336-2a2f23289cemr276477685ad.23.1766975613081;
 Sun, 28 Dec 2025 18:33:33 -0800 (PST)
Date: Mon, 29 Dec 2025 02:31:45 +0000
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <20251229023145.1806877-1-joannechien@google.com>
Subject: [PATCH v2] common/rc: add _require_blocks_in_file helper
From: Joanne Chang <joannechien@google.com>
To: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net, 
	Chao Yu <chao@kernel.org>, Christoph Hellwig <hch@infradead.org>, 
	Joanne Chang <joannechien@google.com>
Content-Type: text/plain; charset="UTF-8"

generic/735 attempts to create a file with nearly 2^32 blocks. However,
some filesystems have a maximum file block limit below this threshold.
For instance, F2FS is limited to approximately 2^30 blocks due to the
capacity of the inode. So add _require_blocks_in_file helper to skip the
test in such cases.

Signed-off-by: Joanne Chang <joannechien@google.com>
---
v1 -> v2:
- changed title from "generic/735: disable for f2fs"
- used a new helper function instead of _exclude_fs as Christoph Hellwig
  suggested

 common/rc         | 16 ++++++++++++++++
 tests/generic/735 |  1 +
 2 files changed, 17 insertions(+)

diff --git a/common/rc b/common/rc
index c3cdc220..e92f4854 100644
--- a/common/rc
+++ b/common/rc
@@ -6120,6 +6120,22 @@ _require_file_attr_special()
 	fi
 }
 
+# Require filesystem to accomodate enough blocks in a file
+_require_blocks_in_file()
+{
+	local blocks=$1
+
+	case $FSTYP in
+	f2fs)
+		if [ $blocks -gt 1057053439 ]; then
+			_notrun "$blocks blocks per file not supported on $FSTYP"
+		fi
+		;;
+	*)
+		;;
+	esac
+}
+
 ################################################################################
 # make sure this script returns success
 /bin/true
diff --git a/tests/generic/735 b/tests/generic/735
index 9bbdf3a1..2fbf125c 100755
--- a/tests/generic/735
+++ b/tests/generic/735
@@ -22,6 +22,7 @@ fi
 _require_odirect
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "finsert"
+_require_blocks_in_file $(( (1 << 32) - 1 ))
 
 dev_size=$((80 * 1024 * 1024))
 _scratch_mkfs_sized $dev_size >>$seqres.full 2>&1
-- 
2.52.0.322.g1dd061c0dc-goog

