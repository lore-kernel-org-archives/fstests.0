Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025871B392A
	for <fstests@vger.kernel.org>; Thu, 24 Oct 2024 13:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729776014; cv=none; b=nSCoM2poGk/n1+mPJe9faHA1JM/zbKNYWpATLu9NJSUdjt0+c9ibMpVI+/6yPnEJs2jBEfiD3n73iHDcKYaEp/8XYn7UBwQB888KZidKFoXSFHfHMRj4/xSiJyURHy/Z6FCUG+OFooFdmULV1CSyk1e8Lpoj5mS8WDbVw9pXwjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729776014; c=relaxed/simple;
	bh=R2INtfzSnpxZhUbY/N7iGAAfGhG/ByhdP2AB7v8J2+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FScRncaRjAqDiI4YxUaP51R9wWfQB4Er2dUAiWp2enVB9yS23womIv0+AYFZ8n1fiOB9tIP2chsgzvR0P+IPXptWosnj6xtQZRy+9T+HEj3VLpJkCB7pAtbjhy3TKv+jD28XZywKDuau1qtn9dmd59FfYFF6hLhIB+7V0DxJymg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RiI211BT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RiI211BT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729776012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8iJ7W3nz4WvfyoieNtKm3ENtdAmy3aJMmF0WG4f6orY=;
	b=RiI211BTU07V3MaLStoIApAFKsfGYzAji3sRPapWs7SCCvgvdkOUYvEByIL6fkBDd9xplh
	ZymZNdzuxuVZbmLJwju2v3NG8emLivcbT4VUtmC4a16xejCkKz1ZKTp5cspJVmCcCvOTd4
	yZ5S9MvD8IhbPugMhac/gUynV/iMuVo=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-2rd0OyglOFCUg8MGI0ynEQ-1; Thu, 24 Oct 2024 09:20:10 -0400
X-MC-Unique: 2rd0OyglOFCUg8MGI0ynEQ-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2e76eabc7ddso1076908a91.3
        for <fstests@vger.kernel.org>; Thu, 24 Oct 2024 06:20:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729776009; x=1730380809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8iJ7W3nz4WvfyoieNtKm3ENtdAmy3aJMmF0WG4f6orY=;
        b=ONnpA5uUsSAO1aOPNFxkgtDoVE7fMHxqw3jlLtAHG8LOgodi3VprJRv0jl7ZPmkfMx
         JsqzaOiQK0n4sXYNnRCYpDyWz1/99Og5qLqbA1ltSWCSzmXmt2oF/QfpRz+ELDsJzr06
         vWvMOlHDiwSvWYr7N1R+6q6evrf0KZI02jbkT+FTOTpCsxvShck66s5iamsDPZZUjwJB
         2qqu3chxDY03stLoVDvLc2h7W8qSYiWQNqMnlscPiK0NAKzEEiE6/bsSEwFNktAu+WVN
         1Jm3ijnSjNx+VZ1ZflbcvrgKMYqj8AgnquCfShkEwB34H+pTfQZjZ+0FtkQS1mhzulBt
         8pDA==
X-Forwarded-Encrypted: i=1; AJvYcCXvKp6vly3nb6sodpZNqcvLq/OZFMXwlXqvQrRgwisnmSKV+agp4GqrUvK2YnRpzBhR18qgDorS@vger.kernel.org
X-Gm-Message-State: AOJu0YzxiEWwQhe3nE5Cb1PQNp8J/KD5NhsTHYO2y2pcNjPkBR/tOmS1
	I8Jmt1r4PKNCvbUHrFe1H4WZdJhTdgIAGB18piKhiBGssOl9jDWXALq/kYjtIoeUKXLRYBeIxeU
	PuQ6qIPc7B382h1/CIKITQxxX2Zl8hqIvR/pEPOZxZizPVOsw+xomOCM=
X-Received: by 2002:a17:902:d50d:b0:20b:b238:9d02 with SMTP id d9443c01a7336-20fa9e62d13mr82149805ad.33.1729776009488;
        Thu, 24 Oct 2024 06:20:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvW9z1JTtlbfYBN395xVJAQWFiwEBT3KCPZwAslFGgJ/BgpM1/xnrVvqALn9Te4Tviz7UGdQ==
X-Received: by 2002:a17:902:d50d:b0:20b:b238:9d02 with SMTP id d9443c01a7336-20fa9e62d13mr82149535ad.33.1729776009099;
        Thu, 24 Oct 2024 06:20:09 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0de428sm72571315ad.230.2024.10.24.06.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 06:20:08 -0700 (PDT)
Date: Thu, 24 Oct 2024 21:20:03 +0800
From: Zorro Lang <zlang@redhat.com>
To: Qu Wenruo <wqu@suse.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-btrfs@vger.kernel.org,
	zlang@kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: avoid deadlock when reading a partial uptodate
 folio
Message-ID: <20241024132003.64sxshdq4qh6fnwu@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <62bf73ada7be2888d45a787c2b6fd252103a5d25.1729725088.git.wqu@suse.com>
 <ZxnXtI_6HCwvCvLT@infradead.org>
 <d373ef6a-956e-4319-ad2c-36f67a887a58@suse.com>
 <ZxnaqgJrYFjGxPEn@infradead.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxnaqgJrYFjGxPEn@infradead.org>

On Wed, Oct 23, 2024 at 10:27:06PM -0700, Christoph Hellwig wrote:
> On Thu, Oct 24, 2024 at 03:54:54PM +1030, Qu Wenruo wrote:
> > And generic/095 has a much higher chance to trigger it than the minimal one.
> > The minimal one is only easier to debug and faster to finish one run.
> > 
> > Do I still need to add the minimal one to fstests?
> 
> If I have bug with a well known isolated reproducer I love
> having it in xfstests.  I don't know if everyone agrees, though.

generic/095 isn't a specific test case for a known issue, it's a common test case.
If you want to have a reproducer for a particular bug, feel free add it to xfstests,
mark _fixed_by_xxxx and describe more details about that bug in the test case.
If one day we update g/095, it might not cover the bug you need. Then a specific
regression test case will help.

Thanks,
Zorro

> 
> 

