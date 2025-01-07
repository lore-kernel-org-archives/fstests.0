Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA51011CAF
	for <fstests@vger.kernel.org>; Tue,  7 Jan 2025 16:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736265984; cv=none; b=hYdEWjHfr7D7p2wJDKwvo3ugPv149faLVlT9f8QOdz94wCSb+O+nFmwnZEfE8zKO0VI2c4RSC3PhHaIRUFtP7kWF7W+CmIat42vxYPKso7/z5pgjSwD8AcB5hqT9EUgy0jguHaFsfRF0mxIs8VKnEo/KrJcznicoEJ8otTIQSCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736265984; c=relaxed/simple;
	bh=vraarPHM3ANcGus0tt/oXc3epKv3Zs2uJhKweocmVcM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y0MXt20ZAeb0eTOnTXVIdh+m83xw5xfMg0vK+yIRRXjh94BARzBEb57e8v5rotwwkx57MpjPGZraFJehiFWCccmorsWaLJW3X2ypBzvYraE9Xj17zeBG7n+CaM0lVcDVyQYqW8u7xN4C3LqSghBHp75Lk062lTyjJwbsHoDtnLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=yYszy43u; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="yYszy43u"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a8c7b02d68so123113215ab.3
        for <fstests@vger.kernel.org>; Tue, 07 Jan 2025 08:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1736265981; x=1736870781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JCcsTgHYFCgSl0Urdeikj8imfBxrBCaukutIK3dSYzw=;
        b=yYszy43udi1DFwhSBB8bxXgbZ0nmfneYY7WelhJAKvRY7IzBY9IRGd9TdiXR5/FKqI
         diRizetec7TEMB0AOfgDllsYKZ9aO0DWALzSLJKjSJ9KwvTkC0bE0wAmwTwJnxZWKsHX
         iFlniSUWVul4YOvfeLJwZfKg6aN7uRyfd7/x+7Q2RtMaMzqRJ2wqaUlD1AqN2/+sM8nK
         KQT1XACXVOvl2JnV1GofF/u2lJCQSwcR9OvebsyPKBFSCvURk27o0GhaaTnYUJma8+Xe
         Xgxl6q27k/FSZTF8Y9mIBwRpRS+1CqiWg2Vxm9aliJX7wjzJajfRJxwq5RrNY9lIjthU
         d5fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736265981; x=1736870781;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JCcsTgHYFCgSl0Urdeikj8imfBxrBCaukutIK3dSYzw=;
        b=XNcW7DCfvIx/vmPEwDeUouAT3K5Pf0aRzZDgWYzscSMY3RiNbu3RORNki8IecMg/2I
         IUsqMokhY7tk2jw8anezkWGdDc7YHRNGehL7bKdZ661768tKQJ1LAsMt6uqOWZNLjm5D
         2WGFS92xavkxv66ztKADoPWjM9CmE7fW8nCZG4Hiqdc+KJ1ul9Gdhy3Zcgg5eCvTN/OQ
         eLivF52UY2hbadW9RbBypnL4KVxtb0/dwrufGKcc90gnQfyp5jHVKL+WjvMplWTYIp9+
         LRIguyJeB4e3GVqhK9QnU68CajHQRStQLNB+cxPkk5r4kyAeC6S5utEv0/sdr3nksu6+
         xkBw==
X-Forwarded-Encrypted: i=1; AJvYcCWM+1lyow1lYm5tT2i7RzE8coKKOvOI69XRB//pLkki0EVlilIXlKeFNhQzVGF65kROx1tw0EgE@vger.kernel.org
X-Gm-Message-State: AOJu0YyqauqyhwomXjhlt4fRrsqY+Gk3jmS8JoGFyv5xHA6zidG+kXFE
	M62s2l6O+7MxHBpeaf1wb6qKFA02ROuG/a9vbITtKgq9EIw8ETT6OGvYe3ijNLjvXqazUcZJ3jH
	r
X-Gm-Gg: ASbGncueHrTaFMacl9W+BmX+bSFaDX+Xj7OKFRqdztZaIYB+SVeogXAndA8+lQDXSnK
	vncanwvLLcWy00MNfs+zHK3rIaut0AWZB1GAYtxj7stKSDlLCSCCHp2okqEfGp8T6Kpimx58vLi
	gboRYGxe4ZdwS6i0fIOZlYUvffLXFn6dFIWwMLZvW/4Si46k3QxShkxhzmHNoFvsSGgfFGkBgum
	LCSFcYo5n8TWI4lXcnOjCdRrvPogSwW572p/oPES8uZmujhbZhZDQg9ksk7
X-Google-Smtp-Source: AGHT+IH6rwH+iMUJAyI/gw+fJGUMMZfduKVoiKpA/gUBr6ddiUdPenNDIlQzbbBCLfpipFoBHBQkyw==
X-Received: by 2002:a92:ca47:0:b0:3a7:e701:bd0f with SMTP id e9e14a558f8ab-3c2d5b273d9mr526639065ab.21.1736265980919;
        Tue, 07 Jan 2025 08:06:20 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e68c22455csm9529955173.160.2025.01.07.08.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 08:06:20 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: zlang@kernel.org
Cc: djwong@kernel.org,
	fstests@vger.kernel.org
Subject: [PATCHSET v2 0/2] Add RWF_DONTCACHE support
Date: Tue,  7 Jan 2025 09:05:13 -0700
Message-ID: <20250107160617.222775-1-axboe@kernel.dk>
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

Since v1:
- Remove debug printf in fsx (Darrick)
- Disable DONTCACHE in fsstress if it fails with -EOPNOTSUPP

-- 
Jens Axboe

