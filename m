Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1195146D7F
	for <fstests@vger.kernel.org>; Thu, 21 Nov 2024 10:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732183408; cv=none; b=gQUu4Cfr9JlY56W8s+IlJBaVan+vp7sf92mNYXzQeS2/fNO8pbEv7OaEjRI1/sdhGK1sQ+dW2YgCLLO+uGtIyFvqUuxW/eja7kOqHqX8f0dVa943oRs2bVUc3cnZW+4o3C/wu+Absghvr5UHSxvcehny/RWO7LznnLnyOBb+Gzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732183408; c=relaxed/simple;
	bh=1DikyKK7WvdLlZBgmNsnOJ4Jly6gUydvJnU+pbZw/q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWKOLpXfIn4Anw7egwzh9SwzFZfMRqsGm6dk0cm6S9frIU9unc6KwAb6kX+jKNPOxPxfvFxb1WtD7KawazKTqYu862YUTjCcDxJAdN0LE2TCMUByj7VNJtmfiE/Y0v20DcZt+DYTU8o3Q+EMEZ/nHVv0npU25a6OI1uQAkyvx0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ojjoe+DM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ojjoe+DM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732183404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CaC/ipvdWYgdC+g1YIvlQTYSbe7hpMUyqF9C7dD/4cE=;
	b=Ojjoe+DMHAkOZQQ41/e8dvkeJUDKe6d3a3+5fSPRaomwZ03A3pTo9uzaEJe4XldaFZ0uXv
	aCYvj4z5ctNmYPaCvWDyIauqupkMaDMCKVz9BeHNufWQ/883DwmbXSsCpJGo5ee8lWzdR+
	VtARNBeZjgd5pEwzkbX2rkMo32CvCpk=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-GKuZYyhtOx6Yv6T8GuD3XA-1; Thu, 21 Nov 2024 05:03:22 -0500
X-MC-Unique: GKuZYyhtOx6Yv6T8GuD3XA-1
X-Mimecast-MFC-AGG-ID: GKuZYyhtOx6Yv6T8GuD3XA
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2124902b13bso6591095ad.2
        for <fstests@vger.kernel.org>; Thu, 21 Nov 2024 02:03:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732183401; x=1732788201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CaC/ipvdWYgdC+g1YIvlQTYSbe7hpMUyqF9C7dD/4cE=;
        b=WDq/8Z4ofCSt4RKray3IKB4bq1ZRpuJ2AZJTcB4Sf+Nltqja/tvsgAjd3TpAm3gOoI
         7pWhsxmkPk6nXf2OiGxNEi7/pjxMj51zYVOJlvS8QgOePLRiT7ArfgFqapOXnK+kn1Wl
         xrG7nfSjP4b+Nkf1XyR/1EL3PnbKhXd0I/65BK5jIzXWeCPeg3v5hNYE6dtrUr0o3J1r
         7dWDx/UAul7xbHj5ZzBwzKQo36qfe4ce6i1Ff/1kBYQOBp2noeECBBFC7lfaA+kgeZl8
         GiCU8yY5SxUaTD5+O3b4gmYNIo0u/y+FygMK+bIC7cTLDYdlVF3bgYeDFLqGCV9Qz9Kt
         8K8g==
X-Forwarded-Encrypted: i=1; AJvYcCW9IAGUIyKOTpNDZVRaDbkPJ4EbOL/CvoR0EyCPDVfSslEmfFnBFGcZ/T+mZ7IOvGBmDivqXqCX@vger.kernel.org
X-Gm-Message-State: AOJu0Yw83J5pjIZpq9ZlnsbS2NcOn3MC76Vv4186BvnwwN2P62DwpsVh
	Bx93HOvJw9l/4hnmxu8XliTZj7jIbxR6XaWhHgk0XM5mM7xM0KPnSUQbodtE0kElhU3GF4qSvdb
	46RNDIe8YLjAONSSBaX1ACV3m8vXZ6LYdsyMwnRKbRTyrhtpif9VvphU=
X-Received: by 2002:a17:902:f551:b0:20c:aa41:9968 with SMTP id d9443c01a7336-2126a49ddfemr83444575ad.53.1732183401494;
        Thu, 21 Nov 2024 02:03:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGiFOED9gXnf0cEhe7CQvRNF+jWARUlG9zyCyXXLBg46ifFj38fBdUHadvrECr+GhtCqpiWUA==
X-Received: by 2002:a17:902:f551:b0:20c:aa41:9968 with SMTP id d9443c01a7336-2126a49ddfemr83444225ad.53.1732183401112;
        Thu, 21 Nov 2024 02:03:21 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-212883fde4asm9993755ad.259.2024.11.21.02.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 02:03:20 -0800 (PST)
Date: Thu, 21 Nov 2024 18:03:17 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@kernel.org, linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 11/12] xfs/157: do not drop necessary mkfs options
Message-ID: <20241121100317.zqz6l4z7kawqxtia@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <173197064408.904310.6784273927814845381.stgit@frogsfrogsfrogs>
 <173197064593.904310.9005954163451030743.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173197064593.904310.9005954163451030743.stgit@frogsfrogsfrogs>

On Mon, Nov 18, 2024 at 03:04:15PM -0800, Darrick J. Wong wrote:
> From: Zorro Lang <zlang@kernel.org>
> 
> To give the test option "-L oldlabel" to _scratch_mkfs_sized, xfs/157
> does:
> 
>   MKFS_OPTIONS="-L oldlabel $MKFS_OPTIONS" _scratch_mkfs_sized $fs_size
> 
> but the _scratch_mkfs_sized trys to keep the $fs_size, when mkfs
> fails with incompatible $MKFS_OPTIONS options, likes this:
> 
>   ** mkfs failed with extra mkfs options added to "-L oldlabel -m rmapbt=1" by test 157 **
>   ** attempting to mkfs using only test 157 options: -d size=524288000 -b size=4096 **
> 
> but the "-L oldlabel" is necessary, we shouldn't drop it. To avoid
> that, we give the "-L oldlabel" to _scratch_mkfs_sized through
> function parameters, not through global MKFS_OPTIONS.
> 
> Signed-off-by: Zorro Lang <zlang@kernel.org>
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> [djwong: fix more string quoting issues]
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---

Oh, you helped to merge the patchset at here. Thanks :)

>  tests/xfs/157 |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> 
> diff --git a/tests/xfs/157 b/tests/xfs/157
> index 9b5badbaeb3c76..e102a5a10abe4b 100755
> --- a/tests/xfs/157
> +++ b/tests/xfs/157
> @@ -66,8 +66,7 @@ scenario() {
>  }
>  
>  check_label() {
> -	MKFS_OPTIONS="-L oldlabel $MKFS_OPTIONS" _scratch_mkfs_sized $fs_size \
> -		>> $seqres.full
> +	_scratch_mkfs_sized "$fs_size" "" -L oldlabel >> $seqres.full 2>&1
>  	_scratch_xfs_db -c label
>  	_scratch_xfs_admin -L newlabel "$@" >> $seqres.full
>  	_scratch_xfs_db -c label
> 

