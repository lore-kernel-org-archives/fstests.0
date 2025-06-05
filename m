Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCAB198A2F
	for <fstests@vger.kernel.org>; Thu,  5 Jun 2025 15:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749136967; cv=none; b=ql85kzQBFZg1USM19pTy+nvM1A5QRDXARwpItDOtbG3X/z3lEhxBg24GBZa2VX0/2IBzAlOZw8rJQQYbHMU//F5VXLbVcFw6rFeKbJRZ9BvlUoX6i18fPFo6NZvyuu+v8D/2UcvZ8ln9yGYnG87iRvLlTg4hveOxYDQG8CgP+go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749136967; c=relaxed/simple;
	bh=9h5SQ7keCAxwBKy42Fl24ub0JV5fKhaSB+kS1/Hym94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nj05iqjNZS7J50qyJWnG0zvtLSOhSrnNJ9E03sGScVU+u0QESkP16oayNBcFJG89eptktjbx7l9dxfLTVZaXTgTmd+6KQ2b9QpesU1uzbGZ0lIuqnoc95VAnk6T4t2rQuCQqYWHD2EO7FoCGV3oLXJsarGolZlheODEx0siTygY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V91BX3TQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V91BX3TQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749136965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eXdnQwGuwYfw6IGH+CaRVGfY/CpzvAp/fNyAN6ExT24=;
	b=V91BX3TQZZKqHt2x6mnqUvUoy04OElqNAgsUNGdRqW7Xts+Uj4GY/q3Vyh6Svd+LjYK2qu
	rjr+ybt+6famKEuWXfC0NW2TY8oavJVxIjIYasWCXybwdvAzlLjFUpFQyVFvA/xWlkRtZC
	xOm8PSiulASdh9TQlfHrnt/6sNcaDWI=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-Ylshve7tNpGdw3X9od1pyg-1; Thu, 05 Jun 2025 11:22:43 -0400
X-MC-Unique: Ylshve7tNpGdw3X9od1pyg-1
X-Mimecast-MFC-AGG-ID: Ylshve7tNpGdw3X9od1pyg_1749136962
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2354ba59eb6so16032415ad.1
        for <fstests@vger.kernel.org>; Thu, 05 Jun 2025 08:22:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749136962; x=1749741762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eXdnQwGuwYfw6IGH+CaRVGfY/CpzvAp/fNyAN6ExT24=;
        b=AKx8SLru7xZ63THLM1no11CtFr+ShfG1P9vF5qrHcMopSpAmyAV8BjNsySErVSV6AB
         sqa9uj1rDOtGBsvy7Z+Mqp5nV1p82X0VgkxQtYVTHMqnzH3XygflJRsUhO9MfYC7e8Ok
         ogAPk32f5rbakHWbQR8WrLOUSVzYDGL1ev+EHl24Jzwm9U2ZHSIZxWSbibjX8fdivvsS
         T1gjkEg5UNrZs3ZMiSS1yqa4d4BhlfHll6Tgb7QIn5h1dRhR+WjEKSS9N15MtuUwmW7P
         dymqdQOpbG9X4Mc1o5kVoCeSH57r17+A3oshdMqlwvdcqqUWbLJ3MMgsddCItx64CFim
         RNEw==
X-Forwarded-Encrypted: i=1; AJvYcCV6ZbBFVjMrkPrl2wfKOrq0dzl4GM7VooYTwtRbdeqHUOrv4I/6zLSVlTn/UyGwMA5fNOnFkgVt@vger.kernel.org
X-Gm-Message-State: AOJu0YwVVYBwsMp0PCC6xYYCzbYA5xU/vNzImnB6tBtZtKTWGPrbAd4A
	RiwdHNbApwZKTlZUFrATZdl3uiydjqlPRZBpl2851TkGGFF53W2Lg4AQ9Fq77oL5zVzN0zRUonn
	HMZuoKNL559u2/Qpo8dlyB1+gw9wtslWnxbCNIpOB8Oj/PJWTEd55+Fpd6Pxs16qCqo0=
X-Gm-Gg: ASbGncuGuRGHh5cL6rrEhEF4sDVrILgxXmKcei/WFMkwlq668P8SqrE7CUfwbzzAXss
	fcgJw0uvnPFmIOv7BUlzJEjHsbhl+JtRT68pGqj9eX8QqKq+Vo16Roob5pa1iL2lZnilgjGLobU
	v9d6wOJWmZVxxW9FHdyWrcA4nSMTG3Ewm3xAgtGxbNWqv4hNpBRTULK142bEgN+eO+NSGgnuoNj
	/B0t2CiM/y8CHgHxpKZN15kEij/xqX0svM6nOt6w5yTMjv+8N7htnHd08uHO6pODFsFfolZMi8e
	rfsWiQv9auWzuKqRy5pYoPYz8GyDfQmRMdmEdoEqIrOinQDn6lbY
X-Received: by 2002:a17:903:2b05:b0:235:ecf2:393 with SMTP id d9443c01a7336-235ecf20d49mr74985745ad.53.1749136961638;
        Thu, 05 Jun 2025 08:22:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGte4qPuYisCnM2B5WMJZExB4Cu8znL0CFUkseba1aXFzqci7OEYJVNC3epgs62ZUWgeQWOig==
X-Received: by 2002:a17:903:2b05:b0:235:ecf2:393 with SMTP id d9443c01a7336-235ecf20d49mr74985265ad.53.1749136961170;
        Thu, 05 Jun 2025 08:22:41 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-235ef2e6241sm18360845ad.21.2025.06.05.08.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 08:22:40 -0700 (PDT)
Date: Thu, 5 Jun 2025 23:22:36 +0800
From: Zorro Lang <zlang@redhat.com>
To: Yuezhang Mo <Yuezhang.Mo@sony.com>
Cc: zlang@kernel.org, fstests@vger.kernel.org, friendy.su@sony.com
Subject: Re: [PATCH v1 0/7] add test requirements
Message-ID: <20250605152236.mmk7zfvcwzf6mcho@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250528091530.1218188-1-Yuezhang.Mo@sony.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528091530.1218188-1-Yuezhang.Mo@sony.com>

On Wed, May 28, 2025 at 05:15:23PM +0800, Yuezhang Mo wrote:
> These patches add test requirements to the following tests so that
> they do not run on filesystems that do not support these requirements,
> rather than causing the tests to fail.
> 

I've reviewed this patchset, now most of patches are Acked, except ...

> Yuezhang Mo (7):
>   generic/696: add _require_chmod
>   generic/656: add _require_chown
>   generic/754: add _require_symlinks
>   generic/755: add _require_hardlinks
>   generic/730: add _require_scratch_shutdown

This need change, but as btrfs list hoped to have it too, so I can help to
do this change when I merge it if you agree with my review point.

>   generic/645: add _require_chown
>   generic/633: add test requirements

This need more update and review, so I'll merge this patchset without
this patch. You can change and resend this patch singly later.

Thanks,
Zorro

> 
>  tests/generic/633 | 6 ++++++
>  tests/generic/645 | 1 +
>  tests/generic/656 | 1 +
>  tests/generic/696 | 1 +
>  tests/generic/730 | 1 +
>  tests/generic/754 | 1 +
>  tests/generic/755 | 1 +
>  7 files changed, 12 insertions(+)
> 
> -- 
> 2.25.1
> 
> 

