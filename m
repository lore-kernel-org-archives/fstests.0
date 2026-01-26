Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B595131A049
	for <fstests@vger.kernel.org>; Mon, 26 Jan 2026 11:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769427531; cv=none; b=J1/bH57lTtfAcve5brbjrFwxMfDIjy6+eYCAxJirbKrOb+X6qcXefvhcpYv9P1dfkwmZIwla6kRrY5sFn4FIGkVaURYJbQzLcp3vpP9E2t7EAVEvl1Tx9km0wPRwqsX6yQirAbOxDqf6dkCZyo5NmZFViLZu0GQumT8/Wg8xFtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769427531; c=relaxed/simple;
	bh=1uHeImTsp6sBfS6z2fR4NTz5MZQI5nrGvZIHDs2hZB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6j5WQx8cQXTw9tIWNSFEDMDRB6qkwz1gP4P2U/aTRNeZAuyyPn8J+Nec36B4V71InX0ndkMRr/W6V0VMPLppm3CNuxItTFgVm5N8lw3H6jsVLgchRX0b7mP2fKb2ss7FIctt+umHSCZUkA+AxESo5uct0RDzYQwtSwRMOuyMuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HEyyliHQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PSel6C4c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HEyyliHQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PSel6C4c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769427528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4JuzNiza5HwpYpdBev/Gv0nk5c9jouzzFaS/rXxrFzM=;
	b=HEyyliHQGDmm063TPkLARaiwxoqOGFHnUHKFVtTWOiuZ5kcrpUlYEv0oQW9ucln9VOQ9bk
	wznSPhr8F7OvwCveBx8smimRgGt11gqinj8seLegbivV/fU2zVommzQLZrtoCcal6ksEGu
	r63nW7PNrx+ZWbWTkCT0brhf4ldRheY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-E8BxZWZjMaerzDpVdInnVA-1; Mon, 26 Jan 2026 06:38:42 -0500
X-MC-Unique: E8BxZWZjMaerzDpVdInnVA-1
X-Mimecast-MFC-AGG-ID: E8BxZWZjMaerzDpVdInnVA_1769427521
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b871d7ad66cso185510866b.1
        for <fstests@vger.kernel.org>; Mon, 26 Jan 2026 03:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769427521; x=1770032321; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4JuzNiza5HwpYpdBev/Gv0nk5c9jouzzFaS/rXxrFzM=;
        b=PSel6C4cUTO5kpDOzzw2+RKh1rj7UFgs3QMMxlzg6pLGk4pYj15v2Mn5VUR9Esg8tN
         oyrfLyY/KSNNa+qdqwa6kMSFyeOLjk1DKcVuPS13TGVADfRUw7fvahk4pobPz98UbVcy
         no0eJZ30IstOCNKjyjJmiCP55uhbWiRSoEvZSo44uEx1Z9rLxCNdqvxPSBS0jSjz8kH8
         Pq6M+iAUWlZMxUWAKRGPEPfCk5HQZH48tZss8K7nQveyVNKoya+AyIaQhuAETiH/FltO
         gLl+XXE+bautwoPHYPX8EP62mrbDyZOwsxIfVGiQBhYs1fhhnfHH/rAU/PQMjepXnBZk
         vUGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769427521; x=1770032321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4JuzNiza5HwpYpdBev/Gv0nk5c9jouzzFaS/rXxrFzM=;
        b=sh37VJKpPqgQ3fdBlKfXj+ZhSTFSm251sAVtwg3sI3KIHEmSvAQ2xYprD8OphNn+9W
         Q9DxtoOvHKFjuZn0F+KMigXcV7bTlv7d+J6rDrfMzcdKOL0YuWuBH7ZpEplYT21zYTkC
         /RdvwWrzQGFcIyzLQ/f/HKuS2oTfSgk0lU9Y0f0Ak+ClvLMf3JbzBKyqCFMczgpyS8uR
         aXXY8xi1Q6AW72E8C1BiPfrW4HZY1K5A2D3DohGoevE0yRB5g7xjhkFAlSBWQWezF3hF
         yjvN4DgNMGV0vfYlTZelMCoxkMFrykAGuUxCC+1Xp3/UEtj2KxiKNjWUd7xUt5h63xH4
         beew==
X-Forwarded-Encrypted: i=1; AJvYcCVB9SGuiw9q5/8HZp3RJj70lF5XW31ulm+LJOmwRQ4358h/EHWFZGgeu94RBo+zLETNtRfZsAKl@vger.kernel.org
X-Gm-Message-State: AOJu0YwB6uKsxWwAfZSiw69e1wa0H22mqqPDXPCLDelWe12D/tB0Ssmv
	7oL4RGxg2vtwHZ2GtkTKngWzMRImM3SA1tjrbdtAJ/LWErQ0XERUI4ckZh8Lkb8Rgvlx/aqbPP8
	RqBKK6eqpJ0klHIyC86p8N5AkB8z51KqUXyIZBXt7YGoncC9Q3bihAtd4mw==
X-Gm-Gg: AZuq6aLhnNzAq5s4thHK0j5uUcSgIDC4WkVKQND+QhvJ2MB93eKan+m7jmmo5OvEKJ0
	lZQjCV39H8mlGT2+kgejgPqgxllhvdBILOYb7FlNqmanKWFhoExeUu6kgx2BcN+pJzQEH7fjGia
	AYouEGjL2E90/oSCXMsZ6TnvKpQSXlldoGDVr9zsZiFW6HXlMa53QN1x98FfRXVMxsPh7XAY+Rb
	FXWTxv6VTglUWzsY6aBr14DJ5qMd27vEOkYlqvAxpizGyBuLUd1yszlB02q+xubK/Dudz7Aa775
	/Vgfu1PE8AZQEF+usCGmzGdjNf+1Zajn8PK6pQ3hXWQ9uvIebvWkdHux/SN/5IShHlWcnKTa9ts
	=
X-Received: by 2002:a17:906:6a0b:b0:b79:eba9:83b4 with SMTP id a640c23a62f3a-b8ceed585e1mr334869266b.6.1769427521190;
        Mon, 26 Jan 2026 03:38:41 -0800 (PST)
X-Received: by 2002:a17:906:6a0b:b0:b79:eba9:83b4 with SMTP id a640c23a62f3a-b8ceed585e1mr334867266b.6.1769427520658;
        Mon, 26 Jan 2026 03:38:40 -0800 (PST)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b885b3d9ae1sm622689466b.13.2026.01.26.03.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 03:38:40 -0800 (PST)
Date: Mon, 26 Jan 2026 12:38:09 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Andrey Albershteyn <aalbersh@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org, fstests@vger.kernel.org, 
	djwong@kernel.org, fsverity@lists.linux.dev
Subject: Re: [PATCH v2 2/2] fsverity: add tracepoints
Message-ID: <fr5qdcfxeok2rjtiqwz7jibxccq7ntrczvfcnvv2g3avauljdo@lmzqhlnq3vox>
References: <20260119165644.2945008-1-aalbersh@kernel.org>
 <20260119165644.2945008-3-aalbersh@kernel.org>
 <20260121003917.GC12110@quark>
 <20260124184954.GC2762@quark>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260124184954.GC2762@quark>

On 2026-01-24 10:49:54, Eric Biggers wrote:
> [+Cc fsverity@lists.linux.dev]

ops, wrong autocomplete, thanks!

> 
> On Tue, Jan 20, 2026 at 04:39:17PM -0800, Eric Biggers wrote:
> > On Mon, Jan 19, 2026 at 05:56:43PM +0100, Andrey Albershteyn wrote:
> > [...]
> > > +	TP_printk("ino %lu data size %llu tree size %llu block size %u levels %u",
> > [...]
> > > +	TP_printk("ino %lu levels %d block_size %d tree_size %lld root_hash %s digest %s",
> > 
> > Would be nice to make these consistent.  3 of the parameters are the
> > same, but the naming and order differs slightly.
> > 
> > [...]
> > > +	TP_printk("ino %lu pos %lld merkle_blocksize %u",
> > > +		(unsigned long) __entry->ino,
> > > +		__entry->data_pos,
> > > +		__entry->block_size)
> > 
> > Likewise here.  So now we have "block size", "block_size", and
> > "merkle_blocksize", all for the same thing.
> > 
> > > +	TP_printk("ino %lu data_pos %llu hblock_idx %lu level %u hidx %u",
> > > +		(unsigned long) __entry->ino,
> > 
> > And here's data_pos as a %llu, whereas in the previous tracepoint it's
> > just pos as an %lld.
> > 
> > > +TRACE_EVENT(fsverity_verify_merkle_block,
> > > +	TP_PROTO(const struct inode *inode, unsigned long index,
> > > +		 unsigned int level, unsigned int hidx),
> > 
> > And the 'index' here is what the previous one calls 'hblock_idx'.
> > 
> > I think consistent naming would be helpful for people trying to use
> > these tracepoints.
> 
> Andrey, let me know if you're planning to send a new version with the
> naming cleaned up, or if I should do it in a follow-up patch instead.

I will send v2 with renames

-- 
- Andrey

