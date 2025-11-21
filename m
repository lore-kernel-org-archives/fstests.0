Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201A42E7BA3
	for <fstests@vger.kernel.org>; Fri, 21 Nov 2025 17:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763747743; cv=none; b=E/Dhq3B3wJxZYQVuMPoRtL1Z9xjAqpCbkYnmibd7F9sk0ZOpsyxmHniJLsDAtI3Q/oLEmdc4Lbvpis7sQyZkTyNGIwWNiu1eia2t0wNYyjCuUcDHrgaicCvwBDUgrWYr7sQH/n9foldxjmhLSzhRi1p084tlI0EZd7pOLdOPNoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763747743; c=relaxed/simple;
	bh=4GkAj7pF2EIR9GTFdVHGYJtWl+diz32yreWlqEaOtPU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=BVl5faj80VkGoxc+F0sTGf/RjF74sMnriYsbl1TZ2oKcQbvX/eqDuo3/BuL76RqVSBsnFwKORy6S7yY5yF5cIfh+jLm5cP2qMfW7ur3V7ye+JP3MnQdAe6jxkA3JXq1e4hU1NzadzIg4KtT72cfTDn5Cc9Cx7RfOShb1jNZNcNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=CuWfpyN+; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="CuWfpyN+"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7895017c722so22727387b3.2
        for <fstests@vger.kernel.org>; Fri, 21 Nov 2025 09:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1763747739; x=1764352539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xHh7NAxLq+wyjDH19eKilpc7ukFZkWjRBiy614h4rD8=;
        b=CuWfpyN+k8zjfk9K4KE8uGhvnORmdizUY4LJJn2DxxZEf4BMtdHNPxyAVdRAsxMOe0
         AQNTM73zDUFciCPvJ16UR7Cu0tprPCwu9C2MnDOHLVd/oUjlMpqrjMmiiDStOzc7oO+b
         DssDyTyy1o5G08D30rbm4yyZi3/VjyZ66GnoBXX/NDN8vUqYYUexaxfVWyE0nH+eVxa+
         IIHIFF2Rco9hTlIiNTiXLtSCCGztCejv8kG4bGuXc60WqwgO55mXv2yEI7KoEDSEElK5
         VS8+I8WYedgz2edC1R75qVQ5aoRwL9yKw4N1BQAx7ltTR/3c08pONG5sfvlXwjUDU/AA
         RwFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763747739; x=1764352539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xHh7NAxLq+wyjDH19eKilpc7ukFZkWjRBiy614h4rD8=;
        b=jWj5+ou5pnPg3rg52Hglaf8kf7PviFe0shtPCaTVK6U3GpQSA5duQYNx6HUEAApUp8
         mv4ejktEs5MZYvcdUlyFGXdilgTkoW22PuAy+bmMIkEXRSv/LF8HuGbXOvzAw1Cm2/6+
         QZVk3EqnX/sHyqfD/TFD2QhCbALgaft9heMfKgjsUmB9mPySCCwbde13yqKll2tJe/3u
         l3/vs9AbqeUYek43siyVv6R7yBKgYwn8OkHkc82KBT+In2q+cyTlFcrRHAoBadOvEdoK
         tytpYUW0wd5Hc9mNuVuDTGIMVSwumJId122rX89ZVnQlvULaOQbQQy+ZOUAhVFzPkIZy
         iLdg==
X-Gm-Message-State: AOJu0Yzl9ZrbFCJwY4tCCPHZ0FueVo0XdZhJgTpBbNlJAuF9XpyPOGnK
	uPjccRNdjV+eHR/KUbbFZ3+E2EuVpQqZNGC08y9TvJnPCUX7idtvkmdAAMxLvKUR5DBF40KVK6m
	umDcRaKl8Kw==
X-Gm-Gg: ASbGncuFKGoYrb2ORIBNNwt74rCOgKBnNpAquHT8lr5+dJtPU35F+TVBODfj9eInv/q
	wYcrM8p6l8FLAddzpwNjx8GiItU7l6sFol3Ok2pvgPeQh5u+l5SFORNpFSMc/S4soi6WudPF6vX
	Z5U/K3YNpDgL/FJHvKYIHHtb4PYiPnvZxktuvpk6ZcKiz/ZZHAjB2xaXhSumK2aFAjhXg+rQG1c
	ba09/aELiiiZOGfvjVIpEAdtQBJs/1soXKLnC/YilI2fFoO7jqAvIJVnbxcqJs0AciDiGz3Uo/Q
	ftejRmj1I5BY/fVGEQS4VP+pRrqrWUQwCVGPkWGB+HH2q7jY5q5jcJooxmgvE6A9EepheCZCEOC
	Z+Mnd/zbwUMaO9zE+3SDxooLFWess5DbtHpNC2Wof6sypZj9UZU4wpGXmQkXdtnRVPddHi0jbmc
	kX+p4HLjGuEGTL
X-Google-Smtp-Source: AGHT+IF7CrjaJfBfeShvlylP9IT2+CGfxtZYt+FhuAACkB2AmYUmdrylfzosaWjlWLKo5XX/H3FmQg==
X-Received: by 2002:a05:690c:3612:b0:784:a232:b3d9 with SMTP id 00721157ae682-78a8b4adf05mr21852877b3.18.1763747739535;
        Fri, 21 Nov 2025 09:55:39 -0800 (PST)
Received: from localhost ([2603:6080:7702:ce00:f528:9f2f:44c:2c84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a7987f5e4sm17629327b3.8.2025.11.21.09.55.38
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 09:55:38 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: fstests@vger.kernel.org
Subject: [PATCH] fstests: fix bug with _check_dmesg "some pattern"
Date: Fri, 21 Nov 2025 12:55:34 -0500
Message-ID: <16110e3dac5c7476dd5c74bfb50efb4dc1aac5f0.1763747729.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I've been rigging up Claude to run fstests via an MCP, and part of this
means it mounts a 9p file system to save the fstests results. This was
giving me occasional ENODATA errors, which I dug into. Turns out it's a
race between truncate and read on 9p which is completely normal for 9p,
but it's uncovering an actual bug in _check_dmesg. The way bash works is
when you do

cat foo | whatever > foo

bash will setup the various communication channels first, which is the |
and >, and then it will execute the commands. This means that it
truncates foo FIRST, and then it launches cat. Which means we'd race
with truncate and sometimes get data, sometimes get nothing. And even
worse on 9p we'd get ENODATA because we get a 0 read back when we
thought the isize was reasonable.

Fix this by changing this case in _check_dmesg to redirect to another
file, and move that file over $seqres.dmesg to be checked later.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 common/rc | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index a10ac177..947685df 100644
--- a/common/rc
+++ b/common/rc
@@ -4844,7 +4844,14 @@ _check_dmesg()
 	# test failures. Custom filters are then applied afterwards.
 	_dmesg_since_test_start | _check_dmesg_filter > $seqres.dmesg
 	if [ -n "$1" ]; then
-		cat $seqres.dmesg | $1 > $seqres.dmesg
+		# We use $seqres.dmesg.tmp because shell will setup the
+		# redirections first, which means we would truncate
+		# $seqres.dmesg before cat'ing it. This is racy so sometimes it
+		# would work, but othertimes it would silently fail, or in the
+		# case of 9p you'd get ENODATA. We must redirect into a
+		# temporary file and then move it.
+		cat $seqres.dmesg | $1 > $seqres.dmesg.tmp && \
+			mv $seqres.dmesg.tmp $seqres.dmesg
 	fi
 
 	grep -E -q -e "kernel BUG at" \
-- 
2.51.1

