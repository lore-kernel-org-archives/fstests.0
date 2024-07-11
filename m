Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8386D15F40D
	for <fstests@vger.kernel.org>; Thu, 11 Jul 2024 13:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720703809; cv=none; b=d50lqtEVTbqzWAtL1YwZCyC+QWv4midsLESA25/NJwuqt/6KsfZ8PRKf5ybFZEvwATUNuRW/1URT9OZdQGFAquuy0c+RgSGpD3ILEVj0G+S8qMBkQ3+rMtwyo+7MXXIon5FdEtpGrPuUhErCqHTXmiYPnmndwrwb5AICssJk4EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720703809; c=relaxed/simple;
	bh=Lhhf9Cwiy2b16rpSQ5wrUHf4nIRSvGGMWJMnncpSSrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qH28016Hzmu0ei03I+ot+qy+/xWkPj5NZ3KgeeQjKBK2d3z75hmPYIshgkoRG2OXdUsLdtlyOFHoPU/QqY94whnRMOruWPeOxAqpVzehbBENackRvJuzfNBoF0ZocJdQk7Zc7ggiENrrcuGKMTP7/PxN5wbaqmFVovl9zPMxA78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YbHHyF/7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YbHHyF/7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720703806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kICuC6UephpQnZRREowkwCRWc4L9gWonI74CmTG3w9I=;
	b=YbHHyF/7OU4FJjBf1So0+p6VpiDirjDIdWEvvPe7y8VurWwaSbDLDT57ZOBY22F9IozVTs
	CXk21/IhvJYXF+HwA+CQNJZGMX980+zf07PVOY3Ss7l8PUSwdvYE7dxDvGpsT3uPKfQlAz
	9pKHfjFbtPTckZ4HxL2/IlMiR239TKE=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-38TmkCgHMxSXSP6A4pmggw-1; Thu, 11 Jul 2024 09:16:45 -0400
X-MC-Unique: 38TmkCgHMxSXSP6A4pmggw-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1fb298a75ccso5913865ad.2
        for <fstests@vger.kernel.org>; Thu, 11 Jul 2024 06:16:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720703804; x=1721308604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kICuC6UephpQnZRREowkwCRWc4L9gWonI74CmTG3w9I=;
        b=pRpGY1/thi+ml0+AMVtyhmPgSz8e/998BKdg1Ai8VSNaLA5bM7eFFWkOP4E88OawT1
         JnfrvAeAnSXYe+c0HxNN5AWi/LNZvYnPVXI2IBV5rJ9om67XeCAzrzHWsh8XMtpPuUdo
         eFXpef6KkFoaLAo2amRXIFz/F7Ozfj5do68bFhYFutzuH9XCJiXRAHfJboinrG8vrHQ2
         GIGkV6SYr2wlJLvJWz7zlakbK1FXjRZkBKrgEMGbmvdUpX5lQXwSmPdxlMuhDP7Cp4/P
         Pbedz0I8z5RYjd1eHUOuWMwoYS+h650YfzaN4kFor8cNPIN9QuWPTsr3gdEJdoyPLAdn
         O8gg==
X-Forwarded-Encrypted: i=1; AJvYcCWYeT760l4Wo0xMaN2N9gf/EJFEkijfmIcnbVyp05Us7Zfd5DW18YUd+R+ZyukTTmihC/8ecbJQmg0LsvIJOFoIMb5fMF1iDw==
X-Gm-Message-State: AOJu0YwemB4oYp1SY6SJVif4F4S01zodjLtFl9fJgdMAIAQuDFW4MYr3
	fQqNGWGXDsqj/zQKMkEdSw6Qdfsa+qtiD3kvaO7vV9PwfTooJaA2cqp6JtFVHj+jsEnMZrnDPsu
	4bAkEiIMYWH8Mq6KbdJ3Zjvtnyg38NBzxCiOlPLzqhY7akxhJ60ZFIDA=
X-Received: by 2002:a17:902:f691:b0:1fb:1fd6:5e57 with SMTP id d9443c01a7336-1fbb6ce5033mr71489025ad.6.1720703804121;
        Thu, 11 Jul 2024 06:16:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpMdyl18akj0+VA/oWLOWvxIOV4BCdIiIrIdhAbZbD0WDL02CPyOVIzjebhy6Xb4Noj7ANmg==
X-Received: by 2002:a17:902:f691:b0:1fb:1fd6:5e57 with SMTP id d9443c01a7336-1fbb6ce5033mr71488855ad.6.1720703803685;
        Thu, 11 Jul 2024 06:16:43 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ac08dfsm50086345ad.213.2024.07.11.06.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 06:16:43 -0700 (PDT)
Date: Thu, 11 Jul 2024 21:16:39 +0800
From: Zorro Lang <zlang@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: mostly remove _supported_fs
Message-ID: <20240711131639.fmy4sjptoizsfuck@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240623121103.974270-1-hch@lst.de>
 <20240710061603.GA25790@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710061603.GA25790@lst.de>

On Wed, Jul 10, 2024 at 08:16:03AM +0200, Christoph Hellwig wrote:
> Hi Zorro,
> 
> is there anything that blocks this series?

Hi Christoph,

Nothing blocks this series. I'm testing it locally, if nothing wrong, I'll
push it in next release :) And I saw you talked with Ted and Darrick in
this series about g/740, so double check if there's something you want to
change.

Thanks,
Zorro

> 

