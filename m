Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593B9131752
	for <fstests@vger.kernel.org>; Thu, 15 Feb 2024 14:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708005779; cv=none; b=V2HEp7c710cboiVUXx54KifcD5dpE5dIjbp7tw60S85JyCHTlPRvvYZ0p5GFkDAwGMP7IaIbtjCaz7ejRN2poMN2I7IB6z9eC9suPy605A2AlLAZCLtrjl5k3fvoERVBPLFylr+ITT+oFLZqn039GZ9doKmWGZF5Gpr3UDvfmfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708005779; c=relaxed/simple;
	bh=+FIG/JudQed41NWCcAarzj82jAbxGRH6EmEM9lcn0K8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F9Jm9qzmh6QYMLzgb9Dyaj/HcJhvgbSZtr8ROoo90ml7KpO3Zlzx3xG4Qy74Aoje8aXOsZu4Q+mJu7F1F7Xvt5hBf6WciL70k0W9h1cNk6MP9R9LpmXHheW0+sTqInLzNYjJ7wNnAsvV+qZKi9bLtU0wuN10inK5AKbzogkv4zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ci2paeJD; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ci2paeJD"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d109e82bd0so10658661fa.3
        for <fstests@vger.kernel.org>; Thu, 15 Feb 2024 06:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1708005775; x=1708610575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XaqEU9VJ/hJSZRWPgoI8e97jFvUw+UwwiOVKeIsG770=;
        b=ci2paeJDSAPFnOkMfdpihsMSaXWYWYhYzH+uBgdxYIH2pzCbQfpuZdkDShAZKu1Sv5
         Ay2/VNyGb/ZxEpMsur01g32aJ6RcocJ50ojweA3uCVuz3GoMNvs6cBFabEEgVk1BvfJZ
         /w+vtPgp3NG8hyVA0x2+AWFvFg9CAuSpwNvh1aoBEdZX6n9JjoxOLcEIvUU0mO6M/AnA
         DA/QLA66kh6h16xjBdJoycbog28ZnwjaYv8nyeM/yEu4YD0cWXEEC4xphp47cu0YWnKb
         /b71DuDXg5sXevrc7J2b43fMOXJPytjVg1EeXL89KuOIxyRejxxnDU+6ix6kwehd8buz
         R+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708005775; x=1708610575;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XaqEU9VJ/hJSZRWPgoI8e97jFvUw+UwwiOVKeIsG770=;
        b=a42MOxFyzPoUA/saPK++d0djF9OA0tXwyporyirSxdeC6b6NEYTARmbRVN4nYFNkvl
         79yMsC6ngW/KaUzKYeH7HnQPxGsT/K+/aW2knzPYTlstaukwqTqCrqFZkQY5mWIxbXEL
         ErxkagULEF93UlZUPkKMhJjcm/xEaqFhikpPme8wwkmrzf3CpuymAbPZg4JMveVrD3K8
         qiK0UZ7jWfGIePSEVjDtQiPpeQOsS1AmDnryDvlQa/5rRigynt7NF6CvXsqr6Z+Qjqeh
         xu9/LHdEfULigUXqqz33mC7Gbwyzb6eaWdIcBgVOR37UadjhHATQWdthTlkYRjTdRpXM
         QXkQ==
X-Gm-Message-State: AOJu0YyfIyNWtXHZXmHM93fPXHWDZtbI4caZj/bw8sKhw6kA2t9UvK/O
	viHqVosfMdC7Ep/XNeK/vH1LHLw4G6lhmFnEd3J2Oyt6IDt9nfFcSGaL5IL9yis3gMq0ixVOBk5
	k
X-Google-Smtp-Source: AGHT+IE6oQKRBaExTwRQiJ1iVb0FhqZVJezI+ztPKaMIxOSeQ7J6Njjm+hU10qzUIUCM7VjFToK/4w==
X-Received: by 2002:a2e:b6c6:0:b0:2d0:fa56:84ce with SMTP id m6-20020a2eb6c6000000b002d0fa5684cemr1358467ljo.52.1708005774638;
        Thu, 15 Feb 2024 06:02:54 -0800 (PST)
Received: from localhost.localdomain ([2406:4440:0:105::28:a])
        by smtp.gmail.com with ESMTPSA id k13-20020a170902f28d00b001d706e373a9sm1296201plc.292.2024.02.15.06.02.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 15 Feb 2024 06:02:53 -0800 (PST)
From: Su Yue <glass.su@suse.com>
X-Google-Original-From: Su Yue <l@damenly.org>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	l@damenly.org,
	Su Yue <glass.su@suse.com>
Subject: [PATCH] btrfs/172,206: call _log_writes_cleanup in _cleanup
Date: Thu, 15 Feb 2024 22:02:36 +0800
Message-Id: <20240215140236.29171-1-l@damenly.org>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Su Yue <glass.su@suse.com>

Because block group tree requires require no-holes feature,
_log_writes_mkfs "-O ^no-holes" fails when "-O block-group-tree" is
given in MKFS_OPTION.
Without explicit _log_writes_cleanup, the two tests fail with
logwrites-test device left. And all next tests will fail due to
SCRATCH DEVICE EBUSY.

Fix it by overriding _cleanup to call _log_writes_cleanup.

Signed-off-by: Su Yue <glass.su@suse.com>
---
 tests/btrfs/172 | 6 ++++++
 tests/btrfs/206 | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/tests/btrfs/172 b/tests/btrfs/172
index f5acc6982cd7..fceff56c9d37 100755
--- a/tests/btrfs/172
+++ b/tests/btrfs/172
@@ -13,6 +13,12 @@
 . ./common/preamble
 _begin_fstest auto quick log replay recoveryloop
 
+# Override the default cleanup function.
+_cleanup()
+{
+	_log_writes_cleanup &> /dev/null
+}
+
 # Import common functions.
 . ./common/filter
 . ./common/dmlogwrites
diff --git a/tests/btrfs/206 b/tests/btrfs/206
index f6571649076f..e05adf75b67e 100755
--- a/tests/btrfs/206
+++ b/tests/btrfs/206
@@ -14,6 +14,12 @@
 . ./common/preamble
 _begin_fstest auto quick log replay recoveryloop punch prealloc
 
+# Override the default cleanup function.
+_cleanup()
+{
+	_log_writes_cleanup &> /dev/null
+}
+
 # Import common functions.
 . ./common/filter
 . ./common/dmlogwrites
-- 
2.43.0

