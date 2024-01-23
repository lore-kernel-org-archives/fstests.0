Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF031552FB
	for <fstests@vger.kernel.org>; Tue, 23 Jan 2024 00:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969506; cv=none; b=bFHnYuTLt7V1e1c1DxM+K6rQaa0QyPhohuLp7zNPamru3s+6mbr2EvuL5dtSazg87sxdtdReRHlfOxtHerbljs6vxvpKqELF0OucUWW11HOIwY8kkJvplPPR4i65LVpEcFEKRjvB7OZrDwlVlO1/SOlgmKaNqmUVTcgRaFyThx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969506; c=relaxed/simple;
	bh=wOJRPKW1bxPGDvsOi3xOSuJuhXqKBU0W5/hrzM6VbL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+q5bn/U09mgfoBPjTLihKfGHe175owqwnQRNBxYBU0QWjvm2MlbW3HccjfE32cqDHBjKLrZM+wrvpKjjuDwOK4TyQq0tFvi0sbASVdSzSGJtqTG7iCBP61kmZL6v/ShgINHFRbmdL9hDij08MdNmKh6s6oynbao2kezT/9wWpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=iFx6H8LW; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="iFx6H8LW"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6dc6f47302bso613871b3a.1
        for <fstests@vger.kernel.org>; Mon, 22 Jan 2024 16:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1705969504; x=1706574304; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C/kC1JFf7JnG/o9WgIwbuo8UGqbWDeIxlO4YdBIy+6E=;
        b=iFx6H8LWVGE1jU61FTYaGODCcnGMugpwwvDFuOnnswHQg4t5LxwWRwoDOkXspm4LQb
         M5EAeD7KsBJKd0ThtNPQ0PyvUncgafFUMX2rkF8ztPeGclYW+nMRmVW0RV0RDVMh8scY
         laXHDo2+kgMfuJ2kG/pT4m6W0QcNUD5Z+QL08ooScNcjrm90ArpVJs72bkJVZdHTb+SA
         6jsL7mbcPgZ2ha5st3PImIDz8mbLUqV4zQY/9DMvLCA8M7/FoarqLEu2jwJfkx1veF18
         FfwAddX82whD++Q9vG76NFMq5A/5+G4MmClumGH3FPuqR+tKUOGKXnd3MKvAwcTBXquk
         LXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705969504; x=1706574304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/kC1JFf7JnG/o9WgIwbuo8UGqbWDeIxlO4YdBIy+6E=;
        b=UxQOkTRUgRNZrFt88xXASnD3Wjy1pDwBh7Nt+BjlCwWMERSt73VTLc7Vbve9FSQLaB
         JleMijpgm/1OTwNBOJjfaL91v4JFT6cEinKqd8hTGNVWwuXPzbtwsBWtJ/KdU5s1dk0T
         aY+DPyMhxFRdeEjMQz3aKLVKH0C1yQxZrMZG1gOFTPcUKAfaNRRNYoGV5+ixqzqj4Iyi
         6Gic7Rym9K5Nacjn4trydH/8gOpitbKhgscvY+qjrZT11pDXYI+4q6Q4zyVQgYTRHfY0
         2ZiQ71NsLcZkruksc4epvqj3kLbL0xnoUILGabeB7AHxx4Zh3J4XYsoZ3ZfSJD4BNBXk
         XjdQ==
X-Gm-Message-State: AOJu0YxJ6qw+eMsm+PbuDromnL86cB41HFHi9rjHMfw3j/+UAlaMZ1o5
	4j1A24q+hXe60gDerwH1mewpF56iVKal/6KjaH8iNpSEmpYLJf7db4pBjFrSsgE=
X-Google-Smtp-Source: AGHT+IFF0J54Pvm/xN0b8DoJCIS3cRp0lsMiqhICOZ1TrW8ZJUoe6BS9T9ByVMyd3tU8PXap3GS/TQ==
X-Received: by 2002:a05:6a00:cca:b0:6db:dd0e:8d6c with SMTP id b10-20020a056a000cca00b006dbdd0e8d6cmr3985474pfv.50.1705969504525;
        Mon, 22 Jan 2024 16:25:04 -0800 (PST)
Received: from dread.disaster.area (pa49-181-38-249.pa.nsw.optusnet.com.au. [49.181.38.249])
        by smtp.gmail.com with ESMTPSA id s10-20020a63dc0a000000b005cddfe17c0csm8831296pgg.92.2024.01.22.16.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:25:04 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rS4b6-00DzOD-1P;
	Tue, 23 Jan 2024 11:25:00 +1100
Date: Tue, 23 Jan 2024 11:25:00 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: zlang@redhat.com, fstests@vger.kernel.org, p.raghav@samsung.com,
	djwong@kernel.org, mcgrof@kernel.org, gost.dev@samsung.com,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 0/2] fstest changes for LBS
Message-ID: <Za8HXDfoIK+lyMvR@dread.disaster.area>
References: <20240122111751.449762-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122111751.449762-1-kernel@pankajraghav.com>

On Mon, Jan 22, 2024 at 12:17:49PM +0100, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> Some tests need to be adapted to for LBS[1] based on the filesystem
> blocksize. These are generic changes where it uses the filesystem
> blocksize instead of assuming it.
> 
> There are some more generic test cases that are failing due to logdev
> size requirement that changes with filesystem blocksize. I will address
> them in a separate series.
> 
> [1] https://lore.kernel.org/lkml/20230915183848.1018717-1-kernel@pankajraghav.com/
> 
> Pankaj Raghav (2):
>   xfs/558: scale blk IO size based on the filesystem blksz
>   xfs/161: adapt the test case for LBS filesystem

Do either of these fail and require fixing for a 64k page size
system running 64kB block size?

i.e. are these actual 64kB block size issues, or just issues with
the LBS patchset?

-Dave.
-- 
Dave Chinner
david@fromorbit.com
