Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720301EFF96
	for <fstests@vger.kernel.org>; Fri, 21 Mar 2025 08:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742546403; cv=none; b=BF2OkbB3WTKZtHaDZ9ZQ8CHgPAgzRmfc3X1fOzkKvhZwbJERsHCbdgsDyKg0i6SeUJcvX3NaHgDxmiiBVYFZOhw47/Yl/BPajvxmeA8rczyBVQZTMv6e4eixCOWCHxlXgmLlJ7Zbz85vEFlzYGUiik/TBmSOUj2qBgOxkJumRaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742546403; c=relaxed/simple;
	bh=r3//Esu+78o2ygh5TLPBMkrcoRkBcfZYwS5QpMx4bHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8JGsdikZdwW+qh3zJxEsYV+gltSBSNj38Ao1g5X+M9Q79c8hrhFIPswXJ8I3v4OqhnFrVSRV6J7eMONKKl0JTlsru3tyMr7ESY1zaK8o+C+yjXPhDwfl1nU9F8gM7fOMqbF2lSyYOeErDpd+vlT6gNeWLIDGVAt/tOner5i5nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hkMMALro; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hkMMALro"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742546400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f3w0UYpjdow8Fk1HqScfIf6dJ91I0G1YG3EeZu5KPDg=;
	b=hkMMALroQ45OjIhYcaI6akX9QygB37bY+axhHci0R8lBtBtCJVe58c18FdAaUU6HIic6Me
	Syu9gG7LXf4FlyElZKC7tFyKplay7z45v9Os8ztBKzR7xouKQ5ZD6PmvT+DqtsbdEVTq86
	7tavEp25/K6Bw6W4feug/TzhoaTO1/k=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-7wZKz45wNHe7ZN4x7wpz7g-1; Fri, 21 Mar 2025 04:39:58 -0400
X-MC-Unique: 7wZKz45wNHe7ZN4x7wpz7g-1
X-Mimecast-MFC-AGG-ID: 7wZKz45wNHe7ZN4x7wpz7g_1742546397
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5e6136633b1so1467148a12.0
        for <fstests@vger.kernel.org>; Fri, 21 Mar 2025 01:39:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742546397; x=1743151197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f3w0UYpjdow8Fk1HqScfIf6dJ91I0G1YG3EeZu5KPDg=;
        b=d45kxcYiDk8ohEXlrz4fe6bLYi2MoSMV5pE4T3/5lktCLPJFOCgy3m9PIob9K2gFRI
         E5izZgcsulsPtMDRDKdH+7fDuKvj6y2A2/bvYXfcHgugRPxkpF1sYNX2ItEGWTQv7c1d
         r/rgke+O9XmysFYuwPXMGFOdguVJqgVAKTI5xcdHknUwLQw/eXjrWxg4VxBO+jWbFeLu
         +0m2Mjwx/r0/y79ve+h22i8rjDNj1eWnk2cTAcTWcdC1bqe0Vior3uOlNoFqemqrZRTe
         /OY6ZACOJuivcOlTR6bYEsgda6XcJj0Ed0JE1T1SKowMzJfkCoGBVz7h5wh4UHLqH/be
         3tOw==
X-Gm-Message-State: AOJu0YzALrUx7E6TnMT5/0ko95fUbUFDo2k/eG0anoIz1xCs1s4QQJ5f
	pOMwxezctxNt6cSSoOZA9PX0DMS7EKz66jFZiCbGp8aywU2G7Ie+jFI/fsbhIFTdPhjyBo8E9aZ
	wgS5dSerN4+V6KuRKUar5WUdF/HOmh/EiT+vacmXzEJ+ER/6hWAhAVY2GHE7yKg==
X-Gm-Gg: ASbGncvIClP0rCqwICXtfhZ+2SRr6/WqxI+DMv+wR44hOwOtxtYfYUAshjD54o12flO
	80p2tsnxHmgByEnIp4GGDFcOAs3cHkxVhT/Xu3M4MNWs2ezhxhdUf/bHNC7KUU8/z7eYRcQKA5/
	AUzjGZmL2ShiVHg69w6TWyC6Wq/psLp7wTpGDDqxUFkE8Ws835vrq4qtxuJxJ0VgL0hX0DumMdF
	XwyQGRQqgWtSWvM09BM4qWYp/5cUIlhKrU/G2aAR9Yc69pv5G0DO33O1B2hnUQ5tOz8g+DXXDym
	Wfi8p9VD31Z4cN+eXnQlvBaWaYASRxP+Gqs=
X-Received: by 2002:a05:6402:35cc:b0:5e6:180b:557d with SMTP id 4fb4d7f45d1cf-5ebcd43158emr2411784a12.11.1742546396669;
        Fri, 21 Mar 2025 01:39:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGs4caFsUnRVpqBdx+4SbS6dWmYKbdRloOjOBIjJSQn0qZVK+++RC3GAE2A8xqj7E2Wvv7FGg==
X-Received: by 2002:a05:6402:35cc:b0:5e6:180b:557d with SMTP id 4fb4d7f45d1cf-5ebcd43158emr2411763a12.11.1742546396334;
        Fri, 21 Mar 2025 01:39:56 -0700 (PDT)
Received: from thinky (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebccfaecfbsm947033a12.41.2025.03.21.01.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 01:39:55 -0700 (PDT)
Date: Fri, 21 Mar 2025 09:39:54 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: fstests@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH v2] fstests: update missing gitignore entries
Message-ID: <wimvsac2kn2z2xidcwpqrdgd4rgrfqv2mjul35skj2pi64fhpb@aqxwfmgrtk4r>
References: <20250319-update-gitignore-v2-1-a77183931c15@kernel.org>
 <Z90UJq9JN-Tos4f3@infradead.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z90UJq9JN-Tos4f3@infradead.org>

On 2025-03-21 00:24:22, Christoph Hellwig wrote:
> On Wed, Mar 19, 2025 at 11:57:33AM +0100, Andrey Albershteyn wrote:
> > Add autoconf backup files (file~).
> > 
> > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> > ---
> > Minor patch to update gitignore autoconf backup files.
> 
> > +/*~
> 
> Why would we ignore those files?  They are garbage that should be
> removed.

Isn't the goal here? The ./configure~ is not part of the repo
but just a backup file

-- 
- Andrey

