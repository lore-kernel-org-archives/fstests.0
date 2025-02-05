Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F64179F5
	for <fstests@vger.kernel.org>; Wed,  5 Feb 2025 00:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738715934; cv=none; b=LuWSLtPHJeSaeIJhxUnYjvg/1icn+XQ8pU1czYP7G78uzE45JdNpn6j+E1e21gqiiT1cntI9cn3s3dOqGAXX9yU7Mx07qkd9nBxJrGsJNTFfwNCfOpjAS/vZlPS30tiDSW/o1X4HrHHpDLFOA81VdqXi9iSdtk6avCkyWNDR/gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738715934; c=relaxed/simple;
	bh=mW1OD3BuFbfIzWNrxO9fgwpxwuJ0Qix9fvFQvNwRe6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OzJi/CYx0/BEtvi4Q/inG2YvNzFDVVNi+8w6ZKT5EcrPPNVRgxgal+/osf/2oYAwPCC9gfUqcxWuH1QUehqoJTzxzuOb4wRSx9VWfiZD8CfCmHp8t+HKW4ldrZvzsXfFbrywkWw0pm+v7bUngYJzy1/b9n8mXva1Vu2rrCD5Omo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=wLMB+bQg; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="wLMB+bQg"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21661be2c2dso105959635ad.1
        for <fstests@vger.kernel.org>; Tue, 04 Feb 2025 16:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1738715932; x=1739320732; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+4F9TLvTLaZFeW21EJEf8M0qCFDAqC+SVSOJf0YLK5Y=;
        b=wLMB+bQg5fLRLqgBq66sN/C1dBdn9UPI0MBLqo9mH/wNWU5bWvKO/vDmT0+DSrQwk+
         OVWXE+LuvE2ASPnMtVk4fTXhCiphnsiZexDfg1JTD/+8gJfAOlNttqCV0jLow1uAOy5T
         xAR3jF8X5E5fEYL3TqxyDPrHT1BY/g7ap7/2SDPjtS9biBzEqnwpdo9h1xqF+o4Rtldn
         rqmNfqrGAJ3ERpsKa5qQQVQGcPoMKOXCC6c6VK1zGH4A+Lw6sT2LYmjvbP3jQPWMSqUm
         UTFyopgQiaslFSlh2NnyfR8zWeNvHCdAFqbBfXbwVBGhL+o7G6XohAnIAPk0XAAZUI8D
         3zDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738715932; x=1739320732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+4F9TLvTLaZFeW21EJEf8M0qCFDAqC+SVSOJf0YLK5Y=;
        b=WtanyGr4QcZqGP9xascOsfexXdiaJFULwPNLqFgerWiGuVLzDymBtozLRsjZp/EAW/
         JmCeTbCVRLBsrptqnbz6nLSRENttyPPlezyPAXXaax4DzWdbfSusOtQg4Cu07PuIuFCN
         ItTsVpq07uhNc4Py5z+f9Lb6aNPMhcDz3XUFqt8G3gBrIPQ6dzes8/Wn9hOzV7NgVR59
         g8u+XntTRZsp/rPNk7Zzd3Kp+AR14QH0o/eH/QqTsdhKLlIUJ62/BGQvoXZBPz9j5RS7
         qCLcxwxRjsbywWrs3dEzxphRpGS0HOkR/E3u+A1iSZ+BZe0PZCSrHLeWpluArdyf86pt
         2+og==
X-Forwarded-Encrypted: i=1; AJvYcCUpqx3zGdhJdvpHQusKpZ0bfiPx33mladwUgrLv4XtKPvDg9CcU/emz+GdkXTz6QRpmO11ApKya@vger.kernel.org
X-Gm-Message-State: AOJu0YztTSMDVPoETafZV7EEop5UHboUdSDIB3lQ45q9DQCxFjZot5K0
	9ZBscBe+QIld3CuEznenaR2/XhflU5XpuI126RkjqFcTQzrokRBOMdo9NiJYVpE=
X-Gm-Gg: ASbGncunxxQAgkj73fSXXf5zSpzgRpjvpcXJaNBue9CYYi8GdK444EUizUl9SC99Lnz
	XuoowxaaFCGY8Fz1CAeK9TUJDUcrOq4LW5m77bSHZ0Qah2JqlR6l/xVNi7QZ/JbC3saVRF/qNQd
	Roq2DK/vi6n16eUTECy9EhPJ4F3NLhmkDBZWaR3iOovbc6Yzoe3jdvOiKhqF3qN/bCkLwpzI34W
	ARAhPHtvc5QowZhFU9PEeDoCIyF6jrD0vipSJ/fkgNEFeY3hU0iC/wAMeQp6gOUI4O2uvpqXmt6
	gi7ifHkwp196NquuxBPdwrwZm/Nw699UKu6whtpYijUUTir6rgGMLC6w
X-Google-Smtp-Source: AGHT+IHqBuV1yiof0Qw+2Mx0DplF/UOOh+y91m5TlM/1KNSCv/EMYl80hHEn5T7tU2SMJp/AP8ESXA==
X-Received: by 2002:a17:903:292:b0:21f:a00:dcdb with SMTP id d9443c01a7336-21f17edbd55mr16040375ad.44.1738715932393;
        Tue, 04 Feb 2025 16:38:52 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21ee2bae0a5sm75584955ad.19.2025.02.04.16.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 16:38:51 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tfTRJ-0000000EjK2-3b10;
	Wed, 05 Feb 2025 11:38:49 +1100
Date: Wed, 5 Feb 2025 11:38:49 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 16/34] check: deprecate using process sessions to isolate
 test instances
Message-ID: <Z6KzGaewZBcAXOZ_@dread.disaster.area>
References: <173870406063.546134.14070590745847431026.stgit@frogsfrogsfrogs>
 <173870406352.546134.8739392016656606912.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173870406352.546134.8739392016656606912.stgit@frogsfrogsfrogs>

On Tue, Feb 04, 2025 at 01:26:29PM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> As I've noted elsewhere, the use of process session ids to "isolate"
> test instances from killing each other is kind of hacky and creates
> other weird side effects.  I'd rather everyone use the new code that
> runs everything in proper isolation with private pid and mount
> namespaces, but I don't know how many people this would break were it a
> hard dependency.
> 
> Deprecate the process session handling immediately with a warning that
> we're going to rip it out in a year.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>

Ok, that answers some of the questions I raised - the session-id
support is time limited and makes people very aware of it.

Reviewed-by: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
david@fromorbit.com
