Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9124F2F26
	for <fstests@vger.kernel.org>; Fri, 11 Oct 2024 05:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728625182; cv=none; b=DoZgAe3h4rULURugV4uZmvI0rX+P06RE5P3ArGTPkz33Mw1oQ5QSDZ6eM6N0RPepaSWtwsLNFopX0/mnIXq4Gbu0X+lCZrVixOYR22Ae3iSm2OSf8PpYhJMci3ts8flqnsLpvW64b8t0RvPtyY6AwjlJbKomeHDBBomyGqW+g4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728625182; c=relaxed/simple;
	bh=FY8dro+fQSldwsk2SDB9liE1I1TdjiKmhK8fdx4vgLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gjI/y9gEBqtC+TzAUsGOUbf9gmwA5zuTgqO3b9a4EqehdCWfIzH1JuqM6ucTpTPj6V6pFF1h3K+HuSEQb/UFSgl2J7vEEmbNen4vT+nB5SvdTDx+piP3PnJ/NDGRP7iF58tsZnE/RJ7HZtEhXoGtKd0jZKYxm38t8jjXuPAoKWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hSy6gvVq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hSy6gvVq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728625179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E79pAvdKc/BkOQp74IhpxCVTpYEs/kRwmWW8Rw2mzQ4=;
	b=hSy6gvVqfXtC+bZUGtay2d5YggOXyO3s5UYwhCu106QIVyBcleXGvHjZDqH4l0YW8TNAD7
	a6hffttTivUl63jmVC9asLe6/PX3wpSaYleHCucGGP3iy2W7WS2FzqjakcekjIZ39hbXLn
	DktIshMJ+AYaeWwOg2HmQXBq+AKFHDA=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-Xl7PzQZzNOOLNFvtvxfrVg-1; Fri, 11 Oct 2024 01:39:37 -0400
X-MC-Unique: Xl7PzQZzNOOLNFvtvxfrVg-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2e2ed2230fcso629218a91.0
        for <fstests@vger.kernel.org>; Thu, 10 Oct 2024 22:39:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728625177; x=1729229977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E79pAvdKc/BkOQp74IhpxCVTpYEs/kRwmWW8Rw2mzQ4=;
        b=BjYBWxbxKVtJUM0bPlouf03CT2ZdNOqNliijy1/gp5U1fLCAn/1tlEF02WBf0Nn3S4
         ZBMYho8selBGTEWRn8IxhKubbySlFqNyxiqh/T7m8omFukFoA9Hj7kjkL27nMXfdAaZO
         OlabE9Pf9lTVbn8IZINF5RGknUOWLq8QWrcuh5UlWvc5bDb8s+tyZyCkSkdb6Ok9tbSV
         BC/NsZl2meAsDaAmTjnLMe3mW52eLRH1wW5dP0bKj0eQPOpibUmj+98u6IZluc7LqWb/
         pxSp/QlO545WJRSFVYzB5RlDPb1sRcFmcdpPLZU3kwYEOxUfeUBUzFpnTVTprvLG++82
         PobQ==
X-Gm-Message-State: AOJu0YyHUxwV9EqnXWSq5JsmAjD/HYp57Ox12qxU9FaOZk1DTVFG3HSN
	w6T8XBeY/gQSveXpCM8ZQUZHhwB/04fyw801n+dqjW+B9zNybZx2HeyOqWotpRwbXCpk0tbCZ2y
	fqc3FzxpON11paAALERRMhsPo0FzlfUHoR26n079pcoeVZ1YdeTTUg/I=
X-Received: by 2002:a17:902:ce92:b0:20c:98f8:e0f5 with SMTP id d9443c01a7336-20ca169e8cbmr17041845ad.43.1728625176862;
        Thu, 10 Oct 2024 22:39:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5smA5lWm7abyTGDBLpFVDgRase/NCR7N+WEFP/CrDFznXyx8zVyg1ZkuLsSgtWnYoIL/H2g==
X-Received: by 2002:a17:902:ce92:b0:20c:98f8:e0f5 with SMTP id d9443c01a7336-20ca169e8cbmr17041725ad.43.1728625176438;
        Thu, 10 Oct 2024 22:39:36 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c35f35fsm17403345ad.300.2024.10.10.22.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 22:39:36 -0700 (PDT)
Date: Fri, 11 Oct 2024 13:39:32 +0800
From: Zorro Lang <zlang@redhat.com>
To: Mark Harmstone <maharmstone@fb.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] common/fail_make_request: fix error message
Message-ID: <20241011053932.3l4xfsdel3iziw7g@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240731114150.2259760-1-maharmstone@fb.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731114150.2259760-1-maharmstone@fb.com>

On Wed, Jul 31, 2024 at 12:41:33PM +0100, Mark Harmstone wrote:
> fail_make_request depends on the kernel option CONFIG_FAIL_MAKE_REQUEST
> to function, not CONFIG_FAULT_INJECTION_DEBUG_FS.
> 
> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
> ---

Make sense to me. Maybe it want to write CONFIG_FAULT_INJECTION, anyway,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  common/fail_make_request | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/fail_make_request b/common/fail_make_request
> index b5370ba6..56402021 100644
> --- a/common/fail_make_request
> +++ b/common/fail_make_request
> @@ -7,7 +7,7 @@ _require_fail_make_request()
>  {
>      [ -f "$DEBUGFS_MNT/fail_make_request/probability" ] \
>  	|| _notrun "$DEBUGFS_MNT/fail_make_request \
> - not found. Seems that CONFIG_FAULT_INJECTION_DEBUG_FS kernel config option not enabled"
> + not found. Seems that CONFIG_FAIL_MAKE_REQUEST kernel config option not enabled"
>  }
>  
>  _allow_fail_make_request()
> -- 
> 2.44.2
> 
> 

