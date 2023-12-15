Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562441C31
	for <fstests@vger.kernel.org>; Fri, 15 Dec 2023 04:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FUnMoK3c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702615495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xe575kdD6ahKwxos/3OQ+fZmGPC3m0aBx/ya7UwtNnQ=;
	b=FUnMoK3czc1RTrLQy2OFikGQxcSgld18Ikasz3OKTAHFstJOK/sxDFx4/qyqR8Z+LvXWkF
	tjOxFXAvXceBlgR1WGJPdpuGqu3aXR/bPxmdeOxsfpb42U+FziTLetTS1hPsYfJXIHb2Kj
	tEeI+8+KlJrWxr7BVEKgyqHVZqC9JBE=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-GeC2xdR1P1OOZS8yi7BExA-1; Thu, 14 Dec 2023 23:44:52 -0500
X-MC-Unique: GeC2xdR1P1OOZS8yi7BExA-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3ba3e8f9f00so497804b6e.3
        for <fstests@vger.kernel.org>; Thu, 14 Dec 2023 20:44:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702615492; x=1703220292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xe575kdD6ahKwxos/3OQ+fZmGPC3m0aBx/ya7UwtNnQ=;
        b=qhjdT4DQpaHpuzdGbJFvMAm54rYdLGp4ruSEfdC2P6QNJaGNyW+ihP98MZ6UhlvvdN
         +wVh+RsGl+OZa0evm0c2c2EhYXccL4MnTtQU3hRWcAvyw+fJ7lACcFAg+Yp3BP+lSJKz
         tcK8EEFD1LUZvhDHMUdUsINhhrWSz0525lQFDAdwcyxhyCSzDErcd2AqME48pnhdgvvX
         qIQhcKOTFEwfCKZbSclFrX9ZcQxEZtGHzTratOtxZZJpa/OMUdwueRTtsXih+u46BJlA
         vnR3IQgL9lEr8nQBdMMP9f4jpG9Z9luWuY89/B273MApcBjkV5+QZQf4elYhXU4c3fYm
         oRUQ==
X-Gm-Message-State: AOJu0YywCvTkwAbjbHYqLiwdNSyhCMnUFfnmuBAp5h/2lpzEkh5enUrc
	daUsZS5B3SblnGerTPFYlktF8lGd/IelLLGaLhR0sGqfkXw8T6IsOeB67/YTBlU46DWKmlu9kpC
	3e8Q0THn92otCwy4ZrA==
X-Received: by 2002:a05:6871:a50d:b0:1fb:648:520e with SMTP id wc13-20020a056871a50d00b001fb0648520emr12870302oab.6.1702615492161;
        Thu, 14 Dec 2023 20:44:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmb5lYLYPcVD5YQ3wwLDhem0d73beXq7egzj5CUDu02xMQ+wNnEf+0gAby8VaSrGadir4ujw==
X-Received: by 2002:a05:6871:a50d:b0:1fb:648:520e with SMTP id wc13-20020a056871a50d00b001fb0648520emr12870296oab.6.1702615491747;
        Thu, 14 Dec 2023 20:44:51 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id u2-20020a63df02000000b005c60ad6c4absm12617093pgg.4.2023.12.14.20.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 20:44:51 -0800 (PST)
Date: Fri, 15 Dec 2023 12:44:48 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCHSET 0/3] fstests: random fixes for v2023.12.10
Message-ID: <20231215044448.lqer75uqyro4yse6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <170250686802.1363584.16475360795139585624.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170250686802.1363584.16475360795139585624.stgit@frogsfrogsfrogs>

On Wed, Dec 13, 2023 at 02:34:28PM -0800, Darrick J. Wong wrote:
> Hi all,
> 
> Here's the usual odd fixes for fstests.
> 
> If you're going to start using this code, I strongly recommend pulling
> from my git trees, which are linked below.
> 
> This has been running on the djcloud for months with no problems.  Enjoy!
> Comments and questions are, as always, welcome.
> 
> --D

Routine "random fixes" from Darrick :)

Reviewed-by: Zorro Lang <zlang@redhat.com>

> 
> kernel git tree:
> https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=random-fixes
> 
> xfsprogs git tree:
> https://git.kernel.org/cgit/linux/kernel/git/djwong/xfsprogs-dev.git/log/?h=random-fixes
> 
> fstests git tree:
> https://git.kernel.org/cgit/linux/kernel/git/djwong/xfstests-dev.git/log/?h=random-fixes
> ---
>  tests/generic/410 |    2 +-
>  tests/generic/615 |    6 ++++--
>  tests/generic/735 |    1 +
>  3 files changed, 6 insertions(+), 3 deletions(-)
> 

