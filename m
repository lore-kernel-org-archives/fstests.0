Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912FB32D451
	for <fstests@vger.kernel.org>; Fri, 14 Nov 2025 16:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763136943; cv=none; b=NLWc/yv7B8N1X9MUHhKxE9vx6rv7+w+wTBsOTmOyPUaHZtjwmqExfPjafADpVOKPWbMY8MarLFqZ5N0MibbMLuATrHjbgc1RqBKqdk+1u6XPK+RDGTl6FyJu97177xigs1q/kgbTjV+rdid4WmwxT1bn2IIjZpjCOMeVS17ty/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763136943; c=relaxed/simple;
	bh=pXEt5uM1TpBXLouep2z8hFhZp0vVQNR2xOa0Nspwy+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KuDRnO2FLIJBNi8IQfyzQ+h1WGON81RH3KBCZMgkxpvizrApIEP8h0b12Mj3ScNPI2H952hXGHPHVlhlSP/s6BknL6YFGgc3ukfRTFJ3k9qHqSs2g0T7CjJ+u+pT8Fd6gdOR/IidlRthS4lMBYJUR512Ti3WoBmaA6ByyQJ8WAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MwkK7J7X; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TkO4PSn5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MwkK7J7X";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TkO4PSn5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763136940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mnbaBLZDjAS50C1wo47cLsiO8TAqB4D6DR4st5NjsaU=;
	b=MwkK7J7X68xt107O43ue8eZOjpHAtFo9LdOv8rSYpZJwLKvEeipx+S4hHJp2RKGxoTjgLH
	+dl3w9pv3Lgg6ON+oOQqDg2keUcyYU9p4cA4BlPNEpXTU0NYmuSFfBicUB7VB511CNTUn2
	WzhZH3Er9gtZTnh7u2E4vNZn6+/B9dk=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-9csUJ91FOFugTZtQBM9SnA-1; Fri, 14 Nov 2025 11:15:38 -0500
X-MC-Unique: 9csUJ91FOFugTZtQBM9SnA-1
X-Mimecast-MFC-AGG-ID: 9csUJ91FOFugTZtQBM9SnA_1763136938
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-295595cd102so51086455ad.3
        for <fstests@vger.kernel.org>; Fri, 14 Nov 2025 08:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763136937; x=1763741737; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mnbaBLZDjAS50C1wo47cLsiO8TAqB4D6DR4st5NjsaU=;
        b=TkO4PSn55lwjm9wvblvlMqUZyF2jOT+4AObguWKrUpIvlf5/YnHwtPp9C0lDxZiPoX
         yY+2yuf4jkmZS4wGTtzckEWJaAY6PalK9h1UoTAuy8N7WsZ9sqhOaB/2FEMLM9/xkQlm
         sryb3dLYvVkDqAU85kuc+sF2IwqQGYPcR3euqG4UoCjF93DZRRS8hPz1xLoFR6GYRV+u
         2szvEUibubnK62wkkE4AHmxWgxb7ksQei2ZtFNGDs8a8bGYwsn01/SHnTl/R8fOuYSep
         1LOv2vQ6HIqrkOsdiEzu0Z5Snnia8JvlJHZX9intk5XkU/A2x+cCxkxDhbuh1hHMVbw+
         UorQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763136937; x=1763741737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mnbaBLZDjAS50C1wo47cLsiO8TAqB4D6DR4st5NjsaU=;
        b=M8E1Ztyxstur80yPbfdrSAYPxisvyyJ5Hc/WgnuxoKR4yGaQf7y0lFgMg7RI0vjn/p
         /NE9H0L/cMq2+2n+9ffL6v7mCBtT5oI/iJ/lh/OSAa9/253ReM2fa1T0svBy78bip5m5
         jb4kWVGTcQjq7lt/SPrGMyVy3RPyraJsqcRzDXImuMbHc8+kLfRamOioo15HFjFR50CG
         7BpLbRIFBF+rYsRwq3mQYwsYpAHvtOBA6vznNVbZHCB90yMWTxVcy6MpGgIZZHG63Fq5
         UZ7dVz2WChgGVv+B6hoCqFycxhRFHIme9pe1hNcnlvXwiPid/CYm0ZwY+L4fmotzjoUX
         PlUQ==
X-Gm-Message-State: AOJu0Yx8Bmq70rEG3bAOxiPPOfVPuyPmoKD50E411Im8pouU6/C8UGH7
	x+rTSp0yyT1pkEqHCeQbeKgysSAKTy8Y6bOs6h8kW+8PMTKElFANjyIFLovGgv6A14fwnlnk4uC
	8BcXiypxlCGCrJIx18J8w3SAArrdN+nrpTC4Y8FR5lNLSHuhyfRkHFzJwsF0=
X-Gm-Gg: ASbGncsAfcv3rwU60iIMKEbxy042KFIDVEJbCldt+VqTrQnBxaoWF8qA/M2EIgaBy+H
	w9FW9/X6Q5gi6RVYNelPOfk3sFpnDY6SybNkr57Ol7GmTzhhgLDojX3fTKuAwOhr0uBBacAxUis
	1yMOMFoi7/cjctpmWSMqqi+7ep1irkmtFNG+uzczZ6myfdQ7m/BEoaZZvmOd67uWX1/6UWzaNdf
	QxxTWtkEFVrEy9LhYCZDr/t2jLYD1IUY8zQN7iSPkMZ3Z19aS4rbUYOF7IkuwaBOTIg5okiKZQC
	yvk5V8iasQ8/fO3VJpryRrrF2HRGj0bJrTbTeXj9Df5Ad07JxDuNGPhemeGKLzi4/dR2/dlbPLA
	OdDBfz9cLaKHbV8uhc47OZoRe5piTxZzXfzFCNxfVRmtJnBMgqQ==
X-Received: by 2002:a17:903:2f0e:b0:295:8c51:64ff with SMTP id d9443c01a7336-2986a7420ebmr41764595ad.29.1763136936692;
        Fri, 14 Nov 2025 08:15:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGefXMo76HOwVOxk+A+2gSmxtU7bjF1gSJnogP7OP6Rumwokc58ZpTNNoMOShXxn27zvnJqg==
X-Received: by 2002:a17:903:2f0e:b0:295:8c51:64ff with SMTP id d9443c01a7336-2986a7420ebmr41763935ad.29.1763136936029;
        Fri, 14 Nov 2025 08:15:36 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c245d4bsm59519495ad.34.2025.11.14.08.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 08:15:35 -0800 (PST)
Date: Sat, 15 Nov 2025 00:15:31 +0800
From: Zorro Lang <zlang@redhat.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Zorro Lang <zlang@kernel.org>
Subject: Re: [PATCH] generic/773: fix expected output "QA output created by
 1226"
Message-ID: <20251114161531.v2qm6k45hrusexbg@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20251114010238.2173413-1-tytso@mit.edu>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114010238.2173413-1-tytso@mit.edu>

On Thu, Nov 13, 2025 at 08:02:38PM -0500, Theodore Ts'o wrote:
> The test generic/773 was apparently submitted as generic/1226, but
> when it was renamed to pack the test namespace, apparently the test
> output wasn't adjusted to reflect the new test name, leading to the
> test failing on sytems that have devices that support atomic writes.
> 
> Fixes: 1499d4ff2365 ("generic: Add atomic write test using fio crc ...")
> Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Cc: Zorro Lang <zlang@kernel.org>
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---

Thanks Ted, I'm not sure why tools/mvtest missed this :)

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/generic/773     | 2 +-
>  tests/generic/773.out | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/generic/773 b/tests/generic/773
> index 7ad745546..0a30ac7f4 100755
> --- a/tests/generic/773
> +++ b/tests/generic/773
> @@ -2,7 +2,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # Copyright (c) 2025 IBM Corporation. All Rights Reserved.
>  #
> -# FS QA Test 1226
> +# FS QA Test 773
>  #
>  # Validate FS atomic write using fio crc check verifier.
>  #
> diff --git a/tests/generic/773.out b/tests/generic/773.out
> index 6dce0ea52..8626114df 100644
> --- a/tests/generic/773.out
> +++ b/tests/generic/773.out
> @@ -1,2 +1,2 @@
> -QA output created by 1226
> +QA output created by 773
>  Silence is golden
> -- 
> 2.51.0
> 
> 

