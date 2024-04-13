Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4481758B
	for <fstests@vger.kernel.org>; Sat, 13 Apr 2024 19:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713036515; cv=none; b=hv2djgwvt98rzITpiK2F57CTil9W7i5A9DodqgDcTuLu0X2T3jNu56nSsQZbjdaXyDPz8SStpzz4CJT4zb5PYjNbG0g5M34brPrBaYVreP4gkptlt/ONHVBjLLouFokdPiVIe7yNRhORKAEKsD8liDRq7ZIAAN1LAyspLZ45hOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713036515; c=relaxed/simple;
	bh=KL8NGgHeebpfysfuhd7F4/H6AL0HzaZb5EJ/ouGQtQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oreSY8N50Z/hKI6SuyJZB+tzRFXYrYsE7aH+ecWLOdpyyaiS91MzSOL0wnRzkxEOXgqU5uKLMrrpXgSTB3p3k41v4rc6WOdxyZT7at04FajLnplOFr1XFdOwJOsCRTi0J/fR7lSJ1WtorxuBNDABhKR35NprkyVNCu9FoH8+hNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jw3lnTMK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jw3lnTMK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713036512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B3paimGL6X5/OSmufIOWalMtwb3NcgkWKKrsHZf7aNc=;
	b=Jw3lnTMKNhShHpQiaKDalhdy1+WCF6z0adm5+Q2llZy0zxwOszJPCfqaqLjCNNDarSDndB
	TwKZKV/Dh3e/OYbwVjlbhdfDzj2WrTCY1anjoN1rMANwwcQLCjWO0BAEeJUhO7zjMS0Wpo
	Up4GQ2BTz9EAg+aUJCbKoRzQDG1Rkfs=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-OeWPTusnOXelnxJcP-SmkQ-1; Sat, 13 Apr 2024 15:28:31 -0400
X-MC-Unique: OeWPTusnOXelnxJcP-SmkQ-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1e45e04bb40so20199065ad.2
        for <fstests@vger.kernel.org>; Sat, 13 Apr 2024 12:28:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713036510; x=1713641310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B3paimGL6X5/OSmufIOWalMtwb3NcgkWKKrsHZf7aNc=;
        b=XZyY9Tx7w1/bnC25PbBOqn4wR/jFN3+oHh6gKOcy/AdILrs5s8iY7IecRBkl/2sSnx
         T5hltlR/HGn5cvoucELPnxtuzMhqRMTqt0J4tLukssNqGfr4NbA4rsBFamzmYruliD82
         4NWavj45WmUNiHJC6nR3UVFsG2dEtlYh158TTlv4ceWiulniETBrSaOBqmCu5VG/lnk0
         0IElJZld4UzUe30cWWAYlH4n/aLdj9rA2iYx4fdIaL4mw1xzFpv42dD4XJ7mMrXvKh9Z
         eaKXylituC5Xi44v1xCFWUwj8SfY0Js3DBP16UyjGDU1q0kaloafIX10MW4M5Lh3w2jf
         XTgA==
X-Forwarded-Encrypted: i=1; AJvYcCXtXdqrVg0QoZq8VhYNultmk+IDI8sn/fFvKJ8SXuj/FGuXq8z3mH/Uj2f7P6FP9qUa+46tmEFqYOcvdQBqs6Fpmx8pFCtFwg==
X-Gm-Message-State: AOJu0Yys102fqtRL3GMga4PMCRU0arwmRlA9MBu8V8z4qiVF5sS0sy4F
	Sl0GjdOEPiHT7gc9DJlv49aRGGIiNK0yKE6ljX1w1nZqtcIbRQEsopvuZ0SY02Zk3/nAKLzpONR
	rLmwqUfaSot+LO0EjSamBs+wLah6FE9dOxUa7LlbU3tVQv+nL3CYRH94=
X-Received: by 2002:a17:902:b198:b0:1dd:6eba:c592 with SMTP id s24-20020a170902b19800b001dd6ebac592mr5076991plr.56.1713036509806;
        Sat, 13 Apr 2024 12:28:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZD1mvYL+ZaCezV9E4xa3AwuALHELyQjs7SuK5xTuYi42rEcjl0a2Fo7zI+Fgm5LwQ38arVQ==
X-Received: by 2002:a17:902:b198:b0:1dd:6eba:c592 with SMTP id s24-20020a170902b19800b001dd6ebac592mr5076976plr.56.1713036509284;
        Sat, 13 Apr 2024 12:28:29 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o16-20020a170902d4d000b001e00285b727sm4940879plg.294.2024.04.13.12.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 12:28:28 -0700 (PDT)
Date: Sun, 14 Apr 2024 03:28:24 +0800
From: Zorro Lang <zlang@redhat.com>
To: David Sterba <dsterba@suse.cz>
Cc: Anand Jain <anand.jain@oracle.com>, fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Subject: Re: [GIT PULL] fstests: btrfs changes for for-next v2024.04.03
Message-ID: <20240413192824.sz4ppx3rmdvcov6i@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240403072417.7034-1-anand.jain@oracle.com>
 <20240409142627.GE3492@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409142627.GE3492@twin.jikos.cz>

On Tue, Apr 09, 2024 at 04:26:27PM +0200, David Sterba wrote:
> On Wed, Apr 03, 2024 at 03:24:14PM +0800, Anand Jain wrote:
> > Zorro,
> > 
> > Please pull this branch, which includes cleanups for background processes
> > initiated by the testcase upon its exit.
> 
> What is the ETA for a pull request to be merged? Not just this one but
> in general for fstests. I don't see the patches in any of for-next or
> queued.

I think you might be confused by the subject of this PR, there's not v2024.04.03
version, and no plan for v2024.04.03.

Last fstests release is v2024.03.31, I generally make a new release in ~2 weeks
(1 week at least, 3 weeks rarely), and each release is nearly on Sunday. Due to
I have to give the new release a basic test and check the test results at the
weekend (I have my jobs on workdays), if nothing wrong, I'll push it on my Sunday
night. That's how I deal with fstests release, please feel free to tell me if you
have any concern :)

Thanks,
Zorro

> 

