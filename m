Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DEC8F5C
	for <fstests@vger.kernel.org>; Tue, 13 May 2025 05:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747112488; cv=none; b=GZSOPpdaoKo9j3qj/wBbOFi6A864LhY7KvEVU4m4bSI2tio1HuOkkG4Iz51uGji9bT/Tvizh3qr//86UgN0WSFY1yjLJs2gAyQbZOtuOhGYKMkvggYZzafzhpAHZqQ2zF3WGXXI63hek4mN8+xtJb5WEUszrY/IAX9TGs9jEmaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747112488; c=relaxed/simple;
	bh=LLhB9DJoVIrHfc32PpK750Mk3TSOxKWWPlLObR1gJAU=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=Pkievi27tERJ3WPRl8ezlsE0wOzjQ+pLWBjAb55CI47yV8hIXkbBAIls2tZpf1LKZuJmZK1lpp7yYTXOuXxCvvgEMl9qN1FmgZjUxY5nEwdJLh6xWYZkI42aWZLlhVJkMkkTfI5GUm2Q4fDkI1XmUx8cL78Wa5+pHDN26Ir5xnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kKgnn6Ln; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKgnn6Ln"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2d0920ce388so2704284fac.0
        for <fstests@vger.kernel.org>; Mon, 12 May 2025 22:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747112486; x=1747717286; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=igthEGHXr8o/mXK09jD+sScyXDFn+/Amne0ueFvtr8U=;
        b=kKgnn6Ln/Km7kPrnNCftFSh4nE36tEU8knY/Gku/1OzVMLCz9zgzlBNPPW/rR7B2vh
         vmipInAqMy9EKIMBGYv1ba/w9hfiXnkzj6SdkCAnbmt1cOTKgNlFu888S/lDMlaCbY1f
         s3XTBNEJ6biylgzrVmnQkMee/JoFZ7FgedbTuBJ/OdRhAC6BcE/i0+8Y9fDHfJR0uZ9f
         LuVGSNlsYxInDVIna0GOObCTa+g83Th4bbAh2VNym4G6FXadi2QCAZPcH9PiDRqO5Uyd
         m9DwTnQJtyWoOhJ+JaQBg63QV+wQ1Wy8AJGT9tfy2ZtnR2HtcYEbisuDqbu7Iw3JdjpH
         ywfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747112486; x=1747717286;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=igthEGHXr8o/mXK09jD+sScyXDFn+/Amne0ueFvtr8U=;
        b=hmcKdh7Rnl0RDkq8a3SHwNBavnl5moWFkVQZ+nAmVoLJ+0yAKRafv/cKd5t1uuLxhk
         ysMvr/1IRrfMMW/AaiGMSJMMsBagLzcNhtmXN/uCUw5zmvJM/gRzMbh0/h2j8eKLrTuj
         S9SARPNDkTBuzHc5Pq6fizTrEqCTZeTGlZF54qSKpOuOHqa4hZrjQMThq0tuX6lKCIrQ
         kpzES3jT51bAJRzoxQx2taneYhK8vUrees1JIU/CHep51C4qVQazgnV+FI8zfq/lJxTI
         pR7yjCiUTh7SspkZCdnnDCAOvKvypufHCBgqKpD2jnJo0iQpWKG849YCBBseFtWHx9Wt
         1hmA==
X-Forwarded-Encrypted: i=1; AJvYcCVeNcIqKr60oYWiQknE10gWJTz7RyZ7K/GwtlUDnl3G1W6j56N6dWTI92pnApIaGKu873RPH9Jf@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7f1O5rVcvoDaedXqusl8uB5KA1+Oys26MNbVgtigofU0vXIRn
	qaICbbirQJGwQURQAzIXxXr06woh9FzU+rIqKlRsXtDbetabEIZe
X-Gm-Gg: ASbGncvY6LwdsfMm1bwjbWkKI+q4seKWumI75vKS8Sxw1W0ydtCKnEMRMttGNuaaIWO
	igcsykhUkyKDdX+4ei5gjDslJ0uY6GO8DT7ExBbY5LIPPS+GXMY+RGc/F3A0QA/4Ugx8i4EkOBW
	s9kSXkB1dSiTMBJcDI7NhqplmqsCtvT62AiecpBDgiGa8oDA3wNHHSKV3HBot2CWP5O+p8I54A5
	i8AgBqSF++mtU3sA9PPBl1HTsfu+j8FOugIy4hHQBmSuo8BKFL88NazS8LyAwJUuT2Fj/nfy2PZ
	HaODXvu9f00slnUXk8aUS2OLQG/McWbglI10Nno8fyEpZ1Bke64RaeXReJrXmEi4M3CwEGDFP08
	sZBHha6P0B+8N
X-Google-Smtp-Source: AGHT+IFSnldnKwHJf9msT1ygua1yzLRyreThi1JW253rDXZDWTsBG01rKQGHUUTPUT9mSGW+OO6XhA==
X-Received: by 2002:a05:6870:9114:b0:2b7:d3f1:dc72 with SMTP id 586e51a60fabf-2dba44cf72cmr10376219fac.29.1747112485606;
        Mon, 12 May 2025 22:01:25 -0700 (PDT)
Received: from smtpclient.apple ([2600:1700:3ec8:dd30:f837:792c:d08:e70c])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2dba0797479sm2166243fac.21.2025.05.12.22.01.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 22:01:25 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Leah <leah.rumancik@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] selftest: add a test that flakes
Date: Mon, 12 May 2025 22:01:11 -0700
Message-Id: <C7DC357D-55CC-4B29-8DF8-DAFC9B205F78@gmail.com>
References: <20250513034746.omeueunfdx7asgpp@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
 Nirjhar Roy <nirjhar.roy.lists@gmail.com>, fstests@vger.kernel.org
In-Reply-To: <20250513034746.omeueunfdx7asgpp@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
To: Lang Zorro <zlang@redhat.com>
X-Mailer: iPhone Mail (22E252)

Great! Thanks everyone!

- leah

> On May 12, 2025, at 8:47=E2=80=AFPM, Zorro Lang <zlang@redhat.com> wrote:
>=20
> =EF=BB=BFOn Mon, May 12, 2025 at 08:19:49AM -0700, Darrick J. Wong wrote:
>>> On Mon, May 12, 2025 at 07:32:15PM +0530, Nirjhar Roy (IBM) wrote:
>>> On Fri, 2025-05-09 at 17:42 -0700, Leah Rumancik wrote:
>>>> Add selftest/007 which should fail about half of the time.
>>>=20
>>> I have already posted something similar[1] a couple of months back. It g=
ot an approval didn't get
>>> picked up.
>>> [1] https://lore.kernel.org/all/20250113164639.GG1251194@frogsfrogsfrogs=
/
>>=20
>> Aha, I /was/ thinking "Gee , haven't I reviewed this before?"
>=20
> Oh, that patchset is marked with RFC, and most of patches aren't acked (ex=
cept
> the 1/5), so I didn't merge it and wait later updates.
>=20
>>=20
>> Zorro: any plans to merge
>> https://lore.kernel.org/all/03ba6c154c9e2cf3d68131b3af2ca12b96663d25.1736=
496620.git.nirjhar.roy.lists@gmail.com/ ?
>=20
> Sure, I'll pick up that single patch to merge at first, as it's gotten eno=
ugh
> acks :)
>=20
> Thanks,
> Zorro
>=20
>>=20
>> --D
>>=20
>>> --NR
>>>>=20
>>>> Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
>>>> ---
>>>> tests/selftest/007     | 14 ++++++++++++++
>>>> tests/selftest/007.out |  3 +++
>>>> 2 files changed, 17 insertions(+)
>>>> create mode 100755 tests/selftest/007
>>>> create mode 100644 tests/selftest/007.out
>>>>=20
>>>> diff --git a/tests/selftest/007 b/tests/selftest/007
>>>> new file mode 100755
>>>> index 00000000..0e983b37
>>>> --- /dev/null
>>>> +++ b/tests/selftest/007
>>>> @@ -0,0 +1,14 @@
>>>> +#! /bin/bash
>>>> +# SPDX-License-Identifier: GPL-2.0
>>>> +#
>>>> +# FS QA Test No. 007
>>>> +#
>>>> +# A test that flakes due to occasional output mismatch
>>>> +#
>>>> +. ./common/preamble
>>>> +_begin_fstest selftest
>>>> +
>>>> +echo "I am intentionally flaky"
>>>> +echo $((RANDOM % 2))
>>>> +status=3D0
>>>> +exit
>>>> diff --git a/tests/selftest/007.out b/tests/selftest/007.out
>>>> new file mode 100644
>>>> index 00000000..0b5e439a
>>>> --- /dev/null
>>>> +++ b/tests/selftest/007.out
>>>> @@ -0,0 +1,3 @@
>>>> +QA output created by 007
>>>> +I am intentionally flaky
>>>> +0
>>>=20
>>>=20
>>=20
>=20
