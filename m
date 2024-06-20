Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505A61B29D5
	for <fstests@vger.kernel.org>; Thu, 20 Jun 2024 18:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718909941; cv=none; b=W+ceD84VCc00c8ZCvLuNk3cvBC/kNaPqDUAaG9oKC2xP9uMKa/XFRuFwjDPmMuFc+2FOt8SJbu7PZOnS4HJszDJg/r405q8dHSJTVe51GPTngiVnVIHPu8mqI3ypiGOKJsTAPnLSUFkoAOHG7Jep5EgDpTqHz4r4yU2KG7iq6k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718909941; c=relaxed/simple;
	bh=qbk7oYZyc1nJBU2j1vFktpd4NnvyyvOmTJcKBouuD5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PsjiTixDCtD9xhmkhVfyPqDvmyRn94C+sdWB7papofGCElxQRuxJhx6VT6PjK+MeBDnyhfO/No8OZbbM6uA5LzJl7GR0QQhuRDtQNe9wDd8NvtZdx+pURi2JGpgvoJPTBPvf7oTWHB1fG9WJqhHw1YzZgi9hkkOaPiKMZstbo+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QNFedg79; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QNFedg79"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718909938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jH/1STGevSI3JAsnqyhpNLSvcx5qg0QdYjDNlIqmlUw=;
	b=QNFedg79lacgtjRAvPmY6plbl4R7v7U/a6+Bc4v52hxgsHXt824u2chMGvDey4PJcftyte
	4vuP7F/d1alBT99Bn4oiTE/kcn0MEown1eeoRlRwHJTc3diZWZN6VmhnocAqE5McUHqqm6
	G7ULFeClJRYzLtJWsVzGmOQYsbHX/VE=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-eSN0ahjcPbGoQaNUEkp1fQ-1; Thu, 20 Jun 2024 14:58:57 -0400
X-MC-Unique: eSN0ahjcPbGoQaNUEkp1fQ-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-6e4d1605a03so1525013a12.3
        for <fstests@vger.kernel.org>; Thu, 20 Jun 2024 11:58:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718909936; x=1719514736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jH/1STGevSI3JAsnqyhpNLSvcx5qg0QdYjDNlIqmlUw=;
        b=p0KeWvGWqyTU9EtAiGmkFvn6zBRUQQ25o1rVdXUIxN+TdJc5GFXOlTQshHAixMdAKU
         TC0eM0ces1+q3fyM2rdAtL8l0R3+ZnH+irODn1iKs5Y4rdPgyZv4Tf64kqzP34jWVXb7
         3+kEcDWhSih4MncWtAJl7PXyCaHMEs98w6BNuW18BbhzVKjq+QJH0KI7qLK0J3rR0vvp
         ddl3qS5wFaV4jti8iw10nUeFbciMAdK6gYzXxHyAWHHp4zVn/p1Ao6GDA7nBoVbJLeNg
         zh8IBylo3S9mP7/uDbYonHqENgtu3dkWh8VyfCu47KbpLr7HuDltlhEAbhvCdx828iHl
         5dqg==
X-Forwarded-Encrypted: i=1; AJvYcCVOBr86KXUBF3XH2tKQqlAdqlbXZhgNebfmnVEglNU6QbVfJvbRrbMKEHUVOnGI2zxQZluRbFPZlSL5kHB4Y0tlbTj+/KbIng==
X-Gm-Message-State: AOJu0YzBtzAvFUnBqTV9bDHKWsJtQ1qTuMo8Ukg/oEIzfft+X2mHzbw3
	CI3AkR3jkJRN3TqfKAJAgp7mRo6eIyk6Os1tf+WI9gohbGHcFqLn/FRnkzES4uS9r2WFFBpVMRD
	Dzx07K5FK3YQnIZwV/6nLrwqEMXIShW2Ypkl17rUg9zUMKTFSfBlLTmY=
X-Received: by 2002:a17:902:f546:b0:1f9:ae6d:5697 with SMTP id d9443c01a7336-1f9ae6d5ac1mr60547285ad.35.1718909935823;
        Thu, 20 Jun 2024 11:58:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUqsYkzeltcUKvcT+Qbx8lhqtSk0mACAOpJV3i8spyZLxlcSTnj4E2BeSlbL9PEJfMkQRRkw==
X-Received: by 2002:a17:902:f546:b0:1f9:ae6d:5697 with SMTP id d9443c01a7336-1f9ae6d5ac1mr60547085ad.35.1718909935351;
        Thu, 20 Jun 2024 11:58:55 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f5c039sm140841785ad.306.2024.06.20.11.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 11:58:55 -0700 (PDT)
Date: Fri, 21 Jun 2024 02:58:51 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, fstests@vger.kernel.org,
	guan@eryu.me, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 04/10] generic/717: remove obsolete check
Message-ID: <20240620185851.nchu3nlllehnqvmk@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <171867145284.793463.16426642605476089750.stgit@frogsfrogsfrogs>
 <171867145359.793463.11533521582429286273.stgit@frogsfrogsfrogs>
 <ZnJ2Ehz8PIcQ5m6R@infradead.org>
 <20240619163148.GN103034@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619163148.GN103034@frogsfrogsfrogs>

On Wed, Jun 19, 2024 at 09:31:48AM -0700, Darrick J. Wong wrote:
> On Tue, Jun 18, 2024 at 11:09:22PM -0700, Christoph Hellwig wrote:
> > On Mon, Jun 17, 2024 at 05:47:48PM -0700, Darrick J. Wong wrote:
> > > From: Darrick J. Wong <djwong@kernel.org>
> > > 
> > > The latest draft of the EXCHANGERANGE ioctl has dropped the flag that
> > > enforced that the two files being operated upon were exactly the same
> > > length as was specified in the ioctl parameters.  Remove this check
> > > since it's now defunct.
> > 
> > The last draft is what got merged into 6.10-rc as far as I can tell,
> > so maybe update the commit message for that?
> 
> "The final version of the EXCHANGERANGE ioctl..."

Will change "The latest draft" to "The final version" when I merge it.

Thanks,
Zorro

> 
> > Otherwise looks good:
> > 
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Thanks!
> 
> --D
> 

