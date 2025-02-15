Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7661369B6
	for <fstests@vger.kernel.org>; Sat, 15 Feb 2025 13:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739626459; cv=none; b=PVsupEhYPNDo/lQ6pgLE8FYjH6XaT7qDj8kLU5DjC0sMU06qmlS/5u/qgM10TYXSesyODaKogVzPxUHcT90x2OuotWqFdzFY8x3AtSAO9X7nc+NfMPPBp6tYO3e7PA394/0+QSlTMnUVOOPArf6YgripvvOWkFZhNRLQu2EEn8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739626459; c=relaxed/simple;
	bh=WtC2GbwCedtZMmXg8Qensd9f1ydLSOsf1VkDH7vDKok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ff2QRBeHjpqtj8T7umst3CNtmr252Kv5iIjmWXqk35oks4XerUkN6IeNWx7RzSwkyA3SZv5znyJFQGMU/X0ljViQ+V6znilmW1U4XsOEyVY69UrQ83L/H+STbuytq73KfgbMyJ7rMspD4Oj3/o7Y47JtTE5NmWsKK0yE0fMjo14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z4DmlQIU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z4DmlQIU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739626456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lZEes/IKM6B0YDSI3Q43LqBo5+9X0FnqE4vfn12Pd5w=;
	b=Z4DmlQIUsrQecWCgWJA4XIzH7h5BVEV62OVIA5jSOnf+B6pp5Zgzxsbq0I4y33FQNEeFrE
	5x/M35VOssoS+ZwaApMi+LYCpYyM0ZsCJm4PuFLvA/yzMekX0wm7cXps8zCIp8WipyWk+K
	Wuv87QsrF6UiGfdmuqHtZ6mOeh2Tbg8=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-9nrcQnV2PlmxaY8_5zbMwQ-1; Sat, 15 Feb 2025 08:34:15 -0500
X-MC-Unique: 9nrcQnV2PlmxaY8_5zbMwQ-1
X-Mimecast-MFC-AGG-ID: 9nrcQnV2PlmxaY8_5zbMwQ_1739626455
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-220e62c4fc2so37168555ad.3
        for <fstests@vger.kernel.org>; Sat, 15 Feb 2025 05:34:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739626454; x=1740231254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lZEes/IKM6B0YDSI3Q43LqBo5+9X0FnqE4vfn12Pd5w=;
        b=ABe3p5lYY1PRqzKMJV2OIvLeabCMjVUPLDKjQ1+pykQdeJzIziZVmcsAtmfByeTOcF
         a+WqWQ62MB2oWXMVhLzt0QEHK1Uj0tRyxvT5HPXUTDv52H4a1KdZ9GvTXOX4GP5mGr8e
         eQoEODJQc1RgkJ5/ZJsP8axT6ADysYjJbLlhDa7qgqRLH9uFxVYd7bSzceZD3x8x2TFG
         QsfVSh/NlHNM08VXLF4ibZoPLB3DRnsad/8UrzWTs6JtAuEdKllAnq4BcTaqZpyV0qh8
         xmphWB2TFvVAg9PNiOwaW7ygCkYD4POaw+eU3cGhtlm/kmbxf8PFaKjkdWb1rYdGEphK
         /b9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXOYZxFTdW972waSFeGklGjMMek22EkogHcsplLj0NvMnTZooTMiYyE7ZuuKTFaCpLN5yf9xW45@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+tWtU0IQK0NAtRmSl2knJ4qPTmsSB42jTMknW34lQTo/gGBAz
	MvxYNDbbCHpHhUw7iCIr4XuyVnBAShcZcm2nbp73JDJAp7jwVyq/VxA4MIfP8A6AdP6dc/2jspW
	hbeiuECcvHKbvF/kmpv5X/1kH2EtpvtWgWmQxbcX/6JqSC/gnw8R6zQEs8Jlx5BQicg==
X-Gm-Gg: ASbGncvvRPb9UvDrzCYDjTxMM4WICXgtNgjl11BtMslrgzCigAfaAVwR2c2Ig6HDxXK
	kqeoXRtLitN3C3sD4aJP8fiI3+OjiPSollP/T5hhBryT6UsmGpIcF8pNtX+5GB1Uqy+krdiXq1S
	AH5bVX+XV+O5hCBQwra/xRfp8Zu1511jE0ibGELjkItlxq5Jl7AKUybUIsENRBdCq4TdLbxFID5
	jwTI4hpTqIKQ6a4cWUKcFCefLHIC5w/oNuGnhegeM8aUfoQJd4G8eCNe1XBxwydvPpzquFpp8oP
	oE8HGHSDJOZGYHNoJ2sbRInGrPiVsBEq4CMlg3NSWTiMWw==
X-Received: by 2002:a17:902:ea11:b0:220:f4db:98b4 with SMTP id d9443c01a7336-22104012399mr57018355ad.24.1739626454425;
        Sat, 15 Feb 2025 05:34:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF53R4PjmNymCIcqascu/2DIBwNl5r118ctAFHiMJfKw83XgYcYgnIFoqfw7YCtS3haP+0/iw==
X-Received: by 2002:a17:902:ea11:b0:220:f4db:98b4 with SMTP id d9443c01a7336-22104012399mr57017975ad.24.1739626454061;
        Sat, 15 Feb 2025 05:34:14 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5349556sm43703045ad.19.2025.02.15.05.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 05:34:13 -0800 (PST)
Date: Sat, 15 Feb 2025 21:34:10 +0800
From: Zorro Lang <zlang@redhat.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: "Darrick J. Wong" <djwong@kernel.org>, dchinner@redhat.com,
	fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 14/34] common: fix pkill by running test program in a
 separate session
Message-ID: <20250215133410.wczc7vvmuahlqfpy@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <173933094308.1758477.194807226568567866.stgit@frogsfrogsfrogs>
 <173933094569.1758477.13105816499921786298.stgit@frogsfrogsfrogs>
 <20250214173406.pf6j5pbb3ccoypui@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20250214175644.GN3028674@frogsfrogsfrogs>
 <20250214205031.GA509210@mit.edu>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214205031.GA509210@mit.edu>

On Fri, Feb 14, 2025 at 03:50:31PM -0500, Theodore Ts'o wrote:
> On Fri, Feb 14, 2025 at 09:56:44AM -0800, Darrick J. Wong wrote:
> > > The tools/ directory never be installed into /var/lib/xfstests. If someone runs
> > > xfstests after `make install`, all tests will be failed due to:
> > > 
> > >   Failed to find executable ./tools/run_setsid: No such file or directory
> > 
> > Urrrk, yeah, I didn't realize that tools/ doesn't have a Makefile,
> > therefore nothing from there get installed.  Three options:
> > 
> > 1) Add a tools/Makefile and an install target
> > 2) Update the top level Makefile's install target to install the two
> >    scripts
> > 3) Move tools/run_* to the top level and (2)
> 
> Looking at tools, it seems like there are a couple of different
> categories of scripts in the directory.  Some are useful to people who
> are developing fstests (mkgroupfile, nextid, mvtest); some are useful
> when debugging a test failure (dm-logwrite-replay); some are useful
> only to xfs developers (ag-wipe, db-walk).
> 
> And to this we are adding utility programs that would be used during a
> test execution.
> 
> I wonder if we should split out these scripts into different
> directories?

Hi Ted,

Thanks for taking care of this issue. Yes, I talked with Darrick about
that. I provided 3 methods:
1) Change xfstests/Makefile only.
2) Add Makefile to tools/ to install the scripts we need.
3) Create another directory (e.g. scripts) to save the scripts for testing,
   and give it Makefile.

After talking, we chose the 2nd one, something likes:

  TOPDIR = ..
  include $(TOPDIR)/include/builddefs

  TOOLS_DIR = tools
  TARGETS = run_setsid run_privatens

  include $(BUILDRULES)

  default: $(TARGETS)

  install: default
         $(INSTALL) -m 755 -d $(PKG_LIB_DIR)/$(TOOLS_DIR)
         $(INSTALL) -m 755 $(TARGETS) $(PKG_LIB_DIR)/$(TOOLS_DIR)

  install-dev install-lib:

The 3rd one is good to me too, as tools/ directory isn't used for
test running from beginning. I think we can let the patches of
Darrick be merged at first. Then I can send another patch to talk
about the "separated directory" way :)

Thanks,
Zorro

> 
> 	  	       	      	    	- Ted
> 				
> 

