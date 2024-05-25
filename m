Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C988663BF
	for <fstests@vger.kernel.org>; Sat, 25 May 2024 05:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716613960; cv=none; b=i6ayAmcmi3Jr5r081fXLEWEZg+Ryho8ypGI+s+4YgR+un5T5JOpDQ0lfNNfw211fEGaxG5Av4cZY/taUW/UQ6nmDSXgME44+bVAfm7YMnpC8e0fC7rtc+52frsM/KRyNGd5Q4dic2soxOlO9DFxO3Gs7Cje6/Ou7em5myqCYvVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716613960; c=relaxed/simple;
	bh=NoScc7BCnT3a7Y9eXMZYmu+gOCtFm6drlEkQt5/JKFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R8bcf1Fq0R+XK06u6TSDxRtZ5s+Tat/iE0Y3oBtqm7AfaUFAG+gl4wjrOpzRboMcn47fSD6pQFJ2bPnTUMDfbgpy6+QFf/9waYM1zFFPKtBy3WrAIixodVb4vs2G+g6SJ7U4lVnu8uwDVbNNfZv8ereedf5csHtTo0ZbvoUD4ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WDWx6dcX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WDWx6dcX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716613957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AcgeABkqh/36IYL9u08JfhPgkrwxMk2ZrXDmFh4maBg=;
	b=WDWx6dcXvCVJxp7L9BUqAqHSw07LdTxrCUfyMDDldgpV/rsRXS68B6H/hqIDdTZMrweQsw
	4hQb1SZA0HGbL2l1aDrapqUSO6tT/Tpn7SM/FXxl0tBTIkQtbiktp0783eftp4F4i6KEhi
	z140Cc9swubIuc6/zxI6mIGH4DcmWNc=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-nbu3AyqLO4uwVznvnEqITw-1; Sat, 25 May 2024 01:12:36 -0400
X-MC-Unique: nbu3AyqLO4uwVznvnEqITw-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-24ca074ea92so1602341fac.3
        for <fstests@vger.kernel.org>; Fri, 24 May 2024 22:12:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716613955; x=1717218755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AcgeABkqh/36IYL9u08JfhPgkrwxMk2ZrXDmFh4maBg=;
        b=OYGkQmPjLPhS2WuNrH4+mJoPxzCl3HjSPry2vSIlKBCySMug4rxZc35ajbm2zJ5ftQ
         V1C8Y7rkZv5Q4VPdKjVnfXx217LXvtrIZcpJ9SNUIxrWW+R1ivFnbCSJUCeRZETj181g
         6F+nsFbz+oL/je+p4+mSGTnXjQwn5Rp52pBsbCPG9Qr/gx30DoEpwfjU4lJW5uqPp8pl
         +prUy6nh827WqlRMdx3TU+z1gVjYvhfFu38EQxl47+ai3pDwOFsSF2hXwePuYXsAEnuz
         ikejTuKWGxTAxe7MNmiJX1CnKNZvPZrXLIOr0eOncTc7xQ8RGP4fRMp9rAGWrbBwwk2u
         ZTdg==
X-Forwarded-Encrypted: i=1; AJvYcCUBhGZcMKTvlC518UynRldlBCM8vXGwRn7l/oc+uPxUpQHEuhVx3vmlIGvr4BOxyhBPVb76XKqSN3IKvpHlggWQBoHRfVI7cQ==
X-Gm-Message-State: AOJu0YzmeaABImNgxjWUadbFq3Fh/8oJ5BhAAUfTh2cvVmGqGV8Rpr44
	fhfRFRsVvSfWAoNKTVvy84voFaqF2o+WeWBOhcb/74h9W25n0paxlz8x+Eaxn/4Tg68NNclWKyh
	58ubBaHI+a+4tG8n+NAqFx+fuxLa/A2Yuer436dQPE5Ukt534eegqILRjjgkAdoedgA==
X-Received: by 2002:a05:6871:58a6:b0:22a:b358:268 with SMTP id 586e51a60fabf-24ca127e786mr4447412fac.25.1716613954916;
        Fri, 24 May 2024 22:12:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBn2NBrqgN/WNwQWZF7aWHOyNNdC0gBZqQ424yFD0MDqKOyqkb41ON4L8dHWCSRVyCryTQww==
X-Received: by 2002:a05:6871:58a6:b0:22a:b358:268 with SMTP id 586e51a60fabf-24ca127e786mr4447406fac.25.1716613954502;
        Fri, 24 May 2024 22:12:34 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fd1d725fsm1848592b3a.169.2024.05.24.22.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 22:12:34 -0700 (PDT)
Date: Sat, 25 May 2024 13:12:31 +0800
From: Zorro Lang <zlang@redhat.com>
To: David Sterba <dsterba@suse.cz>
Cc: David Sterba <dsterba@suse.com>, fstests@vger.kernel.org
Subject: Re: [PATCH] Remove richacl support
Message-ID: <20240525051231.wwam6g4zf6efy5y7@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240522173048.30558-1-dsterba@suse.com>
 <20240523040922.ozy5drxg7w4svrj5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20240523134019.GB17126@suse.cz>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523134019.GB17126@suse.cz>

On Thu, May 23, 2024 at 03:40:19PM +0200, David Sterba wrote:
> On Thu, May 23, 2024 at 12:09:22PM +0800, Zorro Lang wrote:
> > On Wed, May 22, 2024 at 07:30:48PM +0200, David Sterba wrote:
> > > There's no support for richacl in Linux and based on information in the
> > > links will never be. Remove all related files and support code.
> > > 
> > > References:
> > > - https://wiki.samba.org/index.php/NFS4_ACL_overview#Linux
> > > - https://lwn.net/Articles/661357/ (article, 2015)
> > > - https://lwn.net/Articles/661078/ (patches, 2015)
> > > - https://github.com/andreas-gruenbacher/richacl/
> > > - http://www.bestbits.at/richacl/ (n/a anymore)
> > > 
> > > Signed-off-by: David Sterba <dsterba@suse.com>
> > > ---
> > 
> > Thanks! The richacl testing was brought in by:
> > 
> >   commit 73f9e47abdc58f39b7e39b3729bc88db624c9771
> >   Author: Andreas Gruenbacher <agruenba@redhat.com>
> >   Date:   Tue Jun 28 14:47:26 2016 +0200
> > 
> >       generic: Add richacl tests
> > 
> > Looks like we were too hurry to merge the test things before the kernel
> > patchset get merged.
> > 
> > Sorry I didn't learn about the details. From above links, I can see how
> > we tried to implement the richacl, but I didn't see how we denied it and
> > never have it in the future. Is there any record (e.g. an email reply) to
> > learn about the "history"?
> 
> There were many revisions of the patches, talks at LSF and LWN articles
> over the years so I'd consider it a common knowledge. Web search leads
> me to lkml.org links that does not work today so I can't point you to a
> mail where Christop said a clear 'no, never'.

OK, that's clear enough, if you've made a decision in LSF. This patch removes
any cases, so I have to confirm :) Sorry I didn't attend the LSF this year, feel
free to tell me if I missed anything.

This patch looks good to me, it totally reverts the 73f9e47abdc5 ("generic: Add
richacl tests"). So,

Reviewed-by: Zorro Lang <zlang@redhat.com>

> 

