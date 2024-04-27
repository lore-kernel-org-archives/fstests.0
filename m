Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA9663BF
	for <fstests@vger.kernel.org>; Sat, 27 Apr 2024 08:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714207323; cv=none; b=DlXKbuhHAxc+l9ZCbrdvr3dY1CWxpNqJW4/4BHa+0hOFZWrLDXJ6TSQe4AjDWrUXyiNSi/+lnxkf/xiMqBfVGnXBf0eSyaHo4FNUdGw+xd5jYbNXUGKHYVtEcovh1HvOP3OroVYzmY6RqUbDYCoLIx7uHUhuVvca0e383cVnjHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714207323; c=relaxed/simple;
	bh=WPTj3/it2R3hb02X5zxvJdaRG2Uc+iPVGmUc88GPtTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uU8JA6wf013acvsSUM5kWscL9YyN46bKzvP0Kvjh4ttzOX9wr2mjQPTXv0jDyNZRHgN1UTXrGw7jhmEPHZhhEw/SLFubmIb7w8ExSWcQbzDtz/okOGBvHsNfw41U6fG97wDEZswWviZ6FXWrk92Qz5vMCl0gEWOJutk06S7uVEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i3fR0jFn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i3fR0jFn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714207320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sB9oBTgT7zU4StsoU0EVqRO62eooka0kO7SEhcjgnsg=;
	b=i3fR0jFnlPNOJJ9IgbXMNJzHF+H3DH+UnPfMdPpbTE85Wofgaw4RkeZwjXtGgrqHxhFucX
	jLlsnnn68Ef85wCtovd7Y09r4ooTl2E3vuNuSdP8ZXp8SNw7nwRtiPwWFny9i0I6nLnjYy
	u+6SOJzvzb3XrrPkXL2fKoljwsXKr04=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-Rsz2HHemP0eL0cKB4rtZPw-1; Sat, 27 Apr 2024 04:41:59 -0400
X-MC-Unique: Rsz2HHemP0eL0cKB4rtZPw-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3c861f6e19aso170845b6e.0
        for <fstests@vger.kernel.org>; Sat, 27 Apr 2024 01:41:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714207318; x=1714812118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sB9oBTgT7zU4StsoU0EVqRO62eooka0kO7SEhcjgnsg=;
        b=VO8BFZXOqkZPZ3YYpjcXIUONDMCfTObsFWNUqMnE7KyHH3FoEsV4sasYzRs8vLj2QE
         J80h+bZ1hgFQqKp/8Njndj+bNtZg2SP9bUpa6smjGkEtk60AQ9G2SZWInOzXHAAOfJHb
         6YlwKDrLnmEXKJ5Okowk29WZE9mNNFbg9NDdUcRBWFl8ASj80kr2zm6KhtgCMCCMgRfC
         mYjdMTJcgUwz/a4BqhrDVNk51rU00Ofz024Ol2R8AZPSBLt1UTXsQ7Yu/xBqA99DvJbD
         RorJJL9XRvYVGqVzs/N93f8I+IAO3EHWpTCC7zFLYBEyFFtZYv7nR9ZBYrciqsw80DSu
         GqiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKeKKQILedzX+77a2R9XJvsTm521cvF+IwNOCgzgTyjYCnf2C9MGG/vZCGpBB3FBEUpaFAJodH+Uh3n0LRvYv2LsoLTZ0row==
X-Gm-Message-State: AOJu0YxZVGDbxUBnVHpTKOVWV6A55+v1TI+FU27XIJ6cL98Wm1fInNi4
	ONpXXjmAoaoEDEotk2Kp7ZMELZ1Upb7FVHwbtB3RKzezpaHbqGgkNZ/+2BS/veWI1JSPSimeWQN
	apBLvjDt331FQefy3/hT8ZiUxn6AeDdxzhaWe0WHSKNH71ugiEseigrk=
X-Received: by 2002:aca:1201:0:b0:3c5:fa5c:7762 with SMTP id 1-20020aca1201000000b003c5fa5c7762mr4692088ois.44.1714207318234;
        Sat, 27 Apr 2024 01:41:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEr6xMuDIk42RJgRyoxcJob6T22q2/I10x6SHnA+tIoFDgYrs/hs2AL2+mXI8Pkdf41u2a6lg==
X-Received: by 2002:aca:1201:0:b0:3c5:fa5c:7762 with SMTP id 1-20020aca1201000000b003c5fa5c7762mr4692070ois.44.1714207317478;
        Sat, 27 Apr 2024 01:41:57 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id i28-20020a63585c000000b005d5445349edsm15481690pgm.19.2024.04.27.01.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 01:41:44 -0700 (PDT)
Date: Sat, 27 Apr 2024 16:41:40 +0800
From: Zorro Lang <zlang@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Yong Sun <yosun@suse.com>, fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: solve no-return-in-nonvoid-function issue
Message-ID: <20240427084140.6eaalb3tsoe3o35a@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240424112444.20964-1-yosun@suse.com>
 <ZiySu-TX-5kR3VOx@infradead.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiySu-TX-5kR3VOx@infradead.org>

On Fri, Apr 26, 2024 at 10:52:59PM -0700, Christoph Hellwig wrote:
> On Wed, Apr 24, 2024 at 07:24:08PM +0800, Yong Sun wrote:
> > --- a/src/fake-dump-rootino.c
> > +++ b/src/fake-dump-rootino.c
> > @@ -221,4 +221,5 @@ int main(int argc, char *argv[]) {
> >  
> >  	munmap(header, GLOBAL_HDR_SZ);
> >  	close(fd);
> > +        return 0;
> 
> This needs to use a tab instead of spaces.  Otherwise looks good:

Yes, I'll help to change that, thanks!

Reviewed-by: Zorro Lang <zlang@redhat.com>

> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 

