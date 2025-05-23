Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97794625
	for <fstests@vger.kernel.org>; Fri, 23 May 2025 15:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748013790; cv=none; b=cL+NEeYGRWdyEnDXqe8GMLw+k0EIIXD/eSd1amuTC0tdY3Mq0PQaEs4ZMITYrigp9JGX/WAPBttBjP3kgGnHYDM4/BVptFsVi0MPa59PChAL0wSVN7IMYS54YdrTomtifuOq7Za1MVQ4eaK6R9y9sbtXZc30THnUFy7c6gO7vcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748013790; c=relaxed/simple;
	bh=nQOeM3Dqtm4mj1C8J0mbhgzHJirdktm91ab8vaFuA+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q6NkLsLN7XQ4QaDx4XboAgpgtJiQJUJkOiFxz+Cv5AFd08eQXGifSmVVDiUelsOlrMhVkT2F6wXNNuT3hOqbtm2mDcWAhv0zVF1rjXTOenCSK/5xeTimLHARWMfu3hG208aVP6LDkYsBG4bjW+1UX39KAQa2o07oQSTMrPP9lJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KCw2p2wZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KCw2p2wZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748013787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SpMQgLc6DIr4rweXgx1gHRZx9KnbfzvdcczU48QjR2g=;
	b=KCw2p2wZvzFVMxf+EPwsTIKZGKaZOw+PlwtP1skAyICT0GOz9wGWcMCjR3l50ywkK7UsvJ
	WQ/6N0P9Unp+0l44hrwe0IkduarEX5WADEx+i7H6zlz+GTTX6631Q2NgXjEzJT/Tkurbq1
	5wqOAqRq3xuJGmO9zZpKh3fo+0CjnvA=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-PXOHg6EiMB2jX4dmWVsMcQ-1; Fri, 23 May 2025 11:23:06 -0400
X-MC-Unique: PXOHg6EiMB2jX4dmWVsMcQ-1
X-Mimecast-MFC-AGG-ID: PXOHg6EiMB2jX4dmWVsMcQ_1748013785
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-231d7f590ffso55345415ad.1
        for <fstests@vger.kernel.org>; Fri, 23 May 2025 08:23:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748013785; x=1748618585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SpMQgLc6DIr4rweXgx1gHRZx9KnbfzvdcczU48QjR2g=;
        b=HSYk7IEeWAXgD2reNJusd+a3HtwUeU8WKT0yv0qM8KErcRl0arf9Suh9zqrRcW0k2o
         P6K26/iFQ2Fh8n4e7mSTskkNkjCRNMUWLaiJdfPo0zANn5AFd8IBjb6NnmdN3j/J3gk0
         2oNKZVpejrpD9lV1b6WSfgOAa9YONrhB7YlgoP9qnXHGfT/81gtTEg4Bq9htc/iarRFC
         f6rL44BwLdvkMsv0us/R9zictwLJkDl1kmJsX7jSDGyYvPG+JswuhG1IsaxiRH93KlnX
         KIurBU0tibqfq7wzh9+0TmT0m8XcOen8mwPxuwSwLTK8iNoUMuh9EPU9Iu7BJHAKe95U
         xHmg==
X-Gm-Message-State: AOJu0YyBtX34fPi+5G1ndjkWXR8h6sQZQqYWXBUQTUkE5wSh2NurvCxi
	9lgC+Ha2BLpRUjsS2yVfmRtH4BxS6uLNr0RptbuDsynFjl29L00kKFYfLC4xJ0+/6UZ6EF8DB1Q
	9kOcBqdY3SrVfbzJlYMaNkds83XgsN3wOJMEMIfWvXYrNgqTraJqw3qyylUE=
X-Gm-Gg: ASbGncsUYgu8omFYaJdy36HZMSuzp3T8NkDD8ViS/iTzvrm4zmh9gDRPa06xbsjohof
	Q3VnYIzML7YInicFnmt7KTeFcZXtSMwf86Sq1eOZ/jXs/NWYcRiuXFHgIOWmYyG1FRz/9f3dRpA
	6y+tqjq86Exi+DnpX0qzmLrwTu8JH5EfbTFZk03M5iOAK6CC9BGsIpvTvEeGFQKQp9xi+ovSb23
	KOxUxrj+TlxXRi/0Xi9V/EZrCUeAMWCj3ynCcVlGw6gNClfZlju3WViCatDITXIuv1HhhZvApzF
	0X4LK8WtoobM8F8iS79lL2aUqEMO6apSDlaC64HHDtLGCquNwgYc
X-Received: by 2002:a17:902:e54e:b0:224:2175:b0cd with SMTP id d9443c01a7336-231de31b382mr380857845ad.26.1748013785189;
        Fri, 23 May 2025 08:23:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqf7EnTM457tlCg2ymc3jlcny8oCfPBWNX5s2BmpLj2wZ/UD+l7+zLHAkwrcsiBVnJNrZ1fw==
X-Received: by 2002:a17:902:e54e:b0:224:2175:b0cd with SMTP id d9443c01a7336-231de31b382mr380857635ad.26.1748013784888;
        Fri, 23 May 2025 08:23:04 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23401ab6c69sm6339945ad.67.2025.05.23.08.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 08:23:04 -0700 (PDT)
Date: Fri, 23 May 2025 23:23:00 +0800
From: Zorro Lang <zlang@redhat.com>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 2/2] btrfs/023: add to the quick group
Message-ID: <20250523152300.mnnl65jjsvbwe6j4@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1747309685.git.fdmanana@suse.com>
 <29bf7308d67eca82e564956f381dfe983696fbf9.1747309685.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29bf7308d67eca82e564956f381dfe983696fbf9.1747309685.git.fdmanana@suse.com>

On Thu, May 15, 2025 at 12:50:08PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> This is a very quick test, so add it to the quick group.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  tests/btrfs/023 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/btrfs/023 b/tests/btrfs/023
> index 52fe0dfb..f09d11ed 100755
> --- a/tests/btrfs/023
> +++ b/tests/btrfs/023
> @@ -9,7 +9,7 @@
>  # The test aims to create the raid and verify that its created
>  #
>  . ./common/preamble
> -_begin_fstest auto raid
> +_begin_fstest auto quick raid

Sure it's fast enough:

  btrfs/023        2s

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  
>  . ./common/filter
>  
> -- 
> 2.47.2
> 
> 

