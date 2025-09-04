Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99AA2264B1
	for <fstests@vger.kernel.org>; Thu,  4 Sep 2025 08:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756976124; cv=none; b=S44bXIZsbP1VdALrTl5CUEnOmFCjKeJxsGp4C4cH1OTK/9wdtYPsVlHUmpROf6FbXzI7+L4ogmQRGfYjuK+Us1oI0HKgL2In+TUwLHhA6SeGPv/tay43p1+bJj3iWI+rd7ui23DJwixz3D2SFQ00h9Q15Y6RwELPFTQYvcRNmcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756976124; c=relaxed/simple;
	bh=rwv5eWJEm8xfR65ko0SOTjAcGyVWtthPMFcvWhfnlkg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SJ3xx18LAR/RkPyGmfqxBxI+qBVdW99HRqN68u8oQO1JBW1sLLuvU1Y5UOom13OZTGyL4DNF3MKXcFuSDjvx06IwqYScbrAGMHRF69c1QQFbfDmVE6BsTO29PZdntF96596XXkbbOSOmLOFwgUodyYKz+hSqHUmsbX+9HrzgGOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jprusakowski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0+WCxVeM; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jprusakowski.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0+WCxVeM"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-61cbc94f5b6so1018738a12.0
        for <fstests@vger.kernel.org>; Thu, 04 Sep 2025 01:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756976121; x=1757580921; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EqK/tWKIg00wKoXSmamrcavWYc1ptK+oT8MqdmYppT4=;
        b=0+WCxVeMwOJhhjD/Ag9Vc8BmcCFhvuvy09hhuStCnoiWQV/Yo0cBtHdzEahGwE5REd
         BHv+9tOqtKkiT9H3t+RYk4p295lXVVAchGQzQnWrCeehAvtTEJ9LL1/o1k/AEoZYHX0S
         rifZMQaJFn+SANbVzBLjm3NhP9crkCPjZgKEZi696VvD6GQ5iUTmRnY7N4HmOOUt8jyL
         ks6WNzxMe886V2eQebKHigBtU+EaG8aDqd1hUr2RlvA41Oi8EuSaiz9o2j888gZL4Tev
         WYggirQgtc0GFJYmmYLpuh7X9irQ2jlOaWhcY/Y+Lu/YioqWBIAWST+X5YF8SWKCEaj9
         Mp4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756976121; x=1757580921;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EqK/tWKIg00wKoXSmamrcavWYc1ptK+oT8MqdmYppT4=;
        b=QcB4KSEXXxsVJfB9NEXoVsFqm299GRFWX0+bRCyJr9zH2qLudGPr6gM3z61B488wNt
         E+oEfYWROIwK819E6Ru2dvslYgK+f2ODPJOMLMTvI+KZsRJcFnx3Lq3u6LlPMqu3FFRT
         LWisve6db35miI7JeGTlxOtncyPZpAkQ0esqvC2mcVF/4xou6YGMbIn03VVwqnNNzNOJ
         A7f8E3LbgzU4htKT8RGDB957CqISrwuV51FcQxzrPizEe2Pnih90aOzRy4urDueEUWJR
         cDfsAdPQYF3xM0VaPWh2ohx85spO59HTxv22/PxHMR6F1V8IqUW5lJEBTFT6CBMu/Hm/
         HZow==
X-Forwarded-Encrypted: i=1; AJvYcCW5Ahu9bvYbqc2EvLYwKdDzOVo90V9PykLD+UZ09shdgVk9PKAAw3+OthaGoBUYepPX0xfH5xDZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwM3AYjYjy+O4JuyQSbDlt88MQTr0aUiE0xst7L2t2txwBXMbZL
	RVt7QWNzXSTzjqF8tQ7nDZ1tidtgsZaehEUAL7ooKDrSiksp0q0uAB4xU/sge/S6rV9u4ifzx9e
	eQcRdw4dsRgrj2ffVHWSZCcO/JH6g8A==
X-Google-Smtp-Source: AGHT+IE60EE9lJeTaBTVJKZmUHCQgwymZdNMgHzePlfSDAH4ZihwXcAKTO5Du6kLMx41CtNfcr8n2wobhtZcP94KI4k=
X-Received: from edc24.prod.google.com ([2002:a05:6402:4618:b0:61e:da91:9881])
 (user=jprusakowski job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:510d:b0:618:1d7d:b967 with SMTP id 4fb4d7f45d1cf-61d269a7f11mr16318549a12.12.1756976121207;
 Thu, 04 Sep 2025 01:55:21 -0700 (PDT)
Date: Thu,  4 Sep 2025 10:54:49 +0200
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.355.g5224444f11-goog
Message-ID: <20250904085449.290354-1-jprusakowski@google.com>
Subject: [PATCH v1] common/encrypt: Do not run _verify_ciphertext_for_encryption_policy
 on compressed FS
From: Jan Prusakowski <jprusakowski@google.com>
To: Zorro Lang <zlang@kernel.org>, Chao Yu <chao@kernel.org>, fstests@vger.kernel.org
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	Eric Biggers <ebiggers@google.com>, Jan Prusakowski <jprusakowski@google.com>
Content-Type: text/plain; charset="UTF-8"

_verify_ciphertext_for_encryption_policy() checks if encryption works
correctly by reading encrypted file's contents directly from a block device and
comparing it to a known good ciphertext.

This, however, won't work if the file systems is also compressed. So this patch
disables tests using this function when a compressed FS is used.

Signed-off-by: Jan Prusakowski <jprusakowski@google.com>
---
 common/config  | 1 +
 common/encrypt | 4 ++++
 common/f2fs    | 7 +++++++
 common/rc      | 3 +++
 4 files changed, 15 insertions(+)

diff --git a/common/config b/common/config
index 22b52432..1420e35d 100644
--- a/common/config
+++ b/common/config
@@ -509,6 +509,7 @@ _source_specific_fs()
 		;;
 	f2fs)
 		[ "$MKFS_F2FS_PROG" = "" ] && _fatal "mkfs.f2fs not found"
+		. ./common/f2fs
 		;;
 	nfs)
 		. ./common/nfs
diff --git a/common/encrypt b/common/encrypt
index d4f6e3dc..43ec349b 100644
--- a/common/encrypt
+++ b/common/encrypt
@@ -989,6 +989,10 @@ _verify_ciphertext_for_encryption_policy()
 	fi
 	set_encpolicy_args=${set_encpolicy_args# }
 
+
+	# _verify_ciphertext_for_encryption_policy will fail if the FS is compressed.
+	_require_no_compress
+
 	_require_scratch_encryption $set_encpolicy_args -f $policy_flags
 	if $hw_wrapped_key; then
 		_require_hw_wrapped_key_support $SCRATCH_DEV
diff --git a/common/f2fs b/common/f2fs
index 1b39d8ce..c46e2aa2 100644
--- a/common/f2fs
+++ b/common/f2fs
@@ -25,3 +25,10 @@ _require_scratch_f2fs_compression()
 		_scratch_unmount
 	fi
 }
+
+_require_f2fs_no_compress()
+{
+	if _normalize_mount_options "$MOUNT_OPTIONS" | grep -q "compress"; then
+		_notrun "This test requires no compression enabled"
+	fi
+}
\ No newline at end of file
diff --git a/common/rc b/common/rc
index 81587dad..882e0588 100644
--- a/common/rc
+++ b/common/rc
@@ -2112,6 +2112,9 @@ _require_no_compress()
 	btrfs)
 		_require_btrfs_no_compress
 		;;
+	f2fs)
+		_require_f2fs_no_compress
+		;;
 	*)
 		;;
 	esac
-- 
2.51.0.355.g5224444f11-goog

