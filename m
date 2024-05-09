Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D100014B062
	for <fstests@vger.kernel.org>; Thu,  9 May 2024 10:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715248827; cv=none; b=GjTBc+O5OG9RWLDQW3boHFv2STQA6z9FKbtabooc3S3+PxrA7EV8WZb/o60zqGTzUhqcgEY2IJ37q3SgNoanu2nTvO26as8vn7zezLLh7sBxeCSU5Ws1JjzNTyIjKKqi+NRrARFNe2Qx0AU85Rwo8zZtAce6tA4jUVwjRQut5pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715248827; c=relaxed/simple;
	bh=jTIOY9naCn6mX+kkUaWozuodjgVbYUtReGjl3ptNHEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=THT98g8YF3zsohqVqumksQ7DxehVqvQ1aZSS+gkOb6wfvENvbVzSGvGksZNfYG7gEcJ/W/rjsowNy5O2eLjTfMA2i4lwlpyWqDdG1pirPMoRN2fAphIZRkut+dBns7jcnV1lKZt6dJJMy8joF1GjEZ2S28IidWk82EAk+3h04Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IXIIZIAK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IXIIZIAK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715248824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i4DUonvQeAigT1OfKNSVy7siZn8r1lTduEdKfVs50jA=;
	b=IXIIZIAKRvu//igqOx4Rx8MzUopsMb1XQ12WFpCyi0fCe9hB9po4qBfknkXBVgPnMMrKgR
	dCFtMinknPavmioA/sBHnXo8Z1DBItggUFgoAfsJcCt5oq/MRHfYGVsQTTj8e7lwRhVeMk
	4Y8DD320hGMSRCV2IJpfigmHcVDEurQ=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-wwMwckQzNLqZDCFp8nEEoA-1; Thu, 09 May 2024 06:00:23 -0400
X-MC-Unique: wwMwckQzNLqZDCFp8nEEoA-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1ee2078c2d4so6633815ad.0
        for <fstests@vger.kernel.org>; Thu, 09 May 2024 03:00:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715248822; x=1715853622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i4DUonvQeAigT1OfKNSVy7siZn8r1lTduEdKfVs50jA=;
        b=L4rryD3C753JiOHbyAih/ZgBqlTGw2yXZppce0uQ/eiYwlHHFaYgtvkcC1Ee8yreHs
         R+cCLBI7B2DGs+zo+HkC3gXQFKie2Fb0iO2TqgNVjRqih+uu/IK01pddo7bAXncdgM9A
         rCaPOjScmonLEt1RoI3kR76NFDSe9zninDfFZ8BX2OtnLVIUbZLIGcuL0bCQ1mDAWOXJ
         1MTA3VRq4ONA3tJcEGf92cwBiK9PXvhSXWgK6EbQuQ8lJ5qFLO2QNwPRIZmZeD/GVac5
         kwiMizXroV4p5h/CgyqKit0o78zrvDQAH7PnsrPNvQBS5/0V4qGxDgRG5CBMfwOhVJ91
         pl7A==
X-Forwarded-Encrypted: i=1; AJvYcCX/pnxRdwSFSvnq52qwst40xFvEV6/uoMxU4javUPcddKjI/+6pqY13g4TB8eORdSgogjNGXG8D4DcFTyIQb+yACqVo3hKcGQ==
X-Gm-Message-State: AOJu0YxzTwsBjPy9UKse+l8RhQpMpYUtpjlak6/O5+nh7mqi5GI9cU7Y
	u0Tg24j0oVNsym7O9Xi3gssSmFn2Cs+ndMxMZGnVZVqE1R/9UHiIzfv4YprrSTUpNnsWrqb4phI
	IZOrXtqrU8ijbUR9MrlKLwotIfTzJyd/A2f6LKBCnNFh9WCxcT3lxVHM=
X-Received: by 2002:a17:902:ab82:b0:1eb:3d24:3f7a with SMTP id d9443c01a7336-1eeb05936edmr45309935ad.26.1715248821906;
        Thu, 09 May 2024 03:00:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvEuRnKdGeRQyDspP8Ot4KYYgZ+chEOXHtIE3dVhBDliUkc5oanw7l0XIlxY07tgSbWblpIQ==
X-Received: by 2002:a17:902:ab82:b0:1eb:3d24:3f7a with SMTP id d9443c01a7336-1eeb05936edmr45309655ad.26.1715248821071;
        Thu, 09 May 2024 03:00:21 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c2565b6sm10287605ad.295.2024.05.09.03.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 03:00:20 -0700 (PDT)
Date: Thu, 9 May 2024 18:00:16 +0800
From: Zorro Lang <zlang@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: David Sterba <dsterba@suse.com>, fstests@vger.kernel.org
Subject: Re: [PATCH 1/4] Move shared/032 to generic/740
Message-ID: <20240509100016.ov23vek643renv36@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1715108589.git.dsterba@suse.com>
 <8dcb7d564180452eec0c2888740c1b0919e171d3.1715108589.git.dsterba@suse.com>
 <Zjxht5OKsau5QJYm@infradead.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zjxht5OKsau5QJYm@infradead.org>

On Wed, May 08, 2024 at 10:40:07PM -0700, Christoph Hellwig wrote:
> On Tue, May 07, 2024 at 09:07:36PM +0200, David Sterba wrote:
> > The shared/ directory was supposed to host tests that apply to a subset
> > of all supported filesystems but this is not utilized much and creates a
> > split from the generic tests. Move the test to generic.
> 
> While we're at it, can we please have a
> 
> _have_mkfs_overwrite detetion instead of hardcoding ext4 and btrfs
> with another check for that is supported for btrfs?
> 
> I'm also pretty sure at least ext4 supports overwrite detection as
> well..

Yeah, that's the reason I still keep the shared as a "prefix directory"
of generic. The hardcode whitelist or blacklist of _supported_fs is a
bit rude. If a fs isn't supported by a test case totally, that's fine.
But if the condition of _notrun can be smaller and more precise (refer
to some _require_xxx helpers) that would be great.

Of course we can move shared to generic at first, then improve it later.
But I doubt if we can keep that in mind, due to there're hundreds of
generic cases :)

Thanks,
Zorro

> 
> 

