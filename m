Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D01D37268F
	for <fstests@vger.kernel.org>; Wed, 20 May 2026 07:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779263406; cv=none; b=mL2Rev4dEU3jeHr4kSPLcPF6HXEUWrxWne6CYvtc/nAiMUkIixSAo3fa8JK2PV7xGHfvOoUOUw7yZRN1yVfCW8AmdxPirT1WoSRmXOzdfCvWrBn9C2o3/0BBXu2fh6UZan9XqCHT4evuC3eGUuQJK1JyEESau2CeAO/gwUKjB7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779263406; c=relaxed/simple;
	bh=oNJjuxhYSmmnZCA166Wfxqly42LPG2I1zZXnaNdxKxw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kIAn8DVlFUSnhlwp7NPq4AHIRfeYsGNW/4zAx8/IvI2cb/ZrH6TqIrO+prNzkARTeZWCBBDq/BwxbkRhHPCtqdRORwrmQisIGO9nZfHIm9zKTgGKLOL8Lj2VrXKat69TuBMWQElQd2yu474Jk51CFXWPC1NSOufvgmAhoTaimQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aq+LrvNM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aq+LrvNM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 849571F00894
	for <fstests@vger.kernel.org>; Wed, 20 May 2026 07:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779263404;
	bh=qMmbdDz9EarbtFYpIxCtmvE58KptCstyj6rBot4qza4=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=aq+LrvNMc9znhAi/fp6BsaJSIuD1tjuW4OEToHT0oMHcsC6Ux1kF46vpEKElrMDXs
	 ZEeGOMC8BKmUk9VBjcomwG0MPgxUmTgwRxd7vnhnPTsMRsJcyTJrYMzHPvKXicSqFa
	 5aQUibpKdgvidPszhX/2gomacdEZR6cT+CtklYSrbbvU0WPY5q7XZbQmmUi0AWf/dZ
	 ev5flp7ZQnBJSFH7HmLH0dNVR9svXbx8SgoABwKIdYySee/NA+EocfaLZ2c5n/II8g
	 aLRpW8UrzH9TGCidlh/iRptold9UJK3IWIU3K6M/85LDgRY/3qYCiCj4jEW0q68r8b
	 mVYfVnnBwGAHw==
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [PATCH 1/2] tools/mvtest: align the output format between new and mvtest
Date: Wed, 20 May 2026 15:49:51 +0800
Message-ID: <20260520074954.1877984-2-zlang@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520074954.1877984-1-zlang@kernel.org>
References: <20260520074954.1877984-1-zlang@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Maintainers frequently rely on mvtest to manage new cases. Therefore,
./new and ./mvtest should have a consistent output format during case
creation and transfer. Otherwise, it can lead to maintenance issues,
such as regex failures failing to update the case numbers properly.

About 10 years ago, 03c633bff6e4 ("build: Allow alphanumeric test
name suffixes") made below change in new script:

  -# FS QA Test No. $id
  +# FS QA Test $id

However, the mvtest script still uses the "# FS QA Test No. ${did}".
Although we've fixed the regex mismatch issue, unify the output
format across both scripts will prevent future maintenance issues.

Signed-off-by: Zorro Lang <zlang@kernel.org>
---
 tools/mvtest | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/mvtest b/tools/mvtest
index 09a9982b..0541d237 100755
--- a/tools/mvtest
+++ b/tools/mvtest
@@ -36,7 +36,7 @@ git mv "tests/${src}" "tests/${dest}"
 git mv "tests/${src}.out" "tests/${dest}.out"
 # make sure testcase is executable
 chmod a+x "tests/${dest}"
-sed -e "s/^# FS[[:space:]]*QA.*Test.*[0-9]\+$/# FS QA Test No. ${did}/g" -i "tests/${dest}"
+sed -e "s/^# FS[[:space:]]*QA.*Test.*[0-9]\+$/# FS QA Test ${did}/g" -i "tests/${dest}"
 sed -e "s/^QA output created by ${sid}$/QA output created by ${did}/g" -i "tests/${dest}.out"
 sed -e "s/test-${sid}/test-${did}/g" -i "tests/${dest}.out"
 
-- 
2.54.0

