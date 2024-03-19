Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466A01097B
	for <fstests@vger.kernel.org>; Tue, 19 Mar 2024 16:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710867369; cv=none; b=E3q3Ae7xBwJGDYpDNhfT9laFZoGTRnEhbypR6JxfFYYVp4hAQmV86zwZN09g+uPWsr2WzyeJV0/G3ktywIcgWmCLGaX/vsA/NtjmX7bgHA5pYGiobfLYv5mVtnGAVP0q9UaiPFdItgR77D4ztu+E32N1YMLVGaFHBr6mtrR+Lxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710867369; c=relaxed/simple;
	bh=qA72Tz+8tuNZU/4QviNvrzVvbKhLu3y78NAdl4BMYFs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M8S9myAp54DoTwzCLm52xrJVrAG+W4WUuG32D5ZuM5RQbuP8fOzl+Z5Weag6ZNjT79cnVT/YElayGe7JRaw4vgBuFyjtx+UMh/T14FUBpCaFiE4JDwQzTYuhyDAQafsArf6bcWqbS1g2Cxb0zKwe2Px4KSzhSvBemCjTk5LUttw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=ylrLZbO1; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="ylrLZbO1"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-429de32dad9so36018101cf.2
        for <fstests@vger.kernel.org>; Tue, 19 Mar 2024 09:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1710867366; x=1711472166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cBbs+iA1l2yOBOmVBbjTGQGF+IQD6umOZ/ZP4nOCnC0=;
        b=ylrLZbO1RZn1P9HsswUoMKa55AXU8IVZgQp+63KB3YP2l8AxYz92P7fR9ElMjGJMxS
         +t+MJFE0Y+sg8cHlKHIS2QwBvjFEAkRd6siQdcfAE+OfkNcXJZPDh/m9DkY+4Tgply53
         TZVPGDmv+XqTIiX1D9HK4gE7fEHT5WyOaT4Pf4cWfT27GhjHn8u9DzT/jGolMeMqbFNg
         yV7lfOFsI5aCk7NRrilz9sOpuy4DpY87ohv019+VAQd32taUEqdr7egp8ba0MslcY6oK
         kw+Ur/O7OsBOlOCOG39LbAhzahRlOpTkjHcr1pmUEzgY47BTtiUB0LaOO4xc7AJMuGRB
         X0MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710867366; x=1711472166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cBbs+iA1l2yOBOmVBbjTGQGF+IQD6umOZ/ZP4nOCnC0=;
        b=qwUzIKL+hrC/YzJ1DtQOhVlrsRN+wQ7+9WqZk1qRmAxbol305mq49d/EiRXaiaEMQ1
         XCEJQPdLw8VS9qdsYxPXXH3+ur6Irio4ro12RtkjlcxS7I6N3jRzfpDJHr60pSPOgmef
         NmMXnzJ0kHRCc9trFlab0UKPBhAlLLsm5go96y/lhJ77XH7RMuFioQ/HkSMep7zddbBq
         Zhi4FgtQJ1e9nXt5/5TVpYkBBsjprIhi5nxlhYtNvpOJJ7FmhQY5YJJfp4SeLK/XNoLa
         EFOLL0GtaOa6CUhQmgRmLX9jtstOdMmdqp/NZIJMbe80rLbg3Rtxe1/CGZZhZtHDJF3D
         GDoQ==
X-Gm-Message-State: AOJu0YxVZ2Qggp9dZXAS+XcRyMkxkqZIpmXh5e0wS3Mq1ugyS+C8Ab2K
	4z9tJBmiJawH/ee3vExXooe3oGYcTidwXe3aMJfORV4RkkJ8CDtQoRl2nYAT24qVEgZywBodE7N
	y
X-Google-Smtp-Source: AGHT+IHLbkAjOlEgHCvWBkN/yrjOXV5/P5CAREiswnR3MUxogQRQ6+dQkFpm/qDqUfx8MPm4hiI55Q==
X-Received: by 2002:a05:622a:14cc:b0:430:a7c3:be9d with SMTP id u12-20020a05622a14cc00b00430a7c3be9dmr3190521qtx.3.1710867366063;
        Tue, 19 Mar 2024 09:56:06 -0700 (PDT)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id fj5-20020a05622a550500b00430b423f06csm4837298qtb.86.2024.03.19.09.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 09:56:05 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 1/3] fstests: check btrfs profile configs before allowing raid56
Date: Tue, 19 Mar 2024 12:55:56 -0400
Message-ID: <65177ca9d943c043f88d8ea034d1e625af3d0e58.1710867187.git.josef@toxicpanda.com>
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

For some of our tests we have

_require_btrfs_fs_feature raid56

to make sure the raid56 support is loaded in the kernel.  However this
isn't the only limiting factor, we can have only zoned devices which we
already check for, but we could also have BTRFS_PROFILE_CONFIGS set
without raid5 or raid6 as an option.  Fix this by simply checking the
profile as appropriate and skip running the test if we're missing raid5
or raid6 in our profile settings.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 common/btrfs | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/common/btrfs b/common/btrfs
index b0f7f095..d9b01a48 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -111,8 +111,12 @@ _require_btrfs_fs_feature()
 		_notrun "Feature $feat not supported by the available btrfs version"
 
 	if [ $feat = "raid56" ]; then
-		# Zoned btrfs only supports SINGLE profile
-		_require_non_zoned_device "${SCRATCH_DEV}"
+		# Make sure it's in our supported configs as well
+		_btrfs_get_profile_configs
+		if [[ ! "${_btrfs_profile_configs[@]}" =~ "raid5" ]] ||
+		   [[ ! "${_btrfs_profile_configs[@]}" =~ "raid6" ]]; then
+			_notrun "raid56 excluded from profile configs"
+		fi
 	fi
 }
 
-- 
2.43.0

