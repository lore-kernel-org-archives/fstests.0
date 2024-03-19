Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D09710A1C
	for <fstests@vger.kernel.org>; Tue, 19 Mar 2024 16:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710867370; cv=none; b=VbrhIBxht+s41Ba8eUfwrhZAFzviwTExZcNhOwRIluW/u3fgSUa5Jdrzc+EWd/1UR7FCnrbmegiCX3mTq9/hgb5sSr0TsNrMDY33o2IqLcyrm687o8rZ7Z44vDn7YXswP1XZ+pf8efPXR4BScC6FfHW/b0VkeqvBpe3VSwYMlBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710867370; c=relaxed/simple;
	bh=28rqPOzqrzU2xeKeaX/cB7xe1OCGgfzJP9tXmwdNDho=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XvqyR9ZZdHF6VxpPPkWWGsjL74XasvJoGa8fXwNhjIH7EJnjSapPAgOzOJalrSHlYBudZnfAMusphfXKv2n2vMGHh9KAbM5TZfz51Hebeyuhdl9YdABiIgp+qUtLz2ianUk0z8nltDwPsAR1KFTl8gwl0ckdnxg7ou1ts+tFa/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=JRIu7jeD; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="JRIu7jeD"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-69629b4ae2bso11548326d6.3
        for <fstests@vger.kernel.org>; Tue, 19 Mar 2024 09:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1710867367; x=1711472167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nrknpnmmhSsDGdPuq/gQ6JDl7KQ3ZMmkGR/31N88j1s=;
        b=JRIu7jeDlPDSX+a8JeyjgGEO1t6Xo1tr6me6qswNClQ1yVYjVRGy6xAOu4fjDwthq/
         0Q60oK55Ok31DTXQhP6PYrl4l0JiAOUbbxdgEKNQKuE/Sd20t8s2Z4vuV9DfXGUcko2x
         d+Sl1QPyCpO8v0xEZqXB6VlHEm+MvdKANokn0W8z8eZY2UPhRy9gziX8qjDk9IhJAoKB
         +eCnkoXLfDd9BkuuZzAX977tCm7HTOl1enOC+cyCbZZVs1Fca6lwTVmhx3y156L/ryKn
         gzp2AqLfdzCBHXSbyRY9PvSIZyEuuurG/hxNTSvL7i15WEEyLYbayv99Wt0oFWcoJU/G
         Fhzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710867367; x=1711472167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nrknpnmmhSsDGdPuq/gQ6JDl7KQ3ZMmkGR/31N88j1s=;
        b=RUSIlEMHG9c3gxYZiOZvVduoFrRb4Q1EmUpLMm6ikiPLq8CMjJggss/IdcGVxAW7At
         RndG87xmCAJ1r5zLQQdODiTeu+NTr4uIMokChXrkZQcUtXA4vD8MCDVMTcKRraGzyft5
         TwFNNWiP6XPRFqWcq9fIToLoxlqUuQYe5LvS5VyOoUTnopEGRIyI+gAbF9zcBKY0D/lC
         /uOWRzWxux4wA5RGU1k89Yg+/DNw9jLTFYg4tGNrzwm2lZAz+ILnMThrTBXfGuPd+U4G
         9Vj8nAsiT48oE+hSO8R+6iOcfJUUtf8qJrzSvDi9DrKXBK1t4yVxfd/anwOxq0sSDIrj
         rwSA==
X-Gm-Message-State: AOJu0Yy/ST67aGkSTIA8L8UrOujJMB/n+e1M2KG9XdeNhUngfpDgg/Qy
	UEppM6oUrETi9v9wFcQE73oM/NYXCvNxbwFTYekyAXBI7Yz1EW0Afg8iLauktCgrcVPu+WTIJIF
	n
X-Google-Smtp-Source: AGHT+IFwH3KOQnVS99ANDSdHHQg7PS9aFQr53dY6vRcG7MYR/xNMzijOJJiHH6OsEwa9qfkSN7N01w==
X-Received: by 2002:ad4:44b2:0:b0:690:4942:dd89 with SMTP id n18-20020ad444b2000000b006904942dd89mr3238946qvt.28.1710867367281;
        Tue, 19 Mar 2024 09:56:07 -0700 (PDT)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 1-20020a05621420a100b006961c9a2ed8sm2552906qvd.47.2024.03.19.09.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 09:56:06 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 2/3] fstests: btrfs/195: skip raid setups not in the profile configs
Date: Tue, 19 Mar 2024 12:55:57 -0400
Message-ID: <c19995ea42066da0eae381b499475c81679c8f0e.1710867187.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1710867187.git.josef@toxicpanda.com>
References: <cover.1710867187.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

You can specify a custom BTRFS_PROFILE_CONFIGS to skip certain raid
configurations in the tests, however btrfs/195 doesn't honor this
currently.  Fix this up by getting the profile configs and skipping any
configurations that are not listed in BTRFS_PROFILE_CONFIGS.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/btrfs/195 | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tests/btrfs/195 b/tests/btrfs/195
index 96cc4134..df8f5ed6 100755
--- a/tests/btrfs/195
+++ b/tests/btrfs/195
@@ -21,6 +21,9 @@ _require_scratch_dev_pool 4
 # Zoned btrfs only supports SINGLE profile
 _require_non_zoned_device "${SCRATCH_DEV}"
 
+# Load up the available configs
+_btrfs_get_profile_configs
+
 declare -a TEST_VECTORS=(
 # $nr_dev_min:$data:$metadata:$data_convert:$metadata_convert
 "4:single:raid1"
@@ -38,6 +41,11 @@ run_testcase() {
 	src_type=${args[1]}
 	dst_type=${args[2]}
 
+	if [[ ! "${_btrfs_profile_configs[@]}" =~ "$dst_type" ]]; then
+		echo "=== Skipping test: $1 ===" >> $seqres.full
+		return
+	fi
+
 	_scratch_dev_pool_get $num_disks
 
 	echo "=== Running test: $1 ===" >> $seqres.full
-- 
2.43.0

