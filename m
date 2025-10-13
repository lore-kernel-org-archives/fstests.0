Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D772DC352
	for <fstests@vger.kernel.org>; Mon, 13 Oct 2025 05:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760334033; cv=none; b=GWh4G/CzRmKgpIlDPhz3Tsq+eSi9rDdmTk0bdxsI8dRD33SuRdDzetRU39X8w/yiriFoM8EBi5tdqDeOUtPQAgB2qusIEIegd8YY46fddmBy7cfDVO5vJDdxAGJUG4Mbmz77CZIOAhOwaGgFn6enEH1Vsmerx7K9243hU0Tvgas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760334033; c=relaxed/simple;
	bh=cxgyZxSPFqdEV+bzon1DlQodKZF6jClXPN0aaxXDbLw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b+t+HDlf40p03x0U3z5nUU6X9912y2Y+qMf2KCX5Wm2bywqOJO2UKUyuMFOCgCYNeXsPqMq5tDqxcTQMIVPeqZJXxz9RQiZOAQI4oHWgD88mEG+UvnOgJfgXNuCrf1rMXUvdXTCMhnemFUE2WFq/ChEK6CWomMkRjfGhkgoTvjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kAUBrutS; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAUBrutS"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3322e6360bbso3505577a91.0
        for <fstests@vger.kernel.org>; Sun, 12 Oct 2025 22:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760334031; x=1760938831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xEba+0gCaQrfxoNni+oDcfAKt/GiRqPhL9l/uPdmkbE=;
        b=kAUBrutSXxE1vqku0D5HjoZBwTWrtUgqv2VlFswYSRNRaGm38TqDE+hL3pPV4UKflG
         DS0VDyu/mT5T6gmyj1ufwHPdE3CuLqieCzbmc/aP/QQt6aZnLOF8TJ6ln2DPBYkScTgQ
         iKNxWpdFFGN8FOw6kLVS5N2r3/jiHYhUWKoc3Y3tj/38U+x4CdF2DBlk2rloAh84iA5t
         gSUohTGXrmJO8yo7K7wb/yaeyMeQShGCryrHVlwZD+0lbeOvVXAI4XydyD2+52rT7J7T
         J1wt2bh71aEltNo+eGdFJviZjQwGh8yvoD0C1viZyhZOUOnQssFW0GxUx3Aa20chsPfW
         0+xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760334031; x=1760938831;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xEba+0gCaQrfxoNni+oDcfAKt/GiRqPhL9l/uPdmkbE=;
        b=TGz+YW0MFiDKzRVrTQjsLktUNoiFeEHz1I55PG8mmp9ap8DP2PzHx5+ebAe6wLAsx3
         KbIJEduyNUn98kHU0NoY9tNi5w4T5zVJtowR8Op83WtBhy5X1JOD4IYDI6+jZAQO4DEw
         MRPkBvfUh1eePwhSu6l6J9kJKyKGM6Zm70Wx0xFx9L1hBtNkYTZMuUq062aV9WyH/oE1
         eXdCPe0Jx8vFU9P32vDV/hzosqY1+YExW/6yjXJetv4HFfniltejJNUGqnI5SWUod3v4
         Jh0Tl8DYww7NNvs9P2twkYjn3qxFfVhrdwB+nZTSCLi9b1PHcGmS0J/xmN47XqEPBy8M
         o2tg==
X-Gm-Message-State: AOJu0Yxy1OBAWMpNxbgpjQF2HNRFN+ABwWCxoAFSG/cVoFBHlL2R2CPJ
	KXbEC9m5OeyE70AIKCGojDAnfLMXDPhJXzSB6z50dTPSqTnJtK1NoXD/biL3PQ==
X-Gm-Gg: ASbGnctvfnAUPPMhGP6TaAcjcqCUIJkKStYC/8mUHd7V6Uwut/DJYAJ5CJATABOCE2U
	lJr2Dpi7jAwiLHl15nFAXosMUueAgi2AxH/lGSdH83JIhfo+BLkmOQhMdGOROJ1RhndYKbUbdRK
	ynTU0ridqwF3UcCDIRlNbRPkTPne1kxEnUeQaSEpEAHTypX9wKazeYK0n/P7VPQ4+EjimLhdE69
	0eEGV2M8Fj3ehIKcRm48qVWz68EtXXWU7H7zkuMZUxx7AtptV2229Q1ptPEyk4dEBw6X5lR2WOh
	2A8gzyOzvpX/ak/cy9RMRWt8EkHMngaag/a0zikOk8G/4KANZyBK52hF5ylLEdHqnjZgouXZGNa
	UOQ63pEBlyrFq/LYIp3QZJCYp6rhfiY3rZgcCP4mZb2zgOA==
X-Google-Smtp-Source: AGHT+IEXNzExHsC4hdSOyEJbtuOn/55j31Q+bCvxghBnsMs8nP3dPrVEW6BgdAucRb6FWKr6XCowbQ==
X-Received: by 2002:a17:90b:1b05:b0:32e:7270:94a0 with SMTP id 98e67ed59e1d1-33b513990c7mr29721239a91.33.1760334030723;
        Sun, 12 Oct 2025 22:40:30 -0700 (PDT)
Received: from citest-1.. ([49.207.231.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b52968581sm7014726a91.4.2025.10.12.22.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 22:40:30 -0700 (PDT)
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	nirjhar.roy.lists@gmail.com,
	ritesh.list@gmail.com,
	ojaswin@linux.ibm.com,
	djwong@kernel.org,
	fdmanana@kernel.org,
	quwenruo.btrfs@gmx.com,
	zlang@kernel.org
Subject: [PATCH v2 0/3] btrfs: More test fixes for large block/node sizes
Date: Mon, 13 Oct 2025 05:39:41 +0000
Message-Id: <cover.1760332925.git.nirjhar.roy.lists@gmail.com>
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

[v1] -> v2
1. Removed the patch for generic/371 (will send it in a separate series)
2. Added RB by Filipe in generic/562
3. Added RBs by Filipe and Zorro in btrfs/200
4. For btrfs/290 - Commit message changes and changing "196608" and "65536" to
   "192k" and "64k" respectively in the test script to make it more readable
   (Suggested by Filipe).

[1] https://lore.kernel.org/all/cover.1756101620.git.nirjhar.roy.lists@gmail.com/
[v1] https://lore.kernel.org/all/cover.1758036285.git.nirjhar.roy.lists@gmail.com/

Nirjhar Roy (IBM) (3):
  generic/562: Make test compatible with block sizes till 64k
  btrfs/200: Make the test compatible with all supported block sizes
  btrfs/290: Make the test compatible with all supported block sizes

 tests/btrfs/200     |  8 ++++----
 tests/btrfs/200.out |  8 ++++----
 tests/btrfs/290     | 16 ++++++++--------
 tests/generic/562   |  2 +-
 4 files changed, 17 insertions(+), 17 deletions(-)

--
2.34.1

