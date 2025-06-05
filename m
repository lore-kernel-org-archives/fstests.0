Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5422B145355
	for <fstests@vger.kernel.org>; Thu,  5 Jun 2025 15:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749135982; cv=none; b=FXT9YUT4NU1oFJfdWh2//uz4mONdNGyy/YO99yzayERrn6w3+gr0cEq4NI3uPlsl/MYJSrSaP+uNQyF68KjV9rhjOj06Dl4KBMkA8bbAGIhYYmul45e3LynI214oQVlbkmKN02WZnb81ddQ63Avy7x099NiT4H3irtELAlBXpoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749135982; c=relaxed/simple;
	bh=zLeL9Zy8HUJlpftgA8juBAFIJd3hB74Lnf2rHujOZYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qpa8Av5vcaccDoov01jEw+nzKbudfYrHlRojq0NSTBlGY6LnTUqERMFkY+PvKuLybbxHaj+qCYJGseP/Q5ir/2B2K/z0uQHy6I3ieWjw/KWe+b6vTOWmgf3KuDXYUwgWrC2CZIvWb/PGFH5Hz1ezdK8BVf7FForjmHD50p+XSl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=INBZm75P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="INBZm75P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749135978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nvlwCv5XzZ4LOTqAk1EKfRfSoskhki7OQEcWAA0ueGk=;
	b=INBZm75P1hBFL4tX9JKIjQnnKnuGZKlMNGSPat01r1JOfTnapYJdKXlGAE9KFi8yrFWwmU
	qcX3mBY+eM4dxe7QvZ8i7pZ5QAhJSIZ8pniUa4mxcn90Ok8Cp9isiTGp4h7GmyUUG1B0Mq
	LlUNoPhmv0A2lOWfymtZE0Lb++B1pxQ=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-J6FsOmacM2iW8gjYrLAevg-1; Thu, 05 Jun 2025 11:06:16 -0400
X-MC-Unique: J6FsOmacM2iW8gjYrLAevg-1
X-Mimecast-MFC-AGG-ID: J6FsOmacM2iW8gjYrLAevg_1749135976
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-e72ecef490dso1597832276.0
        for <fstests@vger.kernel.org>; Thu, 05 Jun 2025 08:06:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749135976; x=1749740776;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nvlwCv5XzZ4LOTqAk1EKfRfSoskhki7OQEcWAA0ueGk=;
        b=Du2P6kl8IowB1OHniqfojeOT8qPaJK7KvzbUgKoum+F471VrQkWBq6huqTonAgn7Yn
         jHmvIV1AnDq1yCi4upsdYfhRyJGGqiSDpdBG/gVZkojLP0pbR2OC8OFuaGNJPyNfH5Wb
         UF1yV9LX+3oMV4+fYALrrBxwGzBbtAd9GfTicgb3vrVI2TWxGiLxrzUxViiIPS3rx9Hr
         vdLDEFfpduLycm5hQCVlW0j5jikYLmmtDTvE65gNInQeevcF4fSStX2gSUoPOjqH6RNJ
         s/+gCeBdh5lf3VBC/K9o96xjWGKq3dHSKP9dHr/1zWp2VLixk9TIrCuCn9jD9+G7hX2I
         DNlw==
X-Forwarded-Encrypted: i=1; AJvYcCWOiWYzzOHH85MwktXKZnY2paTgoDwvckr7/OYeZg8NKb7uAqxluJJxupLxA1D06E9a1CU116zW@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9W3TO2jeTMULeplGX/cTTQVa9UC7JUXGDmHtXFW0t2sYJ7eOj
	1CCMF5igJr6NUYXYDZFBeHba9Cm6EaOHnBYy2lmzFZTx5AmHdmvrdZbUAV6MCf50wUyn6gWHGD4
	WNzoSXi/gUTc6u6wSyalvhA7XU0/ADG8fPhasFoCjsB3/p7HZJA/YdnHmeYOzaiutFOY=
X-Gm-Gg: ASbGnctywwuXlOFXzrkBD7VwdQvHX8mSwXELCf2nX1+5BpLmCTdF2t0hz4ntivP1T15
	YkbkfPDSs7fkSIH/nUELvhiMShn5NaQwcv78C1as9KwtAbey3n7xVvRmdbV5qPXEFx4NyMsJI6g
	ONoweQwOJFAM6v9rn+hhHPFbevIQZIAfD0GM0Me+m7USPvqJ0j6FUwKlHLP5McRfIhNLG2F496N
	ia01SWp8/qyqd6+Dw2jNEyHBrK8c6+cAMwOmmI+YOycHpW+h71sWu218nZdKqPLcK8EjF8wGOJG
	XtW1zfBVhmIqDrW/cZoITztB8oweuweZ9pDi/DP2Ykn0vvtsqRdT
X-Received: by 2002:a05:6902:2e10:b0:e81:a1d7:5f78 with SMTP id 3f1490d57ef6-e81a20d3b75mr151870276.8.1749135964638;
        Thu, 05 Jun 2025 08:06:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNZfEUv14Zls0cdtwm8wWBtSTLpm+3uIo406hAu5oNYhQj+2Gx9831A+R+fIU6+K+RXAZFPg==
X-Received: by 2002:a17:903:2305:b0:235:91a:31 with SMTP id d9443c01a7336-235e110ddd2mr83941405ad.8.1749135953372;
        Thu, 05 Jun 2025 08:05:53 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cd75d6sm120950315ad.123.2025.06.05.08.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 08:05:53 -0700 (PDT)
Date: Thu, 5 Jun 2025 23:05:49 +0800
From: Zorro Lang <zlang@redhat.com>
To: Yuezhang Mo <Yuezhang.Mo@sony.com>
Cc: zlang@kernel.org, fstests@vger.kernel.org, friendy.su@sony.com
Subject: Re: [PATCH v1 1/7] generic/696: add _require_chmod
Message-ID: <20250605150549.ek6zkott6n72vmsc@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250528091530.1218188-1-Yuezhang.Mo@sony.com>
 <20250528091530.1218188-2-Yuezhang.Mo@sony.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528091530.1218188-2-Yuezhang.Mo@sony.com>

On Wed, May 28, 2025 at 05:15:24PM +0800, Yuezhang Mo wrote:
> This test uses chmod to set the S_ISGID bit, which requires chmod
> support, so add _require_chmod to check for chmod support.
> 
> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> Reviewed-by: Friendy Su <friendy.su@sony.com>
> ---
>  tests/generic/696 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/generic/696 b/tests/generic/696
> index d2e86c96..8731cad2 100755
> --- a/tests/generic/696
> +++ b/tests/generic/696
> @@ -20,6 +20,7 @@ _begin_fstest auto quick cap idmapped mount perms rw unlink
>  _require_idmapped_mounts
>  _require_test
>  _require_scratch
> +_require_chmod

OK, this make sense to me, due to I hit below error too:

    +vfstest.c: 1781: setgid_create_umask - Success - failure: is_setgid
    +vfstest.c: 2418: run_test - Success - failure: create operations in directories with setgid bit set under umask

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  _fixed_by_kernel_commit ac6800e279a2 \
>  	"fs: Add missing umask strip in vfs_tmpfile" \
>  1639a49ccdce "fs: move S_ISGID stripping into the vfs_*() helpers"
> -- 
> 2.25.1
> 
> 

