Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F07F2376F7
	for <fstests@vger.kernel.org>; Fri, 20 Jun 2025 08:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750408163; cv=none; b=eVASwaJv5VVU/ZhB7WnzUKsspatXfw1JvU++OPXt/+QrY8uRif6GYOwiBIJfCy19/99vylW/ayiv9K1UMCnHYTlwazFfqz8SM4i8YVEgCZKWfwg/eHkpNux8pFhtJ/10fwG0943k5ZqYgzMQUtHFMgj6dN3C3wUJyGwBE6A5xPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750408163; c=relaxed/simple;
	bh=dBHZHKZDMlSACPQlcHnbVPp8QNE+P079+gtjCgDg2hQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bY/2iKyw26Vj/o9RNqheLBAXk6zQMiFgpCBQ+w7eldsr1ZXzRPeysnjmz8mHa4ohp7SzyFG0aCRnXP1oOyet9qMpLslzBzzN568UUNejEwqH6wgKTZyyABi8Rnwr1+oHSOF2NAbqw1hQ88rMaSEsuvicXMGwgNSkSNBIx5cCav8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jprusakowski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u3DQXgdK; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jprusakowski.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u3DQXgdK"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-606f504f228so1291108a12.3
        for <fstests@vger.kernel.org>; Fri, 20 Jun 2025 01:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750408159; x=1751012959; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4CL1bQlA742vza1ucSKTw1PY9KB+oxRzPkNlh4M4pto=;
        b=u3DQXgdKqvp68Kn6wHIqV/EpsHpI18666s0HJRwTQXIiynxcM5y4VK6ekPp+is/qTD
         wx+fIe/coubpcV08x9POCzDrOX7LixH4DMsGxsAsuX4dyWAeqBcrsFKg125hnrbIrCOf
         85/YHSKtZij0IpjVi9GCbcM3/82iQ0gNdZRrQwGgCBEVaGsaqXUwPO1qSafCeC/KV7Lj
         50y8U/q6xzu0R8H5BkY5q4e/6dhzzEqSoYPAftD7bMKobeAE9QU0o2SCb0wL5w9kuSsM
         jymG13N26CfN0iQAdHnOFxchjyk6AyDhSqpsOucyZvihdrfAhgZKvBU0wRJKEq9ABJcc
         1xVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750408159; x=1751012959;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4CL1bQlA742vza1ucSKTw1PY9KB+oxRzPkNlh4M4pto=;
        b=r1dYUvqEcMz5ERsjnwsRdBcsX2xMAIUXiVUk9zhkB2QCBfQ39W9wsPAMiPifT61fPP
         bcnjMPaKVr9Hrfs6CIQ05dtDIDSPdJ/8ez3GmOuJh/vrJztzOKa/UqdZBBjLFDMdgiyQ
         +hYDqAPVRiHy4ZzCg2/3WICh7B5CN5O8vYtwZ/GAiCpp0DVsV1NQJt3iFhs25ijBwS+x
         RqyfBX3RU/+jD9cO17LaX8Kh7uFriT/C1vd+XnHaykpDsrygQuP/hjomD1iy6exreH3f
         yd8qEUfi6HcVsHRz3T2ldii2W+EmNITGsgjraIkPrMZDLVvVyp4Sk6eS5YBmoYYh3hKu
         N+3A==
X-Forwarded-Encrypted: i=1; AJvYcCX9T3a5SZQBuBwan8XqO0N03PVLb4e+fD7E0UwelVOY2Nj9gyO0dm5Ddf/5Sxdl3Jodm87mCmAL@vger.kernel.org
X-Gm-Message-State: AOJu0YyDf0D11L1701KhSCxev3KVJHOfTDbQyemzKWj9ntf1NuaRZ0/T
	efQGAIHpqbaslRkK1maOHrINj7ymJy5hhEUZHTZaPFOxj0l1io4Z2km4WPtrDRYfWhfUP1HaqM7
	nSX/o5hzH2OyNyXiVHfzX1fcqBfDmOg==
X-Google-Smtp-Source: AGHT+IF4tZG0Isf803il3uovoSlgHM3LPmKA/KM/U7e2VBzmiMXZSp5i1opvLOvcgFCthTxn4/E2EVjFrZOkLICoe/I=
X-Received: from edbeg40.prod.google.com ([2002:a05:6402:28a8:b0:608:faa3:8a99])
 (user=jprusakowski job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:4415:b0:607:f31f:26de with SMTP id 4fb4d7f45d1cf-60a1ccad8femr1597328a12.1.1750408159572;
 Fri, 20 Jun 2025 01:29:19 -0700 (PDT)
Date: Fri, 20 Jun 2025 08:29:06 +0000
In-Reply-To: <20250620082906.2122560-1-jprusakowski@google.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250620082906.2122560-1-jprusakowski@google.com>
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
Message-ID: <20250620082906.2122560-2-jprusakowski@google.com>
Subject: [PATCH v1 1/1] generic/018: do not run the test if a compressed
 filesystem is used
From: Jan Prusakowski <jprusakowski@google.com>
To: Zorro Lang <zlang@kernel.org>, Chao Yu <chao@kernel.org>, fstests@vger.kernel.org
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	Jan Prusakowski <jprusakowski@google.com>
Content-Type: text/plain; charset="UTF-8"

fiemap does not support compressed extents correctly and the defragmentation
check fails.

Signed-off-by: Jan Prusakowski <jprusakowski@google.com>
---
 tests/generic/018 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/generic/018 b/tests/generic/018
index 501960d7..52b48dca 100755
--- a/tests/generic/018
+++ b/tests/generic/018
@@ -13,6 +13,8 @@ _begin_fstest auto fsr quick defrag
 . ./common/filter
 . ./common/defrag
 
+# Fiemap doesn't work well with compressed extents
+_require_no_compress
 
 # We require scratch so that we'll have free contiguous space
 _require_scratch
-- 
2.50.0.rc2.701.gf1e915cc24-goog

