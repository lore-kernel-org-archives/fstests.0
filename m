Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4795F270545
	for <fstests@vger.kernel.org>; Thu,  8 Jan 2026 02:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767839126; cv=none; b=nfAAFe7EvU7M62WVlgUt34zyTTxKahiruCgI1k0eBIhC9+LYc7DqjOPUPuRyLpEoWPmcfSCcLgmRtHGws6l1d2rGTGG18DoCq+xpoX0u5jLuqjV7p2TCetduCSZRc9cexNmoxqi+bO4Vf3bkOwU9XT5KbnU65RWyFazDD6dQ7tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767839126; c=relaxed/simple;
	bh=e467yNGa5wztMrTorZD45QPIiy310NEM+TvhEXEyglc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OdNh+zdf9RJDYjDFYtRHvRnhymYev3oKInBNUKwW/sNBF0/IkwKrhY3Azt8pQPo5fu0y9lQB4pVe4xXOIHL5XjJ6fKrFTs6dm5mhQhG7uy6s6yZqv5CcwXgy1XoDeyPcoMvMKiBOAnW9Xml0nVAnBseSAL4C2OmxzjASHzmCQUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joannechien.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PiRxNsio; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joannechien.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PiRxNsio"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-29f13989cd3so65410495ad.1
        for <fstests@vger.kernel.org>; Wed, 07 Jan 2026 18:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767839122; x=1768443922; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SrYuwfhwfbmC/bf2zMBK+/g1Cce91zZmpkTDVhsGD/g=;
        b=PiRxNsiodg6J34I+PL9kaa660UKNE1lye8bML4spgjK0CiaJywyTHZAfR2ZRB+2Zen
         J+Mlj7yG5KJxzIPqzJkyZnWOqRQUgYLKB1VleGdkSfD4qOxmmhWz5qS8mKo4JP6y5/cA
         tepTflDUG7tVDnJ/dPCskN/KPawO8u4CRZHB3qHf1zqdp+8L6il8lnZmrCKkaJXQgJ5+
         iLMBx9o0o6kiQLHdzHVCcHycOG+TPOaDBA6uXwTggjXeptQamS7iVP4lyeRic+3mBRC5
         ggnEeySsplreNkpw3dIsvLV+PK8QHzzSiQ84HcrqZ4KN/x2ORZDENy17/qI8XWSP72+c
         3oLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767839122; x=1768443922;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SrYuwfhwfbmC/bf2zMBK+/g1Cce91zZmpkTDVhsGD/g=;
        b=YXIFhv4Bbn43IRdj2QkIvsxT+9qNLWce/2+Sw7YqOvIe+neImjR/gtAREyDKzBsSm4
         C6U0NUezI3MOeoVF6vhuWeO9rG3UX1VoV0dNmUKigGuUO/EiV0S+ojg5mQrk6pRis2tN
         z/G/WGeXn0Umtvf2I0g3VjlegtxBP0/ynnUJz4NkyEBz9F+erzN6n0rhO632Y7alIGtb
         jqUHMu3qb+W06monktGTWWPA/lcqQWhSEl7gA0X3Kd6vNmalGKnK3djzAGx6ba2RILn0
         iHLhTVyzb85sAUBOLGK/NF8mQzmWAq6RsSuORVOACJv0Fl2XDnIfPEf5Yppt5/1RzWnv
         /NBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIZkpWexKcZb813Gg43lJ3wUbNl/XrV4iRlSyQqgBJH8vvao4YQXCCzmoMSEVUpLom9t1bcHW2@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrl0BvXJ80wA66RHy/ujvan5+Ci9NRlSPCC8aJDb9xenxcKB5k
	/s+njcT2dnHY7dK6cnQIve8dOwk8O9GEPzpNCu0MTs60pLTmZQUxSfrVQsUKe6H/LWXGZCFdXLn
	MSF9gyZw3Ne2SyueQyqtmd2VDrA==
X-Google-Smtp-Source: AGHT+IHgjL+jXFv1jsSi9s5ho/HiCU622hRU7RryIEk43OP954ueCqRgazTJrQcyMRnOizOe3GIsTl7vfmnC4gjo1Q==
X-Received: from plov8.prod.google.com ([2002:a17:902:8d88:b0:293:e00:bb82])
 (user=joannechien job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:cecb:b0:29f:2b84:652b with SMTP id d9443c01a7336-2a3ee484c56mr45141305ad.29.1767839122159;
 Wed, 07 Jan 2026 18:25:22 -0800 (PST)
Date: Thu,  8 Jan 2026 02:25:01 +0000
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <20260108022501.754320-1-joannechien@google.com>
Subject: [PATCH v3] common/rc: add _require_blocks_in_file helper
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

The helper uses a hardcoded constant instead of a programmatic method,
so that bugs which affect the maximum file size are not masked.

Signed-off-by: Joanne Chang <joannechien@google.com>
---
v2 -> v3: 
- added explanation for using constants to commit message

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
2.52.0.351.gbe84eed79e-goog

