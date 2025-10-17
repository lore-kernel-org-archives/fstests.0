Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567EE330B3A
	for <fstests@vger.kernel.org>; Fri, 17 Oct 2025 17:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760721216; cv=none; b=MsxTER/jud7F/Ndr48tAVZjLEUNYrhzYZZi5rjYflc/fi0mvWY+Knjn05qmrHDEFxzzncRQRPYEU9Enoux+7rPo/yysNsnfWXTPgx+Oj+UWiLH/mMbZK2k3oB1EXAPAe+whnPol1D4ZTEE1CAWpZnT5iR6pCv4uT+2GejfHpQ7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760721216; c=relaxed/simple;
	bh=BNRwFUIELG2ygw4bW3PH2KI/Q+nWDQN9xxXtMUGUR/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fZKFiJBF3ZL0vsKWL6A4EnbCOQgL/nAaaNpssWezbA9A5WW9zTiL4/pRD7rg0cprPO917hoHs6iUKoR7dsqk10AurJz5SC3vfbkJ/vygCACPxvDeIlnKR9sS0rSukUKFXkMfyrWvQAg9ltsNWwrF7HNa3Hu89Hipj+2fPzKZJHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d6NPxULX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d6NPxULX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760721213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3oH+JLZtPmhaQBCzs5M5q290f+e5pQcBKbkdAyZCCUc=;
	b=d6NPxULXYC1fh6dU8rq4mV6vYPoK1rtJD6Xd0sRmJ+iOVLeZGbfAD+zX5JEDEhs/GhaJF+
	6V0niiCiYRx5Iomt/OUjhaT8ZTH0wcNojdWAW3rpp2nNPPyEhHCMcQf90D8KKxpqM2gZ+m
	G4Wkrs9JFYpCsp8rx75VoumsJ4fU6A0=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558--RUEwY_kOwOXNPZe0vJqaw-1; Fri, 17 Oct 2025 13:13:31 -0400
X-MC-Unique: -RUEwY_kOwOXNPZe0vJqaw-1
X-Mimecast-MFC-AGG-ID: -RUEwY_kOwOXNPZe0vJqaw_1760721211
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-290da17197eso14516925ad.2
        for <fstests@vger.kernel.org>; Fri, 17 Oct 2025 10:13:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760721211; x=1761326011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3oH+JLZtPmhaQBCzs5M5q290f+e5pQcBKbkdAyZCCUc=;
        b=fL29JBJgMvb3z4S510J7in9zO3zi2nSjTfNSdgrM2Rag/u38yOGC7sbolWcF8uqMg5
         0KFlst41SiZ8LL1nunn1FktTD4V0DQNDWhnzNnTNL/AZET76dN79DKtF0v6ECqtH5WcT
         bvodgiJoEfVFjnn4rRRcCJ/Hc7YKv6M9EuPUlxCMwPqZ3mlbVZa8oj+4Z+g2X8FOy5Np
         dAKGeK5eeIJxUPf7HCwgAGHw8sYPbCCOK5tDDMQJsaRg8efygmwglR6GIqZNzX9EfaxC
         lOR5tsXxHYvJgBh/ZEX06r9HP+P81To3jPt6aEqQNzzNnbH85EYwMRZpfI7ANKoGDv/L
         3wAg==
X-Gm-Message-State: AOJu0YzBbHaEe+UXCZhthiguYnOwBK3y9eDFRDDrnnpMeqGqo9xbOnzQ
	OTmyPSgrEKWLdwpoLLD9F9hTPYV10o4nl4RZBmMfnGfTCssA0LntIdhpPvN5+rwNgdj7V280X36
	VRhh3XcJdE9HgifBeUAB0f9LfbSfTl8aiskeq4OjNmRurzsm6W43tbpGq3EM=
X-Gm-Gg: ASbGncsPb8/bfRnCq8F+8apftsECUTuT1IqnD/ztI82FJdevon6ihtA/1+3Ff/GtEs2
	Qe4lw7GEFiJEiUrB7Vt+zw3pHmfShTEEJSoto1GX7hBPnt3lfRPQzSL8v4Tojxhistv97lCpNxK
	6Vv64Nv+xm8cICIattsXfkz72B5HSzBGTTj1voNuRqHegTJHHEGi4nX2ikxNpNMLFPixJQCLOoQ
	C15YSG6vxuPQ9OShUYf5GLR5DysijzdSu08Fi3tRbbMCQtMBK8byZpLYMyjLekN+V68COKzeG6Y
	jkfemPNJOjNSxjoalTtgyD0hVBlE7a3aeyLC1sPPJllaKKkwUKasN4P/gqBjLGrkQf58LDvDmO9
	h7TGyqanoGRKrQ5+Eh08ASWdOx7QHhgiPbCfmsFM=
X-Received: by 2002:a17:902:ebc6:b0:290:9a74:a8ad with SMTP id d9443c01a7336-290cba41dc7mr49790845ad.53.1760721210536;
        Fri, 17 Oct 2025 10:13:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbtm0LLhBl1rlaDnMsaDwvVnWrH3jQfQnns6FlKnwY1B7IPleG4xQHqEgv+4VDuDOp3wi7cg==
X-Received: by 2002:a17:902:ebc6:b0:290:9a74:a8ad with SMTP id d9443c01a7336-290cba41dc7mr49790545ad.53.1760721209989;
        Fri, 17 Oct 2025 10:13:29 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fd9ddsm274415ad.89.2025.10.17.10.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 10:13:29 -0700 (PDT)
Date: Sat, 18 Oct 2025 01:13:25 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 7/8] common/attr: fix _require_noattr2
Message-ID: <20251017171325.b35z55fbubi3kxut@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <176054617853.2391029.10911105763476647916.stgit@frogsfrogsfrogs>
 <176054618026.2391029.1336336050566653412.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176054618026.2391029.1336336050566653412.stgit@frogsfrogsfrogs>

On Wed, Oct 15, 2025 at 09:38:32AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> attr2/noattr2 doesn't do anything anymore and aren't reported in
> /proc/mounts, so we need to check /proc/mounts and _notrun as a result.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  common/attr |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> 
> diff --git a/common/attr b/common/attr
> index 1c1de63e9d5465..35e0bee4e3aa53 100644
> --- a/common/attr
> +++ b/common/attr
> @@ -241,7 +241,11 @@ _require_noattr2()
>  		|| _fail "_try_scratch_mkfs_xfs failed on $SCRATCH_DEV"
>  	_try_scratch_mount -o noattr2 > /dev/null 2>&1 \
>  		|| _notrun "noattr2 mount option not supported on $SCRATCH_DEV"
> +	grep -w "$SCRATCH_MNT" /proc/mounts | awk '{print $4}' | grep -q -w noattr2

How about use findmnt? e.g.

    grep -qw noattr2 <(findmnt -rncv -M / -o OPTIONS)

> +	local res=${PIPESTATUS[2]}

Then the PIPESTATUS isn't needed either.

I can help to do this change if you agree.

Thanks,
Zorro

>  	_scratch_unmount
> +	test $res -eq 0 \
> +		|| _notrun "noattr2 mount option no longer functional"
>  }
>  
>  # getfattr -R returns info in readdir order which varies from fs to fs.
> 

