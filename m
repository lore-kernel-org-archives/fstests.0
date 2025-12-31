Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CC430F532
	for <fstests@vger.kernel.org>; Wed, 31 Dec 2025 22:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767219981; cv=none; b=AJ3BmtJOmckWR/AQTigbqegGNal3eO8Pd3qsUSV3zS0f75CuogQfWgHhHqD5mHRRyvF/cwAddEaD9G0C6vWUIu8uz3A/q9UL4A8MSlD3Vj+2Ksgh2HzYx5EPiiAH8/zJGSm3YTjNqgZ5q4NAp3XKUCBBfdMSYn/XgBYgG33dsig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767219981; c=relaxed/simple;
	bh=4pqBk5aAIRoNhif2HO1/nsph/bdQj38c2Yo89j0sytM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IlxTn3NGsc+3atEC9oPYyfT6nxPohOVYIdtUlaE8WlSGI7hHWnIaLo7xAkKL3V1fFYS92ZvaMGtPu0zbjU1awC9XamsnpyuDljgPeL+IL42169m3bWwuB3ld798V8K6AR3YpbHwFj/WpaaD7LP5xTGKeQreHeYSrMM+6pPvu7Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aMAwpvxz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y+2fVcWd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aMAwpvxz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y+2fVcWd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767219979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QiVsfjKNJCcO38sVQpJEBYAeq0gcXWkKlGmVCeZEjpI=;
	b=aMAwpvxz9X6b4RWLRODZOuvVomhqGdXzdMoxUBX8qC3qXAZ1PDWiGUhx7lKw15M8RBsR3E
	YIVZhu8k9pcKXIhrFY6pUW2t73gocY1XGx/y0ea1FlZCIcP9diBD1ATPUZO2aMxYbJnvqK
	zngWyjpjkXr2AhZrs1lLN+ONblWcHx4=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-_qpa5JyHPSaXEmqRa9uqpQ-1; Wed, 31 Dec 2025 17:26:17 -0500
X-MC-Unique: _qpa5JyHPSaXEmqRa9uqpQ-1
X-Mimecast-MFC-AGG-ID: _qpa5JyHPSaXEmqRa9uqpQ_1767219976
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34eb6589ed2so9893142a91.2
        for <fstests@vger.kernel.org>; Wed, 31 Dec 2025 14:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767219976; x=1767824776; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QiVsfjKNJCcO38sVQpJEBYAeq0gcXWkKlGmVCeZEjpI=;
        b=Y+2fVcWdXTvQdwcVgk2KKQXcE336pam9wBr8DYkzkySrmmMEdpQWERx+VtnsxA+SKS
         3r4UW22yCc+KZ0l5wqeH04A04TQSLEb2AKbJGjkRwebAZXoKxcacvodaR928FDAMiozE
         M4C+Bjqr08el1gIiltB/6Cmn76dPXOshtrwh8gzwaKruRwShIbeqEkBO9SqeYYtQR6/1
         nyjBEZ/8fhIj1tUtJemdRE35OvconpCDYW/d+1OPcx5qIWuR3foDcHKPRFGk78stU3EH
         ns3BwZxfShdB87pZSkg5qM1NbmnB5FGjDJJ2YWM+lwBvID1g811eRWOndGLSPLiF2/xD
         UsMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767219976; x=1767824776;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QiVsfjKNJCcO38sVQpJEBYAeq0gcXWkKlGmVCeZEjpI=;
        b=PXBRQ5RIG2/gniXBownHh9GtZHLLh16toVKRpNBuZKHpZzK/bod5zQU0UkfsDR6yr3
         qxTvPaIw0UFtUQOBlOvFKfnYt+vnm7qkcBsg6LLVX/dtJuuCRvXp3N6psmye9AAAIjpc
         tH1kKADd8+GLG8SdTlRGhUr9ACVjDVa1ctku/2XOWA8mF6xj4hKix1hiIpkqvbsd3S3N
         beoCFPU4CxtR8Kfy52g4NO/n38KpqaHfeWpiWimjlDAYD1nGBhXMKzcjFbgEuLY96Ugr
         kRhh5PlBbTXiSvu9kZ66dZ8qoP+OpQDYfrRJKomJvaeksx4eJ1W215We6H0SFKPju5Jq
         id+A==
X-Forwarded-Encrypted: i=1; AJvYcCVE/wTtAwRjDqykVqa5bdhyek7MldxbcSx68uh19nxMEuHgJ5xC8aknIqYgUPRUneuPl4wj8V8U@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7YpYjdlfGQtfnVzHGPSLC+p66emW/Gr5Cx3zQSTVj0OnhHHhp
	yUbqNGOz5/3Q8kQjBrQXz2y5Qe0sF4y4brbkLY6Q3v0R311mhS3y/ChpMjN2Pw5L+T4xoTv5Yb4
	8IwlqoWhhYUejzgd2F+FtdVgRzsSkl3qcP6nh3UWkEHdFJ9gO4WrZaOK9Xs8=
X-Gm-Gg: AY/fxX6iqttnZVdw4k1SBP3AMnVWDaRtxJ+zvwgQNZ519Y+QyUvyLeVWj6RvsCyPYX1
	7OZgafYW6DVY3ThRImYy6tr27K4Wn+Pqe+xg/WeKVv7zGyUynm5/e2/Ji/ySAoFxQNbq19obUaq
	leP0ItcJSZansBeCBtD6YGDc1oKX0gDfYx9v3y6sO7FOPTNWfhAbP3mVbnFVFMTkC7ym8GlqafA
	qm8yCT2/aKvYI9F2h0kdrF4hYq4MXBtXV3HJaGOuhdmLaKNtdKbC/D6GB9PSEfbItMsd4VDugMK
	zWA5uHGuA1XCvsuKkIJkdiwVCa1mybJpMzdj/c1knKvx5YDCxYH8qd7PCts1VBs6Fti9J0n/tK0
	X/Jv1lm9Aad+F2sZ8lqPFx2T4EVP+VuFNsvdeJwgg5gGM/SJKog==
X-Received: by 2002:a05:6a20:7351:b0:35e:bfe5:ee82 with SMTP id adf61e73a8af0-376a9acecfdmr32432611637.48.1767219976454;
        Wed, 31 Dec 2025 14:26:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjYfsqsv8gURLxbYnZxhql3EeCqYIHHexZIlKyir+i/AvJL4ZcQc1S2ibH7e3Yub6CVT1ryw==
X-Received: by 2002:a05:6a20:7351:b0:35e:bfe5:ee82 with SMTP id adf61e73a8af0-376a9acecfdmr32432603637.48.1767219976023;
        Wed, 31 Dec 2025 14:26:16 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c3a4deb6f17sm5875894a12.22.2025.12.31.14.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 14:26:14 -0800 (PST)
Date: Thu, 1 Jan 2026 06:26:10 +0800
From: Zorro Lang <zlang@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: zlang@kernel.org, asj@kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: update entry for Anand Jain
Message-ID: <20251231222610.vsjbsjudb7khte76@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20251210055134.3470190-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210055134.3470190-1-hch@lst.de>

On Wed, Dec 10, 2025 at 06:51:34AM +0100, Christoph Hellwig wrote:
> The oracle address bounces.  Replaced it with the kernel.org address
> found in recent commit logs.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Thanks for this update,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a0f50f3d98b4..19e558296809 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -108,7 +108,7 @@ Maintainers List
>  	  or reviewer or co-maintainer can be in cc list.
>  
>  BTRFS
> -M:	Anand Jain <anand.jain@oracle.com>
> +M:	Anand Jain <asj@kernel.org>
>  R:	Filipe Manana <fdmanana@suse.com>
>  L:	linux-btrfs@vger.kernel.org
>  S:	Supported
> -- 
> 2.47.3
> 

