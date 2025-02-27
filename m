Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC7C1EB194
	for <fstests@vger.kernel.org>; Thu, 27 Feb 2025 07:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740641746; cv=none; b=AU0GMLTCvxetAMlSPz6MTQdLsFCz3CCao8l4d5HKTq/zcbif+zi+lBpYOwRUN42Bi5eAyijQbOyifEpXs8uhSmw0DNY5NjGrw7vUuXsco/x8X0pLPzZXB5JzeTwTOsQjY6MK5uTpt/EeQSP+yXthjUPB30UETjhGlSPo1BFrs2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740641746; c=relaxed/simple;
	bh=tyg3tDigIj+ib1hlFt380fp0rNyAAN3ruQhrm08IBJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ngax+2pcYWT+PBB/+WTGUOrrKe2V3Rw1pmOQr3xsTwTSqg39560Q49ppBuk2wxMMFZnnqSLoJgsiUDz1CdQJ18TYkP21v0t5NqXPTXAx+n710HjgLsiWaXVY37maWp2HWVT+JuJItdHvNoxRsqZMv7XNIkyTp0OYR5IaNzVFr14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XwYhJCsq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XwYhJCsq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740641743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nk1QNf8HdvFKNgG8if30YvE5vgx5TBL5SLeb1j70Z5I=;
	b=XwYhJCsqkIZXx37PiRgh5Wq+yPFOUKiYHEfpWLZjkLa7SyQSevqpjqOQMdbV3ho6SuUz7w
	0blaE2lbhaSLl8kgBFX51S2YFSQSZm6UjE0SYxHP3Mv9VMpD9hdmRa0TEddQZI1pxVLMbj
	GkZrE4w1r9sBhrOaCqQnp/MCNcBMb5w=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-c2uJH6ehOs-qy_ny5mvIYQ-1; Thu, 27 Feb 2025 02:35:41 -0500
X-MC-Unique: c2uJH6ehOs-qy_ny5mvIYQ-1
X-Mimecast-MFC-AGG-ID: c2uJH6ehOs-qy_ny5mvIYQ_1740641741
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-22334230880so9295735ad.1
        for <fstests@vger.kernel.org>; Wed, 26 Feb 2025 23:35:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740641740; x=1741246540;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nk1QNf8HdvFKNgG8if30YvE5vgx5TBL5SLeb1j70Z5I=;
        b=p8cU16kVTJstWSfkTbMdOai98AfOA4/Qd7xAiRMxERd3qrV1KkgrWCRBx9mHc2gkFy
         MYG6tRhXOvwCD8OlK5P1aYUTxJ69g2O/9TrFz4V3KaC4sB8EBMbMC1p+Pm1nO5EcoRBU
         xHSirdh1te8c1CohuVWKX/AgHvuYI4mx2TdqQq1q54uPyt3pd4jJAO1glbLpamUd0fLI
         m29GAvIWCJ13zAE+LbuqtdHkja6H23vyzFkvTlQmfq10NXKBU+0w1lJBvc1NmdnhW52W
         3ApqasF2rVhtE/Aa1871bWrukNWK6hy+lo2v8UIh2rm5GyXiavdJ60vJyrUWCIF2A4k7
         tTaQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2oGmAx2DwcapS/G0fBlj9NHlhq51oxjhOHaPVTQ3f9vresATNERQhCcP6zbG3C8MGthF6DfI4@vger.kernel.org
X-Gm-Message-State: AOJu0Yyoad8R4H0dE5oIMVpVSrdFcjgYPYFa7v6M6mo1Z0mTSkBqVGZ+
	Kp6JqUf2OVvw/auGL8tnF3eGMIPJ/VW4RpEWCYNdMGQWZGTWbZhwOvyZP1H1qZjhNOXEJYSFxPo
	Qn7frkotOu9iouShHqOiVTeJgxdd/de7dqbzyitOVyG373zJ2MuVvp6N8wpc9pv3kOQ==
X-Gm-Gg: ASbGncvaWQQg6/SkdiK4rG5YFCd9T/27PFb8cfqodr4bTOCrJFOn0vOIrSujOKL+HuP
	BzBQHNdZI1N4g3HGN4KAyZ/EUMocD7NYi8RN+vIyxKjzQUHCfGm+/CFZAkzgibCW72z/jYzOp8j
	V+FDcdKVbHxT+TvBfIIqw50BH8EHJRV6hKp42jGwwQLCsnplCs+krEC3B6cxCAGTbIz/gGe6LpA
	2rPFbAOPFnw6vBLfktC0hdowMxTlcEdGBDtKOpwAH3M4ASIoabKCjWzD9R/0Hc5SgbF2bJwr5v/
	dEGW+VRbRls/APUTvuvaBNPeeoRhisVABwed/FfsMizgz30MFImMGX4m
X-Received: by 2002:a17:902:d2cd:b0:220:c911:3f60 with SMTP id d9443c01a7336-221a00260e0mr391664205ad.47.1740641740443;
        Wed, 26 Feb 2025 23:35:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfOhA5r+6T3PGrAoREzDXSsyRAFWKbA4P6CrKLpUut+65Xb70qwhWzZX6UnHqDzhnVIjAp2w==
X-Received: by 2002:a17:902:d2cd:b0:220:c911:3f60 with SMTP id d9443c01a7336-221a00260e0mr391663985ad.47.1740641740124;
        Wed, 26 Feb 2025 23:35:40 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501d28desm8138695ad.16.2025.02.26.23.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 23:35:39 -0800 (PST)
Date: Thu, 27 Feb 2025 15:35:35 +0800
From: Zorro Lang <zlang@redhat.com>
To: David Sterba <dsterba@suse.cz>
Cc: Zorro Lang <zlang@kernel.org>, David Sterba <dsterba@suse.com>,
	fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: remove reiserfs support
Message-ID: <20250227073535.7gt7mj5gunp67axr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250219221743.20161-1-dsterba@suse.com>
 <20250220202238.6axqgejzk47aay3j@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20250220203751.GH5777@suse.cz>
 <20250221051902.e7ft6iuvahfvvyza@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20250221105918.GJ5777@twin.jikos.cz>
 <20250221154531.ttch34qic7zsxyzv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20250226144107.GU5777@suse.cz>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226144107.GU5777@suse.cz>

On Wed, Feb 26, 2025 at 03:41:07PM +0100, David Sterba wrote:
> On Fri, Feb 21, 2025 at 11:45:31PM +0800, Zorro Lang wrote:
> > > This may bring the question what is the policy for filesystem support.
> > > I've seen "case $FSTYP" with widely inconsistent cases of filesystems,
> > > probably the longest list is in common/rc:_require_scratch_nocheck with
> > > 9p, virtiofs, afs, pvfs2 or ubifs.  It would be good to document that in
> > > README, I haven't found anything in that regard.
> > 
> > Good idea, maybe we should have a list about that.
> > 
> > There's not a limitation about what filesystems are supported or not.
> > Especially the generic test cases, some "not in list" filesystems might
> > run generic tests too. So we don't exclude any filesystem which wants
> > to try fstests.
> > 
> > Generally when someone wants to help fstests to support a new filesystem,
> > there're 3 phases:
> > 1) Check if fstests can mkfs, mount, unmount and fsck on this fs natively.
> >    If it can't, add the fs to the "case...esac" list, to do special treatment.
> > 2) Run generic test case on the new fs, fix some test failures which are
> >    not suitable for this fs.
> > 3) Add more test cases for this fs, might need a new tests/$FSTYP directory
> >    and more common helpers.
> > 
> > Actually some of filesystems which are "supported" by xfstests, just satisfy
> > the phase#1, or a few phase#2. That depends on how deeply that fs list
> > would like to use xfstests.
> > 
> > But everything is still changing. For example, we don't support nfs much,
> > just in phase#1. But as more and more nfs folks start to use xfstests,
> > it's good to run on nfs now, even reach to part of phase#3. In contrast,
> > although cifs is in the list, and xfstests can be run on it, but too
> > many test failures, no one from cifs would like to care about that.
> > 
> > So about the "support list", what's the standard to count in a fs :)
> 
> Thanks, this is useful, can you please add this text to the README?

OK, I'll send a patch to add the list to get more reviewing.

Thanks,
Zorro

> 

