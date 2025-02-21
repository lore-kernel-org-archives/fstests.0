Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF1B18BBA8
	for <fstests@vger.kernel.org>; Fri, 21 Feb 2025 15:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740150206; cv=none; b=BZ1yWVQ+e6naEhZqDfy0uURW/u+FV6bbL6aDJagQeSQUTkl2YmJ0YsbqrfmLPC/c9QRtTglvgi39y6LktbFx9RQbpH0H3VfobRnqVX/YSigTXqcxXYNPVyOuCId4KoDtl4vcfDX/7OuzdsAb+SrnSKT5LBz78YZZAwb5XnkJGdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740150206; c=relaxed/simple;
	bh=Mk+XQ8bti248KSlpnWb74h/SeuRdUh10vyv/7ine9RE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=erO+Hsuc6Uc6P4UaaN7DErG6oX4QL+j1ZJO1y2vZflm40qpYZL9aeeaVphdIv0naKnRdBp9PG/xD1/JwvkqMo362MZaPYZVhzklGuHzFYPywf2JvPfSbhnu0TvDmWLPdhAJeCaxYdCQSg+JRGYfzwpnRFrDwOuwHExLkcf5im7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NI4g3S+8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NI4g3S+8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740150203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9GCgOcalMjVvKv2fxVHDU+ht8NCCeGzsSfPCeNdFkpM=;
	b=NI4g3S+8QJeG2Rzehyj6tHZ7x5rRgvmwXh4limwc/xkizMuNymJP3PXVjx6Vl02/plj+sC
	1UrDlKx0Kn2FZBF+C18ZM9LzY+xXWCeA0KeLZIQJELQbr42ET75JHqMmYGLrmYJohUGUgB
	j9ob/MppXeMMLPKnxNiMbEcWHzu/cmI=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-GQcJtBAjNt-EVceWZRImbA-1; Fri, 21 Feb 2025 10:03:20 -0500
X-MC-Unique: GQcJtBAjNt-EVceWZRImbA-1
X-Mimecast-MFC-AGG-ID: GQcJtBAjNt-EVceWZRImbA_1740150199
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2fc43be27f8so7420714a91.1
        for <fstests@vger.kernel.org>; Fri, 21 Feb 2025 07:03:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740150199; x=1740754999;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9GCgOcalMjVvKv2fxVHDU+ht8NCCeGzsSfPCeNdFkpM=;
        b=HnhCrQy43udim7ls4WSAn8JilJVh0q27SQnoK9pH6U00d2mlQ8qHNuGEc+bTMTyBQ5
         xSv3anf+ujNNJUofxE2JiPMF36QMNcL9sQj1Vq9rRgCWDZEWg/NofsFmMnsRM0Y78SOA
         jQMZaidUmNP1Wf2WbeaVZZ4U7DjonsyGvFIKz0JwsJLLfq2tIJ6XaglRqhsx/4l/HKrh
         it4/eX2zo74uJStoiKYv/Jbme7RfK6fxtyWB44NwROF3km7gV6ZX4hkwbwZmJKm9QOKq
         ais+kveKY9N035S73R82dpZ36nadLhhvcC4ABooZMNnvOJUZYNxtkQodq1IN13tjX5yN
         +CtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlAUuUDjdYJij5TbBMcRPgoCfQQz+qtMOBEAropKQitZYbH/T/adMwTAoYlleIqgmocx9mnNxi@vger.kernel.org
X-Gm-Message-State: AOJu0YzqRfX5hNXSOVY0Tk7Vjq+hBMZEnS06ugFVDSG05QXJFRkyPRp+
	LemvA4tsmNGZxTvWanw4rrL0yUv1ZATikpWsRi9cttzxpWsIqDHxTCDAtfAy6kcUr/PzKBJ3/Va
	YFUJeHnGMrLoVu1SdtUGFitCIqzCOJFbrQTnu/w3wu0TV8FKyBzD8AZw=
X-Gm-Gg: ASbGncsxMORznsV9C7W94B1Ef6MZ9w9+unq+OJS2Ayb3AqSkyFjozqcfqIhT5s7nk+I
	/9/6EEEWK87DiCmavB7cHhh780DIHP7ZL+NAjc6XwO40dN7ijCzieUa9uDv1ZoUZWBUZ8A8+wya
	d+eldBxEshRI5OC2XZ+6C7CZaL0DDl36MNvazDtu2C7qkYx0DhLbIPuwm2PiDwb5v0jdKlGM8p+
	iQtO/VR3ybBWLncSW33S5fhtDzHKsOikOmwmgJ5w9uZgSQGn2xbPWyodkXUBZ38mWUyqRss5H9o
	x9Aj1IRAUr7xf18w9HnklF/GAO1n4Q0BUCKIeA04c+BgiQRSctoEBqfm
X-Received: by 2002:a17:90b:37c7:b0:2ee:edae:75e with SMTP id 98e67ed59e1d1-2fce78a97f2mr6041962a91.13.1740150198979;
        Fri, 21 Feb 2025 07:03:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEsmpngk+FBsNVaalMiX2WwczN1LLAkFLI1XlFWh21qwo5zeGruJ6XQbycyJoiOYTa9L/YEJw==
X-Received: by 2002:a17:90b:37c7:b0:2ee:edae:75e with SMTP id 98e67ed59e1d1-2fce78a97f2mr6041921a91.13.1740150198641;
        Fri, 21 Feb 2025 07:03:18 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceb10fb43sm1453975a91.35.2025.02.21.07.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 07:03:17 -0800 (PST)
Date: Fri, 21 Feb 2025 23:03:11 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: zlang@kernel.org, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@kernel.org>
Subject: Re: [PATCH] fstests: btrfs/226: fill in missing comments changes
Message-ID: <20250221150311.eabczmxfxnvndkqk@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <e73cfe5310a8cee5f6c709d54b8c18ff52e39a0a.1739918100.git.anand.jain@oracle.com>
 <CAL3q7H4GgaQKTLzXzza4xKsoa22pG6MbOFYOuNhK-5J-ieZdRg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H4GgaQKTLzXzza4xKsoa22pG6MbOFYOuNhK-5J-ieZdRg@mail.gmail.com>

On Fri, Feb 21, 2025 at 12:04:32PM +0000, Filipe Manana wrote:
> On Tue, Feb 18, 2025 at 10:36 PM Anand Jain <anand.jain@oracle.com> wrote:
> >
> > From: Qu Wenruo <wqu@suse.com>
> >
> > Update comments that were previously missed.
> >
> > Signed-off-by: Anand Jain <anand.jain@oracle.com>
> > ---
> >  tests/btrfs/226 | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/tests/btrfs/226 b/tests/btrfs/226
> > index 359813c4f394..ce53b7d48c49 100755
> > --- a/tests/btrfs/226
> > +++ b/tests/btrfs/226
> > @@ -22,10 +22,8 @@ _require_xfs_io_command fpunch
> >
> >  _scratch_mkfs >>$seqres.full 2>&1
> >
> > -# This test involves RWF_NOWAIT direct IOs, but for inodes with data checksum,
> > -# btrfs will fall back to buffered IO unconditionally to prevent data checksum
> > -# mimsatch, and that will break RWF_NOWAIT with -EAGAIN.
> > -# So here we have to go with nodatasum mount option.
> > +# RWF_NOWAIT works only with direct I/O and requires an inode with nodatasum
> > +# to avoid checksum mismatches. Otherwise, it falls back to buffered I/O.
> 
> Btw, this is different from what I suggested before here:
> 
> https://lore.kernel.org/fstests/68aa436b-4ddd-4ee7-ad5a-8eca55aae176@oracle.com/T/#mb2369802d2e33c9778c62fcb3c0ee47de28b773b
> 
> Which is:
> 
> # RWF_NOWAIT only works with direct IO, which requires an inode with
> nodatasum (otherwise it falls back to buffered IO).
> 
> What is being added in this patch:
> 
> +# RWF_NOWAIT works only with direct I/O and requires an inode with nodatasum
> +# to avoid checksum mismatches. Otherwise, it falls back to buffered I/O.
> 
> Is confusing because:
> 
> 1) It gives the suggestion RWF_NOWAIT requires nodatasum.
> 
> 2) The part that says "to avoid checksum mismatches", that's not
> related to RWF_NOWAIT at all.
>     That's the reason why direct IO writes against inodes without
> nodatasum fallback to buffered IO.
>     We don't have to explain that - this is not a test to exercise the
> fallback after all, all we have to say
>     is that RWF_NOWAIT needs direct IO and direct IO can only be done
> against inodes with nodatasum.
> 
> So you didn't pick my suggestion after all, you just added your own
> rephrasing which IMO is confusing.

Hi Anand, please talk with Filipe (or more btrfs folks) and make a final
decision about how to write this comment. I'll drop this patch from
patches-in-queue branch temporarily, until you reach a consensus :)

Thanks,
Zorro

> 
> 
> 
> >  _scratch_mount -o nodatasum
> >
> >  # Test a write against COW file/extent - should fail with -EAGAIN. Disable the
> > --
> > 2.47.0
> >
> >
> 

