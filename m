Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326742D7D3A
	for <fstests@vger.kernel.org>; Wed, 25 Feb 2026 05:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771996718; cv=none; b=buDsNFXMt8M/eOGYhM1YxAiu6cvUrl21mRMKbsnZiXcnRPpB2+66FiDoTMUeKCWh6UfZfQEeUnHqvmBNp0G+AxI4ycPuDHrz+N46mdOOYsJF2+OKlTmRF04yVjj1RU29kYykBdpAaacpXc2DVx7IKf6ndDgQBL07SrFI6+eEa6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771996718; c=relaxed/simple;
	bh=C/wN3yfQ9G9UkppJlbjel0p2ELNuDRdLtDCjB5j1cuU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=QbU5b73s4C7hcpE/fq1eaAAwH519bc5BXordbDRH7gxnbTwhUe0PAl1IuL0J41nEfuzOXDGhM7I9yA6jJRsbblOBVbWWnp4WXtmn7O8faHyz7UfBG6iiLLizAckFyJd9h7Wk8nM/q60FIH0z7UNiHU97rU4zJcZy+6NfPO7qaMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iMVzZP9/; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMVzZP9/"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2adae92249eso11672375ad.0
        for <fstests@vger.kernel.org>; Tue, 24 Feb 2026 21:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771996716; x=1772601516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AlEL/5agn86aOLJOKSSL+66MwmfqUNVuVfSZ6HRleS0=;
        b=iMVzZP9/Qiquj6w3jfj+I3hplVbyExN0DRXR3+V4pfLV8OLdkxnIMPalPeHZdtg2GG
         Wdy2oSU3yy2Lpp95iDm/61rFMY2X4z1d7LFBS2s5KHu+2KYzFPnvpALPZPsWwYu5ah5s
         27F7HzckNJP+gjOTUc4hcL9KO88XpZCJWpDL9EGx0q/JR2Heo5RKWOr1ut4q1SAme459
         BvlsyJHEHlXYioGiYgEq3XizqeZ9W81UXcENCYHDNvj5zX9ocXUnTHCEmlc4HQru4z5j
         3//Hlo6/BIQxRfiSeYfRbamIxTRCOulPiFpUQUATRXYaDCFIICGGP18ggD8Kqo/hpxdQ
         GzcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771996716; x=1772601516;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AlEL/5agn86aOLJOKSSL+66MwmfqUNVuVfSZ6HRleS0=;
        b=s4dVbRCHmKX6jq97SCpdREW61SLUsE7w1QuCor/ufEBHmU1l7lzNIZXNb/IlStyR2z
         xHerU6o9T3/F2UnUdjwp0GQer0eECYmBEWtuV2nm4CP5IVQVhM9051Q4W07Z6xZR33Ig
         rvjAQc29BEonFXjojmMkcL3tECbuHoJgEu9JIQo4TomKhJY3tiWF6vP1A4ynuGG/qRC5
         fy7k+IJCddW1yjCPgx0dYkXSz8li874G3GXfiLRKdWQcgpPhgwstGLSYPneqMA9Z0YZK
         9xppmZk95HhfouhEJZluxIgAljBeuPSVmwd5vw4zwmdJevg2oNbquk61s/SWuDB3E+1S
         tXXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPmVjjm82gkO2d9I0a8kixD0WUGw7dRlKiStMDOSAO/dfTqCaZUAkH/EJhxbmv3py1aZTgCmhI@vger.kernel.org
X-Gm-Message-State: AOJu0YzUrdX+OIVe86QI+HiwEzzgZRuIr52BF/LAtFFT4saVxy1laAmQ
	lKsAYvvxxFTdmu2e9KH8uD9gWu8aQUfap68x2bBC0x4Wm2L115Zhg19h
X-Gm-Gg: ATEYQzzSsDO9P1PyFFi6z2IJmNDWJMZXbXfH3zuOLunS0C4ITkuVSmCbcuXi8T/y0dk
	wPAna/AxeAEWXRw3J7MwQuwtFsUqvGdFz9SxtEZjo1434y7Oc1x0XmUgLQ7nCqsYuuk20+bvwsD
	H++EgUPtB1twRpcDbarAZAr7mbVpOKIne98I3eBzp8QkFUEe6OuDUyRj1Mtt19SMF4KTrjH7mgq
	Du+Npdo2QV8UADRdFERy6P+2QeZFz8yujc/R+Z4hH5alMzdmazFtg0aeZCHJVCTfcs0rdnLjswp
	Mbku2UPfyRDLDVveWXxouYRet+7t3ZCGjOCSwmdJrL5BskoNGOJUaSXTZ2yIBsslQiGz6KqFO92
	fOCu7pifDwpO3EAt0TL3B1W0xpMoGdFzckDyv8tKQOlubF/8FXvenQv7uPndPNm0bq19CAvZLyo
	pZk0sTNyhQZs6JI5qirJ73SlQ8dxb9k8GxK1Zjat0H105u3OGodb8sdVJfdFCX66fB0KrjOZgGl
	74=
X-Received: by 2002:a17:902:f60f:b0:2ab:3cba:42fa with SMTP id d9443c01a7336-2ad7453257bmr148390895ad.46.1771996716506;
        Tue, 24 Feb 2026 21:18:36 -0800 (PST)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com ([49.207.233.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad7500e1c0sm130118045ad.45.2026.02.24.21.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 21:18:36 -0800 (PST)
Message-ID: <dba862052a60544058d6e7e9cadd52e6870eb11b.camel@gmail.com>
Subject: Re: [RFC v1 2/4] xfs: Introduce xfs_rtginodes_ensure_all()
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: djwong@kernel.org, cem@kernel.org, david@fromorbit.com, 
	linux-xfs@vger.kernel.org, fstests@vger.kernel.org, ritesh.list@gmail.com, 
	ojaswin@linux.ibm.com, hsiangkao@linux.alibaba.com
Date: Wed, 25 Feb 2026 10:48:31 +0530
In-Reply-To: <aZaqZSUKUJDpuVQK@infradead.org>
References: <cover.1771418537.git.nirjhar.roy.lists@gmail.com>
	 <38947e4ca2d01828e7e7033f115770efe6ac9651.1771418537.git.nirjhar.roy.lists@gmail.com>
	 <aZaqZSUKUJDpuVQK@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

On Wed, 2026-02-18 at 22:15 -0800, Christoph Hellwig wrote:
> > +int
> > +xfs_rtginodes_ensure_all(struct xfs_rtgroup *rtg)
> 
> Please use the usual XFS function definition style.

Will fix this.
> 
> > +{
> > +	int	i = 0;
> 
> The for loop already does this.
> 
> > +	int	error = 0;
> > +
> > +	ASSERT(rtg);
> 
> The assert isn't needed.
> 
> > +
> > +	for (i = 0; i < XFS_RTGI_MAX; i++) {
> > +		error = xfs_rtginode_ensure(rtg, i);
> > +		if (error)
> > +			break;
> > +	}
> > +	return error;
> 
> Just return the error directly from the loop and 0 if you make it
> through, then there is no need for the error initialization at the
> top either.
+1 for all of the above.
--NR

