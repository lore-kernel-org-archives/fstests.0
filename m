Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8841A1BAEF3
	for <fstests@vger.kernel.org>; Fri, 23 Aug 2024 20:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724445106; cv=none; b=saLDDOqt5Ai+wzNR/BerrFaC50pnWkUoQqKW+5VXBkXnxgjDMyjLLiELMVW1toCgmp6vVnDUaPGldPprUujDWAO6SPZzRrJfs+NTJQEQbIqWhJnv+SqFI8LxnQ0DFSqgYRNqMdD+WYWgarGLnUUzqzBfiw8cksH+CWvsaoNJWqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724445106; c=relaxed/simple;
	bh=7UGIoSG4+2JV64amm8AvPMtAJhZOKygM8S1WefUXL0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fxpDiT96lamwNAjeHUOWgaXfc+/n/NsSJioR2LRJLqzZlA06z23kV1EqMLcj0iZhMZXd/mZ6k2Z/26zO9rvLMwku7v61kQYh6VV7lgmg4leHuag7r4W7vBSHTJU62FLH72yNqzOvE/mVx1d3YfSjraVTmpuVTxBmpH/e2BIu1ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bS/xditC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bS/xditC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724445103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=21iDdFJvFfrpgK6XNXo0EuYKR1kO6/cL30Vkc5zhtms=;
	b=bS/xditCcdTqrYUg9Sk6GKLTYzSu4R1ZNnDKqP0Ivh6Tjl7a90VLcsb3LcEVc7F2iR8ITN
	Y5YytvJuXgnpJIxmSPmjcDM/mokpGn/CoUP+HN4VXpHqllLH+mUt5zirjGNmdnL8dz7B49
	tWP06IT/OkrGzsMHBBKNtj8NPsHO/cA=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-b_Ytt6S2NYuytbScewI2Ow-1; Fri, 23 Aug 2024 16:31:40 -0400
X-MC-Unique: b_Ytt6S2NYuytbScewI2Ow-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1fc6db23c74so23293435ad.0
        for <fstests@vger.kernel.org>; Fri, 23 Aug 2024 13:31:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724445099; x=1725049899;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=21iDdFJvFfrpgK6XNXo0EuYKR1kO6/cL30Vkc5zhtms=;
        b=uf54xFjAoI/cpknQ2BLATchof5I17Mwz2CJVQxs2jtBYYyuSn8PNn0yo/dFmL/7YB6
         r3eS9QrGz9d7+BjQHiwLGlixeXp6JbxLlEpQXosAOfKlJhzsgdJaEyIO/npcdGWyyD5Y
         5vqrC0b280Jq6cpgcCbTiDd85eWDQfxPVnxSoIG7/SFk3OcNFvUsppZJO2+9vyiKQ6w3
         vbWUQ6kBZ0UNXG7sIZ5u6eAlUCbgjusSxQnI4FGleyUIDf2+bd9QZdN/VKpNqeS4Fh5U
         iqYUq9uqvkRT7Wa3NaTsAT2X1/HSILeQlprfnaP/kQYwRt9H199P5Bu/+36SxrhDydTX
         ma6A==
X-Forwarded-Encrypted: i=1; AJvYcCUDxahQq/IUgLqJRmZG0nlylFcXq2s34AymGXnrzIyB9pmALCVTQYau0JK/QIr2qH6YeEDhFJrg@vger.kernel.org
X-Gm-Message-State: AOJu0YyUlxH8fmZetRzgeb1kybILXERpREdk/z6l4S/bVlQf0DsJW07U
	uAf5qfHK+hXrxNc84aV/ManoeKO/6KDaWrDemYuGi9Uiyc1OPt9pOYQj2aTbPl9/aJvII6NCozt
	zykQDl/6Xm9dvqh4JvT1inN5HMBMVDmefpwLmsnWheK1MEEbFBWJlyTW2NUqFgMubeA==
X-Received: by 2002:a17:902:e5cd:b0:1ff:4d66:d7bb with SMTP id d9443c01a7336-2039e4aa96fmr40138235ad.36.1724445098881;
        Fri, 23 Aug 2024 13:31:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFb/GXehxfpPSqKtD9S9ZraTTlz5nqmc4n6I9CSKD+dSt49nT+v+Q6dISNA4Xsvfp69qXCHqg==
X-Received: by 2002:a17:902:e5cd:b0:1ff:4d66:d7bb with SMTP id d9443c01a7336-2039e4aa96fmr40137935ad.36.1724445098333;
        Fri, 23 Aug 2024 13:31:38 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855e1854sm32421825ad.178.2024.08.23.13.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 13:31:38 -0700 (PDT)
Date: Sat, 24 Aug 2024 04:31:34 +0800
From: Zorro Lang <zlang@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: zlang@kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] generic/615: add to the quick group
Message-ID: <20240823203134.euzlj5puxjuz4634@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240821044743.603691-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821044743.603691-1-hch@lst.de>

On Wed, Aug 21, 2024 at 06:47:43AM +0200, Christoph Hellwig wrote:
> This is a simple and very quick test, add it to the quick group.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Good to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/generic/615 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/615 b/tests/generic/615
> index 71cdb9ac8..66dd1aa08 100755
> --- a/tests/generic/615
> +++ b/tests/generic/615
> @@ -9,7 +9,7 @@
>  # zero while writeback is in progress.
>  #
>  . ./common/preamble
> -_begin_fstest auto rw
> +_begin_fstest auto quick rw
>  
>  # Import common functions.
>  . ./common/filter
> -- 
> 2.43.0
> 
> 

