Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1214DDB34
	for <fstests@vger.kernel.org>; Mon, 12 Oct 2026 19:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791833469; cv=pass; b=hB6i602ubp1Ij8o2SrrfWnFUQ4M9KJBSRQwqBEYjXJ4oCe1VzJvO8bpl5VLxO/CvHmL+XviVMrbUXX4vxA0Bu/VNcqZIYmGAX1TGCqQ2JHwK8YFFTjXu8VdHSa+wv4mbLaRlYJMWmkY/vDnkZhLUNoRTmhoCKlHIaFzmouGLEF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791833469; c=relaxed/simple;
	bh=UWZZBLyZ+VSfhXVwwRvNM+3CfiTI5wGiS6Q9uL+aiRc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=rou0Q8C/LafGlrOVQfV+k1tsG4MU1nD94NufGtAMyxH7F2aUuoYYE52RzIrEmgptxwl1oF9j+OJPiHRjj3W90jOLmJ5QGY831kvnTxzDRlxRmKaHAKgAu1Zta9nFIxPGjc+bbbbjqh/ShFZBAezc9mQ4XUU79e9OQM216c21zKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=studiomoob.com; spf=pass smtp.mailfrom=studiomoob.com; dkim=pass (2048-bit key) header.d=studiomoob-com.20251104.gappssmtp.com header.i=@studiomoob-com.20251104.gappssmtp.com header.b=ZCbpde6K; arc=pass smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=studiomoob.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=studiomoob.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=studiomoob-com.20251104.gappssmtp.com header.i=@studiomoob-com.20251104.gappssmtp.com header.b="ZCbpde6K"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-93e6eb77f0bso221339185a.3
        for <fstests@vger.kernel.org>; Mon, 12 Oct 2026 12:31:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791833466; cv=none;
        d=google.com; s=arc-20260327;
        b=kgPLIqpEcB/wfU5Bzm1exDYZJeL5fR+hY2RZNbqa/lK8Nb//7oJilmp4HJJ7RUW1Zr
         YqcXjpmv5rFDWAkjnvms/yo1jg6qhN9JsNNkGTUm7MtkW1WAn2Ivum1teLrwo3zSOJnv
         6Fj+23hBHPjPoLpfp9GdJWlLMDIb3/HO1ALdiAtt7MmrG7hK24OTo3uvHOICfUkuaVo/
         Q8PSqk67ZOlbaFlt5/hq8V7pDciQvk0rYom5XwOfB5A53c+KzhyQwFJe5WcebXkYJuLk
         CImRBbCK1oVLaNtuKLccdO1QvLtoDz1dob7CWwYaOF5cye14QCRyqyMMYPjhJiN3X1XP
         p59w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=UWZZBLyZ+VSfhXVwwRvNM+3CfiTI5wGiS6Q9uL+aiRc=;
        fh=LUArN5kVDuxOv1TXPbEsJAmf0QFQu3CTW7xsNKmCec0=;
        b=IGMrYM1RyO43WJ4UKodCvho9Nm2OUV0LFHrCJHg3jTs4N3hrz3vreoIW+/rp3GAY5o
         2IIByVEO34OQscA9xuy8hIEIc7JVPWvzg5/dBdl2TQ3rhrx7whwq2GgHALDQ5gt6LD6m
         AqWABRSh9N+UifILlmTmPH/SvVEJUUYWo4usSyAXbXqAPK5IdAh10f4R+zCIfqvaOlCZ
         KXa/XMmo76b8kV51CPdURai644O6+WEjuQBryBsbjDf/zxMCpuMgbW55tfMu0Ner1w0F
         j2R4aceyoIER+9A44YgqyAx/ARcP8tMlJui7bnob0IyduIvRoqcXhlYX67WqLFaqFZrE
         ovfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=studiomoob-com.20251104.gappssmtp.com; s=20251104; t=1791833466; x=1792438266; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UWZZBLyZ+VSfhXVwwRvNM+3CfiTI5wGiS6Q9uL+aiRc=;
        b=ZCbpde6KnYbM3Kdwz+u9Jn7DVbNEx74gFXRMWUNVlYolyyRJlxHIv/L7Y+jwXK/RDe
         FjuYD4eCtPD36j33mQhKycvHhqVenhFr1+ZiAJkLDxYxLH4KDwpjTFHrvtCX26dd1fYb
         MeBv+GXkZUm2MyFBwjpHxdod0EwPnabnVk+jGrx22t2NdHHd08LMqt78dL3ph7Fo5r9E
         XoN6cRlddJwjPcTSBslPq+DuzbH4+Mt+ByNw50Ve/1iLee4dnjbTPF0qWB5jt4qjnuqj
         bv1ZCjguzUuKnXCMu4TEQEhRUzi2uJRNTPBx0545zp5PY8LYIo7cLcOdERn5eAUdQgLk
         CV5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791833466; x=1792438266;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UWZZBLyZ+VSfhXVwwRvNM+3CfiTI5wGiS6Q9uL+aiRc=;
        b=JwIFIzkoHXUFzxsjxm9Bf8iZ6bKARumHJBHXLNvtpR01KBes8CxeGkG5MJJEnxP/NI
         J32waYaYUxZtQzIze172Eb8i9/mQpC6ALWi7iN6bCGGh/X+ssc79lV/4AiFemfMmdqar
         gwWwIhBQIMUFetP3ADfZv5XOYCO2t3qb5L2LbxuosDGk/vEmMMeHb/1L635JV9caM4Nl
         vth6Ct4CdpbWqJGHaLo8F4jvrVlHISYJQVXpRUX1r2KY0viu2TFAKG4jfXXgh3OhNsmK
         xzXABPyG5sIpy6qlASRsEEO3V7IdxkM36WiwV4djAMu2KnTzozLMOtASHmgyoPOiPfGI
         Wkzg==
X-Gm-Message-State: AFq9FYIDs/jyqrSEJYYsSIUWxrnKKxAJfDbXBaaNllBIzTDF4eqVymWz
	6dz4TdX8lWn+D0GNZxBmWVbyPoHKbQAWYowrVMICDQ6/qhVRhoxRZv2Nmwv53Qirk2HL+nsY7qz
	VrllHItgB0HgTgrgI4RDJ4/Jr2oa89na3tGmFWWnpBib/QJPuHq6hOAo=
X-Gm-Gg: AYBFou2W93jwKP2RyDkXWguO296RTUcd0Yi5RwklIrYhJc+xK4Hn1q9X33aYefGT5jH
	1Lotu3qqPNLNeo4uE0y/j7Rlo/FZWsPv80S8lL1f7EygWl7GitvCa3eHtD/hzkS7qLWBBlY7DhU
	HVjs7j7P8c+TeVnwRs+TbTec7WA711vYdO+15yOv1Jdo4BYuIVT/Vq6ub4jJor56gFyFDUUkFn+
	PsgXm+XKmxHC+ih8kQMQI/wbRyQRtPpvdXHk/kZz4sT/6mTlHXifyvcq2gCD/4yialct5wU+dCR
	qB2/kPN6SDhm3Yz+3gVZ/R4hXChDnArcf+jltx+uneI+f7MTKFF6uop4/+MB/iTCCNzNlYFv0dt
	tILE2A0dZJnmjE6b+Jkv0cIk=
X-Received: by 2002:a05:620a:461e:b0:937:6de8:b40 with SMTP id
 af79cd13be357-93ebd1b713amr1862713285a.15.1791833466531; Mon, 12 Oct 2026
 12:31:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Cl=C3=A1udio_Fernando_Pinto?= <claudio@studiomoob.com>
Date: Mon, 12 Oct 2026 16:30:55 -0300
X-Gm-Features: AclHuK9yrPN9wVoFGswgkpiw6XVDK_RujVPjwfzNgAwJVHkjNMgV7LWKfxs9nJw
Message-ID: <CACU5Mh-+Br5Haf=h+bihpF4qBuS0WmaFZW3zsBBc+PXG+ZB0=g@mail.gmail.com>
Subject: =?UTF-8?Q?Thank_you_=E2=80=94_fsx_and_log=2Dwrites_in_MoobFS=27s_test_su?=
	=?UTF-8?Q?ite?=
To: fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello fstests maintainers,

I maintain MoobFS (https://github.com/studiomoob/llmoobfs), an
experimental, GPL-2.0 Linux kernel layer that stacks over ext4, btrfs
or XFS and gives LLM-agent memories typed attributes and an in-kernel
query.

We vendor fsx and the log-writes replay tool from xfstests, unmodified
at pinned commits: fsx runs on every lower filesystem in our test
suite, and the dm-log-writes replay is one of our power-loss acceptance
gates. Thank you to everyone who maintains them.

We list every work and project we relied on, with verified citations,
at https://github.com/studiomoob/llmoobfs/blob/main/docs/references.md
Nothing is needed from you; if you ever have comments or see something
we got wrong, they are very welcome.

Best regards,
Claudio
studiomoob - https://github.com/studiomoob/llmoobfs


--=20
Cl=C3=A1udio Fernando Pinto
claudio@studiomoob.com
www.studiomoob.com @studiomoob
