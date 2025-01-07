Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA01019C54F
	for <fstests@vger.kernel.org>; Tue,  7 Jan 2025 02:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736217929; cv=none; b=XryVxKPMgAkAZgvK3C3WZko1InFWKV2nV0uDpN8L5NaStyetgb/P/ByX+LtWmgDIaUTv2xFkD2cvNF3cMnwiZPpbgMl1iuxK/m1TyXVB9/abD41Uc5/fGOUYBTYCoUM+K3si2k2YbZrrf/yoY3Af8nqUaCfvSyXnfj/uV7K62mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736217929; c=relaxed/simple;
	bh=GwqqC/XL0ZQrreNBUYCjvO35/oh0f49UocBRMzLayyY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=bGBn7Et8IhI32rOJSazbcy+j0/wl47t181Vrw2sc65kro8IJUduvJgq8CKmwC2dy5KCWkzT90I1SA6ep1E80878b9kqeQUo+Fkhq2W25B7tg27hOUCUrC3TX+QwnDNKm3Y8HwdbHZTfRJO4ms2MdfXoKjwwqmEGDJu9GE26sEw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ad/xD7e6; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ad/xD7e6"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aaeecbb7309so186154066b.0
        for <fstests@vger.kernel.org>; Mon, 06 Jan 2025 18:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736217923; x=1736822723; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0+Wl9KpXKHSFmNKUqWC8LFNRLrG+VpH7xwEJ8wEn98=;
        b=Ad/xD7e6apduJZebWh3jHmw1/VNWwCEYLvKRCYpkix7qGys3N39I7ZhAgIEodLjzwy
         nOcIkQ0qneqdlHHdAUCNN2fkWT0uyDe+guonjlwVsILg5tIXxJ5bhPW2kCCaHvKMeuU8
         5QkK+b0og6HPIMT93rZrIf3uQqF/pkMOYBBP8XPWwNHXBB3Q6U+m6POAfRzt8un4EKxK
         IfADko9xU1iVxf2it+PLl+0g/nnZMfAANG08HtSHTAQ/vAIz+J3k5jGaq0V1x2dKzQyd
         Q3ahnz1viiyWXiiNQBNgjq8FzWJ45cvc2KhcI9VjfhjQLeWEm7uT2nBTtOzjnUWHhLr4
         gLog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736217923; x=1736822723;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F0+Wl9KpXKHSFmNKUqWC8LFNRLrG+VpH7xwEJ8wEn98=;
        b=UaWOY5fWF9DYhsuYb8HLsiGVkiQnbYzg94wU5a+j5CyET0PNNwKTkYSjOevcXmkCLk
         PSlvALPUT5AbUVdh/Aa/X/86oPDenkpwdRyztgaLoYEXvF/t7ACepYohtawqKR0g++mW
         uwAKcgyRTCkXb1eq4eSMwnqwBou1fLf97mVcCjzlDpMll1lPtZ7k907VJQGw6VNt+CQL
         IOvJaEmxpbSZwImrpPC2qhuFWkYP6Ivr3GcL9DEkAQTd59FATpAnRCZd5NjDwH2HiPyb
         8+5yXRD92vt/kZacbelrqDqURgoCsPNXP307840OKRBSrVYl3eKLz3SAu0KrqB/XZZZ7
         Av+A==
X-Gm-Message-State: AOJu0YzFxriCex9zEcDci2pbrBX5TjTNV3zChu4xUBNpcCAqSdMMxj+p
	WQ12/ZS+wofkwHB4EbPhWHkhjvqeXeBeqRC6spGdsYqCjqIUa/FjgylZuGBg1p0=
X-Gm-Gg: ASbGnctDhwpptEfLpaj5hZxg8cbwTr19nHIAJjJg8qYEWD9BwjhCMJbsdYS7zgfPaLT
	85v22BE9eOmNmOWIWFNrcAYQbHxexl2L+8zleToXn9HoXb74Z9SqshHfoMGiUAmTUkHMHPc5tHq
	zOlEZDb3QGl2++9JdaLaG7D+KFTSjwkVGj8yashEwgFf6/xVJCYjGKx9HGqzD+QgSzWHa5duI42
	2dZe4rQ8gnHi2vA9NQAhGh0PAvlEqDvnZ3qoOKHWeTfyyBV5eTUEchvzuE=
X-Google-Smtp-Source: AGHT+IGpZU8Q8czntxu/EcGQkulwxUxwK0jj2h3ltb1dV7Ksvme1Oezp6veKXUsnLngsysuVPQDFXw==
X-Received: by 2002:a17:907:6092:b0:aab:c35e:509b with SMTP id a640c23a62f3a-aac3378bee1mr4924027666b.55.1736217922798;
        Mon, 06 Jan 2025 18:45:22 -0800 (PST)
Received: from smtpclient.apple ([23.247.139.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8f90b9sm32125994b3a.131.2025.01.06.18.45.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jan 2025 18:45:22 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [PATCH] generic/620: add '-J block64' mkfs option for ocfs2
From: Glass Su <glass.su@suse.com>
In-Reply-To: <20250107033901.5da29524.ddiss@suse.de>
Date: Tue, 7 Jan 2025 10:45:08 +0800
Cc: fstests@vger.kernel.org,
 ocfs2-devel@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <0B21E83A-FD77-4A05-A70E-A580F84EC8D1@suse.com>
References: <20250106140104.91880-1-glass.su@suse.com>
 <20250107033901.5da29524.ddiss@suse.de>
To: David Disseldorp <ddiss@suse.de>
X-Mailer: Apple Mail (2.3826.200.121)



> On Jan 7, 2025, at 00:39, David Disseldorp <ddiss@suse.de> wrote:
>=20
> Hi,
>=20
> On Mon,  6 Jan 2025 22:01:04 +0800, Su Yue wrote:
>=20
>> mkfs.ocfs2 is using 32bit journal as default.
>> For 16T size device support, '-J block64' should be used.
>>=20
>> Signed-off-by: Su Yue <glass.su@suse.com>
>> ---
>> tests/generic/620 | 3 +++
>> 1 file changed, 3 insertions(+)
>>=20
>> diff --git a/tests/generic/620 b/tests/generic/620
>> index 3f1ce45a55fd..60e5a2cacdda 100755
>> --- a/tests/generic/620
>> +++ b/tests/generic/620
>> @@ -41,6 +41,9 @@ sectors=3D$((2*1024*1024*1024*17))
>> chunk_size=3D128
>>=20
>> _dmhugedisk_init $sectors $chunk_size
>> +
>> +[ "$FSTYP" =3D "ocfs2"  ] && MKFS_OPTIONS=3D"$MKFS_OPTIONS -J =
block64"
>=20
> Makes sense, although as Christoph mentioned, a less test-specific
> approach might be a better. E.g. _require_scratch_16T_support could =
skip

My brain is clearer after one night sleep. As Christoph said,  I think =
it=E2=80=99s problem of mkfs.ocfs2.
Let me drop this patch. Thanks for  your review.

=E2=80=94=20
Su
> if block64 isn't configured, similar to ext4 (assuming tunefs.ocfs2
> provides a way to query for it, which I don't see at first glance).
>=20
> Cheers, David

