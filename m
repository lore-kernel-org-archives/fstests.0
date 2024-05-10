Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72B2137C23
	for <fstests@vger.kernel.org>; Fri, 10 May 2024 01:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715305437; cv=none; b=J3EElk6hI/NbAaWrvSueW6CbGpvKRoIdynTbp9RpOjDzY7dDRyUtUD4ZiJoPWeRr+/qeDvK1qxOJ3jtljcmYOzQ4SvyJEsTb1JJdTfOZvENwPDv1qEQQ5uGPrjCqF604TdVluYG+IVCE9r956a4iSQVoV/9jUDK4XywKDUk6K6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715305437; c=relaxed/simple;
	bh=2cVTUrAn3HtqXxTNDMOf2vnGsDC1QfmzdsORi4aGGt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XS0mT946DYS5PVBk7aBHVw4BfJhqkqSAMySd4Q9RM2GBV/CY4ac81LuT2OZNsFiBdBxre43x1peL6xV+ukS3ajddd4sxQJ/0IgQg66MnZhDubF0985Lty/WICVIdRkzq+fLovQ9MPPv/4CtDlffsWd9wnMxbSBYuyD2Za1yLsAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AVySHiLk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AVySHiLk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715305434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ux3LtJLUBP0RF0OasUSkpMD1MI3+rUt/w12+63ndBfo=;
	b=AVySHiLkqp6yIP4p0y98YiKVvlxzQf/hkPx1qIhbZUD7bmQF8bKgdzBIZaJ1MC1j+dToWm
	tlDQ1itx+iNdMTpUa4UN8oMNGw02HuxiSlla0SS1X0BJAqpADGqClfnAQq0Jx5R3aMVfcz
	c0ADUKHs2bz0SJIv4BA01aiD3iVjFkM=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-dXZu_7hAO5a3Wu6ENbZnew-1; Thu, 09 May 2024 21:43:53 -0400
X-MC-Unique: dXZu_7hAO5a3Wu6ENbZnew-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2b2738ce656so1340077a91.0
        for <fstests@vger.kernel.org>; Thu, 09 May 2024 18:43:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715305432; x=1715910232;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ux3LtJLUBP0RF0OasUSkpMD1MI3+rUt/w12+63ndBfo=;
        b=sYSLkLfIBNY5DIY/b/N/Eh1HSKT0RVhIhMBxJ/Pn1WADW5nG+jtTpFJVF0aJ3Ptrln
         uyW+j4bRsNuILkkljcC03iDexkQ0MSYbOayp8ttvIf5Fo9sG5QiBNMfuruin9jD5rVt/
         WC9bCH3BA4oR6y9SvncB5P5BWFPYgVf0Wi1aE9w5CetyVBt4P4F4TmFleXzeclurb3M7
         v4P5nr7uJalLNP69DNY9ewPwIRLbKwCDp/ILWgNFn2uBBAd8Ek93EN1rHIM6fYQJzir4
         IIRYRRZNAZ9LNShi47yR86qMkmuhYjDAAgqZ2B4kHR0J2PlNlaZRhemZT1NUQPJfMj3J
         AZJA==
X-Forwarded-Encrypted: i=1; AJvYcCUq/OuljB+m3xe+A4bJZy0+062q5niUZPBWFP+LR3H5Bdq1ouLOIOvY3gQjmfJDS+NJQ0Hi/aMBMMJS4M+lYi/Kx2roFXXtng==
X-Gm-Message-State: AOJu0YyT9V6m+uX+yxTD83+Tbvy1+lEcJTaaKtTvptQbwm14MdLZ5o5i
	q/mG5MRAvHtgj5j2FbPGHfNB6SFi6CEP8DbOM9MRy1jEMxaqJArudzWgAaH9I6CMBRnDAPRD8kG
	wCCdxHTRzZ4kEKyklsOM2I44TPtWJebLYvEjOVTSeQXiUqmUvZW2h9sYeR5ayGJxthg==
X-Received: by 2002:a17:90b:3504:b0:2b2:9d08:80a3 with SMTP id 98e67ed59e1d1-2b6ccd76d69mr1196775a91.35.1715305432005;
        Thu, 09 May 2024 18:43:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGfHjQYSxGcm1cGXnwyiz432nO0G4IsTrtDWF4pquQ3equJ0RZ1nubTig+GPBO0a8Ng9A2Lw==
X-Received: by 2002:a17:90b:3504:b0:2b2:9d08:80a3 with SMTP id 98e67ed59e1d1-2b6ccd76d69mr1196759a91.35.1715305431398;
        Thu, 09 May 2024 18:43:51 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b628ea6aadsm4000694a91.50.2024.05.09.18.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 18:43:51 -0700 (PDT)
Date: Fri, 10 May 2024 09:43:47 +0800
From: Zorro Lang <zlang@redhat.com>
To: David Sterba <dsterba@suse.cz>
Cc: David Sterba <dsterba@suse.com>, fstests@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 0/4] Move test cased from shared to generic
Message-ID: <20240510014347.h3pwsri3h6kastn3@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1715108589.git.dsterba@suse.com>
 <20240509052901.dna2xq3yd4p2b7m3@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20240509162855.GI13977@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509162855.GI13977@twin.jikos.cz>

On Thu, May 09, 2024 at 06:28:55PM +0200, David Sterba wrote:
> On Thu, May 09, 2024 at 01:29:01PM +0800, Zorro Lang wrote:
> > On Tue, May 07, 2024 at 09:07:28PM +0200, David Sterba wrote:
> > > Hi,
> > > 
> > > as discussed recently, the tests in shared should be in generic.
> > > 
> > > Based on branch patches-in-queue, commit e098483c662d8f0b7583edca1501d8addd3b7549.
> > > 
> > > David Sterba (4):
> > >   Move shared/298 to generic/740
> > >   Move shared/002 to generic/745
> > >   Move shared/298 to generic/746
> > 
> > Thanks David! There're two shared/298 above, I think the former is shared/032 :)
> 
> I noticed the wrong subject of patch before sending and updated the
> patch manually but not the summary in the cover letter.
> 
> > And I foundd that all .out files were not changed properly, so I suppose you
> > did that manually. The "mvtest" tool will help you, e.g.
> > 
> > # ./tools/mvtest shared/032 generic/740
> > # ./tools/mvtest shared/002 generic/745
> > # ./tools/mvtest shared/298 generic/746
> 
> I didn't know such tool exist so yeah I forgot to update the .out too.
> Do you want a resend or can you fix that when committing?

Sure, as this patch has gotten RVB from Darrick, and if you and Christoph all tend to
improve the _require_xxx helpers later, I can merge this patchset at first (rewrite
with mvtest script :)

Thanks,
Zorro

> 

