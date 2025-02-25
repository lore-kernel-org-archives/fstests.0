Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB33D261599
	for <fstests@vger.kernel.org>; Tue, 25 Feb 2025 09:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740474014; cv=none; b=vFsH63rS2wRsVoBKiIs0XvTIbq+A6F7ZmeONWK6bnUbfWATYfqK3ZuH7MM4O9QFxl8tDiuf2zczKRdt5BTxntjdWz0HQ1DwIyaWoHcfWsvEv1jy8/AHNbGSX/X+dQ8IJVVSCs7ZISRmjDQ6Hp9xC9/4qGveFvLcOUsG3yy4O96s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740474014; c=relaxed/simple;
	bh=CJYl2KnOR5n0jq+kQWsIfKv+tF5qcOPga7xBI+hX74I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T2MglN+pRFZdPrn6tRTDZ8ECfUDRqyoUUNSmUa3VE98B4l/M5q0hfcnYxa13K5DoNmRhrP/hJaYxEkQVmAt+FHxmfCdCQ5NCR7Op4fp+IqyfMf1mvEUgrEEsrBa3UZgzoEug07R1D3Pg3pLGnqSKJXESc3YH+7lmMwXHZN2BI8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VfAcuA7B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VfAcuA7B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740474010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1VhJdzhRrmVwlrqL9UCjL020/1lx3rVwO5RnRNhbc1U=;
	b=VfAcuA7Bzb/jhRlzhJqld6gDWAMuPOpDEhlIynUROXmhbGYclnGQjnJNRkooRExk+gA1hn
	GtOvZfjMYcQbTpkz5Xg8Zk95bZmdIFSrHvfI40D0jqO7ncRhMqjmf+BduF/D+L5ZH+tERI
	iXKPFEdbPLttaTLeVfjaLms4wjsroB0=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-aA8UsjVjONuwJzl2wZXcYg-1; Tue, 25 Feb 2025 04:00:08 -0500
X-MC-Unique: aA8UsjVjONuwJzl2wZXcYg-1
X-Mimecast-MFC-AGG-ID: aA8UsjVjONuwJzl2wZXcYg_1740474008
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2fc43be27f8so18114442a91.1
        for <fstests@vger.kernel.org>; Tue, 25 Feb 2025 01:00:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740474007; x=1741078807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1VhJdzhRrmVwlrqL9UCjL020/1lx3rVwO5RnRNhbc1U=;
        b=q2AKBYMh2f/UrivBFBnvZ/FCqGTA+NXS6um1Sla+hhktBT+f4nvX8K8GKOGROV6I6l
         Bv3FBxkBcmPT1nI8RIFQgGYxEVUna1XYfcE3FRQ/mjNfEmczhZPAjU4b6kQgU7xuHpzv
         gYOYqJymTfrzQAjQ3UFRXm2ClbfK2Xix1ECJs8uUyxTL34rtIym8T9BLTPx6UGWji2LS
         xTTXCUNV+iseM1tR0J9XLX+Ym4MTHUlSnXJvcfhS5iIKvzculEeK9O4rDmuEbeKYmC8T
         SJ072O9Os4NOpestakl35qGbH/ra9V2daNza/pU9Yl2PT473h88cl022mNuodQf2/0XG
         6yLA==
X-Forwarded-Encrypted: i=1; AJvYcCWcv2foapKhA46nLs1J7yHH4ss2HkZvjF8E6yuQMO0IVlbFENWtIperhMn/rm9sqCDfFNly0PDB@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+/GYimjSMKlImBOAP3xVYBJD4km8LmelD5UVMBfK55atwZZoF
	LPSK6rlEAWdOC+XnU1B8YJHr1oRrg1sDUY3e0sDjPTq+CuBxPBTay6UCXzJDhWiA3UuyJDtS9SS
	OynO5eD25UmaD77iOx3WvCIZl3YdmYVSaP8nioxIogSUSSoOjXcvFchk2s5VLNBhARg==
X-Gm-Gg: ASbGncs2brSNEDR3RymD1F6Pk19dMx49QRjtjRyDQoSMEVjEUAaHIEYCQnjXkJ7wwz+
	kCyNOa2HVN7UjYcEC7VSi/FN3vfD7mUvSuQ3kLIwFi5ODNWrWLqaMH5CtGjZVlIfddzauKVSXjb
	NKmlxupxkPUjhmFuYaSmxeAfX2vokcTezN8Ja5epQsniUSmUozB1ghwGdt55xJsoDJQvpFt2EzD
	hjiDZHZAEkuUzAgwCE4qObBnpYV4q1jk0DAvpsIJVjvOfdgBQnVc8d0YBto+SobdMM1xzt+NRCD
	UstZaKcVHlR0F31KLJz1LAlNdp+yyahXd7AU5UPrlEdQsAgGa5qBhW7U
X-Received: by 2002:a17:90a:9203:b0:2fe:6942:3710 with SMTP id 98e67ed59e1d1-2fe694238e2mr3433724a91.3.1740474007614;
        Tue, 25 Feb 2025 01:00:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzKnmtzVjiqh0co9rne3AM6Z6i63RawHUkwKWaMWfvmVcpFZSTQQZ6SrEs9lfheMmd4PjViA==
X-Received: by 2002:a17:90a:9203:b0:2fe:6942:3710 with SMTP id 98e67ed59e1d1-2fe694238e2mr3433700a91.3.1740474007296;
        Tue, 25 Feb 2025 01:00:07 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe6a3da764sm1035323a91.16.2025.02.25.01.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:00:06 -0800 (PST)
Date: Tue, 25 Feb 2025 17:00:02 +0800
From: Zorro Lang <zlang@redhat.com>
To: Dave Chinner <david@fromorbit.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Subject: Re: [ANNOUNCE] fstests: for-next branch updated to v2025.02.23
Message-ID: <20250225090002.4y5o2op7cliikx6n@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <c238e76631b086db592f214beaa6fd94@kernel.org>
 <20250223193040.GA21799@frogsfrogsfrogs>
 <20250224054839.zne2pykkrm2nll5d@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <Z7zs6bqldp38_5Sn@dread.disaster.area>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7zs6bqldp38_5Sn@dread.disaster.area>

On Tue, Feb 25, 2025 at 09:04:25AM +1100, Dave Chinner wrote:
> On Mon, Feb 24, 2025 at 01:48:39PM +0800, Zorro Lang wrote:
> > On Sun, Feb 23, 2025 at 11:30:40AM -0800, Darrick J. Wong wrote:
> > > On Sun, Feb 23, 2025 at 08:27:43PM +0800, Zorro Lang wrote:
> > > > Hi all,
> > > > 
> > > > The for-next branch of the xfstests repository at:
> > > > 
> > > > 	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> > > > 
> > > > has just been updated and tagged as v2025.02.23 release.
> > > > 
> > > > Release Notes:
> > > > 1) There's not new test cases in this release, this's a release for bug fixes
> > > >    particularly.
> > > > 2) Reiserfs part is removed from fstests.
> > > > 3) ltp/growfiles is removed too, I think no one needs it.
> > > > 
> > > > I can't list all updates at here, more details please refer to below.
> > > > Thanks for all these contributions!
> > > 
> > > Thanks, Zorro.  I know the last few months have been rough. :/
> > 
> > Thank *you* help a lot, and always be patiented to take review points to
> > your patchset, finally we got these patches in :)
> > 
> > Next, I'm going to deal with your 10 PRs (73 patches), and another patchset
> > about the check-parallel ([PATCH 0/5]: CLI and feature improvements for
> > check-parallel). Will talk details with you after my testing.
> 
> No, please do not pull those check-parallel patches or waste time
> trying to apply/review them right now. I have rebased and updated
> versions locally that I'm getting ready to send out - this has been
> waiting on Darrick's namespace helper fixes to land so I can test
> things with those patches in place...

Thanks Dave, I knew Darrick is working on namespace helpers, I was on a travel
at that time, so we haven't gotten time to talk about the details, good to know
your plan :)

So now I'll try to check and merge the 10 PRs from Darrick at first, then the
namespace helpers maybe next. Feel free to let us know your review points and
plans.

Thanks,
Zorro

> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

