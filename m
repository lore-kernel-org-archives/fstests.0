Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACAE216E21
	for <fstests@vger.kernel.org>; Tue,  4 Feb 2025 17:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738690580; cv=none; b=L6roXVkSwiA/wcXddqrXEzmiUDd1Jyp0okD2cBt+aRZ11NBO6eg0lgzpRUWdGVhoOlU4sg4hwkP+GkjjR50qk9/xzpNjACyzStYh/d9UEnKKkHHkwBAzhDQIDa1EcmssrgOXntw8878c+Fxo6qxxH9zf5L3vWcciKCTx1FqEee0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738690580; c=relaxed/simple;
	bh=kaqzE4CHHaM1Aqnj4GS/9KVQe097Vhi5E5Bi6Pt0Iqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NwNPGe081qlYHoG/9uysa8moamcpHZbqQqCnkZs779JrPCx7L/8Sz4E1uVdtsoft7nTmPH27HznjJR/3qjK+BOPXFFoVtf3OMlpz0aB/4EO/u+7+Wo13OFm2oqObDQHQP6jhbxRhJP5RLOrDmfw/SZOHLWV8qPBSYzKNYaQWnLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TVm/3XSz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TVm/3XSz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738690577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tIlxlT5GvDdtnlDPE6aVG5NuaU14d5+F32sJyA4nKIk=;
	b=TVm/3XSzWVOu1t8maNLuPfEgHJSYRAp7ypWjGjwQSTJe8fpbAMfioJM+w0axnEiuON/icz
	1wfyT+LZ5zjRot8N0USvxUeN4oRTZxk8CxRnK46YSrGItIi6UPqtXdCwZiuMpVqQ9sW3Qh
	hdWS5V455/6PVhA0pTNxHtrHl4AkJJg=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-6SindGQlPY-58NcVGzq13Q-1; Tue, 04 Feb 2025 12:36:16 -0500
X-MC-Unique: 6SindGQlPY-58NcVGzq13Q-1
X-Mimecast-MFC-AGG-ID: 6SindGQlPY-58NcVGzq13Q
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2f9c34c0048so2850141a91.3
        for <fstests@vger.kernel.org>; Tue, 04 Feb 2025 09:36:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738690575; x=1739295375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tIlxlT5GvDdtnlDPE6aVG5NuaU14d5+F32sJyA4nKIk=;
        b=lw/R9OAItu7wFzVD5yQnfzCWYtZkib5o8bEq27RDjUCKUnu7mkvYy2gF2chyXZVU+Z
         mz6KrUlx/UIPvku+PWC5wXHR7atkZBpwtKsc0pVaJTLxh+QAbJhKpO5GzRzrnDOFihrY
         LbGhzpqMKoGMh6Tfhf/Jvuy+io5+EQIiPOTRcW+GE64UKHHXQze4uUHOaHi/yXZB/o5u
         XOc3NvUJCOo62RVR/LWyAIfPd4S1NJOxrMxciWpFTVeObxDtkzF1UAQKJc9sYDFOlVzX
         A+UHYoog1tIwysmM4usF+n8P49UMmaV54MobDPN5ttk31wVcdz/J+6SNUAGCjwlwrbzm
         VVVA==
X-Forwarded-Encrypted: i=1; AJvYcCWs+2aFbhZHft9w7cmot8+7cUWfzE/pWn5KVuqw9Qm3oOipejwIrTd3cUPBdWz1VCHMNTuAAwPt@vger.kernel.org
X-Gm-Message-State: AOJu0YwyIP7qepFBgh4BImF27/SLzoiYDqJotR5722Fq9xISPHU3yB92
	u8xQPB+4kEz1y01RKwCXx60P23tq2JnbDAYcpD0dmXBJ8Bpz5Lw/A9Ii9CyNywYuJ6QDUjNO83u
	WGryvVSLl4mF1O2/MOTOYxeyajgxHse/fTnMFhW5TO78+XkBvJPbFk5G+r/Pv6er5cw==
X-Gm-Gg: ASbGnctjwbGUJTMLTMrJauCJK18a8Xc0UnBSRS9ESk6LI+ZwtkQNfP/Bbl0Y8W0CDfJ
	Vg0sqiciUoXkP8TioELexFAUHgTMnP51bu6usRY2OW5ebnwfYnM6P2TkOhfXTMSKjfBtZMVk8K4
	DFJn5hefGmCggheikkWl6pk5LiBWZpHdbYCftpPPQ7Gnij6F11e6Rf7kEb6gYse4U8d2twOwR05
	ligdHrURw01qhWq7xKVbypM654I5nqlmUPKXWDcM2ik6Rl2fBUPvwjWzP0i/12gM20OcAjubZsL
	fXpE8KzqOKUZ5+blkn/fOjLec1fTfmLAH94sFxmuwIdY5w==
X-Received: by 2002:a05:6a00:a88e:b0:725:e057:c3dd with SMTP id d2e1a72fcca58-72fd0c98729mr40768267b3a.22.1738690574915;
        Tue, 04 Feb 2025 09:36:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYWcKcTHCT1xOLJ0jIr/KoDYsB8wS9lxwOYvyGzi25rW09Tm7wdNPYgBA9pweQb7N6R/AVVA==
X-Received: by 2002:a05:6a00:a88e:b0:725:e057:c3dd with SMTP id d2e1a72fcca58-72fd0c98729mr40768231b3a.22.1738690574596;
        Tue, 04 Feb 2025 09:36:14 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe6424f8csm10864631b3a.44.2025.02.04.09.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 09:36:14 -0800 (PST)
Date: Wed, 5 Feb 2025 01:36:10 +0800
From: Zorro Lang <zlang@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Zorro Lang <zlang@kernel.org>, Brian Foster <bfoster@redhat.com>,
	fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 3/3] replace _supported_fs with _exclude_fs
Message-ID: <20250204173610.6atogxyeab7xhlli@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250128071315.676272-1-hch@lst.de>
 <20250128071315.676272-4-hch@lst.de>
 <20250202133101.bpst6rzhjn7g4zvw@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20250203064029.GA16864@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203064029.GA16864@lst.de>

On Mon, Feb 03, 2025 at 07:40:29AM +0100, Christoph Hellwig wrote:
> On Sun, Feb 02, 2025 at 09:31:01PM +0800, Zorro Lang wrote:
> > generic/730 is missed:
> > 
> >   /var/lib/xfstests/tests/generic/370: line 31: _supported_fs: command not found
> > 
> > Anyway, I'll help to change g/370 when I merge this patch.
> 
> generic/730 didn't exist when I submitted this series, you applied
> it in the same batch of patches.

Yeah, sorry it's from another patch which was in the same fstests release
with  yours :) I've fix this "conflict" and pushed, please refer to the
latest for-next branch.

Thanks,
Zorro

> 
> But it really should not skip xfs to start with.  Either the test
> is correct and XFS should fail it (and get fixed) or the test is
> incorrect and it should not be added.  I suspect it is the former
> and I'll look into fixing it.
> 
> As added in the comments in this series we should never add a
> _exclude_fs without a very good reason and comment explaining it.
> 

