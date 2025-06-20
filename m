Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300EA2376F5
	for <fstests@vger.kernel.org>; Fri, 20 Jun 2025 08:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750408160; cv=none; b=pp0SlJmUGTk1pfpKwqbYjs0fKx5Gj0a5pcQFs/41rlv+QUj+trSR4VVpCxP0UoFx8rJr7hqq1f2+8OvWLBqHmo/mpZEl7UO2y5sYRtW+74jPzmMC4EAAxQL1HSMkjX+oIvePrLOJWuC8hsqymFCYls28elI5ZGgdtOKlSB979kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750408160; c=relaxed/simple;
	bh=UI3t4czgjH+DmJLWHS1BpDVc7fTq0Tbhmv/b6yJB658=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=g525DMuR3xwnd+AciK5i3koPvnXO5J5NkaatW4JstTVAPQk0zrv4cFiF886WAgXQ2onQC3DJnIR2tt1yBaSf308XteB3Ag9RrYTpj4ul8G//Yqz4uQRqVrCBXQY91lntBzKB8Jrt6ihtFQzfeOQLyLk8t6K077Y7Yi4zp5F9+A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jprusakowski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0OJ33gDD; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jprusakowski.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0OJ33gDD"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-ade6db50b98so169341266b.0
        for <fstests@vger.kernel.org>; Fri, 20 Jun 2025 01:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750408157; x=1751012957; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UaCdObgSH6WxlhEDS7jc2D5S2sYItdP4GSFStF8K+oc=;
        b=0OJ33gDDILPPRM87IPWv9gx3P4YyFMCrou1tewu4TordKaYI5jTjV5PHRt3l2Em4PU
         pN6WYIQJmDy4k+i17x3Ny11efYfkuI0PZ9m2CZ+4040dRayO1CSVartUNWfuN1C3c1dn
         pStU34zGWB+Q2A45+3Md+90yyyR4M8er/z73reP7cRRWRPoS6zUGAOHE/x5GM5tVjP+t
         cYymKzUsTlWK8Oj4+mX7x4toY0hIL9nVGk1KRBnAg577rjsB4/4N6EdRtqX/sFIRxcPF
         6WvRzD7kslfmwljt4F5qVTMauuI8V6lpWl4uDgN0pauQrByz22IYNun2S4pWqpMpbHcd
         77Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750408157; x=1751012957;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UaCdObgSH6WxlhEDS7jc2D5S2sYItdP4GSFStF8K+oc=;
        b=rd5eryUbFqlQGO65jCsDgJByV1pbzT0NA556I4aY3KjL3qeD29XbBKLRN//i+UK/r+
         4OkTeIk5f4/k/7jtHrxo2S2MDkKACLnPqjZnkq5ZLUm4zOeWMK3KLzfLR03FDBxEp50O
         cIzCDH7DnqRLLmGUzP5sJ9XEJ6xKpYntxdUv7Hm1HSY+dNOacYpSXF+XLaAQeb14F9a+
         oWBPuBzuYTDu9oNIYzHI9sgpUJo1l7ADLNYvjIG3dPLp91KAgdtU7Jx76VRUu5MDmSXZ
         YBV9PpS/fAAUd1psFDAFjnY9D0XbeIGddSBLL8pmIftjb0EL6scKTDclM4MxjNoldfNb
         SfkA==
X-Forwarded-Encrypted: i=1; AJvYcCU9dKEOs9nfflsZE55cIR4R+awq7gH3TJSDTn7XXTZSIXy0F0N7QOf+AbsbxklK+ZvwfK52aZ5L@vger.kernel.org
X-Gm-Message-State: AOJu0YwcYd5SomexJwfHs4O1TgQQqr6m5a6IVfwWEGuAXulpuPp44G6W
	QkdLjs0OXBpz+ICiNMb+yB2whR14kE+tbBV7tfqNP0hCc1/LiSogj1NNV3+Q3gzWPvI9uV0Xef/
	BtmeQzFyDQR/TL2KorGpR16zmX+dDKQ==
X-Google-Smtp-Source: AGHT+IEA/m7L+UmZdOFrJWXH2xK6bnxzXkBEmJIcQUnEt9BcKM3MHaSoEO21ixMJDykHp1KjQ3nsAEwApbDiH40LTTc=
X-Received: from edik12.prod.google.com ([2002:a50:cb8c:0:b0:608:ab44:efff])
 (user=jprusakowski job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:ae47:b0:ae0:3391:f068 with SMTP id a640c23a62f3a-ae057d4eb0cmr136491766b.19.1750408157514;
 Fri, 20 Jun 2025 01:29:17 -0700 (PDT)
Date: Fri, 20 Jun 2025 08:29:05 +0000
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
Message-ID: <20250620082906.2122560-1-jprusakowski@google.com>
Subject: [PATCH v1 0/1] generic/018: do not run the test if a compressed
 filesystem is used
From: Jan Prusakowski <jprusakowski@google.com>
To: Zorro Lang <zlang@kernel.org>, Chao Yu <chao@kernel.org>, fstests@vger.kernel.org
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	Jan Prusakowski <jprusakowski@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

We're testing F2FS internally and when we use a compressed file system we
see the test generic/018 fail consistently. It looks like this is due to
fiemap not supporting compressed extents correctly:

    [...]
    defrag /vdc/fragfile.9981 in region[0, 40960]
    /vdc/fragfile.9981:
        0: [0..31]: 2682968..2682999
        1: [32..63]: 2682976..2683007
        2: [64..79]: 2682984..2682999
    Failed to adequately defragment file

We'd like to disable the test when the file system uses compression. Please
check the following patch.

Please let me know your thoughts on this.

Kind regards,
Jan


Jan Prusakowski (1):
  generic/018: do not run the test if a compressed filesystem is used

 tests/generic/018 | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.50.0.rc2.701.gf1e915cc24-goog

