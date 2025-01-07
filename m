Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD722A1C9
	for <fstests@vger.kernel.org>; Tue,  7 Jan 2025 02:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736218221; cv=none; b=HN+v0oGBwYQgOJ6ztP/zjizKoeq1bamCz2btcVTXxVqN6LPMSDOoIR1bxdbFUWM8rlqJ8wPFCKX/6PSvKkVmBi08g4JWmudxs/iVr1LVSUW+ZUR8MLRyaw4aF+0c7eVyBr8Oy0Fq3X3v+kF8yAS105LeZBYIYDTW0+UPSw3xZus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736218221; c=relaxed/simple;
	bh=qk46SEuRkIbjPMRsP/B4UPPqU6AyLn7OUUPNrMhKXOg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=AYjnzmEtPuxlPog8z4RpWkc+4YTF4jzwA+5lkYGJ2f0YtVE81z3Oxw65MUmybeDk0qztcGZXoMQuAE62NJRZe2Go+2tGxA/02zalbi+7s4CSQu67YYqvlL2AMem8uqQLujru6R7hJy9gPi32RtkyiRS5DUQ+WnyBSGNZTAMWlQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HXIcY3Pb; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HXIcY3Pb"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aaee0b309adso1822487366b.3
        for <fstests@vger.kernel.org>; Mon, 06 Jan 2025 18:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736218217; x=1736823017; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xEL6HuZhOrssSeK1KDJpmAJL/t5BytjEcqPXzORM7xI=;
        b=HXIcY3PbH8GF9VhcSYjtHCSwJL4it25+IPg9YVofWU+fxbLRM+Ps4GeLhFKGIednev
         g7PmHhrzru4Sm8mT/HS8UgIUw8pp8xiUQahC+bb+AcypzvUhxVjGmIjmfbIJqa3zaOjF
         2qSY6X4KtuUxAHfUN2AHjKy1lekdwBG7CLVqARiq9oEjHZjiOeCZKE5vD69UI13tDE5G
         WT32l9VcLxeYWlZwyGO9I4ihVn1uSFHeLbzI8AD4+CHFVkbRnhnH9WR9AnT/Tz9Y00Dv
         gwDYAeZPPWD1CehBvMo7kJtz5dKP09AxasfK/HES/WSzT9D2iYEigZOgSQ2nYwClwqaQ
         dQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736218217; x=1736823017;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xEL6HuZhOrssSeK1KDJpmAJL/t5BytjEcqPXzORM7xI=;
        b=rPFfaMZOcRIchB8EDb8U33orzdlurQ56DiTsdAAg/FvwdQ7uGi1VimRWcys3veNhrL
         gCcdPoBt8hPPxJWhIqrJzGpsydLYXHMVChF1Du6A1DgAHgz+zxPdluANBcl+AX7ce8YE
         JeWAQdeOiRsV0VNUeOaFOJwAOQBiDjMnkDOWT0iFr99DX9BxtdbELcFV43gIaDhtRM2w
         ijabO1UXy69HlnmGtcKQx6/xDNFKNi7xPr/9aEav6Ne1ASQwgYBDIXaa8EKJ2xBuT3rt
         DS43Xrn9hKiaN39qcmYSaAYBkxiu0ooBOiYvMa1wZVvJU5jS/c8WBn+esmhy8M0RcRvI
         gaGg==
X-Gm-Message-State: AOJu0Yw06iWKwmOcfzBqvPKGmy7U5BH9Ai9XZJtTqpAjVDUD+pfCp0pX
	6GpVXx2rBGbp8HrYVLRPxTa/7prfyfuKDApvZM8kg7k1jXKGvuEJrYWD1Fp+1OVb8cMQgcKvBSJ
	ssYg=
X-Gm-Gg: ASbGncs33gBvCFRkhftznDV3iXKbILj+xoOimpOQ1iHMIOC7SsblYvxGPTT9Ipl9pv4
	MVNW9qeeFBL1RB5DSClsl5Uc/FY8si43OLVs85GolbyxPtNvsxTaU/W4HUpty/kstyEJoOunsEY
	AcE8gEVvDdh5h/0tHKfd59yqHj0o8+ZdEtIEu0rvwDYVohtbSW/+3qMr/GKtGoFWEs4yjj4FkpK
	wnz0ANpRhZ8FRlOMI07Ntw4nN2LHubHmEjd37hh9PfnMPzZM3n0Iv+N8zY=
X-Google-Smtp-Source: AGHT+IHa4CI3p7/EYncLFROKKRCiEmPVnG9ZJhYFnehnCDz97oM1NxsgOmFFIw63lX/28M7STqWkuw==
X-Received: by 2002:a17:907:9405:b0:aa6:93c4:c685 with SMTP id a640c23a62f3a-aac2b946474mr4738634766b.23.1736218216885;
        Mon, 06 Jan 2025 18:50:16 -0800 (PST)
Received: from smtpclient.apple ([23.247.139.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f447883b0csm38407878a91.42.2025.01.06.18.50.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jan 2025 18:50:16 -0800 (PST)
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
In-Reply-To: <Z3wFFs371-WNVreY@infradead.org>
Date: Tue, 7 Jan 2025 10:50:03 +0800
Cc: fstests@vger.kernel.org,
 ocfs2-devel@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <AFFEA381-1C08-46B6-97B7-9F7DD954BE0F@suse.com>
References: <20250106140104.91880-1-glass.su@suse.com>
 <Z3wFFs371-WNVreY@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
X-Mailer: Apple Mail (2.3826.200.121)



> On Jan 7, 2025, at 00:30, Christoph Hellwig <hch@infradead.org> wrote:
>=20
> On Mon, Jan 06, 2025 at 10:01:04PM +0800, Su Yue wrote:
>> mkfs.ocfs2 is using 32bit journal as default.
>> For 16T size device support, '-J block64' should be used.
>=20
> Hard coding this into a specific test is weird.  I would expect
> mkfs to pick the right one, but maybe the maintainers have a good
> reason for not doing that?
>=20
Sounds more reasonable.  64bit journal support of ocfs2 was added in
2008, 17 gears agao...

=E2=80=94=20
Su
> But if not you probably want to force it in your config file or
> we need a workaround in _try_mkfs_dev.
>=20

