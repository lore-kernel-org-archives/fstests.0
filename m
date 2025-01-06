Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353FA15C158
	for <fstests@vger.kernel.org>; Mon,  6 Jan 2025 17:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736185764; cv=none; b=Ghy2DzN4nabHdsOQHItroBK8B14/BuZfcXwsOwI1Oim/dAfnhH/i5hQTHOP4Pi7mIUuVmR9mknu1S4aAMpJEIh7qGxn8tnNAV82Pnuv8iEDk33T1P6LokWoPqjf9vYOybSxfV1406lwH1Dmx9xymm+nl2DlHwCP3bEZXrUuulpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736185764; c=relaxed/simple;
	bh=pe3mJ7xBSrzaeAQ3c/zs4oI0+PoA1+aFvFGAWa4TSDY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M7xj2iAxxK65P4Yn1/MR4KVcgFHlriLoNBfPHwiNcVxzJ+xTGh5vxQFTvaTnJ2lU1dpoIQxG6zlENyqz6FvbXB8xqd1OJfTst/vWcq5wYzloc0JCeYmtudQX5RaRurZSV+lUIvhShYSG85Ed7j2TPniR8K8n4iaFg+zcpBHauyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=QAMM2EoD; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="QAMM2EoD"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-844e06e5d11so490842439f.0
        for <fstests@vger.kernel.org>; Mon, 06 Jan 2025 09:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1736185762; x=1736790562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5fhNs/QnKkRfk/4dcrWeTLLXbEcnBgJuGsiOUG56S/A=;
        b=QAMM2EoDd0WLWoa2UckXVfl6NkbBfgl7oAw56NlzEChQ+fHuKq/jJsb1ZI9APLkgmO
         4NL1ysqGvSqRs7IQa2iH5iRW/1h0YNJHlYBlvB5Ijf5SwK4xHu0mJK14rMieC8BMa+mK
         IwWHnOrMf11xnklZWIgaO8dl21HqyoJqgqHuE6ltTPFNIbopbpFpeLdljm0G+vVC4vGU
         +9ZMXgn644o+g3ohvbivuB1Pt6VPlt2oo/kmmCjH+yxATXSeCbuljzdp/tfrTj08Bxvw
         z1/nqUVEGyn+TDaqT3d7B1z8eEm/81IaKsrPrph3RCABYLtoEaNl08y19GszPa49Hflz
         bUuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736185762; x=1736790562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5fhNs/QnKkRfk/4dcrWeTLLXbEcnBgJuGsiOUG56S/A=;
        b=t9KvoEIh9S99nZ6DFjiY9F/P4McqAaJRHmISUUL93EsALsvmzWaZVMsUl8uUJXBO3l
         6wStw/BBiqTc2K1G8eRpYdHxV2w2uIJhO2+/pL0xOIb55Gu0vOs/HMsDRLOTmgNOP4RQ
         2CkphT7W/DwWN1ham3DTg7/8ABkEw/+SuHfrqXfmOSqzSVW+PXv55FQv6+c6z+bdGdtm
         hJpZMGf1atLKqG7BOjjzVHoT6DQm8pSM1ZCikEV5QOob+ktk10IFxVGTr5pGCHw+fB3H
         fetjJX73+a7c3GcCFYZspxkE1G5ALz10nZ7ZwpYsxyOFRgpDu8fNbp/uNUpagctbLV6t
         m0Xw==
X-Forwarded-Encrypted: i=1; AJvYcCVVlqgecASmpVMV2j73xGWB0lkDNCwQlZnJX/7uMoOfeSY7ZF9O2Wd9nnpii/v8yM1UeUfa89/W@vger.kernel.org
X-Gm-Message-State: AOJu0YyyHwFCvDN0oS/bPRiLIllMsfNBd9XR9PA3AagAKwqwuVHYl58V
	Ga165wmkBLDu8xJvaNamwpWJMATGzymJXd32RPwGdQBOW+RAF2dRJdLPH5Q0ov0H8RFbD6p4ndn
	P
X-Gm-Gg: ASbGnct0oP/6VvPFDHugWZvMzE68X7y/q585QrqcxRzFIoDLwekJLRXrZwQ5b5JDnKj
	itCqTUYUw5LSDHkrBzeKGqedb8IMTL44HiB406bbelT61QfEMGhb/8oGplHgpJocuTGjkhhbk29
	CBUOcfpCpt4iIyAxFuGcM80GLsp9B1Iqse6qNYh6627zBUscFHUBo0jX3arA7O7D1LfhnjhYph4
	PpF5QqKeXFw0lVA9hoJK3eQDPDKoubH0dIXt7/6Q6tXLmCz3BUkjYYXAMIf
X-Google-Smtp-Source: AGHT+IHV9Yr0hb6tTZELuRv6SzdW3yA+ucz3tL0NTu9QXae2yC9zSdflbbq4fjYgR3t9rns23/2pIw==
X-Received: by 2002:a05:6e02:b24:b0:3a7:85ee:fa78 with SMTP id e9e14a558f8ab-3c2d51516acmr468643685ab.18.1736185762438;
        Mon, 06 Jan 2025 09:49:22 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e68bf4f355sm9210867173.9.2025.01.06.09.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 09:49:21 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: zlang@kernel.org
Cc: djwong@kernel.org,
	fstests@vger.kernel.org
Subject: [PATCHSET 0/2] Add RWF_DONTCACHE support
Date: Mon,  6 Jan 2025 10:48:45 -0700
Message-ID: <20250106174919.103199-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This adds support for RWF_DONTCACHE for fsx and fsstress, which was
used for testing the kernel patchset referenced in the two patches.

-- 
Jens Axboe

