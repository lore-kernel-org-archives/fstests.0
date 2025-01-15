Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6BC29A5
	for <fstests@vger.kernel.org>; Wed, 15 Jan 2025 06:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736920986; cv=none; b=P/K32bDnCwkbduIg9w4hIbu2FdNWGJWW2uRoBySxWT9g8JZLJX7SpKJNj8KCEYq3qHGfGHI0FKSHFGzZrOqIwvQF2uxNuTmyL2pGeBATnBs0RSHJdvoBimkXFWWB3NtfLXU1G78yYPVDcbIRKvtruq3wun3OPHU/6kuX3ltTCz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736920986; c=relaxed/simple;
	bh=BsfddY/j3PfhwCK21NHqkpY2oH9kfQQUrFOmKNXdt6U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=SWDy9dNsZfLbbB7PbkOglFS63F65DYhCNVwklz0uJ5Ec0/RdljUS5p8W1NeyVD2Cz4wQejxioXWmB/qQINQtSw3h8Vtd6VZy03aeZGgUuvJtIIftEpSICnRfiUCbwaO1mONVTjX5jQhCW9qtqUZC4ol4xPJ4gjsd4qCsqRZKzOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=IrEKpTGe; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="IrEKpTGe"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2161eb95317so112854275ad.1
        for <fstests@vger.kernel.org>; Tue, 14 Jan 2025 22:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1736920984; x=1737525784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dIxOYFi79X7da8AS9xowwIfJN/lRVbczFjdYcFw+PFo=;
        b=IrEKpTGe8RRZ30joVpZHn0KwlNjMEQKnOgCSg7X1b+ZStWGNvJ7UovAje3LAD5C9+y
         GoMT0oK0VtiJJxwYOeeGNIvFmKDIIs29sAso0XRm44KiIsMz/gfV8AYO7j7CEWNS2eUr
         UFTzwE0SD3kMDVULkXvTC2FcuxfO28qOiidUd0pe+6w4CL8q3N/QaBylUNYg/A6Tmhxh
         BZdV9nqoo3vR+HyB2BiOH62MCr7W38tDvpOBPm6s4Rvmu/DL7NvFPK1fzKjDoO1ODbgi
         HIS+RvL26qBQHUUsCDKmR6/zJF8hCiW4WnfjKr92VFKWCjjxxyqwAMd9sYmNnXJhB7sz
         2vhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736920984; x=1737525784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dIxOYFi79X7da8AS9xowwIfJN/lRVbczFjdYcFw+PFo=;
        b=GY1IZoEC1+a/rugOT9SrtpRduYmgopjGfZ1gjoHtEG31Os7+aQa3PUlOQGQqCUCl6b
         UmoojunGcmt7HnFoseAUlHlrS22XC354IwgFB3A5L+QAsE9Nutn4V8GstxIgEucZ2kvT
         ukK9Z9YpsBes/pBOztGlaab5fSGeYpjYyfZ3QQWv4F2f4J893OH7uVJU4fHr+RheEZIR
         bGMW746wBjDwimJZgl1wMM0lq38+aKLM4Rhzm1/LSVqza8+MXMDnRheIxbJccyxh4mtG
         xjy3L9NYD9VPKsOlOqrlCWBkPsstssLVctJHDERJc81dHLND1TyAhVz0ajSeWuiwMkSo
         cDOw==
X-Gm-Message-State: AOJu0YwKLfJTu89wgbzjD3f9FOYGI/2m9KJxzukmfF2vFFtB/sV9oJ61
	0rdIAiM88SgFyLA0113z7L44ARHgAOP/Dn7A3rGK7sJqlu2NtWtZ+uCJIVil/NLRSuSMAIR92xF
	J
X-Gm-Gg: ASbGncv2bXYEKYKY1pj15F1ya3MOwEt/Dqq7mpZcEX9GBdGs03y8qNeMNAFeMl4xl47
	6E0+nu9O30X1mVQbwTc28GRiYsDphrmFmftfFQ7BFjddKrtK5wZWGr2aYE/ajzdFhGlQHSZv3xR
	7H7nhabJoUdAIlyKNj7vFY5DAIBO3ZUqVKfDb2th5lLIrVLLuQyrWNH7yE+tiyzXOmH9lCa/pPO
	h0GCTQAJU2BRo7sno72QdSJ8pQm2uqPhbNHrFEOS4xUPRrVduWoJQNmG32XzcJhz6HQ76NO5eXd
	m0AncHtkyqNDCOJAhxs+P7coC8VGf5A=
X-Google-Smtp-Source: AGHT+IFIheKK0oglsiiFhIPJFfuV0gpjSqnIoEr+Hbzw49wjUTkFj+q+NS0+WrcDJ5jsRJtZ11+K+g==
X-Received: by 2002:a05:6a00:2908:b0:71e:1722:d019 with SMTP id d2e1a72fcca58-72d21ffd1f8mr35840577b3a.22.1736920983618;
        Tue, 14 Jan 2025 22:03:03 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d406a94b8sm8321517b3a.167.2025.01.14.22.03.03
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 22:03:03 -0800 (PST)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1tXwUW-0000000641T-1OU0
	for fstests@vger.kernel.org;
	Wed, 15 Jan 2025 17:03:00 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1tXwUW-0000000GabF-27tG
	for fstests@vger.kernel.org;
	Wed, 15 Jan 2025 17:03:00 +1100
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Subject: [PATCH 0/5]: CLI and feature improvements for check-parallel
Date: Wed, 15 Jan 2025 16:51:11 +1100
Message-ID: <20250115060258.3951185-1-david@fromorbit.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi folks,

This patchset brings some new functionality to check-parallel to
make it easier to run across different machines and filesystems.
The patch seti adds these features:

- auto-adjusts concurrency for the machine it is running on.
- adds CLI support of selection of tests. These CLI parameters are
  identical to the check CLI parameters and the test lists are built
  using the same code.
- adds support for logwrites devices so that all the test that use
  dm-logwrites are now enabled
- adds support for specifying the initial filesystem type to test
  on the CLI. This makes it easy to select xfs, btrfs, ext4, etc as
  the target filesystem type that is to be tested.
- Only block device based filesystems can be used with
  check-parallel, and this is now enforced at FSTYP selection time.

For example, testing the rw group on ext4 is now a simple matter of
adding the "-f ext4" parameter to the command line like so:

$ time sudo ./check-parallel -D /mnt/xfs -f ext4 -g rw -x dump
Runner 12 Failures:  ext4/308
Runner 1 Failures:  generic/095
Runner 21 Failures:  generic/042
Runner 51 Failures:  generic/627
Runner 8 Failures:  generic/032
Runner 13 Failures:  generic/019
Runner 34 Failures:  generic/347
.....

Options like exclude files, groups and lists also work natively in
check-parallel now, same as they do in check...

-Dave.
