Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA2A3E7BA6
	for <fstests@vger.kernel.org>; Thu, 18 Jun 2026 10:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781777584; cv=none; b=hpuJJrM9WJ/sXVsAcYeF8twu+fyC4K+vv1eX0mr++SOc1sCD5GkzFhxrewRxv70lGA8iFzqpONO/VtUQygWsZ1mUrMeMthI5W046SmzJyw8tsExNMy7xHw//aUzXBp6ICR5Y5+ZV8cqgmEHijgA/IjDwZkAiR2aj78LytgaJRAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781777584; c=relaxed/simple;
	bh=Ek8NQg1KPtSH0kD/SJcZzwssAOfa4BS/6ucq88mx4y4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dPiF/yUz3xT9AYe4kPHLMp3pn4GUZ5ZXqinelP1541gulQVp0pahabOPNw2rAJ+GBaE3SifPR6hShqo4mSbfoCFEd+WTjrzY+tSvZK0YEOtqPlOto6Drf171ZWFwIS+MfHbewhg0JHsm7QeYnpeYlg7zRnk5wGiarhLIWWLNSV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=do2moQfk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cfhyW5ix; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="do2moQfk";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cfhyW5ix"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781777575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bVeLhPgXkRL9YuY380vyxTPxAt6EUze1B3shKhUzapA=;
	b=do2moQfkEi8QnuD203rd5MvRjnKPJWy0NvfcJStQzJjHXzHHPoNPV6upL64fXD6BvyjCaR
	tEaMcQwc9P7DQwgUWxBIobBmk2dGRnGXWZYhuuryj/5x4hSTMBR796Lkg2J7uTXCxiMa7+
	nvoF1NeUO1iXe89lTYO0nNxwIoLth+U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-5Xj6Ls_zNVOMv26q0X9L3w-1; Thu, 18 Jun 2026 06:12:54 -0400
X-MC-Unique: 5Xj6Ls_zNVOMv26q0X9L3w-1
X-Mimecast-MFC-AGG-ID: 5Xj6Ls_zNVOMv26q0X9L3w_1781777573
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490b0682d2fso5448485e9.0
        for <fstests@vger.kernel.org>; Thu, 18 Jun 2026 03:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781777573; x=1782382373; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bVeLhPgXkRL9YuY380vyxTPxAt6EUze1B3shKhUzapA=;
        b=cfhyW5ix5o57TlKMhoSH8KdPN9lqEBauSeh2XPQgb9AXfYEWYm7pKFtcUV3d5U1DKx
         +rMDwoshVgmWMNK77WnhudylwSBczToWrW1j1ynAb7W5kHp9/aAM75GUwpzTf5nxlbQ9
         9wrXix0vfBKesct+xuWxOaLZwBJEd0BL3MDDyIBtzHORez/z7xIwQzgjbRdl6Cv6guxh
         k6jsQbg7DRsEaRn1m3SuLVXyu9nJucD6VceYJns36SLLtvteTppB06F9hjkUwrb5caS+
         xjyHSMyo4657Xf/nx5GjruqB/X080GUTEtwGFabnSBB1hLiMZJdNU5Ctj9+71rGK+Dt7
         jhig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781777573; x=1782382373;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bVeLhPgXkRL9YuY380vyxTPxAt6EUze1B3shKhUzapA=;
        b=mHMVTuDnoRvKqD/fcfHOkxdXS++vntC0ZO97KJ+r2ncWxeuR9Dj73O2qYEmglLk9gP
         fOgBjZV7zF+gMRV+LRGBFgmFanFZ+25D9Op+HSBuXntfe9xSj6SpbYcHjsc+iSJ2Ez/N
         ilGgryu1JEKw1dpGRzucSQ1deDrY/3qKeojYYommOS3ZcAh4kAugxjNCxkVQ7BXNFfuU
         KA0jOrkXHWqVX14DYJtr1vgBzFIhEHDztZ2Fhf/D4q8e1wkFH9tp0FwR8baeJwHeKHx3
         xA3JD4MB1ZJ+BtOSPtC/DypD6eXLXcyO5E0z/cmcAgW/YQpzVKqwIUYe0qGlMuvtsQar
         P+4g==
X-Gm-Message-State: AOJu0YyLtxY4Xt9SWN+qoyxy1Hc0vAfG3dYOayTXRzomwUbR0NhnpXDP
	RkaetgGiQ6juLQL771grbiS0mAsGlqvSGafrPhVZDsOX/a5VyJbFeRhG5Dwza+bxePKM61huHKl
	0YjDbbFGeT1Y/ZncranzmuwyFpjdGIKP1zQEIX8qhlRpB5FemjjNRV7mt0Jr2h5Wb/bYLAyLBap
	oT7dsuTBDRhCR4bTSra3cjTWFdO6dqjWcA6XL8fJi1MyoW
X-Gm-Gg: AfdE7ckSMfAPE0boejsxPsJyk7ca7jceBRFP59uXmHzAK5rdEsslRk5EFPLjB+8OEwS
	dCoqWkC7ksyZbX4KkLzlN6LiSdHA0P344+QqXva/mCDujxkuyYoJQrFYqky3+TLMa2tL2Wr+Z3o
	w7UuD16QLyaFpfRRl05j2yr+IzhYGMx5JXyPHgOfH0ejbfJZCypqUPdoXaa9iDLQDHXFB1I4q7B
	8cnwHGG0A6m58pb+RMR2A5jXVAGolBJk0PJe+2We9qAOlTP6oYzHlWosibCbB5c8giKvcWqTAhJ
	+6UfAur/sw6vxXF/TKsprO/w0U65azuhNE1zey8O0FY5wWmRocvCON7hiBQsk2J1eDa8G4hmvBf
	HaliTeDBsYJ7t30vFi7n9jfyVWnz00AGfLnapNGhv9Ho=
X-Received: by 2002:a05:600c:1d12:b0:48a:f18:ece4 with SMTP id 5b1f17b1804b1-49238226374mr47726115e9.24.1781777573110;
        Thu, 18 Jun 2026 03:12:53 -0700 (PDT)
X-Received: by 2002:a05:600c:1d12:b0:48a:f18:ece4 with SMTP id 5b1f17b1804b1-49238226374mr47725485e9.24.1781777572613;
        Thu, 18 Jun 2026 03:12:52 -0700 (PDT)
Received: from 192.168.1.130 (cm-93-156-201-22.telecable.es. [93.156.201.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49230a96d14sm216388815e9.12.2026.06.18.03.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 03:12:52 -0700 (PDT)
From: German Maglione <gmaglione@redhat.com>
Subject: [PATCH 0/2] vfstest: fix tcore_acls() cleanup bug and missing
 _require_acls
Date: Thu, 18 Jun 2026 12:11:52 +0200
Message-Id: <20260618-xfstests-tcore-acls-fixes-v1-0-45a1aec1d99d@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGjEM2oC/x3LQQqAIBBA0avErBtQoaG6SrQQG2sgKhyJQLp70
 vLx+QWUk7DC2BRIfIvKeVTYtoGw+WNllKUanHFkyPb4RM2sWTGHMzH6sCtGeViRFtt5GihS56D
 +V+I/1H2a3/cDVquZmGsAAAA=
X-Change-ID: 20260618-xfstests-tcore-acls-fixes-6d15a696f652
To: fstests@vger.kernel.org
Cc: German Maglione <gmaglione@redhat.com>, brauner@kernel.org, 
 linux-fsdevel@vger.kernel.org, zlang@kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781777571; l=925;
 i=gmaglione@redhat.com; s=20260618; h=from:subject:message-id;
 bh=Ek8NQg1KPtSH0kD/SJcZzwssAOfa4BS/6ucq88mx4y4=;
 b=dQYQZ/QUachk/547w9dv7+oO3MVvDJABHn6RGE6Zd9kz5wz7kSZCpP+pCvICaU7fucbvMfO0s
 w5MqBCSgka3DG74/l6o3vKwas2VnbNXf9Y7lJuKFjQxAhGCRaBaiOBV
X-Developer-Key: i=gmaglione@redhat.com; a=ed25519;
 pk=EgoGsSGnVamWcruH9kiHxwzZf0dPTHHxIjd1Gigd+yo=

Hi,

Running xfstests over virtiofs I hit failures in generic/633, 644,
645, 656 and 696. Two issues in tcore_acls():

1) sys_umount2() only runs on the success path. When setfacl fails,
   the mount is left behind and every test after that fails with
   EEXIST.

2) generic/633 doesn't declare _require_acls, so it fails instead
   of being skipped on filesystems without ACL support.

Signed-off-by: German Maglione <gmaglione@redhat.com>
---
German Maglione (2):
      vfstest: move sys_umount2() to cleanup path in tcore_acls()
      generic/633: add _require_acls for tcore_acls() ACL dependency

 src/vfs/idmapped-mounts.c | 5 ++---
 tests/generic/633         | 1 +
 2 files changed, 3 insertions(+), 3 deletions(-)
---
base-commit: cac9fe2b8dc3e6dbc0c2383b9e3b4d3c1b9e7dd0
change-id: 20260618-xfstests-tcore-acls-fixes-6d15a696f652

Best regards,
-- 
German Maglione <gmaglione@redhat.com>

