Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C6415B996
	for <fstests@vger.kernel.org>; Wed, 24 Apr 2024 14:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713968647; cv=none; b=CcP7xx/6gGf054KTd7qPcpw8KNHEj9ZDdcFwxAv/uQO7XcbonepuxwNOW7Fh21wSutNDS+AUF7fQC2Qx7MmmTa/kOexQTCidYPH/NOGzVip2/43UfJ/qMLeQabycJOkKFTzmgVhJpGXQPdUVDiET5d1qWm1atqcWCbyo4tsQlTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713968647; c=relaxed/simple;
	bh=0llEGKkwxSECjp38KpeBbaalQ6Ta/RRX1nxrXLOLFxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PiFm+UB2D0hahQf2djOHSihGdw+QubAQaYkaPn8I7TU94RwFTyCTvDLtWbRd/n6rNDjLU4ZcXMp+NV9AWhsIiYaMOHPFJTyXmMLs+LSshhTeGYjcPKmj+1HhyebWdFfAz9e3T+Xlylg5m7ZlQbFJLiLxX67soztNAj+2L2EqeVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZI9T/axJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZI9T/axJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713968644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CijgBuqpinbwWpr6/n739zJMWlXp4vcjh+ibzWbPTCM=;
	b=ZI9T/axJpt9VdQtI9LJu5FSdFi2mZdf8PGpaJcsv6GV7u5RiykFeOE0GceQ2y88QKFKNmT
	+RpVXt6+BC3yP8YMvSZm7SbDj5clIX1/X7ra4JBsWYt3IykCVyN5pd1A+k85+Y+dC0eJif
	rpC4Why8ASfo1kEfnC7ing4rFYeFOlI=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-w7QobiUuP8-PUuBwywLhEw-1; Wed, 24 Apr 2024 10:24:03 -0400
X-MC-Unique: w7QobiUuP8-PUuBwywLhEw-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1e438f8dd99so89199415ad.1
        for <fstests@vger.kernel.org>; Wed, 24 Apr 2024 07:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713968642; x=1714573442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CijgBuqpinbwWpr6/n739zJMWlXp4vcjh+ibzWbPTCM=;
        b=dW21UrEtSSk2tgvgJm/vUHojIuab5FrGo3AmI8GvZK5tsCuwQOPq3GeHBdJIEhiTLj
         NIxF5QBl3j+11BPa3528cmTOw1YWeRmDiYI/BAxaM+2JT5ZEBTKrhaFdxte9BKpjarJr
         c/LppM/Bjn5eA6xcLQVjJ25ajm1e4sPL1p8gMp/6ODb5P48VFxR6DVUQ7GCNdMnMerz6
         uV8jxSTJaj4XYjpe5HtTu9NpTyPxUIY0njTDA3YrnQioSOEZiJFMMHmFuRF+tKaVp8M/
         iF1YOc+lA92/jEv3spWcKFkDUp9t/MzIrWakoy9LgBg70c42sA/TJ2ZrlBlBlTbLaVZJ
         GE0A==
X-Forwarded-Encrypted: i=1; AJvYcCWW+fjK9EZ41TOFMVgXcwM9rbYDANcPnTEiWxogaeyydOxmN5jstep7khHy4ScMCcT1iGZHhOr8nDMycN8n8rdx5CSJC0hVtA==
X-Gm-Message-State: AOJu0YzzvWjxymAe86hjO/0OECAZgk/UZW0ojbSU5pK5iaQN8mxCbxWz
	jO3xFWx0iiungRXHAdD3KijO+tWAvaPqiH+b4Myx0u8Z7ZvMX5uWoBae8KvjHdjxEHbDn0l/Uo2
	s1Mi/qW/KQWLQxrPDB5GftS1/OvAVVHwCuBeulyNqXPn9rtRMweIQS+s=
X-Received: by 2002:a17:902:e74a:b0:1e4:b051:f870 with SMTP id p10-20020a170902e74a00b001e4b051f870mr3037058plf.24.1713968642265;
        Wed, 24 Apr 2024 07:24:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF55NYo7g3f1cSl6tm2v+1PKGR4pJQi+Qh1RbC8U0nDypc/bN+5yDX6o3jpF5duewXP+66xZw==
X-Received: by 2002:a17:902:e74a:b0:1e4:b051:f870 with SMTP id p10-20020a170902e74a00b001e4b051f870mr3037024plf.24.1713968641665;
        Wed, 24 Apr 2024 07:24:01 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id f15-20020a170902ce8f00b001dd0d0d26a4sm11945427plg.147.2024.04.24.07.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 07:24:01 -0700 (PDT)
Date: Wed, 24 Apr 2024 22:23:57 +0800
From: Zorro Lang <zlang@redhat.com>
To: David Sterba <dsterba@suse.cz>
Cc: Anand Jain <anand.jain@oracle.com>, zlang@kernel.org,
	fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [GIT PULL] fstests: btrfs changes staged-20240418
Message-ID: <20240424142357.gprsxpkufxbhxt4x@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240423220656.4994-1-anand.jain@oracle.com>
 <20240424091243.72n37q2xlwf5hxky@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20240424121436.GK3492@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424121436.GK3492@twin.jikos.cz>

On Wed, Apr 24, 2024 at 02:14:36PM +0200, David Sterba wrote:
> On Wed, Apr 24, 2024 at 05:12:43PM +0800, Zorro Lang wrote:
> > On Wed, Apr 24, 2024 at 06:06:43AM +0800, Anand Jain wrote:
> > > (I just realized that the previous attempt to send this PR failed. Resending it now.)
> > > 
> > > Zorro,
> > > 
> > > Several of the btrfs test cases were failing due to a change in the golden
> > > output. The commits here fix them. These patches are on top of the last PR
> > > branch staged-20240414.
> > 
> > Hi Anand,
> > 
> > I found lots of patches in this branch doesn't have RVB. That's not safe, if
> > we always do things like that. We need one single peer review at least, that
> > requirement is low enough I think.
> > 
> > Better to ping btrfs-list or fstests-list or particular reviewers to get
> > review, if some patches missed RVB.
> 
> Anand is maintainer within fstests and I guess he reviews the patches
> when putting them to the branch for merge. Filipe is mentioned as
> reviewer but please don't expect him to reivew each and every patch.

Hi David,

Sure, mostly I trust the pull request from Anand. But this time those patches are
from himself, can we say "I've reviewed the patches from myself"? Is that an
acceptable work process? In other words, should maintainers have the privilege
to merge his own patches without any other review? I'm a bit confused, if that's
acceptable by all of you, especially we just through the "xz backdoor".

> 
> I have a feeling that you're following process of merging patches that
> is maybe modeled after linux kernel, with the multiple branches and
> even merge window (mentioned in previsous PR), but this is IMO
> inadequate for a testsuite where we need quick fixups to test cases to
> be released in a much shorter turnaround.

I try to learn it, but won't follow it totally. Due to fstests is not linux
project, it's small and fast, we can accept quick fixes, but not without
control.

I'm not removing all the patches from his PR. I've merged those patches
which got reviewed. For those un-reviewed patches, I'll try to deal with
them in these 2 days, and try to help to catch the next release.

> 
> I was expecting that if there was a dedicated maintainer for a
> filesystem then things would go smoothly and we could skip formalities
> because the maintainer is expected to do reviews that count too.

Anand is already particular for btrfs part of fstests. But this time the
patches are from him. Anyway, I'll help to review his patches, and merge
them if no more other opinions from btrfs-list.

Thanks,
Zorro

> 

