Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84469148FE6
	for <fstests@vger.kernel.org>; Tue, 16 Sep 2025 15:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758036638; cv=none; b=e6mPcUgIvUqOdHvA2A8bws1dg4exBE2pOzub+TO02QWP3Gz3TibQZstIkScbJLtTQjYDyAR7VkvWlQk0jbbubHUisrtLywvDRS+TX7q+XU5HsK4HGhMv8l5i0LF4BE0kYrz0m0XYzOLEwbyo+/LeWZjyQMAdRqmJsWLPQwEB44o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758036638; c=relaxed/simple;
	bh=VFjjGQQjJy1mpPkSqfxHEfuW8YkJqNNBDPC3Nl+LO4M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m2ac91HuIZPBXeHLLd7Oq/fHg0Uyhk2t5fNj9PXYuy8q5AyS8fQTDF85RbXkImiajilgMJlxCOwSdkgdzKcJrHCqev2gEq/4hjJKvlkRizWpZ4r7VXRWy5IlkMX9bp7aSL8+dseqJjrIvcvLsdvtinQZmCIxRogAE2QUNBPQXz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nP8wow8O; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nP8wow8O"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-77251d7cca6so5334272b3a.3
        for <fstests@vger.kernel.org>; Tue, 16 Sep 2025 08:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758036636; x=1758641436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tM22SWsty6XqN+ZQ6rRBUiY5czii7jKoPery64Dg66Q=;
        b=nP8wow8OLA60RJit+wHDfegduQfzXywuIfJLwWf9HkyYrcLC8gXX/chzVZTfTKVul2
         +0Qba0T6eh7m2yvibn1SsagcXrRsnGr6woSmbCokCSBcdJzdXTCzyEiggegcB3X75eEY
         Y+Imtx66OD45hWaPiSoh08vpABa0sB7MvwuCqnQJN5Dm66XQVI6BK3mYz9l/paBq3f4r
         6dHDkg/ih8zoTHOwja4KqtgeJ+1RySQws/m0fc2OWN3/el4I6AMsgAf1GmlS5tuROhQx
         /s6dfoAWpQgdgT/P++q2/M6Dmfywoai4sO2LIt+4+IC6N+mRO4AfqKM0OsJkd5cl9dDy
         fYRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758036636; x=1758641436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tM22SWsty6XqN+ZQ6rRBUiY5czii7jKoPery64Dg66Q=;
        b=KuY+4n46WLxzK0zpxPX0xKEXQ/r4outsH8LGvtOntmx6fbS6XJhrECzo+lVjkHdwT9
         q6edbd1dekr9uRTYkkk7AmTPNTgn+3Qz7gpEPl4e3T84Qo57hQcxv1wgfNe6mLDKiinv
         +zEZxALnx28Xc/YOiItvy47yw8S7tu+DrNg6eUzwGDuhEYxbmaf4yL4OSXufxeyPvL9o
         3Gft6+CCKYl6IvrmHegO1vzyq3RWhjPMWRMsGDtQVYL+FeHiZUVXduNFH/LtsnMlFo+I
         X0BtW9mgBzM5bySVM9N8Dx486n9myVq/C6gIpg6H2k84CBGjNYfkWK0XCpXbIRVnzo8i
         USGQ==
X-Gm-Message-State: AOJu0YzxT/NFYmgGOQH9IFyCto7oL4OT7VR47yvVb62JYvJpgCkicpW+
	dQE66wMWIG13V8fXuKjUFYp0oJXfDCBjbgnE9Yp0N20xCOWOYlAxH75L9fHC3g==
X-Gm-Gg: ASbGncvZDltp3J8qPfkLvQzboCG4J2Df5+aZaxO1XupCDY6lxfWlNBDfooBNgg5XGLe
	MAcQWlSXwkdnns6o/OScgxOeCTytFszlZVk8l4LITXhj8EciC67VPb2CiWHAofbcZbDvbUfYobv
	pCjTaHJF+H/O6CNgZ+JbHUUWHlG0Lk/RMNU7tyehOBJa+uR9fTdrYMg7UY2A18yF8QL5cwExuH0
	uxwEUcwKwTdeq9n356lStJsOa8OiXQVxIQFhjlKi5MuTkLoSuA9Y9hWvIIp9HdTux/AiCYUJ2eU
	8N3iZO5lqa544WgXr2MmpW+6InT7orrfZAY8d2RMFt5M9oc21Ku+YO47zEf9Mh8Cv+yQ3FgiL4s
	nOGWdk4quQf4iVQxz0CzAG770zDjas5ReEB88gg==
X-Google-Smtp-Source: AGHT+IFA76YP4R1LOrU+/DxrqWh+sHq7cKhUXntKO92SGebh/pBMUS+EkNMSwr+27eniGxIeAOIzXg==
X-Received: by 2002:a17:902:e547:b0:264:b836:f192 with SMTP id d9443c01a7336-264b836f845mr112740015ad.35.1758036635820;
        Tue, 16 Sep 2025 08:30:35 -0700 (PDT)
Received: from citest-1.. ([49.207.211.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-262df893ec5sm92596345ad.46.2025.09.16.08.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 08:30:35 -0700 (PDT)
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: fstests@vger.kernel.org
Cc: nirjhar.roy.lists@gmail.com,
	ritesh.list@gmail.com,
	ojaswin@linux.ibm.com,
	djwong@kernel.org,
	fdmanana@kernel.org,
	quwenruo.btrfs@gmx.com,
	zlang@kernel.org
Subject: [PATCH 0/4] btrfs: More test fixes for large block/node sizes
Date: Tue, 16 Sep 2025 15:30:08 +0000
Message-Id: <cover.1758036285.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

More btrfs test fixes. These tests were ran with 64k block size and they failed.
Individual patches have the details. A previous patch series with some other
test fixes was posted[1].

[1] https://lore.kernel.org/all/cover.1756101620.git.nirjhar.roy.lists@gmail.com/

Nirjhar Roy (IBM) (4):
  generic/371: Fix the test to be compatible block sizes upto 64k
  generic/562: Make test compatible with block sizes till 64k
  btrfs/200: Make the test compatible with all supported block sizes
  btrfs/290: Make the test compatible with all supported block sizes

 tests/btrfs/200     |  8 ++++----
 tests/btrfs/200.out |  8 ++++----
 tests/btrfs/290     | 16 ++++++++--------
 tests/generic/371   |  2 +-
 tests/generic/562   |  2 +-
 5 files changed, 18 insertions(+), 18 deletions(-)

--
2.34.1

