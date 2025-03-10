Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E015A22FF42
	for <fstests@vger.kernel.org>; Mon, 10 Mar 2025 18:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741631402; cv=none; b=sECgP0K+5ZyAhO8ok4PaklaAIhqtQsUe+uc9YNj5c9bYO9dLQnC+Qgz/F3GI0XYmr/q+32fQSY0NQYaw5uKmu4zFYFMtm2M7dYV38W9t/meCFjlKfUMpfeHZ2B2hJyVoLWLcVTU2p9EyZOR1VEtkiVYeME75gF+UrgvWtu3Wm5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741631402; c=relaxed/simple;
	bh=7y0Q/j9iCRl2+mqFtCWtChEKc0LpE5n6jMul94tXZuA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LdIe+FUV5OrplAeTIBDg1inVhSgW5hElMw+AAyfRhAVf7cB4gOVoFkHzeexFZuk8aujMgte5XwvAK8mXYKsKD/cfxDe29uw3OIkSmhvmT+qySzKdXvHs2rn2MneM2dk6Gl88wCfnrnb5HjJ0CvCNjIteZZOJPKYemrKupLFgD/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=edFTw174; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="edFTw174"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741631399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7y0Q/j9iCRl2+mqFtCWtChEKc0LpE5n6jMul94tXZuA=;
	b=edFTw174JGnKM8Sz1HT+PlDrZCI3KygkGJ2/Dr8AJxQn571urpNM1g3PWDxNfQKqg4MCbr
	n8EEA7dZKY+BPxriOdVGk6h8q8mvsQ0kyIOIU3FcRYU7y96C3kKO4yo57oiq5pRmFql7S+
	nE30hPl3Y/pKK7Vz61UJDT6yBXzVJjU=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-F0DiiMF3OPelgsUB0KfgGg-1; Mon, 10 Mar 2025 14:29:58 -0400
X-MC-Unique: F0DiiMF3OPelgsUB0KfgGg-1
X-Mimecast-MFC-AGG-ID: F0DiiMF3OPelgsUB0KfgGg_1741631398
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d4423d0c49so32793905ab.0
        for <fstests@vger.kernel.org>; Mon, 10 Mar 2025 11:29:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741631397; x=1742236197;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7y0Q/j9iCRl2+mqFtCWtChEKc0LpE5n6jMul94tXZuA=;
        b=dK4A1Z2dggdKT/rUuBWVU0VPgLiGUbwhz/I1Tre4ulRES3nD9LKpB4719OjmWcwUV/
         MCb08GJagQyKi4kAnu8PuyKsgHBSSGtvLobKqjNp84ZvQ7mrMfqb5rwmI4saXy88VFoA
         5ab2ucayxiB82ojaKGZSMtSDQqPSqTSkbO9Xpsj+Y4vsXQMmIQ2DFaJYtvxNcjc9BQgF
         /V8TJELiSlIfExLcE0wD9FKJWFIckl82ha3lM7LTK1kUzOliUMvUEzfMIMvvp8Xy04EZ
         UHp8iNq2ng5RbG2lJcS/ut9zRrLPuUgMJiP5GUCNylFeJpKBNIhmyfdE/C/zmiT8U64u
         1ggw==
X-Gm-Message-State: AOJu0YzpwgykSyaSSzpLVabK1lXiJrpz+7nMB5mY/FHFVIVlR40MZ6MW
	PpYsvQtoAE+VkXS3JNsKnMf+AmL9Zel7A0AJxu/8YRTcNzfoVvBnqiQWWK1H7CPRJDCt4y83XdV
	7Cnh45prsmsgY9RkwPWfWwyTISYz447v873rSHGNqNqkiuJTf80yQj/luHOJjrXuVg9NN8YUQtO
	o8wt0GsrJfLUmLyf180/IOsSI1EGekfOkdByB5iFMD
X-Gm-Gg: ASbGnctxKXng/qGv5EPiV1EwDuMJ3Ihm59EKTzOZhqyM9+JwkZc+lN39CuS2Mn262P8
	ez33VjYHnTexQzd1ukMRR36FE42LA5h6caMIT94ONcw5COWmSciZKWgdJ1LPbAyY2iWklhqZymr
	T/3PSo6p3QHgUmDQjesxmgv8aHlAtznTdFq6ALZh0WrBw7WdW7+kb3qNEU382Q8fPXW+duk35JU
	RNBrGNYe9Cg3piO1sOAAaX7QwnX+gS3Mw2NbnPxq0FueCDnUC2mjswNxrdH5jxcHtLlH7LG1Uoa
	A54PocmO1dHcTXkk5ajvPmHTTFL8sWk=
X-Received: by 2002:a05:6e02:11:b0:3d1:79a1:5b85 with SMTP id e9e14a558f8ab-3d441a470aemr214253565ab.21.1741631397502;
        Mon, 10 Mar 2025 11:29:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHn6JoUBTQYM9l+y+RMWoR5Ii08XpxmR7SaIwv7Ko5NADgFXUpK0JzACL9QBE8nACgNnN+JOg==
X-Received: by 2002:a05:6e02:11:b0:3d1:79a1:5b85 with SMTP id e9e14a558f8ab-3d441a470aemr214253355ab.21.1741631397166;
        Mon, 10 Mar 2025 11:29:57 -0700 (PDT)
Received: from fedora-rawhide.sandeen.net ([65.128.97.82])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f222ee2efdsm1587512173.13.2025.03.10.11.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 11:29:56 -0700 (PDT)
From: Eric Sandeen <sandeen@redhat.com>
To: fstests@vger.kernel.org
Cc: djwong@kernel.org,
	hch@infradead.org
Subject: [PATCH 0/7 V2] fstests: enable sparse checking & fix fallout
Date: Mon, 10 Mar 2025 13:29:02 -0500
Message-ID: <20250310182954.1396724-1-sandeen@redhat.com>
X-Mailer: git-send-email 2.48.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This does so, in the same manner as the kernel and xfsprogs,i.e.
make C=1 or make C=2.

The rest of the patches fix most of the warnings that showed up
for me after that.

V2: Rather than -Dlinux in builddefs, switch all #ifdef linux
to #ifdef __linux__ which hch says is preferred now (Patch 2)

Otherwise unchanged, with RVB: added to patches 1,3-7

Thanks,
-Eric

