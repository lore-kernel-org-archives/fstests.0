Received: from mail-yx1-f67.google.com (mail-yx1-f67.google.com [74.125.224.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBB730C62C
	for <fstests@vger.kernel.org>; Wed, 24 Dec 2025 00:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766536212; cv=none; b=QJA6GOwaRykJ+zqLVspk6lcsh5N1RlNBYtoToJAb4N2jGKw0vAUTN+2/Kegxm4aHTbQQEVyFUDqQ7V1excvBHGTDogYtIeqQ6/qtXgIRcVSSPGSJiln7tVOOt05eEYQbKTPbVZIqHIhFgvX6z6FN/053smeBFpDyBTr+9a8kVUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766536212; c=relaxed/simple;
	bh=8Q4eclvqxnpfZCIz34VHWYhQ/Qm7L6sIbQyGw6++cdY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QmG5XS+V246pSjLpz5g55av7L8/X/UiAWQBm7mea7sM9lC4CqKknveHCxgxTX7WTXNWOkV+x7NUeU3vD78CwUQ+wwCiHzVwd/t5fKRhR/I9OSPE2etw3SJM6xIoqBVrMINz1PCqLNYTGTk0pEpEojzuAhvYGDrhkvqOt9N7J418=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=dtOmROgR; arc=none smtp.client-ip=74.125.224.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="dtOmROgR"
Received: by mail-yx1-f67.google.com with SMTP id 956f58d0204a3-644795bf5feso5046776d50.2
        for <fstests@vger.kernel.org>; Tue, 23 Dec 2025 16:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1766536209; x=1767141009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tvt7lImfx971sc5dBIyMWPCFjdNg/4vR3ol8PKv5vxI=;
        b=dtOmROgRE2/92lGKRomB0hcc7O7TTAKa3cdR2iExOLB1amFOHTk0ClLmXm6kNAshhC
         4RV9+PskaL5T2VIfN9LK/HaVcniDPSDs0ovPR0YzfhEWPbZjrIZbzUdf/GA3IVqmISpR
         1amArOoDevwuzu3c7pszUjnjMuF8NAtNz15UwvKt+jdvKIplq2uMezbqnbt534wd48Cn
         eFBX4eYc9zOdDrWETHM0e7POR1FXeWnogXoBZaufUmtZ1VYjwFXe60KomLO3qMVTQEll
         IJnQA+rjQjKOO/n+pT+ZAn3PZpPLnH7ljFVHkw0qtW61Etza6KDz76TvZXnM6dpE8VEC
         iFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766536209; x=1767141009;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tvt7lImfx971sc5dBIyMWPCFjdNg/4vR3ol8PKv5vxI=;
        b=gbZ+ROu+l1Lq2MKuLj2ffxGtd7CPBGWT/el1dpvNFwTS2rfKJcgDv8ltSntqsM4aFE
         m5GuI/dbp5KQ4gl/BVk/gHMo6KopzaHQ9cUjBjB5Ca2UXIHEAi83FmhyzpMgjbFqVDnL
         gYV08x3uCP2obT6qpLRIl8aCXCQwwY8FTEckBqdwhozKyl5Ef9VlqEsnsK06spNOm42s
         G5C7VLbDC2s5Y8SuGYr9aLOok4EeQaBHpihvDQjtcI53k0kZUY9RDLMf5xgkfuJwjarr
         8OysrRRG492XXuo1qywOnfJ83zNp9DSyJVtnXWEu0Tg6Fxs2IRrW4GHU3Z2Yib/sDSR/
         B+Zg==
X-Forwarded-Encrypted: i=1; AJvYcCWV0un8nrGTC9iNUH4OsP2UY/1iVuEbMSfNk5GMubnF1f9Khaah2HAnQ65I8P/xkZAAFZM0kZ2X@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6EzHXWerPZJvgMYaaWZZXBGQDLv85s0Es1VTU54fvSMk6iKMk
	ZvLhuciKxB1mEp+FmzVzoyb1wHdUZf5hr7swphZRQM2fqMzZWV5omfdmX2wAoe8jjs4=
X-Gm-Gg: AY/fxX4KQQO3Rn84TNdUeK2Rrr6XzAcoQlauEhSu2kGGPuGlV68U6c7sDfp3McIMSA1
	My2cjqmWLMOcFojSJqCEC0z0DHB+aGBR/MGTlp347JV4VjxWHLbabAHu6lFHRaAEq1qJAnC+NNX
	aQ6CqJvLK7kH60cwpVJN22grtr61td1vH1XtlhQotW1q/suviNYoeO9R+hTyOgaTjgS0EWqZoSo
	ACTpp1ZiMv55x968yrs7dzib5/uTKmhJNLi6e+FFHQt3z+qo4picUlJ9XTVWcFYgu2ijC28YwNr
	4yiLiUtS+YFS0HuNVgKADy7AyFZSSC1H+hf0FdvbVQT3MpPyv82xCFqu27HHQJYo9UlbDKmnn72
	TjbhJ7lThXs+nqDPIyApUQ7uqrXCvzNZiwI8g5kLvPycIbECfi8XBvB8iPB8HI8JXtH2sJJF9zf
	Vdmt0X1PLHy759S12T9fQlveeGM2Ef7McgOHWEosvUlZODo6DNJI4u8wofJRYOH8CJQQVkCBD5X
	RDZutD8j64c
X-Google-Smtp-Source: AGHT+IHPNy0iURraOxC/YoxtpDgPNyQYFKR90KMfdDD+MzTFMNEn+3A7uMfxyokd8BcjsoJ9vk42hw==
X-Received: by 2002:a05:690e:144e:b0:640:d009:e998 with SMTP id 956f58d0204a3-6466a8a4d83mr14013621d50.12.1766536208917;
        Tue, 23 Dec 2025 16:30:08 -0800 (PST)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:d3b4:b334:ddb5:458e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb43c71b6sm59698197b3.22.2025.12.23.16.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 16:30:08 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com,
	fstests@vger.kernel.org,
	zlang@kernel.org
Cc: Slava.Dubeyko@ibm.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH] generic/020: limit xattr value by 3802 bytes
Date: Tue, 23 Dec 2025 16:29:58 -0800
Message-Id: <20251224002957.1137211-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

HFS+ implementation supports only inline extended attributes.
The size of value for inline xattr is limited by 3802 bytes [1].

[1] https://elixir.bootlin.com/linux/v6.19-rc2/source/include/linux/hfs_common.h#L626

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
---
 tests/generic/020 | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/generic/020 b/tests/generic/020
index 8b77d5ca..540f539b 100755
--- a/tests/generic/020
+++ b/tests/generic/020
@@ -168,6 +168,11 @@ _attr_get_maxval_size()
 		fi
 		max_attrval_size=$((65536 - $size - $selinux_size - $max_attrval_namelen))
 		;;
+	hfsplus)
+		# HFS+ implementation supports only inline extended attributes.
+		# The size of value for inline xattr is limited by 3802 bytes.
+		max_attrval_size=3802
+		;;
 	*)
 		# Assume max ~1 block of attrs
 		BLOCK_SIZE=`_get_block_size $TEST_DIR`
-- 
2.43.0

