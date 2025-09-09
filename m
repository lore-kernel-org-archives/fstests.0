Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948D823E356
	for <fstests@vger.kernel.org>; Tue,  9 Sep 2025 15:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757431361; cv=none; b=kHLSPAdVmOgLf2Te1uYE5UAU6gZ84P1yppVfGueE9QfQo7uiFgKlVFA4Dj6XDZocdwTBG160Yqo3MzQ53Pf+/xLBQTOvpxZC1uNMSuMLrGxFcqm/lHCgMyDJ/o81+cqiDPkVhYVwMJMfushlCKa70Hoj/aIpvPippF2HCH3wT5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757431361; c=relaxed/simple;
	bh=QEXhxovWYUHVgBkEl/gTdcNOIaqUcKQWivj1PPJZ8ak=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Af57L+vRopwmrWKmxFTtsTKZ8ZGxvXBuxTgouvG5RalOM/fjY87XKpdtX5BWpxuDSAcqT2neYzGEXcQDf3bxd25FCXPXEv9bHFk329FrD+8PY1lQaq3328T5gb4zxS5m02TYuuB3/PB80IHVv2zDhU4LHqkhAOnbGIfVG4IXoaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FxOCgdeI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FxOCgdeI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757431358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=z+VJfc5dyu/GsDQ2jOZqvhe7ZEO+uEqdgkyy6rtOglw=;
	b=FxOCgdeIDHe2cOeNNFAHI1IoHzw/aiW+7JFOq2gOletUVdYbS3qtbeYs+M0j2J34cgUjYF
	gyDecw/DYrZKtYu7cDJkrZlK3MezG/LkPofbohvymbYpc0Wyp9LkY2dleEKIwa0YE9AP/O
	jjIse3w24MhT6tQ8vfCDnPnLzfLyk+8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-ZSCpbtT1MA6ehlP-fE6T6Q-1; Tue, 09 Sep 2025 11:22:36 -0400
X-MC-Unique: ZSCpbtT1MA6ehlP-fE6T6Q-1
X-Mimecast-MFC-AGG-ID: ZSCpbtT1MA6ehlP-fE6T6Q_1757431356
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3e2055ce8b7so2131649f8f.0
        for <fstests@vger.kernel.org>; Tue, 09 Sep 2025 08:22:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757431355; x=1758036155;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z+VJfc5dyu/GsDQ2jOZqvhe7ZEO+uEqdgkyy6rtOglw=;
        b=P+Y9op3UAdPaHQRNInaUuVnlpjZSbgLZyvCzG/9LaS8dM1WON9s1f7yoeXtsXpth+L
         YR84abqi/GdRuOktDgykeaBRXEqhxiw8vFtmPepdBgEnbQhphQNFw89+THa3Z8VuuNmQ
         9QBvDapEG8tUWogjqxe8pWCs9b7df5L7/rnoTJBQxVJad3ze1V+Ls5NAMwmpNrZeF7NL
         Pfbgk7Km2qh0auyJWOxkSAzYFxIkk/xa4hiY8WLoj7t1huMpBBYaX95oBlGB83eV3ccc
         GNGmRMR1oYv8mhJFxv71DiOt5EU8jrZvEM5N61D8uI/KdIhOyPDqzarWSqZ4cm1iZnp3
         TlHA==
X-Forwarded-Encrypted: i=1; AJvYcCVYDIWAEvRSmi2u/iA6A6CZ6jQCw4lhPXdr2luJLjz5jdogGRL/vYZcMa3VkETABnQhK1umPGCP@vger.kernel.org
X-Gm-Message-State: AOJu0YyiT1Vwdr8EodYai3WQ6kcsEbJbPrueDTuRLKgEO9kcCz1ctcB9
	TLtOYbAiYoUKoAb82xFzdcJpuM3v/g5JQbTRAgWryXFV6DIxYMC2iKAVT/9FtMxevWED/70P8GX
	WJABCAoxruXaZbYuAobzO7nv2tbxqUfWScrP/MG7ShQzdko0EpQFz9pK4pg==
X-Gm-Gg: ASbGncu7MoE9U5gXE0Fd7ofgvi/o1krhOFhbebGnjdYMSB7faMoHGvvuGntE2YtAhXQ
	czBjUCjgf/ixOAzF47YYuiXbMWOy7XD/elcFfndu/t6rgKeW3KKUNUtV8ULPMCRHmX72rkRWNYA
	AqqgTf5+T+8iWLQMmeISNJo93dnR4vWGbj/YXqm3KbEQPrJ5EDY/yDZYjf3shyorxM7/QZ6yWvr
	otU/sK0RjQqlgMNl/3Ak4yV1EyLLCOSfZtocePKKZr9qOGDxaWVWkw2XkbxKjVy2F8j93os4bEF
	ROwtSDQTvt9gHKAC6tiXqJDsA2Bp0FwQ
X-Received: by 2002:a05:6000:2dc4:b0:3c8:6b76:2ee9 with SMTP id ffacd0b85a97d-3e641a60df9mr9697504f8f.19.1757431355570;
        Tue, 09 Sep 2025 08:22:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFe+xRxRQCkMmtxwSoqIUZRLPvVS5q6Y6mHlK4cZ6jPSpPnLLyRBNTHyPyXEqUm7yVvcmuEvA==
X-Received: by 2002:a05:6000:2dc4:b0:3c8:6b76:2ee9 with SMTP id ffacd0b85a97d-3e641a60df9mr9697489f8f.19.1757431355195;
        Tue, 09 Sep 2025 08:22:35 -0700 (PDT)
Received: from thinky ([91.245.205.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45de24ab648sm127055765e9.5.2025.09.09.08.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 08:22:34 -0700 (PDT)
Date: Tue, 9 Sep 2025 17:22:34 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	fstests@vger.kernel.org
Subject: Tests for file_getattr()/file_setattr() and xfsprogs update
Message-ID: <mqtzaalalgezpwfwmvrajiecz5y64mhs6h6pcghoq2hwkshcze@mxiscu7g7s32>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

This two patchsets are update to xfsprogs to utilize recently added
file_getattr() and file_setattr() syscalls.

The second patchset adds two tests to fstests, one generic one on
these syscals and second one is for XFS's original usecase for these
syscalls (projects quotas).

-- 
- Andrey

