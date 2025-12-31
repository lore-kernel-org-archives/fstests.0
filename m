Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A0E173
	for <fstests@vger.kernel.org>; Wed, 31 Dec 2025 18:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767206789; cv=none; b=PbDi5IP3ZmBxCxh30OxOaoiGfndiMVKiZmcR0ZBKbPad6ELenlg7iWVM03zBSDKImI0SijYwOvsEOizlzs0DjSvG/4Gg5Z2TlHjHpJL4YByR8/7uNfKeYUU4+oQ8MOQnTtAHb6jXpPuwGx8//lPeRd4D7jPZ9uri4b/O+cJc4OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767206789; c=relaxed/simple;
	bh=FUUPf8P2gy6AfTGvgSEut/D50AGb2LN/8jOvl5/hOmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=itdubR7BbNffwpHv/KN7cmv2/M4HUie2wouXViWczYUsmX9foDbhlwO7usRH5xYhhj3xb5HLYc8bNKF2x0yXfoDT9Wib8sEQbe37qm6gjIxKNUMCUmFt4lLkExfct74qoPoRUDVC1hOv6aA+vZPG3d9BRXUL5wbriaxKZPN8AoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eDJF2Y0o; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kPSzF4Pc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eDJF2Y0o";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kPSzF4Pc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767206787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vlla47aoLrcDYDSY4BpG3tEXVHnjclwu0RsmzL7mzWQ=;
	b=eDJF2Y0oAo15iDTCfqRzFEvvNkSdjzKpFpUuZ7kQdwTt0qG5yrESDW/FfRMdyNxhUD0IoF
	A6yqf/hE+zpQrEmsUBMWZeDtZJ4/qdHpQItGGhm3tUMeRTpuDJuZxMcCFtVVa1FQnV0ZNw
	jJKXdbi4XqeePTC6HuAEN+c1qEYZxK8=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-QzVsqxhAO0qCkgAfiy6_pw-1; Wed, 31 Dec 2025 13:46:25 -0500
X-MC-Unique: QzVsqxhAO0qCkgAfiy6_pw-1
X-Mimecast-MFC-AGG-ID: QzVsqxhAO0qCkgAfiy6_pw_1767206784
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7b90740249dso19037018b3a.0
        for <fstests@vger.kernel.org>; Wed, 31 Dec 2025 10:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767206784; x=1767811584; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vlla47aoLrcDYDSY4BpG3tEXVHnjclwu0RsmzL7mzWQ=;
        b=kPSzF4PckFqlK36WK1SOUBBOxquIoBvFmQIN8fZqgK8aeyqYCfOdOENroZiLI98FmD
         FyClLc81r2qjzFofVnl3bFvBDHZ1i+CFOJU2YvjV/Z/pqt/EDaERgyLhbn5IrC21mqp4
         k5pLTmDolB2caWX2VInP9K+XB1z3sup8xyEYzV7flHSSFvq+wBfM5njJq6Xxu8AlP0fi
         IdZWSoGt4Zbzk6+nGw3Mw9H3HIgN7OELWAt2aOwU+OtwimybBRtYqaBh/SLUW6n6GO5D
         IE6x0Rr6I3/xd6GztOGnhMkzGYrhLHc5pgG3Uprn09pux1HRJmoY9WV/KrlbHKncE5GF
         YA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767206784; x=1767811584;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vlla47aoLrcDYDSY4BpG3tEXVHnjclwu0RsmzL7mzWQ=;
        b=BJ8VOzpPm6qskry8GM3h11zLJHL8YxRqBFD3Pfn5u5J5N4XffdM1FchbjNk/KC8Dep
         LCT5xV0lBq+Fq9kGFZb6ZQzKxPvyb1KaFrybS2JVktJk84gLYmHZ3rAWL7+aCO+5oBmZ
         yx9hU/43vNeDiMcOHQWyxWyzwbYvdJgteyd8XQC4BnMidJQMmNb/s0B0hfz1p5q8LhCr
         PpZFOeAK2Wfvk2NgDWWWssIg6uCXm747TOFJU5XrP3ArC0AmuU3j0tgTyajzarHo/4C4
         EO15CPoY3BiGoDG7bQk8PitOL5DwPAh0txptVyBDAO51jMi8AdvOVQg+XHHF6jhoruXW
         tsjw==
X-Forwarded-Encrypted: i=1; AJvYcCU7o/2vgiXvQ7PvN+WZd7b3r5Yk8tdGPLhTW17TfnYgYcKaX+GxLjoKp2yUYmoUkotD73uYp3F6@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6XhcKqDBGrq5jV1+uZJ71pvTRlp5qJhkOs8b/iGUYTGYT7Anm
	REUtvGezuwS6zmRECU5PM/EAIlTga4R75hB1MCgq2usC7D4n+Q79UlyHHIuolqeeCdF8fsVGzVI
	JagzegenYIS0rREqdH2FAgfQHMALaAgoDv144iRrAgcKQfLu67JoPK9qS7r8=
X-Gm-Gg: AY/fxX7duqg+uHaQu8A8253U1Udin75FUFBf+IrRXw2AWfMiDXjFauyUrmnXFP76EGi
	gFjp/h48Q/gG6ADmV0ZpNEpr28cXM7OHT6cIM8DHbfhZtdrm9ijFJ9k4/wbOL6gB0gET/rwWbXv
	ubUcBs8pQ6JFrwcddSTPm6Nc8JTYDg0LJcgni3eNxKWUSSKX7JF/qiNrIvA8LQae21lfyhLQX2r
	EBX/x+PXdtxd1hmqoqgcfjYQYKOw6fRLxcJEEMKR7jyfQqPaGQ52e3i+5boW+fBcYSH4Hg7JeQh
	Bf08vn68f7qLKwxFiKmCo8lA4ggnAa/7A0lO2aMl1CeyESE9nvhJIwq0f6ioZjYxWLIBjb/QmX5
	t2IybyYnGFWsxDeiidHjYp45qrY9r9kMbwyWbuPi5sK+oost45A==
X-Received: by 2002:a05:6a20:3c8f:b0:366:14ac:e20f with SMTP id adf61e73a8af0-376aaff1da6mr34738966637.77.1767206783751;
        Wed, 31 Dec 2025 10:46:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMrTlUistPjfFysJnldiS5PO8w2FC+NyZPv9Rma3Q+vU3A+h1qDnobsntt4ae2SIRL2aZ62g==
X-Received: by 2002:a05:6a20:3c8f:b0:366:14ac:e20f with SMTP id adf61e73a8af0-376aaff1da6mr34738950637.77.1767206783308;
        Wed, 31 Dec 2025 10:46:23 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e7961fbb9sm30838452a12.2.2025.12.31.10.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 10:46:22 -0800 (PST)
Date: Thu, 1 Jan 2026 02:46:18 +0800
From: Zorro Lang <zlang@redhat.com>
To: cem@kernel.org
Cc: zlang@kernel.org, linux-xfs@vger.kernel.org, djwong@kernel.org,
	fstests@vger.kernel.org
Subject: Re: [PATCH] punch-alternating: prevent punching all extents
Message-ID: <20251231184618.qpl2d32gth4ajcsp@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20251221102500.37388-1-cem@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251221102500.37388-1-cem@kernel.org>

On Sun, Dec 21, 2025 at 11:24:50AM +0100, cem@kernel.org wrote:
> From: Carlos Maiolino <cem@kernel.org>
> 
> If by any chance the punch size is >= the interval, we end up punching
> everything, zeroing out the file.
> 
> As this is not a tool to dealloc the whole file, so force the user to
> pass a configuration that won't cause it to happen.
> 
> Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
> Signed-off-by: Carlos Maiolino <cem@kernel.org>
> ---
>  src/punch-alternating.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/src/punch-alternating.c b/src/punch-alternating.c
> index d2bb4b6a2276..c555b48d8591 100644
> --- a/src/punch-alternating.c
> +++ b/src/punch-alternating.c
> @@ -88,6 +88,11 @@ int main(int argc, char *argv[])
>  		usage(argv[0]);
>  	}
>  
> +	if (size >= interval) {
> +		printf("Interval must be > size\n");
> +		usage(argv[0]);
> +	}

OK, I don't mind adding this checking. May I ask which test case hit this
"size >= interval" issue when you ran your test?

Reviewed-by: Zorro Lang <zlang@redhat.com>

> +
>  	if (optind != argc - 1)
>  		usage(argv[0]);
>  
> -- 
> 2.52.0
> 

