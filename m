Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEE022D7B5
	for <fstests@vger.kernel.org>; Mon,  9 Feb 2026 03:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770609268; cv=none; b=PWs7roirJy4fpQ0HJHm5EgSoMagqDdljZQ/hrDSGDV19VNt9iKENcLKggYOW0Lf7UCQqbzmp6Kq+RViDRm6dccWQK0CUzAebpwW1lqznwpAySg5USOFC+Te7hfH0EQAvwCQQXyQ6TaVH8q7mB2VqkaW9dtmj+mJbFUtAiO89wlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770609268; c=relaxed/simple;
	bh=qkYoD1gtJ07+ToQxwvg6qV9/Og+TgK93WkdsNT2K3+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FXcUzH29hFTWMy4cPxD8Xl5EcZfibkcDZMADobcFb1TAda6sd6QqROGqlGghZ3DWVD2RDbbA8QN1xZUl29iJBlTz++ngQ4ZWpssD4nrwdLGPpQJI2X3tcjfjlepuhpmGG/7GzWmwDzkh3UddO53UTG8+Fr0But9oPntRLBE+Dc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hf8BrvW+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ga42SZNq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hf8BrvW+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ga42SZNq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770609266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wYc5v3O1OT3iCO7ati2HJEqpec3eejd6ReypbOFPUMQ=;
	b=Hf8BrvW+OfNKq11gdncuoX/hVQbTPXukZQrah2tyrqpL3jrjQhqtXARDPvwGUF2dhCYEoy
	8E9x5JtAVB6obYnOag3GQSgDcY5O7td0j9bRWYKisCKFRe2VOnAjQXLVHYzsVCUwGpIWGx
	dNmacAbEgnKGex95rk7KXAA4+ov0Hvo=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-McHfL6JNNaGGOhoaeWPfXg-1; Sun, 08 Feb 2026 22:54:25 -0500
X-MC-Unique: McHfL6JNNaGGOhoaeWPfXg-1
X-Mimecast-MFC-AGG-ID: McHfL6JNNaGGOhoaeWPfXg_1770609265
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c61dee98720so1581055a12.0
        for <fstests@vger.kernel.org>; Sun, 08 Feb 2026 19:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770609264; x=1771214064; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wYc5v3O1OT3iCO7ati2HJEqpec3eejd6ReypbOFPUMQ=;
        b=ga42SZNqwxkYiibM/UxZNH0/3L09EpIxKoVIUCOJF8nfofQ7HPCyEdMQgWp1WHluxG
         n9K1yN+VtHmeAfo8AR7FbWC6mYVB1qcIK4h+cKzRecqGNtMoZVyxegybbPkhkD4WYVg3
         tYtnQABImFcLwYs05DS5XG6OtXFuwxPYFEkThf5WBCBvZH9YyKdQ0O3h+i9iVI0gWvE4
         EK88vAbQb0kWoxAJGaLkO2EolPtDM7BiGDnahfMogjwnEu2WAXNcR2oEeJsBakjbrEI9
         SvhIz0ZYUzsSVtsQcrEIv56GQoyDPgf32+hZSafVvz9M6PSPyfQBkNtrVtj2VNiimUpT
         DBjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770609264; x=1771214064;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wYc5v3O1OT3iCO7ati2HJEqpec3eejd6ReypbOFPUMQ=;
        b=vU/e++Vo+bVsDI6xbtanUTT+alEaFjDhRQeexQF2R6xRW57hpnwS5z5TtMtXPzosVw
         EYDdqD1ZCYOhCOcg0JufWWYK8MeQnVKUrHpIH7DMvdRmaCKr/YCO8th7WaRBiPOrh+v0
         1UadYiWYuU06NQIulZDuIdQjMbnw1OLQn5XJ4vuDxNkJuF3mOzrpzV/0ULQhcbjED7hO
         RfcE8ItWMXfUigYp12jaj7++7dY8PMcxa05ZypEaifBmQkvciUBE+c+UiDxor11/iRnp
         APJ0iuWgfrH/VXRx3N7gECTuhyqO9AW8Ob3HxrqPqlQaORgtPfevJeUa9uTQOt0DALuk
         cA5Q==
X-Gm-Message-State: AOJu0YylluwjG3AW5dawIQHnWYmC8vDToc1eFnbVnadOY2wO52cWASqi
	aIgyp+4aAeZnU+bCo7+/1lY53N4L5wNg1mZo64dTcmgTpzVRMrdUroUe/4R8uaiwco9L4fMOiar
	caWo+nKNEseBC+18ixw6erA55AJG2NRh5t+bdhu6BfEVU2nw2gs2/+XtFWj4=
X-Gm-Gg: AZuq6aI2qfg2Uknetb8ZcAN0T3rpgxGtJL6UpkoJ9+cR4uob2h2qBsZg2/a5N5+8/Y6
	lDFR9hkIoYfyiYaVPqvNPuNajzQP8TaomedhEFDImq1L3RP5UN93+7FH9275BenCKHu2X0Naa88
	BzLhFRq1qS6q9MGFnrWQtSGjUc/JlRJdswRKkRpa3wJLFaqLlbnWLf++8ET/Kn22MSqu2o5Usfs
	/3kWTSJ+dHDiY2zAFcDQ6GetrqqPyKaJctRsJJcXI4bGlSniwTUFMr9h96daTOKZ2PkbBdY3z/J
	XfVGjL7ZKB94Fg09sRQ7JBl2IGXD58TE1waVS0X+QSmKLPUahZrC9JczHTmg2p9ZQLAJHE094r/
	XdbBbYXW8Qvf1bivIAdbLHN5WpRan12ReqSoUSCeiUz1zGyg+xg==
X-Received: by 2002:a05:6a21:a89:b0:392:e5eb:f0f with SMTP id adf61e73a8af0-393ad3b6c44mr8349850637.68.1770609264491;
        Sun, 08 Feb 2026 19:54:24 -0800 (PST)
X-Received: by 2002:a05:6a21:a89:b0:392:e5eb:f0f with SMTP id adf61e73a8af0-393ad3b6c44mr8349831637.68.1770609263897;
        Sun, 08 Feb 2026 19:54:23 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6dcb526676sm7675744a12.12.2026.02.08.19.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 19:54:23 -0800 (PST)
Date: Mon, 9 Feb 2026 11:54:19 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>,
	Joanne Chang <joannechien@google.com>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v3] common/rc: add _require_blocks_in_file helper
Message-ID: <20260209035419.ivosuxils2gnn3lw@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20260108022501.754320-1-joannechien@google.com>
 <20260110013802.GB15541@frogsfrogsfrogs>
 <CACQK4XDtrE5P-PjwSqvGtmEmMvEQS4r2KZkDh55LXY2YAoH6vw@mail.gmail.com>
 <20260208195043.vhvkanq5pysbb74y@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20260209015326.GK1535390@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260209015326.GK1535390@frogsfrogsfrogs>

On Sun, Feb 08, 2026 at 05:53:26PM -0800, Darrick J. Wong wrote:
> On Mon, Feb 09, 2026 at 03:50:43AM +0800, Zorro Lang wrote:
> > On Mon, Jan 12, 2026 at 11:20:36AM +0800, Joanne Chang wrote:
> > > On Sat, Jan 10, 2026 at 9:38 AM Darrick J. Wong <djwong@kernel.org> wrote:
> > > > On Thu, Jan 08, 2026 at 02:25:01AM +0000, Joanne Chang wrote:
> > > > > generic/735 attempts to create a file with nearly 2^32 blocks. However,
> > > > > some filesystems have a maximum file block limit below this threshold.
> > > > > For instance, F2FS is limited to approximately 2^30 blocks due to the
> > > > > capacity of the inode. So add _require_blocks_in_file helper to skip the
> > > > > test in such cases.
> > > > >
> > > > > The helper uses a hardcoded constant instead of a programmatic method,
> > > > > so that bugs which affect the maximum file size are not masked.
> > > >
> > > > Not to mention trying to create a file with 1,057,053,439 blocks
> > > > allocated to it would probably take forever.
> > > >
> > > > Hang on, we're talking about iblocks (aka the number of blocks allocated
> > > > to this inode), not the maximum file size in blocks, right?
> > > >
> > > > If so, then maybe this function and its comments should
> > > > s/blocks/iblocks/?  Or am I confused? ;)
> > > >
> > > > --D
> > > 
> > > If I understand correctly, generic/735 creates a large logical file, but
> > > the actual physical block allocation is much smaller. Also, the F2FS
> > > limitation is about how many blocks the inode can address, no matter if
> > > the blocks are actually allocated.
> > > 
> > > So I believe the requirement is about the maximum file size in blocks,
> > > not the number of blocks actually allocated. Does it make sense to keep
> > > the name, or do you think another term would be clearer? I appreciate
> > > your thoughts on this.
> > 
> > Hi Darrick,
> > 
> > I think Joanne's explanation makes sense, if you don't have more review points
> > on it, I'll merge this patch.
> 
> Agpgth, I didn't notice this reply!  My apologies! :(
> 
> Ok, since this is a limit on the maximum logical file block number,
> _require_max_file_range_blocks, perhaps?

Thanks Darrick! I'm good with this, if Joanne agrees with this too, I can help to
make this change locally to avoid asking for a new patch.

Thanks,
Zorro

> 
> --D
> 
> > 
> > Thanks,
> > Zorro
> > 
> > > 
> > > Best regards,
> > > Joanne
> > > 
> > 
> 

