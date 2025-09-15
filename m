Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6172927280E
	for <fstests@vger.kernel.org>; Mon, 15 Sep 2025 10:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757930702; cv=none; b=NIk5eMcZVioWJ3D/oAOBEoCkRy1ViFlHGecB3SMBFnBlpvouuar1Lx+oHTtH3c15ki5dVhcMUJOIVqZ3YK5PSQp+7TKhaSo9eSJws0GHPoVAdwpw0AggYC+J+WBE/bgYIMnMkzVTImmYlv/FWoOqCbNZcAIqwYKfqmbESjglcn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757930702; c=relaxed/simple;
	bh=ROv61u4RivAwiehYKIDUfgLbFHnW3do/dxpUjoF/Hmk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VCaOjp2HEMkoBRvFwPlUBXp5IQD2BCYMVWWSyjobBYXs8LzUT7/lyI+Of8qx6neH7I//79bNiP0buN93hr6kaPbPWyD3XvTnS4s3+OiVDPFbwbKYcqW+nuP459fTlHnDkixUlVyLu0N362Rz21Olo9C1zqn/CfK7PRzjUOon8P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jprusakowski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OUVJnEbd; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jprusakowski.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OUVJnEbd"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-aff0df4c4abso560905466b.1
        for <fstests@vger.kernel.org>; Mon, 15 Sep 2025 03:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757930699; x=1758535499; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DvfUW+7ZBYUS2Y3if1wlcE68XU5a59WQYlTWSUQ9KYU=;
        b=OUVJnEbdPdqEWUs/95AR8rpDeosbBqvGHGjWLuJ+2astRt4DLTnqsM9Y0ADO7S+j+t
         ZSTtiXqpd5kqarIbZFNI9F7/IzOaab0FoDdww2zdZrRQBNbqdsDzbrPVi77aKolTNuFc
         /MZ7awJGGA4GHg4Kt/JLy0TCS/L/VxyQtwhbFtGbqgGPI118brUsA6X6YvwQ1Zn+xG2F
         bU5uaTQNwCKOvFBrplVv08kwY2RU1HYXaVZJtTijyejrjF4X7k6IdsU7XFFDAn8rXuIh
         E8SZHA2UBUwAPCimvv06aaYI9OwNx4aOers17gJJGYLKIo7tKqeGxtDUaDVWMtyEWEL2
         gv8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757930699; x=1758535499;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DvfUW+7ZBYUS2Y3if1wlcE68XU5a59WQYlTWSUQ9KYU=;
        b=aTYhsHWa88gkXdOMz4mUni2IorgeZJbLSiNvlKdHGpb5LkW6DpnUH7X6xJebaqBraG
         8bx9IoFartmdSdXaWB2yNG5HY8YmGCRwSY/XxuEg05c6Rcr6R1b0T1vfX1J5UG3Yxwhq
         L7xZaiUnra9hF4lLRcN55RLryN8+1YSww3jGaXGildMTrVAiQfsWW4KArQAt5M3DWehh
         7RH79F585PYKjsS/2QnZZjEUB28bLAyw+VGYGW2TNQx/xe45d/S4/ij+MiSX9wa3F7RN
         vKDjhc7t0SkiIsn8k42meph6iKd5Jf1PiUjcao/GKLkQddM8u8tkecH6nGNMaPaO+uPM
         JCxw==
X-Forwarded-Encrypted: i=1; AJvYcCVpGgGOJifJglWSskNUCyH23TIOfpxmzbNzgCqgag45FSS+DNtbbtZegdVNYqdwGcemwARsRdck@vger.kernel.org
X-Gm-Message-State: AOJu0YxwTAWz7gdpqI4rLgkDn9B33xqMckjuPpJKo6fBNuQLswWVCQPa
	upVm33VH7RY1wtGpa1+uqdeihWsdqUsx/wOZM2Ce+4PlbvhPLOp40JdbgUDfT/gZ/8GA2vqf+Nc
	aQpXelcv27vBsCWhIesR4ekJwt2sOTQ==
X-Google-Smtp-Source: AGHT+IFFtovcE+hpCdmo0WK6KIxOmWxwnFMcROyx7lU+m1pPt7HBZEJ6WYvb3h1UGWc888U5BmO9y2Fh9j56p74N860=
X-Received: from edaa19.prod.google.com ([2002:a05:6402:24d3:b0:62f:5354:86ae])
 (user=jprusakowski job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:278f:b0:62f:26f8:fea0 with SMTP id 4fb4d7f45d1cf-62f26f91103mr4556197a12.33.1757930698573;
 Mon, 15 Sep 2025 03:04:58 -0700 (PDT)
Date: Mon, 15 Sep 2025 12:04:50 +0200
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250915100451.810719-1-jprusakowski@google.com>
Subject: [PATCH v2 0/1] Do not run _verify_ciphertext_for_encryption_policy on
 compressed FS
From: Jan Prusakowski <jprusakowski@google.com>
To: Zorro Lang <zlang@kernel.org>, Chao Yu <chao@kernel.org>, fstests@vger.kernel.org
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	Eric Biggers <ebiggers@google.com>, Jan Prusakowski <jprusakowski@google.com>
Content-Type: text/plain; charset="UTF-8"

Changes in v2: (Thanks to Eric for the review)
- Instead of disabling the test entirely when file compression is used
  we now ensure that compression of the test file is disabled.

Jan Prusakowski (1):
  common/encrypt: Do not run _verify_ciphertext_for_encryption_policy on
    compressed FS

 common/encrypt | 7 +++++++
 1 file changed, 7 insertions(+)

-- 
2.51.0.384.g4c02a37b29-goog

