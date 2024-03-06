Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648BD1386A3
	for <fstests@vger.kernel.org>; Wed,  6 Mar 2024 19:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709753940; cv=none; b=COzo3NdnRwbNuMQxURB9zFFC07EUx6xdFmuFwFxch8eH0qOvKcoF7HUJaft7shhwjB6v4nvbZdlj7XpXJwvDGYalj5PAMbTilnvRyZDlJgmDiIKOnwUFZMynHbZsTCEyOcsBlvpKxgEMxHnmBaoOe7z2oZewmXdIfTINRFaciqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709753940; c=relaxed/simple;
	bh=rOkXvC/2O3BJs8QT2acVqFPP10yE4TuK9fL6MCvN44o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eV73w8ouFJbkIJCZ/DCDoiFL2n/HL8zE8NaDcoAsETSZvuSt5/R1Q8BNGrzw0C4RE6lF1JzzmKN0TrSVuuO9c3sU0pork/XwO6MVDfdg2A+5vZgMA4KaUNY9Axm3fDWSNDzM7OFWzGN+1flIUtuoTlUWMEdaV5UqyOGqXgqm1gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Okevkc+H; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Okevkc+H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709753938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P89CM40iIZfCeQn9OYPtlN2D3LAieBdJkB2PwXlwjMg=;
	b=Okevkc+Hv2HbY5b04TJ4pGXi6G06Z8YGf3EKdA6u9iPd96hcjwMnW+8qI8OJpf9b26vPC6
	Mh89z5kjg4U7MeK81MuOgmAxBdI26PP278u7Zlmqc01PT7QMQO+CDtE1lpRQLzvu0RLEWw
	A22SkNvLpPQt57s3Guv0Qz7cMZXc3DQ=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-o-UB4yIdMBWOpt0fiARUeQ-1; Wed, 06 Mar 2024 14:38:57 -0500
X-MC-Unique: o-UB4yIdMBWOpt0fiARUeQ-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6e5d996a3dcso68968b3a.2
        for <fstests@vger.kernel.org>; Wed, 06 Mar 2024 11:38:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709753936; x=1710358736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P89CM40iIZfCeQn9OYPtlN2D3LAieBdJkB2PwXlwjMg=;
        b=tKhPuJ6vIrfnrRHXJ/KabneXx5df4nXWB+doP1jmIpBvTnErBi/oe8UbEeT7ynxTRe
         vYD3xOANtbi6QPDnwhRgfJAUJHPy5yU+mdv4E9vPhJfhrGEDDX44lR+8HgXxFXWKYXfK
         AWuJX3qN904JBpth9TgU8Iuu5zpQrO4a34EcojEPd5dgzsb6+VkNJ1G9FLVYdfSWFHfr
         ZJv2AnLep0T6b/OhWP2YypCUh72pf94GZIveLC/4CnN4twNT7nKUW502dPqgTYrrE3Eq
         NpkI6yS8DlhCiD6u5a1AVlR1q/x8Hjj8oV2+nwzU1Mo8VJClkVu/elmJ4kB1N8vQGBoK
         2KQA==
X-Gm-Message-State: AOJu0Yy9ebTk9zYnv41hfYWHs2CKOLnawXTgh8P3BOl9rGN5aC1KXori
	/oHAXIvUPxsdxsX25+dCUYVB8RPBSKDqqhueysyWbHQLTGUUQB6hDbFEWx2rAI3YbRE2zEq7G5K
	uR8kATINSm/qLtai859Wwd3z2xQogZ0MA+g6qhsyRSHBol7UQmj/cJZU=
X-Received: by 2002:a05:6a20:6a28:b0:1a1:6da9:e16 with SMTP id p40-20020a056a206a2800b001a16da90e16mr689264pzk.21.1709753935832;
        Wed, 06 Mar 2024 11:38:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGF6+aoeUmtfWjxS+sbqWLLon4bIjM5h1urB7K74LQeTsenxFzGbCFCIms+0ejpNoDh/pN7AA==
X-Received: by 2002:a05:6a20:6a28:b0:1a1:6da9:e16 with SMTP id p40-20020a056a206a2800b001a16da90e16mr689242pzk.21.1709753935313;
        Wed, 06 Mar 2024 11:38:55 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id u20-20020a62d454000000b006e468cd0a5asm12020204pfl.178.2024.03.06.11.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 11:38:54 -0800 (PST)
Date: Thu, 7 Mar 2024 03:38:51 +0800
From: Zorro Lang <zlang@redhat.com>
To: Jeff Moyer <jmoyer@redhat.com>
Cc: fstests@vger.kernel.org, io-uring@vger.kernel.org
Subject: Re: [PATCH 2/3] fsstress: bypass io_uring testing if
 io_uring_queue_init returns EPERM
Message-ID: <20240306193851.tpcaq2vklbjekgde@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240306091935.4090399-1-zlang@kernel.org>
 <20240306091935.4090399-3-zlang@kernel.org>
 <x49a5nbuze3.fsf@segfault.usersys.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x49a5nbuze3.fsf@segfault.usersys.redhat.com>

On Wed, Mar 06, 2024 at 10:57:08AM -0500, Jeff Moyer wrote:
> Zorro Lang <zlang@kernel.org> writes:
> 
> > I found the io_uring testing still fails as:
> >   io_uring_queue_init failed
> > even if kernel supports io_uring feature.
> >
> > That because of the /proc/sys/kernel/io_uring_disabled isn't 0.
> >
> > Different value means:
> >   0 All processes can create io_uring instances as normal.
> >   1 io_uring creation is disabled (io_uring_setup() will fail with
> >     -EPERM) for unprivileged processes not in the io_uring_group
> >     group. Existing io_uring instances can still be used.  See the
> >     documentation for io_uring_group for more information.
> >   2 io_uring creation is disabled for all processes. io_uring_setup()
> >     always fails with -EPERM. Existing io_uring instances can still
> >     be used.
> >
> > So besides the CONFIG_IO_URING kernel config, there's another switch
> > can on or off the io_uring supporting. And the "2" or "1" might be
> > the default on some systems.
> >
> > On this situation the io_uring_queue_init returns -EPERM, so I change
> > the fsstress to ignore io_uring testing if io_uring_queue_init returns
> > -ENOSYS or -EPERM. And print different verbose message for debug.
> >
> > Signed-off-by: Zorro Lang <zlang@kernel.org>
> > ---
> >  ltp/fsstress.c | 15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> >
> > diff --git a/ltp/fsstress.c b/ltp/fsstress.c
> > index 482395c4..9c75f27b 100644
> > --- a/ltp/fsstress.c
> > +++ b/ltp/fsstress.c
> > @@ -762,12 +762,23 @@ int main(int argc, char **argv)
> >  #endif
> >  #ifdef URING
> >  			have_io_uring = true;
> > -			/* If ENOSYS, just ignore uring, other errors are fatal. */
> > +			/*
> > +			 * If ENOSYS, just ignore uring, due to kernel doesn't support it.
> > +			 * If EPERM, might due to sysctl kernel.io_uring_disabled isn't 0,
> > +			 *           or some selinux policies, etc.
> > +			 * Other errors are fatal.
> > +			 */
> >  			if ((c = io_uring_queue_init(URING_ENTRIES, &ring, 0)) != 0) {
> >  				if (c == -ENOSYS) {
> >  					have_io_uring = false;
> > +					if (verbose)
> > +						printf("io_uring isn't supported by kernel\n");
> > +				} else if (c == -EPERM) {
> > +					have_io_uring = false;
> > +					if (verbose)
> > +						printf("io_uring isn't allowed, check io_uring_disabled sysctl or selinux policy\n");
> >  				} else {
> > -					fprintf(stderr, "io_uring_queue_init failed\n");
> > +					fprintf(stderr, "io_uring_queue_init failed, errno=%d\n", c);
> 
> I think you want to use -c here, right?

Sure, will change that, thanks!

> 
> Other than that:
> 
> Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
> 
> 

