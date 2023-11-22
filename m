Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="HrDD4uJg"
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BFA11F
	for <fstests@vger.kernel.org>; Wed, 22 Nov 2023 09:16:04 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-db406b5ceddso22513276.0
        for <fstests@vger.kernel.org>; Wed, 22 Nov 2023 09:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1700673363; x=1701278163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lw7gP53YK9FpL5jKVynCaq+VNbFKDbPRWOvIWdMw/Nw=;
        b=HrDD4uJgLOr0+tzfqJIB8SbRmESbNQbx6pNuK97dXHLlZPyovhSruEJDctIJj2kPCY
         4rl9bdnpZkuGgleucqjjHMbFWIAx3QrG6a5jZ1AEK4x9rAG/yR634Uv7jJ1enfqOWSzL
         W9Dx2JP6X1mCKajfWdPQo0RT6K4Rqav0wqv6cs7BkLA44vHeIef351O5XPehieNvYuD8
         kT3MLYZGPBe3g2QnsdjGKoJo7YjDMycpdenPaNIoOU9On63pF91oOR5EBAXlooKx5Jld
         PPX79ZYAjav4ZKnXS7GrSZs83GFVBI93B+NZ1rR6vt+d1LSKqTfQWfuKzxvTwGcLf1YT
         SQFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700673363; x=1701278163;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lw7gP53YK9FpL5jKVynCaq+VNbFKDbPRWOvIWdMw/Nw=;
        b=NHV+Nh3ZTUuJ9O5/jC32aXDekJ+u+w3OBaiffHB/lBXF7ex70r/YQb85+xj03eV17g
         a5BYvqKtju2NzHCGYUgLqEk19oESruU35eKtninm5I/f7sprfv8etEaJY73KEp9r20d6
         c3dc48gwB98xHqOK/8SqZMlkpUbSRS6DxcHp7GIHpukf8YLUHvFFc+YHHAExWxk5Pj0x
         Cosb65Z7u7bcl7wAd31dgdVkXj9ajPEJyf79vjL1MOK0Ba+cZd6J1asBlD/uKnoBqXi7
         5enmWEiBtmXvByaayS7WoneCzHyz9I2k7Hg1xk3DeQ2cYAG3elrzi2Fq06RNHTMo4JOB
         0S4w==
X-Gm-Message-State: AOJu0YyGJQqhAmmjtPms6vdbZRlMRk6MRTLWyV68WHGQoJxcuWp0lFgg
	41tQlK8sPR6xUYp2YSR6/c6gW+7PjX60lVMNrpseq/nH
X-Google-Smtp-Source: AGHT+IGpFHTSAvjdtWKH7zJNkAbmTTemfNjjfpYwXSt74edbunWcpoyzkL1fLQdqBj2fNgZg/vLdYw==
X-Received: by 2002:a25:5f01:0:b0:da0:38c8:2e66 with SMTP id t1-20020a255f01000000b00da038c82e66mr2362781ybb.3.1700673363021;
        Wed, 22 Nov 2023 09:16:03 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id h11-20020a056902008b00b00d8679407796sm1440222ybs.48.2023.11.22.09.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 09:16:02 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	fstests@vger.kernel.org
Subject: [PATCH] fstests: don't test -o norecovery in btrfs/220
Date: Wed, 22 Nov 2023 12:15:58 -0500
Message-ID: <9cfb7fb05fb474cf5c39ff71340db9c1f6a652aa.1700673354.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a deprecated option and it's going away with the new mount api
patches, so remove this from the test.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/btrfs/220 | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tests/btrfs/220 b/tests/btrfs/220
index b092f40b..60b42b6a 100755
--- a/tests/btrfs/220
+++ b/tests/btrfs/220
@@ -212,20 +212,14 @@ test_non_revertible_options()
 	# nologreplay should be used only with readonly
 	test_should_fail "nologreplay"
 
-	# norecovery should be used only with readonly.
-	# This options is an alias to nologreplay
-	test_should_fail "norecovery"
-
 	if [ "$enable_rescue_nologreplay" = true ]; then
 		#rescue=nologreplay should be used only with readonly
 		test_should_fail "rescue=nologreplay"
 
 		test_mount_opt "nologreplay,ro" "ro,rescue=nologreplay"
-		test_mount_opt "norecovery,ro" "ro,rescue=nologreplay"
 		test_mount_opt "rescue=nologreplay,ro" "ro,rescue=nologreplay"
 	else
 		test_mount_opt "nologreplay,ro" "ro,nologreplay"
-		test_mount_opt "norecovery,ro" "ro,nologreplay"
 	fi
 
 	test_mount_opt "rescan_uuid_tree" "rescan_uuid_tree"
-- 
2.41.0

