Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7841EA91
	for <fstests@vger.kernel.org>; Wed, 22 May 2024 19:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716406657; cv=none; b=V5B0BE7bqj9Rzp0pLJxLzHJ0ifcEft7de6CuE3DfXxCTQGarIOlVmS4/VgRP8G6A9oLao0NYbMkb1X5VgOzZZVYy3VMOIEkX/TzgcGkhNb9AlNQeSCom85Wx++TXlRDXQDd9/NaSkAgD3uOcUzb1ki8eR5YsMqR/GkP3Z93jcj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716406657; c=relaxed/simple;
	bh=6jQnQHEufZWV8OQw9gGw22QmBxbGhD0v0w5JrwRwqsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IrYM+KKK5sx/zSV4tPbOkPEmFE0YBih27u4oBAHFVLfeQhjzQLLG3FHDIg9dUwt6J9GlDVf7OTh4ETLfdUFXcp+Us9yacvqTIufeEpy6vpbcUfMO2EwHolxPzMWdctNWhYrzj1pB71S3ZgGDypJh6E5Mvgk7bMcwqRiHwfUSmcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a/Fm7uxT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a/Fm7uxT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716406655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/+vXJUvYDvXqK/fj5nHxClrjyNfJ6w+vU6wonQDU4jY=;
	b=a/Fm7uxTYL3IQXe5SozOUW+VjWT5oUQ/rCcG31lIeyqVl4crDWnVjwBa+0FBhQohz/OuFu
	V/BEbk/HvCJREEzHbd2PHtjTojVILq2yNvQjNT5vnm+vC3ucAr5nU3OeGQKGgM0l7zC0gM
	nkf8Tf3/cEQYD6SlFwQjZudCQ87Zwdw=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-6VHY3XzPOwmuMZQ5gpgVng-1; Wed, 22 May 2024 15:37:33 -0400
X-MC-Unique: 6VHY3XzPOwmuMZQ5gpgVng-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2b413f9999eso19348a91.1
        for <fstests@vger.kernel.org>; Wed, 22 May 2024 12:37:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716406652; x=1717011452;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+vXJUvYDvXqK/fj5nHxClrjyNfJ6w+vU6wonQDU4jY=;
        b=rAEWot3Q6K5W3T4038omFwnRIZkxbJdXyGbBtzIthcSjeij0HcdrP/cjHRyqgHJSx8
         Lmm6iDz+9MDL5A72x2xY7AqYuqm/yGiA0tRn524w5S8QwiAWfIVMG6qk/f2ook2Zf9A9
         eN8q12feS/j+tddPRzPIBFREXDoudWpIEsbmD4yVnI3gQvR3zVTurO1I/hbnOB7Vs6o+
         y5bQbygPUEHW8NEIwApRckCBDU3Ti7vtZlnrnmt/JiuCIykIFnOHQOemC19SR/iCR31V
         mLIgvu+GpTBCodMmQJs1py1GNEthK4DZBptHq8ebPhYpiFunFNNYDiZpQVn2Pa1XsXJz
         f7UA==
X-Forwarded-Encrypted: i=1; AJvYcCWzBFfSKXKFIquRz0yj5qiO6DFLihNvfSdW7E4K5yx1+CUlvnMx1oZN8emiEs90qZ5g0l/sz4R4MHP8zctWkIkuyI7TC/1R5w==
X-Gm-Message-State: AOJu0YxToq5YE61Ou+iTLydwqKEMQAVItGt/VdA12gZ0hprBEtliUJ27
	07GXQB4dYaQBcPCIRtBlEItmK3MaTtIKYCuCy9F4e27Y0uPodgKu8eENUklEyFCr4h2QkBnAy9R
	AY+WRuTZLmib5fAHiYrXgRXqRHKUiBIZ1SKvaQAkSDx5rmeRufaC/mraUJpV2ExCxdw==
X-Received: by 2002:a17:90b:37c8:b0:2b9:fc72:547e with SMTP id 98e67ed59e1d1-2bddceca852mr325864a91.18.1716406652076;
        Wed, 22 May 2024 12:37:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOpPnRVoydR52gfv/O08YpoOUtaMqE6WsdHBfqvRG4EVN9apq0QQWcJ2W5yB01zY7ZyNdADw==
X-Received: by 2002:a17:90b:37c8:b0:2b9:fc72:547e with SMTP id 98e67ed59e1d1-2bddceca852mr325837a91.18.1716406651399;
        Wed, 22 May 2024 12:37:31 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bdd9ef7622sm172490a91.16.2024.05.22.12.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 12:37:31 -0700 (PDT)
Date: Thu, 23 May 2024 03:37:28 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: cem@kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] Log kernel version in check.log
Message-ID: <20240522193728.uw3nxitq5jho3a6c@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240522113408.392468-1-cem@kernel.org>
 <20240522144241.GA25508@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522144241.GA25508@frogsfrogsfrogs>

On Wed, May 22, 2024 at 07:42:41AM -0700, Darrick J. Wong wrote:
> On Wed, May 22, 2024 at 01:33:38PM +0200, cem@kernel.org wrote:
> > From: Carlos Maiolino <cem@kernel.org>
> > 
> > After collecting several xfstests runs, it's useful to keep track on
> > which kernel a specific run happened.
> > 
> > Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
> 
> I wonder if you want to capture more of the system variables, like
> __generate_report_vars does?
> 
> (Should we be capturing ${FSTYP}progs version too?)

That's good to me, but my concern is: It's hard to have a common method to
get the ${FSTYP}progs version. For most of localfs, "mkfs.$FSTYP -V" can
get a version message, but not all can do that. Even if we can let each
$FSTYP get its version through its own way, but the testers can install
the ${FSTYP}progs by many different ways, e.g. make & make install, or
a .rpm, or a .deb or something else.

If you have any good idea, please feel free to tell me:)

Thanks,
Zorro

> 
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> 
> --D
> 
> > ---
> >  check | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/check b/check
> > index c6dba89b..7703c128 100755
> > --- a/check
> > +++ b/check
> > @@ -478,6 +478,7 @@ _wrapup()
> >  		fi
> >  
> >  		_global_log ""
> > +		_global_log "Kernel version: $(uname -r)"
> >  		_global_log "$(date)"
> >  
> >  		echo "SECTION       -- $section" >>$tmp.summary
> > -- 
> > 2.45.1
> > 
> > 
> 

