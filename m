Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794410427;
	b=fK1S9S7dY46gw4NoTGLCTgj5XPYfCRRujPbtn+BOBRFatPD0HA6BQ7NDQ3FUedUh8Bs3
	 fQKb7A5jJeFOLnLMOnS3+Ia9+jng+iB2caMFbXJ6zYJWegOYkqa68fASET5rTqM7bgIcJ
	 rYHKJ+i4rF/xRiSRhkvgjoykOymWgas/RBpJlr9JPDdBUwoHEJJnhkTQrMiorwh3kP36n
	 zwuhBbSiWqgzPrB+iqJbkqrPFhTMVUvBcbtq9uR7cqkecEnwDOnWzZv0oypFqrjRg8Gym
	 DrNWJPdRNuCt73Gz8mVEhHuJ59R2PEgkj7NQGq9t+9x2R7bx8RCRWRqTm7cr1CbkJaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794410427;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=x9B+elWlManW5RGxLQhyuSzNJDOz9MtxGMXilsfs/98=;
	b=N2WVQ8anB3XpfiuXXtRa0Xc06fx9EWKI32yuRUWVtzLmCTDUYDhZ3Lk6eTHJHYI+eu8u
	 Pkgnmmge1Miy5SAoqPqlZIyWrD7kzwhQXWfZfYl1wCQ0w48nDejjKvdnnrO7OkJHhYBM5
	 n/5QiiUgBwf4Uh3g6/rgh5FXkTHWaEXxoNpgvhMO5zrStZOKXh7zKlaWbi3NYSAkTi3T+
	 +JNQ/nQ7/YKuAGzJ2ebyS5HHuuDAdq2oeZf7abmg8/moELBqBA8Ywag11o0XEp8QHwWgC
	 XptqZXDfY+PusnCGsSbC8vxQFvjeb6k6L6/eSTgx9Y6cxDDIDa4SLuhi+qrhrt1uJOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b="WoN/oSy8";
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C319606A324
	for <fstests@vger.kernel.org>; Wed, 11 Nov 2026 15:20:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C319606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=WoN/oSy8
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a210470b49so27259945e9.2
        for <fstests@vger.kernel.org>; Wed, 11 Nov 2026 07:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1794410426; x=1795015226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=x9B+elWlManW5RGxLQhyuSzNJDOz9MtxGMXilsfs/98=;
        b=WoN/oSy8mxOmHFh2pMk2OxyKVRLTp6nOQUB5CT8J35CZFncIhkaM3qd6g6s/un8+ge
         Y2PMwPgGf6Sg3L/a0I+USLn+HdVujFCw6cfHBREQTHeiLgzDpD0+r+FKMLgBR1N8KTut
         UYgA1NuQmNDcbmwT1/3czUVFDcWJfP0kRiDY4fxioewoomxgs2QVYWepu/11hE0jKpEo
         SYfsKCMdLnzwaBO8Jfv1ybUPOZBeZK2s6OyC1nDZrve7W3xkGri6S17k6A674gUGqTXV
         05GLwb5OlElvTPylXFD5Z43FQeYortcbanZBVFbhaUML54IjkfyIIdWX4qeLetNURZlx
         ArIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794410426; x=1795015226;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x9B+elWlManW5RGxLQhyuSzNJDOz9MtxGMXilsfs/98=;
        b=sUeDZVHhN9BFfFnQpy4aIKbyB2NSTQt6gKUuRywD5abBDR0jtYX7lS4aXgAYjD9h24
         HUs2AMtk4cmxOo082Z3PFfDJkSK8RTGP1BZLapGVzcOKY0y+B3LY8gs2aIu9llR9r1Mo
         xKzlce2k6iB6P9y/JnHcZmkcdf3mNZjxkum0Kbg1SKHezJ7dV98fcCDkXVkR32wpJqh4
         pijjNeiKBAhVM/QzdtPyAIdJ/ekguNwbPrMQ0HxJGujLP/GfrhvN4w68h3RwyP81WoIC
         Jo0HMvFEvqcN3flCPTDZoB5GjJPU1MZOzNnlwkhD6eEGwfG25zfIFKtbdsUdXAfvePlw
         DoSg==
X-Gm-Message-State: APuU4Z/ZO9tlIiHL2fjDtOZaF71kGzCywGr8j1U26cxdFpkn9dIZeRkX
	o18S9pRIfK+y5QCgABwhvyEArNtF0fFVHyp0Os8Kd2Wq54U/cnvi/Bm6QE7MJEdJLF9/zLYau9D
	aBP36OA1eDA==
X-Gm-Gg: AYBFou3glP9smm6l93ZVGOkNJGFl/uLMcbvKhPnpdoXWq/XscfkUM4CDlgC2B5GM1rP
	cmjNCu4IBBRTFSvl9zM3BEp+YFxgfS51C9kUvovedEW8bxUfxrxAfv/ZGraWNIKtVHzhdEoBabI
	kRRSWvWyyHTgeg1xVZSCBJc/lomAFinzD9WJH3Y0ykZP8igWBd4QOXmua+e9A/PShWWUJvDQPaX
	zNsRQaHcFSagctVCiBlUM0npOTf1LKaw1gKfZduchYIze6Af5my7BtmeLDut26pocWGi2hkmAQ9
	/kS6CXhzLKUbNeJSzhuHortrMeqjxlck7uVzM6KHQ37Bo3bsp2EhNnVRYgfPJKAA43BfSyMR2Mc
	r3e61lg97bI5gtIbXZQVuLStMj/gwT383iTS5C9pxkcY1nUTeUs7o2pfC/dEleNaCkjPV6rDw29
	Q4aZZDUs+ob1vT+bEMWo8AmDs2I30l9n3/gnr2hXx/xDz1iPF4wOIvoDoy3UguETNmq0EHMpEBs
	SlzmydgCxvSk4TWuIMKWKqPde0BiPG6fbkE441AeuNLrJKEDyUOEF7xMOhi3na2qxTE/Kqhm349
	yo97+NC2nry91mcWCjp69uveV1qL+D7GcX99+mVv2ewQd9dEkg==
X-Received: by 2002:a05:600c:3f18:b0:4a0:1c0e:b057 with SMTP id 5b1f17b1804b1-4ba0931d91dmr49308585e9.4.1794410425682;
        Wed, 11 Nov 2026 07:20:25 -0800 (PST)
Received: from localhost ([176.114.240.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4c5e2fd6sm1641195e9.10.2026.11.11.07.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 07:20:25 -0800 (PST)
From: Avinesh Kumar <avinesh.kumar@suse.com>
To: fstests@vger.kernel.org,
	zlang@redhat.com
Cc: djwong@kernel.org
Subject: [PATCH] xfs/654: don't complain if the healthmon xfs_io already exited
Date: Wed, 11 Nov 2026 16:20:19 +0100
Message-ID: <20261111152024.163855-1-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.56.0
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

From: Avinesh Kumar <avinesh.kumar@suse.com>

After the unmount, the test resumes the stopped xfs_io healthmon
process, which reads the "filesystem unmounted" event, sees EOF, and
exits on its own.  The test then sends it a SIGTERM anyway in case it
did not exit.  If xfs_io has already exited and been reaped by the
shell, kill prints "kill: (PID) - No such process" to stderr, which
doesn't match the golden output:

    +/opt/xfstests/tests/xfs/654: line 50: kill: (170710) - No such process
     mount refcount is in range
     mount + healthmon refcount is in range

Redirect kill's output to $seqres.full, as _kill_xfs_healer does.

Fixes: 79f6b1c3 ("xfs: test health monitoring code")
Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
---
 tests/xfs/654 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/xfs/654 b/tests/xfs/654
index 012f31a8..e8d815ae 100755
--- a/tests/xfs/654
+++ b/tests/xfs/654
@@ -47,7 +47,7 @@ mon_nomount_refcount="$(_module_refcount xfs)"
 # Capture mod refcount after continuing healthmon (which should exit due to the
 # unmount) and killing it.
 kill -CONT $healer_pid
-kill $healer_pid
+kill $healer_pid &>> $seqres.full
 wait
 unset healer_pid
 nomon_nomount_refcount="$(_module_refcount xfs)"
-- 
2.56.0

