Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6399A133425
	for <fstests@vger.kernel.org>; Wed,  6 Mar 2024 19:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709753655; cv=none; b=cPl6zPmx+kViQAWIoqLGfuNKVyNTTRyvjSixE2Otrbs/Rp7HVzLJuAZ7MTlJM6F90DU5BL9xlsbcFMRxHfA6f934gbqpHVB1104l61mjcJCwuQe33v5rLf9qCVXsldFctZrHsYNOBrYduV7PhcRIusWbN10X3ruv61tYDV4yYXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709753655; c=relaxed/simple;
	bh=SxfVJURIzirgXEki2Q1gUtvHaP3zQ5tvvv5gZnyQEG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uDLEehPGbRM+hsOfLrd9fJ5UNiLSVBrtVytY29SMOwj5GHe/ckv02706pwJT/AymROqVu+r4ekHznmjQSGrgbMzZ+0VP9A29vdJe2zCNzpDVoNhcXrKHQoYGhPwpqwXuNy5MM1oirmpn78NNiN7sXOq0hqYuXmy3xDdsIm9wuI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Whooe1W+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Whooe1W+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709753652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VbAJeOilxQrVj/80d5nm/++aGvn6LYNYkNZHnrvuyCM=;
	b=Whooe1W+iO0Ulxw+YIVYJcJ4XfXUF+Jez+8JXk49PgAK87udfeOvfU86SW95+Dl7yygFgH
	YGGMPUudiT9vCVBlR0lkNcgAzciYMbgx00HAiCPdoLgeOHzrCGiaGnfaLJG83Spv8QcB/7
	ueIQK3aFJ+UjBk3bajOEH71xh2FBjqg=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-_gl4n9NcOvel2G5JbHHvqQ-1; Wed, 06 Mar 2024 14:34:10 -0500
X-MC-Unique: _gl4n9NcOvel2G5JbHHvqQ-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1dc157e4778so928495ad.0
        for <fstests@vger.kernel.org>; Wed, 06 Mar 2024 11:34:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709753650; x=1710358450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VbAJeOilxQrVj/80d5nm/++aGvn6LYNYkNZHnrvuyCM=;
        b=W5Sbxzzi9oLrVJ2EihTMfHx9DfP76DA/sB1q70K0aOWDO187onFPh4LkCkolg8FIet
         0cMzJJvHL7J7CLYPkLI9qguTXAuCK09AocrSi1TB4tX/ngtyU6gy0tzrYlF+yURU9cFm
         w51/hFHGtlvn+L+Ge+f4AIplzXBeZu77P5K0LmMewSP7kVl/qxaQJVMaZ2ZD6jbvLAa5
         2yG+eFjP77gZ4Ku8ugDmI64QWSRQA0G1nQLpOmPzOAymsA0MMir7SeynbreWQk1kvwV9
         RRzsai/CD5xBllZFI+aKknUyzNTe+B4aAQW3dI+tNvAj3VsOj4yo17s4ePEJXExvuQX6
         FJiw==
X-Gm-Message-State: AOJu0YzP5YeR7cQsUWkijtj4FQNrtEi7uFEkxeiFn9KQLvuvbYdUzEun
	3+jYT+o5Yt3ggIXzJCA5ALQHZ7JX0G4dt2fDEtN3+Q2zJ4+3cn7ibZyI1Uh3mOynkpf7rVb58L6
	/GJt8t5FSpFbJD1xRnslXpUBzAJ88J4wrQXcgKMjJ7LHJk609gco46Io=
X-Received: by 2002:a17:902:8bc9:b0:1db:f952:eebf with SMTP id r9-20020a1709028bc900b001dbf952eebfmr5673842plo.44.1709753649605;
        Wed, 06 Mar 2024 11:34:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWUyGcsbKzjZYh7Y/HcUnkwnNTWxR58rpCHLc8BJPLSI18GJCeamj6Oyk/s1kDQGkFvdS9bA==
X-Received: by 2002:a17:902:8bc9:b0:1db:f952:eebf with SMTP id r9-20020a1709028bc900b001dbf952eebfmr5673802plo.44.1709753648885;
        Wed, 06 Mar 2024 11:34:08 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id kw14-20020a170902f90e00b001db70183611sm12984720plb.270.2024.03.06.11.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 11:34:08 -0800 (PST)
Date: Thu, 7 Mar 2024 03:34:04 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, io-uring@vger.kernel.org
Subject: Re: [PATCH 1/3] fsstress: check io_uring_queue_init errno properly
Message-ID: <20240306193404.oc34ks4p5ez37s57@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240306091935.4090399-1-zlang@kernel.org>
 <20240306091935.4090399-2-zlang@kernel.org>
 <20240306155357.GA6188@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306155357.GA6188@frogsfrogsfrogs>

On Wed, Mar 06, 2024 at 07:53:57AM -0800, Darrick J. Wong wrote:
> On Wed, Mar 06, 2024 at 05:19:33PM +0800, Zorro Lang wrote:
> > As the manual of io_uring_queue_init says "io_uring_queue_init(3)
> > returns 0 on success and -errno on failure". We should check if the
> > return value is -ENOSYS, not the errno.
> 
> /me checks liburing source code and sees that the library returns a
> negative error code without touching errno (the semi global error code
> variable) at all.  That's an unfortunate quirk of the manpage, but this
> code here is correct...

Yeah, that confuse me too, especially some io_uring functions set errno,
some return -errno ...

> 
> > Fixes: d15b1721f284 ("ltp/fsstress: don't fail on io_uring ENOSYS")
> > Signed-off-by: Zorro Lang <zlang@kernel.org>
> > ---
> >  ltp/fsstress.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/ltp/fsstress.c b/ltp/fsstress.c
> > index 63c75767..482395c4 100644
> > --- a/ltp/fsstress.c
> > +++ b/ltp/fsstress.c
> > @@ -763,8 +763,8 @@ int main(int argc, char **argv)
> >  #ifdef URING
> >  			have_io_uring = true;
> >  			/* If ENOSYS, just ignore uring, other errors are fatal. */
> > -			if (io_uring_queue_init(URING_ENTRIES, &ring, 0)) {
> > -				if (errno == ENOSYS) {
> > +			if ((c = io_uring_queue_init(URING_ENTRIES, &ring, 0)) != 0) {
> > +				if (c == -ENOSYS) {
> >  					have_io_uring = false;
> >  				} else {
> >  					fprintf(stderr, "io_uring_queue_init failed\n");
> 
> But why not:
> 
> 			c = io_uring_queue_init(...);
> 			switch (c) {
> 			case 0:
> 				have_io_uring = true;
> 				break;
> 			case -ENOSYS:
> 				have_io_uring = false;
> 				break;
> 			default:
> 				fprintf(stderr, "io_uring_queue_init failed\n");
> 				break;
> 			}
> 
> Especially since you add another case in the next patch?

Sure, that looks more clearly, I'll change this part. Thanks!

> 
> I'll leave the style nits up to you though:
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> 
> --D
> 
> 
> --D
> 
> > -- 
> > 2.43.0
> > 
> > 
> 

