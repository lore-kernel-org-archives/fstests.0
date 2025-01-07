Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A311F0E53
	for <fstests@vger.kernel.org>; Tue,  7 Jan 2025 14:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736258405; cv=none; b=bkvJek6I3hyoDeAbNhfJzn3wBpdq0kBB1p+yDgfNaDJdz2hl3IE6EzmVZzPGbo9I4kNSUrJBjjk9PI0+TpdMffW7I6JEjVGGeyHQ8rTcmazphL3cqoOAc4iroDIGOKEzHAEzR2rXwOwNrC2V8oyhGa8J3NrrT9Py9zZoTXvj7pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736258405; c=relaxed/simple;
	bh=wAxME8YMOU4GM4a1MPnvRrFZt+NPAe8W10OAkDSFdh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c95+8QiIyi/pnILEGgcNbpV7HlNBfvaM7nr/1KuMsLa/Z5pBLuA45iLmHwyPRC9EYLae3hRstIS1MPK276hAJmS1KuoQTlSj5f+wW4ty0LCfXmuYFOROQ8mhOyIqkceNbugKFDvTOd2LaUFtYuZ62/uBcQUFi8zXxvAsCvVd9lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RhzIDVsx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RhzIDVsx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736258402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pwPtk1bUMw6H3qg/0OJzmZMXntXsHFnd2zi27fFb7Io=;
	b=RhzIDVsxB3xM9wes59fGubJmyzB5vRs4FrpyVQ33WULVrE+zxm2lDEZGmuCbMC9FFmVWtq
	iV05aPl0ZYgGORLtgh8LAQUXNEdkQ2Y+yr2aDr6T98lWDNHm0i2qMcBNchdHEiTcEQUyUY
	rxCO6soIyUYEgkmdQXtZenvvkaQlCn8=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-C2quQftEMf2CFuAt3ziung-1; Tue, 07 Jan 2025 09:00:00 -0500
X-MC-Unique: C2quQftEMf2CFuAt3ziung-1
X-Mimecast-MFC-AGG-ID: C2quQftEMf2CFuAt3ziung
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2f129f7717fso22867235a91.0
        for <fstests@vger.kernel.org>; Tue, 07 Jan 2025 06:00:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736258399; x=1736863199;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pwPtk1bUMw6H3qg/0OJzmZMXntXsHFnd2zi27fFb7Io=;
        b=Wh5A2wOPF8sNwBdCAFJlsKFtupjoGwMCThl4olzKT+RecuD9JGPdFQKJF2Gba70jJf
         pgikziztjtSpr6JDQrloV9nNDGOdrdEFns3EYlUaNioN8SNxKqO+2avQHRZErPDRX1hH
         bkNf4c80PDjV/Q/ZmtXMMKu57gfiKlRhmeoLMr2K7gXcfBZgfc42lfEm5anlA/nxNnNf
         nd4GiRLEHnWgId75xXKOdUpS11ylW/5WJ6UXkzVSbe2NOmKGUaI9GCI01Vv6lmzug9c6
         UkSMr77+vKL9428klDGSGijX+FpHU874A/J+hXx0pZOYbwrIoLg8/IGV6Ak02KCMjFWP
         2u+g==
X-Gm-Message-State: AOJu0YxdqQkJ4AuhVH/ZpKr92MMRjsqfddNfuRqHxtzJ40VWHvP3JaVr
	WobMX2z6/q0916D/RoEEX6hXbztA8f8yiVmW9J0W/Hl9IjvVkwGNg0+ZvK4wQMihNNxdA0XheK0
	3aSGCic0AFy79PFfD7t3xyKIml0FKd3HdBJ7rGBrQhLvvw6sJMBgShqg=
X-Gm-Gg: ASbGncta6t3IWi+OE14ERjAUFN5ZZRlpMt61lrMuX9gwUsfQu44UeZBShlZ1+B4QAIg
	C6bvqRk8bB91qNOjLS91VGRWeOOY/uBCsi4MtW8x1CceYtVu2gxUw/p4/dS+o3/AnFO1H7ws8k7
	8zCctzx5cbnz6/UIysdmOBUasGM+xOG0AnSobfMnPMJV51r06GbS71SLlVFsxmq1QaEraQVKhdZ
	4GBnf4XrQyqdV2vX/HapOTg8grrkwSistSE3S65GPwJ1agjaHOx+rfOzaoXcE2iPPG7cNNw+P8X
	rKn4/nL4HUIPoLNNRdhGQg==
X-Received: by 2002:a05:6a20:d80f:b0:1e2:5c9:6791 with SMTP id adf61e73a8af0-1e5e04609bfmr105375543637.15.1736258399549;
        Tue, 07 Jan 2025 05:59:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQGAIMBMYfyEH0WhdgKPHwTDoX2FnQN7dUQaqrnDfzapkVsLHcdkSROMlvR/09DvsKerh9Dg==
X-Received: by 2002:a05:6a20:d80f:b0:1e2:5c9:6791 with SMTP id adf61e73a8af0-1e5e04609bfmr105375500637.15.1736258399206;
        Tue, 07 Jan 2025 05:59:59 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad81617csm33311902b3a.39.2025.01.07.05.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 05:59:58 -0800 (PST)
Date: Tue, 7 Jan 2025 21:59:55 +0800
From: Zorro Lang <zlang@redhat.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: fstests@vger.kernel.org, linux-fscrypt@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Gaurav Kashyap <quic_gaurkash@quicinc.com>
Subject: Re: [PATCH v2 0/3] xfstests: test the fscrypt hardware-wrapped key
 support
Message-ID: <20250107135955.7ysucjcdh6m3zlh6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20241213052840.314921-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213052840.314921-1-ebiggers@kernel.org>

On Thu, Dec 12, 2024 at 09:28:36PM -0800, Eric Biggers wrote:
> This is a refreshed version of my hardware-wrapped inline encryption key
> tests from several years ago
> (https://lore.kernel.org/fstests/20220228074722.77008-1-ebiggers@kernel.org/).

As this patchset is applied to upstream, I think it's good to me to have
this test. I gave it a basic test, didn't find issues. If still no more
review points from fscrypt list, I'll merge it.

Reveiwed-by: Zorro Lang <zlang@redhat.com>

> It applies to the latest master branch of xfstests (8467552f09e1).
> It is not ready for merging yet; I am sending this out so that people
> have access to the latest patches for testing.
> 
> This corresponds to the kernel patchset
> "[PATCH v10 00/15] Support for hardware-wrapped inline encryption keys"
> (https://lore.kernel.org/linux-fscrypt/20241213041958.202565-1-ebiggers@kernel.org/).
> In theory the new tests should run and pass on the SM8650 HDK with that
> kernel patchset applied.  On all other systems they should be skipped.
> 
> Eric Biggers (3):
>   fscrypt-crypt-util: add hardware KDF support
>   common/encrypt: support hardware-wrapped key testing
>   generic: verify ciphertext with hardware-wrapped keys
> 
>  common/config            |   1 +
>  common/encrypt           |  80 ++++++++++++-
>  src/fscrypt-crypt-util.c | 251 +++++++++++++++++++++++++++++++++++++--
>  tests/generic/900        |  24 ++++
>  tests/generic/900.out    |   6 +
>  tests/generic/901        |  24 ++++
>  tests/generic/901.out    |   6 +
>  7 files changed, 377 insertions(+), 15 deletions(-)
>  create mode 100755 tests/generic/900
>  create mode 100644 tests/generic/900.out
>  create mode 100755 tests/generic/901
>  create mode 100644 tests/generic/901.out
> 
> 
> base-commit: 8467552f09e1672a02712653b532a84bd46ea10e
> -- 
> 2.47.1
> 
> 

