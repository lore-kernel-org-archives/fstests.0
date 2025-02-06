Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FB81D61A1
	for <fstests@vger.kernel.org>; Thu,  6 Feb 2025 21:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738876914; cv=none; b=Z5fnEWZ5NcVbdhtjXU/w52F3pcwtm1dqV7QfuYSFlkB0ITgznF2vvc1bCiRvh8wMwjK5i1Jyhk+6BbsEaia90YWzBftsY6U0ltSivDpQNg30e7nm6AhSnfSypS7zwjT86nz6prZkT0dKFFgoe+wfVFxrXz9esh/5SXbWiMmpNuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738876914; c=relaxed/simple;
	bh=9QbvR/uxLOgPbJcsmItCxCMB8rTjDpdqY3cAnUnu5/c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Dre5LbgzJJ2ok6rS9YRGPimzdPCIVpbb0s1+Jozi2LOqT8msgumFIIEE6hiIB68j89DIP5jizJEMAZ920k0tM1fst4EbsSpQa3wJwDnGpxvjj3Yhk+noiwcVcitQaO38kFkcAIzjlNSzQRUf2ZxJZNmzCYYKM1mCODiF4qNnz9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wdwc7dcL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wdwc7dcL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738876911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9QbvR/uxLOgPbJcsmItCxCMB8rTjDpdqY3cAnUnu5/c=;
	b=Wdwc7dcL7PpUvscOPLwe0wpjbVLqDFcQaB2oAcR+m6sbTgetAvclTmjptPSZZuCGTZ8afD
	5wbLn+LqJBn4ozBtNoJzoRYY7ZIOpHOIMI6S6+1wStcypdnAWyLHJ9TEG2FvxCMAuXo0x7
	QXq+L5kpqqIPpoQt796hFR0cWcVk8cE=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-A9yKML53M16S0Oq7yHKs6w-1; Thu, 06 Feb 2025 16:21:49 -0500
X-MC-Unique: A9yKML53M16S0Oq7yHKs6w-1
X-Mimecast-MFC-AGG-ID: A9yKML53M16S0Oq7yHKs6w
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3cfb20d74b5so10806635ab.3
        for <fstests@vger.kernel.org>; Thu, 06 Feb 2025 13:21:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738876908; x=1739481708;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9QbvR/uxLOgPbJcsmItCxCMB8rTjDpdqY3cAnUnu5/c=;
        b=V5ohDEbeA8kfITMeY7qV8jDuyLCARhUW1BJ+j0zyRi6Iy8ouyjFrHm4E3bicPUKgDJ
         xxEpBey1MWooWHWve4KSViJGThAg0JzEAKvaxGiiEpw6vcGlXrp757Z1B8T45Z5HLdwf
         uYILnzlPbpQARFEBU+79xW7Yd/v9qU2Uhlehjy7x/gXXIZBye1ufRiuoit4bXHzh7dLf
         ezoDLIsot9w1cBtOrElEL+fip1dNetiktp+49XLCykBb40z+Hq/1FvE33SkXXASyC63Q
         X0sE71rcL+nh2PeUzjJ/ARACYW+PvJr/85wtdcAEjbx4+CuRRMxdL4DEqu704WlXRkn0
         isLg==
X-Gm-Message-State: AOJu0YyR0FiqRMeBWD/aFKaR067u2QSBf15yswzf6G3XpOfVPRX69E2a
	tb00EOG00/kbfuXMRPuS9jbzrp+mDMxzG2URfoA5Dl2wyfa9RxQQpp8fFGTSPJdAs2+vEKYpjx8
	fPsozhIv3g1GC50N9S8D50NbHVChKmpNoVp1ZF+v0O/nu4OhNBEMsX/9qlr68xus/SkjMksNy9Q
	7/jApHyxsQ7BOWTdytrSOoY/ootI5D1tT4GTFQm1O+
X-Gm-Gg: ASbGncuY9JdgiGQaLOTcXbeG3kkH6EdJpYSJAZrHhJYLdNnsIJ1loYZ7nFYFyGhXhmX
	QO3zF0kb3YgxNeCv7P6007INZ+OZWyU7TDcOG1neoTDuITopDYMkeDPqnV33Kqi756g097FHa6g
	DlD6RebFI7RChcrdiQgivaALwEGnzIpxEYaeFeWbH4byqYz40sZmQGUXmKm5uWQdeD+iecoKGZN
	2TpVditIGsHgJKEk2bwbLADV9JT2sDNDyMV/bdbL13eS8LSUq/h0UbBfteBUDwWAoUgnMfa6wbq
	7o4RhNXGSbv9g3OO+pi+5Tz4Iascgnpg6ivYuSrTmupFs7VESBcsCQ==
X-Received: by 2002:a92:ca4d:0:b0:3d0:258e:4841 with SMTP id e9e14a558f8ab-3d13df7faa7mr5148865ab.21.1738876908313;
        Thu, 06 Feb 2025 13:21:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQHPkzpnX8wApRoQErR4flGfcnD6inn1Jx0nmQNfuzCFckU3pGcz9kZf6yfgfPigp/XOmncg==
X-Received: by 2002:a92:ca4d:0:b0:3d0:258e:4841 with SMTP id e9e14a558f8ab-3d13df7faa7mr5148695ab.21.1738876907940;
        Thu, 06 Feb 2025 13:21:47 -0800 (PST)
Received: from fedora-rawhide.sandeen.net (97-116-166-216.mpls.qwest.net. [97.116.166.216])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4eccf9afe8bsm435133173.6.2025.02.06.13.21.47
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 13:21:47 -0800 (PST)
From: Eric Sandeen <sandeen@redhat.com>
To: fstests@vger.kernel.org
Subject: [PATCH 0/7] fstests: enable sparse checking & fix fallout
Date: Thu,  6 Feb 2025 15:19:55 -0600
Message-ID: <20250206212145.7732-1-sandeen@redhat.com>
X-Mailer: git-send-email 2.48.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After the endian bug last week, hch asked whether we should enable
sparse checking in xfstests.

This does so, in the same manner as the kernel and xfsprogs,i.e.
make C=1 or make C=2.

The rest of the patches fix most of the warnings that showed up
for me after that.

Thanks,
-Eric

