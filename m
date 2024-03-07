Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748116AD7
	for <fstests@vger.kernel.org>; Thu,  7 Mar 2024 04:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709784273; cv=none; b=Wir+xQFXaAnp7Pcnc+dmCk3jBq2wUllPp2SpUKkYpeXqSDZ6gcMTMPW5aS0Q8KH6kZXUAMgdMPe+XnSiLWNVjTBRtv78lxokXRLNjYn64m9O3zbAWWGFa/xUe/Nla87sbTfsWZOEeoN+7aF/5Umtml8wW9KtNBvq2oJBi4HR3W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709784273; c=relaxed/simple;
	bh=TdgXcjZ0gFsx3wo8epCRaxlR6J9zeIhqS4k5/as/6gQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o9ERyh5l8aysZ+b9V2R1/dDD1H9A6qkCXf0cEX6G39v2VrEoivgan6yY3MdKteHU0pC8B4P4mksNZ6qEPzEjwcOX2mQwY12ZAMwSUq11JChS+lftCLQUxPnaEQYAaSCr5kmQ0q6BNW3AQgdSUW1dVBAEmXYJPJrZY0gVKVnz32w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DzT+n2sY; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DzT+n2sY"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d22b8801b9so5748571fa.0
        for <fstests@vger.kernel.org>; Wed, 06 Mar 2024 20:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1709784268; x=1710389068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mU0wz6UDyvlpQyHB3jikCpnsOok8fq51PT6jL8U6ySM=;
        b=DzT+n2sY7futNziYeZNM4GMoMGu0QnXpkJyY82O4xeMrKWxFHj6FE+Yd1Thvk9wRR4
         4Ba4lewIZn8Rc8UdeUSTXR+1Trx0IW+JJsoXTStio0Ib9eygzoxmnVMPHF7k8yF8SHkS
         3lg88kLzQaRXeojp7A7dv65aM0C/QxRHowY3/a39fvdIoW7TcABeMRj9nvI2QlUroB1V
         xD4myKLX1ojq4NezGIqwgDMzxfnpRHb6zcveVdmnAgT7I/ThkQJD9yHGMoC0qrme5D2S
         IIXSvcs3KLSJ2xWhrGySS5OigeKj06HzCpSrsgS2nMGJNCLBEu7qWhUSeied0hZ4Lah6
         Xdfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709784268; x=1710389068;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mU0wz6UDyvlpQyHB3jikCpnsOok8fq51PT6jL8U6ySM=;
        b=cjrHSKSQBLPvoLi4ogMGb9Ij+OlgV8iOoT3fMZnvuGirdwcAuECytH4qlUZvN7ZpDs
         JYmYB0Yvsj6pDOAx2XW1pazTMjUPJNvaObXaXbSxyI8/vwYWF1DbOvN5YJo2lM2QCJ7Y
         LKZCgJUTH6bJn9zjMUUFz/hA4PXh3VbXOx5FowRW0YmaJ1GlPlUhnq8DM8dJYKZgLczO
         /BdFTRamVS1ngEyFOwXi4br4tITCKuTxATGcJBDzKPSUvlIo0pyF0wK7KIJOv2a6m2qm
         QtLzIExJ8BsNnOFZT1RfQBW2gdjNArD+nA/WjJwMuyRsobsn2Eq6X5/VoHhJulGz6aE5
         Wblg==
X-Gm-Message-State: AOJu0Ywe5KEBfbVkpxuf6tDKW32059NrswORoAKo1xDQQExu5/67F9qP
	wWhUuOx0zbMPzQCMMzoyKmi2MSraO2DKA2koVF1MK1z6smrwuuGExWehnZi6elBeudw2VtelexX
	Fjjs=
X-Google-Smtp-Source: AGHT+IHIBDqhyTY1gMWyChZCD5IRpqqZwsT9QfLWJM6MA3YdrjkIYse/hTeiLeoRjfmIEImGXX7qeg==
X-Received: by 2002:a2e:b0c2:0:b0:2d2:92a2:9a84 with SMTP id g2-20020a2eb0c2000000b002d292a29a84mr460839ljl.43.1709784268053;
        Wed, 06 Mar 2024 20:04:28 -0800 (PST)
Received: from localhost.localdomain ([23.247.139.60])
        by smtp.gmail.com with ESMTPSA id r27-20020aa79edb000000b006e60c08cbcasm6847603pfq.50.2024.03.06.20.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 20:04:27 -0800 (PST)
From: Su Yue <glass.su@suse.com>
X-Google-Original-From: Su Yue <l@damenly.org>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Su Yue <glass.su@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	Qu Wenruo <wqu@suse.com>
Subject: [PATCH v3] btrfs/172,206: call _log_writes_cleanup in _cleanup
Date: Thu,  7 Mar 2024 12:04:08 +0800
Message-ID: <20240307040408.15410-1-l@damenly.org>
X-Mailer: git-send-email 2.44.0
Reply-To: 20240216102550.46210-1-l@damenly.org
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

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Su Yue <glass.su@suse.com>
---
changelog:
v3:
    Adjust custom _cleanup().
v2:
    Remove unneeded comments for _cleanup.
    Add rvbs.
---
 tests/btrfs/172 | 7 +++++++
 tests/btrfs/206 | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/tests/btrfs/172 b/tests/btrfs/172
index f5acc6982cd7..f2997c047eff 100755
--- a/tests/btrfs/172
+++ b/tests/btrfs/172
@@ -13,6 +13,13 @@
 . ./common/preamble
 _begin_fstest auto quick log replay recoveryloop
 
+_cleanup()
+{
+	cd /
+	_log_writes_cleanup &> /dev/null
+	rm -f $tmp.*
+}
+
 # Import common functions.
 . ./common/filter
 . ./common/dmlogwrites
diff --git a/tests/btrfs/206 b/tests/btrfs/206
index f6571649076f..6ac3d27bbde3 100755
--- a/tests/btrfs/206
+++ b/tests/btrfs/206
@@ -14,6 +14,13 @@
 . ./common/preamble
 _begin_fstest auto quick log replay recoveryloop punch prealloc
 
+_cleanup()
+{
+	cd /
+	_log_writes_cleanup &> /dev/null
+	rm -f $tmp.*
+}
+
 # Import common functions.
 . ./common/filter
 . ./common/dmlogwrites
-- 
2.44.0

