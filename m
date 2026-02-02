Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D5E2FC871
	for <fstests@vger.kernel.org>; Mon,  2 Feb 2026 18:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770058481; cv=none; b=BbOq3JZ/sN71VcbBOwq2S0Rti0W7kUoTiAIXxC1H0F6mKgpqiqAmvz+qXvG/oKbUWDcLm3iGAlb17F/Vmm91A1gRMb1tsSCmF8G0UMKoRLnEX/J9d2JTzx5BJWI1TUqtiiqcz9wCoX8Lg/nd4y0f5MOvcZS66VjhHqFbz3R9bJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770058481; c=relaxed/simple;
	bh=mZ5D2zAzzm696U6VgwotZHk2BkZr+SZOTM12Qx/6SxQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hhyk6A6yfDU9IcyVW3ZE5X/CYev7p3CX2aV/4+N+LbyFSC0CNpjRD9ds8cr2nVGVj2BO346RCq3iINoNeabp4sKmRTZ8JfE0gLW40oo280pe/wmpwCtuO6A+/R3rBLfShvoCcx+Aok83xjBGvakBaNrqkxgiChotqPp3T603RJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K6xCRQNK; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6xCRQNK"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8c6aaf3cd62so527848685a.3
        for <fstests@vger.kernel.org>; Mon, 02 Feb 2026 10:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770058479; x=1770663279; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q8tbSGXqu9XCrGpKlDfgkmWVwXh725wrV1GItS9qDF0=;
        b=K6xCRQNKyf/T6P6kQ0dPFIZHiUp4oMXkQCKomOCQ1JWPqSr3KPGBXUy3Clh3ARgSxl
         fk3IZBg+NmZl0D2a/AFkGqvDViqz6LCZLmtIY0HgIOxlRv/D1q+iuVZNEWe/6B2YMOzY
         KN7Z+ymJyYm0YhZyXYVlPTQU7BJJZb7KbRptu0t9GpN6SSyNlYAfL+Rv62raD7eMS3a9
         ylhghI/a6KXu9m92E+iaTnKRnnUOSk3av3VEzwwdtAY3oaJmQw0WrJoO3n4uyOUvPYw8
         ftGagZdvwnnx4IZxThIistDk+Q/SNpwGrGOI7aXtM1sB1APAGhvB4YMtIZ19FW8wG63X
         eW5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770058479; x=1770663279;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q8tbSGXqu9XCrGpKlDfgkmWVwXh725wrV1GItS9qDF0=;
        b=Cjz6cM+kgr7YYTc1jAFrdesQ1P7wuOt7mv9bzqgfCP8W5zwzS0hralQVKv3qn4W4Da
         PqVGdbR3ObYzF9VrR91feSIe5tDDicVTOYrmje6c57sgk5rqR2qLTL5YV/03V+D7xNSy
         8fT1H6b4gJWFUOJxKwfpeZp1Nhhq6KwGKgUNKQltABBMfLulKABo0rQDzWSnw6RZhCTd
         4SWhJrWmb+wLw+i6bn56pUdOR0rZsWg17OpRNX/s0/cweUi3mvzPJwgPsof5lSu+H7Zm
         bg8hyIwioIPLjHnWDL3BCTCJSdhQGDuq9zGwv6Ix6yNhxd/z7oj4303Mr3BpEEgKYGHk
         Ak8w==
X-Forwarded-Encrypted: i=1; AJvYcCVXBMeNFbmfO/SZVeKEeGWZdiJ5J6gtPrj6jZs1uetORcUYsVnXv9vSQt/YhM5583926LIhlsfM@vger.kernel.org
X-Gm-Message-State: AOJu0YzknfWKhEFSi6BoDK2z21OymMYEEW/r0gQN9gkRf9dA2vKO5XDT
	iH0pMb/tgFPoUXhBmY5kagtNlemJikKJx5JEx9OwLOEWeRAwZFTaAKM12KFpXA==
X-Gm-Gg: AZuq6aIh2ZmW/0KwUUW1lvoOnwghIJyDWpNKoorZRFABYocmmKMH/3a3R7sdZ+0iDPZ
	+LxelqnU0/9DHZFNaZM1XUiKIn2cpxmwld50Q9x+TS9EqUaM1X7GyRrPltVbwcY7erfWONOYGTT
	ug/W12IdIuM5StUk53waeMwZvwrDDvK9+OhMXQOp9EV25sKCvEJQBB9saWMvzVQf4rC8qa7MnzJ
	vZBNwCSuqBkcjeTb4U72jlDjEmk0F15fei7VfZdTWU+bUCP1Oa9S/9ujYenxjITwCa7t+YW36K4
	jaB2KJzPe5PS/r0pCNo9vHwXQ8MJe9zvfLGM+sQCrvddjF9mh89BgUiVKb85d68YzwgNy/BZTyd
	Ni7yz4CyWSlFwSZUSC+HqVxCDGQDYl1gTHBI6EranQEBiqK0XsseCqQPvrJj3P/4WHNpmSkrxd0
	jc9DvkRo6jlCUXEz98USjOPDHf7DY+bqT7KHO0I2P0tKWU0zE83sXNEB6zdG9cmi9gZg==
X-Received: by 2002:a05:620a:488e:b0:8b1:8858:6ead with SMTP id af79cd13be357-8c9eb1fcf6amr1599350085a.11.1770058479006;
        Mon, 02 Feb 2026 10:54:39 -0800 (PST)
Received: from ?IPv6:2a01:e11:3:1ff0:fc63:7c50:c123:ffef? ([2a01:e11:3:1ff0:fc63:7c50:c123:ffef])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c713580985sm1258562285a.8.2026.02.02.10.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 10:54:38 -0800 (PST)
Message-ID: <35351364d83b76158db8d77f0ab2a1a7db27e335.camel@gmail.com>
Subject: Re: [PATCH] xfs/841: create a block device that must exist
From: Luca Di Maio <luca.dimaio1@gmail.com>
To: Christoph Hellwig <hch@lst.de>, zlang@kernel.org
Cc: djwong@kernel.org, linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Date: Mon, 02 Feb 2026 19:54:35 +0100
In-Reply-To: <20260202085701.343099-1-hch@lst.de>
References: <20260202085701.343099-1-hch@lst.de>
Autocrypt: addr=luca.dimaio1@gmail.com; prefer-encrypt=mutual;
 keydata=mQINBGGqRu4BEACybdvi9+LqKuWA/P9HW7+wzGtIbFL2PR/vgJZqLzAscGrJB3ZvpdT2h
 daDdjRX7Maod9EAZceZYl2YVLZ6Q54qhm1hlEp4Iw6/adryfzulrJPX39mvqpJNE6gSkatwUDekhC
 AJpBbpq2aB79wOF08++KofqNW1r0xMIQ/KVoPryE4jNL2y99bEvUpe4S9TEyWTwsv/I0nEIX4SMgf
 VmW9XY842p9Bj6lws5U2dENIU8OD3cgK4uhfueb/ggkYg/5ZcblIBdVY0xDiFCqyTDr8+TVK2Algr
 M+r5MDPUKQXpIxh+gD84PcX8VXDHsmZaWsZmdkryiZ5RFammebqoIdxLF0oqwgUpaA8Ed4hlPAzmd
 TdVjMwFo01IHzFkZvS0g90qVXTf1fTSVG4JZU2gAasKVl0VDh4yJlzK3c1rWueqISv6AiD+BA6sPu
 4zscdBckK6diftYINuGV6Bfw+v+2AFvjCq8isfCQPXY8XHTg+5lktGN6+45SUEghDpeacSM+G/q25
 qCLKbi6dzAtjCDeR8b6o0lRQ645/5fMU4CSyanfsf7YRkw2RqA6pRM3q/i4nlvznMLxR42iNc1BMY
 A3t1jv6RIEE36eke9Ube0p0TsEisGGYo4NTVO4RUeMeSG3waYfLB0eXHe9Ph/K0FrTBq6XE65KwRO
 Bwk0tB6lU0+jwARAQABtCVMdWNhIERpIE1haW8gPGx1Y2EuZGltYWlvMUBnbWFpbC5jb20+iQJOBB
 MBCgA4FiEECdpUF1+FXVXQxDERHMOHTl7ICj4FAmGqRu4CGwMFCwkIBwIGFQoJCAsCBBYCAwECHgE
 CF4AACgkQHMOHTl7ICj5gag/+JtIKsPwWRJWnnexbGS/gGaZ81GtZ4skW/UHhQqfc44//ntToy3uw
 2PFaPB+5WLlA/XAzpLBFjLD5ZscFtHW7/ICGxrBqB/Q6AULoz0zsDhJ8YmO68A5YYNkGCLbWzando
 vrY/GykUEMT1EsReaIHhLpL/+3jsXGyIsztFi6qkjfDsFT+306+llIhIxgY+ZI/B/wlI41BKmSae+
 5WOR4oZb080Famy/5hjx/Mi0AYu2A6cRpw2k+l2/u+aEvunmkgkgB186tA/JhoOPYQvT5xVQ5GYRu
 vcX1kHscYD+Tgx3DhkMS1XqZihH4UE9Ec6QeOJTWrK1czRFTJpTOgPAMmksMdgU8YKKHj0dafCNl3
 /2gld0Q2s5/tAGPpPuOPJf5GUtcOn1Qxr7Re2pyrQdcdr/jUdy1GVHAldzOZlBID3u0dTUGWLsPDA
 dvwGyiwdZiNgnHxTEWchpFo0mwi5S/3+sWcPWAJO2zEVfkqyNhmHSW5EBrwe9nhCT5uqF8dEKb4tf
 FxAAgPAiFfnLhweVxkPIvPK6/rIZo8F6t6qSXibbTIjdi9pLSDMY0m8u/fRZ06DsciFIfrWG1LXlu
 14mDpr4zQSUELe1RRU1NEfD87TyYehjPvEewM6bZlRJ4SLaWQFoRW3OKH7IN1ODUn7T9TIx1uuzs4
 4ViZ2BeR0ow9RQc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thanks Christoph

Reviewed-by: Luca Di Maio <luca.dimaio1@gmail.com>

On Mon, 2026-02-02 at 09:57 +0100, Christoph Hellwig wrote:
> This test currently creates a block device node for /dev/ram0,
> which isn't guaranteed to exist, and can thus cause the test to
> fail with:
>=20
> mkfs.xfs: cannot open $TEST_DIR/proto/blockdev: No such device or
> address
>=20
> Instead, create a node for the backing device for $TEST_DIR, which
> must
> exist.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> =C2=A0tests/xfs/841 | 5 ++++-
> =C2=A01 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/tests/xfs/841 b/tests/xfs/841
> index ee2368d4a746..ddb1b3bea104 100755
> --- a/tests/xfs/841
> +++ b/tests/xfs/841
> @@ -85,9 +85,12 @@ _create_proto_dir()
> =C2=A0	$here/src/af_unix "$PROTO_DIR/socket" 2> /dev/null || true
> =C2=A0
> =C2=A0	# Block device (requires root)
> -	mknod "$PROTO_DIR/blockdev" b 1 0 2> /dev/null || true
> +	# Uses the device for $TEST_DIR to ensure it always exists.
> +	mknod "$PROTO_DIR/blockdev" b $(stat -c '%Hd %Ld' $TEST_DIR)
> \
> +		2> /dev/null || true
> =C2=A0
> =C2=A0	# Character device (requires root)
> +	# Uses /dev/null, which should always exist
> =C2=A0	mknod "$PROTO_DIR/chardev" c 1 3 2> /dev/null || true
> =C2=A0}
> =C2=A0
