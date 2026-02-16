Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C8818C2C
	for <fstests@vger.kernel.org>; Mon, 16 Feb 2026 13:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771247598; cv=none; b=Y5MQGdessSVZSmRjPvLJjorptJXjKKm6L08IqltZBv31Dtk6BINxq35dUtyXSu+I7l8vA/DPdVW6JaQ6TkawTRQh5RF5egdWlk948jmIZs6F1hFwNiXVy3UIrAvD7EzB1EJN7V3gTvDOXFdub/24RFjfpyDKy0YhiV0uBMyI1lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771247598; c=relaxed/simple;
	bh=aZkJ2LC+4l1Mgl8JJsgnBU2eDftSKQyjyB4W5fPxgj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EeKCNtx0vabji9n/F7huLDEfEnlgZZVBnReMvAuIJMCeqUuiDS8DwgQqqRLnzbuAFdw6GaXrLYI2thURHXsfQcE9xNNEq/hWHSW4Gfw5bjRPQ8HVN2LxlBmeoH0t/zlbktkfJ1j/lLTkDu3+i0fJ/HBxsaGGY3j+S+iWy15mjT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZKMgSUzH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BWf8iQ0A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZKMgSUzH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BWf8iQ0A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771247595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eLHZr6BMZ2SnRfi1VuJNibTfFH2915IfXyQtxJbNFRI=;
	b=ZKMgSUzH9V/0y5VPTBS7h9u/T2TR/tn2qE+VpxtZN+BufpgtrqghKlnPYMxqpq3w6QRb2Y
	jPB6uoWhMNIxLuIpGXShugbwwB27lW/osIs3pzVzPypHQJ/5VEKLYBAZsdMPUuSJedBPF7
	s2vlFQxm0rjS/w2dpFTZF7GsOhSoKWQ=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-8k7k94h5PwqNQurmFzPqxA-1; Mon, 16 Feb 2026 08:13:14 -0500
X-MC-Unique: 8k7k94h5PwqNQurmFzPqxA-1
X-Mimecast-MFC-AGG-ID: 8k7k94h5PwqNQurmFzPqxA_1771247593
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-356236ae3c1so2940283a91.1
        for <fstests@vger.kernel.org>; Mon, 16 Feb 2026 05:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771247593; x=1771852393; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eLHZr6BMZ2SnRfi1VuJNibTfFH2915IfXyQtxJbNFRI=;
        b=BWf8iQ0AUM/hISVUYYhq5MRqvtxkrijT9r9y8YrO9YzKrUatKNZZpYOeDi/h4lyXW4
         zzdUCt3zBkk+dhMvlhZmgEhRPZoiztNAgYKEBB93e4csNgVtgJbA2I93Q23OfvLUwdh1
         fImttlJTVJw9nhOrutMnRTJxdsm64ovuTn6XxWazNAol7JnQZuWC+HwzTiVY8uckPg+O
         AWwlsykSXKpMPtKjCBRWZrexgUk1J7auVe934z3a80AFdf88vTEB3mel/Z+fo57uXsfl
         4U6gaMJRG4AxMVJCwJs7v2qNP5Gbzoc0iKtJFitZE/1IyeFnb90nREEXaOlxrIsODyuz
         NwAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771247593; x=1771852393;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eLHZr6BMZ2SnRfi1VuJNibTfFH2915IfXyQtxJbNFRI=;
        b=w0VJoROydUqLuZkhHSzgBSQ4pTefJUw5f4nW3vmmOrA0F/btvgZvSEtZ8rIjIyko7o
         ymD4hX4xYhCYINRiDbsOX2arTq2wpAWcENzWCnfrMI88fLMmVGSbhGJNC1Jr4eyNbFNH
         gjeoOWd8c6xmicvOuRIWC4JDNYOgyIbwYLeFW0VhEvZvccbEH7x/BOORAI5s+K+UpOB2
         GP5KX3967e/G09u6Q5ATJHOTUlYqIPMAWslDpjClp33uvgwowfh4RVi/Yi4QQsZyGsKm
         eCXDIH/ST2sTvqxSHr2+2a1icBUwp4RPZnXahPAjvwPpGG0ikDwFjVT7MpCY8Kd406m5
         0xVg==
X-Forwarded-Encrypted: i=1; AJvYcCXqMDKjEIEoN3DSmljTtCNPx5BE73CIUE1LKMPyJDjxrRg/1p25lVdjSIltZ/pPBDqp6Ix25lI6@vger.kernel.org
X-Gm-Message-State: AOJu0YwfE9fHdR25EZO/2ql6LMq8Qh45BlWxNu4KJRtL7Y9XRW2ZUB4n
	RiP5nvuyPFiG6pNXh2Sx3mWZouWJVyjT2bX6Oog0dhu2WgXhkjLFYcTUNDCpmtzYrpSux+ChrbT
	FAmfVSYryDPtwaX3//JREcpr7bJW3fFl74DLKCpjZQlvuVakuR3SzEE1G4Pw=
X-Gm-Gg: AZuq6aIvTnOdDWd3zuI1EocV8o0SUPlhS5R58Rad7V3tcN4JWHbw1bMzuO5bP5Ghgtw
	f/4w6dF6eOjJj4aZVX6dvDGaR2MhD0KzRE7orvZV7aQ54XZ18eXim6kqjYLmOUEGpEOshIxCQYz
	DGXz4Qi3Q1w10jQvmCcKugCeWwqrjXQh5zJiSYgBzmgA9AYXcpG/rK5A8kv/Hku5xNP9O2fQols
	of3QTRh8DBeS41Kqeu6fqfmtGnwCdyhQajR3an2g3Qi+ZWFSvpG9MjFRtkVp00f3oYUuwdaJDGH
	lTeNQgbuTqHXT7mYeOM/gGW5Usn8BpT3AFKvyk6Bv+zLHaP1KDjlUWrYIIySlg99WztRXcG4PUR
	B3XnvZDVVPdnxhH2XE/apM+zOpwrOIU7NyHzupf3hothhUaIy0IayZiuxEYQBAQ==
X-Received: by 2002:a17:90a:dfc8:b0:352:d0cf:9d18 with SMTP id 98e67ed59e1d1-357b50c0548mr6718924a91.5.1771247593525;
        Mon, 16 Feb 2026 05:13:13 -0800 (PST)
X-Received: by 2002:a17:90a:dfc8:b0:352:d0cf:9d18 with SMTP id 98e67ed59e1d1-357b50c0548mr6718904a91.5.1771247593047;
        Mon, 16 Feb 2026 05:13:13 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3567eba92e2sm16065290a91.12.2026.02.16.05.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 05:13:12 -0800 (PST)
Date: Mon, 16 Feb 2026 21:13:08 +0800
From: Zorro Lang <zlang@redhat.com>
To: Jan Kara <jack@suse.cz>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 0/4] Avoid failing shutdown tests without a journal
Message-ID: <20260216131308.atxnkqehyke4conu@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20260210111707.17132-1-jack@suse.cz>
 <20260212084050.uim52ck6zhffd5kl@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <zh372qbq2tq722476eaqrirmi55hxwzfs6msmzxfj6zv3jws5y@rdip5a6twsf6>
 <20260212164402.tbjcalfmeq6jfwum@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <bgtrbxzrwih2j2bgoanwf5sgl4go5xy6fxnvknkgnugqtkl5pt@iy6bcuqrx5ku>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bgtrbxzrwih2j2bgoanwf5sgl4go5xy6fxnvknkgnugqtkl5pt@iy6bcuqrx5ku>

On Mon, Feb 16, 2026 at 09:56:07AM +0100, Jan Kara wrote:
> On Fri 13-02-26 00:44:02, Zorro Lang wrote:
> > On Thu, Feb 12, 2026 at 11:41:59AM +0100, Jan Kara wrote:
> > > > I initially considered calling _require_metadata_journaling directly inside
> > > > _require_scratch_shutdown. However, I decided against it because some cases might
> > > > only need the shutdown ioctl and don't strictly require a journal.
> > > 
> > > Absolutely. I think they should stay separate.
> > > 
> > > So to summarize I think we should still add _require_metadata_journaling to:
> > > 
> > > overlay/087
> > > g/536
> > > g/622
> > > g/722
> > 
> > Agree :)
> 
> Should I send patches or will you do this modification?

As you brought this issue up, so I'd like to leave the finish line to you :)
I saw your 4 patches nearly use same subject and commit log too. If you fix more 4 cases,
we'll have 8 seperated patches :-D So how about squashing all changes into one single
patch? Does that make sense to you?

Thanks,
Zorro

> 
> > > and we might add fsync of parent directory before shutdown to g/737 and
> > > overlay/078. Does this sound good?
> > 
> > I'm concerned that adding broader sync or fsync operations might interfere with the
> > test's original intent. We should probably evaluate the impact further. Alternatively,
> > we could simply use _require_metadata_journaling to ensure we at least keep the
> > coverage for the original bug :)
> 
> I agree with the approach to just leave the test as is for now and invest time
> into deciding what's the proper solution once someone complains :)
> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
> 

