Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689F419C553
	for <fstests@vger.kernel.org>; Mon, 20 Oct 2025 13:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760968557; cv=none; b=dOLNyxD8axexEG4UhDSXQf52RvrrvuUge1mst7VBSKCMT+gatnVmeDqp2P/JYZ322gVAhhmWLlM6xhpfHh0y+pum1TDM4fYkWXfEr+u6MlH8w3EO1q2mtfWiRu9VXT/NAEkPGMXOFFxwibJ7lBt3FTUVA8JrZ7ciWSIcCBcknoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760968557; c=relaxed/simple;
	bh=GmbQ2jXhDm7vy2iDgaO/7OoZbduITFdgv011FhLwyA4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DFNkE3FJ5Nvv0mCg+uRHARgLaoF3fdHgxLe2QBSChRt5xR7Grm64OTtaBjWkx81ErS8drDP0ob+Y4kSNp/f+FGX+YwnV/eQJKhfQ6tT2WqotHM6YxHGxQZ+pTMO575ka/ftOgldG8OvthlL0hNNQfCc14dwWppTy75u6BqwpXAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YcjF8J/f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YcjF8J/f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760968554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6J67v77z2C8c8cpDHO3kHr83huPFvvnav5l9yd83eE4=;
	b=YcjF8J/fJ2H+BeTUgSmHHypjqFusSPUA5VECLYgaAhTis2g39/2jAhW24rAqyedNQ4NR3n
	CHx3qcN+jqPAf/Ov8W9yOtPVp++LOQEg21KCZHFZuucpbjgjF/OAskZM3s5QCDjv0U+t3K
	UMfwq5VnhEm42WKoCreZP26T1aVH3kc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-QOJ0ntXPOaitaTgYiAyYZg-1; Mon, 20 Oct 2025 09:55:52 -0400
X-MC-Unique: QOJ0ntXPOaitaTgYiAyYZg-1
X-Mimecast-MFC-AGG-ID: QOJ0ntXPOaitaTgYiAyYZg_1760968552
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e4cb3e4deso16010415e9.1
        for <fstests@vger.kernel.org>; Mon, 20 Oct 2025 06:55:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760968551; x=1761573351;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6J67v77z2C8c8cpDHO3kHr83huPFvvnav5l9yd83eE4=;
        b=GWq7VNX+UcWRHRgmcGHOH9rdy0QtGoEU0S8EFCUeRy1ogyIBmHEOfEZlOy76Dxvmcc
         5fwovJTqEtJ5sh5IVfw8UUhy30AKlLA83KxjT3RZnI+JAOS496vyu8LEq50uJwaB44q0
         PE688Oi5ff1h+Zna5JlOEfN63krJoC6Is8L6iROo8Us7QE7BiUt0VEZvpQR8T/WfHfio
         +RzeihMM5oQlFLs7JHRVlt+YflPDYO5OOneJkVIC54AzCv/5TzlRRCJK2wXNUSvl74jB
         yaAwO7Mf+s+JPOspC4cEixK5XXRzmlM8SwKZI5v4a0Y9e4nlzGOPlHeF427iWvnN85XU
         1pkw==
X-Forwarded-Encrypted: i=1; AJvYcCWFaBu2IHer46jmWjAZK3eZDkBih6+q+I9uxelxg+21/MM2niBuCPWRw4C3w57XdyZoptdYNVjp@vger.kernel.org
X-Gm-Message-State: AOJu0YzlMpLHSfjDFK5B0MeCJC+jEIcqIGnXX3U+Tgie54Dfz5+3p9Gu
	ZQbBsD2sd6nVwas6RHERbZPkEmnPWs/HqPd9li7idXtyKrnAss4whLrFj0SjHeUlZKxgRFe4w/F
	2tA2OuTbecwaq0j54aowY2ZHpxF+AsREIUjXn2ad7hH18a/Q5EWlaQtYH9QVszMY1ug==
X-Gm-Gg: ASbGncvl2+ipWjHVmcYLMJxLPOKUlEA8vJ3cy+xQ0nNwL5C+jpElVppunE9wd1JsFN8
	PDuO8xxWlm0ymZJpvntgebwZ3/Qg0gXNFbNhSH6ndefRSrR2/IstOIRgcbNsiJi681e/vWtRU9g
	K072wEiJnGfBrKX88hEwIZ2BGiW1qttO7InefwcE7/TK6dMaE0EDWOoH3rAJ5C0OvSG/eZW1+ja
	9TsiLBYvZdOTUUll+BhGRJxHfIirUT+9dfNWvUcWKRYirrWlsG3aJi40kgMV3URTX5LlpCvILdI
	ubQm0joDnQZrcvw/seyA0UGHTxmU11XLsQX4HUpn4N15zeoipi8Waloiwt5KSsoZysjF7IZxwBz
	54hp4pORES1M333wfzXh8YkN4UxXuoVllHg==
X-Received: by 2002:a05:600c:8183:b0:45f:29eb:2148 with SMTP id 5b1f17b1804b1-4711724e5bcmr97818375e9.7.1760968551385;
        Mon, 20 Oct 2025 06:55:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoNeNjAOEFjzezPaRjRgxNsc3TH8pxblhe4oKdUeogy3uxUDDRaVGenIo3sbIkIFY6QuXKhQ==
X-Received: by 2002:a05:600c:8183:b0:45f:29eb:2148 with SMTP id 5b1f17b1804b1-4711724e5bcmr97818105e9.7.1760968550781;
        Mon, 20 Oct 2025 06:55:50 -0700 (PDT)
Received: from thinky.redhat.com (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47152959b55sm151404645e9.6.2025.10.20.06.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 06:55:50 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
To: linux-xfs@vger.kernel.org,
	fstests@vger.kernel.org
Cc: djwong@kernel.org,
	zlang@redhat.com,
	Andrey Albershteyn <aalbersh@kernel.org>
Subject: [PATCH 0/3] generic/772: split and fix
Date: Mon, 20 Oct 2025 15:55:27 +0200
Message-ID: <20251020135530.1391193-1-aalbersh@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This one add one missed file attribute flag (n). Then, the check for
file_getattr/file_setattr on regular and special files is lifted to the
common/ for futher test splitting. The generic/772 is split into two
tests one for regular files and one for special files.

This one based on top of Darrick's "random fixes" patchset [1]

To: fstests@vger.kernel.org
Cc: linux-xfs@vger.kernel.org
Cc: zlang@redhat.com
Cc: djwong@kernel.org

[1]: https://lore.kernel.org/fstests/176054617853.2391029.10911105763476647916.stgit@frogsfrogsfrogs/T/#t

Andrey Albershteyn (3):
  common/filter: add missing file attribute
  generic/772: require filesystem to support file_[g|s]etattr
  generic/772: split this test into 772 and 773 for regular and special
    files

 common/filter         |  2 +-
 common/rc             | 32 +++++++++++++++++
 tests/generic/772     | 41 ++-------------------
 tests/generic/772.out | 14 --------
 tests/generic/773     | 84 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/773.out | 20 +++++++++++
 tests/xfs/648         |  7 ++--
 7 files changed, 142 insertions(+), 58 deletions(-)
 create mode 100755 tests/generic/773
 create mode 100644 tests/generic/773.out

-- 
2.50.1

