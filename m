Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173163644A3
	for <fstests@vger.kernel.org>; Wed,  1 Jul 2026 06:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782886472; cv=none; b=h2bueLL7NQatWmLL2u5CmShbexaK0hRyKA6cqR4FpNC/bDzpuXXwGrnJvndzOjp8+Xz8v6Z2rKa/bMv1vmxYCEa5V2noBQ8Ba53SEaKxHRRS2SNQPA+mWRiO0eUunVqgwYS/h7PsV2yCH+V+n2FO93RysAlKJ7VMAoc4i0uGyRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782886472; c=relaxed/simple;
	bh=G+0uN1i+t/C/44VRhaxD+nDHk/ECrNN0MO0YpN7OyGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X3nU+Du9N214uvmLfVBCYlAPtqS3koBjSif5hpEoohOG9baTygjNIoEjbrUvFWkui/keKDK9ayo+Tpr2C8iC4mbeG9g/Rv2ztcsY7Mxd2H0IPYjsN44rUjfk6aiK1JoSPZ2WN1VTDeZIz3GCoKgwxST0gsjuLZECSxYiJO27hSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KVBWvD+t; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KVBWvD+t"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c12629c937eso38659666b.3
        for <fstests@vger.kernel.org>; Tue, 30 Jun 2026 23:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782886467; x=1783491267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fsx6EpGKwFJpk9GmGZZR+Oo0q/8vVBmCZdbszGhCwog=;
        b=KVBWvD+tUlHrTPYfHzJfFrl+H16Vnvqgm+RNkEQUV7oV8gv0EDTKnRVvTjZNwbTFhk
         KNej5x3lfCOtiG/k6sGxUf3UQokcMzs9LL/5mY/deWLIkgSlJCRV1MfdoeJn2C3WivDl
         +HUk2+rKu6iKrSh0Rgkhy8uf+FDGSaUrcTfrKlpTDxCMn1gtWRgyaoR23QkBSDLhk4Z5
         KR852e3YQ+WbJtIUc22itv05bDi2U2RwMy+fbdYKRNSR7RipnNlJuFIaRHGOL3cd3Pob
         O98p1nawl6jcJ15CDzyhFUWge5VXuFQnMbLN8n14ML2dVAAWlIQJnu3k1TgXr94rfZwy
         lR7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782886467; x=1783491267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fsx6EpGKwFJpk9GmGZZR+Oo0q/8vVBmCZdbszGhCwog=;
        b=Y4Kba4m+KmgFMc/H1nTny/6aM5x8TW+82xeF+orpfmulCKhwTK9aFyBryGIO8kFVYU
         /bc0VxRLaYTrKOZIfGyu9ioNksuflSG+UGo+r2BbW9pL0G2XAkZ8td6ZSSHe3d4mW4ta
         Zf82LSIcEyN8luglKGWUYVQqYdOlmOV+9DOSGe/eOnrWaRJPkYs+NRKQXLXaklQxRETm
         vjUMDxUymMZpC9ippScA2jaJIqwm86gTKk3WFPKxM3ggXKToKPe2YiDxlkrATC6smRKR
         g55eGU88dKv7W0LjBVTIxpuUmq5m8qjyHDUmin5bVXfIy86OT4lVesjtB36fjYzs6JzZ
         teMA==
X-Forwarded-Encrypted: i=1; AFNElJ9uvJtEdoGkunOMnENFqZ7CtwtUqmRkWZPtzIhfDPaTSBXH9jgyVRIC7QXG1OxMHP4Uifz6bB0J@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7KKvCs/9lfuBwwIB6t7zAz+Q5sBNSRRupz+z/Bc2eLLmGogbA
	s4sXPTjtloSvBr2JnzV6ZAZRvffdLnKyeU5x/wjxtKYd6HTZMz3uaWXGaa/ufz0WkeQ=
X-Gm-Gg: AfdE7cm3ska9Uy5p/6t+/8HS+d4ZtAG8kG/oc+q1Jo8y1pJPMeAeh2oUNmEpadIx5GY
	W/NLR0OP7IjXoA8CWBqvxRFvlXRPLcsJpkMTp10zzQCJuAmxM5WYyUpAQHgT7Mfl+13xhtWi8fz
	siYBf/gIkDLAAQEqd6lgIMYyM8WSTtFYG37+ZZBKnWLna7CBkCB8nq48+YZfKMXVaVu56tktgOs
	5Sh2mjFYekqZy+IkbcLi0OiGvgz/a87QTDfojQf0zIZaRJsk5XaTcojsHZWOg/bJxh+c+OBH9KJ
	asaLG7yvG929xJanOaeurdkFeKkrKnlUahYmqkJoVrzWYLNA1Qk1nFdtVnBkH2k7nu5zRiIZerY
	5KsEKjt7MV2kHTwtjm2iOg9k/tikGzaSX/JyA9AWGbG5lws/mQ3YCxU05WgotBpwjlTsq2ZF6BL
	pSkwOu4LkAPfVKQJmCl53ZbQ==
X-Received: by 2002:a17:906:3b0b:b0:c05:3c55:ee86 with SMTP id a640c23a62f3a-c12aa175d53mr3081366b.46.1782886467272;
        Tue, 30 Jun 2026 23:14:27 -0700 (PDT)
Received: from localhost.localdomain.com ([240e:304:4bb9:5900:2473:1306:a293:a912])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847a0329c08sm3324786b3a.42.2026.06.30.23.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 23:14:25 -0700 (PDT)
From: lan@suse.com
To: djwong@kernel.org,
	fstests@vger.kernel.org
Cc: An Long <lan@suse.com>
Subject: [PATCH v2] common/rc: fix mount options quoting in _mount
Date: Wed,  1 Jul 2026 14:14:07 +0800
Message-ID: <20260701061413.10531-1-lan@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260629155812.GW6070@frogsfrogsfrogs>
References: <20260629155812.GW6070@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: An Long <lan@suse.com>

In commit 078f320 ("treewide: convert all $MOUNT_PROG to _mount"),
direct calls to $MOUNT_PROG were converted to call the helper function
_mount.
However, the _mount helper was implemented using `$*` instead of `"$@"`.
This unquoted argument expansion triggers word splitting on any arguments
containing spaces (such as the overlay mount options containing spaces in
tests `overlay/083` and `overlay/086`), causing the mount to fail with
"mount: bad usage".
Fix this regression by using `"$@"` in the _mount helper, which correctly
preserves argument boundaries exactly as they were provided by the caller.

Signed-off-by: An Long <lan@suse.com>
---
v2: Revert the error log to "$*"
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 79189e7e..b9a07324 100644
--- a/common/rc
+++ b/common/rc
@@ -296,7 +296,7 @@ _has_dmesg_since_option()
 
 _mount()
 {
-	$MOUNT_PROG $*
+	$MOUNT_PROG "$@"
 	ret=$?
 	if [ "$ret" -ne 0 ]; then
 		echo "\"$MOUNT_PROG $*\" failed at $(date)" >> "$seqres.mountfail?"
-- 
2.51.0

