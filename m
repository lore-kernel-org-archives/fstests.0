Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366A7D26D
	for <fstests@vger.kernel.org>; Thu,  9 May 2024 05:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715232551; cv=none; b=D0gtFofWyJ9+1U8qlzRQ3JGy+2tcM3oxbxVMrpTzAriMzK5PRsV8iaRa4UTlF0J2c95iijppohGDe9ywJ9szUH1JiGdhm3mnHsHOOjVqDRNcdcqxRWXqtZnYmTCUOAObu+Fy7BcMT7aIwYFGC1Pt+bPQYtXZzrpxRuARI2Rcp7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715232551; c=relaxed/simple;
	bh=zwvt5SsEFHHM+B5YhfALy68/FN2fqTXaOAa7MnwxUYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lpv2g/7yxpLAVq11/DCFacwV+nmBLZRPrUDMoOzcI9sLpXd8iglodp0HmF4MPnqCSUgmHVHvbP7me4gHA1uVDeUsJ80x+ki7nVodyVHvj40k9K7Ld+PciXY71ho+uU6f9mSJWZn3nPgDM+xV1ll/kMamd+8sK8xVrpMExUbgpAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HOZE0+o8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HOZE0+o8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715232548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TQ1dm4GYV1MPikK2vvMUPjpCddz8i01f+p+0VbawVEo=;
	b=HOZE0+o8UAfcpWd8e6PkEBrA4tzpEFtGCPWGf/lqtwkEqiLa+Mp0XddrRXgR3bNoR7/b2a
	sVsRZotoOcxUI07s8eDQ3PTB7UBhMu6SlrpFHamEkqxn02rpWeT9SOEaWTPkDXX9eGN+1a
	cojYvuiWrgY73Yu8kUDaFk0jWkRRWDU=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-pcopUwM3MceuIW_qlXugMg-1; Thu, 09 May 2024 01:29:07 -0400
X-MC-Unique: pcopUwM3MceuIW_qlXugMg-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1edf507b9e4so4879305ad.1
        for <fstests@vger.kernel.org>; Wed, 08 May 2024 22:29:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715232546; x=1715837346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TQ1dm4GYV1MPikK2vvMUPjpCddz8i01f+p+0VbawVEo=;
        b=NEhYacCNHGJJJ7ie5OZP5e2s1Ies0u3SQVGs51zElzTkEGpjcZLnChlIgbXo2caHuB
         hMFwEkfpGGFSSO+qvgqNx/iViO8TTC4uu4HINWO8xbq4FsP05T4g/v3KuTDE56KFKKyF
         dI6ulhg6Jy3znr93WS55qE0fcgMXWB+jmlhQrKgWpEnV8rvhMmAvl+YV9eC5RpNqvCQH
         7OdNKgmFshwkQKJ/yfK08KXz9z8fVIiPvcwozCE9nTGtvbr+G4eJ5CHVilJWTeFgWVAM
         bbr8ihMnVd+ZP3iuTt3JSzXj7vC97hCVQ5woWHI5PPzTokhKs0O0eSd9emWEB4sO+lWh
         +iZA==
X-Gm-Message-State: AOJu0YyxXrm2k+SY84leRSmgYMr2crZr62m1Iy3oPAJVIMPfB/cUwy5b
	6wpTQxu1B0D5ILhA+jxd38iTqDFk+1IbdI/rOZD09x5M+uZdvGetSk19pWeocouSpyoxLzhKYi0
	8gqMpf56rOGQ1ajswtqlWw/gSkllGiqXZhFhvqe8xksMHfsTJsgHtzbQAtvcOfxeEnw==
X-Received: by 2002:a17:902:e749:b0:1eb:dae:bdab with SMTP id d9443c01a7336-1eeb078ffabmr65567345ad.46.1715232546173;
        Wed, 08 May 2024 22:29:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmok6exOOzyIbFklpXpou6q1WJnRMypkj8fcEBLtWewDWDqdBuj3kzH6oyJwkk7ZUSdx59KQ==
X-Received: by 2002:a17:902:e749:b0:1eb:dae:bdab with SMTP id d9443c01a7336-1eeb078ffabmr65567135ad.46.1715232545695;
        Wed, 08 May 2024 22:29:05 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0badc8ffsm4960905ad.73.2024.05.08.22.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 22:29:05 -0700 (PDT)
Date: Thu, 9 May 2024 13:29:01 +0800
From: Zorro Lang <zlang@redhat.com>
To: David Sterba <dsterba@suse.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 0/4] Move test cased from shared to generic
Message-ID: <20240509052901.dna2xq3yd4p2b7m3@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1715108589.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1715108589.git.dsterba@suse.com>

On Tue, May 07, 2024 at 09:07:28PM +0200, David Sterba wrote:
> Hi,
> 
> as discussed recently, the tests in shared should be in generic.
> 
> Based on branch patches-in-queue, commit e098483c662d8f0b7583edca1501d8addd3b7549.
> 
> David Sterba (4):
>   Move shared/298 to generic/740
>   Move shared/002 to generic/745
>   Move shared/298 to generic/746

Thanks David! There're two shared/298 above, I think the former is shared/032 :)
And I foundd that all .out files were not changed properly, so I suppose you
did that manually. The "mvtest" tool will help you, e.g.

# ./tools/mvtest shared/032 generic/740
# ./tools/mvtest shared/002 generic/745
# ./tools/mvtest shared/298 generic/746

Thanks,
Zorro

>   Remove rest of shared/
> 
>  check                                     |  2 +-
>  tests/{shared/032 => generic/740}         |  2 +-
>  tests/{shared/032.out => generic/740.out} |  0
>  tests/{shared/002 => generic/745}         |  2 +-
>  tests/{shared/002.out => generic/745.out} |  0
>  tests/{shared/298 => generic/746}         |  2 +-
>  tests/{shared/298.out => generic/746.out} |  0
>  tests/shared/Makefile                     | 24 -----------------------
>  8 files changed, 4 insertions(+), 28 deletions(-)
>  rename tests/{shared/032 => generic/740} (99%)
>  rename tests/{shared/032.out => generic/740.out} (100%)
>  rename tests/{shared/002 => generic/745} (99%)
>  rename tests/{shared/002.out => generic/745.out} (100%)
>  rename tests/{shared/298 => generic/746} (99%)
>  rename tests/{shared/298.out => generic/746.out} (100%)
>  delete mode 100644 tests/shared/Makefile
> 
> -- 
> 2.44.0
> 
> 

