Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D143A3E9A
	for <fstests@vger.kernel.org>; Tue, 31 Mar 2026 20:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774987592; cv=none; b=uOrBUteJIVovN0L0a1HB6unAm9JMA6isA3Alb98edMYuJlqkuyr+RRPq0HgCmc161YfP+BA+Avgqj1R+8c3d7zcVakKlMEF3Yb/3ald9a3MCr9UubF8fHDFIs7VGPPVjGhB56IwfUhgnUdHyvRQwG4ah6M0MQ7mb2p8A79W/anU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774987592; c=relaxed/simple;
	bh=u7Cm9YVElUVjzpDu2GXr2uaPPzVtpRbccwHlOy6TUvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UttuNqlQ9NmT4pG+meM/DRrYMyd7nuXaz0VXF1CKIEVcSDqRWY8yI0V+os18OebcHYG+ITqUqy9MJjvfSH4kNkFaOxv3Luz1NEbqsqlPgN4BmuH6gWLWbFetTXYdYwk+9XLbJpViHT4wZ0Rx8H30bqN1jXpFR1/q3P5gIeDD9xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y83VRUhb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gmxf9nj/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y83VRUhb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gmxf9nj/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774987587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r0I94zO8k40YUG8ln8iyh6a8FQP9HTvjx16ZglDMrTI=;
	b=Y83VRUhbH4GKWvoXzcDSUnZDzs7I+6xKMeMElGGdBKPOBwwcQEIQT8PVRAi4ss1VLEUvcm
	V1EVyBNofIRv5gims8D1stAV4MUfYHSWjoeEXkrchNh5QN7RHDFZLy6M0w4ctFpPkmR4Am
	Dz71hWUjCSFhInFHX7/PmOqG2EQkfds=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-jGjkAU7qPBCQoYrdoZZmjw-1; Tue, 31 Mar 2026 16:06:26 -0400
X-MC-Unique: jGjkAU7qPBCQoYrdoZZmjw-1
X-Mimecast-MFC-AGG-ID: jGjkAU7qPBCQoYrdoZZmjw_1774987585
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b24cd2e2b3so32106195ad.0
        for <fstests@vger.kernel.org>; Tue, 31 Mar 2026 13:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774987585; x=1775592385; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r0I94zO8k40YUG8ln8iyh6a8FQP9HTvjx16ZglDMrTI=;
        b=Gmxf9nj/siJlM58NYR/n8HraqPA7Dx1q23nc6zWweeD1k/AOlf6xeBu8GSSWm1b6D1
         30TWg6CJsY9A/0MFHtX7s1St5g7PmqBTRKF3VigaKM3X5qUV+oxk0gyaMgSBCVt80Qit
         f4Vrh2+0vweMYIm29zAG0cFfikbKWh6oP5NxMCl2e2CrdeRcQBtmP/anIv2sUKV9I0dm
         Sn3hBmsoR3R8bHqealSuYXXBnay1DrRp0/KwqoXKSFbxK9o597uhhD5xOiIoD3NZJwXZ
         PjmJLx8xLlc0WDqeQzaSb0hhTQ9h06cY1ja0jqVY763ee1rtLWG4ZvFlstxWmtHIbM0d
         eNrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774987585; x=1775592385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r0I94zO8k40YUG8ln8iyh6a8FQP9HTvjx16ZglDMrTI=;
        b=YqF9huvEuCZxwP4HI/liDBo3O5wrEBVaADXSy10MskcuhALxfLPdwLXGq9jZaW1EqJ
         ga3jnTkepEkDeE4kv/6gtVm56qmkSDSH5jVmNXyZ5xX+lLrBg8QKV5HZg9wmDbLc83ep
         gnJS2fSWOIzAi14SXG/nwwDUHf00USr4wljqu5yxvwSYHVOHMu2fDGv7O3ebb7nU/v+4
         0/7WkSEwathzFPQBu7xuqhTIGPh+XSAmk8bTCV5bghX3V9V6cMX26azJ19gcMlBWjTYm
         HM/twtvcpY/bNEd1YcFYm2xYbGtdhqxEoYKh5GY1hQMxwr59OeWZTOHhCw/SjfL+5Tp6
         DBRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMZVW6yzshixxYFO6b7NdXSX7xCXqG7wY6DhlvG1i8qnvbedXyHHWqYVLm88T/vNyhyu9bjpcd@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1Py3HgY2wYpUEVEHNylr0gh6l9Xo/OcHd+8WQiAXYxA/Faf1P
	juMTKCPPUcyVlgvzCv/ClmR1u3pkoDWdKk0shMzjBvEbP2wQYyHpmoFkrLthanxshpSGZF4LuW4
	k6ar6xpOWlU4tTJrVs3nHLtVPj9GaRwsk9F/o5a7VURxLrFLb8OEE97T08aI=
X-Gm-Gg: ATEYQzzCpmqdjwEtyTkKhaZvMokRbEk1/ZnQXOLdeQ6AjTRm3YhiWFqUs7XkwVAcy7k
	/v9RPZScIwZYrCh2edwuIvMRUxlMQVYyLV2EIl0hHfiWeL/4GmKTAgcXfrMpM9VVgiTzn4PLCQB
	P3OXmj1o8H7dGIws3UGSuqu+/MbSARhyu/IRQPY04jav9ekB0UhmMkBGjPdt4Sc0Ll/zcl+Z9BV
	PdLuP9cm+RbSYT1zmplFq9ky9O5ianixvS6+7toZjLY2ZI2k0p9qgYIkVj0ibded21dA3y0gxYc
	ELB4xdeFA90Z8JnD7cmiemC1/nr1n/P1l8ez1+832rHfBpCzsmbK+3YVrWtBrDdHFdNWTeFU9qH
	Ei6QC5EOyDUMEScoGBQ==
X-Received: by 2002:a17:903:2983:b0:2b0:b075:f2fb with SMTP id d9443c01a7336-2b269c7c5e0mr5139695ad.35.1774987584916;
        Tue, 31 Mar 2026 13:06:24 -0700 (PDT)
X-Received: by 2002:a17:903:2983:b0:2b0:b075:f2fb with SMTP id d9443c01a7336-2b269c7c5e0mr5139465ad.35.1774987584440;
        Tue, 31 Mar 2026 13:06:24 -0700 (PDT)
Received: from doltdoltdolt ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b242765b93sm132177325ad.51.2026.03.31.13.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 13:06:23 -0700 (PDT)
Date: Wed, 1 Apr 2026 04:06:19 +0800
From: Zorro Lang <zlang@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Leo Martins <loemra.dev@gmail.com>, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com, fstests@vger.kernel.org
Subject: Re: [PATCH] generic/301: skip extent count check on btrfs
Message-ID: <20260331200619.buww7bpudldcmxof@doltdoltdolt>
References: <c56960b514baf810f2929b5e955a966d9955c468.1774383226.git.loemra.dev@gmail.com>
 <acN3QEpx_YZZN5Qb@infradead.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acN3QEpx_YZZN5Qb@infradead.org>

On Tue, Mar 24, 2026 at 10:48:48PM -0700, Christoph Hellwig wrote:
> On Tue, Mar 24, 2026 at 01:40:00PM -0700, Leo Martins wrote:
> > +# btrfs CoW extent allocation depends on transaction commit frequency and
> > +# metadata reservation behavior, so the 2/3 fragmentation threshold (designed
> > +# for XFS cowextsize) is not applicable.
> 
> It really is a quality of implementation issue and not specifically
> designed for XFS.  But I gues it is hard to force quality of
> implementation on specific file systems.
> 
> > +if [ "$FSTYP" != "btrfs" ]; then
> > +	test $new_extents -lt $((internal_blks * 2 / 3)) || echo "file2 badly fragmented"
> 
> Please break the echo into a separate line to keep this readable,
> either by just breaking using \ or by turning this into a proper if
> statement.

Sure, I'll help to change it to:

	test $new_extents -lt $((internal_blks * 2 / 3)) || \
		echo "file2 badly fragmented"

when I merge it.

Thanks,
Zorro

> 
> 

