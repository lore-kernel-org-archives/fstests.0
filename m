Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA82207DF4
	for <fstests@vger.kernel.org>; Thu,  6 Mar 2025 21:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741297169; cv=none; b=QdGNYNEiVaeh41NFMTol4+h85kwWLAp3Io73NOgbr1utVvDdIbSZ6H9Gs/oQHS0BlMf+OiM9bsvk0rfjZ3uJ+gdg4NLBonaM+NZoWI/41+Y2w8GYPEasg2Bl6a6IZ7Lz8zwrrpP58LEAzZr3i9fibsTyBm9b0WSpzwCh1mvs9Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741297169; c=relaxed/simple;
	bh=hgOPNNdptM0h7BVLcs0n4/MzgJPsOYy6RMTN3rBmJok=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=aMHvEArpUjWSbKN+mY38lPrEEtM3ve5Gvxs9CUMBnWVQ7rU0KkRWx/pf7dBD40Yin1o3K12yA/9D5HPtWWfZ2L9pBL/3QLjRPLvCxVoS9TKZ2KP3p6010xpRYWlXyXTDBMN600JPrwn4oVQTnHK2dQXxCgSz4Fk1HrCuadzWo+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=eY5vtWLT; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="eY5vtWLT"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2232aead377so22755615ad.0
        for <fstests@vger.kernel.org>; Thu, 06 Mar 2025 13:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1741297167; x=1741901967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hgOPNNdptM0h7BVLcs0n4/MzgJPsOYy6RMTN3rBmJok=;
        b=eY5vtWLTi5QBr1QoU5Is6lZILKoIfYjja89gD5d/mkkNpwWcoRji52IYjpY3XqBUPV
         mPKObPZwkJozjtuNf1H68KpcHyI0hHHlxUfXwdcZWBKGTfqVrHabW+411shOQMfZjrbB
         r29k0TVjwJfaGRhfk4JARDhC32uJezPdZL+lFHR9svvAdcsvnAvGlp9bSvYt8In0up9T
         eIsTsmmZVuJIda8TOZCsoA41HoErufFoTLI2G1mlGMwkF8savF2Gcl7tdlAaRqs0BQnI
         xJ1j0crl2u9KxYhWT90Xqb6Hp0RW4o2wvygl4BUQcfG1TS8Hh+diFzvMbHvujhtq4qKn
         8BQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741297167; x=1741901967;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hgOPNNdptM0h7BVLcs0n4/MzgJPsOYy6RMTN3rBmJok=;
        b=jhBBp5U4x8LhFd3ZPgnQMvU4EQjNAVZlVnFaI5+bIOd//Xv+w+RbWxcuBx0SgtF0Aw
         iVfhBq/+2Rcrjvctgru9KxPuTXKxRfCYx8AAXTB0d49HpjKRDFf5MwsFJR1kmXcfNBBX
         +YtRSW2A6UoTKNZqp5tqNdtM4FAGgoSE977U00u+fbpIDVY8JzF5jEB2KK8vJZGFnnUT
         O1PSmjiLnKmbGaxJ+8hf+HmCyWxUOixeh6M0YarAJF79jvvXWyKakvH1BdlPrrDTAwhx
         9vcwci/gAJO36CuA02eH/G9aLrLL4z9fIJ8wfxIyLpNYOgGn2oBcnDhd5Bh4+Kwrj8H3
         pfZA==
X-Gm-Message-State: AOJu0Yyb2ov9JlVCVOA4WOm6ufODwx5l7W7mBRSQklBogOAACHuypQMm
	klHlY0UKUSOup4xVOwSc4PMkpqYqSNYDASY8fkcGman+bLSMLqXdJwpxGNumVFs5GIaj1YLzQfb
	m
X-Gm-Gg: ASbGncuuD3qBFFhtyK3P8SOcIoZyIGXI+45/UtRKaV34KS92WuXWKT47efmUE0g8L4d
	dJrVPT7lSeOl2OU+VDGl7d/CYaAOhVKje86czuFr233/Ni7tQBFhkcwI+2TkBBFFHjQImaFb4En
	h0QJCdNac/ELHunbZp2R3ryfbFsFUVogjMyfUVUlxinUD6Ki0CkZWVwFCd2F4socOCKfQiQHh+G
	dZOs4fwN4HB8X/G0VPXxZrgnMc0x5Ga4onFOyMvLWtEcb/N6ohMoqvV0gqcq9wN0fJ2fmAE0gwE
	7rdWGsW5NsOG/LiEnMTmG5cVfo79j6qZ0H9SXmiZ84JAS79gMHCoIsjASH7p5WylDBUnO4yvvg7
	kXV+L8VeouR0/5zulmw8=
X-Google-Smtp-Source: AGHT+IFacauxX6fYt2L3q4ncLFmdhtEd1P3U4Ayk/PVi6A3klEBV3DOfu6Q0j9cy7in7UkhQ2Ctr3Q==
X-Received: by 2002:a05:6a00:2d90:b0:736:4b85:ee05 with SMTP id d2e1a72fcca58-736aaa56dc6mr1100861b3a.11.1741297166908;
        Thu, 06 Mar 2025 13:39:26 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736982441c7sm1912823b3a.55.2025.03.06.13.39.25
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 13:39:26 -0800 (PST)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1tqIw6-00000009lRS-1ui7
	for fstests@vger.kernel.org;
	Fri, 07 Mar 2025 08:39:22 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1tqIw6-0000000FvrF-2d35
	for fstests@vger.kernel.org;
	Fri, 07 Mar 2025 08:39:22 +1100
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Subject: [PATCH 0/5] fstests: remove old SGI QE scripts
Date: Fri,  7 Mar 2025 08:34:45 +1100
Message-ID: <20250306213921.3769440-1-david@fromorbit.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi folks,

The scripts this patchset removes are historical relics. They
haven't been maintained, in many cases they don't work, and in a
couple fo cases they are reliant on test machines that SGI
decomissioned almost two decades ago.

There is no point in trying to maintain these scripts, but they
still create dependencies on common fstests code that is now getting
in the way of making changes to fstests infrastructure.

Hence we should simply remove them and get rid of all the technical
debt they contain with them.

-Dave.

